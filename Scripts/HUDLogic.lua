function UnblockCombatUI( flag )
	-- Don't want to show, just want to re-enable the option
	MapState.CombatUIHide[flag] = nil
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

	if CurrentHubRoom ~= nil and CurrentHubRoom.BlockCombatUI then
		return
	end

	ShowingCombatUI = true

	if not args.SkipUpdateTraitSummary then
		UpdateTraitSummary()
	end
	
	ShowHealthUI()
	ShowManaMeter()
	ShowAmmoUI()
	ShowStaffUI()
	ShowDaggerUI()
	ShowAxeUI()
	ShowTorchUI()
	ShowTraitUI()

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom or {}
	ShowResourceUIs()
	if not args.SkipObjectives then
		ShowObjectivesUI()
	end

	thread( HideAfterDelay )
end

function ShowResourceUIs( args )

	args = args or {}

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local offsetY = ConsumableUI.StartY
	if GetResourceAmount( "Money" ) > 0 or HUDScreen.Components.MoneyIcon.Id ~= nil then
		ShowMoneyUI( offsetY )
		offsetY = offsetY - ConsumableUI.SpacerY
	end
	if CurrentRun.NumRerolls and CurrentRun.NumRerolls > 0 or ScreenAnchors.Reroll ~= nil then
		ShowRerollUI( offsetY )
		offsetY = offsetY - ConsumableUI.SpacerY
	else
		HideRerollUI()
	end

	SetAlpha({ Id = HUDScreen.Components.ResourceBackingShadow.Id, Fraction = ConfigOptionCache.HUDOpacity * HUDScreen.Components.ResourceBackingShadow.ShowAlpha, Duration = HUDScreen.FadeInDuration })
	SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })

	if HUDScreen.Components.ToolIcon == nil then
		HUDScreen.Components.ToolIcon = CreateScreenComponent( UIData.ToolButton )
	end
	if GameState.EquippedToolName ~= nil then
		SetAnimation({ Name = ToolData[GameState.EquippedToolName].Icon, DestinationId = HUDScreen.Components.ToolIcon.Id })
		SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })
	else
		SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 0.0, Duration = 0 })
	end

	if GameState.EquippedFamiliar ~= nil then
		SetAnimation({ Name = FamiliarData[GameState.EquippedFamiliar].Icon, DestinationId = HUDScreen.Components.FamiliarIcon.Id })
		SetAlpha({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })
		UpdateFamiliarIconUses()
	else
		SetAlpha({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = 0.0, Duration = 0 })
	end
end

function UpdateFamiliarIconUses()
	ModifyTextBox({ 
		Id = HUDScreen.Components.FamiliarIcon.Id, 
		Text = "UI_Uses",
		LuaKey = "TempTextData", 
		LuaValue = { Time = GameState.FamiliarUses },
	})
end

OnPlayerMoveStarted{
	function( args )
		killTaggedThreads( CombatUI.HideThreadName )
		if not ShowingCombatUI then
			ShowCombatUI( "AutoHide" )
		end
	end
}

OnPlayerMoveStopped{
	function( args )
		StartHideAfterDelayThread()
	end
}

OnControlPressed{ "Rush Attack1 Attack2 Attack3 AutoLock Shout",
	function ( args )
		StartHideAfterDelayThread()
	end
}

function StartHideAfterDelayThread()
	thread( HideAfterDelay )
	if not ShowingCombatUI then
		ShowCombatUI( "AutoHide" )
	end
end

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
	HideMoneyUI( args )
	HideRerollUI( args )
	HideResourceUIs( args )

	HideManaMeter( args )
	if not args.SkipHideObjectives then
		thread( HideObjectivesUI, args )
	end
	HideHealthUI( args )
	thread( HideAmmoUI, args )
	thread( HideStaffUI, args )
	thread( HideDaggerUI, args )
	thread( HideAxeUI, args )
	thread( HideTorchUI, args )

	killTaggedThreads( CombatUI.HideThreadName )
end

function HideResourceUIs( args )
	args = args or {}
	SetAlpha({ Id = HUDScreen.Components.ResourceBackingShadow.Id, Fraction = 0, Duration = HUDScreen.FadeOutDuration })
	SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = 0, Duration = args.FadeDuration or HUDScreen.FadeOutDuration })
	SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 0, Duration = args.FadeDuration or HUDScreen.FadeOutDuration })
	SetAlpha({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = 0, Duration = args.FadeDuration or HUDScreen.FadeOutDuration })
end

function RecreateLifePips()
	if not IsEmpty( ScreenAnchors.LifePipIds ) then
		Destroy({ Ids = ScreenAnchors.LifePipIds })
	end
		
	ScreenAnchors.LifePipIds = {}
	local numLastStands = 0
	if CurrentRun.Hero.IsDead then
		numLastStands = TableLength( CurrentRun.Hero.LastStands ) + GetNumMetaUpgradeLastStands()
	elseif CurrentRun.Hero.MaxLastStands then
		numLastStands = CurrentRun.Hero.MaxLastStands
	end
	for i = 1, numLastStands do
		local obstacleId = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup,
			X = HUDScreen.LastStandX + (i * HUDScreen.LastStandSpacingX),
			Y = ScreenHeight - HUDScreen.LastStandBottomOffset,
			Scale = HUDScreen.LastStandScale,
		})
		local pipSubtitleFormat = ShallowCopyTable( ScreenData.HUD.LastStandTextFormat )
		pipSubtitleFormat.Id = obstacleId
		CreateTextBox( pipSubtitleFormat)
		SetAnimation({ Name = "ExtraLifeEmpty", DestinationId = obstacleId })
		table.insert( ScreenAnchors.LifePipIds, obstacleId )
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
		for i, lifePipId in pairs( ScreenAnchors.LifePipIds ) do
			local lastStandData = unit.LastStands[i]
			local icon = "ExtraLifeEmpty"
			if lastStandData then
				icon = lastStandData.Icon
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
		local numLastStands = TableLength( CurrentRun.Hero.LastStands ) + GetNumMetaUpgradeLastStands()
		for i, lifePipId in pairs( ScreenAnchors.LifePipIds ) do
			if i <= numLastStands then
				local lastStandData = unit.LastStands[i]
				local icon = "ExtraLifeStyx"
				if lastStandData then
					icon = lastStandData.Icon
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

function ShowHealthUI()
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	RecreateLifePips()

	local healthFraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth

	
	SetAnimationFrameTarget({ Name = "HPBarFalloff", Fraction = 1 - healthFraction, DestinationId = HUDScreen.Components.HealthFalloff.Id, Instant = true })
	SetAnimationFrameTarget({ Name = "HPBarFill", Fraction = 1 - healthFraction, DestinationId = HUDScreen.Components.HealthFill.Id, Instant = true })

	local healthIds = {}
	local healthComponents = { "HealthBack", "HealthFalloff", "HealthFill", "HealthBuffer" } -- "HealthFlash", }
	
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
	SetAlpha({ Ids = healthIds, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })

	UpdateHealthUI( { FalloffDelay = 0.0 } )
	
end

function UpdateHealthUI( args )
	local unit = CurrentRun.Hero
	if unit == nil then
		return
	end
	local currentHealth = unit.Health
	local maxHealth = unit.MaxHealth
	if currentHealth == nil or maxHealth == nil then
		return
	end
	if HUDScreen == nil then
		return
	end

	args = args or {}

	local healthBackId = HUDScreen.Components.HealthBack.Id
	ModifyTextBox({ Id = healthBackId, Text = "UI_PlayerHealth", LuaKey = "TempTextData", LuaValue = { Current = math.ceil(currentHealth), Maximum = math.ceil(maxHealth) }, AutoSetDataProperties = false } )

	local healthFill = HUDScreen.Components.HealthFill
	SetAnimationFrameTarget({ Name = "HPBarFill", Fraction = 1 - (currentHealth / maxHealth), DestinationId = HUDScreen.Components.HealthFill.Id,
		Duration = healthFill.UpdateDuration, EaseIn = healthFill.UpdateEaseIn, EaseOut = healthFill.UpdateEaseOut })

	local healthBufferId = HUDScreen.Components.HealthBuffer.Id
	if unit.HealthBuffer ~= nil and unit.HealthBuffer > 0 then
		local armorFraction = unit.HealthBuffer / maxHealth
		if armorFraction > 1.0 then
			armorFraction = 1.0
		end
		if ShowingCombatUI then
			SetAlpha({ Id = healthBufferId, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.1 })
		end
		SetAnimationFrameTarget({ Name = "HPBarArmorFill", Fraction = armorFraction, DestinationId = healthBufferId, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
		ModifyTextBox({ Id = healthBufferId, Text = "UI_HealthBuffer", LuaKey = "TempTextData", LuaValue = { Current = math.ceil(unit.HealthBuffer), AutoSetDataProperties = false } })
	else
		SetAlpha({ Id = healthBufferId, Fraction = 0.0, Duration = 0.1 })
		ModifyTextBox({ Id = healthBufferId, Text = "UI_HealthBuffer", LuaKey = "TempTextData", LuaValue = { Current = 0, AutoSetDataProperties = false } })
	end

	local healthFalloff = HUDScreen.Components.HealthFalloff
	waitUnmodified( args.FalloffDelay or healthFalloff.UpdateDelay )
	SetAnimationFrameTarget({ Name = "HPBarFalloff", Fraction = 1 - (currentHealth / maxHealth), DestinationId = healthFalloff.Id,
		Duration = healthFalloff.UpdateDuration, EaseIn = healthFalloff.UpdateEaseIn, EaseOut = healthFalloff.UpdateEaseOut })
end

function HideHealthUI( args )
	local healthIds = {}
	local healthComponents = { "HealthBack", "HealthFalloff", "HealthFill", "HealthBuffer", "HealthFlash", "HealthHighIndicator", "HealthLowIndicator" }
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
	ClearHealthShroud()
	CreateVignette()
end

function UpdateResourceUI( resourceName, newValue )
	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		return
	end
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], Text = newValue, AutoSetDataProperties = false, })
end

function ShowRerollUI()
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end
	ModifyTextBox({ Id = HUDScreen.Components.RerollIcon.Id, Text = CurrentRun.NumRerolls, AutoSetDataProperties = false, })
	SetAlpha({ Id = HUDScreen.Components.RerollIcon.Id, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
end

function HideRerollUI( args )
	SetAlpha({ Id = HUDScreen.Components.RerollIcon.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
end

function UpdateRerollUI( newValue )
	ModifyTextBox({ Id = HUDScreen.Components.RerollIcon.Id, Text = newValue, AutoSetDataProperties = false, })
end

function ShowMoneyUI( offsetY )
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, Text = GetResourceAmount( "Money" ), AutoSetDataProperties = false, })
	SetAlpha({ Id = ScreenAnchors.MoneyDelta, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	SetAlpha({ Id = HUDScreen.Components.MoneyIcon.Id, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
end

function HideMoneyUI( args )
	args = args or {}
	SetAlpha({ Id = ScreenAnchors.MoneyDelta, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
	SetAlpha({ Id = HUDScreen.Components.MoneyIcon.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
end

function UpdateMoneyUI( )
	local newValue = GetResourceAmount( "Money" )
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
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

function ShowAmmoUI()

	if not CurrentRun.Hero.Weapons.WeaponLob then
		return
	end
	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		return
	end
	ScreenAnchors.AmmoIndicatorUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = HUDScreen.AmmoX, Y = ScreenHeight - HUDScreen.AmmoBottomOffset })
	SetAnimation({ Name = "WitchGrenadeIcon", DestinationId = ScreenAnchors.AmmoIndicatorUI})
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

	FadeObstacleIn({ Id = ScreenAnchors.AmmoIndicatorUI, Duration = HUDScreen.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Direction = 0 })
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
		HideObstacle({ Id = reloadId, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })
	end
	ScreenAnchors.AmmoIndicatorUI = nil
	ScreenAnchors.AmmoIndicatorUIReloads = nil

	wait( HUDScreen.FadeOutDuration, RoomThreadName )

	Destroy({ Ids = ids })
end

function ShowAxeUI( )

	if not HeroHasTrait("AxePerfectCriticalAspect") or not ShowingCombatUI then
		return
	end
	local trait = GetHeroTrait("AxePerfectCriticalAspect")

	if ScreenAnchors.AxeUI ~= nil then
		return
	end

	if ScreenAnchors.Shadow ~= nil then
		SetScaleX({ Id = ScreenAnchors.Shadow, Fraction = 1.3 })
	end

	ScreenAnchors.AxeUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = AxeUI.StartX, Y = ScreenHeight - AxeUI.BottomOffset })
	ScreenAnchors.AxeUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = AxeUI.StartX, Y = ScreenHeight - AxeUI.BottomOffset })

	local trait = GetHeroTrait("AxePerfectCriticalAspect")
	local currentCrit = round(trait.PerfectCritChance * 100, 1)
	local maxCrit = trait.ReportedMaxCrit * 100

	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount })
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = currentCrit/ maxCrit, Instant = true })
		
	SetAlpha({ Id = ScreenAnchors.AxeUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.AxeUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	CreateTextBox({
		Id = ScreenAnchors.AxeUI,
		OffsetX = 26, OffsetY = -2,
		Text = "UI_CritText",
		Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
		Justification = "Left",LuaKey = "TempTextData", LuaValue = { Amount = currentCrit }
		})
end

function UpdateAxeUI( trait ) 
	local currentCrit = round(trait.PerfectCritChance * 100, 1)
	local maxCrit = trait.ReportedMaxCrit * 100
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = currentCrit/ maxCrit, Instant = true })
	ModifyTextBox({ Id = ScreenAnchors.AxeUI, Text = "UI_CritText", LuaKey = "TempTextData", LuaValue = { Amount = currentCrit }})
end

function HideAxeUI( forceDestroy, args )
	if ScreenAnchors.AxeUI == nil then
		return
	end
	args = args or {}

	local id = ScreenAnchors.AxeUI
	HideObstacle({ Id = id, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })
	HideObstacle({ Id = ScreenAnchors.AxeUIChargeAmount, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })

	ScreenAnchors.AxeUI = nil
	ScreenAnchors.AxeUIChargeAmount = nil

	wait( HUDScreen.FadeOutDuration, RoomThreadName)
	Destroy({ Id = ScreenAnchors.AxeUIChargeAmount })
	Destroy({ Id = id })
	ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0, AutoSetDataProperties = false, })
end

function ShowTorchUI( )

	if not HeroHasTrait("LobImpulseAspect") or not ShowingCombatUI then
		return
	end

	if ScreenAnchors.TorchUI ~= nil then
		return
	end

	if ScreenAnchors.Shadow ~= nil then
		SetScaleX({ Id = ScreenAnchors.Shadow, Fraction = 1.3 })
	end
	ScreenAnchors.TorchUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = TorchUI.StartX, Y = ScreenHeight - TorchUI.BottomOffset })

	ScreenAnchors.TorchUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = TorchUI.StartX, Y = ScreenHeight - TorchUI.BottomOffset })

	local trait = GetHeroTrait("LobImpulseAspect")
	local currentCharge = trait.Charge
	local maxCharge = trait.OnEnemyDamagedAction.Args.MaxCharge
	local currentChargeText = round( currentCharge, 1)
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.TorchUIChargeAmount })
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.TorchUIChargeAmount, Fraction = currentCharge/ maxCharge, Instant = true })
		
	if trait.Charge >= trait.OnEnemyDamagedAction.Args.MaxCharge then
		SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.TorchUI })
	end

	SetAlpha({ Id = ScreenAnchors.TorchUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.TorchUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
end

function UpdateTorchUI( trait ) 
	local currentCharge = trait.Charge
	local maxCharge = trait.OnEnemyDamagedAction.Args.MaxCharge
	local currentChargeText = round( currentCharge, 1)
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.TorchUIChargeAmount, Fraction = currentCharge/ maxCharge, Instant = true })
end

function HideTorchUI( forceDestroy, args )
	if ScreenAnchors.TorchUI == nil then
		return
	end
	args = args or {}

	local id = ScreenAnchors.TorchUI
	HideObstacle({ Id = id, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })
	HideObstacle({ Id = ScreenAnchors.TorchUIChargeAmount, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })

	ScreenAnchors.TorchUI = nil
	ScreenAnchors.TorchUIChargeAmount = nil

	wait( HUDScreen.FadeOutDuration, RoomThreadName)
	Destroy({ Id = ScreenAnchors.TorchUIChargeAmount })
	Destroy({ Id = id })
	ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0, AutoSetDataProperties = false, })
end

function ShowDaggerUI()

	if not HeroHasTrait("DaggerBlockAspect") or not ShowingCombatUI then
		return
	end
	local trait = GetHeroTrait("DaggerBlockAspect")

	if ScreenAnchors.DaggerUI ~= nil then
		return
	end

	if ScreenAnchors.Shadow ~= nil then
		SetScaleX({ Id = ScreenAnchors.Shadow, Fraction = 1.3 })
	end

	ScreenAnchors.DaggerUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = DaggerUI.StartX, Y = ScreenHeight - DaggerUI.BottomOffset })
	ScreenAnchors.DaggerUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = DaggerUI.StartX, Y = ScreenHeight - DaggerUI.BottomOffset })
	
	local trait = GetHeroTrait("DaggerBlockAspect")
	local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown
	
	if not CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and SessionState.GlobalCooldowns.DaggerBlockShield then
		local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.DaggerBlockShield)	
		
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, PlaySpeed = 101/totalTime })
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, StartFrameFraction = 1 - remainingTime/totalTime })
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1 })
	else
		SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.DaggerUI })
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount})
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1, Instant = true })
	end
	SetAlpha({ Id = ScreenAnchors.DaggerUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.DaggerUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
end

function UpdateDaggerUI()
	local trait = GetHeroTrait("DaggerBlockAspect")
	local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown
	if not CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and SessionState.GlobalCooldowns.DaggerBlockShield then
		
		local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.DaggerBlockShield)
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, StartFrameFraction = 1 - remainingTime/totalTime })
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, PlaySpeed = 101/totalTime })
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1 })
	else
		SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount})
		SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.DaggerUIChargeAmount, Fraction = 1, Instant = true })
	end

end

function HideDaggerUI( forceDestroy, args )
	if ScreenAnchors.DaggerUI == nil then
		return
	end
	args = args or {}

	local id = ScreenAnchors.DaggerUI
	HideObstacle({ Id = id, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })
	HideObstacle({ Id = ScreenAnchors.DaggerUIChargeAmount, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })
	ScreenAnchors.DaggerUI = nil
	ScreenAnchors.DaggerUIChargeAmount = nil

	wait( HUDScreen.FadeOutDuration, RoomThreadName)
	Destroy({ Id = ScreenAnchors.DaggerUIChargeAmount })
	Destroy({ Id = id })
	ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0, AutoSetDataProperties = false, })
end

function ShowStaffUI( )

	if not HeroHasTrait("StaffClearCastAspect") or not ShowingCombatUI then
		return
	end
	local trait = GetHeroTrait("StaffClearCastAspect")

	if ScreenAnchors.StaffUI ~= nil then
		return
	end

	if ScreenAnchors.Shadow ~= nil then
		SetScaleX({ Id = ScreenAnchors.Shadow, Fraction = 1.3 })
	end

	ScreenAnchors.StaffUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = StaffUI.StartX, Y = ScreenHeight - StaffUI.BottomOffset })
	ScreenAnchors.StaffUIChargeAmount = CreateScreenObstacle({ Name = "BlankObstacle", Group = HUDScreen.ComponentData.DefaultGroup, X = StaffUI.StartX, Y = ScreenHeight - StaffUI.BottomOffset })

	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.StaffUIChargeAmount })
	local currentHits = MapState.StaffClearCountHits or 0
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.StaffUIChargeAmount, Fraction = currentHits/ trait.OnEnemyDamagedAction.Args.RequiredCount, Instant = true })
	
	SetAlpha({ Id = ScreenAnchors.StaffUI, Duration = 0, Fraction = 0 })
	SetAlpha({ Id = ScreenAnchors.StaffUI, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })

end

function HideStaffUI( forceDestroy, args )
	if ScreenAnchors.StaffUI == nil then
		return
	end
	args = args or {}

	local id = ScreenAnchors.StaffUI
	HideObstacle({ Id = id, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })
	HideObstacle({ Id = ScreenAnchors.StaffUIChargeAmount, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, SmoothStep = true })

	ScreenAnchors.StaffUI = nil
	ScreenAnchors.StaffUIChargeAmount = nil

	wait( HUDScreen.FadeOutDuration, RoomThreadName)
	Destroy({ Id = ScreenAnchors.StaffUIChargeAmount })
	Destroy({ Id = id })
	ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0, AutoSetDataProperties = false, })
end

function ShowManaMeter()

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
	SetAlpha({ Ids = componentIds, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })
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
	--local maxAvailableFillPercent =  maxAvailableMana / CurrentRun.Hero.MaxMana
	local reservedManaFraction = (CurrentRun.Hero.MaxMana - maxAvailableMana) / CurrentRun.Hero.MaxMana

	local manaMeterBackId = HUDScreen.Components.ManaMeterBack.Id
	ModifyTextBox({ Id = manaMeterBackId, Text = "UI_ManaText",
		LuaKey = "TempTextData",
		LuaValue = { Current = math.floor(CurrentRun.Hero.Mana), AvailableMaximum = maxAvailableMana, RealMaximum = CurrentRun.Hero.MaxMana }
	})

	SetAnimationFrameTarget({ Name = "ManaBarFill", Fraction = 1 - fillPercent, DestinationId = HUDScreen.Components.ManaMeterFill.Id, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
	
	if maxAvailableMana ~= CurrentRun.Hero.MaxMana then
		ModifyTextBox({ Id = HUDScreen.Components.ManaMeterReserve.Id, Text = "UI_ManaReservedText",
			LuaKey = "TempTextData",
			LuaValue = { ReservedMana = math.min(CurrentRun.Hero.MaxMana, CurrentRun.Hero.MaxMana - maxAvailableMana), Current = math.floor(CurrentRun.Hero.Mana), AvailableMaximum = maxAvailableMana, RealMaximum = CurrentRun.Hero.MaxMana}
		})
		-- SetScaleX({ Id = HUDScreen.Components.ManaMeterReserve.Id, Fraction = -reservedManaFraction, Duration = 0.2 })
		SetAnimationFrameTarget({ Name = "ManaBarReserveFill", Fraction = reservedManaFraction, DestinationId = HUDScreen.Components.ManaMeterReserve.Id, Duration = 0.2, EaseIn = 0.66, EaseOut = 0.88 })
	end

	local lowManaPercent = ScreenData.HUD.ComponentData.ManaLowIndicator.LowManaThreshold / CurrentRun.Hero.MaxMana
	local offsetX = 526 * lowManaPercent - 263
	local offsetY = ScreenData.HUD.ComponentData.ManaLowIndicator.BarOffset
	Attach({ Id = HUDScreen.Components.ManaLowIndicator.Id, DestinationId = HUDScreen.Components.ManaMeterBack.Id, OffsetX = offsetX, OffsetY = offsetY })
	UIScriptsDeferred.ManaMeterDirty = false
end

function GetTraitWithSlot( traits, slot )
	for k, trait in pairs( traits ) do
		if trait.Slot == slot then
			return trait
		end
	end
	return nil
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
	SetAlpha({ Ids = slotIconIds, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })

	TraitUIActivateTraits()
end

function HUDShowTrait( trait, args )
	args = args or {}

	if not args.ForceShow and trait.HideInHUD then
		return
	end

	if trait.AnchorId ~= nil then
		SetAlpha({ Id = trait.AnchorId, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
		UseableOn({ Id = trait.AnchorId })
	end
	if trait.TraitInfoCardId ~= nil then
		SetAlpha({ Id = trait.TraitInfoCardId, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	end
	if trait.TraitIconOverlay ~= nil then
		SetAlpha({ Id = trait.TraitIconOverlay, Duration = args.FadeDuration or HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })
	end
	if trait.TraitActiveOverlay ~= nil then
		SetAlpha({ Id = trait.TraitActiveOverlay, Duration = args.FadeDuration or HUDScreen.FadeOutDuration, Fraction = ConfigOptionCache.HUDOpacity })
	end
	if trait.Slot == "Spell" then
		CreateSpellHUD(trait)
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

	local traitComponent = CreateScreenComponent({ Name = "TraitTrayIconButton", X = locationX, Y = locationY, Group = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup, Scale = 0.5 })
	AttachLua({ Id = traitComponent.Id, Table = traitComponent })
	traitComponent.TraitData = trait
	traitComponent.ActiveOffsetIndex = activeOffsetIndex
	traitComponent.OffsetX = locationX
	traitComponent.OffsetY = locationY
	traitComponent.PinIconScale = 0.26
	traitComponent.PinIconFrameScale = 0.27
	traitComponent.HighlightAnimScale = 0.27
	traitComponent.TrayHighlightAnimScale = 1.0
	trait.AnchorId = traitComponent.Id
	SetAnimation({ Name = GetTraitIcon( trait ), DestinationId = trait.AnchorId })	
	if container ~= nil then
		container[traitComponent.Id] = traitComponent
	end
	SetAlpha({ Id = trait.AnchorId, Fraction = 0, Duration = 0 })

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
	for k, existingTrait in pairs( CurrentRun.Hero.Traits ) do
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
	local yOffset = 0
	local traitCount = GetTraitCount( CurrentRun.Hero, { TraitData = trait } )
	local time = trait.RemainingUses or trait.Uses
	if trait.RarityUpgradeData then
		time = trait.RarityUpgradeData.Uses
	end
	local hasSubtitle = ( time ~= nil ) or ( traitCount > 1) or ( trait.Slot == "Keepsake" ) or ( trait.Slot == "Assist" ) or ( trait.RoomsPerUpgrade and IsTraitActive( trait ) ) or ( trait.CustomLabel )

	if not hasSubtitle then
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0.2 })
		return
	end

	if trait.TraitInfoCardId == nil then
		trait.TraitInfoCardId = CreateScreenObstacle({ Name = "TraitTray_LevelBacking", Group = "Combat_Menu_TraitTray_Labels" })
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 1, Duration = args.FadeDuration or 0.2 })
		Attach({ Id = trait.TraitInfoCardId, DestinationId = anchorId, OffsetY = 40 })
	else
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 1, Duration = args.FadeDuration or 0.2 })	
	end
	if trait.Slot == "Keepsake" or trait.Slot == "Assist" then
		SetAnimation({ DestinationId = trait.TraitInfoCardId, Name = "KeepsakeRank" .. GetKeepsakeLevel( trait.Name ), Scale = 1.25 })
		yOffset = yOffset + 15
	end
	if trait.CustomLabel then
		local textData = {}
		if trait.CustomLabel.DisplayType == "SessionMapStateValue" then
			textData.Value = SessionMapState[trait.CustomLabel.Key]
		end
		if trait.CustomLabel.MultiplyByRarity and trait.RarityMultiplier then
			textData.Value = textData.Value * trait.RarityMultiplier
		end
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = trait.CustomLabel.Text, Font = "NumericP22UndergroundSCMedium",
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
		elseif ( trait.UsesAsRooms and trait.RemainingUses ~= nil ) then
			CreateTextBox({ Id = trait.TraitInfoCardId,
				Text = "UI_Time", Font = "P22UndergroundSCMedium",
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				FontSize = 22,
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center", LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time)},
			})
			xOffset = xOffset + 40
		elseif ( trait.RemainingUses ~= nil or trait.Uses ~= nil ) and not trait.UsesAsRooms then
			if traitCount > 1 then
				time = 0
				for i, ownedTrait in pairs(CurrentRun.Hero.Traits) do
					if ownedTrait.Name == trait.Name then
						if ownedTrait.RemainingUses then
							time = time + ownedTrait.RemainingUses
						elseif ownedTrait.Uses then
							time = time + ownedTrait.Uses
						end
					end
				end
			end

			CreateTextBox({
				Id = trait.TraitInfoCardId,
				Text = "UI_Uses",
				Font = "NumericP22UndergroundSCMedium", 
				FontSize = 22,
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center",
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
			})
			xOffset = xOffset + 40
		end
	elseif IsTraitActive(trait) and trait.RoomsPerUpgrade and trait.CurrentRoom then
		local countdown = trait.RoomsPerUpgrade.Amount - trait.CurrentRoom
		local text = "UI_Time"
		if trait.RoomsPerUpgrade.Rarity and (CurrentRun.Hero.UpgradeableTraitCountCache or 0) <= 0 then
			text = "HUD_NoEligibleUpgrades"
		elseif trait.RoomsPerUpgrade.DowngradeRarity and (CurrentRun.Hero.DowngradableTraitCountCache or 0) <= 0 then
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
			Justification = "Center",
			LuaKey = "TempTextData",
			LuaValue = { Time = trait.DoorHealReserve },
		})
	elseif traitCount > 1 then
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = "UI_TraitLevel",
			Font = "LatoBold", FontSize = 19,
			Color = Color.White,
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset, OffsetY = 1,
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

function TraitUIActivateTraits()

	thread( UpdateSpellActiveStatus )
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		local thresholdData = traitData.LowHealthThresholdText
		if thresholdData ~= nil then
			if thresholdData.Threshold and CurrentRun.Hero.Health <= thresholdData.Threshold then
				TraitUIActivateTrait( traitData )
			end
			if thresholdData.ThresholdFraction and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction then
				TraitUIActivateTrait( traitData )
			end
		end
		
		thresholdData = traitData.HighHealthThresholdText
		if thresholdData ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth >= thresholdData.PercentThreshold then
			TraitUIActivateTrait( traitData )
		end
		if not CurrentRun.CurrentRoom.BlockClearRewards then
			local currentRoom = CurrentRun.CurrentRoom
			local perfectClearDamageData = traitData.PerfectClearDamageBonus
			if not CurrentRun.Hero.IsDead and perfectClearDamageData ~= nil then
				if currentRoom and currentRoom.Encounter ~= nil and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed and not currentRoom.Encounter.PlayerTookDamage then
					TraitUIActivateTrait( traitData )
				end
			end
			local fastClearData = traitData.FastClearSpeedBonus
			if fastClearData ~= nil then
				if not CurrentRun.Hero.IsDead and currentRoom and currentRoom.Encounter ~= nil and currentRoom.Encounter.StartTime and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed then
					local currentEncounter = currentRoom.Encounter
					local elapsedTime = _worldTime - currentEncounter.StartTime
					local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
					TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitSingle", PlaySpeed = 30 / clearTimeThreshold })
					local existingTraitData = GetExistingUITrait( traitData )
					SetAnimation({ Name = "ActiveTraitSingle", StartFrameFraction = 1 - elapsedTime/clearTimeThreshold, DestinationId = existingTraitData.TraitActiveOverlay })
				end
			end
		end
	end
	for _, traitName in pairs({"HephaestusWeaponBoon", "HephaestusSpecialBoon"}) do
		if HeroHasTrait(traitName) then
			local traitData = GetHeroTrait( traitName )
			local damagedActionArgs = traitData.OnEnemyDamagedAction.Args
			if not CheckCooldownNoTrigger( damagedActionArgs.Name, damagedActionArgs.Cooldown, true ) and SessionState.GlobalCooldowns[damagedActionArgs.Name] then
				local totalTime = damagedActionArgs.Cooldown
				local elapsedTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns[damagedActionArgs.Name])
				TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / totalTime })
				local existingTraitData = GetExistingUITrait( traitData )
				SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - elapsedTime/totalTime, DestinationId = existingTraitData.TraitActiveOverlay })
			else
				TraitUIActivateTrait( traitData )
			end
		end
	end

	if HeroHasTrait("DaggerBlockAspect") then
		local trait = GetHeroTrait("DaggerBlockAspect")
		local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown
		if not CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and SessionState.GlobalCooldowns.DaggerBlockShield then
			local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.DaggerBlockShield)
			TraitUIActivateTrait( trait , { CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / totalTime })
			SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - remainingTime/totalTime, DestinationId = trait.TraitActiveOverlay })
		end
	end
	if HeroHasTrait("HadesInvisibilityRetaliateBoon") then
		local trait = GetHeroTrait("HadesInvisibilityRetaliateBoon")
		local totalTime = trait.OnSelfDamagedFunction.FunctionArgs.Cooldown
		if not CheckCooldownNoTrigger("HadesRetaliate", totalTime) and SessionState.GlobalCooldowns.HadesRetaliate then
			local remainingTime = totalTime - ( _worldTime - SessionState.GlobalCooldowns.HadesRetaliate)
			TraitUIActivateTrait( trait , { CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / totalTime })
			SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - remainingTime/totalTime, DestinationId = trait.TraitActiveOverlay })
		end
	end
	
	if HeroHasTrait("ChaosTimeCurse") or ( HeroHasTrait("TimedBuffKeepsake") and not CurrentRun.Hero.IsDead) then
		local traits = {}
		if HeroHasTrait("ChaosTimeCurse") then
			table.insert(traits, GetHeroTrait("ChaosTimeCurse"))
		end
		if HeroHasTrait("TimedBuffKeepsake") then
			table.insert(traits, GetHeroTrait("TimedBuffKeepsake"))
		end
		for _, trait in pairs(traits) do
			local currentTime = trait.CurrentTime
			local totalTime = trait.StartingTime
			TraitUIActivateTrait( trait , { CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / totalTime })
			if IsBiomeTimerPaused() or HasTimerBlock( CurrentRun ) then
				SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = 1 - currentTime/totalTime, DestinationId = trait.TraitActiveOverlay, Instant = true })
			else
				SetAnimation({ Name = "ActiveTraitCooldownNoFlash", StartFrameFraction = 1 - currentTime/totalTime, DestinationId = trait.TraitActiveOverlay })
				SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = 1, DestinationId = trait.TraitActiveOverlay})
			end
		end
	end

	if HeroHasTrait("SpellPotionTrait") then
		local traitData = GetHeroTrait("SpellPotionTrait")
		if traitData.RemainingUses <= 0 then
			TraitUIActivateTrait( traitData, {CustomAnimation = "InactiveTrait" })
		end
	end
	if HeroHasTrait("TimedKillBuffBoon") then
		local traitData = GetHeroTrait("TimedKillBuffBoon")
		UpdateTraitNumber( traitData )
	end
end

function TraitUIActivateTrait( trait, args )
	args = args or {}
	local customAnimation = args.CustomAnimation or "ActiveTrait"
	local playSpeed = args.PlaySpeed
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData == nil then
		return
	end
	if existingTraitData.TraitActiveOverlay == nil then
		existingTraitData.TraitActiveOverlay = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier", Group = args.GroupName or HUDScreen.ActiveTraitGroup })
		Attach({ Id = existingTraitData.TraitActiveOverlay, DestinationId = existingTraitData.AnchorId })
	end
	SetAnimation({ Name = customAnimation, DestinationId = existingTraitData.TraitActiveOverlay, PlaySpeed = playSpeed })
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
	elseif not args.CheckingOverrides and not IsTraitActive( trait ) then
		if trait.RarityUpgradeData and trait.RarityUpgradeData.Uses == 0 then
			return trait.Name .. "_NoUpgradeUses"
		end
		return trait.Name .. "_Inactive"
	elseif trait.CustomDescriptionFunctionName ~= nil and _G[trait.CustomDescriptionFunctionName] ~= nil then
		local traitCustomArgs = trait.CustomDescriptionFunctionArgs
		for index, t in ipairs(traitCustomArgs) do
			if IsGameStateEligible( CurrentRun, trait, t.GameStateRequirements ) then
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

	if trait.CustomTitle then
		return trait.CustomTitle
	else
		if trait.OnExpire ~= nil and trait.OnExpire.TraitData ~= nil then
			return GetDisplayName({ Text = "ChaosCombo_"..trait.Name.."_"..trait.OnExpire.TraitData.Name })
		elseif trait.LastCurseName and trait.LastBlessingName then
			return GetDisplayName({ Text = "ChaosCombo_"..trait.LastCurseName.."_"..trait.LastBlessingName })
		else
			return trait.Name
		end
	end
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

	local traitComponent = HUDScreen.ActiveTraitComponents[trait.AnchorId]
	HUDScreen.ActiveTraitComponents[trait.AnchorId] = nil

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
				local ids = CollapseTable( { otherTraitComponent.TraitData.AnchorId, otherTraitComponent.TraitData.TraitInfoCardId, otherTraitComponent.TraitData.TraitInfoUsesId, otherTraitComponent.TraitData.TraitIconOverlay, otherTraitComponent.TraitData.TraitActiveOverlay } )
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
	if trait.AnchorId ~= nil then
		SetAlpha({ Id = trait.AnchorId, Duration = args.FadeOutDuration or HUDScreen.FadeOutDuration, Fraction = 0 })
		UseableOff({ Id = trait.AnchorId })
	end
	if trait.TraitInfoCardId ~= nil then
		SetAlpha({ Id = trait.TraitInfoCardId, Duration = args.FadeOutDuration or HUDScreen.FadeOutDuration, Fraction = 0 })
	end
	if trait.TraitInfoUsesId ~= nil then
		SetAlpha({ Id = trait.TraitInfoUsesId, Duration = args.FadeOutDuration or HUDScreen.FadeOutDuration, Fraction = 0 })
	end
	if trait.TraitIconOverlay ~= nil then
		SetAlpha({ Id = trait.TraitIconOverlay, Duration = args.FadeOutDuration or HUDScreen.FadeOutDuration, Fraction = 0 })
	end
	if trait.TraitActiveOverlay ~= nil then
		SetAlpha({ Id = trait.TraitActiveOverlay, Duration = args.FadeOutDuration or HUDScreen.FadeOutDuration, Fraction = 0 })
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
	if IsGameStateEligible( CurrentRun, HUDScreen, ScreenData.TraitTrayScreen.ItemCategories[2].GameStateRequirements) then
		SetAlpha({ Id = metaUpgradeCount.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
	end
	if IsGameStateEligible( CurrentRun, HUDScreen, ScreenData.TraitTrayScreen.ItemCategories[3].GameStateRequirements ) then
		SetAlpha({ Id = shrinePointCount.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
	end
	if CurrentRun.ActiveBounty and CurrentHubRoom == nil then
		SetAlpha({ Id = bountyActive.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
		ModifyTextBox({ Id = bountyActive.Id, Text = CurrentRun.ActiveBounty, FadeTarget = 0.0, FadeOpacity = 0.0 })
	end

	wait( args.TextUpdateDelay )

	ModifyTextBox({ Id = traitCount.Id, ReReadTextImmediately = true, })
	ModifyTextBox({ Id = metaUpgradeCount.Id, ReReadTextImmediately = true, })
	ModifyTextBox({ Id = shrinePointCount.Id, ReReadTextImmediately = true, })

end