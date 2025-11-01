function CreateTalentTree( spellData )	
	local uniqueTalents = {}
	local legendaryTalents = {}
	local duoTalents = {}
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
		for i, talentName in pairs( spellData.Talents.Legendary ) do
			if not TraitData[talentName].GameStateRequirements or ( IsGameStateEligible( TraitData[talentName], TraitData[talentName].GameStateRequirements ) and IsGameStateEligible(source, SpellTalentData.ServeDuoGameRequirements ) ) then
				if TraitData[talentName].IsDuoBoon then
					table.insert( duoTalents, talentName )
				else
					table.insert( legendaryTalents, talentName )
				end
			end
		end
	end
	local eligibleStructures = {}
	for name, data in pairs(SpellTalentData.TalentTreeStructures) do
		if ( CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.TestRoom ) or not data.GameStateRequirements or IsGameStateEligible( data, data.GameStateRequirements ) then
			local structure = DeepCopyTable(data.Structure)
			structure.Name = data.Name
			table.insert(eligibleStructures, structure)
		end
	end

	local treeStructure =  GetRandomValue( eligibleStructures )
	local validDuos = not IsEmpty(duoTalents)
	local condemnedIndexes = {}
	for depths, data in ipairs(treeStructure) do
		for s, node in pairs(data) do
			
			if not validDuos and node.Pool and ( node.Pool.OlympianSpell or node.Pool.OlympianCount) then
				table.insert(condemnedIndexes, { Depth = depths, Key = s })

			end
		end
	end
	
	for i, data in pairs( condemnedIndexes ) do
		treeStructure[data.Depth][data.Key] = nil
	end
	local traitCount = {}
	for depth, data in ipairs(treeStructure) do
		for s, node in pairs(data) do
			if IsEmpty( availableTalents ) then
				if spellData.Talents.Repeatable then
					availableTalents = {}
					for _, traitName in pairs( spellData.Talents.Repeatable ) do
						if not TraitData[traitName].MaxCount or ( traitCount[traitName] and traitCount[traitName] < TraitData[traitName].MaxCount ) then
							table.insert( availableTalents, traitName )		
						end
					end
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
					DebugAssert({ Condition = false, Text = "No rare talents available to serve!", Owner = "Alice" })
					-- Serve heroic repeatable boon if we're out of unique talents
					traitName = RemoveRandomValue( availableTalents )
					rarity = "Heroic"
				end
			elseif talentType == "Legendary" then
				if not IsEmpty(legendaryTalents) then
					traitName = RemoveRandomValue( legendaryTalents )
					rarity = "Epic"
				else
					DebugAssert({ Condition = false, Text = "No legendary talents available to serve!", Owner = "Alice" })
					-- Serve heroic repeatable boon if we're out of unique talents
					traitName = RemoveRandomValue( availableTalents )
					rarity = "Heroic"
				end
			elseif talentType == "OlympianCount" then
				traitName = "OlympianSpellCountTalent"
				rarity = "Common"
			elseif talentType == "OlympianSpell" then
				if not IsEmpty( duoTalents ) then
					traitName = RemoveRandomValue( duoTalents )
				else
					DebugAssert({ Condition = false, Text = "No duo talents available to serve!", Owner = "Alice" })
					-- Serve heroic repeatable boon if we're out of unique talents
					traitName = RemoveRandomValue( availableTalents )
					rarity = "Heroic"
				end
			end
			IncrementTableValue(traitCount, traitName)
			node.Name = traitName
			node.Rarity = rarity
		end
	end
	-- generating backlinks
	for depth, data in ipairs(treeStructure) do
		for s, node in pairs(data) do
			if node.LinkTo then
				for _, linkToIndex in pairs(node.LinkTo) do
					if treeStructure[depth+1][linkToIndex] then
						if not treeStructure[depth+1][linkToIndex].LinkFrom then
							treeStructure[depth+1][linkToIndex].LinkFrom = {}
						end
						table.insert(treeStructure[depth+1][linkToIndex].LinkFrom, s)
					end
				end
			end
		end
	end
	return treeStructure
end

function CheckAndAddOlympianDuo( source )
	if not CurrentRun.Hero.SlottedSpell or not CurrentRun.Hero.SlottedSpell.Talents.Name then
		return
	end
	if not IsGameStateEligible(source, SpellTalentData.ServeDuoGameRequirements ) then
		return
	end
	local duoTalents = {}
	local spellData = SpellData[ CurrentRun.Hero.SlottedSpell.Name ]
	if spellData.Talents and spellData.Talents.Legendary then
		for i, talentName in pairs( spellData.Talents.Legendary ) do
			if TraitData[talentName].IsDuoBoon and IsGameStateEligible( TraitData[talentName], TraitData[talentName].GameStateRequirements ) then
				table.insert( duoTalents, talentName )
			end
		end
	end
	if IsEmpty(duoTalents) then
		return
	end
	for rank, rankData in ipairs( SpellTalentData.TalentTreeStructures[CurrentRun.Hero.SlottedSpell.Talents.Name].Structure) do
		CurrentRun.Hero.SlottedSpell.Talents[rank] = CurrentRun.Hero.SlottedSpell.Talents[rank] or {}
		for entry, entryData in pairs( rankData ) do
			if not CurrentRun.Hero.SlottedSpell.Talents[rank][entry] then
				-- Doesn't exist, should be a duo entry
				if entryData.Pool.OlympianSpell then
					local node = DeepCopyTable( entryData )
					node.Name = RemoveRandomValue(duoTalents)
					CurrentRun.Hero.SlottedSpell.Talents[rank][entry] = node
				else
					local node = DeepCopyTable( entryData )
					node.Name = "OlympianSpellCountTalent"
					node.Rarity = "Common"
					CurrentRun.Hero.SlottedSpell.Talents[rank][entry] = node
				end
			end
		end
	end
	-- regenerating backlinks
	for depth, data in ipairs(CurrentRun.Hero.SlottedSpell.Talents) do
		for s, node in pairs(data) do
			if node.LinkTo then
				for _, linkToIndex in pairs(node.LinkTo) do
					if CurrentRun.Hero.SlottedSpell.Talents[depth+1][linkToIndex] then
						if not CurrentRun.Hero.SlottedSpell.Talents[depth+1][linkToIndex].LinkFrom then
							CurrentRun.Hero.SlottedSpell.Talents[depth+1][linkToIndex].LinkFrom = {}
						end
						if not Contains(CurrentRun.Hero.SlottedSpell.Talents[depth+1][linkToIndex].LinkFrom, s ) then
							table.insert(CurrentRun.Hero.SlottedSpell.Talents[depth+1][linkToIndex].LinkFrom, s)
						end
					end
				end
			end
		end
	end
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
	if SessionMapState.BlockSpellCharge and not args.Force then
		return
	end
	if not CanChargeSpell() and not args.Force then
		return
	end
	
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	if spellTrait and spellTrait.RemainingUses and spellTrait.RemainingUses <= 0 then
		return
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
		if spellTrait.Name == "SpellSummonTrait" and not CurrentRun.CurrentRoom.SummonEnemyName then 
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
	if SessionMapState.WeaponsDisabled then
		return false
	end
	if CurrentRun.Hero.IsDead then
		-- Must be PreRun, all other hub maps block combat.
		return true
	end
	if not ActiveEnemies then
		return false
	end
	if not CurrentRun or not CurrentRun.CurrentRoom then
		return false
	end
	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter and encounter.DelayedStart and not encounter.StartTime and not encounter.NeverDelaySpellCharge then
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
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
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
	if traitData.Name == "SpellSummonTrait" and not CurrentRun.CurrentRoom.SummonEnemyName then 
		TraitUIActivateTrait( traitData, {CustomAnimation = "InactiveTrait" })
	elseif CurrentRun.SpellCharge < manaSpend then
		if not CanChargeSpell() then
			TraitUIActivateTrait( traitData, {CustomAnimation = "InactiveTrait" })
			if traitData.TraitInfoCardId ~= nil then
				SetAlpha({ Id = traitData.TraitInfoCardId, Fraction = 0, Duration = 0 })
				Destroy({ Id = traitData.TraitInfoCardId })
				traitData.TraitInfoCardId = nil
			end
			if traitData.TraitInfoChargeId ~= nil then
				SetAlpha({ Id = traitData.TraitInfoChargeId, Fraction = 0, Duration = 0 })
				Destroy({ Id = traitData.TraitInfoChargeId })
				traitData.TraitInfoChargeId = nil
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
	OnSpellFired()
	SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	notifyExistingWaiters( weaponData.Name.."Fire" )
	local spellTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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

function OnSpellFired()
	FrameState.SpellFired = true
	if not SessionMapState.SpellDodge then
		SessionMapState.SpellDodge = true
		SetLifeProperty({ Property = "DodgeChance", Value = GetTotalHeroTraitValue("HexUsedDodgeBuff"), ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if not SessionMapState.SpellSpeed then
		SessionMapState.SpellSpeed = true
		local totalMoveSpeedChange = GetTotalHeroTraitValue( "HexUsedMoveSpeedBuff", {IsMultiplier = true })
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
	end
	SessionMapState.SpellUsed = true
end

function SpellCheckCharges( unit, args, roomArgs )
	roomArgs = roomArgs or {}
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	
	if roomArgs.Grouped and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.MaintainSpellCharge and not CurrentRun.CurrentRoom.RestoreUnlockRoomExits then
		SpellPrecharge( spellTrait, weaponName )
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
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpendCost = GetManaSpendCost( data )
	if roomArgs.Grouped and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.MaintainSpellCharge and not CurrentRun.CurrentRoom.RestoreUnlockRoomExits then
		SpellPrecharge( spellTrait, weaponName )
	end
	if not spellTrait.RemainingUses then
		return
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

function PotionPoseidonDrops( weaponData, traitArgs, triggerArgs )
	if not ShouldFireFirstTimeOlympian() then
		return
	end
	
	thread( DoFullSuperPresentation, "Poseidon" )
	IncrementTableValue( SessionMapState, "SpellFired" )
	local effectName = "PotionBuff"
	local dataProperties = EffectData[effectName].DataProperties 
	dataProperties.Duration = traitArgs.Duration
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })

	if traitArgs.Duration >= 3 then
		wait(traitArgs.Duration - 3)
		thread(PoseidonPotionWarnPresentation)
		waitUnmodified(1)
		thread(PoseidonPotionWarnPresentation)
		waitUnmodified(1)
		thread(PoseidonPotionWarnPresentation)
		waitUnmodified(1)
	else
		wait(traitArgs.Duration)
	end
end


function ContinuousManaRegeneration( manaRegenPerSecond )
	if manaRegenPerSecond <= 0 then
		return
	end
	while SessionMapState.PoseidonRegeneration do
		local manaOverflow = 0
		if IsEmpty( MapState.ChargedManaWeapons ) and IsEmpty(CurrentRun.Hero.ManaDrain) and not HasThread("ManaRegenStartup") then
			if (1/manaRegenPerSecond) < HeroData.ManaData.MinManaTickRate then
				local manaRegen, fraction = math.modf( manaRegenPerSecond * HeroData.ManaData.MinManaTickRate )
				manaOverflow = manaOverflow + fraction
				if manaOverflow >= 1 then
					manaOverflow = manaOverflow - 1
					manaRegen = manaRegen + 1
				end
				ManaRegenPresentation(manaRegen)
				ManaDelta(manaRegen, { Silent = true })
				wait( HeroData.ManaData.MinManaTickRate, "PoseidonRegeneration")
			else
				ManaDelta(1, { Silent = true })
				ManaRegenPresentation(1)
				wait( 1 / manaRegenPerSecond, "PoseidonRegeneration" )
			end
		else
			wait( HeroData.ManaData.MinManaTickRate, "PoseidonRegeneration")
		end
	end
end

function ContinuousHealthRegeneration( healthRegenPerSecond )
	if healthRegenPerSecond <= 0 then
		return
	end
	local lastTime = _worldTime
	while SessionMapState.PoseidonRegeneration do
		local healthOverflow = 0
		if (1/healthRegenPerSecond) < HeroData.ManaData.MinManaTickRate then
			local healthRegen, fraction = math.modf( healthRegenPerSecond * HeroData.ManaData.MinManaTickRate )
			healthOverflow = healthOverflow + fraction
			if healthOverflow >= 1 then
				healthOverflow = healthOverflow - 1
				healthRegen = healthRegen + 1
			end
			Heal( CurrentRun.Hero, { HealAmount = healthRegen, SourceName = "PoseidonSpellDuo", Silent = true })	
			CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
			FrameState.RequestUpdateHealthUI = true
			wait( HeroData.ManaData.MinManaTickRate, "PoseidonRegeneration")
		else
			Heal( CurrentRun.Hero, { HealAmount = 1, SourceName = "PoseidonSpellDuo", Silent = true })
			CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
			FrameState.RequestUpdateHealthUI = true
			lastTime = _worldTime
			wait( 1 / healthRegenPerSecond, "PoseidonRegeneration" )
		end
	end
end
function SpellSummonCheckCharges( unit, args, roomArgs)	
	roomArgs = roomArgs or {}
	local spellTrait = nil
	local weaponName = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
		end
	end
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpendCost = GetManaSpendCost( data )
	
	if roomArgs.Grouped and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.MaintainSpellCharge and not CurrentRun.CurrentRoom.RestoreUnlockRoomExits then
		SpellPrecharge( spellTrait, weaponName )
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
		if not SessionMapState.SpellWorldReadyFx then
			SessionMapState.SpellWorldReadyFx = true
			CreateAnimation({ Name = "SorceryReadyMoonLoopIn", DestinationId = CurrentRun.Hero.ObjectId })
		end
		SpellActivateTrait( spellTrait )
	end
end

function SpellPrecharge( spellTrait, weaponName )
	if not spellTrait then
		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if traitData.Slot == "Spell" then
				spellTrait = traitData
			weaponName = traitData.PreEquipWeapons[1]
			end
		end
	end
	if not spellTrait or not weaponName then
		return
	end
	local data = GetWeaponData( CurrentRun.Hero, weaponName )
	local manaSpendCost = GetManaSpendCost( data )
	CurrentRun.SpellCharge = manaSpendCost * GetTotalHeroTraitValue( "SpellPreCharge" )
end

function CheckPolymorphApply( triggerArgs )
	local enemy = triggerArgs.Victim
	if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].FireProjectileOnApply then
		local projectileData = EffectData[triggerArgs.EffectName].FireProjectileOnApply
		CreateProjectileFromUnit({ WeaponName = projectileData.WeaponName, Name = projectileData.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId })	
	end
	if enemy.DestroyOnPolymorph and not enemy.IsDead then
		Kill( enemy )
		return
	end
	
	if enemy.ImmuneToPolymorph then
		thread( SpellPolymorphResistedPresentation, enemy, triggerArgs )
		ClearEffect({ Id = enemy.ObjectId, Name = triggerArgs.EffectName })
		return
	end
	if not enemy.IsBoss and enemy ~= CurrentRun.Hero and not enemy.SkipModifiers then
		if enemy.StopAnimationsOnPolymorph ~= nil then
			StopAnimation({ DestinationId = enemy.ObjectId, Names = enemy.StopAnimationsOnPolymorph, PreventChain = true, IncludeCreatedAnimations = true })
		end
		if not IsEmpty( enemy.StopAnimationsOnHitStun ) then
			StopAnimation({ Names = enemy.StopAnimationsOnHitStun, DestinationId = enemy.ObjectId, PreventChain = true, IncludeCreatedAnimations = true })
		end

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
			thread( Damage, enemy, { SourceWeapon = "WeaponSpellPolymorph", SourceProjectile = "MorphDamageProjectile", DamageAmount = GetTotalHeroTraitValue("PolymorphBossDamage"), AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false } )	
		else
			thread( SpellPolymorphResistedPresentation, enemy, triggerArgs )
		end
	end
end

function BuildValidEffects( hero, args )
	SessionMapState.ValidEffects = {}
	for effectName, traitNames in pairs( args.StatusTraitNames ) do
		local hasTrait = false
		for _, traitName in pairs( traitNames ) do
			if HeroHasTrait( traitName ) then
				hasTrait = true	
				break
			end
		end
		if hasTrait then
			SessionMapState.ValidEffects[effectName] = {}
		end
	end

	-- set defaults
	for effectName, data in pairs(SessionMapState.ValidEffects) do
		if effectName == "BurnEffect" then
			data.NumStacks = 45
		end
		if effectName == "DamageShareEffect" then
			data.Amount = EffectData.DamageShareEffect.EffectData.Amount + GetTotalHeroTraitValue("DamageShareAmountIncrease")
		end
		if effectName == "DamageEchoEffect" then
			data.Modifier = 1
		end
					
		if effectName == "DelayedKnockbackEffect" then
			data.TriggerDamage = EffectData.DamageEchoEffect.EffectData.TriggerDamage
		end
		if effectName == "DamageOverTime" then
			local damageAmount = 50
			if HeroHasTrait("FirstHangoverBoon") then
				local trait = GetHeroTrait("FirstHangoverBoon")
				damageAmount = trait.OnEnemyDamagedAction.Args.Damage
			end
			data.Amount = damageAmount
		end
	end
end

function PolymorphCopyStatus( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName ~= "PolymorphTag" or not victim or victim.IsDead or victim.SandwichForm then 
		return
	end
	local activeCurses = DeepCopyTable( SessionMapState.ValidEffects )
	for i, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy ~= victim and not enemy.SkipModifiers and enemy.ActiveEffects then
			for effectName, effectStacks in pairs(enemy.ActiveEffects) do
				if functionArgs.ValidStatusNames[effectName] and activeCurses[effectName] then
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
			local dataProperties = {}
			if EffectData[effectName].EffectData then
				dataProperties = MergeTables( EffectData[effectName].EffectData, effectData )
			elseif EffectData[effectName].DataProperties then
				dataProperties = MergeTables( EffectData[effectName].DataProperties, effectData )
			end
			ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })				
		end
	end
end

function PolymorphStunApply(triggerArgs)
	local enemy = triggerArgs.Victim
	enemy.IsPolymorphed = true
	if not SessionMapState.PolymorphIgnores[enemy.ObjectId] then
		SessionMapState.BlockSpellCharge = true
		IncrementTableValue( SessionMapState, "PolymorphCount" )
	end
	OnHitStunApply( triggerArgs )
	if not IsEmpty( enemy.ExpireProjectileIdsOnPolymorph ) then
		ExpireProjectiles({ ProjectileIds = enemy.ExpireProjectileIdsOnPolymorph })
	end
	PolymorphApplyPresentation( triggerArgs )
	if HeroHasTrait("PolymorphSandwichTalent") and not enemy.AlwaysTraitor then
		local polymorphChance = GetTotalHeroTraitValue("PolymorphSandwichChance")
		local polymorphCap = GetTotalHeroTraitValue("PolymorphRoomCap")
		if not enemy.SandwichForm and RandomChance( polymorphChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ) ) and ( MapState.SandwichCount < polymorphCap ) then
		
			RemoveEnemyUI( enemy )
			enemy.PrePolymorphInvulnerableFx = enemy.InvulnerableFx
			enemy.InvulnerableFx = nil
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
	if not SessionMapState.PolymorphIgnores[enemy.ObjectId] then
		DecrementTableValue( SessionMapState, "PolymorphCount" )
		if SessionMapState.PolymorphCount <= 0 then
			SessionMapState.BlockSpellCharge = nil
		end
	else
		SessionMapState.PolymorphIgnores[enemy.ObjectId] = nil
	end
	if enemy.IsDead or enemy.Health <= 0 then
		if enemy.Frozen then
			-- Need to unfreeze before unpolymorphing as part of death sequence
			SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = enemy.ObjectId, DataValue = false })
		end
		if enemy.PrePolymorphGrannyModel then
			SetThingProperty({ Property = "GrannyModel", Value = enemy.PrePolymorphGrannyModel, DestinationId = enemy.ObjectId })
		end
		if enemy.GrannyTexture then
			SetThingProperty({ Property = "GrannyTexture", Value = enemy.GrannyTexture, DestinationId = enemy.ObjectId })
		end
		if enemy.PrePolymorphGraphic ~= nil then
			SetAnimation({ Name = enemy.PrePolymorphGraphic, DestinationId = enemy.ObjectId })
		end
		enemy.OnDeathFireWeapons = nil -- Suppress death weapons if killed under polymorph
		return
	end
	PolymorphClearPresentation( triggerArgs )
	if enemy.SandwichForm then
		RecreateEnemyUI( enemy )
		enemy.InvulnerableFx = enemy.PrePolymorphInvulnerableFx
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
			if WeaponData[weaponName].CancelOnPolymorph then
				thread( DumbFireAttack, enemy, weaponName )
			end
		end
	end
	
	AdjustZLocation({ Distance = enemy.RestoreOffsetZValue, Id = enemy.ObjectId, Duration = 0.2 })
	SetUnitProperty({Property = "StunBreakModifier", Value = enemy.RestoreStunBreakModifierValue, DestinationId = enemy.ObjectId })
	if enemy.HealthBuffer and enemy.HealthBuffer > 0 then
		SetUnitProperty({Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
	elseif enemy.WasImmuneToStunWithoutArmor or GetBaseDataValue({ Type = "Unit", Name = enemy.Name, Property = "ImmuneToStun"}) then
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


function SpellPolymorphFire( owner, weaponData, functionArgs, triggerArgs )
	SessionMapState.BlockSpellCharge = true
end


function CheckPolymorphCharge( triggerArgs, functionArgs )
	if triggerArgs.name == "ProjectileSpellPolymorph" and (not SessionMapState.PolymorphCount or SessionMapState.PolymorphCount == 0 ) then
		SessionMapState.BlockSpellCharge = nil
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

function SummonCastTeleport( weaponData, traitArgs, triggerArgs )
	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY then
		return
	end
	local castProjectilePointId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting" })
	local testPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting" })
	
	local teleportEnemies = {}
	for i, enemy in pairs( MapState.SpellSummons ) do
		table.insert( teleportEnemies, enemy.ObjectId )
	end
	local numTeleportEnemies = #teleportEnemies
	if numTeleportEnemies > 0 then
		-- Primary attempt within cast radius
		local spawnPoints = FindSpawnPointsInCast( castProjectilePointId, 350, numTeleportEnemies )
		if IsEmpty(spawnPoints) then
			wait( 0.02 )
			-- Backup attempt, outside cast radius but still close
			spawnPoints = FindSpawnPointsInCast( castProjectilePointId, 500, numTeleportEnemies )
		end

		for i, enemyId in ipairs( teleportEnemies ) do
			CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = enemyId, })
			if not IsEmpty(spawnPoints) then
				Teleport({ Id = testPoint, DestinationId = spawnPoints[i % #spawnPoints + 1], OffsetX = RandomFloat(-50,50), OffsetY = RandomFloat(-50,50)})
				if IsLocationBlocked({ Id = testPoint }) then
					Teleport({ Id = enemyId, DestinationId = spawnPoints[i % #spawnPoints + 1] })
				else				
					Teleport({ Id = enemyId, DestinationId = testPoint })
				end
			else
				-- Final attempt because this can cause sorting flickering
				local generatedPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX + RandomFloat(-150, 150), LocationY = triggerArgs.ProjectileY + RandomFloat(-100, 100), Group = "Scripting", ForceToValidLocation = true})
				if not IsLocationBlocked({ Id = generatedPoint }) then
					Teleport({ Id = enemyId, DestinationId = generatedPoint })
				end
				Destroy({Ids = { generatedPoint }})
			end
			CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = enemyId, })
		end
	end
	Destroy({ Ids = {testPoint, castProjectilePointId }})
end

function PolymorphCastTeleport( weaponData, traitArgs, triggerArgs )
	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY then
		return
	end
	local castProjectilePointId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting" })
	local testPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = "Scripting" })
	
	local teleportEnemies = {}	
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.ActiveEffects and enemy.ActiveEffects.PolymorphStun and not enemy.BlockForcedTeleport then
			table.insert( teleportEnemies, id )
		end
	end
	local numTeleportEnemies = #teleportEnemies
	if numTeleportEnemies > 0 then
		-- Primary attempt within cast radius
		local spawnPoints = FindSpawnPointsInCast( castProjectilePointId, 350, numTeleportEnemies )
		if IsEmpty(spawnPoints) then
			-- Backup attempt, outside cast radius but still close
			spawnPoints = FindSpawnPointsInCast( castProjectilePointId, 500, numTeleportEnemies )
		end
		for i, enemyId in pairs( teleportEnemies ) do
			CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = enemyId, })
			if not IsEmpty(spawnPoints) then
				Teleport({ Id = testPoint, DestinationId = spawnPoints[i % #spawnPoints + 1], OffsetX = RandomFloat(-50,50), OffsetY = RandomFloat(-50,50)})
				if IsLocationBlocked({ Id = testPoint }) then
					Teleport({ Id = enemyId, DestinationId = spawnPoints[i % #spawnPoints + 1] })
				else				
					Teleport({ Id = enemyId, DestinationId = testPoint })
				end
			else
				-- Final attempt because this can cause sorting flickering
				local generatedPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX + RandomFloat(-150, 150), LocationY = triggerArgs.ProjectileY + RandomFloat(-100, 100), Group = "Scripting", ForceToValidLocation = true})
				if not IsLocationBlocked({ Id = generatedPoint }) then
					Teleport({ Id = enemyId, DestinationId = generatedPoint })
				end
				Destroy({Ids = { generatedPoint }})
			end
			CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = enemyId, })
		end
	end
	Destroy({ Ids = {testPoint, castProjectilePointId }})
end

function FindSpawnPointsInCast( centerId, range, numPointsNeeded )
	local maxChecksPerFrame = 30
	local frameChecks = 0
	local output = GetClosestIds({ Id = centerId, DestinationIds = MapState.SpawnPoints, Distance = range, ScaleY = 0.55 })
	output = FYShuffle(output)
	return output
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
		and CurrentRun.SpellCharge >= manaSpendCost
		and not MapState.HostilePolymorph then
			SpellSummonCheckCharges()
	end
end

function SpellSummon( triggerArgs, weaponData )
	if not CurrentRun.CurrentRoom.SummonEnemyName then
		return
	end
	local wasFirst = true
	if not ShouldFireFirstTimeOlympian() then
		wasFirst = false
	else
		if HeroHasTrait("SummonHeraTalent") then	
			thread( DoFullSuperPresentation, "Hera" )
		end
	end
	IncrementTableValue( SessionMapState, "SpellFired" )
	local enemyName = CurrentRun.CurrentRoom.SummonEnemyName
	local enemyData = EnemyData[enemyName]
	local hasEnemy = false
	if enemyData.UniqueRaise and CurrentRun.CurrentRoom.AssistUnitName == enemyData.Name then
		return
	end

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
		if modifierData.FirstOnly == nil or ( modifierData.FirstOnly and wasFirst ) then
			if modifierData.MaxHealthMultiplier then
				summonArgs.MaxHealthMultiplier = summonArgs.MaxHealthMultiplier * modifierData.MaxHealthMultiplier
			end
			if modifierData.SpeedMultiplier then
				summonArgs.SpeedMultiplier = summonArgs.SpeedMultiplier + ( modifierData.SpeedMultiplier - 1 )
			end
			if modifierData.ScaleMultiplier then
				summonArgs.ScaleMultiplier = summonArgs.ScaleMultiplier + ( modifierData.ScaleMultiplier - 1 )
			end
		end
	
	end
	local offset = CalcOffset(math.rad(GetAngle({Id = CurrentRun.Hero.ObjectId})), 100 )
	local invaderSpawnPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, ForceToValidLocation = true})
	

	summonArgs.SpawnPointId = invaderSpawnPoint
	summonArgs.TryUseRequiredSpawnPoint = true
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
			for s, damageModifierData in ipairs( modifierData.OutgoingCritModifiers ) do
				local validSummon = damageModifierData.ValidSummons == nil or Contains(damageModifierData.ValidSummons, newEnemy.Name )
				local validFirst = modifierData.FirstOnly == nil or ( modifierData.FirstOnly and wasFirst )
				if validSummon and validFirst then
					local modifierData = ShallowCopyTable( damageModifierData )
					modifierData.Chance = modifierData.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })
					AddOutgoingCritModifier( newEnemy, modifierData )
				end
			end
		end
		if modifierData.CreateAnimation then
			CreateAnimation({ Name = modifierData.CreateAnimation, DestinationId = newEnemy.ObjectId })
			newEnemy.CreatedAnimations = newEnemy.CreatedAnimations or {}
			table.insert( newEnemy.CreatedAnimations, modifierData.CreateAnimation )
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

	if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap ~= nil then
		local activeCapWeight = newEnemy.ActiveCapWeight or 1
		CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap = math.min(ConstantsData.MaxActiveEnemyCount, CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap + activeCapWeight)
	end

	MapState.SpellSummons = MapState.SpellSummons or {}
	local condemned = {}
	for _, enemy in pairs( MapState.SpellSummons ) do
		if not enemy or enemy.IsDead or not ActiveEnemies[ enemy.ObjectId ] then
			table.insert(condemned, enemy)
		end
	end
	for _, enemy in pairs( condemned ) do
		RemoveValue(MapState.SpellSummons, enemy )
	end
	MapState.SpellSummons = CollapseTable( MapState.SpellSummons )
	table.insert( MapState.SpellSummons, newEnemy )
	GameState.SpellSummons[newEnemy.Name] = (GameState.SpellSummons[newEnemy.Name] or 0) + 1
	CheckAchievement( newEnemy, { Name = "AchSummonSiren" } )

	if TableLength( MapState.SpellSummons ) > weaponData.MaxSummons then
		local oldest = MapState.SpellSummons[1]
		for i, data in pairs( GetHeroTraitValues("OnSummonDeathFunction")) do
			CallFunctionName( data.Name, oldest, data.Args )
		end
		Kill ( oldest )
		RemoveValueAndCollapse(MapState.SpellSummons, enemy )
	end
	if weaponData.ManaReservationCost then
		ReserveMana(weaponData.ManaReservationCost, weaponData.Name )
	end
	DestroyOnDelay({ invaderSpawnPoint }, 0.1)
	if wasFirst and HeroHasTrait("SummonHeraTalent") then
		local heraTrait = GetHeroTrait("SummonHeraTalent")
		local outlineData = ShallowCopyTable(UnitSetData.Enemies.BaseVulnerableEnemy.Outline)
		outlineData.Id = newEnemy.ObjectId
		if heraTrait.AllyDataModifiers.OutlineColor then
			outlineData.R = heraTrait.AllyDataModifiers.OutlineColor[1]
			outlineData.G = heraTrait.AllyDataModifiers.OutlineColor[2]
			outlineData.B = heraTrait.AllyDataModifiers.OutlineColor[3]
		end
		AddOutline( outlineData )
	else
		local outlineData = ShallowCopyTable(UnitSetData.Enemies.BaseVulnerableEnemy.Outline)
		outlineData.Id = newEnemy.ObjectId
		outlineData.R = Color.AlliedOutline[1]
		outlineData.G = Color.AlliedOutline[2]
		outlineData.B = Color.AlliedOutline[3]
		AddOutline( outlineData )
	end
	if not HeroHasTrait("SummonPermanenceTalent") then
		thread(EndSpellSummon, newEnemy, weaponData)
	end
end

function EndSpellSummon( enemy, weaponData )
	wait( weaponData.Duration, RoomThreadName )
	for i, data in pairs( GetHeroTraitValues("OnSummonDeathFunction")) do
		CallFunctionName( data.Name, enemy, data.Args )
	end
	Kill( enemy )
	RemoveValueAndCollapse(MapState.SpellSummons, enemy )
end

function TeleportSummonsToPlayer (teleports)
	if teleports > 0 and not IsEmpty(MapState.SpellSummons) then
		for i, summonData in pairs (MapState.SpellSummons) do
			if not summonData.ImmobileRaise then
				local offset = CalcOffset( math.rad(180 + GetAngle({Id = CurrentRun.Hero.ObjectId })), 50)
				TeleportSummonPresentation( summonData.ObjectId )
				Teleport({ Id = summonData.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
				TeleportSummonPresentation( summonData.ObjectId )
			end
		end
	end
end

function SummonTakeDamage( unit, args, triggerArgs )
	if not unit or unit.SkipModifiers or not triggerArgs.SourceProjectile or triggerArgs.ManuallyTriggered then
		return
	end
	for i, summonData in pairs (MapState.SpellSummons) do
		thread( Damage, summonData, { SourceProjectile = triggerArgs.SourceProjectile, DamageAmount = triggerArgs.DamageAmount * args.Multiplier, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true } )	
	end
end

function StartSpellSlow( unit, weaponData, args, triggerArgs )
	args = ShallowCopyTable(args)
	local spellDuration = args.Duration
	for i, traitData in pairs( GetHeroTraitValues("TimeSlowModifiers")) do
		if weaponData and traitData.ValidWeapons and Contains(traitData.ValidWeapons, weaponData.Name ) then
			if traitData.AddDuration then
				spellDuration = spellDuration + traitData.AddDuration
			end
		end
	end
	args.Duration = spellDuration

	if args.LoopingSound then
		SessionMapState.TimeSlowSoundId = PlaySound({ Name = args.LoopingSound })
	end
	SessionMapState.TimeSlowActive = true
	SessionMapState.BlockSpellCharge = true
	StartTimeSlowSpeed()
	StartSpellSlowPresentation()
	for i, data in pairs( GetHeroTraitValues("OnTimeSlowStartFunction")) do
		thread( CallFunctionName, data.Name, data.Args )
	end
	for i, timeSlow in pairs( GetHeroTraitValues("TimeSlowModifier") ) do
		if timeSlow < args.Modifier then
			args.Modifier = timeSlow
			args.Force = true
		end
	end	
	if not GameState.Flags.UsedSlowAgainstChronos and CurrentRun.BossHealthBarRecord.Chronos then
		GameState.Flags.UsedSlowAgainstChronos = true
	end
	StartWeaponSlowMotion( triggerArgs, weaponData, args ) 
end

function EndTimeSlow( args )
	SessionMapState.TimeSlowActive = nil
	SessionMapState.BlockSpellCharge = nil
	for i, data in pairs( GetHeroTraitValues("OnTimeSlowEndFunction")) do
		thread( CallFunctionName, data.Name, data.Args )
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
	AddOutgoingCritModifier( CurrentRun.Hero, { Name = "TimeSlowCrit", Chance = traitArgs.Chance, Temporary = true } )
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
	SessionMapState.TimeSlowSpeed = true
	local totalSpeedChange = GetTotalHeroTraitValue( "TimeSlowSpeed", {IsMultiplier = true })
	if totalSpeedChange ~= 1 then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier * totalSpeedChange
		local allPropertyChanges= {}
		if not MapState.TimeSlowSpeedPropertyChanges then
			local affectedWeapons = {}
			for weaponName in pairs(CurrentRun.Hero.Weapons) do
				if WeaponSetLookups.HeroPrimarySecondaryWeapons[weaponName] then
					ConcatTableValues( affectedWeapons, AddLinkedWeapons({weaponName}))
				end
			end
			local speedPropertyChange = 		
			{
				WeaponNames = affectedWeapons,
				ChangeValue = totalSpeedChange,
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
		SetPlayerAttackSpecialChargeSpeed( "TimeSlowSpeed", totalSpeedChange )
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.TimeSlowSpeedPropertyChanges )
	end
end

function EndTimeSlowSpeed()

	SessionMapState.TimeSlowSpeed = nil
	local totalSpeedChange = GetTotalHeroTraitValue( "TimeSlowSpeed", {IsMultiplier = true })
	if not IsEmpty(MapState.TimeSlowSpeedPropertyChanges) and totalSpeedChange ~= 1 then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier / totalSpeedChange
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.TimeSlowSpeedPropertyChanges, true, true)
		RemovePlayerAttackSpecialChargeSpeed( "TimeSlowSpeed", totalSpeedChange )
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

function SpellTransform( user, weaponData, functionArgs, triggerArgs )
	local threadName = "SpellTransformTimer"
	SessionMapState.ElapsedTimeMultiplierIgnores[threadName] = true
	SpellReloadStarted( user, weaponData)
	SetPlayerDarkside("SpellTransform")
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
	
	SessionMapState.BlockStagedCharge.WeaponSprint = true
	for i, weaponName in pairs(GetHeroTraitValues("ReplaceMeleeWeapon")) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		SessionMapState.BlockWeaponFailedToFire[weaponName] = true
	end
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		if weaponName ~= "WeaponCast" and weaponName ~= "WeaponSprint" then
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
	wait( totalDuration - 3, threadName)
	thread(SpellTransformWarnPresentation)
	wait(1, threadName)
	thread(SpellTransformWarnPresentation)
	wait(1, threadName)
	thread(SpellTransformWarnPresentation)
	wait(1, threadName)
	EndSpellTransform(functionArgs)
end

function EndSpellTransform( )
	if not MapState.TransformArgs then
		return
	end
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "WeaponCastAimSlow" })
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	for _, weaponName in pairs( MapState.TransformArgs.FunctionArgs.TransformWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "cancelCharge" })
	end
	SessionMapState.BlockStagedCharge.WeaponSprint = nil
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		if not MapState.HostilePolymorph then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
		end
		SessionMapState.BlockWeaponFailedToFire[weaponName] = nil
	end
	for i, weaponName in pairs(GetHeroTraitValues("ReplaceMeleeWeapon")) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
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
	SetPlayerUnDarkside("SpellTransform")
	SetupCostume( MapState.HostilePolymorph )
	HandleWeaponAnimSwaps()
	if MapState.TransformArgs.EndGraphic and not MapState.HostilePolymorph and not CurrentRun.Hero.IsDead then
		SetAnimation({ Name = MapState.TransformArgs.EndGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
	for i, data in pairs(GetHeroTraitValues("TransformFunctionNames")) do
		thread( CallFunctionName, data.EndTransformFunctionName, data.Args )
	end
	SessionMapState.BlockSpellCharge = nil
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
	}, false, true )
end

function DisableCastArm()
	SessionMapState.SuperchargeCast = true
	SetCastArmDisabled("Transform")
end

function EnableCastArm()
	SessionMapState.SuperchargeCast = nil
	SetCastArmEnabled("Transform")
end

function StartTransformBurst()
	if not ShouldFireFirstTimeOlympian() then
		return
	end
	if not HeroHasTrait("TransformAphroditeTalent") then
		return
	end
	
	thread( DoFullSuperPresentation, "Aphrodite" )
	local trait = GetHeroTrait("TransformAphroditeTalent")
	thread( CreateManaBurst, trait.OnProjectileDeathFunction.Args, 3 )
	IncrementTableValue( SessionMapState, "SpellFired" )
	SessionMapState.TransformHeartburst = true
end

function EndTransformBurst()
	SessionMapState.TransformHeartburst = nil
end

function TransformRespawnBurst( triggerArgs, functionArgs )
	if not SessionMapState.TransformHeartburst or HasThread("ManaBurstDelay") then
		return
	end
	wait( functionArgs.Delay, "ManaBurstDelay" )
	if GetProjectileCount({ Names = {"AphroditeBurst" }}) <= 3 then
		thread(CreateManaBurst, functionArgs, 3 )
	end
end

function TransformArmCast()
	if MapState.TransformArgs then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponCastArm", Method = "ArmProjectiles" })
	end
end

function TransformCheckApolloBoon( args )
	if HeroHasTrait( args.Boon ) then
		if args.Slot == "Melee" then
			SetWeaponProperty({ WeaponName = "WeaponTransformAttack", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileScaleMultiplier", Value = args.Scale, ChangeType = "Multiply" })
		elseif args.Slot == "Special" then
			SetWeaponProperty({ WeaponName = "WeaponTransformSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileScaleMultiplier", Value = args.Scale, ChangeType = "Multiply" })
		end
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
	ClearEffect({ Name = "MedeaPoison", Id = CurrentRun.Hero.ObjectId })
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
		if HasHeroTraitValue("PotionExCast") then
			thread( PotionExCast ) 
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
					thread( CallFunctionName, functionData.Name, attacker, functionData.FunctionArgs, triggerArgs )
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
		local goldGranted = (GetTotalHeroTraitValue("MoneyOnSpell") * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } ))
		if goldGranted > 0 then
			thread( GushMoney, { Amount = goldGranted, LocationId = CurrentRun.Hero.ObjectId, Radius = 100, Source = "Spell Gold Trait"})		
		end
		if HeroHasTrait("ClearCastTalent") then
			SessionMapState.QueuedClearCast = true
		end
	end
	if traitData.RemainingUses <= 0 then
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
end

function PotionExCast( )
	local weaponName = "WeaponCast"
	local projectileName = "ProjectileCast"
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	derivedValues.ThingPropertyChanges = derivedValues.ThingPropertyChanges or {}
	derivedValues.ThingPropertyChanges.Graphic = "null"
	local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, FireFromTarget = true, 
		DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
			ArmAndDetonateProjectiles({ Ids = { projectileId }})
	SessionMapState.PotionCastIds[projectileId] = true
end

function StartSpellCharge( triggerArgs, weaponData, dataArgs)
	ClearEffect({ Name = "MedeaPoison", Id = CurrentRun.Hero.ObjectId })
	thread(SpellChargePresentation, triggerArgs, weaponData)
	SessionMapState.SpellInProgress = true
	local shouldFireSuper = ShouldFireFirstTimeOlympian()
	for i, weaponName in ipairs( WeaponSets.HeroRangedWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "PriorityFireRequest", Value = false })
		end
	end
	if dataArgs.DisableBlink then
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = dataArgs.TimeSlowModifier, Name = weaponData.Name .. "SpellSlow", Force =  true, TimeSlowPresentationFunction = dataArgs.SpellChargePresentationFunction or "SpellChargeTimeSlowPresentation" })
	local notifyName = weaponData.Name .. "Fired"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=", Timeout = dataArgs.Duration })
	waitUntil( notifyName )	
	
	thread( SpellChargeEndPresentation, shouldFireSuper )
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = dataArgs.TimeSlowModifier, Reverse = true, Name = weaponData.Name .. "SpellSlow", EndTimeSlowPresentationFunction = "SpellChargeEndTimeSlowPresentation" })
	if dataArgs.DisableBlink and not dataArgs.ManualBlinkReenable and not MapState.HostilePolymorph then
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	end
	for i, weaponName in ipairs( WeaponSets.HeroRangedWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "PriorityFireRequest", Value = true })
		end
	end
	SessionMapState.SpellInProgress = false
end

function CheckFirstTimeLaserFire( weaponData, args )
	if not ShouldFireFirstTimeOlympian() then
		return
	end
	
	SessionMapState.OverrideProjectileStartColor = Color.ApolloDamageLight
	SessionMapState.OverrideProjectileColor = Color.ApolloDamage
	SessionMapState.OverrideProjectileColorName = "ProjectileSpellLaser"

	thread( DoFullSuperPresentation, "Apollo" )
	IncrementTableValue( SessionMapState, "SpellFired" )
	SessionMapState.PendingSpellChanges = true
	ApplyUnitPropertyChanges( CurrentRun.Hero, args.PropertyChanges, true )
	AddOutgoingDamageModifier( CurrentRun.Hero, args.AddOutgoingDamageModifiers )
end

function ResetFirstHitTalent()
	SessionMapState.LaserHitTargets = {}
end

function LaserSpellFire(unit, weaponData, functionArgs, triggerArgs )
	OnSpellFired()
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
		local totalArmor = GetTotalHeroTraitValue("DefenseDuringLaser")
		if totalArmor > 0 then
			local trait = GetHeroTrait("LaserDefenseTalent")
			trait.CurrentArmor = totalArmor
			AddHealthBuffer(totalArmor, "LaserDefenseTalent", { Silent = true, Temporary = true })
			SetPlayerTempArmorPresentation("LaserDefense")
			FrameState.RequestUpdateHealthUI = true
		end
		local startAoETrait = HasHeroTraitValue("LaserStartProjectile")
		if startAoETrait then
			CreateProjectileFromUnit({ Name = startAoETrait.LaserStartProjectile, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId })
		end
		if not HeroHasTrait("LaserCrystalTalent") then
			local dataProperties = DeepCopyTable( EffectData.LaserFireCancelable.DataProperties )
			dataProperties.DisableRotate = GetConfigOptionValue({ Name = "UseMouse" }) 
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "LaserFireCancelable", DataProperties = dataProperties})	
			thread( LaserSpellForceRelease, weaponData )
			SessionMapState.LaserSpellDown = true
			SessionMapState.BlockSpellCharge = true
			thread( ForceLaserFacing )
		else
			thread( LaserMatchDuration, triggerArgs )
			SessionMapState.LaserSpellDown = true
			SessionMapState.BlockSpellCharge = true
			LaserHoldClear()
		end
		notifyExistingWaiters( weaponData.Name.."Fire" )
	end
end

function ReenableLaserCharge( triggerArgs, functionArgs )
	if triggerArgs.name == "ProjectileSpellLaser" then
		SessionMapState.BlockSpellCharge = nil
	end
end
function LaserSpellForceRelease( weaponData )
	SetProjectileProperty({ WeaponName = "WeaponSpellLaser", DestinationId = CurrentRun.Hero.ObjectId, Property = "TotalFuse", Value = duration })
	local duration = weaponData.MaxDuration + GetTotalHeroTraitValue("LaserDurationBonus")
	if duration > 1 and GetTotalHeroTraitValue("DefenseDuringLaser") > 0 then
		wait( duration - 1, RoomThreadName)
		CheckPlayerTempArmorFalloffPresentation("LaserDefense")
		wait( 1, RoomThreadName)	
	else
		wait( duration, RoomThreadName )
	end
	SessionMapState.LaserTimeout = true
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "LaserFireCancelable"})
end

function LaserMatchDuration( triggerArgs )
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSpellLaser")
	local duration = weaponData.MaxDuration + GetTotalHeroTraitValue("LaserDurationBonus")

	if duration > 1 and GetTotalHeroTraitValue("DefenseDuringLaser") > 0 then
		wait( duration - 1, RoomThreadName)
		CheckPlayerTempArmorFalloffPresentation("LaserDefense")
		wait( 1, RoomThreadName)	
	else
		wait( duration, RoomThreadName )
	end
	
	if triggerArgs and triggerArgs.ProjectileId and triggerArgs.NumProjectiles == 1 then
		ExpireProjectiles({ ProjectileIds = {triggerArgs.ProjectileId }})
	else
		ExpireProjectiles({ Names = {"ProjectileSpellLaser"} })
	end
	local startAoETrait = HasHeroTraitValue("LaserStartProjectile")
	if startAoETrait then
		ExpireProjectiles({ Names = {startAoETrait.LaserStartProjectile} })
	end
	if GetTotalHeroTraitValue("DefenseDuringLaser") > 0 then
		local trait = GetHeroTrait("LaserDefenseTalent")
		trait.CurrentArmor = 0
		RemoveHealthBufferSource( "LaserDefenseTalent" )
		RemovePlayerTempArmorPresentation("LaserDefense")
		FrameState.RequestUpdateHealthUI = true
	end
end

function ForceLaserFacing()
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting" })
	local autolockArc = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponSpellLaser", Property = "AutoLockArcDistance" })
	local range = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponSpellLaser", Property = "AutoLockRange" })
	local validTarget = true
	
	for i, weaponName in ipairs( WeaponSets.SecondaryAndRangedWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			SessionMapState.BlockWeaponFailedToFire[weaponName] = true
		end
	end

	while SessionMapState.LaserSpellDown do
		if GetConfigOptionValue({ Name = "UseMouse" }) then
			local cursorLocation = GetCursorWorldLocation({})
			Teleport({ Id = targetId, OffsetX = cursorLocation.X, OffsetY = cursorLocation.Y, DestinationIsScreenRelative = false })
			AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, CompleteAngle = true })
		elseif not IsControlDown({ Name = "Shout" }) and not IsControlDown({ Names = {"Up", "Down", "Left", "Right" }}) then
			local autoLockId = GetAutoLockId({ Id = CurrentRun.Hero.ObjectId, Arc = autolockArc, Range = range, UseController = true })
			if autoLockId ~= 0 and ActiveEnemies[autoLockId] ~= nil and not ActiveEnemies[autoLockId].IsDead then
				Attach({ Id = targetId, DestinationId = autoLockId})
				validTarget = true
				AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, CompleteAngle = true })
			else
				validTarget = false
			end
		end
		wait(0.03)
	end
	
	for i, weaponName in ipairs( WeaponSets.SecondaryAndRangedWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			SessionMapState.BlockWeaponFailedToFire[weaponName] = nil
		end
	end
	if GetTotalHeroTraitValue("DefenseDuringLaser") > 0 then
		RemoveHealthBufferSource( "LaserDefenseTalent" )
		RemovePlayerTempArmorPresentation("LaserDefense")
		FrameState.RequestUpdateHealthUI = true
	end
	UpdateWeaponMana()
	Destroy({ Id = targetId})
end

function LaserHoldClear()
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSpellLaser")
	CurrentRun.SpellCharge = 0
	SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	ExpireProjectiles({ Names = {"ProjectileSpellLaser"}})	
	local startAoETrait = HasHeroTraitValue("LaserStartProjectile")
	if startAoETrait then
		ExpireProjectiles({ Names = {startAoETrait.LaserStartProjectile} })
	end
	
	RemoveOutgoingDamageModifier( CurrentRun.Hero, "TempLaserBonus")

	if SessionMapState.LaserTimeout then
		local effectName = "LaserFireEndCancelable"
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
	end
	SessionMapState.LaserTimeout = nil
	local spellTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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
	if SessionMapState.PendingSpellChanges and HeroHasTrait("LaserApolloTalent") then
		local trait = GetHeroTrait("LaserApolloTalent")
		local args = trait.OnWeaponChargeFunctions.FunctionArgs
		ApplyUnitPropertyChanges( CurrentRun.Hero, args.PropertyChanges, true, true )
		ApplyUnitPropertyChanges( CurrentRun.Hero, {
					{
						WeaponName = "WeaponSpellLaser",
						ProjectileProperty = "Graphic",
						ChangeValue = "MoonLaserLoop",
					},
					{
						WeaponName = "WeaponSpellLaser",
						ProjectileProperty = "DissipateFx",
						ChangeValue = "MoonLaserEnd",
					},
				}, true )
		RemoveOutgoingDamageModifier( CurrentRun.Hero, args.AddOutgoingDamageModifiers.Name )
		SessionMapState.PendingSpellChanges = nil
		SessionMapState.OverrideProjectileStartColor = nil
		SessionMapState.OverrideProjectileColor = nil
		SessionMapState.OverrideProjectileColorName = nil
	end
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.Name, Method = "cancelCharge"})
	SessionMapState.LaserSpellDown = nil
end

function LaserSpellReload( owner, weaponData, onChargeFunctionArgs )
	SpellReloadStarted(owner, weaponData )
end

function SpellReloadStarted( owner, weaponData )
	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
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
	local totalDodgeChange = GetTotalHeroTraitValue( "HexCooldownDodgeBuff")
	if totalDodgeChange > 0 then
		MapState.HexCooldownDodgeChance = totalDodgeChange
		SetLifeProperty({ Property = "DodgeChance", Value = totalDodgeChange, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	
	local totalSpeedChange = GetTotalHeroTraitValue( "HexCooldownSpeedBuff", {IsMultiplier = true })
	if not IsEmpty(MapState.HexSpeedPropertyChanges) and totalSpeedChange ~= 1 then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier / totalSpeedChange
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.HexSpeedPropertyChanges, true, true)
	end
end

function EndCooldownBuff()
	local totalSpeedChange = GetTotalHeroTraitValue( "HexCooldownSpeedBuff", {IsMultiplier = true })
	if totalSpeedChange ~= 1 then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier * totalSpeedChange
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

end

function SetupSpellLeap( owner, weaponData, functionArgs, triggerArgs )
	SessionMapState.BlockSpellCharge = true
	SessionMapState.SpellInProgress = true
	local firstFire = true
	if not ShouldFireFirstTimeOlympian() then
		firstFire = false
	else
		IncrementTableValue( SessionMapState, "SpellFired" )
	end
	CheckSpellMultiuse( weaponData.Name )
	FreezePlayerUnit("SpellLeap")
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	local lockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.TargetX, LocationY = triggerArgs.TargetY })
	local distanceToTarget = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = lockedTargetId })
	
	AddPlayerImmuneToForce( "SpellLeap" )

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

	if firstFire and HeroHasTrait("LeapHephaestusTalent") then
		local trait = GetHeroTrait("LeapHephaestusTalent")
		local data = trait.SpellLeapModifiers	
		thread( DoFullSuperPresentation, "Hephaestus" )
		local delay = data.StartFxDelay or 0
		local projectileDelay = data.ProjectileStartDelay or 0
		thread( DelayedHephaestusLeapPresentation, delay, data.StartFx, lockedTargetId, 1 / ( weaponData.RiseTime + weaponData.HangTime + weaponData.LandingTime + projectileDelay - delay ) )
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
	RemovePlayerImmuneToForce( "SpellLeap" )
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	
	local projectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Projectile" })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponData.Name,
		Type = "Projectile",
	})
	SessionMapState.BlockSpellCharge = nil
	CreateProjectileFromUnit({ WeaponName = weaponData.Name, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
	
	if firstFire and HeroHasTrait("LeapHephaestusTalent") then
		local trait = GetHeroTrait("LeapHephaestusTalent")
		local data = trait.SpellLeapModifiers
		
		local projectileDelay = data.ProjectileStartDelay or 0
		local blastModifier = GetTotalHeroTraitValue( "MassiveAttackSizeModifier", { IsMultiplier = true })
		CreateProjectileFromUnit({ Name = data.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, BlastRadiusModifier = blastModifier, DataProperties = { StartDelay = projectileDelay }})
	end

	UnfreezePlayerUnit("SpellLeap")
	local invulnerableTime = GetTotalHeroTraitValue("LeapInvulnerability")
	if invulnerableTime > 0 then
		local dataProperties = EffectData.MeteorInvincibubble.DataProperties 
		dataProperties.Duration = invulnerableTime
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "MeteorInvincibubble", DataProperties = dataProperties })
	end
	local tempArmor = GetTotalHeroTraitValue("LeapArmor")
	if tempArmor > 0 then
		local traitName = "LeapShieldTalent"
		local trait = GetHeroTrait(traitName)
		trait.CurrentArmor = tempArmor
		AddHealthBuffer(tempArmor, traitName, { Silent = true, Temporary = true })
		SetPlayerTempArmorPresentation(traitName)
		FrameState.RequestUpdateHealthUI = true
		thread( RemoveHealthBufferOnDelay, traitName, GetTotalHeroTraitValue("LeapArmorDuration"))
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
		TraitUIActivateTrait( traitData,{ FlashOnActive = true, Duration = GetTotalHeroTraitValue("MultiuseTimeout") })
		thread(SpellMultiuseExpire, weaponData.Name)
	else
		SessionMapState.SpellMultiuseCount = 0
	end
	SessionMapState.SpellInProgress = nil
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
		local triggered = false
		-- Apollo's sprint action effects
		local sprintTraitData = GetHeroTrait(CurrentRun.Hero.SlottedTraits.Rush)
		if sprintTraitData.OnSprintAction and HeroHasTrait("ApolloSprintBoon") then
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
		-- Aphrodite & Ares
		if HeroHasTrait("AphroditeSprintBoon") or HeroHasTrait("AresSprintBoon") then
			local blinkProjectile = sprintTraitData.OnWeaponFiredFunctions.FunctionArgs.ProjectileName
			CreateProjectileFromUnit({ Name = blinkProjectile, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = sprintTraitData.OnWeaponFiredFunctions.FunctionArgs.DamageMultiplier, DestinationId = victim.ObjectId, FireFromTarget = true })
			triggered = true
		end
		-- Hestia
		if HeroHasTrait("HestiaSprintBoon") then
			local blinkProjectile = sprintTraitData.OnSprintAction.Args.ProjectileName
			CreateProjectileFromUnit({ Name =  blinkProjectile, DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier =  sprintTraitData.OnSprintAction.Args.DamageMultiplier, FizzleOldestProjectileCount =  sprintTraitData.OnSprintAction.Args.MaxSpawns })
			triggered = true
		end
		-- Hephaestus
		if HeroHasTrait("HephaestusSprintBoon") and not ProjectileHasUnitHit(triggerArgs.ProjectileId, "HephLeapSprintStrike" ) then
			ProjectileRecordUnitHit(triggerArgs.ProjectileId, "HephLeapSprintStrike")
			local blastModifier = GetTotalHeroTraitValue( "MassiveAttackSizeModifier", { IsMultiplier = true })
			CreateProjectileFromUnit({ Name = "HephSprintBlast", Id = CurrentRun.Hero.ObjectId, DamageMultiplier = sprintTraitData.OnBlinkEndAction.FunctionArgs.DamageMultiplier, DestinationId = victim.ObjectId, BlastRadiusModifier = blastModifier, FireFromTarget = true })
			triggered = true
		end
		-- Zeus
		if HeroHasTrait("ZeusSprintBoon") then
			local blinkProjectile = sprintTraitData.OnWeaponFiredFunctions.FunctionArgs.ProjectileName
			CreateZeusBolt({
				WeaponName = "WeaponBlink",
				SourceId = CurrentRun.Hero.ObjectId,
				TargetId = victim.ObjectId,
				ProjectileName = blinkProjectile, 
				DamageMultiplier = sprintTraitData.OnWeaponFiredFunctions.FunctionArgs.DamageMultiplier,
				InitialDelay = 0, 
				Delay = 0.1, 
				Count = 1
			}) 
			triggered = true
		end
		if HeroHasTrait("HeraSprintBoon") then
			local projectileName = sprintTraitData.OnSprintAction.Args.ProjectileName
			local effectName = "DamageShareEffect"
			local firstApplication = (victim.ActiveEffects and not victim.ActiveEffects[effectName])
			ApplyDamageShare( victim, { EffectName = effectName })
			if projectileName then
				CreateProjectileFromUnit({ Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = sprintTraitData.OnSprintAction.Args.DamageMultiplier })
			end
			triggered = true
		end
		if HeroHasTrait("DemeterSprintBoon") then
			if SessionMapState.LeapStormId then
				ExpireProjectiles({ ProjectileIds = {SessionMapState.LeapStormId} })
			end
			local dataProperties = 
			{
				AttachToOwner = false	
			}
			SessionMapState.LeapStormId = CreateProjectileFromUnit({ Name = "DemeterSprintStorm", Id = CurrentRun.Hero.ObjectId, DamageMultiplier = sprintTraitData.OnWeaponFiredFunctions.FunctionArgs.DamageMultiplier, DataProperties = dataProperties, })
			triggered = true
		end

		-- Poseidon
		if HeroHasTrait("PoseidonSprintBoon") then
			local functionArgs = sprintTraitData.OnEnemyDamagedAction.Args
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier })				
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

function SpellMeteorFire()
	SessionMapState.BlockSpellCharge = true
	SessionMapState.BossHitChargeSpell = nil
end


function CheckBurnAll( weaponData, functionArgs, triggerArgs )
	if not ShouldFireFirstTimeOlympian() then
		return
	end
	
	thread( DoFullSuperPresentation, "Hestia" )
	IncrementTableValue( SessionMapState, "SpellFired" )
	SessionMapState.ReverseBurn = true
	thread( EndBurnAll, weaponData )
	local enemyIds = GetClosestIds({ Id =  CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulenrable = true, Distance = 4000, ScaleY = 0.6, PreciseCollision = true})
	for _, id in pairs( enemyIds ) do
		local enemy = ActiveEnemies[id]
		if enemy  and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) and not enemy.SkipModifiers and enemy.TriggersOnHitEffects and not IsUntargetable({Id = enemy.ObjectId}) then
			thread( ApplyBurn, enemy, { EffectName = functionArgs.EffectName, NumStacks = functionArgs.StartStacks })
			wait(0.05)
		end
	end
end

function StartReverseBurn( enemy, traitArgs)
	if not SessionMapState.ReverseBurn then
		return
	end
	wait(0.1)
	thread( ApplyBurn, enemy, { EffectName = "BurnEffect", NumStacks = traitArgs.StartStacks })
end

function EndBurnAll( weaponData )
	local duration = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Fuse" }) + GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "ProjectileInterval"})
	
	local endTime = _worldTimeUnmodified + duration
	while _worldTimeUnmodified < endTime do
		thread(StartOrRefreshLavaPresentation)
		waitUnmodified( 0.1, RoomThreadName )
	end
	SessionMapState.ReverseBurn = nil
end

function StartTimeSlowFreeze( functionArgs )
	if not ShouldFireFirstTimeOlympian() then
		return
	end
	
	thread( DoFullSuperPresentation, "Demeter" )
	IncrementTableValue( SessionMapState, "SpellFired" )
	SessionMapState.SpellFreeze = true
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies) ) do
		if enemy and (MapState.AggroedUnits[id] or RequiredKillEnemies[id] ) and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) and not enemy.SkipModifiers and enemy.TriggersOnHitEffects and not IsUntargetable({Id = enemy.ObjectId}) then
			ApplyEffect( { DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = EffectData[functionArgs.EffectName].DataProperties } )

			wait(0.05)
		end
	end
end

function CheckSpawnFreeze( enemy, functionArgs )
	if SessionMapState.SpellFreeze then
		ApplyEffect( { DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = EffectData[functionArgs.EffectName].DataProperties } )
	end
end

function EndTimeSlowFreeze( functionArgs )
	SessionMapState.SpellFreeze = nil	
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies) ) do
		if enemy then
			ClearEffect({ Id = enemy.ObjectId, Name = functionArgs.EffectName })
			wait(0.05)
		end
	end	
end

function CheckMeteorCharge( triggerArgs, functionArgs )
	if triggerArgs.name == "ProjectileSpellMeteor" then
		SessionMapState.BlockSpellCharge = nil
	end
end

function MeteorCheckInvulnerability( weaponData, args, triggerArgs )
	local duration = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Fuse" })
	local traitName = "MeteorInvulnerableChargeTalent"
	local trait = GetHeroTrait(traitName)
	trait.CurrentArmor = args.Armor
	AddHealthBuffer( args.Armor, traitName, { Silent = true, Temporary = true })
	SetPlayerTempArmorPresentation(traitName)
	FrameState.RequestUpdateHealthUI = true	
	thread( RemoveHealthBufferOnDelay, traitName, duration)
end

function MeteorStartVulnerability( weaponData, args, triggerArgs )
	local touchdownPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.TargetX, LocationY = triggerArgs.TargetY, Group = "Scripting"})
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
	local touchdownPoint = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.TargetX, LocationY = triggerArgs.TargetY, Group = "Scripting"})
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
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
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

function CheckSpellForceCharge( victim, functionArgs, triggerArgs )
	if victim.IsBoss and not SessionMapState.BossHitChargeSpell then
		SessionMapState.BossHitChargeSpell = true
		ChargeSpell( - functionArgs.ManaCharge, {Force = true })
		thread( UpdateManaMeterUI, triggerArgs )
	end
end

function SorceryChargeSetup( hero, args )
	args = args or {}
	args.Name = args.Name or "Backcompat"
	CurrentRun.Hero.SpellChargeSources = CurrentRun.Hero.SpellChargeSources or {}
	CurrentRun.Hero.SpellChargeSources [ args.Name ] = { Value = args.ChargePerSecond or 0 }
	thread( SpellRegen )
end


function SpellRegen()
	if HasThread("ChargeInterval") then
		return
	end
	local chargeOverflow = 0	
	while not CurrentRun.Hero.IsDead do
		local chargePerSecond = 0
		if CurrentRun.Hero.SpellChargeSources then
			for key, data in pairs(CurrentRun.Hero.SpellChargeSources) do
				chargePerSecond = chargePerSecond + data.Value
			end	
		end
		local encounter = nil
		if CurrentRun and CurrentRun.CurrentRoom then
			encounter = CurrentRun.CurrentRoom.Encounter
		end
		if not encounter or encounter.DelayedStart and not encounter.StartTime and not encounter.NeverDelayManaRegen then
			chargePerSecond = 0
		end
		if chargePerSecond > 0 then
			if (1/chargePerSecond) < HeroData.ManaData.MinManaTickRate then
				waitUnmodified( HeroData.ManaData.MinManaTickRate, "ChargeInterval")
				local charge, fraction = math.modf( chargePerSecond * HeroData.ManaData.MinManaTickRate )
				chargeOverflow = chargeOverflow + fraction
				if chargeOverflow >= 1 then
					chargeOverflow = chargeOverflow - 1
					charge = charge + 1
				end
				ChargeSpell( -charge )
			else
				waitUnmodified( 1 / chargePerSecond, "ChargeInterval" )
				ChargeSpell( -1 )
			end
		else
			waitUnmodified( HeroData.ManaData.MinManaTickRate, "ChargeInterval")
		end
	end
end

function MoonBeamSpellFire(unit, weaponData, functionArgs, triggerArgs )
	CurrentRun.SpellCharge = 0
	ClearEffect({ Name = "MedeaPoison", Id = CurrentRun.Hero.ObjectId })
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
		end
	end
	if spellTrait then
		UpdateSpellActiveStatus()
		thread(SpellUnreadyPresentation, spellTrait)
	end	
	OnSpellFired()
	thread(EndMoonBeam, weaponData, functionArgs )
end

function EndMoonBeam( weaponData, functionArgs )

	local firstFire = true
	if not ShouldFireFirstTimeOlympian() then
		firstFire = false
	else
		IncrementTableValue( SessionMapState, "SpellFired" )
	end

	SessionMapState.ConsecutiveMoonBeamHits = {}
	SessionMapState.BlockSpellCharge = true
	SessionMapState.MoonBeamActive = true
	local projectileName = functionArgs.ProjectileName
	if firstFire and HasHeroTraitValue("ReplaceMoonBeam") then
		local moonBeamReplacement = GetHeroTraitValues("ReplaceMoonBeam")[1]
		projectileName = moonBeamReplacement.ProjectileName	
		thread( DoFullSuperPresentation, "Ares" )
	end
	SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	local maxCount = 1 + GetTotalHeroTraitValue("MoonBeamTargetCountBonus")
		FireWeaponWithinRange({
			SourceId = CurrentRun.Hero.SourceId,
			Range = functionArgs.Range,
			SeekTarget = true, 
			WeaponName = weaponData.Name,
			ProjectileName = projectileName, 
			DamageMultiplier = functionArgs.DamageMultiplier,
			InitialDelay = functionArgs.Delay, 
			RunFunctionNameOnTarget = "ApplyMoonBeamExVulnerability",
			Delay = functionArgs.FollowUpDelay or 0.1, 
			Targets = 1 + GetTotalHeroTraitValue("MoonBeamTargetCountBonus"),
			Count = functionArgs.Count + GetTotalHeroTraitValue("MoonBeamCountBonus"),
			FireWithoutTarget = true })
	SessionMapState.BlockSpellCharge = nil
	SessionMapState.MoonBeamActive = nil
	
	local spellTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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

function ApplyMoonBeamExVulnerability( args )
	local effectName = "MoonBeamVulnerability"
	local dataProperties = EffectData[effectName].DataProperties
					
	ApplyEffect({ DestinationId = args.Id, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
end

function CheckMoonBeamConsecutiveDamage( victim, args, triggerArgs )
	if not victim or not victim.ObjectId then
		return
	end
	IncrementTableValue (SessionMapState.ConsecutiveMoonBeamHits, victim.ObjectId )
end

function CheckAutoMoonBeam(weaponData, functionArgs, triggerArgs )
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) then
	local sourceTrait = GetHeroTrait("SpellMoonBeamTrait")
	local sourceWeaponData = GetWeaponData(CurrentRun.Hero, sourceTrait.PreEquipWeapons[1])
	local functionArgs = sourceWeaponData.OnFiredFunctionArgs
	FireWeaponWithinRange({
			SourceId = CurrentRun.Hero.SourceId,
			Range = functionArgs.Range,
			SeekTarget = true, 
			WeaponName = sourceWeaponData.Name,
			ProjectileName = functionArgs.ProjectileName, 
			DamageMultiplier = functionArgs.DamageMultiplier,
			InitialDelay = functionArgs.Delay, 
			RunFunctionNameOnTarget = "ApplyMoonBeamExVulnerability",
			Delay = functionArgs.FollowUpDelay or 0.1, 
			Targets = 1,
			FireWithoutTarget = true })
	end
end

function ZeusStrikeNearProjectile( triggerArgs, functionArgs )
	if not ShouldFireFirstTimeOlympian() then
		return
	else
		IncrementTableValue( SessionMapState, "SpellFired" )
	end
	
	thread( DoFullSuperPresentation, "Zeus" )
	thread( HandleZeusStrikeNearProjectile, triggerArgs, functionArgs )
end

function HandleZeusStrikeNearProjectile( triggerArgs, functionArgs )
	local projectileId = triggerArgs.ProjectileId
	local followTarget = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Group = "Scripting" })
	while ProjectileExists({ Id = projectileId }) do
		local location = GetLocation({ Id = projectileId, IsProjectile = true })
		Teleport({ Id = followTarget, OffsetX = location.X, OffsetY = location.Y })
		thread( CreateZeusBolt, {
			SourceId =  followTarget,
			Range = functionArgs.Range, 
			SeekTarget = true, 
			ProjectileName = functionArgs.ProjectileName, 
			InitialDelay = 0, 
			FireWithoutTarget = true,
			Targets = functionArgs.Targets,
			FollowUpDelay = functionArgs.FollowUpDelay
		}) 
		wait( functionArgs.Interval )
	end
	Destroy({ Id = followTarget })
end

function PregenerateSpells( screen )
	SessionMapState.SelectedSpells = {}
	
	local eligibleSpells = GetEligibleSpells( screen )
	local items = 0
	while items < 3 and not IsEmpty( eligibleSpells ) do
		local spellName = RemoveRandomValue( eligibleSpells )
		table.insert(SessionMapState.SelectedSpells, spellName )
		items = items + 1
	end
	local duoEligible = false
	for _, spellName in pairs( SessionMapState.SelectedSpells ) do
		local spellData = SpellData[spellName]
		for _, talentName in pairs(spellData.Talents.Legendary) do
			local talentData = TraitData[talentName]
			if talentData.IsDuoBoon and IsGameStateEligible({}, talentData.GameStateRequirements ) then
				SessionMapState.DuoTalentEligible = true
				SessionMapState.DuoTalentEligibleSpell[spellName] = true
				SessionMapState.DuoTalentEligibleGender[ LootData[talentData.LinkedGod ].Gender ] = true
			end
		end
	end
end

function ShouldFireFirstTimeOlympian()
	-- Should mirror requirements for godsent VO
	if IsEmpty(RequiredKillEnemies) and CurrentRun.CurrentRoom.RoomSetName ~= "H" then
		return false
	end
	if SessionMapState.SpellMultiuseCount and SessionMapState.SpellMultiuseCount > 0 then
		return false
	end

	local hasAnyDuo = false
	for _, traitName in ipairs(GameData.AllHexDuos) do
		if HeroHasTrait( traitName ) then
			hasAnyDuo = true
			break
		end
	end
	
	if not hasAnyDuo then
		return false
	end

	local uses = 1 + GetTotalHeroTraitValue("OlympianSpellCountAddition")
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.EncounterType == "Boss" and not CurrentRun.CurrentRoom.Encounter.SkipBossTraits then
		uses = uses + GetTotalHeroTraitValue("OlympianSpellCountBossAddition")
	end
	if SessionMapState.SpellFired and SessionMapState.SpellFired >= uses then
		return false
	end
	return true
end