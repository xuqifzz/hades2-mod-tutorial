
function InitializeMetaUpgradeState()
	if not GameState.MetaUpgradeCardLayout or not GameState.MetaUpgradeState then
		GameState.MetaUpgradeCardLayout = DeepCopyTable( MetaUpgradeDefaultCardLayout )
	end
	if IsEmpty( GameState.MetaUpgradeState ) then
		GameState.MetaUpgradeState = {}
	end

	for metaUpgradeName, initialData in pairs( MetaUpgradeCardData ) do
		if not GameState.MetaUpgradeState[metaUpgradeName] then
			GameState.MetaUpgradeState[metaUpgradeName] = {}
			if initialData.StartUnlocked then
				GameState.MetaUpgradeState[metaUpgradeName].Unlocked = true
			end
			if initialData.StartEquipped then
				GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
			end
		end
		GameState.MetaUpgradeState[metaUpgradeName].Level = GameState.MetaUpgradeState[metaUpgradeName].Level or 1
	end
end

function EquipMetaUpgrades( hero, args )

	local skipTraitHighlight = args.SkipTraitHighlight or false
	
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if MetaUpgradeCardData[ metaUpgradeName ] and metaUpgradeData.Equipped and MetaUpgradeCardData[ metaUpgradeName ].TraitName and not HeroHasTrait( MetaUpgradeCardData[ metaUpgradeName ].TraitName ) then
			
		local cardMultiplier = 1
		if GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses and GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses.CustomMultiplier then
			cardMultiplier = cardMultiplier + GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses.CustomMultiplier 
		end
		AddTraitToHero({ 
				SkipNewTraitHighlight = skipTraitHighlight, 
				TraitName = MetaUpgradeCardData[ metaUpgradeName ].TraitName, 
				Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( metaUpgradeName )],
				CustomMultiplier = cardMultiplier,
				SourceName = metaUpgradeName,
				})
		end
	end
end

function GetMetaUpgradeLevel( metaUpgradeName )
	if GameState.MetaUpgradeState[ metaUpgradeName ].Level then
		return GameState.MetaUpgradeState[ metaUpgradeName ].Level
	end
	return 1
end

function HasAffordableMetaUpgradeUpgrade()
	local count = 0
	for metaUpgradeName, data in pairs( GameState.MetaUpgradeState ) do
		if not MetaUpgradeCardData[metaUpgradeName].DebugOnly and data.Unlocked and not MetaUpgradeAtMaxLevel( metaUpgradeName ) and CanUpgradeMetaUpgrade( metaUpgradeName ) then
			if HasResources(MetaUpgradeCardData[metaUpgradeName].UpgradeResourceCost[GetMetaUpgradeLevel( metaUpgradeName )]) then
				return true
			end
		end
	end
	return false
end

function EquipPreRunMetaUpgrades( eventSource, hero )
	EquipMetaUpgrades( hero, { SkipTraitHighlight = true })
	ValidateMaxHealth()
	ValidateMaxMana()
	HandleWeaponAnimSwaps()
	CurrentRun.NumRerolls = GetTotalHeroTraitValue( "RerollCount" )
end

function UnequipMetaUpgrades( eventSource, hero )
	hero = hero or CurrentRun.Hero
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if MetaUpgradeCardData[ metaUpgradeName ] and metaUpgradeData.Equipped and MetaUpgradeCardData[ metaUpgradeName ].TraitName and 
		( eventSource == nil or not MetaUpgradeCardData[ metaUpgradeName ].ActiveWhileDead ) then
			RemoveWeaponTrait(	MetaUpgradeCardData[ metaUpgradeName ].TraitName )
		end
	end
end

function ClearPreRunUpgrades( eventSource, hero )
	UnequipMetaUpgrades( eventSource, hero)
	UnequipWeaponUpgrade()
end

function CheckAutoEquipRequirements( requirementData )
	local metaUpgradeCosts = {}
	local totalMetaUpgrades = 0
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if MetaUpgradeCardData[ metaUpgradeName ] and metaUpgradeData.Equipped and not MetaUpgradeCardData[ metaUpgradeName ].AutoEquipRequirements then
			local cost = MetaUpgradeCardData[ metaUpgradeName ].Cost or 0
			IncrementTableValue( metaUpgradeCosts, cost )
			totalMetaUpgrades = totalMetaUpgrades + 1
		end
	end

	if requirementData.HasCostsThrough then
		for cost = 1, requirementData.HasCostsThrough do
			if not metaUpgradeCosts[cost] then
				return false
			end
		end
	end

	if requirementData.HasCosts then
		for i, cost in pairs( requirementData.HasCosts ) do
			if not metaUpgradeCosts[cost] then
			
				return false
			end
		end
	end

	if requirementData.MaxDuplicateCount then
		for cost, amount in pairs( metaUpgradeCosts ) do
			if amount > requirementData.MaxDuplicateCount then
				return false
			end
		end
	end
	if requirementData.MinDuplicateCount then
		local hasDuplicate = false
		for cost, amount in pairs( metaUpgradeCosts ) do
			if amount >= requirementData.MinDuplicateCount then
				hasDuplicate = true
			end
		end
		if not hasDuplicate then
			return false
		end
	end
	if requirementData.RequiredMetaUpgradesMin then
		if totalMetaUpgrades < requirementData.RequiredMetaUpgradesMin then
			return false
		end
	end
	if requirementData.RequiredMetaUpgradesMax then
		if totalMetaUpgrades > requirementData.RequiredMetaUpgradesMax then
			return false
		end
	end
	if requirementData.SurroundAllEquipped then
		local sourceCoords = GetMetaUpgradeCardCoords( requirementData.MetaUpgradeName )
		if not sourceCoords then
			return false
		end
		local coordsCheck = GetNeighboringCoords( sourceCoords.Row, sourceCoords.Column, true )
		for i, coords in pairs(coordsCheck) do
			local metaUpgradeName = GameState.MetaUpgradeCardLayout[ coords.Row ][ coords.Column ]
			if not GameState.MetaUpgradeState[metaUpgradeName] or not GameState.MetaUpgradeState[metaUpgradeName].Equipped then
				return false
			end
		end
	end

	if requirementData.SurroundEquipped then
		local sourceCoords = GetMetaUpgradeCardCoords( requirementData.MetaUpgradeName )
		if not sourceCoords then
			return false
		end
		local coordsCheck = GetNeighboringCoords( sourceCoords.Row, sourceCoords.Column, true )
		local noneEquipped = true
		for i, coords in pairs(coordsCheck) do
			local metaUpgradeName = GameState.MetaUpgradeCardLayout[ coords.Row ][ coords.Column ]
			if GameState.MetaUpgradeState[metaUpgradeName] and GameState.MetaUpgradeState[metaUpgradeName].Equipped then
				noneEquipped = false
			end
		end
		if noneEquipped then
			return false
		end
	end

	if requirementData.OtherRowOrColumnEquipped then
		local sourceCoords = GetMetaUpgradeCardCoords( requirementData.MetaUpgradeName )
		if not sourceCoords then
			return false
		end
		local hasOtherRowEquipped = false
		local hasOtherColumnEquipped = false
		for i=1, GetZoomLevel() do
			local rowEquipped = true
			local columnEquipped = true
			-- Column check
			if i == sourceCoords.Column then
				columnEquipped = false
			else
				local coordsCheck = GetCoordsInColumn( i )
				columnEquipped = true	
				for i, coords in pairs(coordsCheck) do
					local metaUpgradeName = GameState.MetaUpgradeCardLayout[ coords.Row ][ coords.Column ]
					if not GameState.MetaUpgradeState[metaUpgradeName] or not GameState.MetaUpgradeState[metaUpgradeName].Equipped then
						columnEquipped = false
					end
				end
			end
			if columnEquipped then
				hasOtherColumnEquipped = true
				break
			end
			-- Row check
			if i == sourceCoords.Row then
				rowEquipped = false
			else
				local coordsCheck = GetCoordsInRow( i )
				rowEquipped = true	
				for i, coords in pairs(coordsCheck) do
					local metaUpgradeName = GameState.MetaUpgradeCardLayout[ coords.Row ][ coords.Column ]
					if not GameState.MetaUpgradeState[metaUpgradeName] or not GameState.MetaUpgradeState[metaUpgradeName].Equipped then
						rowEquipped = false
					end
				end
			end
			if rowEquipped then
				hasOtherRowEquipped = true
				break
			end
		end
		if not hasOtherRowEquipped and not hasOtherColumnEquipped then
			return false
		end
	end
	return true
end

function UpdateMetaUpgradeCardAdjacencyBonuses()
	local toApply = {}
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		metaUpgradeData.AdjacencyBonuses = {}
		if metaUpgradeData.Equipped and MetaUpgradeCardData[metaUpgradeName].AdjacencyBonus then
			local coords = GetMetaUpgradeCardCoords( metaUpgradeName )
			local coordsCheck = GetNeighboringCoords( coords.Row, coords.Column, true )
			table.insert( toApply, { AffectedCoords  = coordsCheck, AdjacencyBonus =  { CustomMultiplier = MetaUpgradeCardData[metaUpgradeName].AdjacencyBonus.CustomMultiplier[GetMetaUpgradeLevel("BonusDoubler")] }} )
		end
	end
	for _, applyData in pairs( toApply ) do
		for i, coord in pairs ( applyData.AffectedCoords ) do
			local metaUpgradeName = GameState.MetaUpgradeCardLayout[coord.Row][coord.Column]
			GameState.MetaUpgradeState[metaUpgradeName].AdjacencyBonuses = MergeTables( GameState.MetaUpgradeState[metaUpgradeName].AdjacencyBonuses, applyData.AdjacencyBonus)
		end
	end
end

function GetMetaUpgradeCardCoords( metaUpgradeName )
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if cardName == metaUpgradeName then
				return { Row = row, Column = column }
			end
		end
	end
	return nil
end

function CheckWeaponCastChannelSlow( weaponData, args )
	if weaponData.ChannelSlowIneligible then
		return
	end
	wait( GetHideChargeDuration(weaponData), RoomThreadName)
	local chargeStages = GetWeaponChargeStages( weaponData )
	local skipWait = false
	if chargeStages[1] and ( chargeStages[1].ChannelSlowEventOnStart or chargeStages[1].ChannelSlowEventOnEnter ) then
		if not MapState.WeaponCharge or not MapState.WeaponCharge[weaponData.Name] then
			return
		end	
		skipWait = true
	end

	if weaponData.CustomChannelSlowEvent and not skipWait then
		waitUntil( weaponData.CustomChannelSlowEvent, RoomThreadName )
	end	
	if not GameState.Flags.UsedSlowAgainstChronos and CurrentRun.BossHealthBarRecord.Chronos then
		GameState.Flags.UsedSlowAgainstChronos = true
	end
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.Modifier, Name = weaponData.Name })
	thread( EndWeaponCastChannelSlow, weaponData, args )
end


function EndWeaponCastChannelSlow( weaponData, args )

	local notifyName = weaponData.Name .. "Fired"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=", Timeout = args.Duration })
	waitUntil( notifyName )	

	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.Modifier, Reverse = true, Name = weaponData.Name })
end

function WeaponCastFired( owner, weaponData, args, triggerArgs)
	local projectileIds = { triggerArgs.ProjectileId }
	local attachedProjectileIds = {}
	local baseDuration = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileCast", Property = "FuseStart" })
	-- TODO: Extracting this data from property changes and/or fired function args are foiled by the way that various boons change every variable separately
	for i, traitArgs in pairs(GetHeroTraitValues("CastProjectileModifiers")) do
		for _, projectileId in pairs( projectileIds ) do
			SetDamageRadiusMultiplier({ Id = projectileId, Fraction = traitArgs.AreaIncrease, Duration = baseDuration })
		end
	end
	thread( StartCastSlow, triggerArgs.ProjectileId, baseDuration )
	SessionMapState.CastAttachedProjectiles[triggerArgs.ProjectileId] = attachedProjectileIds
	SessionMapState.LastCastProjectileId = triggerArgs.ProjectileId
	SessionMapState.LastCastProjectileVolley = triggerArgs.ProjectileVolley
	if weaponData.Name == "WeaponCast" and weaponData.UnarmedCastCompleteGraphic then
		thread(CheckCastCompleteGraphic, weaponData)
	end
	if SessionMapState.ArmCast then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponCastArm", Method = "ArmProjectiles" })
		SessionMapState.ArmCast = nil
		local interestedTraits = 
		{
			StaffSelfHitAspect = true,
			PoseidonManaBoon = true,
			LobGunAspect = true,
			ClearCastTalent = true,
			ChaosExAttackCurse = true,
			MagicCritMetaUpgrade = true,
		}
		for traitName in pairs( interestedTraits ) do
			if HeroHasTrait(traitName) then
				triggerArgs.DisjointExCast = true
				local traitData = GetHeroTrait(traitName)
				if traitData.OnWeaponFiredFunctions then
					thread( CallFunctionName, traitData.OnWeaponFiredFunctions.FunctionName, weaponData, traitData.OnWeaponFiredFunctions.FunctionArgs, triggerArgs )
				end
				triggerArgs.DisjointExCast = false
			end
		end
	end
	if HeroHasTrait("HadesCastProjectileBoon") and triggerArgs.TargetId then
		AttachProjectiles({ Ids = projectileIds, DestinationId = triggerArgs.TargetId })
		for _, id in pairs(SessionState.PoseidonExCastTarget) do
			Attach({ Id = id, DestinationId = triggerArgs.TargetId  })
		end
	end
	notifyExistingWaiters(weaponData.Name .. "Fired")
end

function CheckChargeCastBuffs()
	if not HasHeroTraitValue("InvulnerableDuringCastCharge") and not HasHeroTraitValue("CastChargeBuffDuration") then
		return
	end
	SetPlayerPhasing("CastCharge")
	SetPlayerInvulnerable("CastCharge")
	local traitData = GetHeroTrait("DodgeBonusMetaUpgrade")
	local effectName = "CastSpeedBoostEffect"
	local dataProperties = ShallowCopyTable(EffectData[effectName].DataProperties )
	dataProperties.Modifier = traitData.CastChargeSpeedMultiplier
	dataProperties.Duration = traitData.CastChargeBuffDuration

	local baseSpeed = GetBaseDataValue({ Type = "Unit", Name = "_PlayerUnit", Property = "Speed" })
	local currentSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed" })
	local targetSpeed = baseSpeed * traitData.CastChargeSpeedMultiplier
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxSpeed", Value = targetSpeed })

	ApplyEffect({DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })

	local gripEffectName = "CastGripEffect"
	local dataProperties = ShallowCopyTable(EffectData[gripEffectName].DataProperties )
	dataProperties.Duration = traitData.CastChargeGripDuration
	ApplyEffect({DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = gripEffectName, DataProperties = dataProperties })
	SetPlayerDarkside("CastCharge")
	thread(EndCastInvulnerability, traitData.CastInvulnerableDuration)
end

function EndCastInvulnerability( duration )
	wait( duration )
	SetPlayerVulnerable("CastCharge")
	SetPlayerUnphasing("CastCharge")
	SetPlayerUnDarkside("CastCharge")
end

function StartCastSlow( projectileId, duration )
	local scaleX = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleX" })
	local scaleY = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleY" })
	local impactSlowDataProperties = ShallowCopyTable( EffectData.ImpactSlow.DataProperties )
	local impactSlowEffect = { Id = CurrentRun.Hero.ObjectId, EffectName = "ImpactSlow", DataProperties = impactSlowDataProperties }
	local impactGripDataProperties = ShallowCopyTable( EffectData.ImpactGrip.DataProperties )
	local impactGripEffect = { Id = CurrentRun.Hero.ObjectId, EffectName = "ImpactGrip", DataProperties = impactGripDataProperties }
	while ProjectileExists({ Id = projectileId }) do
		local radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
		local ids = GetClosestIds({ ProjectileId = projectileId, Distance = radius, DestinationName = "EnemyTeam", IgnorePermanentlyInvulnerable = true, ScaleX = scaleX, ScaleY = scaleY, PreciseCollision = true })
		for _, id in pairs( ids ) do
			local victim = ActiveEnemies[id]
			if victim ~= nil then
				if victim.IgnoreCastSlow then
					impactSlowDataProperties.Type = "TAG"
					impactSlowDataProperties.HaltOnStart = false
					impactGripDataProperties.Type = "TAG"
					impactGripDataProperties.HaltOnStart = false
				else
					impactSlowDataProperties.Type = EffectData.ImpactSlow.DataProperties.Type
					impactSlowDataProperties.HaltOnStart = EffectData.ImpactSlow.DataProperties.HaltOnStart
					impactGripDataProperties.Type = EffectData.ImpactGrip.DataProperties.Type
					impactGripDataProperties.HaltOnStart = EffectData.ImpactGrip.DataProperties.HaltOnStart
				end
				impactSlowEffect.DestinationId = id
				ApplyEffect( impactSlowEffect )
				impactGripEffect.DestinationId = id
				ApplyEffect( impactGripEffect )
				for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnCastEffectApplyFunction ) do
					CallFunctionName( data.FunctionName, victim, data.FunctionArgs, projectileId )
				end
			end
		end
		if not IsEmpty( GetInProjectilesBlast({ Id = CurrentRun.Hero.ObjectId, DestinationName = "ProjectileCast", UseDamageRadius = true, ReturnFirst = true }) ) then
			local effectName = "InsideCastBuff"
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
		end
		waitUnmodified( 0.15 )
	end
end

function RefreshImpactSlow( victim, victimId, triggerArgs )
	if not Contains( victim.Groups, "EnemyTeam" ) then
		return
	end
	local effectNames = { "ImpactSlow", "ImpactGrip" }
	for _, effectName in pairs(effectNames) do
		local dataProperties = ShallowCopyTable(EffectData[effectName].DataProperties)
		if victim.IsBoss then
			dataProperties.HaltOnStart = false
		end
		if CurrentRun.Hero.ObjectId ~= nil then
			ApplyEffect({ DestinationId = victimId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
		end
	end
end

function CastProjectileCleanup( projectileData, triggerArgs )
	local id = triggerArgs.ProjectileId
	SessionMapState.CastAttachedProjectiles[id] = nil
end

function CheckCastCompleteGraphic( weaponData )
	if not IsControlDown({ Name = "Attack1" }) or not GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCastArm", Property = "Enabled"}) then
		-- Quick tap or OOM presentation
		if weaponData.UnarmedCastCompleteGraphic ~= "nil" and not MapState.HostilePolymorph then
			if not ( MapState.WeaponCharge.WeaponLobSpecial and MapState.WeaponCharge.WeaponLobSpecial >= 1 ) then
				SetAnimation({ Name = weaponData.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	else
		-- Release during  cast arm presentation

		local notifyName = "ResetAnimation"
		local frameWait = 0.02
		waitUnmodified( frameWait )
		local timeout = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCastArm", Property = "ChargeTime" }) - frameWait
		-- Brittle, more directly optimized version
		if HeroHasTrait("ApolloSecondStageCastBoon") then
			local hasMana = true
			timeout = 0
			local trait = GetHeroTrait("ApolloSecondStageCastBoon")
			for i, chargeStage in pairs( trait.WeaponDataOverride.WeaponCastArm.ChargeWeaponStages) do
				timeout = timeout + chargeStage.Wait
				if GetManaCost( weaponData, false, { ManaCostOverride = chargeStage.ManaCost }) > CurrentRun.Hero.Mana then
					hasMana = false
				end
			end
			if not hasMana then
				timeout = nil
			else
				timeout = timeout * GetLuaWeaponSpeedMultiplier( weaponData.Name )
			end
		end
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = "WeaponCastArm", ChargeFraction = 0.0, Comparison = "<=", Timeout = timeout })
		waitUntil( notifyName )
		if weaponData.UnarmedCastCompleteGraphic ~= "nil" and not MapState.HostilePolymorph then
			SetAnimation({ Name = weaponData.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })	
		end
	end
end

function AddRandomMetaUpgrades( numCards, args )

	args = args or {}
	numCards = numCards or 3
	local delay = args.Delay or 3
	local unequippedUnlockedMetaupgrades = {}
	local skippedLowPriorityMetaupgrade = {}
	local equippedMetaUpgrades = {}
	for cardName, cardData in pairs(GameState.MetaUpgradeState) do
		if cardData.Equipped then		
			equippedMetaUpgrades[cardName] = true
		end
	end

	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			local metaUpgradeData = GameState.MetaUpgradeState[cardName]
			if metaUpgradeData and metaUpgradeData.Unlocked and not metaUpgradeData.Equipped then
				local fateConflict = false
				if GameState.FatedStatus == "Fated" and FatedDisableMetaUpgrades[cardName] then
					fateConflict = true
				end
				if not fateConflict then
					if MetaUpgradeCardData[cardName].RandomDrawChance then
						if RandomChance(MetaUpgradeCardData[cardName].RandomDrawChance) then
							table.insert(unequippedUnlockedMetaupgrades, cardName)
						else
							table.insert(skippedLowPriorityMetaupgrade, cardName)
						end
					else
						table.insert(unequippedUnlockedMetaupgrades, cardName)
					end
				end
			end
		end
	end

	local addedMetaUpgrades = {}
	while (not IsEmpty( unequippedUnlockedMetaupgrades ) or not IsEmpty( skippedLowPriorityMetaupgrade )) and numCards > 0 do
		numCards = numCards - 1
		local metaUpgradeName = nil
		if not IsEmpty( unequippedUnlockedMetaupgrades ) then
			metaUpgradeName = RemoveRandomValue(unequippedUnlockedMetaupgrades)
		else
			metaUpgradeName = RemoveRandomValue(skippedLowPriorityMetaupgrade)
		end
		if MetaUpgradeCardData[metaUpgradeName].RequiredCardNames and not ContainsAnyKey( equippedMetaUpgrades, MetaUpgradeCardData[metaUpgradeName].RequiredCardNames ) and not IsEmpty(unequippedUnlockedMetaupgrades) then
			table.insert( skippedLowPriorityMetaupgrade, metaUpgradeName )
			metaUpgradeName = RemoveRandomValue( unequippedUnlockedMetaupgrades )
		end
		CurrentRun.TemporaryMetaUpgrades[metaUpgradeName] = true
		GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
		equippedMetaUpgrades[metaUpgradeName] = true

		table.insert( addedMetaUpgrades, metaUpgradeName )
		if MetaUpgradeCardData[ metaUpgradeName ].TraitName then
			local rarityLevel = GetMetaUpgradeLevel( metaUpgradeName )
			if args.RarityLevel then
				rarityLevel = args.RarityLevel
			end
			AddTraitToHero({ 
				SkipNewTraitHighlight = true, 
				TraitName = MetaUpgradeCardData[ metaUpgradeName ].TraitName, 
				Rarity = TraitRarityData.RarityUpgradeOrder[ rarityLevel ],
				CustomMultiplier = 1,
				SourceName = metaUpgradeName,
				})
		end
		if MetaUpgradeCardData[ metaUpgradeName ].OnGrantedFunctionName then
			thread( CallFunctionName, MetaUpgradeCardData[ metaUpgradeName ].OnGrantedFunctionName, MetaUpgradeCardData[ metaUpgradeName ].TraitName, MetaUpgradeCardData[ metaUpgradeName ].OnGrantedFunctionArgs, args )
		end
	end
	if numCards > 0 and not IsEmpty(lowPriorityMetaupgrades) then
	
	end

	thread( AddedMetaUpgradePresentation, addedMetaUpgrades, delay )
end

function GrantMetaUpgradeRerolls( traitName, args )
	local trait = GetHeroTrait( traitName )
	if trait then
		AddRerolls( traitName, { Amount = trait.RerollCount } )
	end
end

function UpgradeMetaUpgradeRerolls( oldTrait, newTrait )
	local difference = newTrait.RerollCount - oldTrait.RerollCount
	AddRerolls( newTrait.Name, { Amount = difference } )
end

function GrantMetaUpgradeCurrency( traitName, args )
	local trait = GetHeroTrait( traitName )
	if trait and not HasHeroTraitValue("BlockMoney") then
		AddResource( "Money", trait.BonusMoney, "RunStart" )
	end
end

function UpgradeMetaUpgradeCurrency( oldTrait, newTrait )
	local difference = newTrait.BonusMoney - oldTrait.BonusMoney
	if not HasHeroTraitValue("BlockMoney") then
		AddResource( "Money", difference , "RunStart" )
	end
end


function GrantMetaUpgradeLastStands( traitName, args )
	local trait = GetHeroTrait( traitName )
	if trait then
		for i = 1, trait.AddMetaUpgradeLastStands do
			AddLastStand({
				Unit = CurrentRun.Hero,
				IncreaseMax = true,
				Icon = "ExtraLifeMel",
				ManaFraction = 0.4,
				HealFraction = 0.4,
			})
		end
		RecreateLifePips()
	end
end

function UpgradeMetaUpgradeLastStands( oldTrait, newTrait )
	local difference = newTrait.AddMetaUpgradeLastStands - oldTrait.AddMetaUpgradeLastStands
	for i = 1, difference do
		AddLastStand({
			Unit = CurrentRun.Hero,
			IncreaseMax = true,
			Icon = "ExtraLifeMel",
			ManaFraction = 0.4,
			HealFraction = 0.4,
		})
	end
	RecreateLifePips()
end

function RoomStatGrowth( unit, args )
	local traitData = GetHeroTrait("ChamberHealthMetaUpgrade")
	traitData.CurrentRoom = traitData.CurrentRoom + 1
	if traitData.CurrentRoom >= args.Amount then
		local addedMana = 0
		local addedHealth = 0
		traitData.CurrentRoom = 0

		if args.MaxMana then
			addedMana = round(args.MaxMana)
			AddMaxMana( addedMana, traitData.Name, { Thread = true, Silent = true})
		end
		if args.MaxHealth then
			addedHealth = round(args.MaxHealth)
			AddMaxHealth( addedHealth, traitData.Name, { Thread = true, Silent = true })
		end
		if CurrentRun and GetPreviousRoom( CurrentRun ) and GetPreviousRoom( CurrentRun ).NextRoomEntranceFunctionArgsOverride  and GetPreviousRoom( CurrentRun ).NextRoomEntranceFunctionArgsOverride.NotifyName  then
			waitUntil(GetPreviousRoom( CurrentRun ).NextRoomEntranceFunctionArgsOverride.NotifyName)
		end
		if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.EncounterType ~= "Boss" then
			local waitTime = CurrentRun.CurrentRoom.EntrancePresentationDelay or 0.8	
			if addedHealth > 0  and addedMana > 0 then
				waitUnmodified(waitTime)
				thread(BonusHealthAndManaPresentation, addedHealth, addedMana )
			elseif addedMana > 0 then
				waitUnmodified(waitTime)
				thread(BonusManaPresentation, addedMana )
			end
		end
	end
end


function RemoveSprintBonusVolley( triggerArgs )
	waitUnmodified(0.1)
	SessionMapState.SprintBonusProjectiles[ triggerArgs.ProjectileId ] = nil
	if not IsExWeapon( triggerArgs.WeaponName, {Combat = true}, triggerArgs ) then
		return
	end
	if triggerArgs.WeaponName and SessionMapState.SprintBonusVolleys and SessionMapState.SprintBonusVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( SessionMapState.SprintBonusVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if SessionMapState.SprintBonusVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			SessionMapState.SprintBonusVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckSprintBonusVolley( weaponData, functionArgs, triggerArgs )
	if weaponData.Name == "WeaponBlink" then
		SessionMapState.SprintBonusCharge = true
		return
	end
	if not IsExWeapon( weaponData.Name , {Combat = true}, triggerArgs ) then
		return
	end
	if SessionMapState.SprintBonusCharge and (( triggerArgs.ProjectileVolley and triggerArgs.NumProjectiles) or weaponData.Name == "WeaponCastArm") then
		if weaponData.Name == "WeaponSuitRanged" and not HeroHasTrait("SuitComboAspect") then
			SessionMapState.SprintBonusVolleys[weaponData.Name] = SessionMapState.SprintBonusVolleys[weaponData.Name] or {}
			if not IsEmpty(SessionMapState.TargetedEnemies) then
				IncrementTableValue( SessionMapState.SprintBonusVolleys[weaponData.Name], triggerArgs.ProjectileVolley, TableLength(SessionMapState.TargetedEnemies) * 2 )
			else
				IncrementTableValue( SessionMapState.SprintBonusVolleys[weaponData.Name], triggerArgs.ProjectileVolley, 4 )
			end
		elseif weaponData.Name == "WeaponCastArm" then
			SessionMapState.SprintBonusVolleys.WeaponCast = SessionMapState.SprintBonusVolleys.WeaponCast or {}
			IncrementTableValue( SessionMapState.SprintBonusVolleys.WeaponCast, SessionMapState.LastCastProjectileVolley )
		else
			SessionMapState.SprintBonusVolleys[weaponData.Name] = SessionMapState.SprintBonusVolleys[weaponData.Name] or {}
			IncrementTableValue( SessionMapState.SprintBonusVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		end
		SessionMapState.SprintBonusCharge = nil
	end
end
