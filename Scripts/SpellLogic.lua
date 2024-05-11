function CreateTalentTree( spellData )	
	local uniqueTalents = {}
	local legendaryTalents = {}
	local availableTalents = {}
	if spellData.Talents.Repeatable then
		availableTalents = ShallowCopyTable( spellData.Talents.Repeatable )
	else
		availableTalents = ShallowCopyTable( spellData.Talents )
	end

	if spellData.Talents and spellData.Talents.Unique then
		uniqueTalents = ShallowCopyTable( spellData.Talents.Unique )
	end
	if spellData.Talents and spellData.Talents.Legendary then
		legendaryTalents = ShallowCopyTable( spellData.Talents.Legendary )
	end
	local eligibleStructures = {}
	for name, data in pairs(SpellTalentData.TalentTreeStructures) do
		if CurrentRun.CurrentRoom.TestRoom or not data.GameStateRequirements or IsGameStateEligible( CurrentRun, data.GameStateRequirements ) then
			table.insert(eligibleStructures, DeepCopyTable(data.Structure))
		end
	end

	local treeStructure =  GetRandomValue( eligibleStructures )
	for depth, data in ipairs(treeStructure) do
		for s, node in pairs(data) do
			if IsEmpty( availableTalents ) then
				if spellData.Talents.Repeatable then
					availableTalents = ShallowCopyTable( spellData.Talents.Repeatable )
				else
					availableTalents = ShallowCopyTable( spellData.Talents )
				end
			end
			local talentType = "Repeatable"
			local traitName = nil
			local rarity = nil
			
			if node.Pool then
				talentType = GetRandomValueFromWeightedList( node.Pool )
			end
			if talentType == "Repeatable" then
				rarity = GetTalentRarity( depth - 1)
				if rarity == "Legendary" then
					rarity = TraitRarityData.TalentRarityUpgradeOrder[GetKey(TraitRarityData.TalentRarityUpgradeOrder, rarity) - 1 ]
				end
				traitName = RemoveRandomValue( availableTalents )
			elseif talentType == "Keystone" then
				if not IsEmpty(uniqueTalents) then
					traitName = RemoveRandomValue( uniqueTalents )
					rarity = "Rare"
				else
					-- Serve heroic repeatable boon if we're out of unique talents
					traitName = RemoveRandomValue( availableTalents )
					rarity = "Heroic"
				end
			elseif talentType == "Legendary" then
				if not IsEmpty(legendaryTalents) then
					traitName = RemoveRandomValue( legendaryTalents )
					rarity = "Epic"
				else
					-- Serve heroic repeatable boon if we're out of unique talents
					traitName = RemoveRandomValue( availableTalents )
					rarity = "Heroic"
				end
			end
			node.Name = traitName
			node.Rarity = rarity
		end
	end
	-- generating backlinks
	for depth, data in ipairs(treeStructure) do
		for s, node in pairs(data) do
			if node.LinkTo then
				for _, linkToIndex in pairs(node.LinkTo) do
					if not treeStructure[depth+1][linkToIndex].LinkFrom then
						treeStructure[depth+1][linkToIndex].LinkFrom = {}
					end
					table.insert(treeStructure[depth+1][linkToIndex].LinkFrom, s)
				end
			end
		end
	end
	return treeStructure
end

function GetTalentRarity( column )
	if IsEmpty(SpellTalentData.RarityChances) then
		return "Common"
	end
	local rarities = ShallowCopyTable(SpellTalentData.RarityChances[column + 1])
	for i = #TraitRarityData.TalentRarityUpgradeOrder, 1, -1 do
		local rarityName = TraitRarityData.TalentRarityUpgradeOrder[i]
		if rarities[rarityName] and RandomChance(rarities[rarityName]) then
			return rarityName
		end
	end
	return "Common"
end

function ChargeSpell( manaDelta, args )
	args = args or {}
	if SessionMapState.BlockSpellCharge then
		return
	end
	if not CanChargeSpell() and not args.Force then
		return
	end
	
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	for i, data in pairs(GetHeroTraitValues("SpellChargeModifiers")) do
		local validSource = (data.ValidSource == nil or data.ValidSource == args.Source)
		if validSource then
			if data.Multiplier then
				manaDelta = manaDelta * data.Multiplier
			end
		end
	end
	if spellTrait and weaponName then
		local startingCharge = CurrentRun.SpellCharge
		IncrementTableValue( CurrentRun, "SpellCharge", -manaDelta )
		local data = GetWeaponData( CurrentRun.Hero, weaponName )
		local manaSpendCost = GetManaSpendCost( data )
		if CurrentRun.SpellCharge < manaSpendCost and spellTrait.TraitInfoCardId then
			local remainingSpend = math.max( manaSpendCost - CurrentRun.SpellCharge, 0 )
			thread( SpellChargeNumber, spellTrait, manaSpendCost, remainingSpend )
		elseif startingCharge < manaSpendCost then
			UpdateTraitNumber( spellTrait )
		end
		if ( spellTrait.RemainingUses and spellTrait.RemainingUses <=  0 )
			or ( spellTrait.Name == "SpellSummonTrait" and not CurrentRun.CurrentRoom.SummonEnemyName ) then 
			TraitUIActivateTrait( spellTrait, {CustomAnimation = "InactiveTrait" })
		elseif CurrentRun.SpellCharge >= manaSpendCost then
			if not MapState.HostilePolymorph then
				if CurrentRun.Hero.SlottedSpell and startingCharge < manaSpendCost  then
					CheckObjectiveSet(CurrentRun.Hero.SlottedSpell.Objective)
				end
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		else
			TraitUIActivateTrait( spellTrait, { CustomAnimation = "ActiveTraitCooldownNoFlash" })
			SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = CurrentRun.SpellCharge/manaSpendCost, DestinationId = spellTrait.TraitActiveOverlay, Instant = true })
		end	
		if CurrentRun.SpellCharge >= manaSpendCost then
			if startingCharge < manaSpendCost then
				EndCooldownBuff()
				thread( SpellReadyPresentation, spellTrait ) 
			end
		end
	end
end

function CanChargeSpell()

	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter and encounter.DelayedStart and not encounter.StartTime then
		return false
	end

	local nearestEnemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreUntargetable = false, Distance = SpellChargeData.EnemySpellChargeRadius, YScale = SpellChargeData.EnemySpellChargeYScale})
	
	if ActiveEnemies[nearestEnemyId] then
		return true
	end

	local hasAggro = not IsEmpty(MapState.AggroedUnits)
	
	if encounter and not encounter.Completed then
		if encounter.EncounterType == "Miniboss" or encounter.EncounterType == "Boss" then
			hasAggro = true
		end
	end
	return hasAggro
end

function UpdateSpellActiveStatus()
	local traitData = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if not traitData then
		return
	end
	weaponName = traitData.PreEquipWeapons[1]
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpend = GetManaSpendCost( data )
	if  ( traitData.RemainingUses and traitData.RemainingUses <=  0 ) 
		or ( traitData.Name == "SpellSummonTrait" and not CurrentRun.CurrentRoom.SummonEnemyName ) then 
		TraitUIActivateTrait( traitData, {CustomAnimation = "InactiveTrait" })
	elseif CurrentRun.SpellCharge < manaSpend then
		if not CanChargeSpell() then
			TraitUIActivateTrait( traitData, {CustomAnimation = "InactiveTrait" })
			if traitData.TraitInfoCardId ~= nil then
				Destroy({ Id = traitData.TraitInfoCardId })
				traitData.TraitInfoCardId = nil
			end
		else
			TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitCooldownNoFlash" })
			UpdateTraitNumber( traitData )
			SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = CurrentRun.SpellCharge/manaSpend, DestinationId = traitData.TraitActiveOverlay, Instant = true })
		end
	else	
		SpellActivateTrait( traitData )
	end
end

function SpellFire( owner, weaponData )
	CurrentRun.SpellCharge = 0
	
	SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	notifyExistingWaiters( weaponData.Name.."Fire" )
	local spellTrait = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
		end
	end
	if spellTrait then
		UpdateSpellActiveStatus()
		StartCooldownBuff()
		thread(SpellUnreadyPresentation, spellTrait)
	end
end

function SpellCheckCharges( unit, args, roomArgs )
	roomArgs = roomArgs or {}
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	
	if roomArgs.Grouped and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.MaintainSpellCharge and not CurrentRun.CurrentRoom.RestoreUnlockRoomExits then
		CurrentRun.SpellCharge = 0	
	end
	if spellTrait and weaponName then
		local data = GetWeaponData( CurrentRun.Hero, weaponName )
		local manaSpendCost = GetManaSpendCost( data )
		if  manaSpendCost and CurrentRun.SpellCharge < manaSpendCost then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			StartCooldownBuff()
			TraitUIActivateTrait( spellTrait, { CustomAnimation = "ActiveTraitCooldownNoFlash" })
			SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = CurrentRun.SpellCharge/manaSpendCost, DestinationId = spellTrait.TraitActiveOverlay, Instant = true })
		else
			SpellActivateTrait( spellTrait )
		end	
	end
end

function SpellPotionCheckCharges( unit, args, roomArgs )	
	roomArgs = roomArgs or {}
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpendCost = GetManaSpendCost( data )
	if roomArgs.Grouped and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.MaintainSpellCharge and not CurrentRun.CurrentRoom.RestoreUnlockRoomExits then
		CurrentRun.SpellCharge = 0	
	end
	if spellTrait.RemainingUses <= 0 or CurrentRun.SpellCharge < manaSpendCost then
		if spellTrait.AnchorId then
			StopAnimation({ DestinationId = spellTrait.AnchorId, Name = "DarkSorceryReady" })
		end
		TraitUIActivateTrait( spellTrait, {CustomAnimation = "InactiveTrait" })
		SetWeaponProperty({ WeaponName = spellTrait.PreEquipWeapons[1], DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	elseif spellTrait.RemainingUses > 0 then
		if CurrentRun.SpellCharge < manaSpendCost then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			TraitUIActivateTrait( spellTrait, { CustomAnimation = "ActiveTraitCooldownNoFlash" })
			SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = CurrentRun.SpellCharge/manaSpendCost, DestinationId = spellTrait.TraitActiveOverlay, Instant = true })
		else
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			SpellActivateTrait( spellTrait )
		end
	end
end

function GrantPotionBonusCharges( args )
	local spellTrait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell )
	spellTrait.RemainingUses = spellTrait.RemainingUses + args.BonusCharges
end

function SpellSummonCheckCharges( unit, args, roomArgs)	
	roomArgs = roomArgs or {}
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpendCost = GetManaSpendCost( data )
	
	if roomArgs.Grouped and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.MaintainSpellCharge and not CurrentRun.CurrentRoom.RestoreUnlockRoomExits then
		CurrentRun.SpellCharge = 0	
	end
	if not CurrentRun.CurrentRoom.SummonEnemyName then
		TraitUIActivateTrait( spellTrait, {CustomAnimation = "InactiveTrait" })
		SetWeaponProperty({ WeaponName = spellTrait.PreEquipWeapons[1], DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	elseif CurrentRun.SpellCharge < manaSpendCost then
		StartCooldownBuff()
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		TraitUIActivateTrait( spellTrait, { CustomAnimation = "ActiveTraitCooldownNoFlash" })
		SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = CurrentRun.SpellCharge/manaSpendCost, DestinationId = spellTrait.TraitActiveOverlay, Instant = true })
	else
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
		SpellActivateTrait( spellTrait )
	end
end

function CheckPolymorphApply( triggerArgs )
	local enemy = triggerArgs.Victim
	if enemy.ImmuneToPolymorph then
		ClearEffect({ Id = enemy.ObjectId, Name = triggerArgs.EffectName })
		return
	end
	if not enemy.IsBoss and enemy ~= CurrentRun.Hero and not enemy.SkipModifiers then
		SetUnitProperty({Property = "ImmuneToStun", Value = false, DestinationId = enemy.ObjectId })
		enemy.RestoreStunBreakModifierValue = GetUnitDataValue({ Property = "StunBreakModifier", Id = enemy.ObjectId })
		enemy.RestoreOffsetZValue = GetThingDataValue({ Property = "OffsetZ", Id = enemy.ObjectId })
		AdjustZLocation({ Distance = -enemy.RestoreOffsetZValue, Id = enemy.ObjectId, Duration = 0.2 })
		SetUnitProperty({Property = "StunBreakModifier", Value = 1, DestinationId = enemy.ObjectId })
		if enemy.Enlarged  then
			thread(PolymorphEnlargeClear, enemy )
		end
		ApplyEffect({
			DestinationId = enemy.ObjectId, 
			Id = CurrentRun.Hero.ObjectId,
			EffectName = "PolymorphStun",
			DataProperties = 
			{
				Duration = triggerArgs.Duration,
				Type = "SPEED",
				Modifier = 0.5,
				DisableMove = false,
				DisableRotate = false,
				DisableAttack = true,
				CanAffectInvulnerable = true,
			}
		})
	elseif enemy.IsBoss then
		if HasHeroTraitValue("PolymorphBossDamage") then
			thread( Damage, enemy, { SourceWeapon = "WeaponSpellPolymorph", SourceProjectile = "ProjectileSpellPolymorph", DamageAmount = GetTotalHeroTraitValue("PolymorphBossDamage"), AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false } )	
		else
			thread( SpellPolymorphResistedPresentation, enemy )
		end
	end
end

function PolymorphCopyStatus( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName ~= "PolymorphTag" or not victim or victim.IsDead then 
		return
	end
	local activeCurses = {}
	for i, enemy in pairs(ActiveEnemies) do
		if enemy ~= victim and not enemy.SkipModifiers and enemy.ActiveEffects then
			for effectName, effectStacks in pairs(enemy.ActiveEffects) do
				if functionArgs.ValidStatusNames[effectName] then
					activeCurses[effectName] = {}
					-- unfortunately (fortunately?) we only store stacks on the unit, we'll have to dig to get other salient data :T @alice
					if effectName == "BurnEffect" then
						if not activeCurses[effectName].NumStacks or activeCurses[effectName].NumStacks < effectStacks then
							activeCurses[effectName].NumStacks = effectStacks
						end
					end
					if effectName == "DamageShareEffect" then
						if not activeCurses[effectName].Amount or activeCurses[effectName].Amount < enemy.DamageShareAmount then
							activeCurses[effectName].Amount = enemy.DamageShareAmount
						end
					end
					if effectName == "DamageEchoEffect" then
						if enemy.ActiveEchoes and enemy.ActiveEchoes[effectName] and enemy.ActiveEchoes[effectName].Payoff and 
							( not activeCurses[effectName].Modifier or activeCurses[effectName].Modifier < enemy.ActiveEchoes[effectName].Payoff ) then
							activeCurses[effectName].Modifier = enemy.ActiveEchoes[effectName].Payoff
						end
					end
					
					if effectName == "DelayedKnockbackEffect" then
						activeCurses[effectName].TriggerDamage = enemy.TriggerDamage 
					end
				end
			end
		end
	end

	for effectName, effectData in pairs( activeCurses ) do
		if type(functionArgs.ValidStatusNames[effectName]) == "string" then
			thread( _G[functionArgs.ValidStatusNames[effectName]], victim, { EffectName = effectName, EffectArgs = { Modifier = effectData.Modifier, Amount = effectData.Amount }, NumStacks = effectData.NumStacks }, {})
		else
			ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].EffectData })				
		end
	end
end

function PolymorphStunApply(triggerArgs)
	local enemy = triggerArgs.Victim
	enemy.IsPolymorphed = true
	OnHitStunApply( triggerArgs )
	if not IsEmpty( enemy.ExpireProjectileIdsOnPolymorph ) then
		ExpireProjectiles({ ProjectileIds = enemy.ExpireProjectileIdsOnPolymorph })
	end
	PolymorphApplyPresentation( triggerArgs )
	if HeroHasTrait("PolymorphSandwichTalent") and not enemy.AlwaysTraitor then
		local polymorphChance = GetTotalHeroTraitValue("PolymorphSandwichChance")
		local polymorphCap = GetTotalHeroTraitValue("PolymorphRoomCap")
		if not enemy.SandwichForm and RandomChance( polymorphChance ) and ( MapState.SandwichCount < polymorphCap ) then
		
			IncrementTableValue( MapState, "SandwichCount" )
			enemy.SandwichForm = CreatePolymorphHealItem(enemy)

			SetAlpha({ Id = enemy.ObjectId, Fraction = 0, Duration = 0.1 })
			SetColor({ Id = enemy.ObjectId, Color = { 0, 0, 0, 0 }, Duration = 0.1 })
			
			SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
			SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = false })
			SetUnitInvulnerable( enemy )
			
		end
	elseif HeroHasTrait("PolymorphTauntTalent") and not enemy.AlwaysTraitor then
		local tauntChance = GetTotalHeroTraitValue( "PolymorphTauntChance" )
		if RandomChance( tauntChance ) then
			enemy.TauntTarget = true
			MapState.TauntTargetIds[enemy.ObjectId] = true
			SetUnitProperty({ Property = "NoAllegiance", Value = true, DestinationId = enemy.ObjectId })
		end
	end
end

function PolymorphStunClear(triggerArgs)
	local enemy = triggerArgs.Victim
	enemy.IsPolymorphed = false
	PolymorphClearPresentation( triggerArgs )
	if enemy.SandwichForm then
		Destroy({ Id = enemy.SandwichForm.ObjectId })
		SetAlpha({ Id = enemy.ObjectId, Fraction = 1, Duration = 0 })
		SetColor({ Id = enemy.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0 })

		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })
		SetUnitVulnerable( enemy )
	end
	if enemy.TauntTarget then
		MapState.TauntTargetIds[enemy.ObjectId] = nil
		enemy.TauntTarget = false
		SetUnitProperty({ Property = "NoAllegiance", Value = false, DestinationId = enemy.ObjectId })
	end

	if enemy.DumbFireWeapons ~= nil then
		for k, weaponName in pairs( enemy.DumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			DebugPrintTable(WeaponData[weaponName])
			if WeaponData[weaponName].CancelOnPolymorph then
				thread( DumbFireAttack, enemy, weaponData )
			end
		end
	end
	
	AdjustZLocation({ Distance = enemy.RestoreOffsetZValue, Id = enemy.ObjectId, Duration = 0.2 })
	SetUnitProperty({Property = "StunBreakModifier", Value = enemy.RestoreStunBreakModifierValue, DestinationId = enemy.ObjectId })
	if enemy.HealthBuffer and enemy.HealthBuffer > 0 then
		SetUnitProperty({Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
	elseif enemy.WasImmuneToStunWithoutArmor then
		SetUnitProperty({Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
	end

	if HasHeroTraitValue("PolymorphHealthMultiplier") and not enemy.AlwaysTraitor then
		local healthMultiplier = GetTotalHeroTraitValue( "PolymorphHealthMultiplier", { IsMultiplier = true })
		local damage = math.floor(enemy.Health - enemy.Health * healthMultiplier)
		if damage > 0 then
			thread( Damage, enemy, { SourceWeapon = "WeaponSpellPolymorph", SourceProjectile = "ProjectileSpellPolymorph", DamageAmount = damage, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true } )	
		end
	end
end

function PolymorphManaRegenSetup( hero, args )
	thread( PolymorphManaRegen, args )
	thread( ManaRegen )
end

function PolymorphManaRegen( args )
	CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		if IsCombatEncounterActive( CurrentRun ) and not CurrentRun.Hero.IsDead and not IsEmpty( RequiredKillEnemies ) then
			wait(0.1, RoomThreadName)
			local enemiesMorphed = 0
			for enemyId, enemy in pairs(RequiredKillEnemies) do
				if enemy.ActiveEffects and enemy.ActiveEffects.PolymorphStun then
					enemiesMorphed = enemiesMorphed + 1
				end
			end
			if enemiesMorphed >= args.RequiredPolymorphTargets then
				CurrentRun.Hero.ManaRegenSources[args.Name] = { Value = args.ManaRegenPerSecond }
			else
				CurrentRun.Hero.ManaRegenSources[args.Name] = nil
			end
		else
			wait( 0.1, RoomThreadName )
		end
	end
end

function CheckPolymorphDeathExplosion( enemy, args )
	if ( enemy.ActiveEffects and enemy.ActiveEffects.PolymorphStun ) or ( enemy.ActiveEffectsAtDamageStart and enemy.ActiveEffectsAtDamageStart.PolymorphStun ) then
		CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, DamageMultiplier = args.ProjectileDamageMultiplier})
	end
end

function CreatePolymorphHealItem( enemy )
	
	local id = SpawnObstacle({ Name = "HealDropRange", DestinationId = enemy.ObjectId, Group = "Standing" })
	local createdHealingItem = CreateConsumableItem( id, "HealDropMinor", 0)
	ApplyUpwardForce({ Id = id, Speed = RandomFloat( 500, 700 ) })
	ApplyForce({ Id = id, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
	
	createdHealingItem.DestroyOnPickupId = enemy.ObjectId
	return createdHealingItem
end

function PolymorphCastTeleport( weaponData, traitArgs, triggerArgs )
	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY then
		return
	end
	local spawnPointId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting" })
	local teleportEnemies = {}	
	for id, enemy in pairs(ActiveEnemies) do
		if enemy.ActiveEffects and enemy.ActiveEffects.PolymorphStun then
			table.insert(teleportEnemies, id )
		end
	end
	if #teleportEnemies > 0 then
		for i, id in pairs(teleportEnemies) do
			local offset = CalcOffset( math.rad( 360 / #teleportEnemies * i), 150 )
			offset.Y = offset.Y * 0.5
			Teleport({ Id = id, DestinationId = spawnPointId, OffsetX = offset.X, OffsetY = offset.Y })
		end
	end
	Destroy({Id = spawnPointId })
end

function SelfBuffOutputApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local fxName = EffectData[triggerArgs.EffectName].DefaultVfxName
		if SessionState.SelfBuffEffectOverride then
			fxName = EffectData[triggerArgs.EffectName].OverrideVfxName
		end
		CreateAnimation({ Name = fxName, DestinationId = CurrentRun.Hero.ObjectId})
		MapState.LastHeroHealth = CurrentRun.Hero.Health
	end
end

function SelfBuffOutputClear( triggerArgs )
	StopAnimation({ Name = EffectData[triggerArgs.EffectName].DefaultVfxName, DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = EffectData[triggerArgs.EffectName].OverrideVfxName, DestinationId = CurrentRun.Hero.ObjectId })
	local selfBuffHealFraction = GetTotalHeroTraitValue("ExpireSelfBuffHeal")
	if selfBuffHealFraction > 0 and CurrentRun.Hero.Health < MapState.LastHeroHealth then
		Heal( CurrentRun.Hero, { HealAmount = round(( MapState.LastHeroHealth - CurrentRun.Hero.Health) * selfBuffHealFraction), Name = "Self Buff Heal" })
	end
	if HeroHasTrait("SelfBuffExpiringNovaTalent") then
		CreateProjectileFromUnit({ Name = "SelfBuffNova", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, DamageMultiplier = GetTotalHeroTraitValue("NovaDamageMultiplier")})
	end
	UnreserveMana( "SelfBuff" )
end

OnWeaponFired{ "WeaponSpellSummon",
	function(triggerArgs)
		local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )
		SpellSummon(triggerArgs, weaponData)
	end
}

function RecordSpellSummonEnemyDeath( enemy, args )

	local weaponName = "WeaponSpellSummon"
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpendCost = GetManaSpendCost( data )

	if not enemy.SkipModifiers and (( not enemy.IsBoss and not enemy.BlockRaiseDead ) or enemy.ForceAllowRaiseDead )
		and not GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "Enabled" }) 
		and CurrentRun.SpellCharge >= manaSpendCost then
			SpellSummonCheckCharges()
	end
end

function SpellSummon( triggerArgs, weaponData )
	if not CurrentRun.CurrentRoom.SummonEnemyName then
		return
	end
	
	local enemyName = CurrentRun.CurrentRoom.SummonEnemyName
	if triggerArgs.Charge >= 1 and weaponData.FullChargeOverride then
		enemyName = weaponData.FullChargeOverride
	end

	local summonArgs = { MaxHealthMultiplier = 1, SpeedMultiplier = 1, ScaleMultiplier = 1, DamageMultiplier = 1}
	if weaponData.SummonMultipliers then
		summonArgs = {
			MaxHealthMultiplier = weaponData.SummonMultipliers.MaxHealthMultiplier or 1,
			SpeedMultiplier = weaponData.SummonMultipliers.SpeedMultiplier or 1,
			ScaleMultiplier = weaponData.SummonMultipliers.ScaleMultiplier or 1,
			DamageMultiplier = weaponData.SummonMultipliers.DamageMultiplier or 1,
		}
	end
	local allyModifiers = GetHeroTraitValues("AllyDataModifiers")
	for i, modifierData in pairs( allyModifiers ) do
		if modifierData.MaxHealthMultiplier then
			summonArgs.MaxHealthMultiplier = summonArgs.MaxHealthMultiplier * modifierData.MaxHealthMultiplier
		end
	end
	local offset = CalcOffset(math.rad(GetAngle({Id = CurrentRun.Hero.ObjectId})), 100 )
	local invaderSpawnPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, ForceToValidLocation = true})
	
	summonArgs.SpawnPointId = invaderSpawnPoint
	local newEnemy = CreateAlliedEnemy( enemyName, summonArgs)
	for i, modifierData in pairs( allyModifiers ) do
		if modifierData.AddOutgoingDamageModifiers then
			for s, damageModifierData in pairs(modifierData.AddOutgoingDamageModifiers) do
				local validSummon = damageModifierData.ValidSummons == nil or Contains(damageModifierData.ValidSummons, newEnemy.Name )
				if validSummon then
					AddOutgoingDamageModifier( newEnemy, damageModifierData)
				end
			end
		end
		if modifierData.OutgoingCritModifiers then
			for s, damageModifierData in pairs(modifierData.OutgoingCritModifiers) do
				local validSummon = damageModifierData.ValidSummons == nil or Contains(damageModifierData.ValidSummons, newEnemy.Name )
				if validSummon then
					AddOutgoingCritModifier( newEnemy, damageModifierData)
				end
			end
		end
		if modifierData.SpeedMultiplier then
			newEnemy.SpeedMultiplier = ( newEnemy.SpeedMultiplier or 1 ) + ( modifierData.SpeedMultiplier - 1)
		end
	end

	for i, data in pairs( GetHeroTraitValues("AddSummonWeaponsToTraits") ) do
		if CurrentRun.Hero.SlottedTraits[data.Slot] then
			local trait = GetHeroTrait(CurrentRun.Hero.SlottedTraits[data.Slot])
			if trait.AddOutgoingDamageModifiers then
				local damageData = DeepCopyTable(trait.AddOutgoingDamageModifiers)
				damageData.ValidWeapons = nil
				damageData.ValidWeaponsLookup = nil
				AddOutgoingDamageModifier( newEnemy, damageData )
			end
			if trait.Name == "ApolloSpecialBoon" then
				newEnemy.ProjectileBlastRadiusMultiplier = 1.4
				newEnemy.ProjectileScaleMultiplier = 1.4
			end
		end
	end

	MapState.SpellSummons = MapState.SpellSummons or {}
	table.insert( MapState.SpellSummons , newEnemy )
	if TableLength( MapState.SpellSummons ) > weaponData.MaxSummons then
		local oldest = table.remove( MapState.SpellSummons , 1 )
		for i, data in pairs( GetHeroTraitValues("OnSummonReplaceFunction")) do
			CallFunctionName( data.Name, oldest, data.Args )
		end
		Kill ( oldest )
	end
	if weaponData.ManaReservationCost then
		ReserveMana(weaponData.ManaReservationCost, weaponData.Name )
	end
	DestroyOnDelay({ invaderSpawnPoint }, 0.1)
	if not HeroHasTrait("SummonPermanenceTalent") then
		thread(EndSpellSummon, newEnemy, weaponData)
	end
end

function FireSummonDeathWeapon( unit )
	CreateProjectileFromUnit({ Name = "SummonDeathWeapon", Id = unit.ObjectId, DestinationId = unit.ObjectId, AutoEquip = true })
end

function EndSpellSummon( enemy, weaponData )
	wait( weaponData.Duration, RoomThreadName )
	Kill( enemy )
end
function DetonateSummon( unit, args )
	CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, DamageMultiplier = args.DamageMultiplier})	
end

function TeleportSummonsToPlayer (teleports)
	if teleports > 0 and not IsEmpty(MapState.SpellSummons) then
		for i, summonData in pairs (MapState.SpellSummons) do
			local offset = CalcOffset( math.rad(180 + GetAngle({Id = CurrentRun.Hero.ObjectId })), 50)
			Teleport({ Id = summonData.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
			TeleportSummonPresentation( summonData.ObjectId )
		end
	end
end

function SummonTakeDamage( unit, args, triggerArgs )
	if not unit or unit.SkipModifiers or not triggerArgs.SourceProjectile then
		return
	end
	for i, summonData in pairs (MapState.SpellSummons) do
		thread( Damage, summonData, { SourceProjectile = triggerArgs.SourceProjectile, DamageAmount = triggerArgs.DamageAmount * args.Multiplier, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true } )	
	end
end

function StartSpellSlow( unit, weaponData, args, triggerArgs )
	local spellDuration = args.Duration
	for i, traitData in pairs( GetHeroTraitValues("TimeSlowModifiers")) do
		if weaponData and traitData.ValidWeapons and Contains(traitData.ValidWeapons, weaponData.Name ) then
			if traitData.AddDuration then
				spellDuration = spellDuration + traitData.AddDuration
			end
		end
	end
	if args.LoopingSound then
		SessionMapState.TimeSlowSoundId = PlaySound({ Name = args.LoopingSound })
	end
	SessionMapState.TimeSlowActive = true
	StartTimeSlowSpeed()
	StartSpellSlowPresentation()
	for i, data in pairs( GetHeroTraitValues("OnTimeSlowStartFunction")) do
		CallFunctionName( data.Name, data.Args )
	end
	for i, timeSlow in pairs( GetHeroTraitValues("TimeSlowModifier") ) do
		if timeSlow < args.Modifier then
			args.Modifier = timeSlow
			args.Force = true
		end
	end
	StartWeaponSlowMotion( triggerArgs, weaponData, args ) 
end

function EndTimeSlow( args )
	SessionMapState.TimeSlowActive = nil
	for i, data in pairs( GetHeroTraitValues("OnTimeSlowEndFunction")) do
		CallFunctionName( data.Name, data.Args )
	end
	if SessionMapState.TimeSlowSoundId then
		StopSound({ Id = SessionMapState.TimeSlowSoundId, Duration = 0.2 })
	end
	if args.EndSlowMotionSound ~= nil then
		PlaySound({ Name = args.EndSlowMotionSound, Id = CurrentRun.Hero.ObjectId })
	end
	thread(EndSpellSlowPresentation)
	EndTimeSlowSpeed()
end

function TimeSlowResetBuff()
	local traitData = GetHeroTrait("TimeSlowCumulativeBuffTalent")
	traitData.TimeSlowDamageBonus = 1
end

function StartTimeSlowCrit ( traitArgs )
	AddOutgoingCritModifier( CurrentRun.Hero, { Name = "TimeSlowCrit", Chance = traitArgs.Chance } )
end

function EndTimeSlowCrit()
	RemoveOutgoingCritModifier( CurrentRun.Hero, "TimeSlowCrit" )
end

function TimeSlowDestroyProjectiles()
	ExpireProjectiles({ ExcludeNames = WeaponSets.TimeSlowExpireProjectileExcludeProjectileNames })
end

function TimeSlowDamageBonus( enemy, functionArgs, triggerArgs )
	if not enemy.SkipModifiers and SessionMapState.TimeSlowActive then
		
		local traitData = GetHeroTrait("TimeSlowCumulativeBuffTalent")
		traitData.TimeSlowDamageBonus = traitData.TimeSlowDamageBonus + functionArgs.DamageIncrease
	end
end

function StartTimeSlowSpeed()
	local totalSpeedChange = GetTotalHeroTraitValue( "TimeSlowSpeed", {IsMultiplier = true })
	if totalSpeedChange ~= 1 then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier * totalSpeedChange
		local allPropertyChanges= {}
		if not MapState.TimeSlowSpeedPropertyChanges then
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
			MapState.TimeSlowSpeedPropertyChanges = allPropertyChanges
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.TimeSlowSpeedPropertyChanges )
	end
end

function EndTimeSlowSpeed()
	local totalSpeedChange = GetTotalHeroTraitValue( "TimeSlowSpeed", {IsMultiplier = true })
	if not IsEmpty(MapState.TimeSlowSpeedPropertyChanges) and totalSpeedChange ~= 1 then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier / totalSpeedChange
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.TimeSlowSpeedPropertyChanges, true, true)
	end
end

function UpdateTalentPointInvestedCache( currentRun )
	currentRun = currentRun or CurrentRun
	local allInvested = true
	local allHighValueInvested = true
	if not CurrentRun.Hero.SlottedSpell then
		CurrentRun.AllSpellInvestedCache = false
		return 
	end

	for i, column in ipairs( CurrentRun.Hero.SlottedSpell.Talents ) do
		for s, talent in pairs( column ) do
			if not talent.Invested then
				allInvested = false
				if talent.Rarity == "Epic" or talent.Rarity == "Rare" then
					allHighValueInvested = false
				end
			end
		end
	end
	CurrentRun.AllSpellInvestedCache = allInvested
	CurrentRun.AllUniqueSpellInvestedCache = allHighValueInvested
end

function ApplySelfBuff(weaponData, traitArgs, triggerArgs )
	ApplyEffect({ 
		Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
		EffectName = traitArgs.EffectName or "SelfBuffOutput", 
		DataProperties = {
		Type = "DAMAGE_OUTPUT", 
		Modifier = traitArgs.Modifier, 
		Duration = traitArgs.Duration }})			
end

function StartWeaponSpellDrain( triggerArgs, weaponData, args )
	thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )
	local notifyName = "SpellDrainRelease"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = "WeaponSpellDrain", ChargeFraction = 0.0, Comparison = "<=" })
	MapState.SpellDrain = true
	thread( DoSpellDrain, weaponData )
	waitUntil( notifyName )
	EndSpellDrain( weaponData )
end

function DoSpellDrain( weaponData )
	local enemyId = 0
	
	while MapState.SpellDrain do
		if enemyId == 0 or not ActiveEnemies[enemyId] or ActiveEnemies[enemyId].IsDead then
			enemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = 1200 })
			if ActiveEnemies[enemyId] and not ActiveEnemies[enemyId].IsDead then
				MapState.SpellDrainTarget = ActiveEnemies[enemyId]
			else
				enemyId = 0
			end
		else
			CurrentRun.Hero.ManaRegenSources.SpellDrain = { Value = weaponData.ManaRegenPerSecond * GetTotalHeroTraitValue("SpellDrainMultiplier", {IsMultiplier = true })}
			--ApplyEffect( { DestinationId = enemyId, Id = CurrentRun.Hero.ObjectId, EffectName = weaponData.DrainEffectName, DataProperties = EffectData[weaponData.DrainEffectName].EffectData })
			CreateAnimationsBetween({ Animation = "DrainFx", DestinationId = enemyId, Id = CurrentRun.Hero.ObjectId, Stretch = true, UseZLocation = false, Group = "FX_Standing_Add" })
		end
		wait( weaponData.DrainInterval)
	end
end

function EndSpellDrain( weaponData )
	MapState.SpellDrain = false
	if MapState.SpellDrainTarget then
		for i, data in pairs(GetHeroTraitValues("OnDrainEndEffect")) do
			local effectName = data.EffectName
			local dataProperties = MergeTables(	EffectData[effectName].EffectData, data.EffectArgs)
			ApplyEffect( { DestinationId = MapState.SpellDrainTarget.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
		end
	end
	SpellReloadStarted( user, weaponData )
	CurrentRun.Hero.ManaRegenSources.SpellDrain = nil
	MapState.SpellDrainTarget = nil
end

function SpellTransform( user, weaponData, functionArgs, triggerArgs )
	SpellReloadStarted( user, weaponData)
	if functionArgs.TransformTexture then
		SetThingProperty({ Property = "GrannyTexture", Value = functionArgs.TransformTexture, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if functionArgs.TransformGraphic then
		SetAnimation({ Name = functionArgs.TransformGraphic, DestinationId = user.ObjectId })
	end
	if functionArgs.RevertAnimationSwaps then
		for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
			local weaponData = WeaponData[weaponName]
			if weaponData ~= nil and weaponData.SwapAnimations ~= nil then
				for fromAnim, toAnim in pairs( weaponData.SwapAnimations ) do
					SwapAnimation({ Name = fromAnim, Reverse = true })
				end
			end
		end
	end
	
	SessionMapState.BlockSpellCharge = true
	MapState.TransformArgs = {}
	MapState.TransformArgs.FunctionArgs = ShallowCopyTable( functionArgs )
	MapState.TransformArgs.Vfx = functionArgs.Vfx
	for _, weaponName in pairs( functionArgs.TransformWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	end
	EndAllControlSwaps({ DestinationId = CurrentRun.Hero.ObjectId })
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		if weaponName ~= "WeaponCast" and weaponName ~= "WeaponSprint" and weaponName ~= "WeaponBlink" then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			SessionMapState.BlockWeaponFailedToFire[weaponName] = true
		end
	end
	local baseThingProperties = {}
	for propertyName, propertyValue in pairs( functionArgs.ThingProperties or {} ) do
		baseThingProperties[propertyName] = GetThingDataValue({ Property = propertyName, Id = CurrentRun.Hero.ObjectId  })
		SetThingProperty({ Property = propertyName, Value = propertyValue, DestinationId = CurrentRun.Hero.ObjectId })
	end
	local baseProperties = {}
	for propertyName, propertyValue in pairs( functionArgs.UnitProperties or {} ) do
		baseProperties[propertyName] = GetUnitDataValue({ Property = propertyName, Id = CurrentRun.Hero.ObjectId  })
		SetUnitProperty({ Property = propertyName, Value = propertyValue, DestinationId = CurrentRun.Hero.ObjectId })
	end
	local baseLuaProperties = {}
	for propertyName, propertyValue in pairs( functionArgs.LuaProperties or {} ) do
		baseLuaProperties[propertyName] = CurrentRun.Hero[propertyName]
		CurrentRun.Hero[propertyName] = propertyValue
	end

	if functionArgs.Scale then
		SetScale({ Id = CurrentRun.Hero.ObjectId, Fraction = functionArgs.Scale, Duration = 0.2 })	
	end
	
	MapState.TransformArgs.BaseThingProperties = ShallowCopyTable( baseThingProperties )
	MapState.TransformArgs.BaseProperties = ShallowCopyTable( baseProperties )
	MapState.TransformArgs.BaseLuaProperties = ShallowCopyTable( baseLuaProperties )
	MapState.TransformArgs.EndGraphic = functionArgs.EndGraphic
	MapState.TransformArgs.EndVfx = functionArgs.EndVfx
	MapState.TransformArgs.Scale = functionArgs.Scale

	SetPlayerInvulnerable("SpellTranform")

	SpellTransformStartPresentation( user, weaponData, functionArgs, triggerArgs )
	for i, data in pairs(GetHeroTraitValues("TransformFunctionNames")) do
		thread( CallFunctionName, data.StartTransformFunctionName, data.Args )
	end
	CreateAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = functionArgs.StartVfx, DestinationId = CurrentRun.Hero.ObjectId })
	local totalDuration = weaponData.Duration + GetTotalHeroTraitValue("TransformDurationIncrease")
	waitUnmodified( totalDuration - 3 )
	thread(SpellTransformWarnPresentation)
	waitUnmodified(1)
	thread(SpellTransformWarnPresentation)
	waitUnmodified(1)
	thread(SpellTransformWarnPresentation)
	waitUnmodified(1)
	EndSpellTransform(functionArgs)
end

function EndSpellTransform( )
	if not MapState.TransformArgs then
		return
	end
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	for _, weaponName in pairs( MapState.TransformArgs.FunctionArgs.TransformWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		if not MapState.HostilePolymorph then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
		end
		SessionMapState.BlockWeaponFailedToFire[weaponName] = nil
	end
	if MapState.TransformArgs.Vfx then
		StopAnimation({ Name = MapState.TransformArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
	end

	for propertyName, propertyValue in pairs( MapState.TransformArgs.BaseProperties or {} ) do
		SetUnitProperty({ Property = propertyName, Value = propertyValue, DestinationId = CurrentRun.Hero.ObjectId })
	end
	for propertyName, propertyValue in pairs( MapState.TransformArgs.BaseThingProperties or {} ) do
		SetThingProperty({ Property = propertyName, Value = propertyValue, DestinationId = CurrentRun.Hero.ObjectId })
	end
	for propertyName, propertyValue in pairs( MapState.TransformArgs.BaseLuaProperties or {} ) do
		CurrentRun.Hero[propertyName] = propertyValue
	end

	if MapState.TransformArgs.Scale then
		local targetScale = 1
		if HeroHasTrait("CirceShrinkTrait") then
			targetScale = TraitData.CirceShrinkTrait.SetupFunction.Args.ScaleMultiplier
		elseif HeroHasTrait("CirceEnlargeTrait") then
			targetScale = TraitData.CirceEnlargeTrait.SetupFunction.Args.ScaleMultiplier
		end
		SetScale({ Id = CurrentRun.Hero.ObjectId, Fraction = targetScale, Duration = 0.2 })
	end
	
	if MapState.TransformArgs.EndVfx then
		CreateAnimation({ Name = MapState.TransformArgs.EndVfx, DestinationId = CurrentRun.Hero.ObjectId })
	end
	SetPlayerVulnerable("SpellTranform")

	SpellTransformEndPresentation()
	SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
	SetupCostume( MapState.HostilePolymorph )
	HandleWeaponAnimSwaps()
	if MapState.TransformArgs.EndGraphic and not MapState.HostilePolymorph then
		SetAnimation({ Name = MapState.TransformArgs.EndGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
	for i, data in pairs(GetHeroTraitValues("TransformFunctionNames")) do
		thread( CallFunctionName, data.EndTransformFunctionName, data.Args )
	end
	SessionMapState.BlockSpellCharge = false
	MapState.TransformArgs = nil
end

function AddTransformAttackSpeed( functionArgs )	
	ApplyUnitPropertyChanges( CurrentRun.Hero, 
	{
		{
			WeaponName = "WeaponTransformAttack",
			WeaponProperty = "Cooldown",
			ChangeValue = 1/functionArgs.AttackSpeed,
			ChangeType = "Multiply",
		},
		{
			WeaponName = "WeaponTransformAttack",
			ProjectileProperty = "Speed",
			ChangeValue = functionArgs.AttackSpeed,
			ChangeType = "Multiply",
		}
	} )
end

function RemoveTransformAttackSpeed( functionArgs )
	-- Automatically reset via unequipping the weapons
end

function DisableCastArm()
	SessionMapState.CastArmEnabledValue = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCastArm", Property = "Enabled" })
	SessionMapState.CastArmDisabled = true
	SessionMapState.SuperchargeCast = true
	SetWeaponProperty({ WeaponName = "WeaponCastArm", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })	
end

function EnableCastArm()
	SessionMapState.CastArmDisabled = nil
	SessionMapState.SuperchargeCast = nil
	SetWeaponProperty({ WeaponName = "WeaponCastArm", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = SessionMapState.CastArmEnabledValue })
end

function TransformArmCast()
	if MapState.TransformArgs then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponCastArm", Method = "ArmProjectiles" })
	end
end

function SpellHasMana( weaponData )
	if MapState.SpellFireOnRelease ~= nil then
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "FireOnRelease", Value = MapState.SpellFireOnRelease })
		MapState.SpellFireOnRelease = nil
	end
	--thread( SpellHasManaPresentation )
end

function SpellHasNoMana( weaponData )
	MapState.SpellFireOnRelease = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "FireOnRelease"})
	SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "FireOnRelease", Value = true })
	--thread( SpellHasNoManaPresentation )
end

function SpellPotion( owner, weaponData, args )
	local traitData = GetHeroTrait("SpellPotionTrait")
	if traitData.RemainingUses > 0 then
		traitData.RemainingUses = traitData.RemainingUses - 1
		UpdateTraitNumber( traitData )
		if traitData.RemainingUses > 0 then
			SpellReloadStarted(user, weaponData)
		else
			if traitData.AnchorId then
				StopAnimation({ DestinationId = traitData.AnchorId, Name = "DarkSorceryReady" })
			end
			TraitUIActivateTrait( traitData, {CustomAnimation = "InactiveTrait" })
		end
		local manaRestore = GetTotalHeroTraitValue("PotionManaRestored")
		if manaRestore > 0 then
			ManaDelta( manaRestore )
		end
		if HeroHasTrait("HealRetaliateTalent")  then
			local attacker = nil
			local triggerArgs = { ManuallyTriggered = true, Victim = CurrentRun.Hero, DamageAmount = 10}
			
			if SessionMapState.LastHeroDamage and SessionMapState.LastHeroDamage.Attacker and not SessionMapState.LastHeroDamage.Attacker.IsDead then
				attacker = SessionMapState.LastHeroDamage.Attacker
				if SessionMapState.LastHeroDamage.Damage then
					triggerArgs.DamageAmount = SessionMapState.LastHeroDamage.Damage
				end
			end
			if not attacker then
				local nearestId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, StopsProjectiles = true })			
				if ActiveEnemies[nearestId] and not ActiveEnemies[nearestId].IsDead then
					attacker = ActiveEnemies[nearestId]
				end
			end
			if attacker then
				for i, functionData in pairs( GetHeroTraitValues("OnSelfDamagedFunction") ) do
					CallFunctionName( functionData.Name, attacker, functionData.FunctionArgs, triggerArgs )
				end	
			end
		end

		if args.HealDelay then
			wait( args.HealDelay )
		end
		thread( SpellPotionUsedPresentation, owner, weaponData )
		local healAmount= round((args.Amount + GetTotalHeroTraitValue("BonusSpellHeal") + SessionMapState.SpellHealWindow) *  CalculateHealingMultiplier())
		Heal( CurrentRun.Hero, { HealAmount = healAmount, SourceName = "SpellPotion", Silent = false } )
		SessionMapState.SpellHealWindow = 0
		CurrentRun.SpellCharge = 0
		if traitData.RemainingUses > 0 then
			UpdateTraitNumber( traitData )
		end
		local goldGranted = GetTotalHeroTraitValue("MoneyOnSpell")
		if goldGranted > 0 then
			thread( GushMoney, { Amount = goldGranted, LocationId = CurrentRun.Hero.ObjectId, Radius = 100, Source = "Spell Gold Trait"})		
		end
		local clearCastDuration = GetTotalHeroTraitValue("ClearCastDuration")
		if clearCastDuration > 0 then
			thread( StartClearCastPresentation )
			local dataProperties = EffectData.ClearCast.DataProperties
			dataProperties.Duration = clearCastDuration
			ApplyEffect( MergeTables({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ClearCast", DataProperties = dataProperties }))
		end
	end
	if traitData.RemainingUses <= 0 then
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
end

function StartSpellCharge( triggerArgs, weaponData, dataArgs)
	thread(SpellChargePresentation, triggerArgs, weaponData)
	if dataArgs.DisableBlink then
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = dataArgs.TimeSlowModifier, Name = weaponData.Name .. "SpellSlow", Force =  true, TimeSlowPresentationFunction = dataArgs.SpellChargePresentationFunction or "SpellChargeTimeSlowPresentation" })
	local notifyName = weaponData.Name .. "Fired"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=", Timeout = dataArgs.Duration })
	waitUntil( notifyName )	
	
	thread( SpellChargeEndPresentation )
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = dataArgs.TimeSlowModifier, Reverse = true, Name = weaponData.Name .. "SpellSlow", EndTimeSlowPresentationFunction = "SpellChargeEndTimeSlowPresentation" })
	if dataArgs.DisableBlink and not dataArgs.ManualBlinkReenable then
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	end
end

function LaserSpellFire(unit, weaponData )
	if not SessionMapState.LaserSpellDown then
		for i, data in pairs( GetHeroTraitValues("AddWeaponsToTraits") ) do
			if CurrentRun.Hero.SlottedTraits[data.Slot] then
				local trait = GetHeroTrait(CurrentRun.Hero.SlottedTraits[data.Slot])
				if trait.AddOutgoingDamageModifiers then
					local weaponData = DeepCopyTable( trait.AddOutgoingDamageModifiers )
					weaponData.ValidWeapons = { data.WeaponName }
					weaponData.ValidWeaponsLookup = ToLookup( weaponData.ValidWeapons )
					weaponData.Name = "TempLaserBonus"
					AddOutgoingDamageModifier( CurrentRun.Hero, weaponData )
				end
			end
		end	
		--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeSpellFireHoldFrame"})
		if GetTotalHeroTraitValue("DefenseDuringLaser") > 0 then
			local laserDefenseValue = GetTotalHeroTraitValue("DefenseDuringLaser")
			AddIncomingDamageModifier( CurrentRun.Hero, 
				{
					Name = "LaserDefense",
					GlobalMultiplier = 1 - laserDefenseValue,
					Temporary = true,
				})
		end
		if not HeroHasTrait("LaserCrystalTalent") then
			local dataProperties = DeepCopyTable( EffectData.LaserFireCancelable.DataProperties )
			dataProperties.DisableRotate = GetConfigOptionValue({ Name = "UseMouse" }) 
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "LaserFireCancelable", DataProperties = dataProperties})	
			thread( LaserSpellForceRelease, weaponData )
			SessionMapState.LaserSpellDown = true
			thread( ForceLaserFacing )
		else
			SessionMapState.LaserSpellDown = true
			LaserHoldClear()
		end
		notifyExistingWaiters( weaponData.Name.."Fire" )
	end
end

function LaserSpellForceRelease( weaponData )
	SetProjectileProperty({ WeaponName = "WeaponSpellLaser", DestinationId = CurrentRun.Hero.ObjectId, Property = "TotalFuse", Value = duration })
	local duration = weaponData.MaxDuration + GetTotalHeroTraitValue("LaserDurationBonus")
	waitUnmodified( duration, RoomThreadName)
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "LaserFireCancelable"})
end

function LaserMatchDuration( hero, args )
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSpellLaser")
	local duration = weaponData.MaxDuration + GetTotalHeroTraitValue("LaserDurationBonus")
	SetProjectileProperty({ WeaponName = "WeaponSpellLaser", DestinationId = CurrentRun.Hero.ObjectId, Property = "TotalFuse", Value = duration })
end

function ForceLaserFacing()
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting"})
	local autolockArc = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponSpellLaser", Property = "AutoLockArcDistance" })
	local range = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponSpellLaser", Property = "AutoLockRange" })
	local validTarget = true
	while SessionMapState.LaserSpellDown do
			
		if GetConfigOptionValue({ Name = "UseMouse" }) then
			local cursorLocation = GetCursorWorldLocation({})
			Teleport({ Id = targetId, OffsetX = cursorLocation.X, OffsetY = cursorLocation.Y, DestinationIsScreenRelative = false })
		else
			local autoLockId = GetAutoLockId({ Id = CurrentRun.Hero.ObjectId, Arc = autolockArc, Range = range, UseController = true })
			if autoLockId ~= 0 and ActiveEnemies[autoLockId] ~= nil and not ActiveEnemies[autoLockId].IsDead then
				Attach({ Id = targetId, DestinationId = autoLockId})
				validTarget = true
			else
				validTarget = false
			end
		end
		-- CompleteAngle is required so dashing out keeps the right facing
		if validTarget then
			AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, CompleteAngle = true })
		end
		wait(0.03)
	end
	Destroy({ Id = targetId})
end

function LaserHoldClear(unit )
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSpellLaser")
	CurrentRun.SpellCharge = 0
	SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	ExpireProjectiles({ Names = {"ProjectileSpellLaser"}})	
	RemoveOutgoingDamageModifier( CurrentRun.Hero, "TempLaserBonus")
	local spellTrait = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
		end
	end
	if spellTrait then
		UpdateSpellActiveStatus()
		StartCooldownBuff()
		thread(SpellUnreadyPresentation, spellTrait)
	end
	if not MapState.HostilePolymorph then
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "Melinoe_ForwardCast_End"})
	end
	RemoveIncomingDamageModifier( CurrentRun.Hero, "LaserDefense" )
	SessionMapState.LaserSpellDown = nil
end

function LaserSpellReload( owner, weaponData, onChargeFunctionArgs )
	SpellReloadStarted(owner, weaponData )
end

function SpellReloadStarted( owner, weaponData )
	local traitData = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if traitData ~= nil then
		SpellReloadPresentation( owner, weaponData )
		--local remainingTime = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "NextClipRegenTime" })
		--thread( OnStartSpellCooldown, remainingTime )
	end
end

function StartCooldownBuff( )
	local totalMoveSpeedChange = GetTotalHeroTraitValue( "HexCooldownMoveSpeedBuff", {IsMultiplier = true })
	if totalMoveSpeedChange ~= 1 then
		if not MapState.HexMoveSpeedPropertyChanges then
			MapState.HexMoveSpeedPropertyChanges = 
			{
				{
					UnitProperty = "Speed",
					ChangeType = "Multiply",
					ChangeValue = totalMoveSpeedChange,
				},
				{
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocity",
					ChangeValue = 1100 * (totalMoveSpeedChange - 1),
					ChangeType = "Add",
					ExcludeLinked = true,
				},
				{
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocityCap",
					ChangeValue = 740 * ( totalMoveSpeedChange - 1),
					ChangeType = "Add",
					ExcludeLinked = true,
				},
			}
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.HexMoveSpeedPropertyChanges )
	end
	
	local totalDodgeChange = GetTotalHeroTraitValue( "HexCooldownDodgeBuff")
	if totalDodgeChange > 0 then
		MapState.HexCooldownDodgeChance = totalDodgeChange
		SetLifeProperty({ Property = "DodgeChance", Value = totalDodgeChange, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	
	local totalSpeedChange = GetTotalHeroTraitValue( "HexCooldownSpeedBuff", {IsMultiplier = true })
	if not IsEmpty(MapState.HexSpeedPropertyChanges) and totalSpeedChange ~= 1 then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier / totalSpeedChange
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.HexSpeedPropertyChanges, true, true)
	end
end

function EndCooldownBuff()
	local totalSpeedChange = GetTotalHeroTraitValue( "HexCooldownSpeedBuff", {IsMultiplier = true })
	if totalSpeedChange ~= 1 then
		MapState.MapSpeedMultiplier = MapState.MapSpeedMultiplier * totalSpeedChange
		local allPropertyChanges= {}
		if not MapState.HexSpeedPropertyChanges then
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
					ChangeValue = 1100 * ( 1/totalSpeedChange - 1),
					ChangeType = "Add",
					ExcludeLinked = true,
				},
				{
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocityCap",
					ChangeValue = 740 * ( 1/totalSpeedChange - 1),
					ChangeType = "Add",
					ExcludeLinked = true,
				},
			} )
			MapState.HexSpeedPropertyChanges = allPropertyChanges
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.HexSpeedPropertyChanges )
	end

	if MapState.HexCooldownDodgeChance > 0 then
		
		SetLifeProperty({ Property = "DodgeChance", Value = -MapState.HexCooldownDodgeChance, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end

	local totalMoveSpeedChange = GetTotalHeroTraitValue( "HexCooldownMoveSpeedBuff", {IsMultiplier = true })
	if not IsEmpty(MapState.HexMoveSpeedPropertyChanges) and totalMoveSpeedChange ~= 1 then
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.HexMoveSpeedPropertyChanges, true, true)
	end
end


function SetupSpellLeap( owner, weaponData, functionArgs, triggerArgs )
	CheckSpellMultiuse( weaponData.Name )
	FreezePlayerUnit("SpellLeap")
	local lockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.TargetX, LocationY = triggerArgs.TargetY })
	local distanceToTarget = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = lockedTargetId })
	local immuneToForceReset = GetThingDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce" })

	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = true })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = lockedTargetId })
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	SetPlayerNotStopsProjectiles( "SpellLeap" )

	Halt({ Id = CurrentRun.Hero.ObjectId })
	if HeroHasTrait("LeapLaunchAoETalent") then
		local projectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Projectile" })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponData.Name,
			Type = "Projectile",
		})
		CreateProjectileFromUnit({ WeaponName = weaponData.Name, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
	
	end

	SetAnimation({ Name = weaponData.LeapRiseAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapRiseStreaks", DestinationId = CurrentRun.Hero.ObjectId })
	if weaponData.LeapRiseSound then
		PlaySound({ Name = weaponData.LeapRiseSound, Id = CurrentRun.Hero.ObjectId })
	end
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = lockedTargetId })

	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = weaponData.RiseDistance, Duration = weaponData.RiseTime, EaseIn = 0.85, EaseOut = 1.0 })
	wait( weaponData.RiseTime + weaponData.HangTime, RoomThreadName )

	SetAnimation({ Name = weaponData.LeapFlightAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitter", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterBright", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterDisplace", DestinationId = CurrentRun.Hero.ObjectId })

	if weaponData.LeapFlightSound then
		PlaySound({ Name = weaponData.LeapFlightSound, Id = CurrentRun.Hero.ObjectId })
	end

	local landingEaseIn = 0.0
	local landingEaseOut = 0.1

	AdjustZLocation({Id = CurrentRun.Hero.ObjectId, Distance = -GetZLocation({ Id = CurrentRun.Hero.ObjectId }), Duration = weaponData.LandingTime, EaseIn = landingEaseIn, EaseOut = landingEaseOut })
	Move({ Id = CurrentRun.Hero.ObjectId, 
		Angle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = lockedTargetId }), 
		Distance = distanceToTarget, 
		Speed = distanceToTarget / weaponData.LandingTime,
		EaseIn = landingEaseIn, EaseOut = landingEaseOut, })
	
	thread( LeapSimSlow, weaponData, weaponData.LandingTime )
	wait(weaponData.LandingTime, RoomThreadName)

	SetAnimation({ Name = weaponData.LeapLandingAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	if weaponData.LeapLandingSound then
		PlaySound({ Name = weaponData.LeapLandingSound, Id = CurrentRun.Hero.ObjectId })
	end
	Halt({ Id = CurrentRun.Hero.ObjectId })
	Destroy({ Id = lockedTargetId })
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = true })
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = true })
	SetPlayerStopsProjectiles( "SpellLeap" )
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = immuneToForceReset })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	
	local projectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Projectile" })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponData.Name,
		Type = "Projectile",
	})
	CreateProjectileFromUnit({ WeaponName = weaponData.Name, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
	UnfreezePlayerUnit("SpellLeap")
	local invulnerableTime = GetTotalHeroTraitValue("LeapInvulnerability")
	if invulnerableTime > 0 then
		local dataProperties = EffectData.MeteorInvincibubble.DataProperties 
		dataProperties.Duration = invulnerableTime
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "MeteorInvincibubble", DataProperties = dataProperties })
	end
	MapState.LeapCritCharges = GetTotalHeroTraitValue("LeapCritCount")
	if MapState.LeapCritCharges > 0 then
		local trait = GetHeroTrait("LeapCritTalent")
		if trait.LeapCritVfx then
			CreateAnimation({ Name = trait.LeapCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
	if GetTotalHeroTraitValue("SpellMultiuse") > 0 and SessionMapState.SpellMultiuseCount < GetTotalHeroTraitValue("SpellMultiuse") then
		ChargeSpell(-1000, {Force = true })			
		SessionMapState.SpellMultiuseCount = SessionMapState.SpellMultiuseCount + 1
		local traitData = GetHeroTrait("SpellLeapTrait")
		TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitSingle", PlaySpeed = 30 / GetTotalHeroTraitValue("MultiuseTimeout") })
		thread(SpellMultiuseExpire, weaponData.Name)
	else
		SessionMapState.SpellMultiuseCount = 0
	end
end
function SpellMultiuseExpire( weaponName )
	local traitData = GetHeroTrait("SpellLeapTrait")
	waitUnmodified(GetTotalHeroTraitValue("MultiuseTimeout"), "MultiuseExpire" )
	SessionMapState.SpellMultiuseCount = 0
	if not MapState.HostilePolymorph and GetWeaponChargeFraction({Name = weaponName}) > 0 then
		SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	end
	CurrentRun.SpellCharge = 0
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "ForceControlRelease" })
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	UpdateSpellActiveStatus()
	StartCooldownBuff()
	thread(SpellUnreadyPresentation, traitData)
end

function CheckSpellMultiuse( weaponName )
	killTaggedThreads("MultiuseExpire")
end

function LeapSimSlow( weaponData, descentTime )
	if weaponData.TouchdownSimSlow then
		local simSlowData = weaponData.TouchdownSimSlow
		wait( weaponData.TouchdownSimSlow.LeapFraction * descentTime, RoomThreadName)
		AddSimSpeedChange( "LastStand", { Fraction = simSlowData.Fraction, LerpTime = 0.0001, Priority = true } )
		waitUnmodified(simSlowData.Duration, RoomThreadName )
		RemoveSimSpeedChange( "LastStand", { LerpTime = 0.4 } )

		wait((1 - weaponData.TouchdownSimSlow.LeapFraction) * descentTime - simSlowData.Duration * simSlowData.Fraction, RoomThreadName)
	end
end

function ApplyLeapSprint( victim, functionArgs, triggerArgs)
	if not CurrentRun.Hero.SlottedTraits.Rush then
		return
	end

	if not CheckCountInWindow("LeapSprintEffect", 0.35, functionArgs.MaximumCount) then
		-- Apollo and Hera's sprint action effects
		local sprintTraitData = GetHeroTrait(CurrentRun.Hero.SlottedTraits.Rush)
		if sprintTraitData.OnSprintAction then
			local onSprintAction = sprintTraitData.OnSprintAction
			if onSprintAction.RunOnce then
				local args = DeepCopyTable(onSprintAction.Args)
				args.Cooldown = 0
				CallFunctionName( onSprintAction.FunctionName, args )
			else
				CheckSprintBoons()
			end
			return
		end
		-- Aphrodite's detonate on dash
		local blinkProjectile = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "Projectile" })
		if blinkProjectile then
			local derivedValues = GetDerivedPropertyChangeValues({
				ProjectileName = blinkProjectile,
				WeaponName = "WeaponBlink" ,
				Type = "Projectile",
			})
			CreateProjectileFromUnit({ WeaponName = "WeaponBlink", Name = blinkProjectile, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, FireFromTarget = true, 
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges})
		end
		-- Hestia mana drain effect
		if sprintTraitData.OnSprintManaDrain then
			local sprintArgs = DeepCopyTable( sprintTraitData.OnSprintManaDrain.FunctionArgs )
			sprintArgs.TargetId = victim.ObjectId
			thread( CallFunctionName, sprintTraitData.OnSprintManaDrain.FunctionName, sprintArgs)
		end
		-- Hephaestus is handled directly :T
		if sprintTraitData.SprintStrikeDamageMultiplier and not ProjectileHasUnitHit(triggerArgs.ProjectileId, "HephLeapSprintStrike" ) then
			ProjectileRecordUnitHit(triggerArgs.ProjectileId, "HephLeapSprintStrike")
			local blastModifier = GetTotalHeroTraitValue( "MassiveAttackSizeModifier", { IsMultiplier = true })
			CreateProjectileFromUnit({ Name = "HephSprintBlast", Id = CurrentRun.Hero.ObjectId, DamageMultiplier = GetTotalHeroTraitValue("SprintStrikeDamageMultiplier", {IsMultiplier = true}), DestinationId = victim.ObjectId, BlastRadiusModifier = blastModifier, FireFromTarget = true })
		end
		-- Continuous effect boons
		if sprintTraitData.OnWeaponFiredFunctions then
			local sprintFunctionName = sprintTraitData.OnWeaponFiredFunctions.FunctionName
			local sprintFunctionArgs = DeepCopyTable(sprintTraitData.OnWeaponFiredFunctions.FunctionArgs)
			-- strip conditions and costs
			sprintFunctionArgs.TargetId = victim.ObjectId
			sprintFunctionArgs.Cooldown = 0
			sprintFunctionArgs.CostPerStrike = 0
			sprintFunctionArgs.RunFunctionNameOnTarget = nil
			sprintFunctionArgs.SprintSound = nil
			sprintFunctionArgs.ManaCost = 0
			sprintFunctionArgs.DetachInterval = 0
			thread( CallFunctionName, sprintFunctionName, GetWeaponData("WeaponSprint"), sprintFunctionArgs )
		end
	end
end

function LeapEnableBlink(weaponData,functionArgs, triggerArgs)
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
end

function RecordLastDamaged( attacker, args, triggerArgs )
	if triggerArgs.ManuallyTriggered or not attacker then
		return
	end
	local damage = triggerArgs.DamageAmount
	if damage == nil then
		return
	end
	SessionMapState.LastHeroDamage = { Id = attacker.ObjectId, Attacker = attacker, Damage = damage }
end

function RecordDamageInWindow( attacker, args, triggerArgs )
	if triggerArgs.ManuallyTriggered then
		return
	end
	local damage = triggerArgs.DamageAmount
	if damage == nil then
		return
	end
	if CurrentRun.Hero.Health <= 0 then
		-- Never trigger on death defiance or actual death
		return
	end

	SessionMapState.SpellHealWindow = SessionMapState.SpellHealWindow + damage
	thread(ReleaseDamageInWindow, args.HealWindowDuration, damage )
end

function ReleaseDamageInWindow( delay, damage )
	waitUnmodified( delay, RoomThreadName )
	
	SessionMapState.SpellHealWindow = SessionMapState.SpellHealWindow - damage
	if SessionMapState.SpellHealWindow < 0 then
		SessionMapState.SpellHealWindow = 0
	end
end

function GetManaSpendCost( weaponData )
	local manaCost = weaponData.ManaSpendCost or 0

	local manaModifiers = GetHeroTraitValues("ManaSpendCostModifiers")
	local manaMultiplier = 1
	for i, data in pairs(manaModifiers) do
		
		if data.Add then
			manaCost = manaCost + data.Add
		end
		if data.Multiplier then
			manaMultiplier = manaMultiplier * data.Multiplier	
		end
	end
	manaCost = manaCost * manaMultiplier
	return manaCost
end

function MeteorCheckInvulnerability( weaponData, args, triggerArgs )
	local duration = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Fuse" })
	SetPlayerInvulnerable("MeteorIncoming")
	local dataProperties = EffectData.MeteorInvincibubble.DataProperties 
	dataProperties.Duration = duration
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "MeteorInvincibubble", DataProperties = dataProperties })
	thread( MeteorResetVulnerability, duration )
end

function MeteorResetVulnerability( duration )
	waitUnmodified( duration, RoomThreadName )
	SetPlayerVulnerable("MeteorIncoming")
end

function MeteorStartVulnerability( weaponData, args, triggerArgs )
	local touchdownPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting"})
	thread( MeteorVulnerabilityThread, touchdownPoint, weaponData, args )
end

function MeteorVulnerabilityThread( destinationId, weaponData, args)
	local radius = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "DamageRadius" })
	local duration = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Fuse" }) + GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "ProjectileInterval"})
	local scaleX = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "DamageRadiusScaleX" })
	local scaleY = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "DamageRadiusScaleY" })
	
	local endTime = _worldTimeUnmodified + duration
	while _worldTimeUnmodified < endTime do
		local ids = GetClosestIds({ Id = destinationId, Distance = radius, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, ScaleX = scaleX, ScaleY = scaleY })
		for _, id in pairs(ids) do
			local effectName = args.EffectName
			local dataProperties = ShallowCopyTable(EffectData[effectName].DataProperties)
			dataProperties.Modifier = args.Modifier
			ApplyEffect({ DestinationId = id, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
			if args.AdditionalEffect then
				ApplyEffect({ DestinationId = id, Id = CurrentRun.Hero.ObjectId, EffectName = args.AdditionalEffect, DataProperties = EffectData[args.AdditionalEffect].DataProperties })
			end
		end
		waitUnmodified( 0.2, RoomThreadName )
	end
	Destroy({Id = destinationId })
end
function MeteorFirePreattack( weaponData, args, triggerArgs )
	local touchdownPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting"})
	thread( MeteorPreattackThread, touchdownPoint, weaponData, args )
end

function MeteorPreattackThread( destinationId, weaponData, args)
	local radius = args.Radius or GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "DamageRadius" })
	local scaleX = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "DamageRadiusScaleX" })
	local scaleY = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "DamageRadiusScaleY" })
	local duration = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Fuse" }) + GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "ProjectileInterval"})
	local endTime = _worldTimeUnmodified + duration
	local count = 0
	while count < args.Count do
		local offsetX = RandomFloat(-radius * scaleX, radius * scaleX)
		local offsetY =  RandomFloat( -radius*scaleY, radius*scaleY )
		CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = destinationId, OffsetX = offsetX , OffsetY = offsetY, FireFromTarget = true })
		waitUnmodified( args.Interval, RoomThreadName )
		count = count + 1
	end
	Destroy({Id = destinationId })
end

function MeteorExCast( triggerArgs, functionArgs )
	if triggerArgs.LocationX and triggerArgs.LocationY then
		local weaponName = "WeaponCast"
		local projectileName = "ProjectileCast"
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName,
			Type = "Projectile",
		})
		derivedValues.ThingPropertyChanges = derivedValues.ThingPropertyChanges or {}
		derivedValues.ThingPropertyChanges.Graphic = "null"
		local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
			ArmAndDetonateProjectiles({ Ids = { projectileId }})
		Destroy({Id = dropLocation })
	end
end

function SorceryChargeSetup( hero, args )
	while not hero.IsDead do
		if CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
			ChargeSpell( -1 )
			waitUnmodified( 1/args.ChargePerSecond, RoomThreadName )
		else
			waitUnmodified(1.0, RoomThreadName)
		end
	end
end