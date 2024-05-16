-- |MELEE & RANGED WEAPONS| --

function CheckPlayerOnFirePowers( triggerArgs )
	local firedWeaponName = triggerArgs.name
	
	for i, functionArgs in pairs( GetHeroTraitValues("SetupFunction")) do
		if functionArgs.Name == "PlayerWorldSlowSetup" then
			local penaltyDuration = functionArgs.Args.AttackPenaltyDuration or functionArgs.Args.ActionPenaltyDuration
			SetThreadWait( "PlayerWorldSlow", penaltyDuration )	
			if SessionState.PlayerWorldSlow then
				SessionState.PlayerWorldSlow = false
				GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = functionArgs.Args.TimeSlow, Reverse = true, Name = "PlayerWorldSlow" })
			end
		end
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
	for i, data in pairs(GetHeroTraitValues("OverrideWeaponFireNames")) do
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

function CheckOnHitPowers( victim, attacker, args )
	args = args or {}
	if victim == attacker or victim == nil or victim.OnHitWeapons == nil or ( victim.Health and args.DamageAmount and (victim.Health - args.DamageAmount) <= 0 and not HasLastStand( victim )) then
		return
	end

	local attackerId = nil
	if attacker ~= nil then
		attackerId = attacker.ObjectId
	end

	if args.SourceWeapon and WeaponData[args.SourceWeapon] and WeaponData[args.SourceWeapon].IgnoreOnHitEffects then
		return
	end
	if args.EffectName and EffectData[args.EffectName] and EffectData[args.EffectName].IgnoreOnHitEffects then
		return
	end

	if attackerId == nil or attacker.TriggersOnHitEffects then
		for onHitWeaponName, onHitWeaponData in pairs( victim.OnHitWeapons ) do
			if type(onHitWeaponData) == "table" then
				if (not args.Automatic or (not onHitWeaponData.IgnoreAutomatic and args.Automatic))
					and (not args.IsInvulnerable or (onHitWeaponData.AllowInvulnerable and args.IsInvulnerable )) then
					if onHitWeaponData.FunctionName then
						if _G[onHitWeaponData.FunctionName] then
							_G[onHitWeaponData.FunctionName]( attacker, args )
						end
					else
						FireWeaponFromUnit({ Weapon = onHitWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
					end
				end
			elseif not args.IsInvulnerable then
				FireWeaponFromUnit({ Weapon = onHitWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
			end
		end
	end
end

function CheckOnDamagedPowers( victim, attacker, args )
	local isCrit = args.IsCrit
	local weaponName = args.SourceWeapon
	local currentRun = CurrentRun
	local isWallSlam = args.WeaponName == "BaseCollision"

	if isWallSlam then
		for i, traitData in pairs( GetHeroTraitValues("OnEnemySlamProjectile")) do
			if not traitData.Cooldown or CheckCooldown( victim.ObjectId.."Slam", traitData.Cooldown) then
				CreateProjectileFromUnit({ Name = traitData.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = traitData.DamageMultiplier })
				if args.Angle and traitData.Force then
					ApplyForce({ Id = victim.ObjectId, Speed = traitData.Force, Angle = math.deg(args.Angle) })
				end
			end
		end
	end

	if victim ~= nil and ( victim.Health ~= nil and args.DamageAmount ~= nil and (( victim.HealthBuffer and victim.HealthBuffer > 0) or (victim.Health - args.DamageAmount) > 0 or HasLastStand( victim ))) then
		if attackerId == nil or attacker.TriggersOnDamageEffects then
			if victim.OnDamagedWeapons ~= nil then
				for onDamagedWeaponName, onDamagedWeaponData in pairs( victim.OnDamagedWeapons ) do
					if type(onDamagedWeaponData) == "table" then
						if (not args.Automatic or (not onDamagedWeaponData.IgnoreAutomatic and args.Automatic))
							and (not args.IsInvulnerable or (onDamagedWeaponData.AllowInvulnerable and args.IsInvulnerable )) then
							if onDamagedWeaponData.Requirements == nil or IsGameStateEligible(CurrentRun, onDamagedWeaponData, onDamagedWeaponData.Requirements) then
								FireWeaponFromUnit({ Weapon = onDamagedWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
							end
						end
					elseif not args.IsInvulnerable then
						FireWeaponFromUnit({ Weapon = onDamagedWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
					end
				end
			end
			if victim.OnDamagedFireProjectiles then
				for k, projectileData in pairs( victim.OnDamagedFireProjectiles ) do
					if projectileData.Requirements == nil or IsGameStateEligible(CurrentRun, projectileData, projectileData.Requirements) then
						projectileData.Id = victim.ObjectId
						projectileData.TargetId = GetTargetId(victim, projectileData)
						thread(ProcessFireProjecile, victim, projectileData)
					end
				end
			end
			if victim.OnDamagedWeaponInterrupt and CheckCooldown("OnDamagedWeaponCooldown"..victim.ObjectId, victim.OnDamagedWeaponCooldown) then
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
	if victim ~= nil and ( victim.Health ~= nil and args.DamageAmount ~= nil and (( victim.HealthBuffer and victim.HealthBuffer > 0) or (victim.Health - args.DamageAmount) > 0 or HasLastStand( victim ))) then
		if not IsEmpty( victim.ActiveEffects ) then
			for effectName in pairs(victim.ActiveEffects) do
				local effectData = EffectData[effectName]
				if effectData and effectData.OnDamagedFunctionName and ( effectData.TriggerOnKillingBlow or (( victim.HealthBuffer and victim.HealthBuffer > 0) or (victim.Health - args.DamageAmount) > 0 or HasLastStand( victim ))) then
					CallFunctionName( effectData.OnDamagedFunctionName, victim, args )
				end
			end
		end
	end
	if attacker ~= nil then
		local victimId = nil
		if victim ~= nil then
			victimId = victim.ObjectId
		end
		if victim and not victim.SkipModifiers and weaponName and IsExWeapon( weaponName, { Combat = true } , args ) and not ProjectileHasUnitHit(args.ProjectileVolley, weaponName ) then
			ProjectileRecordUnitHit( args.ProjectileVolley, weaponName )
			if SessionMapState.ChargeStageManaSpend[weaponName] and not CanChargeSpell() then
				ChargeSpell(-SessionMapState.ChargeStageManaSpend[weaponName], { Force = true } )
			end
		end
		if attacker.OnDamageWeapons ~= nil and ( victim == nil or victim.TriggersOnDamageEffects ) then
			if attacker.OnDamageWeapons[weaponName] ~= nil then
				for weaponName, weaponData in pairs( attacker.OnDamageWeapons[weaponName] ) do
					if type(weaponData) == "table" then
						local passesCritCheck = weaponData.CritOnly == nil or (weaponData.CritOnly and isCrit)
						local passesHitCheck = weaponData.FirstHitOnly == nil or (weaponData.FirstHitOnly and not ProjectileHasUnitHit( args.ProjectileId, weaponName.."OnDamage" ) )
						local passesVelocityCheck = weaponData.RequireImpactMin == nil or (weaponData.RequireImpactMin and args.ImpactVelocity ~= nil and args.ImpactVelocity >= weaponData.RequireImpactMin)
						local passesEffectCheck = weaponData.IncludeEffectDamage or args.EffectName == nil
						if passesCritCheck and passesHitCheck and passesVelocityCheck and passesEffectCheck then
							ProjectileRecordUnitHit( args.ProjectileId, weaponName.."OnDamage")
							FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victimId, FireFromTarget = weaponData.FireFromVictimLocation})
						elseif not weaponData.CritOnly and not weaponData.FirstHitOnly and not weaponData.RequireImpactMin and not weaponData.IncludeEffectDamage then
							FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victimId, FireFromTarget = weaponData.FireFromVictimLocation})
						end
					elseif weaponData then
						FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victimId })
					end
				end
			end
		end
		CheckOnImpactPowers( victim, attacker, args )
	end

	if isCrit and attacker ~= nil and attacker.ObjectId == CurrentRun.Hero.ObjectId and attacker ~= victim and victim ~= nil and victim.TriggersOnDamageEffects then
		for i, functionData in pairs(GetHeroTraitValues("OnEnemyCrittedFunction")) do
			if _G[functionData.Name] ~= nil then
				_G[functionData.Name](victim, functionData.Args)
			end
		end
	end

	local summonShareBonus = {}
	for i, traitData in pairs(GetHeroTraitValues("AddSummonWeaponsToTraits")) do
		summonShareBonus [ traitData.Slot ] = true
	end
	local weaponShareBonus = {}
	for i, traitData in pairs(GetHeroTraitValues("AddWeaponsToTraits")) do
		if traitData.WeaponName then
			weaponShareBonus [ traitData.Slot ] =  { [traitData.WeaponName] = true }
		elseif traitData.WeaponNames then
			weaponShareBonus [ traitData.Slot ] =  traitData.WeaponNamesLookup
		end
	end
	
	if attacker and ( attacker == CurrentRun.Hero or Contains(MapState.SpellSummons, attacker)) and victim ~= nil and victim.TriggersOnDamageEffects then
		for i, traitData in pairs(CurrentRun.Hero.Traits) do
			if traitData.OnEnemyDamagedAction and not traitData.OnEnemyDamagedAction.ValidActiveEffectGenus then 
				local actionData = traitData.OnEnemyDamagedAction
				local validWeapons = actionData.ValidWeaponsLookup == nil or ( actionData.ValidWeaponsLookup[ args.SourceWeapon] ~= nil and args.EffectName == nil )
				local validProjectiles = actionData.ValidProjectilesLookup == nil or ( actionData.ValidProjectilesLookup[ args.SourceProjectile ] ~= nil and args.EffectName == nil )
				local validChance = actionData.Chance == nil or RandomChance(actionData.Chance)
				local validTrait = actionData.RequiredTraitName == nil or HeroHasTrait(actionData.RequiredTraitName)
				if not validWeapons then
					if Contains(MapState.SpellSummons, attacker) and traitData.Slot and summonShareBonus [traitData.Slot] then
						validWeapons = true
					end
					if traitData.Slot and weaponShareBonus[ traitData.Slot ] and weaponShareBonus[traitData.Slot][args.SourceWeapon] and args.EffectName == nil then
						validWeapons = true
					end
				end
				if validWeapons and validProjectiles and actionData.FunctionName ~= nil and ( not actionData.FirstHitOnly or not ProjectileHasUnitHit( args.ProjectileId, actionData.FunctionName ) ) then
					ProjectileRecordUnitHit( args.ProjectileId, actionData.FunctionName )
					CallFunctionName( actionData.FunctionName, victim, ShallowCopyTable( actionData.Args ), args )
				end
				if actionData.EffectName ~= nil or actionData.EffectNames ~= nil then
					if validWeapons and validProjectiles and validChance then
						local effectNames = ShallowCopyTable( actionData.EffectNames ) or {}
						local effectArgs = ShallowCopyTable( actionData.Args ) or {}
						if actionData.EffectName then
							table.insert( effectNames, actionData.EffectName )
							table.insert( effectArgs, actionData.Args or {} )
						end
						for i, effectName in pairs( effectNames ) do
							local dataProperties = MergeTables( EffectData[effectName].EffectData, effectArgs[i] )
							-- kludge, but I'm okay with this one-off. see ApplyBurn for a more extension @alice
							if effectName == "DamageEchoEffect" and HeroHasTrait("EchoAllBoon") then
								dataProperties.Duration = dataProperties.Duration + GetTotalHeroTraitValue("EchoDurationIncrease")
							end
							ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, ImpactAngle = math.rad(args.ImpactAngle), DataProperties = dataProperties })
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
	if HeroHasTrait("SummonRetaliateTalent") and attacker ~= CurrentRun.Hero and Contains( MapState.SpellSummons, victim ) then
		validVictim = true
	end

	local projectileData = ProjectileData[args.SourceProjectile] or {}
	if validVictim and ( attacker ~= victim or projectileData.SelfDamage )
		and ( not args.SourceProjectile or not projectileData.BypassRetaliate ) 
		and (( victim.HealthBuffer and victim.HealthBuffer > 0) or (victim.Health - args.DamageAmount) > 0 or HasLastStand( victim )) then
		for i, functionData in pairs( GetHeroTraitValues("OnSelfDamagedFunction") ) do
			CallFunctionName( functionData.Name, attacker, functionData.FunctionArgs, args )
		end
	end


	if victim and not victim.IsDead and IsEmpty( victim.InvulnerableFlags ) and args.EffectName then
		local effectData = EffectData[args.EffectName]
		if effectData then
			if effectData.CreateAnimationOnDamage then
				CreateAnimation({ Name = effectData.CreateAnimationOnDamage, DestinationId = victim.ObjectId, Scale = victim.EffectVfxScale})
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
		for i, actionData in pairs(GetHeroTraitValues( "OnEnemyDamagedAction" )) do
			local validEffects = actionData.AllEffectsTrigger or ( args.EffectName and actionData.ValidActiveEffectGenus and HasVulnerabilityGenusEffect( victim, actionData.ValidActiveEffectGenus))
			if _G[actionData.FunctionName] ~= nil and validEffects then
				_G[actionData.FunctionName](victim, ShallowCopyTable( actionData.Args ), args)
			end
		end
	end
end

function CheckOnImpactPowers( victim, attacker, args )
	if attacker == CurrentRun.Hero and ( victim == nil or victim.TriggersOnDamageEffects ) then
		local victimId = nil
		if victim ~= nil then
			victimId = victim.ObjectId
		end
		for i, traitData in pairs(GetHeroTraitValues("OnImpactWeapons")) do
			local passesVelocityCheck = traitData.RequireImpactMin == nil or (traitData.RequireImpactMin and args.ImpactVelocity ~= nil and args.ImpactVelocity >= traitData.RequireImpactMin)
			if passesVelocityCheck then
				if traitData.EffectName then
					local dataProperties = MergeTables( EffectData[traitData.EffectName].EffectData,traitData.EffectData )
					ApplyEffect( { DestinationId = victim.ObjectId, Id = attacker.ObjectId, EffectName = traitData.EffectName, DataProperties = dataProperties })
				end
			end
		end
	end
end

function CheckOnDeathPowers( victim, attacker, weaponName )
	if attacker ~= nil and attacker.OnKillWeapons ~= nil then
		if attacker.OnKillWeapons[weaponName] ~= nil then
			for weaponName, v in pairs( attacker.OnKillWeapons[weaponName] ) do
				FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victim.ObjectId })
			end
		end
	end

	local attackerId = nil
	if attacker ~= nil then
		attackerId = attacker.ObjectId
	end

	if victim ~= nil and not victim.AlwaysTraitor and not victim.SkipModifiers then
		for _, data in pairs(GetHeroTraitValues("AddEnemyOnDeathProjectile")) do
			for projectileName, value in pairs(data) do
				CreateProjectileFromUnit({ Name = projectileName, Id = victim.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		
			end
		end

		if victim.OnDeathWeapons ~= nil then
			for onDeathWeaponName, v in pairs( victim.OnDeathWeapons ) do
				local weaponData = WeaponData[onDeathWeaponName]
				local destinationId = attackerId
				if weaponData ~= nil and weaponData.TargetSelf then
					destinationId = victim.ObjectId
				end
				FireWeaponFromUnit({ Weapon = onDeathWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = destinationId })
			end
		end
	end
end

function DamageOverTimeApply( triggerArgs )
	UpdatePoisonEffectStacks( triggerArgs )
end

function DamageOverTimeClear( triggerArgs )
	ClearPoisonEffectStacks( triggerArgs )
end


function AmplifyKnockbackApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and not victim.IsDead then
		SetThingProperty({ Property = "ExternalForceMultiplier", Value = triggerArgs.Modifier, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function AmplifyKnockbackClear( triggerArgs )
	local victim = triggerArgs.Victim
	if not victim.IsDead then
		SetThingProperty({ Property = "ExternalForceMultiplier", Value = 1/triggerArgs.Modifier, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function NearbyVulnerabilityApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied then
	
		local effectData = EffectData[triggerArgs.EffectName]
		thread( NearbyVulnerabilityThread, victim, effectData )
		AddIncomingDamageModifier( victim,
		{
			Name = triggerArgs.EffectName,
			ValidWeapons = ConcatTableValues( ShallowCopyTable( WeaponSets.HeroAllWeapons) , AddLinkedWeapons(WeaponSets.HeroAllWeapons)),
			ProximityMultiplier = triggerArgs.Amount,
			ProximityThreshold = effectData.DistanceThreshold,
			Temporary = true,
		})
	end
end

function NearbyVulnerabilityClear( triggerArgs )
	local victim = triggerArgs.Victim
	RemoveIncomingDamageModifier( victim, triggerArgs.EffectName )
	killWaitUntilThreads( "NearbyVulnerability" .. victim.ObjectId )
end

function NearbyVulnerabilityThread( unit, effectData )
	local notifyName = "NearbyVulnerability" .. unit.ObjectId
	local nearby = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId }) < effectData.DistanceThreshold
	if not unit.HasHealthBar then
		CreateHealthBar(unit)
		UpdateHealthBar( unit, 0, { Force = true })
	end
	if not EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ]  then
		UpdateEffectStacks( unit, effectData.Name )
	end

	if EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ] then
		if nearby then
			SetAnimation({ Name = effectData.ActiveAnimation, DestinationId = EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ] })
		else
			SetAnimation({ Name = effectData.InactiveAnimation, DestinationId = EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ] })
		end
	end
	while unit and not unit.IsDead do
		if nearby then
			NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, Distance = effectData.DistanceThreshold, Notify = notifyName })
		else
			NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, Distance = effectData.DistanceThreshold, Notify = notifyName })
		end
		waitUntil( notifyName )
		nearby = not nearby
		if EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ] then
			if nearby then
				SetAnimation({ Name = effectData.ActiveAnimation, DestinationId = EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ] })
			else
				SetAnimation({ Name = effectData.InactiveAnimation, DestinationId = EnemyHealthDisplayAnchors[ unit.ObjectId .. effectData.DisplaySuffix ] })
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

	StasisPresentation( victim )
	if victim.Frozen then
		-- Already frozen
		return
	end
	victim.Frozen = true
	victim.Mute = true
end

function StasisStunClear( triggerArgs )
	local victim = triggerArgs.Victim	if victim.Frozen then
		local notifyName = "FreezeStunExpired"..victim.ObjectId
		NotifyOnEffectExpired({ Id = victim.ObjectId, Notify = notifyName, EffectName = "FreezeStun" })
		waitUntil( notifyName )
	end
	UnfrozenPresentation( victim )
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
		StopAnimation({ Names = victim.StopAnimationsOnHitStun, DestinationId = victim.ObjectId })
	end

	if victim.CancelWeaponComboOnHitStun then
		victim.ActiveWeaponCombo = nil
	end

	if not IsEmpty( victim.StopSoundsOnHitStun ) then
		for k, soundId in pairs(victim.StopSoundsOnHitStun) do
			StopSound({ Id = soundId, Duration = 0.2 })
		end
	end

	if not IsEmpty( victim.PreAttackLoopingSoundId ) then
		StopSound({ Id = victim.PreAttackLoopingSoundId, Duration = 0.2 })
	end
end

function CheckLavaPresentation( victim, victimId, triggerArgs )
	if triggerArgs.DamageAmount and triggerArgs.DamageAmount > 0 and CurrentRun.Hero and victim == CurrentRun.Hero and not CurrentRun.Hero.IsDead and not CurrentRun.Hero.LavaPresentationActive then
		if not HasIncomingDamageModifier( CurrentRun.Hero, "ConsecerationLavaDefense" ) then
			CurrentRun.Hero.LavaPresentationActive = true
			StartLavaPresentation()
		end
	end
end

function CheckLavaSplashPresentation( victim, victimId, triggerArgs )
	if triggerArgs.DamageAmount and triggerArgs.DamageAmount > 0 and CurrentRun.Hero and victim == CurrentRun.Hero and not CurrentRun.Hero.IsDead and not CurrentRun.Hero.LavaPresentationActive and triggerArgs.SourceProjectile and triggerArgs.SourceProjectile == "LavaPuddleLarge" then
		if not HasIncomingDamageModifier( CurrentRun.Hero, "ConsecerationLavaDefense" ) then
			CurrentRun.Hero.LavaPresentationActive = true
			StartLavaPresentation()
		end
	end
end

function LavaSlowApply( triggerArgs )
	local unit = triggerArgs.Victim
	if unit == CurrentRun.Hero then
		CurrentRun.Hero.OnLava = true
	end
end

function LavaSlowClear( triggerArgs )
	local unit = triggerArgs.Victim
	if unit == CurrentRun.Hero then
		CurrentRun.Hero.LavaPresentationActive = nil
		CurrentRun.Hero.OnLava = nil
		EndLavaPresentation()
	end
end

function EnlargeApply(triggerArgs)
	local victim = triggerArgs.Victim
	local effectData = EffectData[triggerArgs.EffectName]

	if victim.Enlarged then
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
	table.insert(victim.OutgoingDamageModifiers, { Name = "EnlargeSatyrBuff", PlayerMultiplier = effectData.DamageMultiplier } )
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
	StopAnimation({ Name = "SatyrRatCatcherSpellBuffFx", DestinationId = victim.ObjectId, })
	SetScale({ Id = victim.ObjectId, Fraction = victim.OriginalScale, Duration = 0.5 })
end

function InsideCastBuffApply( triggerArgs )
	local unit = triggerArgs.Victim
	if not triggerArgs.Reapplied and triggerArgs.Victim == CurrentRun.Hero then
		local insideManaRegenValue = GetTotalHeroTraitValue( "CastCircleManaRegen" )
		if insideManaRegenValue > 0 and EffectData[triggerArgs.EffectName].MetaUpgradeActiveVfx then
			CreateAnimation({ Name = EffectData[triggerArgs.EffectName].MetaUpgradeActiveVfx, DestinationId = unit.ObjectId })
		end
		CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
		if not CurrentRun.Hero.ManaRegenSources.CastCircleRegen then
			CreateAnimation({ Name = EffectData[triggerArgs.EffectName].ManaRegenStartVfx, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		end
		CurrentRun.Hero.ManaRegenSources.CastCircleRegen = { Value = insideManaRegenValue }
	end
end

function InsideCastBuffClear( triggerArgs )
	local unit = triggerArgs.Victim
	if unit == CurrentRun.Hero then	
		if EffectData[triggerArgs.EffectName].MetaUpgradeActiveVfx then
			StopAnimation({ Name = EffectData[triggerArgs.EffectName].MetaUpgradeActiveVfx, DestinationId = unit.ObjectId })
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
	if not triggerArgs.Reapplied and not victim.IgnoreTimeSlowEffects then
		CallFunctionName( EffectData[triggerArgs.EffectName].OnApplyPresentationFunctionName, victim, triggerArgs.triggeredById )
		local oldMultiplier = victim.SpeedMultiplier or 1
		if victim.SpeedMultiplier then
			victim.SpeedMultiplier = victim.SpeedMultiplier * triggerArgs.ElapsedTimeMultiplier
		else
			victim.SpeedMultiplier = triggerArgs.ElapsedTimeMultiplier
		end
		if victim.AIThreadName then
			SetElapsedTimeMultiplier( victim.SpeedMultiplier / oldMultiplier, victim.AIThreadName)
		end
		if not IsEmpty( victim.ExpireProjectileIdsOnFreeze ) then
			ExpireProjectiles({ ProjectileIds = victim.ExpireProjectileIdsOnFreeze })
		end
	end
end

function TimeSlowUpdate( triggerArgs )
	local unit = triggerArgs.Victim
	if unit.SpeedMultiplier and not unit.IgnoreTimeSlowEffects then
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
		
		local oldMultiplier = unit.SpeedMultiplier
		unit.SpeedMultiplier = unit.SpeedMultiplier * triggerArgs.ElapsedTimeMultiplier / triggerArgs.OldElapsedTimeMultiplier
		
		if unit.AIThreadName then
			SetElapsedTimeMultiplier( unit.SpeedMultiplier / oldMultiplier, unit.AIThreadName)
		end
	end
end

function TimeSlowClear( triggerArgs )
	local unit = triggerArgs.Victim
	
	if unit.IgnoreTimeSlowEffects then
		return
	end
	local oldMultiplier = unit.SpeedMultiplier or 1
	CallFunctionName( EffectData[triggerArgs.EffectName].OnClearPresentationFunctionName, unit, triggerArgs.triggeredById )
		
	if unit.SpeedMultiplier and not unit.IgnoreTimeSlowEffects then
		unit.SpeedMultiplier = unit.SpeedMultiplier / triggerArgs.ElapsedTimeMultiplier
	else
		unit.SpeedMultiplier = 1
	end
	if unit.AIThreadName then
		SetElapsedTimeMultiplier( unit.SpeedMultiplier / oldMultiplier, unit.AIThreadName)
	end
end

function StasisApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and not victim.IgnoreTimeSlowEffects then
		local timeSlow = triggerArgs.Modifier
		CallFunctionName( EffectData[triggerArgs.EffectName].OnApplyPresentationFunctionName, victim, triggerArgs.triggeredById )
		SetThingProperty({ Property = "AnimFreeze", Value = true, DestinationId = victim.ObjectId, DataValue = false })
		local oldMultiplier = victim.SpeedMultiplier or 1
		if victim.SpeedMultiplier then
			victim.SpeedMultiplier = victim.SpeedMultiplier * timeSlow
		else
			victim.SpeedMultiplier = timeSlow
		end
		if victim.AIThreadName then
			SetElapsedTimeMultiplier( victim.SpeedMultiplier / oldMultiplier, victim.AIThreadName)
		end
	end
end
function StasisClear( triggerArgs )
	local unit = triggerArgs.Victim
	local oldMultiplier = unit.SpeedMultiplier or 1
	local timeSlow = triggerArgs.Modifier
	CallFunctionName( EffectData[triggerArgs.EffectName].OnClearPresentationFunctionName, unit, triggerArgs.triggeredById )
		
	if unit.SpeedMultiplier and not unit.IgnoreTimeSlowEffects then
		unit.SpeedMultiplier = unit.SpeedMultiplier / timeSlow
	else
		unit.SpeedMultiplier = 1
	end
	SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = unit.ObjectId, DataValue = false })
	local idleGraphic = GetThingDataValue({ Id = unit.ObjectId, Property = "Graphic" })
	SetAnimation({ DestinationId = unit.ObjectId, Name = idleGraphic })
	if unit.AIThreadName then
		SetElapsedTimeMultiplier( unit.SpeedMultiplier / oldMultiplier, unit.AIThreadName)
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

function ClearRoot(victim, functionArgs, triggerArgs)
	ClearEffect({ Id = victim.ObjectId, Name = functionArgs.EffectName })
end

-- |DASH WEAPONS| --
OnWeaponFired{ "RushWeapon RamWeapon",
	function(triggerArgs)
		local runFunctions = {}

		for i, dashData in pairs( GetHeroTraitValues("AddRush") ) do
			local dashFunction = _G[dashData.FunctionName]
			if dashFunction ~= nil and ( not dashData.RunOnce or ( dashData.RunOnce and not runFunctions[ dashData.FunctionName ])) then
				thread( dashFunction, dashData.FunctionArgs, triggerArgs )
				runFunctions[dashData.FunctionName] = true
			end
		end
		for i, dashData in pairs( GetHeroTraitValues("DashProperties") ) do
			ProcessDashProperties( dashData )
			thread( PostProcessDashThread, dashData )
		end
	end
}

OnWeaponChargeCanceled{ "RushWeapon",
	function(triggerArgs)
		for i, dashData in pairs(GetHeroTraitValues("DashChargeProperties")) do
			PostProcessDashProperties( dashData )
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
		local nearestEnemyTarget = 0
		local targetId = 0
		if chooseTarget ~= nil then
			targetId = chooseTarget
		else
			if seekTarget then
				nearestEnemyTarget = GetClosest({ Id = sourceTargetId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, StopsProjectiles = true, Distance = range, YScale = yScale })
			end
			if nearestEnemyTarget == 0 then
				local randomLightningTargetOffsetX = RandomFloat(-1 * range/2, range/2)
				local randomLightningTargetOffsetY = RandomFloat(-1 * range/2, range/2)
				targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = sourceTargetId, OffsetX = randomLightningTargetOffsetX, OffsetY = randomLightningTargetOffsetY })
				createdObstacleId = targetId
			else
				targetId = nearestEnemyTarget
			end
		end
		if targetId ~= 0 and ActiveEnemies[targetId] and not ActiveEnemies[targetId].IsDead then
			CreateProjectileFromUnit({ 
				Name = projectileName, 
				WeaponName = weaponName,
				Id = CurrentRun.Hero.ObjectId, 
				DamageMultiplier = damageMultiplier, 
				DestinationId = targetId, 
				FireFromTarget = true })
			if runFunctionOnTarget then
				CallFunctionName( runFunctionOnTarget, { Id = targetId, Args = runFunctionArgsOnTarget} )
			end
			if createdObstacleId ~= nil then
				Destroy({ Id = createdObstacleId })
			end
		end
		waitUnmodified( args.Delay )
	end
end

function ApolloPerfectDash( traitArgs, triggerArgs )
	if triggerArgs.NearbyDangerId ~= nil and triggerArgs.NearbyDangerId > 0 and ActiveEnemies[triggerArgs.NearbyDangerId] ~= nil and not ActiveEnemies[triggerArgs.NearbyDangerId].IsDead and CheckCooldownNoTrigger( "BlockPerfectDash", CurrentRun.Hero.PerfectDashHitDisableDuration ) then
		local unit = ActiveEnemies[triggerArgs.NearbyDangerId]
		if HasVulnerabilityGenusEffect( unit, traitArgs.ValidActiveEffectGenus ) then
			PerfectDashStartPresentation( triggerArgs )
			PerfectDashEndPresentation( triggerArgs, traitArgs.Text )
			CreateProjectileFromUnit({ Name = traitArgs.ProjectileName or "ApolloPerfectDashStrike", Id = CurrentRun.Hero.ObjectId, DestinationId = triggerArgs.NearbyDangerId, DamageMultiplier = traitArgs.DamageMultiplier})
		end
	end
end

function ApolloBlindStrike( unit, traitArgs )
	if unit and HasVulnerabilityGenusEffect( unit, traitArgs.ValidActiveEffectGenus ) and CheckCooldown( "ApolloBlindStrike", traitArgs.Cooldown ) then
		CreateProjectileFromUnit({ Name = traitArgs.ProjectileName or "ApolloPerfectDashStrike", Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier})
	end
end

function TimeSlowPerfectDash( traitArgs, triggerArgs )
	if triggerArgs.NearbyDangerId ~= nil and triggerArgs.NearbyDangerId > 0 and ActiveEnemies[triggerArgs.NearbyDangerId] ~= nil and not ActiveEnemies[triggerArgs.NearbyDangerId].IsDead and CheckCooldownNoTrigger( "BlockPerfectDash", CurrentRun.Hero.PerfectDashHitDisableDuration ) and CheckCooldown( "PerfectDodgeSlowBoon", traitArgs.Cooldown ) then
		StartWeaponSlowMotion( triggerArgs, { Name = "PerfectDash" }, traitArgs )
	end
end

OnWeaponFired{ "RushWeapon",
	function( triggerArgs )
		DashManeuver()
		if triggerArgs.NearbyDangerId ~= nil and triggerArgs.NearbyDangerId > 0 and IsMetaUpgradeActive( "PerfectDashMetaUpgrade" ) and GetNumMetaUpgrades("PerfectDashMetaUpgrade") > 0 and CheckCooldownNoTrigger( "BlockPerfectDash", CurrentRun.Hero.PerfectDashHitDisableDuration ) then
			PerfectDashStartPresentation( triggerArgs )
			FireWeaponFromUnit({ Weapon = "PerfectDashEmpowerApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			PerfectDashEndPresentation( triggerArgs )
		end
	end
}

function SetupCastCast( unit, args )

	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponCastProjectile", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end
function SetupAnywhereCast( unit, args )

	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponAnywhereCast", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end

function GetNearestEnemyArgs( args )
	-- Approximates autolock
	args = args or {}
	local range = args.Range or 600
	local count = args.Count or 4
	local arc = args.Arc or 90
	local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = range, MaximumCount = count })
	local facingAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	local closestFacingTarget = nil
	local closestFacingTargetDistance = range * 2
	local closestTarget = nil
	local closestAngle = 360
	local closestTargetDistance = range * 2
	for _, id in pairs( nearestEnemyTargetIds ) do
		local enemy = ActiveEnemies[id]
		if enemy ~= nil and not enemy.IsDead and not enemy.IgnoreAutoLock then
			local angleToTarget = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = id })
			local distance = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = id })
			local arcDistance = CalcArcDistance( facingAngle, angleToTarget )
			if arcDistance <= arc then
				if closestFacingTarget == nil or arcDistance < closestAngle then
					closestFacingTarget = id
					closestAngle = arcDistance
				end
			elseif not args.RequireFacing then
				if closestTarget == nil or distance < closestTargetDistance then
					closestTarget = id
					closestTargetDistance = distance
				end
			end
		end
	end
	return closestFacingTarget or closestTarget or 0
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

function GetTotalGodEnhancement()
	local perGodMultiplier = GetTotalStatChange( MetaUpgradeData.GodEnhancementMetaUpgrade )
	local godDictionary = {}
	for traitName in pairs( CurrentRun.Hero.TraitDictionary ) do
		if GetLootSourceName( traitName ) then
			godDictionary[GetLootSourceName( traitName )] = true
		end
	end
	return  perGodMultiplier * TableLength( godDictionary )
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
	
	CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, DamageMultiplier = args.DamageMultiplier})
	for id, enemy in pairs( ActiveEnemies ) do
		if enemy and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) and not enemy.SkipModifiers and enemy.TriggersOnHitEffects and not IsUntargetable({Id = enemy.ObjectId}) then
			
			ApplyEffect( { DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = EffectData[args.EffectName].EffectData })
		end
	end
end

function ZeusRetaliate( unit, args )
	if not unit or unit.SkipModifiers or not CheckCooldown( "ZeusRetaliate"..unit.ObjectId, args.Cooldown ) then
		return
	end
	local strikeCount = 1
	while RandomChance( args.ConsecutiveStrikeChance ) and strikeCount < args.MaxStrikes do
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

function CheckBlindVampOnHit( victim, functionArgs, triggerArgs )
	if HasVulnerabilityGenusEffect( victim, functionArgs.ValidActiveEffectGenus )
		and RandomChance( functionArgs.Chance)
		and CurrentRun.Hero.Health < CurrentRun.Hero.MaxHealth then
		local tempHealthGain = 1
		IncrementTableValue( CurrentRun.CurrentRoom, "TempHealth", tempHealthGain)
		Heal( CurrentRun.Hero, { HealAmount = tempHealthGain, SourceName = "TempHealth", Silent = false })
	end
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

function RemoveCastVolleyProjectile(triggerArgs)
	if triggerArgs.name and triggerArgs.name == "ArtemisCastVolley" then
	--	DebugPrint({Text = " decrementing cast volley "})
		DecrementTableValue( SessionState, "ArtemisCastProjectiles" )
	end
end
function CheckSupportingFire( victim, functionArgs, triggerArgs )
	local cooldown = functionArgs.Cooldown or 0.1667
	if CheckCooldown("SupportFire", window ) then
		local angle = functionArgs.StartAngle
		if angle and functionArgs.Scatter then
			angle = angle + RandomFloat(-functionArgs.Scatter, functionArgs.Scatter)
		end

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

function CheckPoseidonManaDrop( victim, functionArgs, triggerArgs )
	if RandomChance( functionArgs.Chance ) then
		local id = SpawnObstacle({ Name = functionArgs.Name, DestinationId = victim.ObjectId, Group = "Standing" })
		CreateConsumableItem( id, functionArgs.Name, 0)
		local upwardForceMin = functionArgs.UpwardForceMin or 600
		local upwardForceMax = functionArgs.UpwardForceMin or 800
		local forceMin = functionArgs.ForceMin or 400
		local forceMax = functionArgs.ForceMax or 550
		ApplyUpwardForce({ Id = id, Speed = RandomFloat( upwardForceMin, upwardForceMax ) })
		ApplyForce({ Id = id, Speed = RandomFloat( forceMin, forceMax ), Angle = RandomFloat( 0, 360 ), SelfApplied = true })
		if functionArgs.Sound then
			PlaySound({ Name = functionArgs.Sound, Id = id, ManagerCap = 46 })
		end
		if functionArgs.Duration then
			thread( DestroyOnDelay, { id } , functionArgs.Duration, { Fx = functionArgs.ExpireFx })
		end
	end
end

function CheckPoseidonKnockback( victim, functionArgs, triggerArgs )
	local angle = triggerArgs.ImpactAngle
	local knockbackForce = WeaponData.DefaultWeaponValues.DefaultKnockbackForce 
	local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.SourceWeapon )
	if weaponData and weaponData.DefaultKnockbackForce then
		knockbackForce = weaponData.DefaultKnockbackForce
	end
	if angle < 0 then
		angle = GetAngleBetween({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId}) 
	end
	ApplyForce({ Id = victim.ObjectId, Speed = knockbackForce, Angle = angle })
	CheckOnImpactPowers( victim, CurrentRun.Hero, {ImpactVelocity = knockbackForce})
end

function RaiseKilledEnemy( enemy, args )
	if MapState.RaiseDeadCount then
		return
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

		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap ~= nil then
			local activeCapWeight = newEnemy.ActiveCapWeight or 1
			CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap = math.min(CurrentRun.CurrentRoom.Encounter.ActiveEnemyCapMax, CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap + activeCapWeight)
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
	newEnemy.RequiredKill = false
	newEnemy.DefaultAIData.TargetClosest = true
	newEnemy.MaxHealth = newEnemy.MaxHealth * weaponDataMultipliers.MaxHealthMultiplier

	if newEnemy.SpellSummonDataOverrides ~= nil then
		OverwriteTableKeys(newEnemy, newEnemy.SpellSummonDataOverrides)
	end

	newEnemy.BlocksLootInteraction = false
	newEnemy.ObjectId = SpawnUnit({
			Name = enemyData.Name,
			Group = "Standing",
			DestinationId = newEnemy.SpellSummonSpawnOnId or args.SpawnPointId, OffsetX = 0, OffsetY = 0 })
		
	thread( SpellSummonPresentation, newEnemy )
	thread( SetupUnit, newEnemy, CurrentRun, { SkipPresentation = true } )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = GetGameplayElapsedTimeMultiplier(), ValueChangeType = "Absolute", DataValue = false, DestinationId = newEnemy.ObjectId })
	AddOutgoingDamageModifier( newEnemy, { NonPlayerMultiplier = weaponDataMultipliers.DamageMultiplier })
	
	newEnemy.SpeedMultiplier = ( newEnemy.SpeedMultiplier or 1 ) + (weaponDataMultipliers.SpeedMultiplier - 1)
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = newEnemy.SpeedMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = newEnemy.ObjectId })
	RemoveAutoLockTarget({ Id = newEnemy.ObjectId })
		
	AddIncomingDamageModifier( newEnemy,
	{
		Name = "PlayerDeathDefense",
		PlayerMultiplier = 0.2,
	})
	AddIncomingDamageModifier( newEnemy,
	{
		Name = "EnemyDeathDefense",
		NonPlayerMultiplier = 0.5,
	})	
	SetLifeProperty({ DestinationId = newEnemy.ObjectId, Property = "JumpTargetEligible", Value = false })
	SetLifeProperty({ DestinationId = newEnemy.ObjectId, Property = "HomingEligible", Value = false })
	SetScale({ Id = newEnemy.ObjectId, Fraction = weaponDataMultipliers.ScaleMultiplier, Duration = 0 })
	AddEffectBlock({ Id = newEnemy.ObjectId, Name = "OnHitStun" })
	AddEffectBlock({ Id = newEnemy.ObjectId, Name = "OnHitStunHeavy" })

	return newEnemy
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
	for unitId, unit in pairs(ActiveEnemies) do
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
	MapState.RaiseDeadCount = nil
end
function CheckZeusProjectile( victim, functionArgs, triggerArgs )
	
	local window = functionArgs.WindowDuration or 0.1
	local count = functionArgs.WindowCount or 1
	if CheckCountInWindow("ZeusProjectile", window, count ) then
		return
	end

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
			CreateProjectileFromUnit({ 
				Name = functionArgs.ProjectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				DamageMultiplier = functionArgs.DamageMultiplier + bonusDamageMultiplier, 
				DestinationId = victim.ObjectId, 
				FireFromTarget = true,
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
	if not HeroHasTrait("WeaponCastProjectileHades") and not HeroHasTrait("WeaponAnywhereCast") and not HeroHasTrait("WeaponCastProjectile") then
		return
	end
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
	
	AttachProjectiles({ Ids = { triggerArgs.ProjectileId }, DestinationId = dropLocation })
	AttachProjectiles({ Ids = SessionMapState.CastAttachedProjectiles[triggerArgs.ProjectileId], DestinationId = dropLocation })

	local speed = functionArgs.Speed
	local interval = 0.1
	while SessionMapState.CastAttachedProjectiles[triggerArgs.ProjectileId] do
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
	if not IsControlDown({ Name = "Attack1" }) then
		CheckCastDetach( weaponData, nil, { PostFire = false })
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
	if not triggerArgs.PostFire then
		DetachProjectiles({ Ids = projectileIds})
	end
end

function OnPoseidonCastArmed( triggerArgs, functionArgs )
	local projectileId = triggerArgs.ProjectileId
	if not IsEmpty(SessionMapState.CastAttachedProjectiles[projectileId]) then
		ExpireProjectiles({ ProjectileIds = SessionMapState.CastAttachedProjectiles[projectileId] })
	end
	local radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
	local scaleX = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleX" })
	local scaleY = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleY" })
	
	local location = GetLocation({ Id = projectileId, IsProjectile = true })
	local destinationId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y, Group = "Scripting"})
	local ids = GetClosestIds({ Id = destinationId, Distance = radius, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, ScaleX = scaleX, ScaleY = scaleY, PreciseCollision = true })
	local effectNames = { "ImpactSlow", "ImpactGrip" }
		
	for _, id in pairs(ids) do
		for _, effectName in pairs(effectNames) do
			ClearEffect({ Id = id, Name = effectName})
			AddEffectBlock({ Id = id, Name = effectName })
		end
	end
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = functionArgs.ProjectileName,
		WeaponName = triggerArgs.WeaponName ,
		Type = "Projectile",
		MatchProjectileName = true,
	})
	CreateProjectileFromUnit({ 
		WeaponName = triggerArgs.WeaponName, Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, ProjectileDestinationId = projectileId, FireFromTarget = true, 
		DamageMultiplier = functionArgs.DamageMultiplier, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
	
	wait(0.2)
	Destroy({ Id = dropLocation })
	Destroy({ Id = destinationId })
	for _, id in pairs(ids) do
		for _, effectName in pairs(effectNames) do
			RemoveEffectBlock({ Id = id, Name = effectName })
		end
	end
		
end

function OnHephCastArmed( triggerArgs, functionArgs )
	local projectileId = triggerArgs.ProjectileId
	
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = functionArgs.ProjectileName,
		WeaponName = triggerArgs.WeaponName ,
		Type = "Projectile",
		MatchProjectileName = true,
	})
	derivedValues.PropertyChanges.TotalFuse = triggerArgs.RemainingTime
	CreateProjectileFromUnit({ 
		WeaponName = triggerArgs.WeaponName, Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
		DamageMultiplier = functionArgs.DamageMultiplier, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
	Destroy({Id = dropLocation })	
end

function OnPoseidonCastArmedExtension( triggerArgs, functionArgs )
	functionArgs.ProjectileId = triggerArgs.ProjectileId
	CheckMassiveAttack( nil, functionArgs, triggerArgs )
end

function OnZeusCastArmed( triggerArgs, functionArgs )
	local projectileId = triggerArgs.ProjectileId
	local tempObstacleId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY= triggerArgs.LocationY })
	functionArgs.StrikeCount = triggerArgs.RemainingTime / functionArgs.StrikeInterval
	thread( ManageZeusCloud, functionArgs, tempObstacleId, triggerArgs.ProjectileId )
end

function ManageZeusCloud( functionArgs, tempObstacleId, projectileId )
	local strikeCount = 0
	local range = functionArgs.Range
	while strikeCount <= functionArgs.StrikeCount do
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
		ProjectileName = functionArgs.ProjectileName, 
		DamageMultiplier = functionArgs.DamageMultiplier,
		InitialDelay = 0,
		Delay = 0.1, 
		Count = 1 })
		wait( functionArgs.StrikeInterval, RoomThreadName )
		strikeCount = strikeCount + 1
	end
	ZeusCloudFinishPresentation( functionArgs, tempObstacleId )
	Destroy({ Id = tempObstacleId})
end

function CheckZeusManaBolt( unit, functionArgs )
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		if (IsCombatEncounterActive(CurrentRun) or (not IsEmpty(ActiveEnemies) and (not CurrentRun.CurrentRoom.Encounter or not CurrentRun.CurrentRoom.Encounter.DelayedStart ))) and CurrentRun.Hero.Mana <= functionArgs.ManaThreshold then
			local targetedEnemies = GetAllKeys( ActiveEnemies )
			local delay = 0.1
			for _, enemy in pairs(ActiveEnemies) do
				if not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) and not enemy.SkipModifiers and not enemy.IgnoreAutoLock then
					thread( CreateZeusBolt, { ProjectileName = functionArgs.ProjectileName, TargetId = enemy.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, Delay = delay })
					delay = delay + 0.1
				end
			end
			wait( functionArgs.Cooldown, RoomThreadName )
		else
			wait( 0.1, RoomThreadName )
		end
	end
end

function HandleOnSprintEffect()
	for i, data in pairs(GetHeroTraitValues("OnSprintManaDrain")) do
		CallFunctionName( data.FunctionName, data.FunctionArgs )
	end
end

function HestiaSprintDefense ( weaponData, traitArgs, triggerArgs )
	if not MapState.SprintStorms then
		MapState.SprintStorms = {}
	end	
	if not MapState.AttachedStormProjectileId or MapState.AttachedStormProjectileId < 0 then
		local dataProperties = 
		{
			StartDelay = traitArgs.StartDelay
		}
		if traitArgs.TargetId then
			dataProperties.AttachToOwner = false
			projectileId = CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, DestinationId = traitArgs.TargetId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true, DataProperties = dataProperties, BlastRadiusModifier = traitArgs.BlastRadiusMultiplier })				
		else
			projectileId = CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, ProjectileDestinationId = traitArgs.TargetId or CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, DataProperties = dataProperties,  BlastRadiusModifier = traitArgs.BlastRadiusMultiplier, FireFromTarget = true })				
		end
		table.insert(MapState.SprintStorms, projectileId )
		MapState.AttachedStormProjectileId = projectileId
		if traitArgs.BuffVfx then
			CreateAnimation({ Name = traitArgs.BuffVfx, DestinationId = CurrentRun.Hero.ObjectId })
			MapState.AttachedStormAnimation = traitArgs.BuffVfx
		end
		if TableLength( MapState.SprintStorms ) > 1 then
			ExpireProjectiles({ ProjectileIds = { MapState.SprintStorms[1] } })
			table.remove( MapState.SprintStorms, 1)
		end
	end 
end


function HestiaBlockSpend( victim, args, triggerArgs )
	local traitData = GetHeroTrait("HestiaSprintBoon")
	local functionArgs = traitData.OnWeaponFiredFunctions.FunctionArgs
	local attacker = triggerArgs.Attacker 
	if triggerArgs.BlockingProjectileName == functionArgs.ProjectileName then
		local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY= triggerArgs.ProjectileY })
		if attacker and not attacker.SkipModifiers and not attacker.IsDead and not IsUntargetable({Id = attacker.ObjectId}) then
			ApplyBurn( attacker, functionArgs.EffectArgs )
		end
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = targetId })
		if functionArgs.FireSound then
			PlaySound({ Name = functionArgs.FireSound, Id = targetId, ManagerCap = 46 })
		end
		Destroy({ Id = targetId })
	end
end

function ZeusSprintZap( weaponData, functionArgs, triggerArgs )
	local manaCost = 0
	if functionArgs.CostPerStrike and functionArgs.CostPerStrike > 0 then
		manaCost = GetManaCost( weaponData, true, { ManaCostOverride = functionArgs.CostPerStrike} )
	end
	if CheckCooldown("ZeusSprintZap", functionArgs.Cooldown, true ) then
		if CurrentRun.Hero.Mana >= manaCost then
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
	local manaCost = GetManaCost( weaponData, true, { ManaCostOverride = functionArgs.CostPerStrike} )
	ManaDelta(-manaCost)
end


function PreDamageBoss( enemy, damageAmount, damageData )
	local waitTime = damageData.Delay or 3
	wait( waitTime, RoomThreadName )
	Damage( enemy, { DamageAmount = damageAmount, Silent = true})
			
	UpdateHealthBar( enemy, 0, { Force = true })
	thread( CallFunctionName, damageData.PresentationFunctionName or "PreDamagePresentation", enemy, damageAmount, damageData )
end

function CreateZeusBolt( functionArgs )
	local doubleBoltChance = GetTotalHeroTraitValue("DoubleBoltChance")
	local strikes = functionArgs.Count or 1
	if RandomChance(doubleBoltChance) then
		strikes = strikes + 1
	end
	FireWeaponWithinRange({
		SourceId = functionArgs.SourceId,
		Range = functionArgs.Range,
		TargetId = functionArgs.TargetId,
		SeekTarget = functionArgs.SeekTarget, 
		WeaponName = functionArgs.WeaponName,
		ProjectileName = functionArgs.ProjectileName, 
		DamageMultiplier = functionArgs.DamageMultiplier,
		InitialDelay = functionArgs.Delay, 
		RunFunctionNameOnTarget = functionArgs.RunFunctionNameOnTarget,
		RunFunctionArgsOnTarget = functionArgs.RunFunctionArgsOnTarget,
		Delay = functionArgs.FollowUpDelay or 0.1, 
		Count = strikes })
end

function PoseidonSprintSplash ( weaponData, functionArgs, triggerArgs )
	local manaCost = 0
	if functionArgs.ManaCost and functionArgs.ManaCost > 0 then
		manaCost = GetManaCost( weaponData, true, { ManaCostOverride = functionArgs.ManaCost} )
	end
	if CheckCooldown("PoseidonFrontSprint", functionArgs.Cooldown, true ) then
		if CurrentRun.Hero.Mana >= manaCost then
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
	local trait = GetHeroTrait("PoseidonSprintBoon")
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSprint" )
	local manaCost = GetManaCost( weaponData, true, { ManaCostOverride = trait.OnWeaponFiredFunctions.FunctionArgs.ManaCost } )
	ManaDelta(-manaCost)
end

function PoseidonSprintBackSplash ( weaponData, functionArgs, triggerArgs )
	if CheckCooldown("PoseidonBackSprint", functionArgs.Cooldown, true ) then
		local scale = functionArgs.Scale or 1
		for i, data in pairs(GetHeroTraitValues("ConeModifier")) do
			if data.ScaleIncrease then
				scale = scale * data.ScaleIncrease
			end
			if data.MaxScale and scale > data.MaxScale then
				scale = data.MaxScale
			end
		end
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, ScaleMultiplier = scale, Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }), DamageMultiplier = functionArgs.DamageMultiplier})
	end
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
	if not CurrentRun.Hero.SprintActive or not SessionMapState.SprintStartTime or ( functionArgs.StartDelay and (_worldTimeUnmodified - SessionMapState.SprintStartTime) < functionArgs.StartDelay ) then
		return
	end
	if  CheckCooldown( "HeraSprintSuction", functionArgs.Cooldown) then
		local enemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = functionArgs.Radius })
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
		if enemyId and ActiveEnemies[enemyId] and not ActiveEnemies[enemyId].IsDead then
			ApplyDamageShare( ActiveEnemies[enemyId], functionArgs )
			local closestEnemies = GetClosestIds({ Id = enemyId, Distance = functionArgs.Range, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true })
			local maxTargets = functionArgs.NumJumps
			local currentTargets = 0
			for _, nearbyEnemyId in pairs( closestEnemies ) do
				if ActiveEnemies[nearbyEnemyId] and ( IsEmpty(ActiveEnemies[nearbyEnemyId].ActiveEffects) or not ActiveEnemies[nearbyEnemyId].ActiveEffects[functionArgs.EffectName] ) then
					CreateAnimationsBetween({ 
						Animation = "HeraRope", DestinationId = nearbyEnemyId, Id = enemyId, 
						Stretch = true, UseZLocation = false})

					PlaySound({ Name = "/SFX/Player Sounds/HeraKnotDamageSingle", Id = enemyId, ManagerCap = 46 })

					ApplyDamageShare( ActiveEnemies[nearbyEnemyId], functionArgs )
					currentTargets = currentTargets + 1
					if currentTargets >= maxTargets then
						break
					end
				end
			end
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
	if not victim.IsDead and triggerArgs.EffectName == functionArgs.EffectName then
		thread( CheckBurnConsumptionDelay, victim, functionArgs, triggerArgs )
	end
end

function CheckBurnConsumptionDelay( victim, functionArgs, triggerArgs )
	waitUnmodified( functionArgs.Delay, RoomThreadName )
	if not victim.IsDead and victim.ActiveEffects[functionArgs.EffectName] and victim.ActiveEffects[functionArgs.EffectName] >= functionArgs.BurnStacks then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = victim.ActiveEffects[functionArgs.EffectName] * functionArgs.ConsumptionDamage })
		ClearEffect({ Id = victim.ObjectId, Name = functionArgs.EffectName })
	end
end

function CheckCastBurnApply( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" and CheckCooldown("CastBurnApply"..victim.ObjectId, functionArgs.Cooldown ) then
		ApplyBurn( victim, functionArgs, triggerArgs )
	end
end

function CheckOmegaZeroBurn( victim, functionArgs, triggerArgs )
	if IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		if victim.ActiveEffectsAtDamageStart and not victim.ActiveEffectsAtDamageStart [functionArgs.EffectName ] then
			ApplyBurn( victim, functionArgs, triggerArgs )
		end
	end
end

function ApplyBurn( victim, functionArgs, triggerArgs )
	functionArgs = functionArgs or { EffectName = "BurnEffect", NumStacks = 1 }
	local effectName = functionArgs.EffectName 
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
				if data.RefreshOnExpireMultiplier then
					dataProperties.RefreshOnExpireMultiplier = dataProperties.RefreshOnExpireMultiplier + data.RefreshOnExpireMultiplier
				end
			end
		end
	end
	local baseMaxStacks = EffectData[effectName].EffectData.MaxStacks or 1
	dataProperties.MaxStacks = baseMaxStacks + GetTotalHeroTraitValue( "BurnStackIncrease")
	IncrementTableValue( victim.ActiveEffects, effectName, functionArgs.NumStacks )
	ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, NumStacks = functionArgs.NumStacks, DataProperties = dataProperties } )
	
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

function CheckMaximumLink( victim, functionArgs, triggerArgs )
	if not victim or victim.IsDead then
		return
	end
	SessionMapState.DamageShareRecord[victim.ObjectId] = _worldTime
	local removeIds = {}
	for id in pairs(SessionMapState.DamageShareRecord) do
		if not ActiveEnemies[id] or ActiveEnemies[id].IsDead or not ActiveEnemies[id].ActiveEffects.DamageShareEffect then
			table.insert(removeIds, id )
		end
	end
	for _, removeId in pairs(removeIds) do
		SessionMapState.DamageShareRecord[removeId] = nil
	end
	
	while TableLength( SessionMapState.DamageShareRecord) > 2 do
		local oldest = GetFirstKey(SessionMapState.DamageShareRecord)
		for id, time in pairs( SessionMapState.DamageShareRecord ) do
			if time < SessionMapState.DamageShareRecord[oldest] then
				oldest = id
			end
		end
		ClearEffect({ Id = oldest, Name = "DamageShareEffect" })
		SessionMapState.DamageShareRecord[oldest] = nil
	end
	if triggerArgs.EffectName == "DamageShareEffect" then
		ApplyAphroditeVulnerability( victim, functionArgs, triggerArgs )
	end
end

function CheckCastAphroditeVulnerabilityApply( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" then
		local effectName = functionArgs.EffectName 	
		ApplyAphroditeVulnerability( victim, functionArgs, triggerArgs )
	end
end

function DoubleBurnBoon( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == functionArgs.RequiredEffect and not triggerArgs.Reapplied and not victim.IsDead and victim.ActiveEffects[functionArgs.MultipliedEffect] then
		ApplyBurn( victim, {
			EffectName = functionArgs.MultipliedEffect,
			NumStacks = victim.ActiveEffects[functionArgs.MultipliedEffect],
		})
	end
end

function ApplyDamageShare( victim, functionArgs, triggerArgs )
	if not victim or victim.SkipModifiers or not GetThingDataValue({ Id = victim.ObjectId, Property = "StopsProjectiles" }) or IsInvulnerable({ Id = victim.ObjectId }) then
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

function CheckLinkDeath( unit, args )
	if unit.ActiveEffectsAtDamageStart and unit.ActiveEffectsAtDamageStart [args.EffectName] then
		for id, enemy in pairs( ActiveEnemies ) do
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
	traitArgs = traitArgs or {}
	delay = traitArgs.Delay or 0.1
	wait( delay, RoomThreadName)
	CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier })
	if CheckCooldown("HeraCastPresentation", traitArgs.VfxCooldown) then
		local castId = GetFirstKey( SessionMapState.CastAttachedProjectiles )
		local location = GetLocation({ Id = castId, IsProjectile = true})
		local ropeTargetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y}) 
		CreateAnimationsBetween({
			Animation = "HeraRope", DestinationId = enemy.ObjectId, Id = ropeTargetId, 
			Stretch = true, UseZLocation = false})
		thread( DestroyOnDelay, { ropeTargetId } , 0.1 )
	end
end

function CheckDamageShareJump( victim, functionArgs, triggerArgs )
	if MapState.DamageShareJumping then
		return
	end

	MapState.DamageShareJumping = true
	
	if triggerArgs.EffectName == functionArgs.EffectName then
		local closestEnemies = GetClosestIds({ Id = victim.ObjectId, Distance = functionArgs.Range, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true })
		local maxTargets = functionArgs.NumJumps
		local currentTargets = 0
		for _, enemyId in pairs( closestEnemies ) do
			if ActiveEnemies[enemyId] and ( IsEmpty(ActiveEnemies[enemyId].ActiveEffects) or not ActiveEnemies[enemyId].ActiveEffects[functionArgs.EffectName] ) then
				ApplyEffect( { DestinationId = enemyId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = EffectData[functionArgs.EffectName].EffectData })
				currentTargets = currentTargets + 1
				if currentTargets >= maxTargets then
					break
				end
			end
		end
	end
	MapState.DamageShareJumping = false
end

function CheckTimedKillBuff (enemy, args )
	if not enemy.SkipModifiers then
		if SessionMapState.TimedBuff <= 0 and args.Fx then
			CreateAnimation({ Name = args.Fx, DestinationId = CurrentRun.Hero.ObjectId })
		end
		SessionMapState.TimedBuff = SessionMapState.TimedBuff + 1
		thread(ReduceKillBuff, args )
		local trait = GetHeroTrait( "TimedKillBuffBoon")
		UpdateTraitNumber( trait )
	end
end

function ReduceKillBuff( args )	
	waitUnmodified( args.Duration, RoomThreadName )
	SessionMapState.TimedBuff = SessionMapState.TimedBuff - 1
	local trait = GetHeroTrait( "TimedKillBuffBoon")
	UpdateTraitNumber( trait )
	if SessionMapState.TimedBuff <= 0 then
		StopAnimation({ Name = args.Fx, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function CheckBurnDeathExplosion( enemy, args )
	args = args or {}
	if args.EffectName and enemy.ActiveEffectsAtDamageStart and enemy.ActiveEffectsAtDamageStart[args.EffectName] then	
		CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, DamageMultiplier = args.ProjectileDamageMultiplier})
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
	local radius = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCast", Property = "DamageRadius" })
	while pullCount < traitArgs.PullCount and ProjectileExists({ Id = projectileId }) do
		pullCount = pullCount + 1
		local nearestEnemyTargetIds = 
			GetClosestIds({ Id = centerId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = radius })
		CreateAnimation({ Name = traitArgs.PullVfx, DestinationId = centerId, ScaleRadius = damageRadius })
		for i, id in pairs(nearestEnemyTargetIds) do
			ApplyForce({ Id = id, Speed = GetRequiredForceToEnemy( id, centerId, -traitArgs.DeadZoneRadius, traitArgs.DistanceMultiplier ), Angle = GetAngleBetween({ Id = id, DestinationId = centerId }) })
		end
		wait( traitArgs.Interval, RoomThreadName)
	end
	Destroy({ Id = centerId })
end

function AddTraitResources( args )
	wait(args.Delay)
	for resourceName, resourceAmount in pairs( args.GiftResources ) do
		if resourceName ~= "ReportValues" then
			AddResource( resourceName, resourceAmount, args.Name )
			wait( 0.01 )
		end
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
end

function DemeterCastBlast( weaponData, traitArgs, triggerArgs )
	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY then
		return
	end
	if not MapState.CastStorms then
		MapState.CastStorms = {}
	end	
	local createdProjectiles = {}
	local dataProperties = 
	{
		StartDelay = traitArgs.StartDelay,
		AttachToOwner = false
	}
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY })
	for _, projectileName in pairs( traitArgs.ProjectileNames or {} ) do
		local projectileId = CreateProjectileFromUnit({ Name = projectileName, DestinationId = targetId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true, DataProperties = dataProperties, BlastRadiusModifier = traitArgs.BlastRadiusMultiplier })				
		table.insert(createdProjectiles, projectileId)
	end
	table.insert(MapState.CastStorms, createdProjectiles )
		
	if TableLength( MapState.CastStorms ) > traitArgs.MaxProjectiles then
		ExpireProjectiles({ ProjectileIds = MapState.CastStorms[1] })
		table.remove( MapState.CastStorms, 1)
	end
	Destroy({ Id = targetId })
end

function DemeterSprintBlast ( weaponData, traitArgs, triggerArgs )
	if not MapState.SprintStorms then
		MapState.SprintStorms = {}
	end	
	if IsEmpty(MapState.AttachedStormProjectileIds) then
		MapState.AttachedStormProjectileIds = {}
		local dataProperties = 
		{
			StartDelay = traitArgs.StartDelay
		}
		if traitArgs.TargetId then
			dataProperties.AttachToOwner = false
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
	local detachInterval = traitArgs.DetachInterval or 0.3
	thread( DemeterSprintStormDetach, { Delay = detachInterval, StartTime = _worldTime })
end

function DemeterSprintStormDetach( args )
	args = args or {}
	if args.Delay then
		if SetThreadWait( "DemeterSprintStorm", args.Delay ) then
			RefreshProjectile({ Id = MapState.AttachedStormProjectileIds })
			return
		end
		wait( args.Delay, "DemeterSprintStorm" )
	end

	DetachProjectiles({ Id = MapState.AttachedStormProjectileIds })
	MapState.AttachedStormProjectileIds = nil
end

function ChaosManaDrain( weaponData, traitArgs, triggerArgs )
	ManaDelta(-traitArgs.Cost, { IgnoreSpend = true })
	thread( ChaosManaDrainPresentation )
end

function SprintShieldSetup( hero, traitArgs, args )
	MapState.SprintShields = traitArgs.SprintShields
	MapState.SprintShieldFx = traitArgs.ActiveVfx
end

function MassiveAttackSetup( hero, traitArgs, args )
	args = args or {}
	traitArgs = traitArgs or {}
	if traitArgs.Delay then
		waitUnmodified(traitArgs.Delay)
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
end

function DaggerBlockSetup( hero, args )
	ResetCooldown( "DaggerBlockShield" )
	wait(0.1)
	ShowDaggerUI()
end

function CheckMassiveAttack( victim, functionArgs, triggerArgs )
	if CheckCooldownNoTrigger( functionArgs.Name, functionArgs.Cooldown, true ) and ( not ProjectileHasUnitHit( triggerArgs.ProjectileId, "MassiveAttack") or (triggerArgs.SourceWeapon == nil or (functionArgs.MultihitWeaponWhitelistLookup and functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon]))) then
		local timeSinceCooldown = 100000
		if SessionState.GlobalCooldowns[functionArgs.Name] then 
			timeSinceCooldown = _worldTimeUnmodified - SessionState.GlobalCooldowns[functionArgs.Name] - functionArgs.Cooldown
		end
		CheckCooldown( functionArgs.Name, functionArgs.Cooldown, true ) 
		
		ProjectileRecordUnitHit( triggerArgs.ProjectileId, "MassiveAttack" )
		local attackTrait = GetExistingUITraitName( functionArgs.TraitName )
		if attackTrait then
			TraitUIActivateTrait( attackTrait, {CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / functionArgs.Cooldown })
			thread( MassiveAttackSetup, CurrentRun.Hero, { Delay = functionArgs.Cooldown, TraitName = functionArgs.TraitName })
		end
		local blastModifier = GetTotalHeroTraitValue( "MassiveAttackSizeModifier", { IsMultiplier = true })
		waitUnmodified( functionArgs.BlastDelay or 0 )
		if victim then
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Angle = triggerArgs.ImpactAngle, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, BlastRadiusModifier = blastModifier, FireFromTarget = true })
			if HeroHasTrait("DoubleMassiveAttackBoon") and timeSinceCooldown <= GetTotalHeroTraitValue("DoubleAttackInterval") then
				waitUnmodified( 0.75 )
				CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Angle = triggerArgs.ImpactAngle, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, BlastRadiusModifier = blastModifier, FireFromTarget = true })
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


function PlayerWorldSlowSetup( hero, args )
	thread( PlayerWorldSlow, args )
end

function PlayerWorldSlow( args )
	waitUnmodified(0.3, "PlayerWorldSlowSetup" )
	SessionState.PlayerWorldSlow = false
	local waitInterval = 0.1

	while not CurrentRun.Hero.IsDead do
		waitUnmodified( waitInterval, "PlayerWorldSlow" )
		local isActive = IsMoving({ Id = CurrentRun.Hero.ObjectId }) or AreScreensActive() or not IsInputAllowed({})
		if not isActive and not SessionState.PlayerWorldSlow then
			SessionState.PlayerWorldSlow = true
			GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.TimeSlow, Name = "PlayerWorldSlow" })
		elseif isActive and SessionState.PlayerWorldSlow then
			SessionState.PlayerWorldSlow = false
			GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.TimeSlow, Reverse = true, Name = "PlayerWorldSlow" })
		end
	end
end

function CheckWorldSlowWeapon( triggerArgs, args )
	if triggerArgs.WeaponName and Contains( args.WeaponNames, triggerArgs.WeaponName) then
		SetThreadWait( "PlayerWorldSlow", args.PenaltyDuration)	
		if SessionState.PlayerWorldSlow then
			SessionState.PlayerWorldSlow = false
			GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = functionArgs.Args.TimeSlow, Reverse = true, Name = "PlayerWorldSlow" })
		end	
	end
end

OnPlayerMoveStarted{
	function( args )
		for i, functionArgs in pairs( GetHeroTraitValues("SetupFunction")) do
			if functionArgs.Name == "PlayerWorldSlowSetup" then
				SetThreadWait( "PlayerWorldSlow", 3600 )
				if SessionState.PlayerWorldSlow then
					SessionState.PlayerWorldSlow = false
					GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = functionArgs.Args.TimeSlow, Reverse = true, Name = "PlayerWorldSlow" })
				end
			end
		end
	end
}
OnPlayerMoveStopped{
	function ( args )
		for i, functionArgs in pairs( GetHeroTraitValues("SetupFunction")) do
			if functionArgs.Name == "PlayerWorldSlowSetup" then
				SetThreadWait( "PlayerWorldSlow", functionArgs.Args.ActionPenaltyDuration )
			end
		end
	end
}

function HephaestusArmor( hero, args )
	local sourceTrait = GetHeroTrait("ArmorBoon")
	sourceTrait.CurrentArmor = args.Amount
	AddHealthBuffer( sourceTrait.CurrentArmor, sourceTrait.Name, { Silent = true } )
	thread( UpdateHealthUI )
	UnreserveMana( "HephaestusArmor")
	ReserveMana( args.ManaReservationCost, "HephaestusArmor")
end

function TraitReserveMana( hero, args )
	local name = args.Name or "Trait"
	if args.Name then
		UnreserveMana( args.Name )
	end
	ReserveMana( args.ManaReservationCost, args.Name or "Trait" )
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
	while CurrentRun and CurrentRun.CurrentRoom and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		if IsCombatEncounterActive(CurrentRun) or (not IsEmpty(ActiveEnemies) and (not CurrentRun.CurrentRoom.Encounter or not CurrentRun.CurrentRoom.Encounter.DelayedStart )) then
			local nearbyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true, Distance = 2000 })
			local eligibleEnemies = {}
			for _, id in pairs(nearbyTargetIds) do
				if ActiveEnemies[id] and not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers then
					table.insert(eligibleEnemies, ActiveEnemies[id])
				end
			end
			if TableLength(eligibleEnemies) >= args.Minimum then
				if not MapState.CrowdWeakEnemy or MapState.CrowdWeakEnemy.IsDead or not Contains(eligibleEnemies, MapState.CrowdWeakEnemy)  then
					MapState.CrowdWeakEnemy = GetRandomValue(eligibleEnemies)
				end
				ApplyEffect({ 
					Id = CurrentRun.Hero.ObjectId, 
					DestinationId = MapState.CrowdWeakEnemy.ObjectId, 
					EffectName = args.EffectName,
					DataProperties = EffectData[args.EffectName].EffectData, 
				})
			end
			local nearbyIds = {}
			if args.ProximityThresholdExclusionBoon and HeroHasTrait(args.ProximityThresholdExclusionBoon) then
				nearbyIds = GetAllKeys(ActiveEnemies)
			else
				nearbyIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationNames = {"EnemyTeam"}, Distance = args.Range })
			end
			local hasWeakNearby = false
			for _, id in pairs(nearbyIds) do
				if ActiveEnemies[id] and not ActiveEnemies[id].IsDead and ActiveEnemies[id].ActiveEffects and ActiveEnemies[id].ActiveEffects[args.EffectName] then
					hasWeakNearby = true	
					break
				end
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
			wait(0.3, RoomThreadName)
		end
	end
end

function DaggerLastHitSetup( unit, traitArgs )
	SessionMapState.DaggerLastHit = 0
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
		thread( UpdateHealthUI )
		thread( StaffHealPresentation, traitArgs.CombatText )
	end
end

function GrantRandomManaTrait( functionArgs )
	local eligibleTraits = {}
	local extantTraits = {}
	if	MapState.RoomRequiredObjects then
		for id, loot in pairs( MapState.RoomRequiredObjects ) do
			if loot.UpgradeOptions then
				for i, option in pairs(loot.UpgradeOptions) do
					if option.ItemName then
						extantTraits[option.ItemName] = true
					end
				end
			end
		end
	end
	for i, traitName in pairs(LootData.ManaUpgrade.Traits) do
		if not HeroHasTrait( traitName ) and IsTraitEligible( CurrentRun, TraitData[traitName] ) and not extantTraits[traitName] then
			table.insert(eligibleTraits, traitName )
		end
	end
	local manaTraitName  = GetRandomValue( eligibleTraits )
	if manaTraitName then
		AddTraitToHero({ TraitName = manaTraitName , Rarity = GetRarityKey(functionArgs.RarityBonus)})
		thread( ManaTraitGainedPresentation, manaTraitName )
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
			ManaDelta( refund )
		end
	end
end

function CheckSteam( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName and functionArgs.ValidEffect and triggerArgs.EffectName ~= functionArgs.ValidEffect then
		return
	end
	if victim.ActiveEffects[functionArgs.EffectName] then
		local projectileId = CreateProjectileFromUnit({ Name = "SteamBlast", Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		AttachProjectiles({ Ids = {projectileId}, DestinationId = victim.ObjectId })		
	
		ClearEffect({ Id = victim.ObjectId, Name = functionArgs.EffectName })
	end
end

function FireRallyHeal ( attacker, functionArgs, triggerArgs )
	if triggerArgs.ManuallyTriggered then
		return
	end
	local rallyTraitData = GetHeroTrait("ElementalRallyBoon") 
	if rallyTraitData == nil or not IsGameStateEligible( CurrentRun, rallyTraitData.ActivationRequirements) then
		return
	end
	if not triggerArgs or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 or triggerArgs.PureDamage then
		return
	end
	thread( FireRallyThread, functionArgs, triggerArgs )
end

function FireRallyThread( functionArgs, triggerArgs )
	local threadName = "FireRally"
	killTaggedThreads( threadName )
	wait(0.1)
	local healAmount = round( triggerArgs.DamageAmount * functionArgs.Multiplier )
	local duration = functionArgs.Duration
	local minTickRate = 0.05
	local healPerSecond = duration/ healAmount
	local healthOverflow = 0
	local totalHeal = 0

	while totalHeal < healAmount do
		if healPerSecond < minTickRate then
			wait( minTickRate , threadName)
			local healthRegen, fraction = math.modf( healPerSecond * minTickRate )
			healthOverflow = healthOverflow + fraction
			if healthOverflow >= 1 then
				healthOverflow = healthOverflow - 1
				healthRegen = healthRegen + 1
			end
			totalHeal = totalHeal + healthRegen
			Heal( CurrentRun.Hero, { HealAmount = healthRegen, SourceName = "FireRally", Silent = true })
		else
			wait( duration/healAmount, threadName )
			totalHeal = totalHeal + 1
			Heal( CurrentRun.Hero, { HealAmount = 1, SourceName = "FireRally" })
		end
	end
end

function CheckFireballSpawn(weaponData, functionArgs, triggerArgs )
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier})
	end
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

	local destinationId = SpawnObstacle({ Name = "BlankObstacle", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = projectileData.ReticleGroupName or "FX_Terrain_Top" })		
	if projectileData.ReticleAnimation ~= nil then
		local damageRadius = GetBaseDataValue({ Type = "Projectile", Name = traitArgs.ProjectileName, Property = "DamageRadius" })
		local fuse = GetBaseDataValue({ Type = "Projectile", Name = traitArgs.ProjectileName, Property = "Fuse" })
		SetAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId, ScaleRadius = damageRadius, Group = "FX_Terrain_Top" })
		thread( DestroyOnDelay, { destinationId }, fuse )
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
	Damage( CurrentRun.Hero, { triggeredById = CurrentRun.Hero.ObjectId, DamageAmount = args.Damage, PureDamage = true, } )
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


function CheckPoseidonSplash(victim, functionArgs, triggerArgs )
	if ProjectileHasUnitHit( triggerArgs.ProjectileId, "PoseidonSplash") and (triggerArgs.SourceWeapon == nil or not functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon])  then
		return
	end
	local passesMultihitCheck = true

	if triggerArgs.SourceWeapon ~= nil and functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon] and functionArgs.MultihitWeaponConditions[triggerArgs.SourceWeapon] then
		local conditions = functionArgs.MultihitWeaponConditions[triggerArgs.SourceWeapon]
		if conditions.Cooldown and not CheckCooldown( "PoseidonSplash", conditions.Cooldown ) then
			return
		end
		if conditions.Window and not CheckCountInWindow("PoseidonSplash", conditions.Window, conditions.Count ) then
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

	for i, data in pairs(GetHeroTraitValues("ConeModifier")) do
		if data.ScaleIncrease then
			scale = scale * data.ScaleIncrease
		end
		if data.MaxScale and scale > data.MaxScale then
			scale = data.MaxScale
		end
	end

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
			ImpactVelocity = force
		}
	})
end

function MultiplyCurrentArmor( functionArgs, sourceTrait )
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.CurrentArmor then
			trait.CurrentArmor = math.ceil(trait.CurrentArmor * functionArgs.ArmorMultiplier)
			AddHealthBuffer( trait.CurrentArmor, trait.Name )
		end
	end
	thread( UpdateHealthUI )
end

function HeavyArmorSetup( unit, args )
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = true })
end

function HeavyArmorExpire( flagName )
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = false})
	AddTraitToHero({ TraitName = "HeavyArmorExpired" })
end

function SturdySetup( unit, args )
	args = args or {}
	SetPlayerUninterruptible(args.Name)
end

function StartAxeSturdy( weaponData, args )
	AddIncomingDamageModifier( CurrentRun.Hero,
	{
		Name = "AxeSturdy",
		GlobalMultiplier = args.DamageTakenModifier,
		Temporary = true,
	})
	CreateAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end

function EndAxeSturdy()
	RemoveIncomingDamageModifier( CurrentRun.Hero, "AxeSturdy" )
	StopAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end


function StartLobSturdy( weaponData, args, triggerArgs )
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) then
		return
	end
	AddIncomingDamageModifier( CurrentRun.Hero,
	{
		Name = "LobHammer",
		GlobalMultiplier = args.DamageTakenModifier,
		Temporary = true,
	})
	CreateAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end

function EndLobSturdy()
	RemoveIncomingDamageModifier( CurrentRun.Hero, "LobHammer" )
	StopAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end


function PrepOnHitEmpower( attacker, functionArgs, args )
	if args.ManuallyTriggered then
		return
	end
	local chargingWeapons = {}
	if not SessionState.PrepOnHitEmpowerValidWeaponsLookup then
		local validWeapons = AddLinkedWeapons( functionArgs.ValidWeapons )
		SessionState.PrepOnHitEmpowerValidWeaponsLookup = ToLookup( validWeapons )
	end
	local weaponNames = AddLinkedWeapons( GetAllKeys( CurrentRun.Hero.Weapons ))
	for _, weaponName in pairs( weaponNames ) do
		if GetWeaponChargeFraction({ Name = weaponName }) > 0 and SessionState.PrepOnHitEmpowerValidWeaponsLookup[ weaponName ] then
			chargingWeapons[weaponName] = true
		end
	end
	if IsEmpty(chargingWeapons) then
		return
	end

	if IsEmpty( SessionState.EmpoweredWeapons ) then
		SessionState.EmpoweredWeapons = {}
		for weaponName in pairs( chargingWeapons ) do
				SetWeaponProperty({WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "DamageMultiplier", Value = functionArgs.BonusMultiplier, ValueChangeType = "Add"})
				SessionState.EmpoweredWeapons[ weaponName ] = functionArgs.BonusMultiplier
		end

		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "SelfEmpower", 
			DataProperties = 
			{
				FrontFx = functionArgs.Vfx,
				ClearOnAttack = true,
				Duration = 1000,
			}
		})
	end
end

function PermanentSwitchWeapon( unit, args )
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if unit.Weapons[weaponName] then
			SwapWeapon({ DestinationId = unit.ObjectId, Name = weaponName, SwapWeaponName = args, StompOriginalWeapon = true })
			return
		end
	end
end

function AddBlockEmpower( victim, args, triggerArgs )
	if triggerArgs.WeaponName == args.WeaponName then
		local dataProperties = MergeTables(	EffectData[args.EffectName].DataProperties, args.EffectData)
		ApplyEffect( MergeTables({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = dataProperties }))
	end
end

function CheckClearCastCount( victim, functionArgs, triggerArgs )
	if functionArgs.IsNotEx and IsExWeapon( triggerArgs.SourceWeapon, {Combat = true}, triggerArgs ) then
		return
	end
	if IsEmpty(CurrentRun.Hero.ActiveEffects) or not CurrentRun.Hero.ActiveEffects.ClearCast then
		IncrementTableValue( MapState, "StaffClearCountHits" )
		
		if ScreenAnchors.StaffUIChargeAmount then
			SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.StaffUIChargeAmount, Fraction = MapState.StaffClearCountHits / functionArgs.RequiredCount, Instant = true })
		end
		if MapState.StaffClearCountHits >= functionArgs.RequiredCount then
			MapState.StaffClearCountHits = 0
			RefillMana()
			thread( StartClearCastPresentation )
			local dataProperties = MergeTables(	EffectData[functionArgs.EffectName].DataProperties, functionArgs.DataProperties)
			ApplyEffect( MergeTables({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties }))
		end
	end
end


function CheckClearCastManaRefund( functionArgs, manaDelta )
	if IsEmpty(MapState.ClearCastWeapons) then
		return
	end
	local manaRestored = math.abs(manaDelta)
	CreateAnimation({ Name = functionArgs.AnimationName, DestinationId = CurrentRun.Hero.ObjectId })
	thread( ManaOverTimeRefund, functionArgs.Duration, functionArgs.Interval, manaRestored, true)
end


function CheckDaggerBlock( weaponData, functionArgs )
	if not MapState.DaggerBlockShieldActive and CheckCooldownNoTrigger("DaggerBlockShield", functionArgs.Cooldown ) then
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
		MapState.DaggerBlockShieldActive = true
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
		MapState.DaggerCharges = MapState.DaggerCharges - 1

		if MapState.DaggerCharges <= 0 then
			local traitData = GetHeroTrait("DaggerBlockAspect")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			thread( DaggerBlockClearedPresentation, chargeFunctionArgs )
		
		end
	end
end

function DropOriginMarker( weaponData, functionArgs, triggerArgs )
	MapState.OriginMarkers = MapState.OriginMarkers or {}
	MapState.OriginMarkers[weaponData.Name] = MapState.OriginMarkers[weaponData.Name] or {}
	local originMarkerId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Terrain", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, OffsetZ = 90 })
	SetAnimation({ Name = functionArgs.AnimationName, DestinationId = originMarkerId })
	MapState.OriginMarkers[weaponData.Name][triggerArgs.ProjectileVolley] = originMarkerId
end

function ClearOriginMarker( triggerArgs, functionArgs )
	if triggerArgs.FireEndProjectile and triggerArgs.WeaponName and MapState.OriginMarkers and MapState.OriginMarkers[triggerArgs.WeaponName] then
		local id = MapState.OriginMarkers[triggerArgs.WeaponName][triggerArgs.ProjectileVolley]
		MapState.OriginMarkers[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil

		SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
		thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	end
end

function CheckWeaponFullManaFire( weaponData, functionArgs, triggerArgs )
	if MapState.FullManaAtFireStart[weaponData.Name]  then
		MapState.FullManaVolleys = MapState.FullManaVolleys or {}
		MapState.FullManaVolleys[weaponData.Name] = MapState.FullManaVolleys[weaponData.Name] or {}
		if triggerArgs.ProjectileVolley then
			IncrementTableValue(MapState.FullManaVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		end
	end
end

function RemoveWeaponFullManaFire(triggerArgs)
	if triggerArgs.WeaponName and MapState.FullManaVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( MapState.FullManaVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if MapState.FullManaVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			MapState.FullManaVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckWeaponAmmoFire( weaponData, functionArgs, triggerArgs )
	if SessionMapState.AmmoAtFireStart then
		if triggerArgs.ProjectileVolley then
			SessionMapState.AmmoVolleys[ triggerArgs.ProjectileVolley ] = { AmmoCount = SessionMapState.AmmoAtFireStart, Count = triggerArgs.NumProjectiles }
		end
	end
end

function RemoveWeaponAmmoFire(triggerArgs)
	if SessionMapState.AmmoVolleys and SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley] then
		SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count = SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count - 1
		if SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count <= 0 then
			SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley] = nil
		end
	end
end
function SetupClearCastUI()	
	wait(0.1)
	ShowStaffUI()
end

function SetupPerfectCritUI()	
	wait(0.1)
	ShowAxeUI()
end


function SetupSkullImpulseUI()	
	wait(0.1)
	ShowTorchUI()
end


function ApplyDashKnockup( victim, functionArgs, triggerArgs )
	local immuneToForce = GetThingDataValue({ Id = victim.ObjectId, Property = "ImmuneToForce" })
	if not immuneToForce and victim.ResetOnTouchdown == nil then
		ApplyUpwardForce({ Id = victim.ObjectId, Speed = functionArgs.Force, SelfApplied = false })
	end
end

function ConvertArmorToHealth( trait ) 

	local sourceTraits = {}
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.CostumeTrait and traitData.CurrentArmor > 0 then
			table.insert(sourceTraits, traitData)
		end
	end
	if IsEmpty ( sourceTraits ) then
		return
	end
	local lostTraits = {}
	local maxHealthGained = CurrentRun.Hero.HealthBuffer
	while not IsEmpty(sourceTraits) do
	
		local topSourceTrait = sourceTraits[1]
		topSourceTrait.CurrentArmor = 0
		if not topSourceTrait.Invincible then
			table.insert( lostTraits, topSourceTrait )
			thread( TraitSacrificedPresentation, topSourceTrait )
			RemoveTraitData( CurrentRun.Hero, topSourceTrait)
		end
		RemoveValueAndCollapse( sourceTraits, topSourceTrait )
	end
	CurrentRun.Hero.HealthBuffer = 0
	trait.GrantedHealth = maxHealthGained
	trait.TrayStatLines = { "BonusLifeStatDisplay1" }
	AddMaxHealth( maxHealthGained, "ArmorConversionKeepsake", {Silent = true})
	-- thread( PlayerArmorConversionPresentation, lostTraits, maxHealthGained )
	
	ReduceTraitUses( trait, {Force = true })
end

function CheckSpawnZeusDamage( enemy, traitArgs )
	if enemy.IsBoss or enemy.UseBossHealthBar or not RandomChance(traitArgs.Chance) then
		return
	end
	local damageAmount = traitArgs.Damage
	thread( DoZeusSpawnDamage, enemy, traitArgs, damageAmount )
end
function DoZeusSpawnDamage( enemy, traitArgs, damageAmount )
	LoadVoiceBanks("Zeus")
	wait(0.1, RoomThreadName )
	CreateAnimation({ Name = traitArgs.Vfx, DestinationId = enemy.ObjectId, Group = "FX_Standing_Top" })
	thread( SpawnKillPresentation, enemy )
	thread( Damage, enemy, { SourceProjectile = "ZeusOnSpawn", DamageAmount = damageAmount, Silent = false, PureDamage = true, IgnoreHealthBuffer = true } )
end

function CheckSpawnCurseDamage( enemy, traitArgs )
	if enemy.IsBoss or enemy.UseBossHealthBar or enemy.IgnoreCurseDamage or enemy.AlwaysTraitor then
		return
	end
	local damageAmount = 0
	for _, data in ipairs(traitArgs.DamageArgs) do
		if not data.Chance or RandomChance(data.Chance) then
			damageAmount = RandomInt( data.MinDamage, data.MaxDamage )
			break
		end
	end
	thread( DoCurseDamage, enemy, traitArgs, damageAmount )
end

function CheckSpawnArmorDamage( enemy, traitArgs )
	local damageAmount = 0
	if enemy.HealthBuffer then
		damageAmount = enemy.HealthBuffer * traitArgs.Multiplier
	end
	thread( DoCurseDamage, enemy, traitArgs, damageAmount )
end

function CurseRetaliate( functionArgs, triggerArgs )
	local enemy = triggerArgs.AttackerTable
	if not enemy or not enemy.Health then
		return 
	end
	local damageAmount = enemy.Health * functionArgs.HealthDamageMultiplier
	thread( DoCurseDamage, enemy, functionArgs, damageAmount )
end

function DoCurseDamage( enemy, traitArgs, damageAmount )
	wait(0.1, RoomThreadName )
	CreateAnimation({ Name = traitArgs.Vfx, DestinationId = enemy.ObjectId, Group = "FX_Standing_Top" })
	thread( Damage, enemy, { SourceProjectile = "MedeaCurse", DamageAmount = damageAmount, Silent = false, PureDamage = true } )
end

function StartHitShield( hero, args )
	CreateAnimation({ Name = args.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
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
		thread( HammerKeepsakeAcquiredPresentation, newTrait.Name )
	end
end
function AddRandomHammer( args )
	local eligibleTraits = {}
	for i, traitName in pairs( LootData.WeaponUpgrade.Traits) do
		if IsTraitEligible( CurrentRun, TraitData[traitName]) and not HeroHasTrait( traitName ) then
			table.insert(eligibleTraits, traitName )
		end
	end
	local traitName = GetRandomValue( eligibleTraits )
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	traitData.RemainingUses = args.Duration
	traitData.UsesAsEncounters = true
	traitData.OnExpire = { FunctionName = "HammerKeepsakeLostPresentation", FunctionArgs = traitName }
	AddTraitToHero({ TraitData = traitData, SkipUIUpdate = true })
	return traitData
end

function ChaosBlessingBonus( args, traitData )
	if not CurrentRun.Hero.IsDead then
		local newTrait = AddRandomChaosBlessing( GetRarityKey(args.BlessingRarity) )
		thread( ChaosKeepsakeAcquiredPresentation, newTrait.Name )
	end
end

function AddRandomChaosBlessing( rarityName )
	local eligibleTraits = {}
	for i, traitName in pairs( LootData.TrialUpgrade.PermanentTraits) do
		if IsTraitEligible( CurrentRun, TraitData[traitName]) and TraitData[traitName].RarityLevels and TraitData[traitName].RarityLevels[rarityName] then
			table.insert(eligibleTraits, traitName )
		end
	end

	local traitName = GetRandomValue( eligibleTraits )
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = rarityName })
	traitData.CustomTitle = "ChaosCombo_ChaosKeepsakePrefix_"..traitName
	traitData.FromChaosKeepsake = true
	AddTraitToHero({ TraitData = traitData })
	return traitData
end

function OutOfCombatRegenSetup( hero, args )
	thread( OutOfCombatRegen, hero, args )
end

function OutOfCombatRegen( unit, functionArgs, triggerArgs)
	if not HeroHasTrait("CoverRegenerationBoon") then
		return
	end
	if SetThreadWait( "CoverRegen", functionArgs.Timeout) then
		return
	end
	waitUnmodified( functionArgs.Timeout, "CoverRegen" )
	if functionArgs.RegenStartFx then
		CreateAnimation({ Name = functionArgs.RegenStartFx, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
	end
	if functionArgs.RegenStartSound then
		PlaySound({ Name = functionArgs.RegenStartSound, Id = CurrentRun.Hero.ObjectId })
	end
	while not CurrentRun.Hero.IsDead do
		Heal( CurrentRun.Hero, {HealAmount = 1, SourceName = "CoverRegen", Silent = true })
		thread(UpdateHealthUI)
		waitUnmodified( 1 / (functionArgs.Regen * CalculateHealingMultiplier()), "CoverRegenLooping" )
	end
end

function InterruptRegen(victim, triggerArgs)
	if HeroHasTrait("CoverRegenerationBoon") then
		killTaggedThreads("CoverRegenLooping")
		local trait = GetHeroTrait("CoverRegenerationBoon")
		thread( OutOfCombatRegen, CurrentRun.Hero, trait.SetupFunction.Args )
	end
end

function CacheCurrentLifestealUses( unit, args)

	for i, modifierData in pairs( unit.OutgoingLifestealModifiers ) do
		if modifierData.LimitedUse then
			CurrentRun.LifestealUses = modifierData.LimitedUse
			local trait = GetHeroTrait("HadesLifestealBoon")
			trait.RemainingUses = CurrentRun.LifestealUses
			UpdateTraitNumber( trait )
			return
		end
	end
	if not CurrentRun.LifestealUses then
		local trait = GetHeroTrait("HadesLifestealBoon")
		trait.RemainingUses = CurrentRun.LifestealUses
		CurrentRun.LifestealUses = trait.AddOutgoingDamageModifier.LimitedUse
		UpdateTraitNumber( trait )
	end
end



function SetupHadesCast( unit, args )
	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponCastProjectileHades", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end

function AttachCastAtLocation( triggerArgs )
	if triggerArgs.LocationX and triggerArgs.LocationY then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		if triggerArgs.triggeredById and ActiveEnemies[triggerArgs.triggeredById] and not ActiveEnemies[triggerArgs.triggeredById].SkipModifiers then
			FireWeaponFromUnit({ Weapon = "WeaponCast", AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = triggerArgs.triggeredById, FireFromTarget = true, Angle = fireAngle })
		else
			FireWeaponFromUnit({ Weapon = "WeaponCast", AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
		end
		Destroy({Id = dropLocation })
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
	if not unit or not unit.Health or unit.Health < 0 or not CheckCooldown( "HadesRetaliate", args.Cooldown ) then
		return
	end
	if triggerArgs.Victim ~= CurrentRun.Hero then
		return
	end
	local dataProperties = MergeTables(	EffectData[args.EffectName].EffectData, args.EffectData )
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = dataProperties })
	thread( HadesInvisibility )
	
	local traitData = GetHeroTrait("HadesInvisibilityRetaliateBoon")
	local functionArgs = traitData.OnSelfDamagedFunction.FunctionArgs
	if traitData then
		TraitUIActivateTrait( traitData , { CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / functionArgs.Cooldown})
	end			
end


function HadesInvisibility()
	SetPlayerNotStopsProjectiles("HadesShout")
	SetPlayerInvulnerable("HadesShout")
	SetPlayerFade({ Flag = "HadesShout", Fraction = 0.4, Duration = 0.3 })
	CurrentRun.Hero.Invisible = true
	CurrentRun.CurrentRoom.InvisTargetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = "HadesDisappear_Player", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.6 })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "Invisible_CombatText", 0.85, { SkipFlash = true, PreDelay = RandomFloat(0.1, 0.15), SkipShadow = true } )
	for enemyId, enemy in pairs(ActiveEnemies) do
		if not enemy.SkipModifiers then
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


function CheckWeaponInvisibleFire( weaponData, functionArgs, triggerArgs )
	if CurrentRun.Hero.ActiveEffects.HadesInvisible then
		MapState.InvisibleVolleys = MapState.InvisibleVolleys or {}
		MapState.InvisibleVolleys[weaponData.Name] = MapState.InvisibleVolleys[weaponData.Name] or {}
		if triggerArgs.ProjectileVolley then
			IncrementTableValue(MapState.InvisibleVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		end
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HadesInvisible" })
		InvisBreakPresentation()
	end
end

function RemoveWeaponInvisibleFire(triggerArgs)
	if triggerArgs.WeaponName and MapState.InvisibleVolleys and MapState.InvisibleVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( MapState.InvisibleVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if MapState.InvisibleVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			MapState.InvisibleVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function HadesInvisibleClear()
	notifyExistingWaiters("StealthBroken")
end

function StartExBurn( weaponData, args )
	wait(args.StartDelay)
	while MapState.ChargedManaWeapons[weaponData.Name] ~= nil do
		if args.Fx then
			CreateAnimation({ Name = args.Fx, DestinationId = CurrentRun.Hero.ObjectId, ScaleRadius = args.Range })
		end
		local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", PreciseCollision = true, ScaleY = 0.5, IgnoreInvulnerable = true, Distance = args.Range })
		for _, id in pairs( nearestEnemyTargetIds ) do
			local enemy = ActiveEnemies[id]
			if enemy ~= nil and not enemy.IsDead then
				ApplyBurn( enemy, args )
			end
		end
		wait(args.Interval)
	end
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

function SetupExShields( hero, args )

	if not HeroHasTrait("ExShieldMetaUpgrade") then
		return
	end
	local shieldTrait = GetHeroTrait("ExShieldMetaUpgrade")
	if not shieldTrait.RemainingUses or shieldTrait.RemainingUses <= 0 then
		return
	end

	MapState.ExShieldTriggers = shieldTrait.RemainingUses
	MapState.ExShieldFx = args.Fx
	MapState.ExShieldWeapons = ToLookup( AddLinkedWeapons(args.ValidWeapons ))
end

function CheckAxeCastArm( triggerArgs, args )
	local intersectionProjectiles = GetInProjectilesBlast({ ProjectileId = triggerArgs.ProjectileId, DestinationName = "ProjectileCast", UseDamageRadius = true })
	if not IsEmpty(intersectionProjectiles) then
		ArmAndDetonateProjectiles({ Ids = intersectionProjectiles, BlastMultiplier = args.BlastMultiplier })
		for _, projectileId in pairs( intersectionProjectiles) do
			SessionState.ValidProjectileIds[ projectileId ] = true
			if not IsEmpty(SessionMapState.CastAttachedProjectiles[projectileId]) then
				ExpireProjectiles({ ProjectileIds = SessionMapState.CastAttachedProjectiles[projectileId] })
			end
		end
	end
end

function CheckStaffSelfHit( triggerArgs, args )
	if not IsEmpty( GetInProjectilesBlast({ Id = CurrentRun.Hero.ObjectId, DestinationName = args.ProjectileName })) then
		if (CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth) <= args.Threshold then
			Heal( CurrentRun.Hero, {HealAmount = args.HealAmount, SourceName = "Aspect" })
		end
	end
end

function CheckPerfectAxeCrit( victim, args, triggerArgs )
	if not IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		return
	end
	local trait = GetHeroTrait( "AxePerfectCriticalAspect")
	trait.PerfectCritChance = math.min( args.MaxCrit,  trait.PerfectCritChance + args.Increment )
	UpdateAxeUI( trait )
end

function ResetPerfectAxeCrit( attacker, args, triggerArgs )
	if triggerArgs.ManuallyTriggered or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 then
		return
	end
	local trait = GetHeroTrait( "AxePerfectCriticalAspect")
	trait.PerfectCritChance = 0
	UpdateAxeUI( trait )
end

function ChargeSkullImpulse( victim, args, triggerArgs )
	if not triggerArgs.DamageAmount or SessionMapState.ActiveSkullImpulse or triggerArgs.SourceProjectile == args.BlockedProjectile then
		return
	end
	if triggerArgs.SourceWeapon == args.BlockedWeapon and IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		return
	end
	local damageAmount = triggerArgs.DamageAmount
	local trait = GetHeroTrait( "LobImpulseAspect")
	local prevCharge = trait.Charge
	trait.Charge = math.min(args.MaxCharge, trait.Charge + damageAmount * args.ChargePerDamage)
	if prevCharge < args.MaxCharge and  trait.Charge >= args.MaxCharge and ScreenAnchors.TorchUI then	
		SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.TorchUI, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	end
	UpdateTorchUI( trait )
end

function CheckSkullImpulseStart()
	local trait = GetHeroTrait( "LobImpulseAspect")
	
	if GetUnitProperty({ Id = CurrentRun.Hero.ObjectId, Property = "AllowAnyFire" }) and trait.Charge >= trait.OnEnemyDamagedAction.Args.MinChargeToFire then
		FireWeaponFromUnit({ Weapon = "WeaponSkullImpulse", Id = CurrentRun.Hero.ObjectId }) 
		SessionMapState.ActiveSkullImpulse = true
	end
end

function SkullImpulseTransform( weaponData, functionArgs, triggerArgs )
	local trait = GetHeroTrait( "LobImpulseAspect")
	local tickRate = 0.1
	MapState.ThrowWeaponInterval = functionArgs.Interval
	local currentTime = _worldTimeUnmodified
	
		SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.TorchUI })
	while trait.Charge > 0 do
		-- Wait isn't super accurate for this
		trait.Charge = trait.Charge - (_worldTimeUnmodified  - currentTime)
		currentTime = _worldTimeUnmodified
		UpdateTorchUI( trait )
		waitUnmodified(tickRate)
	end
	
	if HeroHasTrait("LobSturdySpecialTrait") then
		EndLobSturdy()
	end
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	trait.Charge = 0
	UpdateTorchUI( trait )
end

OnRamWeaponComplete{ "WeaponSkullImpulse",
	function(triggerArgs) 
		SessionMapState.ActiveSkullImpulse = nil
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

function CheckTorchRepeatStrike( triggerArgs, functionArgs )
	if MapState.TorchDetonations and MapState.TorchDetonations > 0 and functionArgs[triggerArgs.name] and triggerArgs.LocationX and triggerArgs.LocationY then
		
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = functionArgs[triggerArgs.name],
			WeaponName = triggerArgs.WeaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		derivedValues.PropertyChanges.MaxDetonations = MapState.TorchDetonations
		CreateProjectileFromUnit({ WeaponName = triggerArgs.WeaponName, Name = functionArgs[triggerArgs.name], Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
		Destroy({Id = dropLocation })

		MapState.TorchDetonations = 0
	end
end

function TorchSprintRecall( functionArgs )
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponTorch", Method = "RecallProjectiles" })
end

function RecordSecondStageApolloCast(victim, functionArgs, triggerArgs )
	thread( CreateZeusBolt, {
		TargetId = victim.ObjectId,
		WeaponName = "WeaponCast",
		ProjectileName = functionArgs.ProjectileName, 
		DamageMultiplier = functionArgs.DamageMultiplier,
		InitialDelay = 0,
		Delay = 0.1 })
end

function CheckArmedApolloCast( triggerArgs, functionArgs )
	if triggerArgs.name == functionArgs.ValidProjectileName and triggerArgs.Armed and triggerArgs.LocationX and triggerArgs.LocationY and triggerArgs.Detonated then
		
		local modifier = GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "BlastRadiusModifier" })
		
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = functionArgs.ProjectileName,
			WeaponName = triggerArgs.WeaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		local projectileId = CreateProjectileFromUnit({ 
			WeaponName = triggerArgs.WeaponName, Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true,
			BlastRadiusModifier = modifier, DamageMultiplier = functionArgs.DamageMultiplier, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
		if triggerArgs.ProjectileId and SessionMapState.MarkedEnemies[triggerArgs.ProjectileId] then
			SessionMapState.MarkedEnemies[projectileId] = DeepCopyTable(SessionMapState.MarkedEnemies[triggerArgs.ProjectileId])
			SessionMapState.MarkedEnemies[triggerArgs.ProjectileId] = nil
		end
		Destroy({Id = dropLocation })	
	end
end

function MultiplySameRoomRewards( args, trait )
	for id, data in pairs(MapState.RoomRequiredObjects) do
		if data.Name == args.Name and data.AddMaxHealth then
			MapState.RoomRequiredObjects[id].AddMaxHealth = round( data.AddMaxHealth * trait.HealthRewardBonus )
		end
	end
end

function CheckProjectileSpawn( triggerArgs, functionArgs )
	if triggerArgs.BlockSpawns then
		return
	end
	functionArgs = functionArgs or {}
	local damageMultiplier = functionArgs.DamageMultiplier or 1
	local spawnCount = functionArgs.SpawnCount or 1
	local matchProjectileName = true
	if functionArgs.MatchProjectileName ~= null then
		matchProjectileName = functionArgs.MatchProjectileName 
	end
	if triggerArgs.LocationX and triggerArgs.LocationY then
		
		local projectileName = functionArgs.ProjectileName
		local propertyChangeProjectileName = projectileName
		if not projectileName and functionArgs.ProjectileNameMap then
			projectileName =  functionArgs.ProjectileNameMap[ triggerArgs.name ]
		end

		if functionArgs.UseOriginalProjectileForPropertyChanges then
			propertyChangeProjectileName = triggerArgs.name
		else
			propertyChangeProjectileName = projectileName
		end

		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = propertyChangeProjectileName,
			WeaponName = triggerArgs.WeaponName ,
			Type = "Projectile",
			MatchProjectileName = matchProjectileName,
		})
		local impactIgnore = nil
		if functionArgs.IgnoreImpactId then
			impactIgnore = triggerArgs.triggeredById
		end
		local angle = triggerArgs.Angle
		local angleIncrement = 0
		if spawnCount > 1 then
			if functionArgs.SpawnArc then
				angle = angle - functionArgs.SpawnArc /2 
			end
			angleIncrement = functionArgs.SpawnArc / ( spawnCount - 1 )
		end
		for i = 1, spawnCount do
			CreateProjectileFromUnit({ 
				WeaponName = triggerArgs.WeaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
				DamageMultiplier = damageMultiplier, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
				HitByImpactId = impactIgnore,
				Angle = angle + (i - 1) * angleIncrement })
		end
		Destroy({Id = dropLocation })	
	end
end

function CheckManaBurst( traitArgs, manaDelta )
	IncrementTableValue( SessionMapState, "BurstCounter", math.abs(manaDelta))
	if SessionMapState.BurstCounter >= traitArgs.ManaCost then
		local totalBursts = 1 + GetTotalHeroTraitValue("BurstCount") 
		for i = 1, totalBursts do
			CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
				DamageMultiplier = traitArgs.DamageMultiplier, Angle = i * 360/totalBursts })
		end
		SessionMapState.BurstCounter = 0
	end
end

function AddTalentPoints( args, traitData)
	IncrementTableValue( CurrentRun, "NumTalentPoints", args.Count )
end
function RemoveLeapCritVolley(triggerArgs)
	if triggerArgs.WeaponName and MapState.LeapCritVolleys and MapState.LeapCritVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( MapState.LeapCritVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if MapState.LeapCritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			MapState.LeapCritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckLeapCritCharges( weaponData, functionArgs, triggerArgs )
	if MapState.LeapCritCharges and MapState.LeapCritCharges >= 1 and triggerArgs.ProjectileVolley and triggerArgs.NumProjectiles then
		MapState.LeapCritVolleys[weaponData.Name] = MapState.LeapCritVolleys[weaponData.Name] or {}
		IncrementTableValue(MapState.LeapCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		MapState.LeapCritCharges = MapState.LeapCritCharges - 1

		if MapState.LeapCritCharges <= 0 then
			local traitData = GetHeroTrait("LeapCritTalent")
			if traitData.LeapCritVfx then
				StopAnimation({ Name = traitData.LeapCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
end


function TimedBuffSetup( hero, args )
	local traitData = GetHeroTrait("TimedBuffKeepsake")
	if hero.IsDead or ( traitData.CurrentTime and traitData.CurrentTime <= 0 ) then
		return
	end
	local totalSpeedChange = args.Multiplier or 1
	if totalSpeedChange ~= 1 then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier * totalSpeedChange
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
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier / totalSpeedChange
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
		if ActiveEnemies[id] and not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers then
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
	wait( args.Delay or 0 , RoomThreadName )
	local effectName = "ArtemisBoonHuntersMark"
	while CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.Hero ~= nil and not CurrentRun.Hero.IsDead do
		if (IsCombatEncounterActive(CurrentRun) or (not IsEmpty(ActiveEnemies) and (not CurrentRun.CurrentRoom.Encounter or not CurrentRun.CurrentRoom.Encounter.DelayedStart ))) then
			local eligibleTargets = {}
			for id, enemy in pairs(ActiveEnemies) do
				if not enemy.IsDead and not enemy.SkipModifiers and not enemy.AlwaysTraitor then
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
				wait( args.Interval, RoomThreadName )
			else
				wait( 0.1, RoomThreadName )
			end
		else
			wait( 0.1, RoomThreadName )
		end
	end
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
	while MapState.AttachedBallProjectileId do
		local playerFacing = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		local offset = CalcOffset( math.rad( playerFacing + 180 ), functionArgs.Offset )
		SetAngle({ ProjectileId = MapState.AttachedBallProjectileId, Angle = math.rad(playerFacing) })
		if GetDistance({ Id = MapState.AttachedStormTargetId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y }) < speed * interval then
			Move({ Id = MapState.AttachedStormTargetId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, Duration = interval })
		else
			Move({ Id = MapState.AttachedStormTargetId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, Speed = speed })
		end
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

function PoseidonSprintBlastDetach( functionArgs, finalAngle )

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