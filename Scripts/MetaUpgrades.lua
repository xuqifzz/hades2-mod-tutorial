function GetMetaUpgradePurchasePrice( metaUpgrade )
	return GetMetaUpgradePrice(metaUpgrade, GetNumMetaUpgrades( metaUpgrade.Name ))
end

function GetMetaUpgradeRefundPrice( metaUpgrade, args )
	local refund = GetMetaUpgradePrice( metaUpgrade, GetNumMetaUpgrades( metaUpgrade.Name, args ) - 1 )
	if not GameState.MetaUpgradeState[ metaUpgrade.Name ] then
		return refund
	end
	if not IsMetaUpgradeActive( metaUpgrade.Name, args ) then
		refund = GetMetaUpgradePrice( metaUpgrade, GameState.MetaUpgradeState[ metaUpgrade.Name ] - 1 )
	end
	return refund or 0
end

function GetMetaUpgradeTotalInvestment( metaUpgrade )
	local total = 0
	for i = 1, GetNumMetaUpgrades( metaUpgrade.Name ) do
		local price = GetMetaUpgradePrice( metaUpgrade, i - 1 )
		if price ~= nil then
			total = total + price
		end
	end
	return total
end

function GetMetaUpgradePrice( metaUpgrade, index )
	if metaUpgrade.CostTable then
		return metaUpgrade.CostTable[index + 1]
	else
		if metaUpgrade.MaxInvestment ~= nil and metaUpgrade.MaxInvestment <= index then
			return nil
		end
		local additionalCost = 0
		if metaUpgrade.CostIncreaseInterval ~= nil and metaUpgrade.CostIncreaseInterval > 0 then
			additionalCost = math.floor(index / metaUpgrade.CostIncreaseInterval) * metaUpgrade.CostIncrease
		end
		return metaUpgrade.Cost + additionalCost
	end
end

function GetBaseAmmoReloadTime()
	return MetaUpgradeData.ReloadAmmoMetaUpgrade.BaseValue + (GetNumMetaUpgrades("ReloadAmmoMetaUpgrade") * MetaUpgradeData.ReloadAmmoMetaUpgrade.ChangeValue)
end

function GetNumMetaUpgradeLastStands()
	return GetTotalHeroTraitValue( "AddMetaUpgradeLastStands" )
end

function CalculateMetaPointMultiplier()
	local totalMetaPointMultiplier = 1.0
	for key, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.MetaPointMultiplier then
			totalMetaPointMultiplier = totalMetaPointMultiplier + (upgradeData.MetaPointMultiplier - 1)
		end
	end
	return totalMetaPointMultiplier * GetTotalHeroTraitValue("MetaPointMultiplier", {IsMultiplier = true})
end

function CalculateHealingMultiplier()
	return MetaUpgradeData.HealingReductionShrineUpgrade.ChangeValue * GetTotalHeroTraitValue( "TraitHealingBonus", { IsMultiplier = true } )
end
function CalculatePositiveHealingMultiplier()
	return GetTotalHeroTraitValue("TraitHealingBonus", {IsMultiplier = true })
end

function MetaUpgradePresentation( metaUpgrade )
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = 40002, Scale = 3.0 })
end

function GetMetaUpgradeStatDelta(upgradeData)
	local topLevelTable = upgradeData;
	if topLevelTable.ChangeValue == nil then
		topLevelTable = upgradeData.PropertyChanges[1]
	end

	if topLevelTable ~= nil then
		local key = "ChangeValue"
		if not isint(topLevelTable[key]) or topLevelTable.FormatAsPercent then
			key = "ChangeValuePercentDelta"
		end
		if topLevelTable.FormatAsAbsoluteValue then
			key = math.abs(key)
		end
		if topLevelTable.DecimalPlaces then
			if key == "ChangeValuePercentDelta" then
				-- Value is pre-rounded so extract unrounded values
				return round( (topLevelTable.ChangeValue - 1) * 100, topLevelTable.DecimalPlaces )
			else
				return round( topLevelTable[key], topLevelTable.DecimalPlaces )
			end
		else
			return topLevelTable[key]
		end
	end
	return 0
end

function GetTotalStatChange( upgradeData, numUpgradesOverride )
	local numUpgrades = numUpgradesOverride or GetNumMetaUpgrades( upgradeData.Name )
	if upgradeData.ChangeValues and numUpgrades > 0 then
		if upgradeData.FormatAsPercent then
			return ( upgradeData.ChangeValues[numUpgrades] - 1 ) * 100
		else
			return upgradeData.ChangeValues[numUpgrades]
		end
	end
	return (upgradeData.BaseValue or 0) + GetMetaUpgradeStatDelta(upgradeData) * numUpgrades
end

function UpdateSeenMetaUpgrades()
	GameState.LastUnlockedMetaUpgrades = {}
	for k, upgradeName in pairs( GameState.MetaUpgradesSelected ) do
		if GameState.MetaUpgradesUnlocked[upgradeName] then
			table.insert( GameState.LastUnlockedMetaUpgrades, upgradeName )
		end
	end
	for k, upgradeName in pairs( ShrineUpgradeOrder ) do
		if GameState.MetaUpgradesUnlocked[upgradeName] then
			table.insert( GameState.LastUnlockedMetaUpgrades, upgradeName )
		end
	end
end

function GetNulledMetaUpgradeCount( )	
	return 0
end

function IsMetaUpgradeActive( upgradeName, args )
	args = args or {}
	local nulledMetaUpgradeCount = GetNulledMetaUpgradeCount()

	if Contains(ShrineUpgradeOrder, upgradeName) then
		return true
	end

	return false
end

function IsMetaUpgradeSelected( upgradeName )
	return Contains( GameState.MetaUpgradesSelected, upgradeName )
end

function BiomeSpeedTimerLoop()
	while not CurrentRun.Hero.IsDead do
		if not HasTimerBlock( CurrentRun ) and not IsBiomeTimerPaused() and CurrentRun.ActiveBiomeTimer then
			if GetNumShrineUpgrades("BiomeSpeedShrineUpgrade") > 0 and CurrentRun.BiomeTime <= 0 and not CurrentRun.Hero.IsDead then
				local minHealth = 0
				if (CurrentRun.Hero.InvulnerableFlags ~= nil and not IsEmpty( CurrentRun.Hero.InvulnerableFlags )) then
					minHealth = 1
				end 
				Damage( CurrentRun.Hero, { SourceWeapon = "BiomeTimer", DamageAmount = BiomeTimeLimits.Penalty.Damage, MinHealth = minHealth, PureDamage = true, Silent = true } )			
				thread( UpdateHealthUI )
				if not CurrentRun.Hero.IsDead then
					BiomeDamagePresentation( BiomeTimeLimits.Penalty.Damage )
					SetMenuOptions({ Name = "InGameUI", Properties = { Run = "PulseExpiredBiomeTimeText" } })
				end
			elseif CurrentRun.BiomeTime <= 30 then
				-- critical time remaining
				SetMenuOptions({ Name = "InGameUI", Properties = { Run = "PulseElapsedBiomeTimeText" } })
			end
		end
		wait( BiomeTimeLimits.Penalty.Interval, RoomThreadName )
	end
end

function IsBiomeTimerPaused()
	if not CurrentRun.CurrentRoom or not CurrentRun.CurrentRoom.Encounter then
		return false
	end

	if CurrentRun.CurrentRoom.Encounter.PauseBiomeTimer then
		return true
	end

	return false
end


function StartSurfaceHealthPenalty( unit, args )
	thread( SurfaceHealthPenalty, args )
end

function SurfaceHealthPenalty( args )
	CurrentRun.SurfacePenaltyCumulativeDamage = CurrentRun.SurfacePenaltyCumulativeDamage or 0
	wait( 0.1 )
	while not CurrentRun.Hero.IsDead do
		if not HasTimerBlock( CurrentRun, { "ArtemisEncounter" } ) and not IsBiomeTimerPaused() and not CurrentRun.Hero.IsDead then
			local minHealth = 0
			if args.DamageIncrementPerTick then
				CurrentRun.SurfacePenaltyCumulativeDamage = CurrentRun.SurfacePenaltyCumulativeDamage + args.DamageIncrementPerTick
			end
			local damage = math.floor( args.Damage + CurrentRun.SurfacePenaltyCumulativeDamage )
			BiomeDamagePresentation( damage )
			Damage( CurrentRun.Hero, { SourceWeapon = "SurfaceHealthPenalty", DamageAmount = damage, MinHealth = minHealth, PureDamage = true, Silent = true, IgnoreLastStand = true } )					
			if CurrentRun.Hero.IsDead then
				return
			end
			thread( UpdateHealthUI )
		end
		wait( args.Interval )
	end
end