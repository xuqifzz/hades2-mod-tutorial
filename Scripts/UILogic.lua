--[[ * UI LIBRARY * ]]

function SetupFormatContainers( triggerArgs )
	if SessionState.FormattersParsed == nil or (triggerArgs and triggerArgs.HotLoad ) then
		for formatName, formatTable in pairs( TextFormats ) do
			formatTable.Name = formatName
			formatTable.AutoSetDataProperties = true
			CreateFormatContainer( formatTable )
		end
		SessionState.FormattersParsed = true
	end
end

OnPreThingCreation
{
	function( triggerArgs )
		-- References survive to objects that cannot survive a load
		ScreenState = {}
		ScreenState.ActiveObjectives = {}
		ScreenState.TraitAddedPresentationQueue = ScreenState.TraitAddedPresentationQueue or {}
		ScreenAnchors = {}
		ScreenAnchors.CallLock = {}
		ActiveScreens = {}
		ActiveScreenOrder = {}

		EnemyHealthDisplayAnchors = {}
		GamepadCursorRequests = {}
		UIScriptsDeferred =
		{ 
			ManaMeterDirty = false
		}
	end
}

OnPreThingCreation
{
	function( triggerArgs )
		SetupFormatContainers( triggerArgs )
	end
}

OnAnyLoad
{
	function( triggerArgs )
		if GameState ~= nil then
			HUDScreen = DeepCopyTable( ScreenData.HUD )
			CreateScreenFromData( HUDScreen, HUDScreen.ComponentData )
		end
	end
}

function DeferredUIScripts()
	if UIScriptsDeferred.ManaMeterDirty then
		UpdateManaMeterUIReal()
	end
	if UIScriptsDeferred.ElementalCountDirty and not UIScriptsDeferred.IgnoreElementalCountDirty then
		thread( ElementalTraitUpdatedPresentationReal )
	end
	if UIScriptsDeferred.KillBuffDirty then
		local trait = GetHeroTrait( "TimedKillBuffBoon" )
		if trait then
			UpdateTraitNumber( trait )	
		end
		UIScriptsDeferred.KillBuffDirty = nil
	end
end

OnMenuOpened{ "PauseScreen",
	function( triggerArgs )
		SessionMapState.IsPaused = true
		SessionState.PrevEasyMode = ConfigOptionCache.EasyMode
		SessionState.PrevShowGameplayTimer = ConfigOptionCache.ShowGameplayTimer
		PauseSpeech({ })
		if SessionMapState.PauseMusicOnPauseScreen then
			PauseMusic()
		end
		if SessionMapState.PauseMenuTakeoverCue ~= nil then
			PlaySound({ Name = "/SFX/TimeSlowStart" })
		end
	end
}

OnMenuCloseFinished{ "PauseScreen",
	function( triggerArgs )
		
		SessionMapState.IsPaused = nil
		thread( PauseMenuTakeoverClosed )

		ResumeSpeech({ })
		if SessionMapState.PauseMusicOnPauseScreen then
			ResumeMusic()
		end

		if SessionState.PrevEasyMode ~= ConfigOptionCache.EasyMode then
			if ConfigOptionCache.EasyMode then
				if not HeroHasTrait( "GodModeTrait") and ScreenAnchors.TraitBacking then
					AddTraitToHero({ TraitName = "GodModeTrait" })
				end
				if CurrentHubRoom == nil then
					CurrentRun.EasyModeLevel = GameState.EasyModeLevel
				end
				EasyModeEnabledPresentation()
			else
				if CurrentRun.Hero then
					while HeroHasTrait( "GodModeTrait" ) do
						RemoveTrait( CurrentRun.Hero, "GodModeTrait" )
					end
				end
				EasyModeDisabledPresentation()
			end
		end
		thread( MarkObjectiveComplete, "EasyModePrompt" )

		if SessionState.PrevShowGameplayTimer ~= ConfigOptionCache.ShowGameplayTimer then
			if ConfigOptionCache.ShowGameplayTimer then
				GameplayTimerEnabledPresentation()
			else
				GameplayTimerDisabledPresentation()
			end
		end
	end
}

OnMenuCloseFinished{ "AnnouncementScreen",
	function( triggerArgs )
		notifyExistingWaiters( "AnnouncementScreen" )
	end
}

OnMenuOpened{ "MiscSettingsScreen",
	function( triggerArgs )
		TempTextData = { Resistance = round( (1.0 - CalcEasyModeMultiplier() ) * 100 ) }
	end
}

function GetLowHealthUIThreshold( maxHealth )
	maxHealth = maxHealth or CurrentRun.Hero.MaxHealth
	local healthThreshold = maxHealth * HealthUI.LowHealthThreshold
	if HealthUI.LowHealthMaximum ~= nil then
		healthThreshold = math.min( healthThreshold, HealthUI.LowHealthMaximum )
	end
	if HealthUI.LowHealthMinimum ~= nil then
		healthThreshold = math.max( healthThreshold, HealthUI.LowHealthMinimum )
	end
	if maxHealth <= healthThreshold then
		healthThreshold = maxHealth - 1
	end
	return healthThreshold
end

function ShowRunIntro()

	-- skip this except for every fourth run since the last remembrance
	local completedRuns = GetCompletedRuns()
	if GameState.LastRemembranceCompletedRunCount ~= nil then
		if completedRuns - GameState.LastRemembranceCompletedRunCount < 4 then
			return
		end
	else
		-- proceed
	end

	local currentRun = CurrentRun
	local eligibleRunIntroData = {}
	local eligibleUnplayedRunIntroData = {}
	for index, entryData in pairs( RunIntroData ) do
		if entryData.GameStateRequirements == nil or IsGameStateEligible( entryData, entryData.GameStateRequirements ) then
			table.insert( eligibleRunIntroData, entryData )
			if not GameState.PlayedRandomRunIntroData[entryData.Header] then
				table.insert( eligibleUnplayedRunIntroData, entryData )
			end
		end
	end

	if IsEmpty( eligibleRunIntroData ) then
		return
	end

	AddTimerBlock( currentRun, "RunIntro" )

	local runIntroData = nil
	if IsEmpty( eligibleUnplayedRunIntroData ) then
		-- All played, start the record over
		for index, entryData in pairs( RunIntroData ) do
			GameState.PlayedRandomRunIntroData[entryData.Header] = nil
		end
		runIntroData = GetRandomValue( eligibleRunIntroData )
	else
		runIntroData = GetRandomValue( eligibleUnplayedRunIntroData )
	end
	GameState.PlayedRandomRunIntroData[runIntroData.Header] = true

	RunInterstitialPresentation( runIntroData )
	GameState.LastRemembranceCompletedRunCount = completedRuns

	RemoveTimerBlock( currentRun, "RunIntro" )

end

function ClearHealthShroud()
	if ScreenAnchors.HealthShroudAnchor == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.HealthShroudAnchor })
	ScreenAnchors.HealthShroudAnchor = nil
end

function CreateHealthShroud()
	if ScreenAnchors.HealthShroudAnchor ~= nil then
		return
	end
	ScreenAnchors.HealthShroudAnchor = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI_World", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetAnimation({ DestinationId = ScreenAnchors.HealthShroudAnchor, Name = "LowHealthShroud"})
end

function DestroyHealthShroud()
	if ScreenAnchors.HealthShroudAnchor == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.HealthShroudAnchor })
	ScreenAnchors.HealthShroudAnchor = nil
end

OnActiveUseTarget{
	function( triggerArgs )
		if triggerArgs.AutoActivate then
			return
		end
		local useTarget = triggerArgs.AttachedTable
		SessionMapState.ActiveUseTarget = useTarget
		if CanReceiveGift( useTarget ) then
			SessionMapState.ActiveGiftableUseTarget = true
			if not GetConfigOptionValue({ Name = "UseMouse" }) then
				AddControlBlock( "Shout", "ActiveUseTarget" )
			end
		elseif useTarget ~= nil and useTarget.RerollFunctionName ~= nil and CurrentRun.NumRerolls > 0 and useTarget.CanBeRerolled then
			if not GetConfigOptionValue({ Name = "UseMouse" }) then
				AddControlBlock( "Shout", "ActiveUseTarget" )
			end
		end
		ShowUseButton( triggerArgs.triggeredById, useTarget )
	end
}

OnActiveUseTargetLost{
	function( triggerArgs )
		if triggerArgs.AutoActivate then
			return
		end
		SessionMapState.ActiveUseTarget = nil
		SessionMapState.ActiveGiftableUseTarget = nil
		RemoveControlBlock( "Shout", "ActiveUseTarget" )
		
		local useTarget = triggerArgs.AttachedTable
		HideUseButton( triggerArgs.triggeredById or triggerArgs.PrevUseTargetId, useTarget )
	end
}

function GetUseText( useTarget )

	if useTarget == nil then
		return ConstantsData.DefaultUseText
	end

	if useTarget.GetUseTextFunctionName ~= nil then
		return CallFunctionName( useTarget.GetUseTextFunctionName, useTarget, useTarget.GetUseTextFunctionArgs )
	end

	local customUseText = nil

	if useTarget.UnlockedUseText ~= nil and MapState.OfferedExitDoors[useTarget.ObjectId] ~= nil then
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) and CheckSpecialDoorRequirement( useTarget ) == nil then
			if useTarget.RerollFunctionName ~= nil and CurrentRun.NumRerolls > 0 and HasHeroTraitValue( "AllowDoorReroll" ) then
				if useTarget.CanBeRerolled then
					customUseText = useTarget.UnlockedUseTextReroll
				else
					customUseText = useTarget.UnlockedUseTextCannotReroll
				end
			else
				customUseText = useTarget.UnlockedUseText
			end
		elseif useTarget.HideUseIfLocked then
			return nil
		end
	end

	if useTarget.AggroedEnemyUseText ~= nil then
		if not IsEmpty( RequiredKillEnemies ) or IsAggroedUnitBlockingInteract() then
			return useTarget.AggroedEnemyUseText
		end
	end

	if useTarget.BlockedLootInteractionText ~= nil and not CurrentRun.CurrentRoom.AlwaysAllowLootInteraction then
		for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy.BlocksLootInteraction then
				return useTarget.BlockedLootInteractionText
			end
		end
	end

	if useTarget.FamiliarUseText ~= nil then
		if useTarget.LinkedToolName ~= nil and HasFamiliarTool( useTarget.LinkedToolName ) and IsComplexHarvestAllowed() then
			customUseText = useTarget.FamiliarUseText
		end
	end
	
	if useTarget.EncounterCost ~= nil then
		if useTarget.EncounterCostStarted then
			customUseText = useTarget.EncounterCostStartedUseText
		else
			customUseText = useTarget.EncounterCostUseText
		end
	end

	if useTarget.LockedUseText ~= nil and MapState.OfferedExitDoors[useTarget.ObjectId] ~= nil then
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) and CheckSpecialDoorRequirement( useTarget ) ~= nil then
			customUseText = useTarget.LockedUseText
		end
	end

	if useTarget.UseIneligibleText ~= nil and useTarget.OnUsedGameStateRequirements ~= nil and not IsGameStateEligible( useTarget, useTarget.OnUsedGameStateRequirements ) then
		return useTarget.UseIneligibleText
	end

	local canTalk = false
	if useTarget.OnUsedFunctionName == "UseNPC" then
		if useTarget.AlwaysShowDefaultUseText or useTarget.NextInteractLines ~= nil then
			canTalk = true
		end
	elseif useTarget.OnUsedFunctionName ~= nil and ( useTarget.OnUsedGameStateRequirements == nil or IsGameStateEligible( useTarget, useTarget.OnUsedGameStateRequirements ) ) then
		canTalk = true
	elseif not IsEmpty( useTarget.OnUseEvents ) then
		canTalk = true
	end

	local canGift = CanReceiveGift( useTarget )
	local canAssist = CanSpecialInteract( useTarget )

	if useTarget.TalkOnlyIfNoGiftOrSpecial then
		if canGift or canAssist then
			canTalk = false
		end
	end

	--DebugPrint({ Text = "canTalk = "..tostring(canTalk) })
	--DebugPrint({ Text = "canGift = "..tostring(canGift) })
	--DebugPrint({ Text = "canAssist = "..tostring(canAssist) })

	if canTalk and canGift and canAssist then
		return useTarget.UseTextTalkGiftAndSpecial or "NPCUseTextTalkGiftAndSpecial"
	elseif canTalk and canAssist then
		return useTarget.UseTextTalkAndSpecial or "NPCUseTextTalkAndSpecial"
	elseif canGift and canAssist then
		return useTarget.UseTextGiftAndSpecial or "NPCUseTextGiftAndSpecial"
	elseif canTalk and canGift then
		return useTarget.UseTextTalkAndGift or "NPCUseTextTalkAndGift"
	elseif canTalk then
		return customUseText or useTarget.UseTextTalk or useTarget.UseText or "NPCUseTextTalk"
	elseif canGift then
		return useTarget.UseTextGift or "NPCUseTextGift"
	elseif canAssist then
		return useTarget.UseTextSpecial or "NPCUseTextSpecial"
	end

	return nil

end

function ShowUseButton( objectId, useTarget )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if ScreenAnchors.UsePrompts == nil then
		ScreenAnchors.UsePrompts = {}
	end

	if useTarget == nil then
		return
	end
	if useTarget.UnuseableWhenDead and useTarget.IsDead then
		return
	end

	if ScreenAnchors.UsePrompts[objectId] ~= nil then
		return
	end
	if not IsEmpty( ActiveScreens ) then
		return
	end

	if not IsAlive({ Id = objectId }) then
		return
	end

	if useTarget.ShowUseButtonEvents ~= nil then
		RunEventsGeneric( useTarget.ShowUseButtonEvents, useTarget )
	end

	if useTarget.RefreshExtractValuesOnApproach and useTarget.ExtractValues ~= nil then
		ExtractValues( CurrentRun.Hero, useTarget, useTarget )
	end
	if GetTotalHeroTraitValue( "MetaConversionUses" ) > 0 and useTarget.MetaConversionEligible then
		local maxUses = 0
		if HeroHasTrait("MetaToRunMetaUpgrade") then
			maxUses = GetHeroTrait("MetaToRunMetaUpgrade").RarityMultiplier
		end
		useTarget.ConvertAmount = GetTotalHeroTraitValue( "MetaConversionUses" )
		useTarget.ConvertMaxAmount = maxUses
	end
	
	if CanGoldifyReward( useTarget ) then
		useTarget = ShallowCopyTable(useTarget)
		local maxUses = 0
		if HeroHasTrait("MetaToRunMetaUpgrade") then
			maxUses = GetHeroTrait("MetaToRunMetaUpgrade").RarityMultiplier
		end
		useTarget.UseTextTalkAndSpecial = useTarget.UseTextTalkAndSpecial or "UseLootAndConsume"
		useTarget.UseTextTalkGiftAndSpecial = useTarget.UseTextTalkGiftAndSpecial or "UseLootGiftAndConsume"
		if useTarget.ReplaceSpecialForGoldify then
			useTarget.UseTextTalkAndSpecial = "UseLootAndConsume"
			useTarget.UseTextTalkGiftAndSpecial = "UseLootGiftAndConsume"
		end
		useTarget.GoldGain = GetRewardGoldifyValue( useTarget )
		useTarget.ConvertAmount = GetTotalHeroTraitValue( "MetaConversionUses" )
		useTarget.ConvertMaxAmount = maxUses
	end

	local useText = GetUseText( useTarget )
	if useText == nil then
		return
	end

	local offset = {}
	offset.X = useTarget.UsePromptOffsetX or 0
	offset.Y = useTarget.UsePromptOffsetY or 0
	ScreenAnchors.UsePrompts[objectId] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX + UIData.UsePrompt.CenterOffsetX, Y = ScreenHeight - UIData.UsePrompt.BottomOffset })
	if UIData.UsePrompt.AttractAnim ~= nil then
		SetAnimation({ Name = UIData.UsePrompt.AttractAnim, DestinationId = ScreenAnchors.UsePrompts[objectId], OffsetX = 0, OffsetY = 0 })
	end

	local textBox = ShallowCopyTable( UIData.UsePrompt.TextFormat )
	textBox.Id = ScreenAnchors.UsePrompts[objectId]
	textBox.Text = useText
	textBox.LuaKey = "TempTextData"
	textBox.LuaValue = useTarget
	textBox.AutoSetDataProperties = false
	textBox.OffsetY = -80
	textBox.TextSymbolScale = useTarget.UseTextSymbolScale or textBox.TextSymbolScale
	CreateTextBox( textBox )

end

function HideUseButton( objectId, useTarget, fadeDuration )

	if ScreenAnchors.UsePrompts == nil then
		return
	end

	if ScreenAnchors.UsePrompts[objectId] == nil then
		return
	end

	local anchorId = ScreenAnchors.UsePrompts[objectId]
	ScreenAnchors.UsePrompts[objectId] = nil

	fadeDuration = fadeDuration or 0.25
	ModifyTextBox({ Id = anchorId, FadeTarget = 0.0, FadeDuration = fadeDuration, AutoSetDataProperties = false, })
	if UIData.UsePrompt.AttractAnimOff ~= nil then
		SetAnimation({ Name = UIData.UsePrompt.AttractAnimOff, DestinationId = anchorId })
	end
	wait( fadeDuration, RoomThreadName )

	Destroy({ Id = anchorId })

end

function HideAllUseButtons()
	if not IsEmpty(ScreenAnchors.UsePrompts) then
		for i, id in pairs(ScreenAnchors.UsePrompts) do
			SetAlpha({ Id = id, Fraction = 0, Duration = 0.1 })
			ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0.1})
		end
	end
end

function ShowAllUseButtons()
	if not IsEmpty(ScreenAnchors.UsePrompts) then
		for i, id in pairs(ScreenAnchors.UsePrompts) do
			SetAlpha({ Id = id, Fraction = 1, Duration = 0.1 })
			ModifyTextBox({ Id = id, FadeTarget = 1, FadeDuration = 0.1})
		end
	end
end

function RefreshUseButton( objectId, useTarget )
	if ScreenAnchors ~= nil and ScreenAnchors.UsePrompts~= nil and ScreenAnchors.UsePrompts[objectId] ~= nil then
		HideUseButton( objectId, useTarget, 0 )
		ShowUseButton( objectId, useTarget )
	end
end

function CreateScreenComponent( params )
	local component = ShallowCopyTable( params )
	component.Id = CreateScreenObstacle( component )
	return component
end

function GetAllIds( components )
	local componentIds = {}
	for k, component in pairs( components ) do
		table.insert( componentIds, component.Id )
	end
	return componentIds
end

function GetComponentById( components, id )
	for k, component in pairs( components ) do
		if component.Id == id then
			return component
		end
	end
	return nil
end

function GetComponentByHotkey( components, hotkey )
	for k, component in pairs( components ) do
		if component.ControlHotkey == hotkey then
			return component
		end
		if component.MouseControlHotkeys ~= nil and GetConfigOptionValue({ Name = "UseMouse" }) and Contains( component.MouseControlHotkeys, hotkey ) then
			return component
		end
		if component.ControlHotkeys ~= nil and Contains( component.ControlHotkeys, hotkey ) then
			return component
		end
	end
	return nil
end

function CreateScreenObstacle( params )

	if params.X == nil and params.Y == nil then
		params.X = ScreenCenterX
		params.Y = ScreenCenterY
	end

	params.Group = params.Group or "Events"
	params.Animation = params.Animation or params.AnimationName

	local obstacleId = SpawnScreenObstacle( params )

	if (params.TimeModifierFraction or 1.0) ~= 1.0 then
		SetThingProperty({ Property = "TimeModifierFraction", DataValue = false, Value = params.TimeModifierFraction, DestinationId = obstacleId })
	end

	if params.ThingProperties ~= nil then
		for key, value in pairs( params.ThingProperties ) do
			SetThingProperty({ Property = key, Value = value, DestinationId = obstacleId })
		end
	end

	return obstacleId

end

function DisableWeapons()
	SessionMapState.WeaponsDisabled = true
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
		local weaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponNames ~= nil then
			for k, linkedWeaponName in ipairs( weaponNames ) do
				if MapState.EquippedWeapons[linkedWeaponName] then
					SetWeaponProperty({ WeaponName = linkedWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
				end
			end
		end
	end
	for k, weaponName in ipairs( WeaponSets.HeroNonPhysicalWeapons ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
		local weaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponNames ~= nil then
			for k, linkedWeaponName in ipairs( weaponNames ) do
				if MapState.EquippedWeapons[linkedWeaponName] then
					SetWeaponProperty({ WeaponName = linkedWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
				end
			end
		end
	end
	ToggleCombatControl( { "Reload", } , false )
end

function OnScreenOpened( screen, args )

	args = args or {}

	GameState.ScreensViewed[screen.Name] = true
	CurrentRun.ScreenViewRecord[screen.Name] = (CurrentRun.ScreenViewRecord[screen.Name] or 0) + 1

	ActiveScreens[screen.Name] = screen
	table.insert( ActiveScreenOrder, screen.Name )
	SetConfigOption({ Name = "ScreenEdgeIndicatorOpacity", Value = 0.0 })
	HideAllUseButtons()
	ZeroMouseTether( screen.Name )
	FreezePlayerUnit( screen.Name, screen.FreezePlayerArgs )
	EnableGamepadCursor( screen.Name )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetConfigOption({ Name = "LuaGCStepSize", Value = 50.0 })
	if not args.SkipBlockTimer then
		AddTimerBlock( CurrentRun, screen.Name, { MapState = true } )
	end
	thread( GenericScreenOpenStartPresentation, screen )
end

function IsScreenOpen( screenName )
	return ActiveScreens[screenName] ~= nil
end

function GetTopScreen()
	local topScreenName = ActiveScreenOrder[#ActiveScreenOrder]
	return ActiveScreens[topScreenName]
end

function OnScreenCloseStarted( screen, args )
	screen.Closing = true
	screen.KeepOpen = false -- Halt reading input
	DisableGamepadCursor( screen.Name )
	GenericScreenClosePresentation( screen )
end

function OnScreenCloseFinished( screen, args )

	args = args or {}
	ActiveScreens[screen.Name] = nil
	RemoveValueAndCollapse( ActiveScreenOrder, screen.Name )

	UnfreezePlayerUnit( screen.Name )
	UnzeroMouseTether( screen.Name )
	RemoveTimerBlock( CurrentRun, screen.Name )

	CombatUI.AutoHideEnabled = true
	thread( StartHideAfterDelayThread )

	if not screen.SkipQuestStatusCheck and IsEmpty( ActiveScreens ) then
		thread( CheckQuestStatus )
	end

	if IsEmpty( ActiveScreens ) then
		ShowAllUseButtons()
		SetConfigOption({ Name = "UseOcclusion", Value = true })
		for i, defaultOption in pairs( GamepadNavigationDefaults ) do
			SetConfigOption({ Name = defaultOption, Value = "Default" })
		end
	else
		local topScreen = GetTopScreen()
		if topScreen ~= nil then
			SetGamepadNavigation( topScreen )
		end
	end

	if screen.OnCloseFinishedThreadedFunctionName ~= nil then
		thread( CallFunctionName, screen.OnCloseFinishedThreadedFunctionName, screen, screen.OnCloseFinishedThreadedFunctionArgs )
	end
	if screen.OnCloseFinishedFunctionName ~= nil then
		CallFunctionName( screen.OnCloseFinishedFunctionName, screen, screen.OnCloseFinishedFunctionArgs )
	end

	GenericScreenCloseFinishedPresentation( screen )

	if IsEmpty( ActiveScreens ) then
		SetConfigOption({ Name = "ScreenEdgeIndicatorOpacity", Value = 1.0 })
		SetConfigOption({ Name = "LuaGCStepSize", Value = "Default" })
		-- RunGC({ })
	end

end

function IsPauseBlocked()

	if SessionMapState.HandlingDeath or SessionMapState.BlockPause then
		return true
	end

	if CurrentRun ~= nil then
		if CurrentRun.Hero.FishingStarted then
			return true
		end
	end

	for screenName, screen in pairs( ActiveScreens ) do
		if screen.BlockPause then
			return true
		end
	end

	-- @deprecated Use BlockPause value in ScreenData for above
	local blockingScreens =
	{
		"Codex", "MetaUpgrade", "ShrineUpgrade", "MusicPlayer", "QuestLog", "Mutator", "GhostAdmin", "AwardMenu", "RunClear", "RunHistory", "GameStats", "TraitTrayScreen", "WeaponUpgradeScreen",
		"InventoryScreen", "MarketScreen", "WeaponShop",
		"DebugEnemySpawn", "DebugConversations",
	}
	for k, name in pairs( blockingScreens ) do
		if ActiveScreens[name] then
			return true
		end
	end

	return false

end

function GetComponentDataByName( screen, dataName )
	if screen == nil or screen.ComponentData == nil then
		return nil
	end

	if dataName == nil then
		return nil -- Assert?
	end

	-- Breadth-first search
	local queue = { screen.ComponentData }
	while #queue > 0 do
		local node = table.remove( queue, 1 )
		for componentName, data in pairs( node ) do
			if componentName == dataName then
				-- DebugPrint({ Text="Found ComponentData for: "..dataName })
				return data
			end
			if type(data) == "table" and data.Children ~= nil then
				table.insert( queue, data.Children )
			end
		end

	end
end

function OnLanguageChanged( args )
	-- Warning: this can be called from the shell
	if ActiveScreens ~= nil then
		for screenName, screen in pairs( ActiveScreens ) do
			if screen.Components then
				if screenName == "Codex" and ActiveScreens.Codex.Components[screen.OpenEntryName] ~= nil then
					CodexOpenEntry( screen, ActiveScreens.Codex.Components[screen.OpenEntryName], { AutoOpen = true, LanguageChanged = true } )
				elseif screenName == "InventoryScreen" and screen.LineHistorySetup == true and screen.ActiveCategoryIndex == 6 then
					ModifyTextBox({ Id = screen.Components.LineHistory.Id, ClearText = true })
					screen.LineHistorySetup = false
					thread( InventoryScreenDisplayLineHistory, screen )
				end
				for componentName, component in pairs( screen.Components ) do
					if component.Id then
						local langData = {}
						local componentData = nil
						if component.ComponentName ~= nil and screen.ComponentData ~= nil then
							componentData = DeepCopyTable( GetComponentDataByName( screen, component.ComponentName ) )
						elseif component.Data ~= nil then
							componentData = component.Data
						end
						if componentData ~= nil then
							-- Check if we have any Lang* properties and copy only those changes to langData
							if componentData.TextArgs ~= nil then
								componentData = componentData.TextArgs
							end
							for k, v in pairs( componentData ) do
								if componentData["Lang"..k] ~= nil then
									local val = GetLocalizedValue( v, componentData["Lang"..k] )
									langData[k] = val
									langData.AutoSetDataProperties = true
								end
							end

						end
						ModifyTextBox(MergeTables({ 
							Id = component.Id, 
							UseLastHelpTextIdOrDefaultText = true,
							UseDefaultFont = true,
							UseDefaultScale = true,
							ReReadTextImmediately = true,
						}, langData))
					end
				end
			elseif IsScreenOpen( "Dialog" ) and screen.BackgroundId ~= nil then
				ModifyTextBox({ 
					Id = screen.BackgroundId, 
					UseLastHelpTextIdOrDefaultText = true,
					UseDefaultFont = true,
					UseDefaultScale = true,
					ReReadTextImmediately = true,
				})
			end
		end
	end
end

function SetCameraFocusOverride()
	UIData.CameraFocusOverride = true
	SetConfigOption({ Name = "ZeroMouseTether", Value = false })
end

function ClearCameraFocusOverride()
	UIData.CameraFocusOverride = false
	SetConfigOption({ Name = "ZeroMouseTether", Value = false })
	if not IsEmpty(UIData.ZeroMouseFlags) then
		SetConfigOption({ Name = "ZeroMouseTether", Value = true })
	end
end

function ZeroMouseTether( flag )
	UIData.ZeroMouseFlags[flag] = true
	if not UIData.CameraFocusOverride then
		SetConfigOption({ Name = "ZeroMouseTether", Value = true })
	end
end

function UnzeroMouseTether( flag )
	UIData.ZeroMouseFlags[flag] = nil
	if IsEmpty(UIData.ZeroMouseFlags) then
		SetConfigOption({ Name = "ZeroMouseTether", Value = false })
	end
end

function AreScreensActive( flag )
	if flag == nil then
		if ScreenState.InTransition then
			return true
		end
		return not IsEmpty( ActiveScreens )
	end
	return ActiveScreens[flag] ~= nil
end

function AreScreensInactiveExcluding( flags )
	for flag in pairs( ActiveScreens ) do
		if not Contains( flags, flag ) then
			return false
		end
	end
	return true
end

function FreezePlayerUnit( flag, args )
	if not CurrentRun or not CurrentRun.Hero then
		return
	end
	
	args = args or { DisableTray = true  }
	local disabledKeys = { "Use", "Move", "Rush", "Shout", "Assist", "Attack1", "Attack2", "Attack3", "AutoLock", "Gift", "Emote", "Reload", }
	if args.DisableTray then
		table.insert( disabledKeys, "AdvancedTooltip" )
	end
	if args.DisableCodex then
		table.insert( disabledKeys, "Codex" )
	end
	if args.DisableInventory then
		table.insert( disabledKeys, "Inventory" )
	end
	if args.AllowedKeys then
		for i, allowedKey in pairs(args.AllowedKeys) do
			RemoveValue( disabledKeys, allowedKey)
		end
	end

	ToggleCombatControl( disabledKeys, false, flag )
	TogglePlayerMove( false, flag )
	Stop({ Id = CurrentRun.Hero.ObjectId, StopRotation = args.StopRotation })
end

function UnfreezePlayerUnit( flag )
	if not CurrentRun or not CurrentRun.Hero then
		return
	end
	ClearCombatControlBlock( flag )
	TogglePlayerMove( true, flag ) 
end

function HandleScreenInput( screen )
	screen.KeepOpen = true
	while screen.KeepOpen do
		local notifyName = "ScreenInput"
		if screen.Name ~= nil then
			notifyName = notifyName..screen.Name
		end
		local buttonIds = {}
		local hotkeyControls = {}
		for k, component in pairs( screen.Components ) do
			if component.OnPressedFunctionName ~= nil then
				table.insert( buttonIds, component.Id )
			end
			if component.ControlHotkey ~= nil then
				table.insert( hotkeyControls, component.ControlHotkey )
			end
			if component.MouseControlHotkeys ~= nil and GetConfigOptionValue({ Name = "UseMouse" }) then
				for k, controlHotkey in pairs( component.MouseControlHotkeys ) do
					--DebugPrint({ Text = controlHotkey })
					table.insert( hotkeyControls, controlHotkey )
				end
			elseif component.ControlHotkeys ~= nil then
				for k, controlHotkey in pairs( component.ControlHotkeys ) do
					table.insert( hotkeyControls, controlHotkey )
				end
			end
		end
		NotifyOnInteractOrControlPressed({ Ids = buttonIds, Names = hotkeyControls, Notify = notifyName })
		waitUntil( notifyName )
		local acceptInput = true
		for screenName, otherScreen in pairs( ActiveScreens ) do
			if screen ~= otherScreen and otherScreen.IgnoreOtherScreenInput then
				acceptInput = false
			end
		end
		local inputBlockDuration = 0.05
		if acceptInput and IsInputAllowed({}) then
			local inputResult = NotifyResultsTable[notifyName]
			local button = nil
			if type(inputResult) == "string" then
				button = GetComponentByHotkey( screen.Components, inputResult )
			else
				button = GetComponentById( screen.Components, inputResult )
			end
			if button ~= nil and button.OnPressedFunctionName ~= nil and IsUseable({ Id = button.Id }) then
				if button.Sound ~= nil then
					PlaySound({ Name = button.Sound })
				end
				CallFunctionName( button.OnPressedFunctionName, screen, button )
			end
			if button ~= nil then
				inputBlockDuration = button.InputBlockDuration or inputBlockDuration
			end
		else
			DebugPrint({ Text = "input ignored for "..screen.Name })
		end
		wait( inputBlockDuration )
	end
end

function CloseScreen( componentIds, delay, screen, args )
	screen = screen or {}
	args = args or {}
	HideTopMenuScreenTooltips({ })
	ModifyTextBox({ Ids = componentIds, BlockTooltip = true })
	waitUnmodified( delay )
	local fadeOutTime = args.FadeOutTime or screen.FadeOutTime or 0.2
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime, EaseIn = 0, EaseOut = 1 })
	ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime, EaseIn = 0, EaseOut = 1 })
	waitUnmodified( args.CloseDestroyWait or screen.CloseDestroyWait or fadeOutTime )
	Destroy({ Ids = componentIds })
	ClearUseTarget({})
end

function CloseScreenButton( screen, button )
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0, screen )
	OnScreenCloseFinished( screen )
end

function DestroyScreenDataComponents( screen, componentData )
	for componentName, componentData in pairs( componentData or screen.ComponentData ) do
		local component = screen.Components[componentName]
		if component ~= nil then
			Destroy({ Id = component.Id })
		end
		if type(componentData) == "table" and componentData.Children ~= nil then
			DestroyScreenDataComponents( screen, componentData.Children )
		end
	end
end

function CreateComponentFromData( screenData, data, args )

	args = args or {}
	if data.BottomOffset ~= nil then
		data.Y = ScreenHeight - data.BottomOffset
	elseif data.Y ~= nil and (screenData.UseNativeScreenCenter or data.UseNativeScreenCenter or data.UseNativeScreenY) then
		data.Y = data.Y + ScreenCenterNativeOffsetY
	end

	if data.RightOffset ~= nil then
		data.X = ScreenWidth - data.RightOffset
	elseif data.PillarboxLeft then
		data.X = ScreenState.PillarboxLeftX
	elseif data.PillarboxRight then
		data.X = ScreenState.PillarboxRightX
	elseif data.X ~= nil and (screenData.UseNativeScreenCenter or data.UseNativeScreenCenter or data.UseNativeScreenX) then
		data.X = data.X + ScreenCenterNativeOffsetX
	end

	data.Name = data.Name or data.Graphic or "BlankObstacle"
	data.Group = data.Group or data.GroupName or args.DefaultGroup or screenData.DefaultGroup
	if data.Data ~= nil then
		OverwriteTableKeys( data, data.Data )
	end
	local component = CreateScreenComponent( data )
	component.Data = data
	
	if data.PillarboxLeft or data.PillarboxRight then
		data.ScaleX = (data.ScaleX or 1.0) * ScreenState.PillarboxScaleX
	end
	if data.UseScreenScaleX then
		data.ScaleX = (data.ScaleX or 1.0) * ScreenScaleX
	end
	if data.ScaleX ~= nil then
		SetScaleX({ Id = component.Id, Fraction = data.ScaleX })
	end
	if data.UseScreenScaleY then
		data.ScaleY = (data.ScaleY or 1.0) * ScreenScaleY
	end
	if data.ScaleY ~= nil then
		SetScaleY({ Id = component.Id, Fraction = data.ScaleY })
	end
	if data.FlipHorizontal then
		FlipHorizontal({ Id = component.Id })
	end

	if data.TooltipOffsetX then
		SetInteractProperty({ DestinationId = component.Id, Property = "TooltipOffsetX", Value = data.TooltipOffsetX })
	end

	if data.TooltipOffsetY then
		SetInteractProperty({ DestinationId = component.Id, Property = "TooltipOffsetY", Value = data.TooltipOffsetY })
	end

	if data.UseableOff then
		UseableOff({ Id = component.Id })
	end

	if data.Text or data.TextArgs then
		if data.TextArgs ~= nil and data.TextArgs.Format ~= nil then
			local textArgs = MergeTables( { Id = component.Id, Text = data.Text, }, data.TextArgs )
			CreateTextBoxWithFormat( textArgs )	
		else
			local textArgs = MergeTables( { Id = component.Id, Text = data.Text, }, data.TextArgs )
			CreateTextBox( ApplyLocalizedProperties( textArgs ) )	
		end
	end
	
	return component
end

function CreateScreenFromData( screen, componentData, args )

	args = args or {}
	local skipComponents = ToLookup( args.SkipComponents or {} )

	if componentData ~= nil then

		if componentData.Order ~= nil then
			for i, componentName in ipairs( componentData.Order ) do
				local data = componentData[componentName]
				if data ~= nil and not skipComponents[componentName] and (data.Requirements == nil or IsGameStateEligible( screen, data.Requirements ) ) then
					--DebugPrint({ Text = "componentName = "..componentName })
					if data.FunctionName ~= nil then
						CallFunctionName( data.FunctionName, screen, data )
					else
						local component = CreateComponentFromData( componentData, data, args )
						component.Screen = screen
						screen.Components[componentName] = component
						if data.Children ~= nil then
							AttachChildrenFromData( screen, component, data, componentData, args )
						end
					end
					data.Ordered = true
				end
			end
		end

		for name, data in pairs( componentData ) do
			--DebugPrint({ Text = "componentName = "..name })
			if type(data) == "table" and not data.Skip and not data.Ordered and name ~= "Ordered" and not skipComponents[name] and (data.Requirements == nil or IsGameStateEligible( screen, data.Requirements ) ) then
				local component = CreateComponentFromData( componentData, data, args )
				component.Screen = screen
				screen.Components[name] = component				
				if data.Children ~= nil then
					AttachChildrenFromData( screen, component, data, componentData, args )
				end
			end
		end

	end

	SetGamepadNavigation( screen )

end

function SetGamepadNavigation( screen )
	local optionsSet = {}
	if screen.GamepadNavigation ~= nil then
		for name, value in pairs( screen.GamepadNavigation ) do
			optionsSet[name] = true
			SetConfigOption({ Name = name, Value = value })
		end
	end
	for i, defaultOption in pairs( GamepadNavigationDefaults ) do
		if not optionsSet[defaultOption] then
			SetConfigOption({ Name = defaultOption, Value = "Default" })
		end
	end
end

function ApproximateStringWidth( text )
	local len = 0
	local curr = 1
	local delim = "\\n"
	local from = string.find( text, delim, curr )
	if from == nil then
		return utf8strlen( text )
	end
	while from do
		len = math.max(len, utf8strlen( string.sub( text, curr, from - 1 ) ))
		curr = curr + 1
		from = string.find( text, delim, curr )
	end
	return len
end

function AttachChildrenFromData( screen, parentComponent, childData, screenData, args )
	if childData.Children ~= nil then

		if childData.ChildrenOrder ~= nil then
			local accumOffsetX = 0
			for i, componentName in ipairs( childData.ChildrenOrder ) do
				local data = childData.Children[componentName]
				if data ~= nil and (data.Requirements == nil or IsGameStateEligible( screen, data.Requirements ) ) then
					data.ComponentName = componentName
					local component = CreateComponentFromData( screenData, data, args )
					component.Screen = screen
					screen.Components[componentName] = component
					if parentComponent.AutoAlignContextualButtons and data.TextArgs then
						Attach({ Id = component.Id, DestinationId = parentComponent.Id, OffsetX = accumOffsetX })
						local dataWidth = data.TextArgs.Width or UIData.ContextualButtonSpacing
						local label = GetDisplayName({ Text = data.Text })
						local labelAlt = GetDisplayName({ Text = data.AltText })
						local fontSize = data.TextArgs.FontSize or 20
						local len = math.max(ApproximateStringWidth( label ), ApproximateStringWidth( labelAlt ))

						if data.AltTexts ~= nil then
							for index, text in ipairs( data.AltTexts ) do
								len = math.max(len, ApproximateStringWidth( GetDisplayName({ Text = text }) )) 
							end
						end
						local approxTextSize = fontSize * len - UIData.AutoAlignContextualButtonGlyphWidth
						approxTextSize = math.max(approxTextSize, UIData.AutoAlignContextualButtonMinWidth)
						
						local spacing = math.min(dataWidth, approxTextSize) + UIData.AutoAlignContextualButtonSpacing
						-- Subtract for right-align, Add for left-align
						if parentComponent.AutoAlignJustification == "Left" then
							accumOffsetX = accumOffsetX + spacing
						elseif parentComponent.AutoAlignJustification == "Right" then
							accumOffsetX = accumOffsetX - spacing
						end
					else				
						Attach({ Id = component.Id, DestinationId = parentComponent.Id, OffsetX = data.OffsetX, OffsetY = data.OffsetY })
					end
					data.Ordered = true
					if data.Children ~= nil then
						AttachChildrenFromData( screen, component, data, screenData, args )
					end
				end
			end
		end

		for componentName, data in pairs( childData.Children ) do
			if not data.Ordered and (data.Requirements == nil or IsGameStateEligible( screen, data.Requirements ) ) then
				data.ComponentName = componentName
				local component = CreateComponentFromData( screenData, data, args )	
				component.Screen = screen
				screen.Components[componentName] = component
				Attach({ Id = component.Id, DestinationId = parentComponent.Id, OffsetX = data.OffsetX, OffsetY = data.OffsetY })
				if data.Children ~= nil then
					AttachChildrenFromData( screen, component, data, screenData, args )
				end
			end
		end
	end
end

function EnableGamepadCursor( flag )
	GamepadCursorRequests[flag] = flag
	SetConfigOption({ Name = "GamepadCursorControl", Value = true })
end

function DisableGamepadCursor( flag )
	GamepadCursorRequests[flag] = nil
	if IsEmpty( GamepadCursorRequests ) then
		SetConfigOption({ Name = "GamepadCursorControl", Value = false })
	end
end

function CreateTextBoxWithScreenFormat( screen, component, formatName, dynamicValues )
	component.FormatName = formatName
	component.Format = ShallowCopyTable( screen[formatName] )
	component.Format.Id = component.Id
	for key, value in pairs( dynamicValues ) do
		component.Format[key] = value
	end
	CreateTextBox( component.Format )
end

function CreateTextBoxWithFormat( args )

	local format = TextFormats[args.Format]
	DebugAssert({ Condition = format ~= nil, Text = "Asking for non-existent TextFormat ("..args.Format..")!" })
	local textBoxParams = MergeTables( format, ApplyLocalizedProperties( args ) )
	textBoxParams.AutoSetDataProperties = true
	CreateTextBox( textBoxParams )
	HotLoadInfo.TextBoxCache = HotLoadInfo.TextBoxCache or {}
	HotLoadInfo.TextBoxCache[args.Id] = args.Format

end

function CreateGroupHealthBar( encounter )

	encounter.HasHealthBar = true

	local xOffset = ScreenWidth / 2
	local yOffset = 0
	if ScreenAnchors.BossHealthTitles == nil then
		ScreenAnchors.BossHealthTitles = {}
	end

	ScreenAnchors.BossHealthBack = CreateScreenObstacle( {Name = "BossHealthBarBack", Group = "Combat_UI", X = xOffset , Y = 70 + yOffset })
	ScreenAnchors.BossHealthTitles[encounter.Name] = ScreenAnchors.BossHealthBack

	local fallOffBar = CreateScreenObstacle({Name = "BossHealthBarFillFalloff", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })
	SetColor({ Id = fallOffBar, Color = Color.HealthFalloff })
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 0, DestinationId = fallOffBar, Instant = true })
		
	local scorchBarId = CreateScreenObstacle({ Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })
	SetColor({ Id = scorchBarId, Color = Color.HealthScorch })

	ScreenAnchors.BossHealthFill = CreateScreenObstacle( {Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })

	CreateAnimation({ Name = "BossNameShadow", DestinationId = ScreenAnchors.BossHealthBack })

	SetScaleX({ Ids = { ScreenAnchors.BossHealthBack, ScreenAnchors.BossHealthFill, fallOffBar, scorchBarId }, Fraction = 1, Duration = 0 })

	local barName = EncounterData[encounter.Name].HealthBarTextId or encounter.Name

	CreateTextBox({ Id = ScreenAnchors.BossHealthBack, Text = barName,
			Font = "CaesarDressing", FontSize = 22, ShadowRed = 0, ShadowBlue = 0, ShadowGreen = 0,
			OutlineColor = {0, 0, 0, 1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 3, ShadowOffsetX = 0, Justification = "Center", OffsetY = -30,
			DataProperties =
			{
				OpacityWithOwner = false,
			},
		})

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 0, FadeDuration = 0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 1.0, Duration = 2.0 })
	EnemyHealthDisplayAnchors[encounter.Name.."back"] = ScreenAnchors.BossHealthBack

	encounter.HealthBarFill = "EnemyHealthBarFillBoss"
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1, DestinationId = scorchBarId })
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1, DestinationId = ScreenAnchors.BossHealthFill })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar, scorchBarId }, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar, scorchBarId }, Fraction = 1, Duration = 2.0 })
	EnemyHealthDisplayAnchors[encounter.Name] = ScreenAnchors.BossHealthFill
	EnemyHealthDisplayAnchors[encounter.Name.."falloff"] = fallOffBar
	EnemyHealthDisplayAnchors[encounter.Name.."scorch"] = scorchBarId
	thread( GroupHealthBarPresentation, encounter )
end

function GroupHealthBarPresentation( encounter )
	local screenId = EnemyHealthDisplayAnchors[encounter.Name]
	local fallOffBar = EnemyHealthDisplayAnchors[encounter.Name.."falloff"]
	local healthFraction = 0
	local bossHealthBarSoundId = PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraHealthFillUp", Id = screenId })
	SetColor({ Id = screenId, Color = Color.Red })
	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 1, FadeDuration = 2 })
	while healthFraction < encounter.GroupHealth / encounter.GroupMaxHealth do
		healthFraction = healthFraction + 0.01
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - healthFraction, DestinationId = screenId })
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 1 - healthFraction, DestinationId = fallOffBar, Instant = true })
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - healthFraction, DestinationId = scorchId })
		wait(0.005)
	end
	StopSound({ Id = bossHealthBarSoundId, Duration = 0.25 })
	UpdateHealthBar( encounter, 0, { Force = true } )
end

function CheckRemoveGroupHealthBar(encounter)

	local notifyName = encounter.Name.."GroupHealthBarDead"
	waitUntil( notifyName )

	if ScreenAnchors.BossHealthTitles ~= nil then
		DestroyTextBox({ Id = ScreenAnchors.BossHealthTitles[encounter.Name] })
		ScreenAnchors.BossHealthTitles[ encounter.Name ] = nil
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name.."back"] })
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name.."scorch"] })
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name] })
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name.."falloff"] })
	end
end

function CreateBossHealthBar( boss )
	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter ~= nil and encounter.UseGroupHealthBar ~= nil then
		if not boss.HasHealthBar then
			local offsetY = ConstantsData.DefaultHealthBarOffsetY
			boss.HasHealthBar = true
			if boss.Scale ~= nil then
				offsetY = offsetY * boss.Scale
			end
			if boss.HealthBarOffsetY then
				offsetY = boss.HealthBarOffsetY
			end
			-- Invisible health bar for effect purposes
			local screenId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = boss.ObjectId, Attach = true, OffsetY = offsetY, TriggerOnSpawn = false })
			EnemyHealthDisplayAnchors[boss.ObjectId] = screenId
		end
		if not encounter.HasHealthBar then
			CreateGroupHealthBar( encounter )
		end
		return
	end
	if boss.HasHealthBar then
		return
	end
	boss.HasHealthBar = true

	if ScreenAnchors.BossHealthTitles == nil then
		ScreenAnchors.BossHealthTitles = {}
	end
	local index = TableLength(ScreenAnchors.BossHealthTitles)
	local numBars = GetNumBossHealthBars()
	local yOffset = 0
	local xScale = 1 / numBars
	boss.BarXScale = boss.HealthBarScaleX or xScale
	local totalWidth = ScreenWidth * xScale
	local xOffset = boss.HealthBarLocationX or (( totalWidth / ( 2 * numBars )) * ( 1 + index * 2 ) + (ScreenWidth - totalWidth) / 2)
	if boss.HealthBarLocationX ~= nil then
		xOffset = xOffset + ScreenCenterNativeOffsetX
	end

	if numBars == 0 then
		return
	end

	ScreenAnchors.BossHealthBack = CreateScreenObstacle({ Name = "BossHealthBarBack", Group = "Combat_UI", X = xOffset , Y = 70 + yOffset })
	ScreenAnchors.BossHealthTitles[boss.ObjectId] = ScreenAnchors.BossHealthBack
	
	local fallOffBar = CreateScreenObstacle({ Name = "BossHealthBarFillFalloff", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })
	SetColor({ Id = fallOffBar, Color = Color.HealthFalloff })
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 0, DestinationId = fallOffBar, Instant = true })
	
	local scorchBarId = CreateScreenObstacle({ Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })
	SetColor({ Id = scorchBarId, Color = Color.HealthScorch })

	ScreenAnchors.BossHealthFill = CreateScreenObstacle({ Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })	
	
	CreateAnimation({ Name = "BossNameShadow", DestinationId = ScreenAnchors.BossHealthBack })

	SetScaleX({ Ids = { ScreenAnchors.BossHealthBack, ScreenAnchors.BossHealthFill, fallOffBar, scorchBarId }, Fraction = boss.BarXScale, Duration = 0 })
	
	local bossName = boss.HealthBarTextId or boss.Name

	if boss.AltHealthBarTextIds ~= nil then
		local eligibleTextIds = {}
		for k, altTextIdData in pairs( boss.AltHealthBarTextIds ) do
			if altTextIdData.GameStateRequirements == nil or IsGameStateEligible( altTextIdData, altTextIdData.GameStateRequirements ) then
				table.insert( eligibleTextIds, altTextIdData.TextId )
			end
		end
		if not IsEmpty(eligibleTextIds) then
			bossName = GetRandomValue(eligibleTextIds)
		end
	end

	CreateTextBox({ Id = ScreenAnchors.BossHealthBack, Text = bossName,
			Font = "CaesarDressing", FontSize = 22, ShadowRed = 0, ShadowBlue = 0, ShadowGreen = 0,
			OutlineColor = {0, 0, 0, 1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 3, ShadowOffsetX = 0, Justification = "Center", OffsetY = -30,
			DataProperties =
			{
				OpacityWithOwner = false,
			},
		})

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 0, FadeDuration = 0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 1.0, Duration = 2.0 })
	EnemyHealthDisplayAnchors[boss.ObjectId.."back"] = ScreenAnchors.BossHealthBack

	boss.HealthBarFill = "EnemyHealthBarFillBoss"
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = boss.Health / boss.MaxHealth, DestinationId = screenId })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar, scorchBarId }, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar, scorchBarId }, Fraction = 1, Duration = 2.0 })
	EnemyHealthDisplayAnchors[boss.ObjectId] = ScreenAnchors.BossHealthFill
	EnemyHealthDisplayAnchors[boss.ObjectId.."falloff"] = fallOffBar
	boss.ScorchHealthBarId = scorchBarId

	thread( BossHealthBarPresentation, boss )
end

function BossHealthBarPresentation( boss )
	local screenId = EnemyHealthDisplayAnchors[boss.ObjectId]
	local falloffId = EnemyHealthDisplayAnchors[boss.ObjectId.."falloff"]
	local scorchId = boss.ScorchHealthBarId
	local healthFraction = 0
	local bossHealthBarSoundId = PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraHealthFillUp", Id = screenId })
	if boss.HitShields > 0 then
		SetColor({ Id = screenId, Color = Color.HitShield})
	else
		SetColor({ Id = screenId, Color = Color.Red })
	end
	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 1, FadeDuration = 2 })
	boss.HealthBarLoading = true
	while healthFraction < boss.Health / boss.MaxHealth do
		healthFraction = healthFraction + 0.01
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - healthFraction, DestinationId = screenId })
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 1 - healthFraction, DestinationId = falloffId, Instant = true })
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - healthFraction, DestinationId = scorchId })
		wait(0.005)
	end
	boss.HealthBarLoading = nil
	StopSound({ Id = bossHealthBarSoundId, Duration = 0.25 })
	UpdateHealthBar( boss, 0, { Force = true } )
end

function CheckCallLock( name )
	if ScreenAnchors.CallLock[name] then
		return false
	end
	ScreenAnchors.CallLock[name] = true
	return true
end

function ReleaseCallLock( name )
	ScreenAnchors.CallLock[name] = nil
end

OnMouseOver{
	function( triggerArgs )
		local button = triggerArgs.TriggeredByTable
		if button == nil then
			return
		end
		if button.OnMouseOverFunctionName == nil then
			return
		end
		CallFunctionName( button.OnMouseOverFunctionName, button )
	end
}

OnMouseOff{
	function( triggerArgs )
		local button = triggerArgs.TriggeredByTable
		if button == nil then
			return
		end
		if button.OnMouseOffFunctionName == nil then
			return
		end
		CallFunctionName( button.OnMouseOffFunctionName, button )
	end
}

function AddResourceCostText( destinationId, resourceCostData, args )
	args = args or {}
	args.TextArgs = args.TextArgs or {}
	local costOffsetY = args.InitialYOffset or 0
	local costOffsetX = args.InitialXOffset or 0
	local costXStep = args.XSpacer or 0
	local costYStep = args.YSpacer or 0

	for _, resourceName in ipairs( ResourceDisplayOrderData ) do
		if resourceCostData[resourceName] then
			local costFontColor = args.AffordableColor or Color.White
			if not HasResource( resourceName, resourceCostData[resourceName] ) then
				costFontColor = args.UnaffordableColor or Color.CostUnaffordable
			end
			local text = args.CostText or "ResourceCost"
			CreateTextBox( 
				MergeTables(
				{ 
					Id = destinationId, 
					Text = text, 
					LuaKey = "TempTextData",
					LuaValue = { Current = GameState.Resources[resourceName] or 0, Amount = resourceCostData[resourceName], IconPath = ResourceData[resourceName].TextIconPath },
					OffsetY  = costOffsetY,
					OffsetX = costOffsetX,
					Color = costFontColor,
					DataProperties =
					{
						OpacityWithOwner = true,
					},
				},
				args.TextArgs ))
			costOffsetY = costOffsetY + costYStep
			costOffsetX = costOffsetX + costXStep
		end
	end
end

function AddResourceCostDisplay( screen, resourceCostData, args, source )
	
	args = args or {}
	
	local totalDisplayResources = 0
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if resourceCostData[resourceName] then
			totalDisplayResources = totalDisplayResources + 1
		end
	end

	if verboseLogging then
		ResourceDisplayOrderDataLookup = ResourceDisplayOrderDataLookup or ToLookup( ResourceDisplayOrderData )
		for resourceName, resourceeAmount in pairs( resourceCostData ) do
			if not ResourceDisplayOrderDataLookup[resourceName] then
				DebugAssert({ Condition = false, Text = resourceName.." not found in ResourceDisplayOrderData" })
			end
		end
	end

	local numColumns = math.min( totalDisplayResources, args.ItemsPerRow or 999 )
	local totalWidth = (args.SpacerX or 0) * ( numColumns - 1 )
	local startX = (args.StartX or ScreenCenterX) - (totalWidth * 0.5)
	local locationX = startX

	local numRows = math.ceil( totalDisplayResources / numColumns )
	local totalHeight = (args.SpacerY or 0) * ( numRows - 1 )
	local startY = (args.StartY or ScreenCenterY) - (totalHeight * 0.5)
	local locationY = startY

	local inventoryAmountOffsetY = args.InventoryAmountOffsetY or 80
	local resourceIconOffsetY = args.ResourceIconOffsetY or -10
	local iconOffsetX = args.InventoryIconOffsetX or -60

	screen.CostIds = screen.CostIds or {}

	local resourceNum = 1
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if resourceCostData[resourceName] then

			local resourceData = ResourceData[resourceName]

			local hideCost = false
			if resourceData.CostRevealRequirements ~= nil and not IsGameStateEligible( resourceData, resourceData.CostRevealRequirements ) then
				hideCost = true
			end

			local resourceNameFormat = ScreenData.GhostAdmin.CostDisplay.ResourceNameAffordableFormat
			local resourceAmountFormat = ScreenData.GhostAdmin.CostDisplay.ResourceAmountAffordableFormat
			if not HasResource( resourceName, resourceCostData[resourceName] ) then
				resourceAmountFormat = ScreenData.GhostAdmin.CostDisplay.ResourceAmountUnaffordableFormat
				resourceNameFormat = ScreenData.GhostAdmin.CostDisplay.ResourceNameUnaffordableFormat
			end

			local backingKey = "ResourceIconBacking"..resourceName
			local resourceIconBacking = screen.Components[backingKey]
			resourceIconBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = args.GroupName or "Combat_Menu_Overlay", X = locationX, Y = locationY })
			screen.Components[backingKey] = resourceIconBacking				
			table.insert( screen.CostIds, resourceIconBacking.Id )
			--SetAnimation({ DestinationId = resourceIconBacking.Id, Name = "GhostAdminScreenCauldronReagentsIn" })
			SetAnimation({ DestinationId = resourceIconBacking.Id, Name = "ResourceCardBacking" }) --nopkg

			local iconKey = "ResourceIcon"..resourceName
			local resourceIcon = screen.Components[iconKey]
			resourceIcon =  CreateScreenComponent({ Name = "BlankObstacle", Group = args.GroupName or "Combat_Menu_Overlay", X = locationX, Y = locationY + resourceIconOffsetY })
			screen.Components[iconKey] = resourceIcon
			table.insert( screen.CostIds, resourceIcon.Id )
			SetScale({ Id = resourceIcon.Id, Fraction = (args.ResourceIconScale or 0.85) * (resourceData.IconScale or 1.0) })
			local iconPath = resourceData.IconPath
			if hideCost then
				iconPath = ResourceData.MysteryResource.IconPath
			end
			SetAnimation({ DestinationId = resourceIcon.Id, Name = iconPath })

			-- Name
			local name = resourceData.CostTextId or resourceName
			if hideCost then
				name = "MysteryResource_CostName"
			end
			local inventoryAmountFormat = ShallowCopyTable( resourceNameFormat )
			inventoryAmountFormat.Id = resourceIcon.Id
			inventoryAmountFormat.Text = name
			CreateTextBox( inventoryAmountFormat )

			-- Cost
			local costText = resourceCostData[resourceName]
			if hideCost then
				costText = "MysteryResource"
			end
			local resourceAmountFormat = ShallowCopyTable( resourceAmountFormat )
			resourceAmountFormat.Id = resourceIcon.Id
			resourceAmountFormat.Text = costText
			CreateTextBox( resourceAmountFormat )

			-- InventoryAmount
			local inventoryAmountFormat = ShallowCopyTable( ScreenData.GhostAdmin.CostDisplay.InventoryAmountFormat )
			inventoryAmountFormat.Id = resourceIcon.Id
			inventoryAmountFormat.LuaKey = "TempTextData"
			inventoryAmountFormat.LuaValue = { InventoryAmount = GameState.Resources[resourceName] or 0 }
			CreateTextBox( inventoryAmountFormat )
			
			locationX = locationX + (args.SpacerX or 0)
			--locationY = locationY + (args.SpacerY or 0)
			if args.ItemsPerRow ~= nil and resourceNum % args.ItemsPerRow == 0 then
				locationX = startX
				locationY = locationY + (args.SpacerY or 0)	
			end
			resourceNum = resourceNum + 1
		end
	end
end

function MouseOverContextualAction( button )
	ModifyTextBox({ Id = button.Id, ColorTarget = { 0.50, 0.90, 0.80, 1.0 }, ColorDuration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
end

function MouseOffContextualAction( button )
	local color = { 0.58, 0.34, 0.78, 1.0 }
	if button.TextArgs ~= nil then
		color = button.TextArgs.Color
	end
	ModifyTextBox({ Id = button.Id, ColorTarget = color, ColorDuration = 0.2 })
end

function MouseOverNarrativeChoiceButton( button )
	SetAnimation({ DestinationId = button.Id, Name = button.MouseOverAnimation })
	ModifyTextBox({ Id = button.Id, ColorTarget = { 0.50, 0.90, 0.80, 1.0 }, ColorDuration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
end

function MouseOffNarrativeChoiceButton( button )
	SetAnimation({ DestinationId = button.Id, Name = button.Animation })
	ModifyTextBox({ Id = button.Id, ColorTarget = button.TextArgs.Color, ColorDuration = 0.2 })
end

function AltAspectRatioFramesShow()
	if HUDScreen.Components.Letterbox ~= nil then
		SetAlpha({ Id = HUDScreen.Components.Letterbox.Id, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })	
	elseif HUDScreen.Components.PillarboxLeft ~= nil then
		SetAlpha({ Id = HUDScreen.Components.PillarboxLeft.Id, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
		SetAlpha({ Id = HUDScreen.Components.PillarboxRight.Id, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	end
end

function AltAspectRatioFramesHide()
	if HUDScreen.Components.Letterbox ~= nil then
		SetAlpha({ Id = HUDScreen.Components.Letterbox.Id, Fraction = 0.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	elseif HUDScreen.Components.PillarboxLeft ~= nil then
		SetAlpha({ Id = HUDScreen.Components.PillarboxLeft.Id, Fraction = 0.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
		SetAlpha({ Id = HUDScreen.Components.PillarboxRight.Id, Fraction = 0.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	end
end

function ScreenResetCursorToStartLocation( screen )
	TeleportCursor({ OffsetX = screen.CursorStartX, OffsetY = screen.CursorStartY, ForceUseCheck = true })
end