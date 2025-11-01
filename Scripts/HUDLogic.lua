function UnblockCombatUI( flag )
	-- Don't want to show, just want to re-enable the option
	MapState.CombatUIHide[flag] = nil
	MapState.ObjectiveUIHide[flag] = nil
end

function ShowCombatUI( flag, args )
	args = args or {}
	if flag ~= nil then
		UnblockCombatUI( flag )
	end
	if not IsEmpty( MapState.CombatUIHide ) then
		--DebugPrint({ Text = "Combat Show Blocked By " .. tostring(GetFirstKey(MapState.CombatUIHide)) })
		return
	end

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	UnzeroMouseTether( "AutoHide" )

	if SessionMapState.WeaponsDisabled then
		return
	end

	ShowingCombatUI = true

	if not args.SkipUpdateTraitSummary then
		UpdateTraitSummary()
	end
	
	ShowHealthUI( args )
	ShowManaMeter( args )
	ShowAmmoUI( args )
	ShowDaggerUI( args )
	ShowAxeUI( args )
	ShowLobUI( args )
	ShowSuitUI( args )
	ShowTraitUI( args )

	ShowResourceUIs()
	if not args.SkipObjectives then
		ShowObjectivesUI( flag )
	end

	thread( HideAfterDelay )
end

function ShowResourceUIs( args )

	args = args or {}

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if GetResourceAmount( "Money" ) > 0 or HUDScreen.Components.MoneyIcon.Id ~= nil then
		ShowMoneyUI( args )
	end
	if CurrentRun.NumRerolls and CurrentRun.NumRerolls > 0 or ScreenAnchors.Reroll ~= nil then
		ShowRerollUI( args )
	else
		HideRerollUI()
	end

	SetAlpha({ Id = HUDScreen.Components.ResourceBackingShadow.Id, Fraction = ConfigOptionCache.HUDOpacity * HUDScreen.Components.ResourceBackingShadow.ShowAlpha, Duration = HUDScreen.FadeInDuration })

end

OnPlayerMoveStarted{
	function()
		killTaggedThreads( CombatUI.HideThreadName )
		if not ShowingCombatUI then
			ShowCombatUI( "AutoHide" )
		end
	end
}

function StartHideAfterDelayThread()
	thread( HideAfterDelay )
	if not ShowingCombatUI then
		ShowCombatUI( "AutoHide" )
	end
end

OnPlayerMoveStopped{
	StartHideAfterDelayThread
}

OnControlPressed{ "Rush Attack1 Attack2 Attack3 AutoLock Shout",
	function ( args )
		StartHideAfterDelayThread()
	end
}

function HideAfterDelay()
	if not CombatUI.AutoHideEnabled then
		return
	end

	if SetThreadWait( CombatUI.HideThreadName, CombatUI.HideDelay ) then
		return
	end

	waitUnmodified( CombatUI.HideDelay, CombatUI.HideThreadName )

	if CombatUI.AutoHideEnabled then
		HideCombatUI( "AutoHide" )
		ZeroMouseTether( "AutoHide" )
	end
end

function HideCombatUI( flag, args )
	args = args or {}
	MapState.CombatUIHide[flag] = true

	ShowingCombatUI = nil
	if not args.IgnoreActiveShrinePoints then
		UpdateTraitSummary()
	end

	HideTraitUI( args )
	if not args.IgnoreHideMoney then
		HideMoneyUI( args )
	end
	HideRerollUI( args )
	HideResourceUIs( args )

	HideManaMeter( args )
	if not args.SkipHideObjectives then
		HideObjectivesUI( flag )
	end
	HideHealthUI( args )
	thread( HideAmmoUI, args )
	thread( HideDaggerUI, args )
	thread( HideAxeUI, args )
	thread( HideLobUI, args )
	thread( HideSuitUI, args )

	killTaggedThreads( CombatUI.HideThreadName )
end

function HideResourceUIs( args )
	args = args or {}
	SetAlpha({ Id = HUDScreen.Components.ResourceBackingShadow.Id, Fraction = 0, Duration = HUDScreen.FadeOutDuration })
	SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = 0, Duration = args.FadeDuration or HUDScreen.FadeOutDuration })
end

function RecreateLifePips()
	if not IsEmpty( ScreenAnchors.LifePipIds ) then
		Destroy({ Ids = ScreenAnchors.LifePipIds })
	end
		
	ScreenAnchors.LifePipIds = {}
	local numLastStands = 0
	if CurrentRun.Hero.IsDead then
		numLastStands = TableLength( CurrentRun.Hero.LastStands ) + GetNumMetaUpgradeLastStands()
		if GameState.LastAwardTrait == "BlockDeathKeepsake" then
			numLastStands  = numLastStands + 1
		end
	elseif CurrentRun.Hero.MaxLastStands then
		numLastStands = CurrentRun.Hero.MaxLastStands
		if HeroHasTrait("BlockDeathKeepsake") and not MapState.UsedBlockDeath then
			numLastStands = numLastStands + 1
		end
	end
	if SessionMapState.InfiniteDeathDefiance then
		numLastStands = numLastStands + 1
	end
	for i = 1, numLastStands do
		CreateLifePip(i)
	end

	SetAlpha({ Ids = ScreenAnchors.LifePipIds, Fraction = 0, Duration = 0 })
	SetAlpha({ Ids = ScreenAnchors.LifePipIds, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })

	UpdateLifePips()
end

function UpdateLifePips( heroUnit )
	local unit = heroUnit or CurrentRun.Hero
	if not ScreenAnchors.LifePipIds or not unit.LastStands then
		return
	end
	if not unit.IsDead then
		local currentIndex = 0
		local lastIcon = nil
		local lastStandCount = 0
		local addedBlockDeath = false
		local addedInfiniteDefiance = false
		for i, lifePipId in ipairs( ScreenAnchors.LifePipIds ) do
			local index = i
			local lastStandData = unit.LastStands[index]
			local icon = "ExtraLifeEmpty"
			if lastStandData then
				icon = lastStandData.Icon
			elseif HeroHasTrait("BlockDeathKeepsake") and not MapState.UsedBlockDeath and not addedBlockDeath then
				icon = "ExtraLifeMoros"
				addedBlockDeath = true
			elseif SessionMapState.InfiniteDeathDefiance and not addedInfiniteDefiance then
				icon = "ExtraLifeReplenish"
				addedInfiniteDefiance = true
			end
			if icon == lastIcon then
				lastStandCount = lastStandCount + 1
				ModifyTextBox({ Id = ScreenAnchors.LifePipIds[currentIndex], Text = lastStandCount })
			else
				currentIndex = currentIndex + 1
				SetAnimation({ Name = icon, DestinationId = ScreenAnchors.LifePipIds[currentIndex] })
				ModifyTextBox({ Id = ScreenAnchors.LifePipIds[currentIndex], Text = " " })
				lastStandCount = 1
			end
			lastIcon = icon
		end
		
		for i = currentIndex + 1, #ScreenAnchors.LifePipIds do
			SetAnimation({ Name = "Blank", DestinationId = ScreenAnchors.LifePipIds[i] })
			ModifyTextBox({ Id = ScreenAnchors.LifePipIds[i], Text = " " })
		end
	else
		local currentIndex = 0
		local lastIcon = nil
		local lastStandCount = 0
		local addedBlockDeath = false
		local numLastStands = TableLength( CurrentRun.Hero.LastStands ) + GetNumMetaUpgradeLastStands()
		if GameState.LastAwardTrait == "BlockDeathKeepsake" then
			numLastStands  = numLastStands + 1
		end
		for i, lifePipId in ipairs( ScreenAnchors.LifePipIds ) do
			if i <= numLastStands then
				local lastStandData = unit.LastStands[i]
				local icon = "ExtraLifeMel"
				if lastStandData then
					icon = lastStandData.Icon
				end
				if GameState.LastAwardTrait == "BlockDeathKeepsake" and i == numLastStands then
					icon = "ExtraLifeMoros"
					addedBlockDeath = true
				end
				if icon == lastIcon then
					lastStandCount = lastStandCount + 1
					ModifyTextBox({ Id = ScreenAnchors.LifePipIds[currentIndex], Text = lastStandCount })
				else
					currentIndex = currentIndex + 1
					SetAnimation({ Name = icon, DestinationId = ScreenAnchors.LifePipIds[currentIndex] })
					ModifyTextBox({ Id = ScreenAnchors.LifePipIds[currentIndex], Text = " " })
					lastStandCount = 1
				end
				lastIcon = icon
			else
				SetAnimation({ Name = "Blank", DestinationId = ScreenAnchors.LifePipIds[i] })
				ModifyTextBox({ Id = ScreenAnchors.LifePipIds[i], Text = " " })
			end
		end
		
		for i = currentIndex + 1, #ScreenAnchors.LifePipIds do
			SetAnimation({ Name = "Blank", DestinationId = ScreenAnchors.LifePipIds[i] })
			ModifyTextBox({ Id = ScreenAnchors.LifePipIds[i], Text = " " })
		end
	end
end

function CreateLifePip( index )
	local obstacleId = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup,
		X = HUDScreen.LastStandX + (index * HUDScreen.LastStandSpacingX),
		Y = ScreenHeight - HUDScreen.LastStandBottomOffset,
		Scale = HUDScreen.LastStandScale,
	})
	local pipSubtitleFormat = ShallowCopyTable( ScreenData.HUD.LastStandTextFormat )
	pipSubtitleFormat.Id = obstacleId
	CreateTextBox( pipSubtitleFormat)
	SetAnimation({ Name = "ExtraLifeEmpty", DestinationId = obstacleId })
	table.insert( ScreenAnchors.LifePipIds, obstacleId )
end

function IsHealthHidden()
	if CurrentRun.Cleared then
		return false
	end
	if HasHeroTraitValue("HideHealth") then
		return true
	end
	return false
end

function ShowHealthUI( args )
	args = args or {}
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if not args.IgnoreLifePips then
		RecreateLifePips()
	end

	local healthFraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth
	local reservedHealthFraction = ( CurrentRun.Hero.MaxHealth - GetHeroMaxAvailableHealth() ) / CurrentRun.Hero.MaxHealth
	
	if IsHealthHidden() then
		healthFraction = 1
		reservedHealthFraction = 0
	end
	SetAnimationFrameTarget({ Name = "HPBarFalloff", Fraction = 1 - healthFraction, DestinationId = HUDScreen.Components.HealthFalloff.Id, Instant = true })
	SetAnimationFrameTarget({ Name = "HPBarFill", Fraction = 1 - healthFraction, DestinationId = HUDScreen.Components.HealthFill.Id, Instant = true })
	
	SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = reservedHealthFraction, DestinationId = HUDScreen.Components.HealthReserve.Id, Instant = true })

	local healthIds = {}
	local healthComponents = { "HealthBack", "HealthFalloff", "HealthFill", "HealthBuffer", "HealthReserve" }
	
	if HasHeroTraitValue("ShowHighHealthIndicator") then
		table.insert( healthComponents, "HealthHighIndicator" )
	end
	if HasHeroTraitValue("ShowLowHealthIndicator") then
		table.insert( healthComponents, "HealthLowIndicator" )
	end	

	for k, componentName in ipairs( healthComponents ) do
		local component = HUDScreen.Components[componentName]
		table.insert( healthIds, component.Id )
	end
	SetAlpha({ Ids = healthIds, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity, Duration = args.FadeDuration or HUDScreen.FadeInDuration })

	UpdateHealthUI( { FalloffDelay = 0.0, Force = args.Force, Fraction = args.Fraction } )
	
end

function UpdateHealthUI( args )
	local unit = CurrentRun.Hero
	if unit == nil then
		return
	end
	local currentHealth = unit.Health
	local maxHealth = unit.MaxHealth
	local maxAvailableHealth = GetHeroMaxAvailableHealth()
	local reservedHealthFraction = ( CurrentRun.Hero.MaxHealth - GetHeroMaxAvailableHealth() ) / CurrentRun.Hero.MaxHealth
	CurrentRun.TooltipHeroHealth = currentHealth
	CurrentRun.TooltipHeroMaxHealth = maxHealth
	if currentHealth == nil or maxHealth == nil then
		return
	end
	
	if CurrentRun.Hero.InvulnerableFlags.BlockDeath then
		currentHealth = 0
	end
	
	if HUDScreen == nil then
		return
	end

	args = args or {}

	local healthBackId = HUDScreen.Components.HealthBack.Id
	local healthFill = HUDScreen.Components.HealthFill
	if IsHealthHidden() then
		CurrentRun.TooltipHeroHealth = "UI_Mystery"
		CurrentRun.TooltipHeroMaxHealth = "UI_Mystery"
		ModifyTextBox({ Id = healthBackId, Text = "UI_PlayerHealth", LuaKey = "TempTextData", LuaValue = { Current = "UI_Mystery", Maximum = "UI_Mystery" }, AutoSetDataProperties = false } )

		SetAnimationFrameTarget({ Name = "HPBarFill", Fraction = 0, DestinationId = HUDScreen.Components.HealthFill.Id,
			Duration = healthFill.UpdateDuration, EaseIn = healthFill.UpdateEaseIn, EaseOut = healthFill.UpdateEaseOut })
	else
		ModifyTextBox({ Id = healthBackId, Text = "UI_PlayerHealth", LuaKey = "TempTextData", LuaValue = { Current = math.ceil(currentHealth), Maximum = math.ceil(GetHeroMaxAvailableHealth()) }, AutoSetDataProperties = false } )

		SetAnimationFrameTarget({ Name = "HPBarFill", Fraction = 1 - (currentHealth / maxHealth), DestinationId = HUDScreen.Components.HealthFill.Id,
			Duration = healthFill.UpdateDuration, EaseIn = healthFill.UpdateEaseIn, EaseOut = healthFill.UpdateEaseOut })
		if maxHealth ~= GetHeroMaxAvailableHealth() then
			if unit.HealthBuffer ~= nil and unit.HealthBuffer > 0 then
				ModifyTextBox({ Id = healthBackId, Text = "UI_PlayerHealth_Reserved", LuaKey = "TempTextData", LuaValue = { Current = math.ceil(currentHealth), Maximum = GetHeroMaxAvailableHealth() }, AutoSetDataProperties = false } )
				ModifyTextBox({ Id = HUDScreen.Components.HealthReserve.Id, Text = " "})
			else
				ModifyTextBox({ Id = HUDScreen.Components.HealthReserve.Id, Text = "UI_HealthReservedText",
					LuaKey = "TempTextData",
					LuaValue = { ReservedHealth = math.min(CurrentRun.Hero.MaxHealth, CurrentRun.Hero.MaxHealth - maxAvailableHealth), Current = math.floor(CurrentRun.Hero.MaxHealth), AvailableMaximum = maxHealth, RealMaximum = CurrentRun.Hero.MaxHealth}
				})
			end
			SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = reservedHealthFraction, DestinationId = HUDScreen.Components.HealthReserve.Id, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
		else
			ModifyTextBox({ Id = HUDScreen.Components.HealthReserve.Id, Text = " " })
			SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = 0, DestinationId = HUDScreen.Components.HealthReserve.Id, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
		end
	end
	local healthBufferId = HUDScreen.Components.HealthBuffer.Id
	if unit.HealthBuffer ~= nil and unit.HealthBuffer > 0 then
		local armorFraction = unit.HealthBuffer / maxHealth
		if armorFraction > 1.0 then
			armorFraction = 1.0
		end
		if IsHealthHidden() then
			armorFraction = 0.2
		end
		if args.Force or ShowingCombatUI then
			SetAlpha({ Id = healthBufferId, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity, Duration = 0.1 })
		end
		SetAnimationFrameTarget({ Name = "HPBarArmorFill", Fraction = armorFraction, DestinationId = healthBufferId, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
		ModifyTextBox({ Id = healthBufferId, Text = "UI_HealthBuffer", LuaKey = "TempTextData", LuaValue = { Current = math.ceil(unit.HealthBuffer), AutoSetDataProperties = false } })
	else
		SetAlpha({ Id = healthBufferId, Fraction = 0.0, Duration = 0.1 })
		ModifyTextBox({ Id = healthBufferId, Text = "UI_HealthBuffer", LuaKey = "TempTextData", LuaValue = { Current = 0, AutoSetDataProperties = false } })
	end
	
	if IsHealthHidden() then
		local healthFalloff = HUDScreen.Components.HealthFalloff
		SetAnimationFrameTarget({ Name = "HPBarFalloff", Fraction = 0, DestinationId = healthFalloff.Id, Instant = true})
	
	else
		local healthFalloff = HUDScreen.Components.HealthFalloff
		waitUnmodified( args.FalloffDelay or healthFalloff.UpdateDelay )
		SetAnimationFrameTarget({ Name = "HPBarFalloff", Fraction = 1 - (currentHealth / maxHealth), DestinationId = healthFalloff.Id,
			Duration = healthFalloff.UpdateDuration, EaseIn = healthFalloff.UpdateEaseIn, EaseOut = healthFalloff.UpdateEaseOut })
	end
end

function HideHealthUI( args )
	local healthIds = {}
	local healthComponents = { "HealthBack", "HealthFalloff", "HealthFill", "HealthBuffer", "HealthHighIndicator", "HealthLowIndicator", "HealthReserve" }
	for k, componentName in ipairs( healthComponents ) do
		local component = HUDScreen.Components[componentName]
		table.insert( healthIds, component.Id )
	end
	SetAlpha({ Ids = healthIds, Fraction = 0.0, Duration = HUDScreen.FadeOutDuration })
	
	Destroy({ Ids = ScreenAnchors.LifePipIds })
end

function ResetUI()
	if CurrentRun and MapState and MapState.MoneyUI then
		MapState.MoneyUI.LastValue = GetResourceAmount( "Money" )
	end
	if CurrentRun and CurrentRun.Hero then
		CurrentRun.TooltipHeroHealth = CurrentRun.Hero.Health
		CurrentRun.TooltipHeroMaxHealth = CurrentRun.Hero.MaxHealth
	end
	ClearHealthShroud()
	CreateVignette()
end

function ShowRerollUI( args )
	args = args or {}
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end
	ModifyTextBox({ Id = HUDScreen.Components.RerollIcon.Id, Text = CurrentRun.NumRerolls, AutoSetDataProperties = false, })
	SetAlpha({ Id = HUDScreen.Components.RerollIcon.Id, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
end

function HideRerollUI( args )
	SetAlpha({ Id = HUDScreen.Components.RerollIcon.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
end

function UpdateRerollUI( newValue )
	ModifyTextBox({ Id = HUDScreen.Components.RerollIcon.Id, Text = newValue, AutoSetDataProperties = false, })
end

function ShowMoneyUI( args )
	args = args or {}
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, Text = GetResourceAmount( "Money" ), AutoSetDataProperties = false, })
	SetAlpha({ Id = ScreenAnchors.MoneyDelta, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
	SetAlpha({ Id = HUDScreen.Components.MoneyIcon.Id, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
end

function HideMoneyUI( args )
	args = args or {}
	SetAlpha({ Id = ScreenAnchors.MoneyDelta, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
	SetAlpha({ Id = HUDScreen.Components.MoneyIcon.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
end

function UpdateMoneyUI( force )
	local newValue = GetResourceAmount( "Money" )
	if not force and ( not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI ) then
		return
	end
	local valueDelta = newValue - MapState.MoneyUI.LastValue
	MapState.MoneyUI.LastValue = newValue
	MapState.MoneyUI.Floating = MapState.MoneyUI.Floating + valueDelta
	if valueDelta > 0 then
		thread(MoneyGainPresentation, newValue, valueDelta)
	elseif valueDelta < 0 then
		thread(MoneyLossPresentation, newValue, valueDelta)
	end

	if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.SpawnedStoreItems ~= nil then
		for i, item in pairs(CurrentRun.CurrentRoom.Store.SpawnedStoreItems) do
			UpdateCostText( item, true )
		end
	end

	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, Text = GetResourceAmount( "Money" ), AutoSetDataProperties = false, })

end

function ShowAmmoUI( args )

	args = args or {}
	if not CurrentRun.Hero.Weapons.WeaponLob or HasHeroTraitValue( "UnlimitedAmmo" ) then
		return
	end
	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		SetAlpha({ Id = ScreenAnchors.AmmoIndicatorUI, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
		return
	end
	ScreenAnchors.AmmoIndicatorUI = CreateScreenObstacle({ Name = "BlankObstacle",
		Group = HUDScreen.ComponentData.DefaultGroup, X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset,
		Animation = "WitchGrenadeIcon",
		Alpha = 0.0,
		})
		
	if HeroHasTrait("LobImpulseAspect") or HeroHasTrait("LobGunAspect") then
		SetAnimation({ DestinationId = ScreenAnchors.AmmoIndicatorUI, Name = "Blank"})
	end
	CreateTextBox({
		Id = ScreenAnchors.AmmoIndicatorUI,
		OffsetX = 24, OffsetY = -2,
		Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
		Justification = "Left",
		})
	thread( UpdateAmmoUI )

	SetAlpha({ Id = ScreenAnchors.AmmoIndicatorUI, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
end

function UpdateAmmoUI( triggerArgs )
	if ScreenAnchors.AmmoIndicatorUI == nil or CurrentRun.Hero == nil then
		return
	end
	triggerArgs = triggerArgs or {}
	local ammoData =
	{
		Current = GetCurrentAmmo( "WeaponLob" ),
		Maximum = GetMaxAmmo( "WeaponLob" )
	}
	PulseText({ ScreenAnchorReference = "AmmoIndicatorUI", ScaleTarget = 1.04, ScaleDuration = 0.05, HoldDuration = 0.05, PulseBias = 0.02})
	ModifyTextBox({ Id = ScreenAnchors.AmmoIndicatorUI, Text = "UI_AmmoText", OffsetY = -2, LuaKey = "TempTextData", LuaValue = ammoData, AutoSetDataProperties = false, })
end

function HideAmmoUI( args )
	if ScreenAnchors.AmmoIndicatorUI == nil then
		return
	end
	args = args or {}
	ScreenAnchors.AmmoIndicatorUIReloads = ScreenAnchors.AmmoIndicatorUIReloads or {}

	local ids = CombineTables( { ScreenAnchors.AmmoIndicatorUI }, ScreenAnchors.AmmoIndicatorUIReloads )
	for i, reloadId in pairs( ids ) do
		SetAlpha({ Id = reloadId, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, Fraction = 0.0 })
	end
	ScreenAnchors.AmmoIndicatorUI = nil
	ScreenAnchors.AmmoIndicatorUIReloads = nil

	wait( HUDScreen.FadeOutDuration )

	Destroy({ Ids = ids })
end

function ShowAxeUI( )

	if (not HeroHasTrait("AxePerfectCriticalAspect") and not HeroHasTrait("AxeRallyAspect")) or not ShowingCombatUI then
		return
	end

	if ScreenAnchors.AxeUI ~= nil then
		return
	end

	
	ScreenAnchors.AxeUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	ScreenAnchors.AxeUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })

	if HeroHasTrait("AxePerfectCriticalAspect") then
		local trait = GetHeroTrait("AxePerfectCriticalAspect")
		local currentCrit = round(trait.PerfectCritChance * 100 * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ))
		local maxCrit = round(trait.ReportedMaxCrit * 100 * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ))
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount })
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = currentCrit/ maxCrit, Instant = true })
		
		SetAlpha({ Id = ScreenAnchors.AxeUI, Duration = 0, Fraction = 0 })
		SetAlpha({ Id = ScreenAnchors.AxeUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
		SetAlpha({ Id = ScreenAnchors.AxeUIChargeAmount, Duration = 0, Fraction = 0 })
		SetAlpha({ Id = ScreenAnchors.AxeUIChargeAmount, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
		CreateTextBox({
			Id = ScreenAnchors.AxeUI,
			OffsetX = 26, OffsetY = -2,
			Text = "UI_CritText",
			TextSymbolScale = 0.88,
			Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
			ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
			Justification = "Left",LuaKey = "TempTextData", LuaValue = { Amount = currentCrit }
			})
	elseif HeroHasTrait("AxeRallyAspect") then
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount })
		local currentHits = MapState.FrenzyHits or 0
		local requiredCount = 12
		local traitData = GetHeroTrait("AxeRallyAspect")
		if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs then
			requiredCount = traitData.OnWeaponFiredFunctions.FunctionArgs.RequiredCount or requiredCount
		end
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = currentHits / requiredCount, Instant = true })
		if currentHits >= requiredCount then
			SetAnimation({Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = ScreenAnchors.AxeUI })
		end
		SetAlpha({ Id = ScreenAnchors.AxeUI, Duration = 0, Fraction = 0 })
		SetAlpha({ Id = ScreenAnchors.AxeUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
		SetAlpha({ Id = ScreenAnchors.AxeUIChargeAmount, Duration = 0, Fraction = 0 })
		SetAlpha({ Id = ScreenAnchors.AxeUIChargeAmount, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	end
end

function UpdateAxeUI( trait ) 
	if trait.PerfectCritChance then
		local currentCrit = round(trait.PerfectCritChance * 100 * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ))
		local maxCrit = round(trait.ReportedMaxCrit * 100 * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ))
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = currentCrit/ maxCrit, Instant = true })
		ModifyTextBox({ Id = ScreenAnchors.AxeUI, Text = "UI_CritText", LuaKey = "TempTextData", LuaValue = { Amount = currentCrit }})
	elseif trait.Name == "AxeRallyAspect" then
	end
end

function HideAxeUI( args )
	if ScreenAnchors.AxeUI == nil then
		return
	end
	args = args or {}
	local ids = { ScreenAnchors.AxeUI, ScreenAnchors.AxeUIChargeAmount }
	SetAlpha({ Ids = ids, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, Fraction = 0.0 })
	ScreenAnchors.AxeUI = nil
	ScreenAnchors.AxeUIChargeAmount = nil
	wait( HUDScreen.FadeOutDuration )
	Destroy({ Ids = ids })
end

function ShowLobUI()

	if (not HeroHasTrait("LobImpulseAspect") and not HeroHasTrait("LobGunAspect")) or not ShowingCombatUI then
		return
	end

	if ScreenAnchors.LobUI ~= nil then
		return
	end
	ScreenAnchors.LobUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	ScreenAnchors.LobUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount })
	if HeroHasTrait("LobImpulseAspect") then
		local trait = GetHeroTrait("LobImpulseAspect")
		local currentCharge = trait.Charge
		local maxCharge = trait.OnEnemyDamagedAction.Args.MaxCharge
		local currentChargeText = round( currentCharge, 1)
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount, Fraction = currentCharge/ maxCharge, Instant = true })
		
		if trait.Charge >= trait.OnEnemyDamagedAction.Args.MaxCharge then
			SetAnimation({ Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = ScreenAnchors.LobUI })
		end
	elseif HeroHasTrait("LobGunAspect") then
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount, Fraction = 0, Instant = true })
	end
	SetAlpha({ Id = ScreenAnchors.LobUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.LobUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	SetAlpha({ Id = ScreenAnchors.LobUIChargeAmount, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.LobUIChargeAmount, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
end

function UpdateLobUI( trait )
	if not trait then
		return
	end
	if HeroHasTrait("LobImpulseAspect") then
		local currentCharge = trait.Charge
		local maxCharge = trait.OnEnemyDamagedAction.Args.MaxCharge
		local currentChargeText = round( currentCharge, 1)
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.LobUIChargeAmount, Fraction = currentCharge/ maxCharge, Instant = true })
	end
end

function HideLobUI( args )
	if ScreenAnchors.LobUI == nil then
		return
	end
	args = args or {}
	local ids = { ScreenAnchors.LobUI, ScreenAnchors.LobUIChargeAmount }
	SetAlpha({ Ids = ids, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, Fraction = 0.0 })
	ScreenAnchors.LobUI = nil
	ScreenAnchors.LobUIChargeAmount = nil
	wait( HUDScreen.FadeOutDuration )
	Destroy({ Ids = ids })
end

function ShowDaggerUI( args )

	args = args or {}
	if not ShowingCombatUI  and not args.Force then
		return
	end
	if not HeroHasTrait("DaggerBlockAspect") then
		return
	end

	local trait = GetHeroTrait("DaggerBlockAspect")

	if ScreenAnchors.DaggerUI ~= nil then
		SetAlpha({ Ids = { ScreenAnchors.DaggerUI, ScreenAnchors.DaggerUIChargeAmount }, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
		return
	end
	if ScreenAnchors.DaggerUIChargeAmount then
		Destroy({ Id = ScreenAnchors.DaggerUIChargeAmount })
	end
	
	ScreenAnchors.DaggerUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	ScreenAnchors.DaggerUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })

	local trait = GetHeroTrait("DaggerBlockAspect")
	local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown
	
	if not CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and SessionState.GlobalCooldowns.DaggerBlockShield then
		local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.DaggerBlockShield)			
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, PlaySpeed = ScreenData.HUD.ReloadTimerFrames / totalTime })
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, StartFrameFraction = 1 - remainingTime / totalTime })
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1 })
	else
		SetAnimation({ Name = "StaffReloadTimerReady",SuppressSounds = true, DestinationId = ScreenAnchors.DaggerUI })
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount})
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1, Instant = true })
	end
	SetAlpha({ Id = ScreenAnchors.DaggerUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.DaggerUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	SetAlpha({ Id = ScreenAnchors.DaggerUIChargeAmount, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.DaggerUIChargeAmount, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
end

function UpdateDaggerUI()
	local trait = GetHeroTrait("DaggerBlockAspect")
	local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown
	if not CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and SessionState.GlobalCooldowns.DaggerBlockShield then
		local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.DaggerBlockShield)
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, StartFrameFraction = 1 - remainingTime/totalTime })
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, PlaySpeed = ScreenData.HUD.ReloadTimerFrames / totalTime })
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1 })
	else
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount})
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1, Instant = true })
	end

end

function HideDaggerUI( args )
	if ScreenAnchors.DaggerUI == nil then
		return
	end
	args = args or {}
	local ids = { ScreenAnchors.DaggerUI, ScreenAnchors.DaggerUIChargeAmount }
	SetAlpha({ Ids = ids, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, Fraction = 0.0 })
	ScreenAnchors.DaggerUI = nil
	ScreenAnchors.DaggerUIChargeAmount = nil
	wait( HUDScreen.FadeOutDuration )
	Destroy({ Ids = ids })
end

function ShowSuitUI( args )

	args = args or {}
	if (not HeroHasTrait("SuitMarkCritAspect") and not HeroHasTrait("SuitComboAspect")) or not ShowingCombatUI then
		return
	end
	if ScreenAnchors.SuitUI ~= nil then
		SetAlpha({ Ids = { ScreenAnchors.SuitUI, ScreenAnchors.SuitUIChargeAmount }, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
		return
	end

	ScreenAnchors.SuitUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	ScreenAnchors.SuitUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount })
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, Fraction = 0, Instant = true })
	SetAlpha({ Id = ScreenAnchors.SuitUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.SuitUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	SetAlpha({ Id = ScreenAnchors.SuitUIChargeAmount, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.SuitUIChargeAmount, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	CreateTextBox({
		Id = ScreenAnchors.SuitUI,
		OffsetX = 26, OffsetY = -2,
		TextSymbolScale = 0.88,
		Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
		Justification = "Left",
		})
	UpdateSuitUI()
end

function UpdateSuitUI()
	if ScreenAnchors.SuitUI == nil then
		return
	end
	if HeroHasTrait("SuitComboAspect") then
		local trait = GetHeroTrait("SuitComboAspect")
		local effectName = trait.OnWeaponFiredFunctions.FunctionArgs.EffectName
		local stacks = 0
		local maxStacks = trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks
		
		if not IsEmpty(CurrentRun.Hero.ActiveEffects) and CurrentRun.Hero.ActiveEffects[effectName] then
			stacks = CurrentRun.Hero.ActiveEffects[effectName]
		end

		local text = "UI_StackText"
		local font = "NumericP22UndergroundSCHeavy"
		if stacks >= trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks then
			text = "UI_StackText_Max"
			font = "P22UndergroundSCHeavy"
		end
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, Fraction = stacks/maxStacks, Instant = true })
		if stacks >= maxStacks then
			SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.SuitUI })
		else
			StopAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.SuitUI })
		end
		ModifyTextBox({ Id = ScreenAnchors.SuitUI, Text =  text, Font = font, LuaKey = "TempTextData", LuaValue = { Amount = stacks}})
	end
end

function HideSuitUI( args )
	if ScreenAnchors.SuitUI == nil then
		return
	end
	args = args or {}
	local ids = { ScreenAnchors.SuitUI, ScreenAnchors.SuitUIChargeAmount }
	SetAlpha({ Ids = ids, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, Fraction = 0.0 })
	ScreenAnchors.SuitUI = nil
	ScreenAnchors.SuitUIChargeAmount = nil
	wait( HUDScreen.FadeOutDuration )
	Destroy({ Ids = ids })
end

function ShowManaMeter( args )
	
	args = args or {}

	local manaFraction = CurrentRun.Hero.Mana / CurrentRun.Hero.MaxMana
	local maxAvailableMana = GetHeroMaxAvailableMana()
	local reservedManaFraction = (CurrentRun.Hero.MaxMana - maxAvailableMana) / CurrentRun.Hero.MaxMana
	SetAnimationFrameTarget({ Name = "ManaBarFill", Fraction = 1 - manaFraction, DestinationId = HUDScreen.Components.ManaMeterFill.Id, Instant = true })
	SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = reservedManaFraction, DestinationId = HUDScreen.Components.ManaMeterReserve.Id, Instant = true })

	local componentIds = {}
	local componentNames = { "ManaMeterBack", "ManaMeterFill", "ManaMeterReserve", }
	if HasHeroTraitValue("ShowLowManaIndicator") then
		table.insert(componentNames, "ManaLowIndicator")
	end
	for k, componentName in ipairs( componentNames ) do
		local component = HUDScreen.Components[componentName]
		table.insert( componentIds, component.Id )
	end
	SetAlpha({ Ids = componentIds, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity, Duration = args.FadeDuration or HUDScreen.FadeInDuration })
	UpdateManaMeterUI()
end

function HideManaMeter( args )
	local componentIds = {}
	local componentNames = { "ManaMeterBack", "ManaMeterFill", "ManaMeterReserve", "ManaLowIndicator", }
	for k, componentName in ipairs( componentNames ) do
		local component = HUDScreen.Components[componentName]
		table.insert( componentIds, component.Id )
	end
	SetAlpha({ Ids = componentIds, Fraction = 0.0, Duration = HUDScreen.FadeOutDuration })
end


function UpdateManaMeterUI()
	UIScriptsDeferred.ManaMeterDirty = true
end

function UpdateManaMeterUIReal()	

	local fillPercent = CurrentRun.Hero.Mana / CurrentRun.Hero.MaxMana
	local maxAvailableMana = GetHeroMaxAvailableMana()
	local reservedManaFraction = (CurrentRun.Hero.MaxMana - maxAvailableMana) / CurrentRun.Hero.MaxMana

	local manaMeterFill = HUDScreen.Components.ManaMeterFill
	local manaMeterBackId = HUDScreen.Components.ManaMeterBack.Id
	ModifyTextBox({ Id = manaMeterBackId, Text = "UI_ManaText",
		LuaKey = "TempTextData",
		LuaValue = { Current = math.floor(CurrentRun.Hero.Mana), AvailableMaximum = maxAvailableMana, RealMaximum = CurrentRun.Hero.MaxMana }
	})

	SetAnimationFrameTarget({ Name = "ManaBarFill", Fraction = 1 - fillPercent, DestinationId = HUDScreen.Components.ManaMeterFill.Id, Duration = manaMeterFill.UpdateDuration, EaseIn = manaMeterFill.UpdateEaseIn, EaseOut = manaMeterFill.UpdateEaseOut })
	
	if maxAvailableMana ~= CurrentRun.Hero.MaxMana then
		ModifyTextBox({ Id = HUDScreen.Components.ManaMeterReserve.Id, Text = "UI_ManaReservedText",
			LuaKey = "TempTextData",
			LuaValue = { ReservedMana = math.min(CurrentRun.Hero.MaxMana, CurrentRun.Hero.MaxMana - maxAvailableMana), Current = math.floor(CurrentRun.Hero.Mana), AvailableMaximum = maxAvailableMana, RealMaximum = CurrentRun.Hero.MaxMana}
		})
		SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = reservedManaFraction, DestinationId = HUDScreen.Components.ManaMeterReserve.Id, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
	else
		ModifyTextBox({ Id = HUDScreen.Components.ManaMeterReserve.Id, Text = " "})
		SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = 0, DestinationId = HUDScreen.Components.ManaMeterReserve.Id, Instant = true })
	end

	local lowManaPercent = ScreenData.HUD.ComponentData.ManaLowIndicator.LowManaThreshold / CurrentRun.Hero.MaxMana
	local offsetX = 526 * lowManaPercent - 263
	local offsetY = ScreenData.HUD.ComponentData.ManaLowIndicator.BarOffset
	Attach({ Id = HUDScreen.Components.ManaLowIndicator.Id, DestinationId = HUDScreen.Components.ManaMeterBack.Id, OffsetX = offsetX, OffsetY = offsetY })
	UIScriptsDeferred.ManaMeterDirty = false
end

function ShowTraitUI( args )

	args = args or {}
	local traitsToAdd = {}

	local currentTraits = ShallowCopyTable( CurrentRun.Hero.Traits )
	currentTraits = CollapseTableOrdered( currentTraits )

	-- Add slotted
	for i, slotName in ipairs( HUDScreen.SlottedTraitOrder ) do
		for i, trait in ipairs( currentTraits ) do
			if trait.AnchorId == nil and trait.Slot == slotName and IsShownInHUD( trait ) then
				trait.Ordered = true
				table.insert( traitsToAdd, trait )
				break
			end
		end
	end
	-- Add actives
	for i, slotName in ipairs( HUDScreen.ActiveTraitOrder ) do
		for i, trait in ipairs( currentTraits ) do
			if trait.AnchorId == nil and trait.Slot == slotName and IsShownInHUD( trait ) then
				trait.Ordered = true
				table.insert( traitsToAdd, trait )
				break
			end
		end
	end

	-- Add remaining
	for i, trait in ipairs( currentTraits ) do
		if trait.AnchorId == nil and not trait.Ordered and IsShownInHUD( trait ) then
			table.insert( traitsToAdd, trait )
		end
	end

	for index, trait in ipairs( traitsToAdd ) do
		TraitUIAdd( trait )
	end

	if args.ForceShow or CurrentHubRoom == nil then
		for id, traitComponent in pairs( HUDScreen.SlottedTraitComponents ) do
			HUDShowTrait( traitComponent.TraitData, args )
		end
	end
	for id, traitComponent in pairs( HUDScreen.ActiveTraitComponents ) do
		HUDShowTrait( traitComponent.TraitData, args )
		SessionMapState.HUDTraitsShown[traitComponent.TraitData.Name] = true
	end

	local slotIconIds = nil
	if args.ForceShow or CurrentHubRoom == nil then
		slotIconIds =
		{
			HUDScreen.Components.AttackSlotIcon.Id,
			HUDScreen.Components.SpecialSlotIcon.Id,
			HUDScreen.Components.CastSlotIcon.Id,
			HUDScreen.Components.DashSlotIcon.Id,
			HUDScreen.Components.ManaSlotIcon.Id,
		}
	else
		slotIconIds = {}
	end
	if args.ForceShow then
		table.insert( slotIconIds, HUDScreen.Components.WeaponSlotIcon.Id )
		table.insert( slotIconIds, HUDScreen.Components.FamiliarSlotIcon.Id )
	end
	SetAlpha({ Ids = slotIconIds, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })

	if not args.SkipTraitActivateCheck then
		TraitUIActivateTraits( { IgnoreFlash = true } )
	end
end

function HUDShowTrait( trait, args )
	args = args or {}

	if not args.ForceShow and trait.HideInHUD then
		return
	end
	if trait.QueuedNumberUpdate then
		UpdateTraitNumber( trait ) 
		trait.QueuedNumberUpdate = nil
	end

	local fadeInIds = {}
	if trait.AnchorId ~= nil then
		table.insert( fadeInIds, trait.AnchorId )
		if args.ForceUseableOn then
			UseableOn({ Id = trait.AnchorId })
		end
	end
	if trait.TraitInfoCardId ~= nil then
		table.insert( fadeInIds, trait.TraitInfoCardId )
	end
	if trait.TraitIconOverlay ~= nil then
		table.insert( fadeInIds, trait.TraitIconOverlay )
	end
	if trait.TraitActiveOverlay ~= nil then
		table.insert( fadeInIds, trait.TraitActiveOverlay )
	end
	SetAlpha({ Ids = fadeInIds, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = args.Fraction or ConfigOptionCache.HUDOpacity })
	if trait.Slot == "Spell" then
		CreateSpellHUD( trait )
	end
end

function TraitUIAdd( trait, args )

	if HUDScreen == nil then
		return
	end
	args = args or {}

	--local updatedTrait = IsExistingTraitShown( trait )
	if trait.AnchorId ~= nil then
		UpdateTraitNumber( trait )
		return
	end

	local locationX = args.LocationX
	local locationY = args.LocationY
	local container = nil
	local activeOffsetIndex = nil
	if locationX == nil then
		local slotIndex = GetIndex( HUDScreen.SlottedTraitOrder, trait.Slot )
		if slotIndex > 0 then
			locationX = ScreenData.TraitTrayScreen.TraitStartX
			locationY = (ScreenHeight - ScreenData.TraitTrayScreen.TraitStartBottomOffset) + ( (slotIndex - 1) * ScreenData.TraitTrayScreen.TraitSpacingY )
			container = HUDScreen.SlottedTraitComponents
		else
			activeOffsetIndex = trait.ActiveSlotOffsetIndex or TableLength( HUDScreen.ActiveTraitComponents )
			locationX = ScreenData.TraitTrayScreen.TraitStartX + ( activeOffsetIndex * ScreenData.TraitTrayScreen.TraitSpacingX )
			locationY = ScreenHeight - HUDScreen.ActiveTraitBottomOffset
			container = HUDScreen.ActiveTraitComponents
		end
	end

	local rawTraitData = TraitData[trait.Name] or trait
	local traitComponent = CreateScreenComponent({ Name = "TraitTrayIconButton", X = locationX, Y = locationY, Group = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup, Scale = rawTraitData.HUDScale or 0.5 })
	AttachLua({ Id = traitComponent.Id, Table = traitComponent })
	traitComponent.TraitData = trait
	traitComponent.ActiveOffsetIndex = activeOffsetIndex
	traitComponent.OffsetX = locationX
	traitComponent.OffsetY = locationY
	traitComponent.PinIconScale = 0.26
	traitComponent.PinIconFrameScale = 0.27
	traitComponent.HighlightAnimScale = 0.27
	traitComponent.TrayHighlightAnimScale = trait.TrayHighlightAnimScale or 1.0
	trait.AnchorId = traitComponent.Id
	SetAnimation({ Name = GetTraitIcon( trait ), DestinationId = trait.AnchorId })	
	if container ~= nil then
		container[traitComponent.Id] = traitComponent
	end
	SetAlpha({ Id = trait.AnchorId, Fraction = 0, Duration = 0 })
	UseableOff({ Id = traitComponent.Id })

	if rawTraitData.PreCreateActiveOverlay then
		trait.TraitActiveOverlay = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier",
			Group = args.GroupName or HUDScreen.ActiveTraitGroup,
			Alpha = 0.0, AlphaTarget = ConfigOptionCache.HUDOpacity, AlphaTargetDuration = 0.2, })
		Attach({ Id = trait.TraitActiveOverlay, DestinationId = trait.AnchorId })
	end
	
	local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ActiveTraitGroup, Scale = 0.5 })
	Attach({ Id = traitFrameId, DestinationId = trait.AnchorId })
	local frameAnim = GetTraitFrame( trait )
	if frameAnim ~= nil then
		SetAnimation({ Name = frameAnim, DestinationId = traitFrameId })
	end
	trait.TraitIconOverlay = traitFrameId
	SetAlpha({ Id = trait.TraitIconOverlay, Fraction = 0, Duration = 0 })

	TraitUICreateText( trait, HUDScreen.ActiveTraitGroup )		
	if trait.TraitIconOverlay ~= nil then
		SetAlpha({ Id = trait.TraitIconOverlay, Fraction = 0, Duration = 0 })
	end
	if trait.TraitInfoCardId ~= nil then
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0 })
	end

	if args.Show then
		HUDShowTrait( trait )
	end

end

function IsExistingTraitShown( trait )
	local searchTable = CurrentRun.Hero.Traits
	if CurrentRun.Hero.TraitDictionary then
		searchTable = CurrentRun.Hero.TraitDictionary[trait.Name]
	end
	if searchTable == nil then
		return false
	end

	for k, existingTrait in pairs( searchTable ) do
		if existingTrait.AnchorId ~= nil then
			return true
		end
	end
	return false
end

function GetExistingUITraitName( traitName )
	for k, existingTrait in ipairs( CurrentRun.Hero.Traits ) do
		if existingTrait.Name == traitName and existingTrait.AnchorId ~= nil then
			return existingTrait
		end
	end
	return nil
end

function GetExistingUITrait( trait )
	if not trait then
		return nil
	end
	local searchTable = CurrentRun.Hero.Traits
	if CurrentRun.Hero.TraitDictionary then
		searchTable = CurrentRun.Hero.TraitDictionary[trait.Name]
	end
	if not searchTable then
		return nil
	end

	for k, existingTrait in pairs( searchTable ) do
		if AreTraitsIdentical(trait, existingTrait) then
			if existingTrait.AnchorId ~= nil then
				return existingTrait
			end
		end
	end
	return nil
end

function UpdateTraitNumber( trait )
	if not ShowingCombatUI then
		trait.QueuedNumberUpdate = true
		return
	end
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData ~= nil then
		DestroyTextBox({ Id = existingTraitData.TraitInfoCardId })
		TraitUICreateText( existingTraitData, HUDScreen.ActiveTraitGroup )
		if GetRarityValue( existingTraitData.Rarity ) < GetRarityValue ( trait.Rarity ) then
			Destroy({ Id = existingTraitData.TraitIconOverlay })
			local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI"  })
			Attach({ Id = traitFrameId, DestinationId = existingTraitData.AnchorId })
			local frameAnim = GetTraitFrame( trait )
			if frameAnim ~= nil then
				SetAnimation({ Name = frameAnim, DestinationId = traitFrameId })
			end
			existingTraitData.TraitIconOverlay = traitFrameId
		end
	end
end

function TraitUICreateText( trait, args )
	args = args or {}
	local anchorId = args.AnchorId or trait.AnchorId
	if anchorId == nil then
		return
	end
	if trait.Slot == "Spell" then
		CreateSpellHUD( trait, args )
		return
	end
	local xOffset = 0
	local yOffset = trait.TrayTextOffsetY or -7
	local traitCount = 1
	if trait.FamiliarTrait then
		traitCount = 1 + GetFamiliarUpgradeCount( trait )
	else
		traitCount = GetTraitCount( CurrentRun.Hero, { TraitData = trait } )
	end
	local time = trait.RemainingUses or trait.Uses
	if trait.RarityUpgradeData then
		time = trait.RarityUpgradeData.Uses
	end
	if trait.BoonConversionUses then
		time = trait.BoonConversionUses
	end
	local hasSubtitle = ( time ~= nil ) or ( traitCount > 1) or ( trait.RoomsPerUpgrade and IsTraitActive( trait ) ) or ( trait.CustomLabel ) or (trait.TotalManaRecovered ~= nil) or (trait.DoorHealReserve ~= nil)
	if trait.BlockedByEnding and IsGameStateEligible( trait, { NamedRequirements = { "SurfaceRouteLockedByTyphonKill" } } ) then
		hasSubtitle = false
	end

	if not hasSubtitle then
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0.2 })
		return
	end

	if trait.TraitInfoCardId == nil then
		trait.TraitInfoCardId = CreateScreenObstacle({
				Name = "TraitTray_LevelBacking",
				Group = "Combat_Menu_TraitTray",
				Animation = trait.TrayTextBackingAnimation,
				AlphaTarget = ConfigOptionCache.HUDOpacity,
				AlphaTargetDuration = args.FadeDuration or 0.2,
				DestinationId = anchorId, Attach = true,
				OffsetY = ScreenData.HUD.TraitInfoCardOffsetY + (trait.TrayTextBackingOffsetY or 0),
			})
	else
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = ConfigOptionCache.HUDOpacity, Duration = args.FadeDuration or 0.2 })	
	end
	if trait.CustomLabel then
		local textData = {}
		if trait.CustomLabel.DisplayType == "SessionMapStateValue" then
			textData.Value = SessionMapState[trait.CustomLabel.Key]
		end
		if trait.CustomLabel.DisplayType == "RoomValue" and CurrentRun and CurrentRun.CurrentRoom then
			textData.Value = CurrentRun.CurrentRoom[trait.CustomLabel.Key]
		end
		textData.Value = textData.Value or 0
		if trait.CustomLabel.MultiplyByRarity and trait.RarityMultiplier then
			textData.Value = textData.Value * trait.RarityMultiplier
		end
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = trait.CustomLabel.Text,
			Font = trait.CustomLabel.Font or "NumericP22UndergroundSCMedium",
			TextSymbolScale = 0.88,
			Color = Color.White, FontSize = 22, 
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset, OffsetY = yOffset,
			Justification = "Center",
			LuaKey = "TempTextData",
			LuaValue = textData,
		})
	end
	if time ~= nil then
		if trait.HUDTextOverride then
			if trait.HUDTextOverride == "LimitedLifesteal" then
				local lifestealUses = CurrentRun.LifestealUses 
				if not lifestealUses then
					lifestealUses = trait.AddOutgoingLifestealModifiers.LimitedUse
				end
				CreateTextBox({
					Id = trait.TraitInfoCardId,
					Text = "UI_HealingUses", Font = "NumericP22UndergroundSCMedium",
					Color = Color.White, FontSize = 22, 
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
					OffsetX = xOffset, OffsetY = yOffset,
					Justification = "Center",
					LuaKey = "TempTextData",
					LuaValue = { Time = lifestealUses },
				})
			end

		elseif trait.ActivatedThisBiome ~= nil then
			local text = "UI_Uses" 
			if trait.ActivatedThisBiome then
				text = "HUD_NoEligibleUpgrades"
			end
			CreateTextBox({ Id = trait.TraitInfoCardId,
				Text = text, Font = "P22UndergroundSCMedium",
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				FontSize = 22,
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center",
				DataProperties =
				{
					TextSymbolScale = 0.9,
					TextSymbolOffsetY = 3,
				},
				LuaKey = "TempTextData",
				LuaValue = { Time = 1 },
			})
			xOffset = xOffset + 40
		elseif ( trait.UsesAsEncounters and trait.RemainingUses ~= nil and trait.OnExpire and trait.OnExpire.HealFraction ) then
			CreateTextBox({ Id = trait.TraitInfoCardId,
				Text = "UI_Time", Font = "P22UndergroundSCMedium",
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				FontSize = 22,
				OffsetX = xOffset, OffsetY = yOffset,
				DataProperties =
				{
					TextSymbolScale = 0.9,
					TextSymbolOffsetY = 3,
				},
				Justification = "Center", LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time)},
			})
			xOffset = xOffset + 40
		elseif ( trait.UsesAsRooms and trait.RemainingUses ~= nil ) then
			CreateTextBox({ Id = trait.TraitInfoCardId,
				Text = "UI_Uses", Font = "P22UndergroundSCMedium",
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				FontSize = 22,
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center",
				DataProperties =
				{
					TextSymbolScale = 0.9,
					TextSymbolOffsetY = 3,
				},
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time)},
			})
			xOffset = xOffset + 40
		elseif ( trait.RemainingUses ~= nil or trait.Uses ~= nil ) and not trait.UsesAsRooms then
			if traitCount > 1 then
				time = 0
				for i, ownedTrait in ipairs( CurrentRun.Hero.Traits ) do
					if ownedTrait.Name == trait.Name then
						if ownedTrait.RemainingUses then
							time = time + ownedTrait.RemainingUses
						elseif ownedTrait.Uses then
							time = time + ownedTrait.Uses
						end
					end
				end
			end
			local text = "UI_Uses"
			if trait.UsesAsBosses then
				text = "UI_Uses_Boss"
			end

			CreateTextBox({
				Id = trait.TraitInfoCardId,
				Text = text,
				Font = "NumericP22UndergroundSCMedium", 
				FontSize = 22,
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center",
				DataProperties =
				{
					TextSymbolScale = 0.9,
					TextSymbolOffsetY = 3,
				},
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
			})
			xOffset = xOffset + 40
		
		elseif trait.RarityUpgradeData or trait.BoonConversionUses then
			CreateTextBox({
				Id = trait.TraitInfoCardId,
				Text = "UI_Uses",
				Font = "NumericP22UndergroundSCMedium", 
				FontSize = 22,
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center",
				DataProperties =
				{
					TextSymbolScale = 0.9,
					TextSymbolOffsetY = 3,
				},
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
			})
			xOffset = xOffset + 40
		end
	elseif IsTraitActive(trait) and trait.RoomsPerUpgrade and trait.CurrentRoom then
		local countdown = trait.RoomsPerUpgrade.Amount - trait.CurrentRoom
		local text = "UI_Time"
		if trait.RoomsPerUpgrade.Rarity and (CurrentRun.Hero.UpgradableTraitCount or 0) <= 0 then
			text = "HUD_NoEligibleUpgrades"
		end
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = text,
			Font = "P22UndergroundSCMedium", FontSize = 22,
			Color = Color.White,
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset, OffsetY = yOffset,
			Justification = "Center",
			DataProperties =
			{
				TextSymbolScale = 0.7,
				TextSymbolOffsetY = 3,
			},
			LuaKey = "TempTextData",
			LuaValue = { Time = math.floor(countdown) },
		})
	elseif trait.TotalManaRecovered then
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = "UI_ManaUses", Font = "NumericP22UndergroundSCMedium",
			Color = Color.White, FontSize = 22, 
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset, OffsetY = yOffset,
			DataProperties =
			{
				TextSymbolScale = 0.7,
				TextSymbolOffsetY = 3,
			},
			Justification = "Center",
			LuaKey = "TempTextData",
			LuaValue = { Time = trait.TotalManaRecovered },
		})
	elseif trait.DoorHealReserve then
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = "UI_HealingUses", Font = "NumericP22UndergroundSCMedium",
			Color = Color.White, FontSize = 22, 
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset, OffsetY = yOffset,
			DataProperties =
			{
				TextSymbolScale = 0.7,
				TextSymbolOffsetY = 3,
			},
			Justification = "Center",
			LuaKey = "TempTextData",
			LuaValue = { Time = trait.DoorHealReserve },
		})
	elseif traitCount > 1 then
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = "UI_TraitLevel",
			Font = "NumericP22UndergroundSCMedium", FontSize = 21,
			Color = Color.White,
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset, OffsetY = yOffset,
			DataProperties =
			{
				TextSymbolScale = 1.0,
				TextSymbolOffsetY = 6,
			},
			Justification = "Center",
			LuaKey = "TempTextData",
			LuaValue = { Amount = traitCount },
		})
		xOffset = xOffset + 45
	end

	if not ShowingCombatUI then
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0})
	end
end

function TraitUIActivateTraits( args )

	thread( UpdateSpellActiveStatus )
	local blockedByEndingTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		local thresholdData = traitData.LowHealthThresholdText
		if thresholdData ~= nil then
			if thresholdData.Threshold and CurrentRun.Hero.Health <= thresholdData.Threshold then
				TraitUIActivateTrait( traitData, args )
			end
			if thresholdData.ThresholdFraction and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction then
				TraitUIActivateTrait( traitData, args )
			end
		end
		
		thresholdData = traitData.HighHealthThresholdText
		if thresholdData ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth >= thresholdData.PercentThreshold then
			TraitUIActivateTrait( traitData, args )
		end
		if blockedByEndingTrait == nil and traitData.BlockedByEnding and not IsGameStateEligible( traitData, { NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" } } ) then
			blockedByEndingTrait = traitData
		end
	end
	for _, traitName in ipairs( { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusSprintBoon" } ) do
		if HeroHasTrait(traitName) then
			local traitData = GetHeroTrait( traitName )
			local damagedActionArgs = nil
			if traitData.OnEnemyDamagedAction then
				damagedActionArgs = traitData.OnEnemyDamagedAction.Args
			elseif traitData.OnBlinkEndAction then
				damagedActionArgs = traitData.OnBlinkEndAction.FunctionArgs
			end
			local visibleTrait = GetHeroTrait( damagedActionArgs.TraitName)
			local cooldown = damagedActionArgs.Cooldown * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
			if not CheckCooldownNoTrigger( damagedActionArgs.Name, cooldown ) and SessionState.GlobalCooldowns[damagedActionArgs.Name] then
				local totalTime = cooldown
				local elapsedTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns[damagedActionArgs.Name])
				TraitUIActivateTrait( visibleTrait, { FlashOnActive = false, Duration = totalTime })
				local existingTraitData = GetExistingUITrait( visibleTrait )
				if existingTraitData ~= nil then
					SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - elapsedTime/totalTime, DestinationId = existingTraitData.TraitActiveOverlay })
				end
			else
				TraitUIActivateTrait( visibleTrait, args )
			end
		end
	end
	if HeroHasTrait( "AthenaProjectileBoon" ) then
		local traitData = GetHeroTrait( "AthenaProjectileBoon" )
		if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs and traitData.OnWeaponFiredFunctions.FunctionArgs.Cooldown and CheckCooldownNoTrigger( "AthenaProjectile", traitData.OnWeaponFiredFunctions.FunctionArgs.Cooldown, true ) then
			TraitUIActivateTrait( traitData, args )	
		end
	end
	if HeroHasTrait( "RetaliateInvulnerabilityBoon" ) then
		local traitData = GetHeroTrait( "RetaliateInvulnerabilityBoon" )
		if traitData.OnSelfDamagedFunction and traitData.OnSelfDamagedFunction.FunctionArgs and traitData.OnSelfDamagedFunction.FunctionArgs.Cooldown and CheckCooldownNoTrigger( "AthenaInvulnerability" .. CurrentRun.Hero.ObjectId, traitData.OnSelfDamagedFunction.FunctionArgs.Cooldown, true ) then
			TraitUIActivateTrait( traitData, args )	
		end
	end
	if HeroHasTrait("PoseidonManaBoon") and not SessionMapState.PoseidonManaActive and SessionMapState.NextPoseidonManaActiveTime then
		local trait = GetHeroTrait("PoseidonManaBoon")
		local totalTime = trait.SetupFunction.Args.Interval * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
		local remainingTime = SessionMapState.NextPoseidonManaActiveTime - _worldTime
		TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = remainingTime })
		SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - remainingTime/totalTime, DestinationId = trait.TraitActiveOverlay, PlaySpeed = ScreenData.HUD.CooldownTimerFrames/totalTime })
	end
	if HeroHasTrait("DaggerBlockAspect") then
		local trait = GetHeroTrait("DaggerBlockAspect")
		local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown
		if not CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and SessionState.GlobalCooldowns.DaggerBlockShield then
			local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.DaggerBlockShield)
			TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = remainingTime })
			SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - remainingTime/totalTime, DestinationId = trait.TraitActiveOverlay, PlaySpeed = ScreenData.HUD.CooldownTimerFrames/totalTime })
		end
	end
	if HeroHasTrait("HadesInvisibilityRetaliateBoon") then
		local trait = GetHeroTrait("HadesInvisibilityRetaliateBoon")
		local totalTime = trait.OnSelfDamagedFunction.FunctionArgs.Cooldown
		if not CheckCooldownNoTrigger("HadesRetaliate", totalTime) and SessionState.GlobalCooldowns.HadesRetaliate then
			local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.HadesRetaliate)
			TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = remainingTime })
			SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - remainingTime/totalTime, DestinationId = trait.TraitActiveOverlay, PlaySpeed = ScreenData.HUD.CooldownTimerFrames/totalTime })
		else
			TraitUIActivateTrait( trait, args )	
		end
	end
	if HeroHasTrait("ExPolymorphBoon") then
		local trait = GetHeroTrait("ExPolymorphBoon")
		local totalTime = trait.OnEnemyDamagedAction.Args.Cooldown
		if not CheckCooldownNoTrigger("CircePolymorph", totalTime) and SessionState.GlobalCooldowns.CircePolymorph then
			local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.CircePolymorph)
			TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = remainingTime })
			SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - remainingTime/totalTime, DestinationId = trait.TraitActiveOverlay, PlaySpeed = ScreenData.HUD.CooldownTimerFrames/totalTime })
		else
			TraitUIActivateTrait( trait, args )	
		end
	end
	
	UpdateTimerDependentTraits()

	if HeroHasTrait("SpellPotionTrait") then
		local traitData = GetHeroTrait("SpellPotionTrait")
		if traitData.RemainingUses <= 0 then
			TraitUIActivateTrait( traitData, { CustomAnimation = "InactiveTrait" } )
		end
	end
	if HeroHasTrait("TimedKillBuffBoon") then
		local traitData = GetHeroTrait("TimedKillBuffBoon")
		UpdateTraitNumber( traitData )
	end
	if HeroHasTrait("DummyBloodDisplayBoon") then
		local traitData = GetHeroTrait("DummyBloodDisplayBoon")
		UpdateTraitNumber( traitData )
	end
	if blockedByEndingTrait ~= nil then
		TraitUIActivateTrait( blockedByEndingTrait, { CustomAnimation = "LockedKeepsakeIcon" } )
	end
end

function UpdateTimerDependentTraits()

	if HeroHasTrait("ChaosTimeCurse") or ( HeroHasTrait("TimedBuffKeepsake") and not CurrentRun.Hero.IsDead) then
		local traits = {}
		if HeroHasTrait("ChaosTimeCurse") then
			table.insert(traits, GetHeroTrait("ChaosTimeCurse"))
		end
		if HeroHasTrait("TimedBuffKeepsake") then
			table.insert(traits, GetHeroTrait("TimedBuffKeepsake"))
		end
		for _, trait in pairs(traits) do
			local currentTime = trait.CurrentTime or 0.0
			local totalTime = trait.StartingTime or 1.0
			TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = totalTime })
			if trait.TraitActiveOverlay then
				if IsBiomeTimerPaused() or HasTimerBlock( CurrentRun ) then
					SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = 1 - currentTime/totalTime, DestinationId = trait.TraitActiveOverlay, Instant = true })
				else
					SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - currentTime/totalTime, DestinationId = trait.TraitActiveOverlay })
					SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = 1, DestinationId = trait.TraitActiveOverlay})
				end
			end
		end
	end

end

function TraitUIActivateTrait( trait, args )
	if not ShowingCombatUI then
		return
	end
	args = args or {}
	local customAnimation = args.CustomAnimation or "ActiveTrait"
	local playSpeed = args.PlaySpeed
	local existingTraitData = GetExistingUITrait( trait )
	if args.Duration then
		customAnimation = args.CustomAnimation or "ActiveTraitCooldownNoFlash"
		playSpeed = ScreenData.HUD.CooldownTimerFrames / args.Duration
			
		if args.FlashOnActive then
			thread( ActivateTraitAfterDelay, existingTraitData, args.Duration )
		end
	end
	if existingTraitData == nil or existingTraitData.HideInHUD then
		return
	end
	if existingTraitData.TraitActiveOverlay == nil then
		existingTraitData.TraitActiveOverlay = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier",
			Group = args.GroupName or HUDScreen.ActiveTraitGroup,
			Alpha = 0.0, AlphaTarget = ConfigOptionCache.HUDOpacity, AlphaTargetDuration = 0.2, })
		Attach({ Id = existingTraitData.TraitActiveOverlay, DestinationId = existingTraitData.AnchorId })
	end
	SetAnimation({ Name = customAnimation, DestinationId = existingTraitData.TraitActiveOverlay, PlaySpeed = playSpeed })
	if not args.IgnoreFlash and not args.Duration and args.CustomAnimation == nil then
		CreateAnimation({ Name = "ActiveTraitFlash", DestinationId = existingTraitData.TraitActiveOverlay })
	end
end

function ActivateTraitAfterDelay( traitData, delay )
	if not traitData or SetThreadWait( traitData.Name .. "HUD", delay )then
		return
	end
	local threadName = traitData.Name .. "HUD"
	SessionMapState.ElapsedTimeMultiplierIgnores[ threadName ] = true
	wait(delay, threadName )
	TraitUIActivateTrait( traitData )
	SessionMapState.ElapsedTimeMultiplierIgnores[threadName] = nil
end

function TraitUIDeactivateTrait( trait )
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData ~= nil and existingTraitData.TraitActiveOverlay ~= nil then
		Destroy({ Id = existingTraitData.TraitActiveOverlay })
		existingTraitData.TraitActiveOverlay = nil
	end
end

function TraitUIUpdateText( trait )
	if trait.AnchorId then
		DestroyTextBox({ Id = trait.TraitInfoCardId })
		TraitUICreateText( trait )
	end
end

function GetTraitIcon( trait )
	return trait.Icon
end

function GetTraitFrame( trait )
	if trait.NoFrame then
		return nil
	end
	if trait.Frame then
		return "Frame_Boon_Menu_"..trait.Frame
	elseif trait.Rarity ~= nil then
		if trait.FrameRarities ~= nil then
			return trait.FrameRarities[trait.Rarity]
		end
		return "Frame_Boon_Menu_"..trait.Rarity
	end
	return "BoonIcon_Frame_Common"
end

function GetTraitTooltip( trait, args )
	args = args or {}

	if CurrentRun.Hero.IsDead and args.ForTraitTray and trait.CustomTrayNameWhileDead then
		return trait.CustomTrayNameWhileDead		
	elseif args.UnequippedKeepsakePreview and trait.UnequippedKeepsakeTitle then
		return trait.UnequippedKeepsakeTitle
	elseif args.ForTraitTray and trait.CustomTrayText then
		return trait.CustomTrayText
	elseif trait.CustomName then
		return trait.CustomName
	elseif trait.CustomNameWithWeaponName and CurrentRun.Hero.Weapons[trait.CustomNameWithWeaponName.WeaponName] then
		return trait.CustomNameWithWeaponName.Name
	elseif not args.CheckingOverrides and not IsTraitActive( trait ) then
		if trait.RarityUpgradeData and trait.RarityUpgradeData.Uses == 0 then
			return trait.Name .. "_NoUpgradeUses"
		end
		return trait.Name .. "_Inactive"
	elseif trait.CustomDescriptionFunctionName ~= nil and _G[trait.CustomDescriptionFunctionName] ~= nil then
		local traitCustomArgs = trait.CustomDescriptionFunctionArgs
		for index, t in ipairs(traitCustomArgs) do
			if IsGameStateEligible( trait, t.GameStateRequirements ) then
				traitCustomArgs = t
				break
			end
		end
		local customDesc = CallFunctionName( trait.CustomDescriptionFunctionName, traitCustomArgs )
		return customDesc
	elseif args.Default then
		return args.Default
	end
	return trait.Name

end

function GetTraitTooltipTitle( trait )

	local title = ""
	if trait.CustomTitle then
		title = trait.CustomTitle
	else
		if trait.OnExpire ~= nil and trait.OnExpire.TraitData ~= nil then
			title = "ChaosCombo_"..trait.Name.."_"..trait.OnExpire.TraitData.Name
		elseif trait.LastCurseName and trait.LastBlessingName then
			title = "ChaosCombo_"..trait.LastCurseName.."_"..trait.LastBlessingName
		else
			title = trait.Name
		end
	end

	--DebugAssert({ Condition = HasDisplayName({ Text = title }), Owner = "Dexter", "GetTraitTooltipTitle() returned "..tostring(title).." but it doesn't have a DisplayName!" })
	return title
end

function TraitUIRemove( trait )
	if trait == nil then
		return
	end
	if HUDScreen == nil then
		return
	end
	if trait.AnchorId == nil then
		return
	end

	local container = nil
	local slotIndex = GetIndex( HUDScreen.SlottedTraitOrder, trait.Slot )
	if slotIndex > 0 then
		container = HUDScreen.SlottedTraitComponents
	else
		container = HUDScreen.ActiveTraitComponents
	end
	local traitComponent = container[trait.AnchorId]
	container[trait.AnchorId] = nil

	if trait.AnchorId ~= nil then
		Destroy({ Id = trait.AnchorId })
		trait.AnchorId = nil
	end
	if trait.TraitInfoCardId ~= nil then
		Destroy({ Id = trait.TraitInfoCardId })
		trait.TraitInfoCardId = nil
	end
	if trait.TraitInfoUsesId ~= nil then
		Destroy({ Id = trait.TraitInfoUsesId })
		trait.TraitInfoUsesId = nil
	end
	if trait.TraitInfoChargeId ~= nil then
		Destroy({ Id = trait.TraitInfoChargeId })
		trait.TraitInfoChargeId = nil
	end
	if trait.TraitIconOverlay ~= nil then
		Destroy({ Id = trait.TraitIconOverlay })
		trait.TraitIconOverlay = nil
	end
	if trait.TraitActiveOverlay ~= nil then
		Destroy({ Id = trait.TraitActiveOverlay })
		trait.TraitActiveOverlay = nil
	end

	if traitComponent ~= nil and traitComponent.ActiveOffsetIndex ~= nil and trait.ActiveSlotOffsetIndex == nil then
		for id, otherTraitComponent in pairs( HUDScreen.ActiveTraitComponents ) do
			if otherTraitComponent.ActiveOffsetIndex ~= nil and otherTraitComponent.ActiveOffsetIndex > traitComponent.ActiveOffsetIndex then
				local ids = CollapseTable( { otherTraitComponent.TraitData.AnchorId, otherTraitComponent.TraitData.TraitInfoCardId, otherTraitComponent.TraitData.TraitInfoUsesId,otherTraitComponent.TraitData.TraitInfoChargeId, otherTraitComponent.TraitData.TraitIconOverlay, otherTraitComponent.TraitData.TraitActiveOverlay } )
				Move({ Ids = ids, Distance = ScreenData.TraitTrayScreen.TraitSpacingX, Angle = 180, Duration = 0.3, EaseOut = 1, Additive = true })
				otherTraitComponent.ActiveOffsetIndex = otherTraitComponent.ActiveOffsetIndex - 1
			end
		end
	end

end

function HideTraitUI( args )
	args = args or {}
	for id, traitComponent in pairs( HUDScreen.SlottedTraitComponents ) do
		HUDHideTrait( traitComponent.TraitData, args )
	end
	if not args.KeepActiveComponents then
		for id, traitComponent in pairs( HUDScreen.ActiveTraitComponents ) do
			HUDHideTrait( traitComponent.TraitData, args )
		end
	end
	local slotIconIds =
	{
		HUDScreen.Components.WeaponSlotIcon.Id,
		HUDScreen.Components.FamiliarSlotIcon.Id,
		HUDScreen.Components.AttackSlotIcon.Id,
		HUDScreen.Components.SpecialSlotIcon.Id,
		HUDScreen.Components.CastSlotIcon.Id,
		HUDScreen.Components.DashSlotIcon.Id,
		HUDScreen.Components.ManaSlotIcon.Id,
	}
	SetAlpha({ Ids = slotIconIds, Duration = args.FadeOutDuration or HUDScreen.FadeOutDuration, Fraction = 0 })
end

function HUDHideTrait( trait, args )
	args = args or {}
	local duration = args.FadeOutDuration or HUDScreen.FadeOutDuration
	if trait.AnchorId ~= nil then
		SetAlpha({ Id = trait.AnchorId, Duration = duration, Fraction = 0 })
		UseableOff({ Id = trait.AnchorId })
	end
	if trait.TraitInfoCardId ~= nil then
		SetAlpha({ Id = trait.TraitInfoCardId, Duration = duration, Fraction = 0 })
	end
	if trait.TraitInfoUsesId ~= nil then
		SetAlpha({ Id = trait.TraitInfoUsesId, Duration = duration, Fraction = 0 })
	end
	if trait.TraitInfoChargeId ~= nil then
		SetAlpha({ Id = trait.TraitInfoChargeId, Duration = duration, Fraction = 0 })
	end
	if trait.TraitIconOverlay ~= nil then
		SetAlpha({ Id = trait.TraitIconOverlay, Duration = duration, Fraction = 0 })
	end
	if trait.TraitActiveOverlay ~= nil then
		SetAlpha({ Id = trait.TraitActiveOverlay, Duration = duration, Fraction = 0 })
	end
	if args.RemoveAfterHidden then
		wait( duration )
		TraitUIRemove( trait )
	end
end

function UpdateTraitSummary( args )

	args = args or {}

	local traitCount = HUDScreen.Components.TraitCount
	local metaUpgradeCount = HUDScreen.Components.MetaUpgradeCount
	local shrinePointCount = HUDScreen.Components.ShrinePointCount
	local bountyActive = HUDScreen.Components.BountyActive

	if not args.Show then
		if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
			SetAlpha({ Id = traitCount.Id, Fraction = 0, Duration = 0.2 })
			SetAlpha({ Id = metaUpgradeCount.Id, Fraction = 0, Duration = 0.2 })	
			SetAlpha({ Id = shrinePointCount.Id, Fraction = 0, Duration = 0.2 })
			SetAlpha({ Id = bountyActive.Id, Fraction = 0, Duration = 0.2 })
			return
		end

		if CurrentHubRoom ~= nil and not CurrentHubRoom.ShowShrinePoints then
			SetAlpha({ Id = traitCount.Id, Fraction = 0, Duration = 0.2 })
			SetAlpha({ Id = metaUpgradeCount.Id, Fraction = 0, Duration = 0.2 })
			SetAlpha({ Id = shrinePointCount.Id, Fraction = 0, Duration = 0.2 })
			SetAlpha({ Id = bountyActive.Id, Fraction = 0, Duration = 0.2 })
			return
		end
	end

	SetAlpha({ Id = traitCount.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
	if IsGameStateEligible( HUDScreen, ScreenData.TraitTrayScreen.ItemCategories[3].GameStateRequirements) then
		SetAlpha({ Id = metaUpgradeCount.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
	end
	local showingShrinePoints = false
	if IsGameStateEligible( HUDScreen, ScreenData.TraitTrayScreen.ItemCategories[4].GameStateRequirements ) then
		SetAlpha({ Id = shrinePointCount.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
		showingShrinePoints = true
	end
	if CurrentRun.ActiveBounty and CurrentHubRoom == nil then
		SetAlpha({ Id = bountyActive.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
		ModifyTextBox({ Id = bountyActive.Id, Text = CurrentRun.ActiveBounty, FadeTarget = 0.0, FadeOpacity = 0.0 })
		if not showingShrinePoints then
			bountyActive.OffsetX = shrinePointCount.X - bountyActive.X
			Teleport({ Id = bountyActive.Id, OffsetX = bountyActive.X + bountyActive.OffsetX, OffsetY = bountyActive.Y })
		end
	end

	wait( args.TextUpdateDelay )

	ModifyTextBox({ Id = traitCount.Id, ReReadTextImmediately = true, })
	ModifyTextBox({ Id = metaUpgradeCount.Id, ReReadTextImmediately = true, })
	ModifyTextBox({ Id = shrinePointCount.Id, ReReadTextImmediately = true, })

end