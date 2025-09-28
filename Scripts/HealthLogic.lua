function GetHeroMaxAvailableHealth()
	local health = CurrentRun.Hero.MaxHealth
	if CurrentRun.Hero.ReserveHealthSources ~= nil then
		for source, amount in pairs( CurrentRun.Hero.ReserveHealthSources ) do
			health = health - amount * GetTotalHeroTraitValue("ReserveHealthMultiplier", { IsMultiplier = true })
		end
		if health < 1 then
			health = 1
		end
	end	
	return math.ceil( health )
end


function ReserveHealth( amount, source )
	DebugAssert({ Condition = ( source ~= nil ), Text = "No source provided to reserve health!", Owner = "Alice" })
	IncrementTableValue(CurrentRun.Hero.ReserveHealthSources, source, amount )
	if GetHeroMaxAvailableHealth() < CurrentRun.Hero.Health then
		local extraHealth = CurrentRun.Hero.Health - GetHeroMaxAvailableHealth()
		SacrificeHealth({ SacrificeHealth = extraHealth, IgnoreHealthBuffer = true, IgnoreDamageCap = true, ManuallyTriggered = true })
		CurrentRun.Hero.ReserveHealthExtra = CurrentRun.Hero.ReserveHealthExtra + extraHealth
	end
	FrameState.RequestUpdateHealthUI = true
end

function ClearHealthReserve()
	local previousMaxHealth = GetHeroMaxAvailableHealth()
	CurrentRun.Hero.ReserveHealthSources = {}
	local newMaxHealth = GetHeroMaxAvailableHealth()

	if newMaxHealth > previousMaxHealth and CurrentRun.Hero.ReserveHealthExtra > 0 then
		if newMaxHealth - previousMaxHealth > CurrentRun.Hero.ReserveHealthExtra then
			Heal( CurrentRun.Hero, { HealAmount = CurrentRun.Hero.ReserveHealthExtra, Silent = true })
			CurrentRun.Hero.ReserveHealthExtra = 0
		else
			Heal( CurrentRun.Hero, { HealAmount = newMaxHealth - previousMaxHealth, Silent = true })
			CurrentRun.Hero.ReserveHealthExtra = CurrentRun.Hero.ReserveHealthExtra - (newMaxHealth - previousMaxHealth)
		end
	end
	FrameState.RequestUpdateHealthUI = true
end


function Heal( victim, triggerArgs )

	if victim == nil or victim.Health == nil or victim.Health == victim.MaxHealth then
		return
	end

	local prevHealth = victim.Health

	if triggerArgs.HealFraction ~= nil then
		triggerArgs.HealAmount = round(victim.MaxHealth * triggerArgs.HealFraction)
	end
	if triggerArgs.HealAmount <= 0 then
		return
	end

	if triggerArgs.HealAmount ~= nil then

		victim.Health = victim.Health + triggerArgs.HealAmount
		if victim.Health > victim.MaxHealth then
			victim.Health = victim.MaxHealth
		end
		if victim == CurrentRun.Hero and victim.Health > GetHeroMaxAvailableHealth() then
			victim.Health = GetHeroMaxAvailableHealth()
		end	
	end

	triggerArgs.ActualHealAmount = round(victim.Health - prevHealth)

	local sourceName = triggerArgs.AttackerName or "Unknown"

	if victim == CurrentRun.Hero then
		GameState.HealthRecord[sourceName] = (GameState.HealthRecord[sourceName] or 0) + triggerArgs.HealAmount
		GameState.ActualHealthRecord[sourceName] = (GameState.ActualHealthRecord[sourceName] or 0) + triggerArgs.ActualHealAmount
		CurrentRun.HealthRecord[sourceName] = (CurrentRun.HealthRecord[sourceName] or 0) + triggerArgs.HealAmount
		CurrentRun.ActualHealthRecord[sourceName] = (CurrentRun.ActualHealthRecord[sourceName] or 0) + triggerArgs.ActualHealAmount
		for _, data in pairs(GetHeroTraitValues("OnPlayerHealthChangedFunctionName")) do
			thread( CallFunctionName, data.FunctionName, data.Args, triggerArgs.ActualHealAmount )
		end
		if not triggerArgs.Silent then
			table.insert( SessionMapState.PresentationQueue, { FunctionName = "OnPlayerHealed", Source = CurrentRun.Hero, Args = triggerArgs, Threaded = true } )
			FrameState.RequestUpdateHealthUI = true
		end

		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			local thresholdData = traitData.LowHealthThresholdText
			if thresholdData ~= nil and thresholdData.Threshold ~= nil and CurrentRun.Hero.Health > thresholdData.Threshold and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount) <= thresholdData.Threshold then
				TraitUIDeactivateTrait( traitData )
			end
			if thresholdData ~= nil and thresholdData.ThresholdFraction ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth > thresholdData.ThresholdFraction and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount)/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction then
				TraitUIDeactivateTrait( traitData )
			end

			thresholdData = traitData.HighHealthThresholdText
			if thresholdData ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth >= thresholdData.PercentThreshold and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount)/CurrentRun.Hero.MaxHealth < thresholdData.PercentThreshold then
				TraitUIActivateTrait( traitData )
			end

		end
	else
		UpdateHealthBar( victim, -1 * triggerArgs.ActualHealAmount, triggerArgs )
		if triggerArgs.ActualHealAmount > 0 and not triggerArgs.Silent then
			DisplayEnemyHealingText( victim, triggerArgs )
		end
	end

end