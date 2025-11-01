function GetExistingAnimationPriority( unit, excludeEffectNames )
	excludeEffectNames = excludeEffectNames or {}
	local effectNamesLookup = ToLookup(excludeEffectNames)
	local currentAnimationPriority = 9999
	if unit.ActiveEffects and unit.StunAnimationOrder then
		for existingEffectName in pairs( unit.ActiveEffects ) do
			if not effectNamesLookup[existingEffectName] and existingEffectName ~= effectName and EffectData[existingEffectName] and EffectData[existingEffectName].StunAnimationType then
				local animationPriority = unit.StunAnimationOrder[ EffectData[existingEffectName].StunAnimationType ]
				if animationPriority < currentAnimationPriority then
					currentAnimationPriority = animationPriority
				end
			end
		end
	end
	return nil
end

function CheckStunAnimation( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local effectData = EffectData[effectName]
	
	if not effectData or not effectData.StunAnimationType then
		return
	end

	if IsEmpty( victim.StunAnimations ) then
		return
	end

	local existingAnimation = { effectName }
	if triggerArgs.Reapplied then
		existingAnimation = {}
	end
	local existingAnimationPriority = GetExistingAnimationPriority( victim, existingAnimation ) or 9999
	local newAnimationPriority = victim.StunAnimationOrder[effectData.StunAnimationType ] or 9999
	if existingAnimationPriority < newAnimationPriority then
		return
	end
	
	if not victim.HealthBuffer or victim.HealthBuffer <= 0 or effectData.StunThroughHealthBuffer then
		if victim.EndThreadWaitsOnStun then
			SetThreadWait(victim.AIThreadName, 0.01)
		end

		if victim.StunAnimations[effectData.StunAnimationType] then
			SetAnimation({ Name = victim.StunAnimations[effectData.StunAnimationType], DestinationId = victim.ObjectId })
		elseif victim.StunAnimations.Default then
			SetAnimation({ Name = victim.StunAnimations.Default, DestinationId = victim.ObjectId })
		end
	end
end


function CheckInvulnerableFalloff( triggerArgs )
	local showFalloffWarning = IsCombatEncounterActive(CurrentRun) or not IsEmpty( RequiredKillEnemies ) or not IsEmpty( MapState.AggroedUnits )
	thread( EncounterInvulnerableFalloffWarning, triggerArgs.EffectName, showFalloffWarning)
end

function EncounterInvulnerableFalloffWarning( effectName, showFalloffWarning )
	local threadName = "EncounterInvulnerabilityFalloff"
	if HasThread( threadName ) then
		killTaggedThreads( threadName )
		waitUnmodified(0.1)
	end
	local duration = GetTotalHeroTraitValue( "EncounterStartInvulnerabilityDuration")
	if showFalloffWarning then
		wait( duration - 3, "EncounterInvulnerabilityFalloff" )
		thread(EncounterStartInvulnerableWarnPresentation)
		wait(1, "EncounterInvulnerabilityFalloff")
		thread(EncounterStartInvulnerableWarnPresentation)
		wait(1, "EncounterInvulnerabilityFalloff")
		thread(EncounterStartInvulnerableWarnPresentation)
		wait(1, "EncounterInvulnerabilityFalloff")
	else
		wait( duration, "EncounterInvulnerabilityFalloff" )
	end
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = effectName })
end

function DamageEchoApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local victim = triggerArgs.Victim
		local effectName = triggerArgs.EffectName
		local effectData = EffectData[effectName]
		victim.ActiveEchoes = victim.ActiveEchoes or {}
		victim.ActiveEchoes[effectName] = 
		{ 
			Threshold = effectData.EffectData.DamageThreshold,
			Payoff = triggerArgs.Modifier, 
			Cooldown = effectData.Cooldown,
			Amount = 0 
		}
	end
end

function DamageEchoClear( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local echoData = victim.ActiveEchoes[effectName]
	if echoData and echoData.Amount < echoData.Threshold then
		DamageEchoTrigger( victim, effectName, echoData.Payoff )
	end
	victim.ActiveEchoes[effectName] = nil
end

function DamageEchoProcess( enemy, triggerArgs )

	if triggerArgs.EffectName then
		local effectData = EffectData[triggerArgs.EffectName]
		if effectData and effectData.EffectData and effectData.EffectData.DamageThreshold then
			return
		end
	end	

	if enemy and not enemy.IsDead and enemy.ActiveEchoes then
		local damageAmount = triggerArgs.DamageAmount
		for effectName, echoData in pairs(enemy.ActiveEchoes) do
			echoData.Amount = echoData.Amount + damageAmount
			if echoData.Amount >= echoData.Threshold then
				local damageMultiplier = 1
				if IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
					damageMultiplier = damageMultiplier * GetTotalHeroTraitValue( "DamageEchoOmegaDamageBonus", { IsMultiplier = true })
				end
				DamageEchoTrigger( enemy, effectName, echoData.Payoff, damageMultiplier, echoData.Cooldown)
				CheckTriggerAllDamageEcho( enemy )
			end
		end
	end
end

function CharmApply( triggerArgs )
	local victim = triggerArgs.Victim
	victim.Charmed = true
end

function CharmClear( triggerArgs )
	local victim = triggerArgs.Victim
	victim.Charmed = nil
end

function CheckOmegaBlitzTrigger ( victim, functionArgs, triggerArgs )
	if IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) and victim and not victim.IsDead and victim.ActiveEchoes and victim.ActiveEffectsAtDamageStart and victim.ActiveEffectsAtDamageStart.DamageEchoEffect then	
		for effectName, echoData in pairs(victim.ActiveEchoes) do
			echoData.Amount = echoData.Threshold
			DamageEchoTrigger( victim, effectName, echoData.Payoff, GetTotalHeroTraitValue( "DamageEchoOmegaDamageBonus", { IsMultiplier = true }), echoData.Cooldown )
			CheckTriggerAllDamageEcho( victim )
		end
	end
end
function CheckSprintBlitz ( weaponData, functionArgs, triggerArgs )
	local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = functionArgs.Range })
		
	for _, enemyId in pairs( nearestEnemyTargetIds ) do
		if ActiveEnemies[enemyId] then
			local victim = ActiveEnemies[enemyId]
			if victim and not victim.IsDead and victim.ActiveEchoes then	
				for effectName, echoData in pairs(victim.ActiveEchoes) do
					echoData.Amount = echoData.Threshold
					DamageEchoTrigger( victim, effectName, echoData.Payoff, functionArgs.DamageMultiplier, echoData.Cooldown )
					CheckTriggerAllDamageEcho( victim )
				end
			end
		end
	end
end

function CheckTriggerAllDamageEcho( ignoreUnit )
	if not HeroHasTrait("EchoAllBoon") then
		return
	end
	for _, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if not enemy.IsDead and not IsEmpty(enemy.ActiveEchoes) and enemy ~= ignoreUnit then
			local echoData = GetFirstValue(enemy.ActiveEchoes)
			local effectName = GetFirstKey(enemy.ActiveEchoes)
			DamageEchoTrigger(enemy, effectName, echoData.Payoff, echoData.Cooldown)
		end
	end
end
function RemoveEffectBlockOnDelay( id, delay, effectName )
	wait( delay, RoomThreadName )
	RemoveEffectBlock({ Id = id, Name = effectName })
end

function RemoveEffectOnDelay( id, delay, effectName )
	wait( delay, RoomThreadName )
	ClearEffect({ Id = id, Name = effectName })
end

function DamageEchoTrigger( enemy, effectName, damageMultiplier, additiveDamageMultiplier, cooldown )

	if enemy and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) then
		CreateAnimation({ Name = "ZeusEchoDebuffSwell", DestinationId = enemy.ObjectId, Scale = enemy.EffectVfxScale  })
		additiveDamageMultiplier = additiveDamageMultiplier or 1
		enemy.QueuedDamageMultipliers[EffectData[effectName].ProjectileName] = additiveDamageMultiplier

		thread( CreateZeusBolt, {
			SourceId = CurrentRun.Hero.ObjectId,
			TargetId = enemy.ObjectId,
			Range = 1, 
			SeekTarget = true, 
			ProjectileName = EffectData[effectName].ProjectileName, 
			DamageMultiplier = damageMultiplier,
			Delay = 0.45, 
			Count = 1
		})
		ApplyEffect({ DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "DamageEchoVulnerabilityPlaceholder", DataProperties = EffectData.DamageEchoVulnerabilityPlaceholder.DataProperties })
		ClearEffect({ Id = enemy.ObjectId, Name = effectName })
		if cooldown then
			AddEffectBlock({ Id = enemy.ObjectId, Name = effectName })
			thread( RemoveEffectBlockOnDelay, enemy.ObjectId, cooldown, effectName )
			thread( RemoveEffectOnDelay, enemy.ObjectId, cooldown, "DamageEchoVulnerabilityPlaceholder")
		end
	end
end

function ProcessDamageShare( victim, triggerArgs)
	if triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].IgnoreDamageShare then
		return
	end
	if victim.DamageShareAmount and HasEffectWithEffectGroup( victim, "DamageShare") and not triggerArgs.PureDamage and not IsEmpty(ActiveEnemies) and ( not victim.SkipModifiers or victim.TrainingTarget) then
		local range = EffectData.DamageShareEffect.Range
		local damageAmount = triggerArgs.DamageAmount * victim.DamageShareAmount		
		for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy and victim and enemy ~= victim and not enemy.IsDead and not enemy.AlwaysTraitor and not IsInvulnerable({ Id = enemy.ObjectId })
				and HasEffectWithEffectGroup( enemy, "DamageShare") and GetDistance({ Id = victim.ObjectId, DestinationId = enemy.ObjectId}) <= range then
				CreateAnimationsBetween({ 
					Animation = "HeraRope", DestinationId = enemy.ObjectId, Id = victim.ObjectId, 
					Stretch = true, UseZLocation = false})
				thread( Damage, enemy, { EffectName = "DamageShareEffect", DamageAmount = damageAmount, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true, ImpactAngle = triggerArgs.ImpactAngle or 0 } )
			end
			wait(0.02)
		end
	end
end


function CheckPoseidonFont( victim, triggerArgs )
	local effectData = EffectData.AmplifyKnockbackEffect
	if not triggerArgs.SourceProjectile or effectData.ProjectileNameBlacklistLookup[triggerArgs.SourceProjectile] then
		return
	end
	if RandomChance( effectData.Chance * GetTotalHeroTraitValue("LuckMultiplier", {IsMultiplier = true})) and CheckCooldown("PoseidonStatusFont", effectData.Cooldown) then
		CreateProjectileFromUnit({ Name = effectData.ProjectileName, DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, FireFromTarget = true, DamageMultiplier = GetTotalHeroTraitValue("PoseidonFontMultiplier", { IsMultiplier = true }) })
	end
end

function RootedApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		HeroRootApplyPresentation( triggerArgs )
	end
end

function RootedClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		HeroRootClearPresentation( triggerArgs )
	end
end

function MatiHypnosisApply( triggerArgs )
	local victim = triggerArgs.Victim
	AddInputBlock({ Name = "MatiHypnosis" })
	DebugPrintTable(triggerArgs)

	local wanderId = GetFarthest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints" }) or CurrentRun.Hero.ObjectId

	MoveHeroToRoomPosition({ SkipInputBlock = true, DestinationId = wanderId, Timeout = triggerArgs.Duration })
end

function MatiHypnosisClear( triggerArgs )
	RemoveInputBlock({ Name = "MatiHypnosis" })
end

function HecatePolymorphApply( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		MapState.HostilePolymorph = true
		ExpireProjectiles({ Names = { "HecatePolymorph", "HecatePolymorph_EM", "HecatePolymorph_EMSplit" }, BlockSpawns = true })
		EndBlinkWeapons({ Id = CurrentRun.Hero.ObjectId })
		SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
		SetupCostume( true )
		thread( CallFunctionName, victim.OnHostilePolymorphFunctionName, victim, triggerArgs )
		if SessionMapState.LaserSpellDown then
			LaserHoldClear()
		end
		if MapState.BlinkDropTrail then	
			TerminateBlinkTrail()
		end
		if SessionMapState.ThrowWeaponCharged then
			ApplyDeferredThrowReversions( GetWeaponData( CurrentRun.Hero, "WeaponLobSpecial" ))
		end
		for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
			local weaponData = WeaponData[weaponName]
			if weaponData ~= nil and weaponData.SwapAnimations ~= nil then
				for fromAnim, toAnim in pairs( weaponData.SwapAnimations ) do
					SwapAnimation({ Name = fromAnim, Reverse = true })
				end
			end
		end
		RunWeaponMethod({ Id = victim.ObjectId, Weapon = "All", Method = "cancelCharge" })
		RunWeaponMethod({ Id = victim.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
		thread( PlayVoiceLines, GlobalVoiceLines.HecatePolymorphVoiceLines, true )
		if MapState.EquippedWeapons.WeaponLob then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
		end
		EndSpellTransform()
		EndAllControlSwaps({ DestinationId = CurrentRun.Hero.ObjectId })

		-- Pick Polymorph Type
		local polymorphOptions = { "Sheep", "Pig", "Rat" }
		local eligibleOptions = {}
		for k, type in pairs(polymorphOptions) do
			if PolymorphPresentationData[type].GameStateRequirements == nil or IsGameStateEligible(PolymorphPresentationData[type], PolymorphPresentationData[type].GameStateRequirements) then
				table.insert(eligibleOptions, type)
			end
		end

		GameState.PolymorphRecord = GameState.PolymorphRecord or { Sheep = GameState.ProjectileRecord.HecatePolymorph }
		local forcedOptions = {}
		for k, type in pairs(eligibleOptions) do
			if GameState.PolymorphRecord[type] == nil then
				table.insert(forcedOptions, type)
			end
		end

		if not IsEmpty(forcedOptions) then
			victim.PolymorphType = GetRandomValue(forcedOptions)
		else
			victim.PolymorphType = GetRandomValue(eligibleOptions)
		end
		
		local effectName = "HostilePolymorphSpeed"
		local dataProperties = ShallowCopyTable( EffectData[effectName].DataProperties)
		dataProperties.Duration = triggerArgs.Duration
		if PolymorphPresentationData[victim.PolymorphType].SpeedModifier then
			dataProperties.Modifier = PolymorphPresentationData[victim.PolymorphType].SpeedModifier
		end
		ApplyEffect({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
		GameState.PolymorphRecord[victim.PolymorphType] = GameState.PolymorphRecord[victim.PolymorphType] or 0
		GameState.PolymorphRecord[victim.PolymorphType] = GameState.PolymorphRecord[victim.PolymorphType] + 1

		HecatePolymorphEquipWeapons({ PolymorphType = victim.PolymorphType })
		PolymorphApplyPresentation( triggerArgs, { BossPolymorph = true, PolymorphType = victim.PolymorphType } )
	else
		CheckPolymorphApply( triggerArgs )
	end
end

function HecatePolymorphClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		victim.SkipDamageAnimation = false
		MapState.HostilePolymorph = false
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HostilePolymorphSpeed" })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = triggerArgs.triggeredById })
		HecatePolymorphUnequipWeapons({ PolymorphType = victim.PolymorphType })
		PolymorphClearPresentation( triggerArgs, { BossPolymorph = true, PolymorphType = victim.PolymorphType } )
		for _, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if traitData.ReplacementGrannyModels ~= nil then
				for originalModel, attachmentModel in pairs(traitData.ReplacementGrannyModels) do
					SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = attachmentModel, OriginalAttachmentModel = originalModel, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end	
		end
		HandleWeaponAnimSwaps()
		if CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
			local trait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell)
			thread( CallFunctionName, trait.CheckChargeFunctionName, CurrentRun.Hero )
		end
		SetupCostume()
		if not IsEmpty(SessionMapState.ReadiedMassiveAttacks) then
			AddReadiedMassiveAttackPolymorphPresentation()
		end
		victim.PolymorphType = nil
	end
end

function ChronosPolymorphApply( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		MapState.HostilePolymorph = true
		MapState.BabyPolymorph = true
		EndBlinkWeapons({ Id = CurrentRun.Hero.ObjectId })
		SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
		SetupCostume( true )
		thread( CallFunctionName, victim.OnHostilePolymorphFunctionName, victim, triggerArgs )
		if SessionMapState.LaserSpellDown then
			LaserHoldClear()
		end
		if MapState.BlinkDropTrail then	
			TerminateBlinkTrail()
		end
		if SessionMapState.ThrowWeaponCharged then
			ApplyDeferredThrowReversions( GetWeaponData( CurrentRun.Hero, "WeaponLobSpecial" ))
		end
		for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
			local weaponData = WeaponData[weaponName]
			if weaponData ~= nil and weaponData.SwapAnimations ~= nil then
				for fromAnim, toAnim in pairs( weaponData.SwapAnimations ) do
					SwapAnimation({ Name = fromAnim, Reverse = true })
				end
			end
		end
		RunWeaponMethod({ Id = victim.ObjectId, Weapon = "All", Method = "cancelCharge" })
		RunWeaponMethod({ Id = victim.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
		if MapState.EquippedWeapons.WeaponLob then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
		end
		EndSpellTransform()
		EndAllControlSwaps({ DestinationId = CurrentRun.Hero.ObjectId })
		HecatePolymorphEquipWeapons( { WeaponNames = { "WeaponMorphedBlink_YoungMel" } } )
		PolymorphApplyPresentation( triggerArgs, { BossPolymorph = false, PolymorphType = "YoungMel", SkipPolymorphText = true } )
	end
end

function ChronosPolymorphClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		MapState.HostilePolymorph = false
		MapState.BabyPolymorph = nil
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = triggerArgs.triggeredById })
		HecatePolymorphUnequipWeapons( { WeaponNames = { "WeaponMorphedBlink_YoungMel" } } )
		PolymorphClearPresentation( triggerArgs, { BossPolymorph = false, PolymorphType = "YoungMel" } )
		for _, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if traitData.ReplacementGrannyModels ~= nil then
				for originalModel, attachmentModel in pairs(traitData.ReplacementGrannyModels) do
					SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = attachmentModel, OriginalAttachmentModel = originalModel, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end	
		end
		HandleWeaponAnimSwaps()
		if CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
			local trait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell)
			thread( CallFunctionName, trait.CheckChargeFunctionName, CurrentRun.Hero )
		end
		SetupCostume()
		if not IsEmpty(SessionMapState.ReadiedMassiveAttacks) then
			AddReadiedMassiveAttackPolymorphPresentation()
		end
	end
end

function HecatePolymorphEquipWeapons( args )
	args = args or {}
	local polymorphData = {}
	if args.PolymorphType ~= nil then
		polymorphData = PolymorphPresentationData[args.PolymorphType]
	end
	local morphWeapons = args.WeaponNames or polymorphData.WeaponNames or { "WeaponMorphedBlink", "WeaponMorphedAttack" }
	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Names = morphWeapons })
	for i, weaponName in ipairs( morphWeapons ) do
		MapState.EquippedWeapons[weaponName] = true
	end
	
	local weaponFireOverrides = {}
	for i, data in pairs(GetHeroTraitValues("OverrideWeaponFireNames")) do
		for newWeapon, originalWeapon in pairs(data) do
			weaponFireOverrides[originalWeapon] = newWeapon
		end
	end
	for i, newWeapon in pairs(GetHeroTraitValues("ReplaceMeleeWeapon")) do
		if WeaponData[newWeapon] and WeaponData[newWeapon].LinkedUpgrades then
			weaponFireOverrides[WeaponData[newWeapon].LinkedUpgrades] = newWeapon
		end
	end

	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		SessionMapState.BlockWeaponFailedToFire[weaponName] = true
		if weaponFireOverrides[weaponName] then
			SetWeaponProperty({ WeaponName = weaponFireOverrides[weaponName], DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
	end
	
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			local weaponName = traitData.PreEquipWeapons[1]
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
	end
end

function HecatePolymorphUnequipWeapons( args )
	args = args or {}
	local polymorphData = {}
	if args.PolymorphType ~= nil then
		polymorphData = PolymorphPresentationData[args.PolymorphType]
	end
	local morphWeapons = args.WeaponNames or polymorphData.WeaponNames or { "WeaponMorphedBlink", "WeaponMorphedAttack" }
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Names = morphWeapons })
	RemoveTableValues( MapState.EquippedWeapons, morphWeapons )

	local weaponFireOverrides = {}
	for i, data in pairs(GetHeroTraitValues("OverrideWeaponFireNames")) do
		for newWeapon, originalWeapon in pairs(data) do
			weaponFireOverrides[originalWeapon] = newWeapon
		end
	end
	
	for i, newWeapon in pairs(GetHeroTraitValues("ReplaceMeleeWeapon")) do
		if WeaponData[newWeapon] and WeaponData[newWeapon].LinkedUpgrades then
			weaponFireOverrides[WeaponData[newWeapon].LinkedUpgrades] = newWeapon
		end
	end

	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
		SessionMapState.BlockWeaponFailedToFire[weaponName] = nil
		if weaponFireOverrides[weaponName] then
			if CurrentRun.Hero.Ammo[ weaponName ] then			
				UpdateWeaponAmmo( weaponName, 0 )
			else
				SetWeaponProperty({ WeaponName = weaponFireOverrides[weaponName], DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end
	end

	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			local weaponName = traitData.PreEquipWeapons[1]
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
		end
	end
	UpdateWeaponMana()
end

function PolyphemusPlayerGrabApply( triggerArgs )
	local victim = triggerArgs.Victim
	victim.SkipDamageAnimation = true
	MapState.HostilePolymorph = true
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })

	thread( CallFunctionName, victim.OnHostilePolymorphFunctionName, victim, triggerArgs )
	if SessionMapState.LaserSpellDown then
		LaserHoldClear()
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "Melinoe_ForwardCast_End"})
	end
	if MapState.BlinkDropTrail then	
		TerminateBlinkTrail()
	end
	if SessionMapState.ThrowWeaponCharged then
		ApplyDeferredThrowReversions( GetWeaponData( CurrentRun.Hero, "WeaponLobSpecial" ))
	end
	RunWeaponMethod({ Id = victim.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = victim.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	if MapState.EquippedWeapons.WeaponLob then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
	end
	EndSpellTransform()
	EndAllControlSwaps({ DestinationId = CurrentRun.Hero.ObjectId })

	EndAutoSprint({ Halt = true })
	PolyphemusPlayerGrabApplyPresentation( triggerArgs, { } )
end

function PolyphemusPlayerGrabClear( triggerArgs )
	local victim = triggerArgs.Victim
	victim.SkipDamageAnimation = false
	MapState.HostilePolymorph = false
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = triggerArgs.triggeredById })
	PolyphemusPlayerGrabClearPresentation( triggerArgs, { } )
	if CurrentRun.Hero.Weapons.WeaponLob then
		UpdateWeaponAmmo( "WeaponLob", 0 )
	end
	UpdateWeaponMana()
	if not victim.IsDead then
		SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
end

function ZeusRepeatedStun( unit )
	local initialStrike = true
	while not unit.IsDead and (( unit.ActiveEffects and unit.ActiveEffects.ZeusRepeatedStun ) or initialStrike ) do
		ApplyEffect({ DestinationId = unit.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ZeusStun", DataProperties = EffectData.ZeusStun.EffectData })
		initialStrike = false
		thread( PulseUnitColor, unit, 0.1 )
		wait( EffectData.ZeusRepeatedStun.Interval, RoomThreadName )
	end
end

function PulseUnitColor( unit, restoreColorDelay )
	SetColor({ Id = unit.ObjectId, Color = Color.Black, Duration = 0.03 })
	wait( restoreColorDelay )
	SetColor({ Id = unit.ObjectId, Color = Color.White, Duration = 0.2 })
end

function StaffSelfBuffApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
	end
end

function StaffSelfBuffClear( triggerArgs )	
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then

	end
end

function OmegaBuffApply( triggerArgs )
	if not triggerArgs.Reapplied then
		AddOutgoingCritModifier( CurrentRun.Hero, 
		{
			Name = "OmegaBuff",
			Chance = triggerArgs.Modifier,
			WeaponNames = WeaponSets.HeroAllWeapons,
			IsEx = true,
			Temporary = true,
		})
	end
end

function OmegaBuffClear( triggerArgs )
	RemoveOutgoingCritModifier( CurrentRun.Hero, "OmegaBuff" )
end

function ClearCastApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		MapState.ClearCastWeapons = ToLookup(AddLinkedWeapons( WeaponSets.HeroAllWeapons ))
		UpdateWeaponMana()
	end
end

function ClearCastClear( triggerArgs )	
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		MapState.ClearCastWeapons = nil
		UpdateWeaponMana()
		thread( EndClearCastPresentation )
		if HeroHasTrait("PoseidonManaBoon") then
			local trait = GetHeroTrait("PoseidonManaBoon")
			thread( PoseidonIntermittentClearCast, nil, trait.SetupFunction.Args, {Cooldown = true} )
		end
	end
end

function DelayedKnockbackEffectApply( triggerArgs )
	local victim = triggerArgs.Victim
	victim.TriggerDamage = triggerArgs.TriggerDamage
end

function DamageShareApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not victim.DamageShareAmount or victim.DamageShareAmount < triggerArgs.Amount then
		victim.DamageShareAmount = triggerArgs.Amount
	end
end

function DamageOverTimeApply( triggerArgs )
end

function DamageShareClear( triggerArgs )
	local victim = triggerArgs.Victim
	victim.DamageShareAmount = nil
end

function PlayerSprintPhasingApply( triggerArgs )
	local victim = triggerArgs.Victim	
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero and not victim.IsSprintPhasing then
		victim.IsSprintPhasing = true
		SetPlayerNotStopsProjectiles( triggerArgs.EffectName )
		AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "DashInvulnerableTag" })
	end
end

function PlayerSprintPhasingClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		SetPlayerStopsProjectiles( triggerArgs.EffectName )
		if triggerArgs.EffectName == "RushWeaponInvulnerable" and not CurrentRun.Hero.ActiveEffects.RushWeaponInvulnerableCharge then
			RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Name = "DashInvulnerableTag" })
			EndPlayerBlinkAlpha()
			victim.IsSprintPhasing = nil
		end
	end
end

function LobShortInvulnerableApply( triggerArgs )
	local victim = triggerArgs.Victim
	
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		SetPlayerDarkside("LobShortInvulnerable")
	end
end

function LobShortInvulnerableClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		SetPlayerUnDarkside("LobShortInvulnerable")
	end
end

function MiasmaSlowApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier * EffectData[triggerArgs.EffectName].AttackSpeedMultiplier
	
		local allPropertyChanges= {}
		if not MapState.MiasmaPropertyChanges then
			local speedPropertyChange = 		
			{
				WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
				ChangeValue = EffectData[triggerArgs.EffectName].AttackSpeedMultiplier,
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
					WeaponName = "WeaponSprint",
					WeaponProperty = "SelfVelocity",
					ChangeValue = EffectData[triggerArgs.EffectName].SprintSpeedMultiplier,
					ChangeType = "Multiply",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponSprint",
					WeaponProperty = "SelfVelocityCap",
					ChangeValue = EffectData[triggerArgs.EffectName].SprintSpeedMultiplier,
					ChangeType = "Multiply",
					ExcludeLinked = true,
				},
			} )
			MapState.MiasmaPropertyChanges = allPropertyChanges
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.MiasmaPropertyChanges )
		if not EffectData[triggerArgs.EffectName].SkipPresentation then
		thread( HitByMiasmaPresentation, CurrentRun.Hero )
	end
end
end

function MiasmaSlowClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier / EffectData[triggerArgs.EffectName].AttackSpeedMultiplier
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.MiasmaPropertyChanges, true, true)
		thread( MiasmaClearedPresentation, victim )
	end
end

function StaffSpecialTriggerLockApply( triggerArgs )
	AddBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	AddSpecialLockLayer( "WeaponStaffBall", "Disable"..triggerArgs.EffectName )
end

function StaffSpecialTriggerLockClear( triggerArgs )
	RemoveBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	HandleSpecialTriggerLockClear( "WeaponStaffBall", triggerArgs )
end

function DaggerSpecialTriggerLockApply( triggerArgs )
	AddBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	AddSpecialLockLayer( "WeaponDaggerThrow", "Disable"..triggerArgs.EffectName )
end

function DaggerSpecialTriggerLockClear( triggerArgs )
	RemoveBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	HandleSpecialTriggerLockClear( "WeaponDaggerThrow", triggerArgs )
end

function TorchSpecialTriggerLockApply( triggerArgs )
	AddBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	AddSpecialLockLayer( "WeaponTorchSpecial", "Disable"..triggerArgs.EffectName )
end

function TorchSpecialTriggerLockClear( triggerArgs )
	RemoveBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	HandleSpecialTriggerLockClear( "WeaponTorchSpecial", triggerArgs )
end

function HandleSpecialTriggerLockClear( weaponName, triggerArgs )
	if not MapState.EquippedWeapons[weaponName] then
		return
	end
	local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ChargeTime" }) or 0
	local minCharge = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "MinChargeToFire" }) or 0
	local cooldown = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "Cooldown" }) or 0
	if cooldown > 0 then
		local duration = nil
		if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].EffectData and EffectData[triggerArgs.EffectName].EffectData.Duration then
			cooldown = cooldown - EffectData[triggerArgs.EffectName].EffectData.Duration 
		else
			cooldown = cooldown - GetEffectDataValue({ WeaponName = weaponName, EffectName = triggerArgs.EffectName, Property = "Duration"})
		end
	end
	local totalWait = math.max(chargeTime * minCharge, cooldown )
	waitUnmodified(totalWait + 0.06 )
	RemoveSpecialLockLayer( weaponName, "Disable"..triggerArgs.EffectName )
end

function BlinkTriggerLockApply( triggerArgs )	
	AddBlinkLockLayer( "Disable"..triggerArgs.EffectName )	
end

function BlinkTriggerLockClear( triggerArgs )
	RemoveBlinkLockLayer( "Disable"..triggerArgs.EffectName )
end

function BlinkAndCastTriggerLockApply( triggerArgs )	
	AddBlinkLockLayer( "Disable"..triggerArgs.EffectName )	
	AddCastLockLayer( "Disable"..triggerArgs.EffectName )
end

function BlinkAndCastTriggerLockClear( triggerArgs )
	RemoveBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	RemoveCastLockLayer( "Disable"..triggerArgs.EffectName )
end

function BlinkAndSpecialTriggerLockApply( triggerArgs )	
	AddBlinkLockLayer( "Disable"..triggerArgs.EffectName )	
	AddSpecialLockLayer( "WeaponLobSpecial", "Disable"..triggerArgs.EffectName )	
end

function BlinkAndSpecialTriggerLockClear( triggerArgs )
	RemoveBlinkLockLayer( "Disable"..triggerArgs.EffectName )
	RemoveSpecialLockLayer( "WeaponLobSpecial", "Disable"..triggerArgs.EffectName )
end

function LobDisableTriggerLockApply( triggerArgs )	
	AddLobWeaponLockLayer( "Disable" )	
end

function LobDisableTriggerLockClear( triggerArgs )
	if not CurrentRun.Hero.Weapons.WeaponLob then
		return
	end
	local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLob", Property = "ChargeTime" })
	local minCharge = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLob", Property = "MinChargeToFire" })
	waitUnmodified(chargeTime * minCharge + 0.06 )
	RemoveLobWeaponLockLayer( "Disable" )
end
function AddLobWeaponLockLayer( tag )
	if not SessionMapState.LobLock[tag] then
		SessionMapState.LobLock[tag] = true
	end
	SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = true})
	SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowMultiFireRequest", Value = true})
	SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "CanCancelDisables", Value = true})
end

function RemoveLobWeaponLockLayer( tag )
	SessionMapState.LobLock[tag] = nil
	if IsEmpty(SessionMapState.LobLock) then
		SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = false})
		SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowMultiFireRequest", Value = false})
		SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "CanCancelDisables", Value = false})	
	end
end

function AddSpecialLockLayer( weaponName, tag )
	if not MapState.EquippedWeapons[weaponName] then
		return
	end
	if not SessionMapState.SpecialLock[weaponName] then
		SessionMapState.SpecialLock[weaponName] = {}
	end
	SessionMapState.SpecialLock[weaponName][tag] = true
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = true})
end

function RemoveSpecialLockLayer( weaponName, tag )
	if not MapState.EquippedWeapons[weaponName] then
		return
	end
	if not SessionMapState.SpecialLock[weaponName] then
		return
	end
	SessionMapState.SpecialLock[weaponName][tag] = nil
	if IsEmpty(SessionMapState.SpecialLock[weaponName]) then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = false})
	end
end

function AddBlinkLockLayer( tag )
	if not SessionMapState.BlinkLock[tag] then
		SessionMapState.BlinkLock[tag] = true
	end
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = true})
end

function RemoveBlinkLockLayer( tag )
	SessionMapState.BlinkLock[tag] = nil
	if IsEmpty(SessionMapState.BlinkLock) then
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = false})
	end
end

CastLockWeapons =
{
	"WeaponCastProjectile",
	"WeaponAnywhereCast",
	"WeaponCastProjectileHades",
	"WeaponCastLob",
}

function AddCastLockLayer( tag )
	if not SessionMapState.CastLock[tag] then
		SessionMapState.CastLock[tag] = true
	end
	for i, weaponName in ipairs( CastLockWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = true })
		end
	end
end

function RemoveCastLockLayer( tag )
	SessionMapState.CastLock[tag] = nil
	if IsEmpty( SessionMapState.CastLock ) then
		for i, weaponName in ipairs( CastLockWeapons ) do
			if MapState.EquippedWeapons[weaponName] then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = false })
			end
		end
	end
end

function SuitDashAttackLockApply( triggerArgs )	
end

function SuitDisableTriggerLockApply( triggerArgs )	
	AddSuitWeaponLockLayer( "Disable" )	
end


function SuitDisableTriggerLockClear( triggerArgs )
	RemoveSuitWeaponLockLayer( "Disable" )
end

function AddSuitWeaponLockLayer( tag )
	if not SessionMapState.SuitLock[tag] then
		SessionMapState.SuitLock[tag] = true
	end
	SetWeaponProperty({ WeaponName = "WeaponSuit", DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = true})
	SetWeaponProperty({ WeaponName = "WeaponSuit", DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowMultiFireRequest", Value = true})
	SetWeaponProperty({ WeaponName = "WeaponSuit", DestinationId = CurrentRun.Hero.ObjectId, Property = "CanCancelDisables", Value = true})
end

function RemoveSuitWeaponLockLayer( tag )
	SessionMapState.SuitLock[tag] = nil
	if IsEmpty(SessionMapState.SuitLock) then
		SetWeaponProperty({ WeaponName = "WeaponSuit", DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = false})
		SetWeaponProperty({ WeaponName = "WeaponSuit", DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowMultiFireRequest", Value = false})
		SetWeaponProperty({ WeaponName = "WeaponSuit", DestinationId = CurrentRun.Hero.ObjectId, Property = "CanCancelDisables", Value = false})	
	end
end

function AxeSpecialBlockSelfTriggerLockApply( triggerArgs )
	SetWeaponProperty({ WeaponName = "WeaponAxeSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "IgnoreTriggerLockDuringCooldown", Value = true})	
end

function AxeSpecialBlockSelfTriggerLockClear( triggerArgs )
	SetWeaponProperty({ WeaponName = "WeaponAxeSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "IgnoreTriggerLockDuringCooldown", Value = false})
end

function BurnEffectApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local effectData = EffectData[triggerArgs.EffectName]
	if not victim.ObjectId then
		return
	end
	if EnemyHealthDisplayAnchors[victim.ObjectId] == nil then
		CreateHealthBar( victim )
		UpdateHealthBar( victim, 0, { Force = true } )
	end
	CreateScorchHealthBar( victim )
	if not triggerArgs.Reapplied and effectData and effectData.InflictedVfx then
		CreateAnimation({ Name = effectData.InflictedVfx, DestinationId = victim.ObjectId})
	end
	local burnMissChance = GetTotalHeroTraitValue("BurnMissChance")
	if burnMissChance > 0 then
		local dataProperties = EffectData.BurnBlind.DataProperties
		dataProperties.Duration = 3600
		dataProperties.MissChance = burnMissChance
		ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "BurnBlind", DataProperties = dataProperties })
	end
	thread( HandleBurnTicks, triggerArgs  )
end

function BurnEffectClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim and victim.UseBossHealthBar then
		UpdateHealthBar( victim, 0, {Force = true})
	end
	ClearEffect({ Id = victim.ObjectId, Name = "BurnBlind" })
end

function ClearSuitAttackShield( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero and SessionMapState.SuitBlockGraphic then
		local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSuitCharged" )
		StopAnimation({ Name = weaponData.BlockGraphic, DestinationId = victim.ObjectId })
		SessionMapState.SuitBlockGraphic = nil
	end
end

function HandleBurnTicks( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local effectData = EffectData[triggerArgs.EffectName]
	local threadName = "BurnThread"..victim.ObjectId
	local presentationThreadName = "BurnPresentation"..victim.ObjectId 

	if SetThreadWait( threadName, effectData.DamageHoldDuration ) then
		killTaggedThreads( presentationThreadName )
		return
	end
	local damageOverflow = 0
	local stackOverflow = 0
	while victim and not victim.IsDead and victim.ActiveEffects[effectName] and victim.ActiveEffects[effectName] > 0 do
		local interval = effectData.DamageInterval
		wait(interval, threadName )
		local damagePerSecond = effectData.DamagePerSecond * GetTotalHeroTraitValue( "BurnDamageMultiplier", {IsMultiplier = true })
		if victim and not victim.IsDead and victim.ActiveEffects[effectName] and victim.ActiveEffects[effectName] > 0 then
			local stackReduction, stackFraction = math.modf( interval / (1 / damagePerSecond) )
			stackOverflow = stackOverflow + stackFraction
			if stackOverflow > 1 then
				stackReduction = stackReduction + 1
				stackOverflow = stackOverflow - 1
			end
			if stackReduction >= victim.ActiveEffects[effectName] then
				stackReduction = victim.ActiveEffects[effectName]
				interval = stackReduction / damagePerSecond
			end
			local refreshBurn = false
			local increaseBurn = false
			if SessionMapState.ReverseBurn then
				increaseBurn = true
			else
				for i, value in pairs( GetHeroTraitValues("EternalBurnRequirements")) do
					if value.RequiredEffect and victim.ActiveEffects[ value.RequiredEffect ] then
						refreshBurn = true
					end
				end
			end
			if not refreshBurn then
				local stackDelta = stackReduction
				if increaseBurn then
					stackDelta = -stackDelta
				end
				victim.ActiveEffects[effectName] = victim.ActiveEffects[effectName] - stackDelta 
				thread( HandleBurnStacks, victim, { EffectData = effectData, StartingStacks = victim.ActiveEffects[effectName], Stacks = stackDelta , Duration = interval, PresentationThreadName = presentationThreadName })
			end
			Damage( victim, { AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, EffectName = "BurnEffect", DamageAmount = stackReduction, Silent = false})
			if victim.ActiveEffects[effectName] and victim.ActiveEffects[effectName] <= 0 then
				-- final wait to allow presentation to finish catching up
				wait( stackReduction / damagePerSecond, threadName)
			end
		end
	end
	ClearEffect({ Id = victim.ObjectId, Name = effectName })
	
	killTaggedThreads(threadName)
	killTaggedThreads(presentationThreadName)
end

function HandleBurnStacks( victim, args )
	if not victim or victim.IsDead or IsEmpty(victim.ActiveEffects) then
		return
	end
	local effectData = args.EffectData
	local effectName = effectData.Name
	local stacks = args.Stacks
	local startingStacks = victim.ActiveEffects[effectName] + stacks
	local totalDuration = args.Duration
	local threadName = args.PresentationThreadName
	local startTime = _worldTime
	local lastStacks = startingStacks
	while _worldTime < startTime + totalDuration do
		local lerp = (_worldTime - startTime) / totalDuration
		local expectedStacks = round( startingStacks * (1 - lerp ) + (startingStacks - stacks) * lerp)
		local expectedDelta = math.abs(expectedStacks - lastStacks )
		if expectedDelta > 0 then
			if victim.CreatedDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ] then
				ModifyTextBox({ Id = victim.CreatedDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ], Text = expectedStacks })
				UpdateHealthBar(victim, 0, { Force = true })
			end
		end
		lastStacks = expectedStacks
		if effectData.DamagePresentationInterval then
			wait( effectData.DamagePresentationInterval, threadName )
		else
			wait( 1 / effectData.DamagePerSecond, threadName )
		end
	end
end

function RecordSafeZoneFired( enemy, aiData, currentRun )
	SessionMapState.LastTriggeredSafeZoneId = enemy.ObjectId
end

function CheckSafeZoneRecharge()
	local safeZoneId = SessionMapState.LastTriggeredSafeZoneId

	if GameState.WorldUpgradesAdded.WorldUpgradeSafeZoneSpellCharge and (not safeZoneId or not MapState.UsedSafeZones[safeZoneId] ) then
		CurrentRun.CurrentRoom.TriggeredSpellRecharge = true
		ChargeSpell( -1000, {Force = true} )
		if safeZoneId then
			MapState.UsedSafeZones[safeZoneId] = true
		end
	end
end


function EffectUninterruptibleApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	if victim == CurrentRun.Hero and not triggerArgs.Reapplied then
		SetPlayerUninterruptible( effectName )
	end
end

function EffectUninterruptibleClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim and victim == CurrentRun.Hero then
		SetPlayerInterruptible( triggerArgs.EffectName )
	end
end

function MoonBeamVulnerabilityApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied then
		AddIncomingDamageModifier( victim, 
		{
			Name = triggerArgs.EffectName,
			ExMultiplier = triggerArgs.Modifier + GetTotalHeroTraitValue("MoonBeamVulnerabilityBonus"),
			WeaponNames = WeaponSets.HeroAllWeapons,
			Temporary = true,
		})
	end
end

function MoonBeamVulnerabilityClear( triggerArgs )	
	local victim = triggerArgs.Victim
	RemoveIncomingDamageModifier( victim, triggerArgs.EffectName )
end

function HecateDarkSideApply( triggerArgs, args )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied then
		AddIncomingDamageModifier(victim, args.AddIncomingDamageModifier)
		victim.RestoreWeaponOptions = victim.WeaponOptions
		victim.WeaponOptions = args.TemporaryWeaponOptions
		HecateDarkSideTransformPresentation(triggerArgs)
	end
end

function HecateDarkSideClear( triggerArgs, args )	
	local victim = triggerArgs.Victim
	RemoveIncomingDamageModifier(victim, args.RemoveIncomingDamageModifier)

	if not victim.InTransition then
		victim.WeaponOptions = victim.RestoreWeaponOptions
		victim.ForcedWeaponInterrupt = true
	end
	-- End current weapon
	notifyExistingWaiters( victim.AINotifyName )
	SetThreadWait( victim.AIThreadName, 0.1 )
	victim.ChainedWeapon = nil

	HecateDarkSideEndPresentation(triggerArgs)
end


function ShivaAttackBoostApply( triggerArgs )
	if not HeroHasTrait("SuitComboAspect") then
		return
	end
	local victim = triggerArgs.Victim
	IncrementTableValue( victim.ActiveEffects, triggerArgs.EffectName )

	UpdateSuitUI()

	local trait = GetHeroTrait("SuitComboAspect")
	local maxStacks = trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks
	PlaySound({ Name = "/SFX/Player Sounds/ShivaPowerUp", Id = CurrentRun.Hero.ObjectId })
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, Fraction = victim.ActiveEffects[triggerArgs.EffectName]/maxStacks, Instant = true })
	if victim.ActiveEffects[triggerArgs.EffectName] >= maxStacks then
		SessionMapState.ShivaMaxStackPresentation = true
		SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.SuitUI })
	end
end

function ShivaAttackBoostClear( triggerArgs )
	if not HeroHasTrait("SuitComboAspect") then
		return
	end
	
	local victim = triggerArgs.Victim
	local trait = GetHeroTrait("SuitComboAspect")
	
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, Fraction = 0, Instant = true })
	if SessionMapState.ShivaMaxStackPresentation then
		SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.SuitUI })
		SessionMapState.ShivaMaxStackPresentation = nil
	end
	UpdateSuitUI()
end

function CastGripEffectApply( triggerArgs )
	thread( CastSpeedPresentation )
end

function CastGripEffectClear( triggerArgs )
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxSpeed", Value = 0})
end

function OverheatApply( triggerArgs )
	if triggerArgs.Reapplied then
		return
	end
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount, Fraction = 1, Instant = true })
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount, PlaySpeed = 100 / triggerArgs.Duration })
    SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount, Fraction = 0 })
	SessionMapState.OverheatConsecutiveHit = 0
	
	SessionMapState.Overheat = true
	ModifyTextBox({ Id = ScreenAnchors.LobUI, FadeTarget = 1, FadeDuration = 0.2 })
	SessionMapState.BlockStagedCharge.WeaponLob = true
	SessionMapState.BlockStagedCharge.WeaponLobSpecial = true
	local totalSpeedChange = triggerArgs.Modifier
	if totalSpeedChange ~= 1 then
		local allPropertyChanges = 
		{
		}
		local speedPropertyChange = 		
		{
			WeaponNames = {"WeaponLob" },
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

		MapState.OverheatSpeedPropertyChanges = allPropertyChanges
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.OverheatSpeedPropertyChanges )
	end
	thread( UpdateLobUI )
	thread( OverheatStartPresentation, triggerArgs )
    SetAnimation({Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.LobUI })
	SetCastArmDisabled( "Overheat" )
end

function CheckOverheatConsecutiveDamage( victim, args, triggerArgs )
	if CurrentRun.Hero.ActiveEffects[args.EffectName] then
		IncrementTableValue( SessionMapState, args.Key, args.Count )
		thread( PulseText, { ScreenAnchorReference = "LobUI", Color = Color.White, OriginalColor = Color.White, ScaleTarget = 1.2, ScaleDuration = 0.2, HoldDuration = 0, PulseBias = 0.1 })
		thread( UpdateLobUI )
		thread(OverheatConsecutiveFalloff, args.Duration, args.Key )
	end
end

function OverheatConsecutiveFalloff( delay, key )
	if SetThreadWait("OverheatFalloff", delay) then
		return
	end
	wait( delay, "OverheatFalloff")
	SessionMapState[key] = 0
	thread( UpdateLobUI )
end

function OverheatClear( triggerArgs )	

	SessionMapState.BlockStagedCharge.WeaponLob = nil
	SessionMapState.BlockStagedCharge.WeaponLobSpecial = nil

	if not IsEmpty(MapState.OverheatSpeedPropertyChanges) then
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.OverheatSpeedPropertyChanges, true, true)
	end
	if ScreenAnchors.LobUI then
		SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.LobUI})
	end
	--SetWeaponProperty({ WeaponName = "WeaponLobSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = true, DataValue = false })
		
	if GetWeaponProperty({ WeaponName = "WeaponLob", Id = CurrentRun.Hero.ObjectId, Property = "Charging", DataValue = false}) then
		local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponLob" )
		triggerArgs.name = weaponData.Name
		thread( DoWeaponCharge, triggerArgs, weaponData )
		thread( HandleManaChargeIndicator, { name = weaponData.Name } )
	end
	SessionMapState.Overheat = nil
	SessionMapState.OverheatConsecutiveHit = 0
	thread( UpdateLobUI )
	ModifyTextBox({ Id = ScreenAnchors.LobUI, FadeTarget = 0, FadeDuration = 0.2 })
	SetCastArmEnabled( "Overheat" )
end

function FrenzyApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		local speedMultiplier = triggerArgs.Modifier

		SessionMapState.MapSpeedMultiplier = speedMultiplier * SessionMapState.MapSpeedMultiplier
		local allPropertyChanges= {}
		if not MapState.FrenzyPropertyChanges then
			local speedPropertyChange = 		
			{
				WeaponNames = WeaponSets.HeroAllWeapons,
				ChangeValue = speedMultiplier,
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
			MapState.FrenzyPropertyChanges = allPropertyChanges
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.FrenzyPropertyChanges )
	end
	thread( FrenzyStartAnimation, triggerArgs.Duration )
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, PlaySpeed = 100 / triggerArgs.Duration })
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = 0 })
	SetAnimation({Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.AxeUI })
end

function FrenzyClear( triggerArgs )	
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		local speedMultiplier = triggerArgs.Modifier
		SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.AxeUI})
		if SessionMapState.MapSpeedMultiplier then
			SessionMapState.MapSpeedMultiplier = speedMultiplier / SessionMapState.MapSpeedMultiplier
		end
		if not IsEmpty(MapState.FrenzyPropertyChanges) and totalSpeedChange ~= 1 then
			ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.FrenzyPropertyChanges, true, true)
		end
	end
end

function TyphonWeakEffectApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectData = EffectData[triggerArgs.EffectName]
	if not triggerArgs.Reapplied and victim.UniqueIconAttachments and victim.UniqueIconAttachments[triggerArgs.EffectName] then
		if victim.CustomWeakEffectId then
			StopAnimation({ Name = effectData.Vfx, DestinationId = victim.CustomWeakEffectId, PreventChain = true})
			Destroy({ Id = victim.CustomWeakEffectId })
			victim.CustomWeakEffectId = nil
		end
		victim.CustomWeakEffectId = SpawnObstacle({ Name = "BlankObstacle", TriggerOnSpawn = false })
		Attach({ Id = victim.CustomWeakEffectId, DestinationId = victim.ObjectId, MarkerName = victim.UniqueIconAttachments[triggerArgs.EffectName] })
		SetAnimation({ Name = effectData.Vfx, DestinationId = victim.CustomWeakEffectId })
	end
end

function TyphonWeakEffectClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim.CustomWeakEffectId then
		Destroy({ Id = victim.CustomWeakEffectId })
		victim.CustomWeakEffectId = nil
	end
end

function TyphonBlindEffectApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectData = EffectData[triggerArgs.EffectName]
	if not triggerArgs.Reapplied and victim.UniqueIconAttachments and victim.UniqueIconAttachments[triggerArgs.EffectName] then
		if victim.CustomBlindEffectId then
			StopAnimation({ Name = effectData.Vfx, DestinationId = victim.CustomBlindEffectId, PreventChain = true})
			Destroy({ Id = victim.CustomBlindEffectId })
			victim.CustomBlindEffectId = nil
		end
		victim.CustomBlindEffectId = SpawnObstacle({ Name = "BlankObstacle", TriggerOnSpawn = false })
		Attach({ Id = victim.CustomBlindEffectId, DestinationId = victim.ObjectId, MarkerName = victim.UniqueIconAttachments[triggerArgs.EffectName] })
		SetAnimation({ Name = effectData.Vfx, DestinationId = victim.CustomBlindEffectId })
	end
end

function TyphonBlindEffectClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim.CustomBlindEffectId then
		Destroy({ Id = victim.CustomBlindEffectId })
		victim.CustomBlindEffectId = nil
	end
end


function PotionBuffApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied then
		SessionMapState.PoseidonRegeneration = true
		SessionMapState.ElapsedTimeMultiplierIgnores.PoseidonRegeneration = true
		local trait = GetHeroTrait("PotionPoseidonTalent")
		local traitArgs = trait.OnWeaponFiredFunctions.FunctionArgs
		thread( ContinuousHealthRegeneration, traitArgs.HealPerSecond * CalculateHealingMultiplier())
		thread( ContinuousManaRegeneration, traitArgs.ManaRegenPerSecond )
	end
end

function PotionBuffClear( triggerArgs )
	local victim = triggerArgs.Victim
	SessionMapState.PoseidonRegeneration = nil
end