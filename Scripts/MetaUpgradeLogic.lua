
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

	if GetNumShrineUpgrades( "NoMetaUpgradesShrineUpgrade" ) >= 1 then
		return
	end

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

function EquipPreRunMetaUpgrades( eventSource, hero )
	EquipMetaUpgrades( hero, { SkipTraitHighlight = true })
	ValidateMaxHealth()
	ValidateMaxMana()
	HandleWeaponAnimSwaps()
end

function UnequipMetaUpgrades( eventSource, hero )
	hero = hero or CurrentRun.Hero
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if MetaUpgradeCardData[ metaUpgradeName ] and metaUpgradeData.Equipped and MetaUpgradeCardData[ metaUpgradeName ].TraitName then
			RemoveWeaponTrait(	MetaUpgradeCardData[ metaUpgradeName ].TraitName )
		end
	end
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

	if requirementData.OtherRowEquipped then
		local sourceCoords = GetMetaUpgradeCardCoords( requirementData.MetaUpgradeName )
		if not sourceCoords then
			return false
		end
		local hasOtherRowEquipped = false
		for i=1, GetZoomLevel() do
			local rowEquipped = true
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
		if not hasOtherRowEquipped then
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
	if chargeStages[1] and chargeStages[1].ChannelSlowEventOnStart then
		if not MapState.WeaponCharge or not MapState.WeaponCharge[weaponData.Name] then
			return
		end	
		skipWait = true
	end

	if weaponData.CustomChannelSlowEvent and not skipWait then
		waitUntil( weaponData.CustomChannelSlowEvent, RoomThreadName )
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
	if HeroHasTrait("AxeArmCastAspect") then
		local trait = GetHeroTrait("AxeArmCastAspect")
		if trait.DurationIncrease then
			baseDuration = baseDuration + trait.DurationIncrease
		end
	end
	for i, traitArgs in pairs(GetHeroTraitValues("CastProjectileModifiers")) do
		for _, projectileId in pairs( projectileIds ) do
			SetDamageRadiusMultiplier({ Id = projectileId, Fraction = traitArgs.AreaIncrease, Duration = baseDuration })
		end
	end
	thread( StartCastSlow, triggerArgs.ProjectileId, baseDuration )
	SessionMapState.CastAttachedProjectiles[triggerArgs.ProjectileId] = attachedProjectileIds

	if weaponData.Name == "WeaponCast" and weaponData.UnarmedCastCompleteGraphic then
		thread(CheckCastCompleteGraphic, weaponData)
	end
	if SessionMapState.ArmCast then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponCastArm", Method = "ArmProjectiles" })
		SessionMapState.ArmCast = nil
	end
	if HeroHasTrait("HadesCastProjectileBoon") and triggerArgs.TargetId then
		AttachProjectiles({ Ids = projectileIds, DestinationId = triggerArgs.TargetId })		
	end
	notifyExistingWaiters(weaponData.Name .. "Fired")
end

function StartCastSlow (projectileId, duration )
	local scaleX = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleX" })
	local scaleY = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleY" })
	while ProjectileExists({ Id = projectileId }) do
		local radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
		local location = GetLocation({ Id = projectileId, IsProjectile = true })
		local destinationId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y, Group = "Scripting"})
		local ids = GetClosestIds({ Id = destinationId, Distance = radius, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, ScaleX = scaleX, ScaleY = scaleY, PreciseCollision = true })
		for _, id in pairs(ids) do
			local effectNames = { "ImpactSlow", "ImpactGrip" }
			for _, effectName in pairs(effectNames) do
				ApplyEffect({ DestinationId = id, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
			end
		end
		if not IsEmpty(GetInProjectilesBlast({ Id = CurrentRun.Hero.ObjectId, DestinationName = "ProjectileCast", UseDamageRadius = true })) then
			local effectName = "InsideCastBuff"
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
		end
		Destroy ({ Id = destinationId })
		waitUnmodified( 0.15, RoomThreadName )
	end
end

function RefreshImpactSlow ( victim, victimId, triggerArgs )
	local effectNames = { "ImpactSlow", "ImpactGrip" }
	for _, effectName in pairs(effectNames) do
		ApplyEffect({ DestinationId = victimId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
	end
end

function CastProjectileCleanup( projectileData, triggerArgs )
	local id = triggerArgs.ProjectileId
	SessionMapState.CastAttachedProjectiles[id] = nil
end

function CheckCastCompleteGraphic( weaponData )
	if not IsControlDown({ Name = "Attack1" }) or not GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCastArm", Property = "Enabled"}) then
		-- Quick tap or OOM presentation
		if weaponData.UnarmedCastCompleteGraphic ~= "nil" then
			SetAnimation({ Name = weaponData.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })
		end
	else
		-- Release during  cast arm presentation
		local notifyName = "ResetAnimation"
		local frameWait = 0.02
		wait( frameWait )
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = "WeaponCastArm", ChargeFraction = 0.0, Comparison = "<=", Timeout = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCastArm", Property = "ChargeTime" }) - frameWait })
		waitUntil( notifyName )
		if not _eventTimeoutRecord[ notifyName ] and weaponData.UnarmedCastCompleteGraphic ~= "nil" then
			SetAnimation({ Name = weaponData.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end

function LastStandTimeSlow( unit, args )
	thread( RunLastStandTimeSlow, unit, args )
end

function RunLastStandTimeSlow( unit, args )
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.Modifier, Name = "LastStand" })
	waitUnmodified( args.Duration, RoomThreadName)
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.Modifier, Reverse = true, Name = "LastStand" })
	
end

function AddRandomMetaUpgrades( numCards, args )

	if GetNumShrineUpgrades( "NoMetaUpgradesShrineUpgrade" ) >= 1 then
		return
	end

	args = args or {}
	numCards = numCards or 3
	local delay = args.Delay or 3
	local unequippedUnlockedMetaupgrades = {}
	
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if GameState.MetaUpgradeState[cardName] and GameState.MetaUpgradeState[cardName].Unlocked and not GameState.MetaUpgradeState[cardName].Equipped then
				table.insert(unequippedUnlockedMetaupgrades, cardName)
			end
		end
	end

	local addedMetaUpgrades = {}
	while not IsEmpty( unequippedUnlockedMetaupgrades ) and numCards > 0 do
		numCards = numCards - 1
		local metaUpgradeName = RemoveRandomValue(unequippedUnlockedMetaupgrades)
		CurrentRun.TemporaryMetaUpgrades[metaUpgradeName] = true
		GameState.MetaUpgradeState[metaUpgradeName].Equipped = true

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
			thread( CallFunctionName, MetaUpgradeCardData[ metaUpgradeName ].OnGrantedFunctionName, MetaUpgradeCardData[ metaUpgradeName ].TraitName, MetaUpgradeCardData[ metaUpgradeName ].OnGrantedFunctionArgs )
		end

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
				Icon = "ExtraLifeStyx",
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
			Icon = "ExtraLifeStyx",
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
		
		if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.EncounterType ~= "Boss" then
			if addedHealth > 0  and addedMana > 0 then
				waitUnmodified(0.8)
				thread(BonusHealthAndManaPresentation, addedHealth, addedMana )
			elseif addedMana > 0 then
				waitUnmodified(0.8)
				thread(BonusManaPresentation, addedMana )
			end
		end
	end
end