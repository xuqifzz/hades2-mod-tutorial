function GetExistingAnimationPriority( unit, excludeEffectNames )
	excludeEffectNames = excludeEffectNames or {}
	local effectNamesLookup = ToLookup(excludeEffectNames)
	local currentAnimationPriority = 9999
	if unit.ActiveEffects then
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
			return
		elseif victim.StunAnimations.Default then
			SetAnimation({ Name = victim.StunAnimations.Default, DestinationId = victim.ObjectId })
		end
	end
end


function CheckInvulnerableFalloff( triggerArgs )
	if IsCombatEncounterActive(CurrentRun) then
		thread( EncounterInvulnerableFalloffWarning, triggerArgs.EffectName)
	end
end

function EncounterInvulnerableFalloffWarning( effectName )
	local duration = GetTotalHeroTraitValue( "EncounterStartInvulnerabilityDuration")
	wait( duration - 3 )
	thread(EncounterStartInvulnerableWarnPresentation)
	wait(1)
	thread(EncounterStartInvulnerableWarnPresentation)
	wait(1)
	thread(EncounterStartInvulnerableWarnPresentation)
	wait(1)
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
	if HeroHasTrait("EchoExpirationBoon") then
		local echoData = victim.ActiveEchoes[effectName]
		if echoData and echoData.Amount < echoData.Threshold then
			DamageEchoTrigger( victim, effectName, echoData.Payoff * GetTotalHeroTraitValue("EchoExpirationMultiplier") )
		end
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
				DamageEchoTrigger( enemy, effectName, echoData.Payoff, echoData.Cooldown)
				CheckTriggerAllDamageEcho( enemy )
			end
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
					DamageEchoTrigger( victim, effectName, echoData.Payoff * functionArgs.DamageMultiplier, echoData.Cooldown )
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
	for _, enemy in pairs(ActiveEnemies) do
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

function DamageEchoTrigger( enemy, effectName, damageMultiplier, cooldown )

	if enemy and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) then
		CreateAnimation({ Name = "ZeusEchoDebuffSwell", DestinationId = enemy.ObjectId, Scale = enemy.EffectVfxScale  })
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
	if victim.DamageShareAmount and HasEffectWithEffectGroup( victim, "DamageShare") and not triggerArgs.PureDamage and not IsEmpty(ActiveEnemies) and ( not victim.SkipModifiers or victim.BondAlwaysApplies) then
		local range = EffectData.DamageShareEffect.Range
		local damageAmount = triggerArgs.DamageAmount * victim.DamageShareAmount		
		for id, enemy in pairs( ActiveEnemies ) do
			if enemy and victim and enemy ~= victim and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags )
				and HasEffectWithEffectGroup( enemy, "DamageShare") and GetDistance({ Id = victim.ObjectId, DestinationId = enemy.ObjectId}) <= range then
				CreateAnimationsBetween({ 
					Animation = "HeraRope", DestinationId = enemy.ObjectId, Id = victim.ObjectId, 
					Stretch = true, UseZLocation = false})
				thread( Damage, enemy, { EffectName = "DamageShareEffect", DamageAmount = damageAmount, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true } )
			end
		end
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

function HecatePolymorphApply( triggerArgs )
	local victim = triggerArgs.Victim
	victim.SkipDamageAnimation = true
	if victim == CurrentRun.Hero then
		MapState.HostilePolymorph = true
		EndBlinkWeapons({ Id = CurrentRun.Hero.ObjectId })
		SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
		SetupCostume( true )
		thread( CallFunctionName, victim.OnHostilePolymorphFunctionName, victim )
		if SessionMapState.LaserSpellDown then
			LaserHoldClear()
		end
		if MapState.BlinkDropTrail then	
			TerminateBlinkTrail()
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
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
		EndSpellTransform()
		HecatePolymorphEquipWeapons()
		PolymorphApplyPresentation( triggerArgs, { BossPolymorph = true } )
	else
		CheckPolymorphApply( triggerArgs )
	end
end

function HecatePolymorphClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		victim.SkipDamageAnimation = false
		MapState.HostilePolymorph = false
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = triggerArgs.triggeredById })
		HecatePolymorphUnequipWeapons( )
		PolymorphClearPresentation( triggerArgs, { BossPolymorph = true } )
		for _, traitData in pairs( CurrentRun.Hero.Traits ) do
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
	end
end

function HecatePolymorphEquipWeapons( )
	local morphWeapons = { "WeaponMorphedBlink", "WeaponMorphedAttack" }
	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Names = morphWeapons })
	
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
	
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			local weaponName = traitData.PreEquipWeapons[1]
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
	end
end

function HecatePolymorphUnequipWeapons( )
	local morphWeapons = { "WeaponMorphedBlink", "WeaponMorphedAttack" }
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Names = morphWeapons })

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

	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
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

function SelfEmpowerApply( triggerArgs )

end

function SelfEmpowerClear( triggerArgs )	
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		for weaponName, multiplier in pairs( SessionState.EmpoweredWeapons ) do
			SetWeaponProperty({WeaponName = weaponName, DestinationId = victim.ObjectId, Property = "DamageMultiplier", Value = -multiplier, ValueChangeType = "Add"})
		end
	end
	SessionState.EmpoweredWeapons = nil
end

function StaffSelfBuffApplicatorApply( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero and HeroHasTrait("StaffSelfHitAspect") then
		local effectData = GetHeroTraitValues("SelfHitEffectData")[1]
		local effectName = effectData.EffectName
		local dataProperties = MergeTables(	EffectData[effectName].DataProperties, effectData.DataProperties )
		ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectData.EffectName, DataProperties = dataProperties })
	end
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
		AddOutgoingDamageModifier( CurrentRun.Hero, 
		{
			Name = "OmegaBuff",
			ExMultiplier = triggerArgs.Modifier,
			WeaponNames = WeaponSets.HeroAllWeapons,
			Temporary = true,
		})
	end
end

function OmegaBuffClear( triggerArgs )
	RemoveOutgoingDamageModifier( CurrentRun.Hero, "OmegaBuff" )
end

function ClearCastApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		MapState.ClearCastWeapons = ToLookup(AddLinkedWeapons( WeaponSets.HeroAllWeapons ))
		UpdateWeaponMana()
		local effectData = EffectData[triggerArgs.EffectName]
		local bonus = triggerArgs.Amount
		if GetTotalHeroTraitValue("ClearCastDamageMultiplierOverride", {IsMultiplier = true}) then
			bonus = GetTotalHeroTraitValue("ClearCastDamageMultiplierOverride", {IsMultiplier = true})
		end
		AddOutgoingDamageModifier( CurrentRun.Hero, 
		{
			Name = triggerArgs.EffectName,
			ExMultiplier = bonus,
			WeaponNames = WeaponSets.HeroAllWeapons,
			Temporary = true,
		})
	end
end

function ClearCastClear( triggerArgs )	
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		MapState.ClearCastWeapons = nil
		UpdateWeaponMana()
		thread( EndClearCastPresentation )
		RemoveOutgoingDamageModifier( CurrentRun.Hero, triggerArgs.EffectName )
		if ScreenAnchors.StaffUIChargeAmount then
			SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.StaffUIChargeAmount, Fraction = 0, Instant = true })
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

function DamageShareClear( triggerArgs )
	local victim = triggerArgs.Victim
	victim.DamageShareAmount = nil
end

function PlayerSprintPhasingApply( triggerArgs )
	local victim = triggerArgs.Victim
	
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		SetPlayerNotStopsProjectiles( triggerArgs.EffectName )
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "DashInvulnerableTag", DataProperties = { Duration = 3600 } })
	end
end

function PlayerSprintPhasingClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		SetPlayerStopsProjectiles( triggerArgs.EffectName )
		if triggerArgs.EffectName == "RushWeaponInvulnerable" and not CurrentRun.Hero.ActiveEffects.RushWeaponInvulnerableCharge then
			ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "DashInvulnerableTag"})
			EndPlayerBlinkAlpha()
		end
	end
end

function MiasmaSlowApply( triggerArgs )
	local victim = triggerArgs.Victim
	MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier or 1
	if not triggerArgs.Reapplied and victim == CurrentRun.Hero then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier * EffectData[triggerArgs.EffectName].AttackSpeedMultiplier
	
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
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocity",
					ChangeValue = EffectData[triggerArgs.EffectName].SprintSpeedMultiplier,
					ChangeType = "Multiply",
					ExcludeLinked = true,
				},
				{
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocityCap",
					ChangeValue = EffectData[triggerArgs.EffectName].SprintSpeedMultiplier,
					ChangeType = "Multiply",
					ExcludeLinked = true,
				},
			} )
			MapState.MiasmaPropertyChanges = allPropertyChanges
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.MiasmaPropertyChanges )
		thread( HitByMiasmaPresentation, CurrentRun.Hero )
	end
end

function MiasmaSlowClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim == CurrentRun.Hero then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier / EffectData[triggerArgs.EffectName].AttackSpeedMultiplier
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

function LobDisableTriggerLockApply( triggerArgs )	
	AddLobWeaponLockLayer( "Disable" )	
end

function LobDisableTriggerLockClear( triggerArgs )
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
	if not SessionMapState.SpecialLock[weaponName] then
		SessionMapState.SpecialLock[weaponName] = {}
	end
	if not SessionMapState.SpecialLock[weaponName][tag] then
		SessionMapState.SpecialLock[weaponName][tag] = true
	end
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "LockTriggerForFireOnRelease", Value = true})
end

function RemoveSpecialLockLayer( weaponName, tag )
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

function BurnEffectApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local effectData = EffectData[triggerArgs.EffectName]
	if not victim.ObjectId then
		return
	end
	if not triggerArgs.Reapplied and effectData and effectData.InflictedVfx then
		CreateAnimation({ Name = effectData.InflictedVfx, DestinationId = victim.ObjectId})
	end
	thread( HandleBurnTicks, triggerArgs  )
end

function BurnEffectClear( triggerArgs )
	local victim = triggerArgs.Victim
	if victim and victim.UseBossHealthBar then
		UpdateHealthBar( victim, 0, {Force = true})
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
			for i, value in pairs( GetHeroTraitValues("EternalBurnRequirements")) do
				if value.RequiredEffect and victim.ActiveEffects[ value.RequiredEffect ] then
					refreshBurn = true
				end
			end
			if not refreshBurn then
				victim.ActiveEffects[effectName] = victim.ActiveEffects[effectName] - stackReduction
				thread( HandleBurnStacks, victim, { EffectData = effectData, StartingStacks = victim.ActiveEffects[effectName], Stacks = stackReduction, Duration = interval, PresentationThreadName = presentationThreadName })
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
			if EnemyHealthDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ] then
				ModifyTextBox({ Id = EnemyHealthDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ], Text = expectedStacks })
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

function CheckSafeZoneRecharge()
	if GameState.WorldUpgradesAdded.WorldUpgradeSafeZoneSpellCharge and not CurrentRun.CurrentRoom.TriggeredSpellRecharge then
		CurrentRun.CurrentRoom.TriggeredSpellRecharge = true
		ChargeSpell( -1000, {Force = true} )
	end
end