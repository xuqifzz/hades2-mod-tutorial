--[[ * UI LIBRARY * ]]

OnPreThingCreation
{
	function( triggerArgs )
		-- References survive to objects that cannot survive a load
		ScreenState = {}
		ScreenState.TraitAddedPresentationQueue = ScreenState.TraitAddedPresentationQueue or {}
		ScreenAnchors = {}
		ScreenAnchors.ResourceAnchorIds = {}
		ScreenAnchors.ResourceDeltaIds = {}
		ScreenAnchors.ResourceShowing = {}
		ScreenAnchors.ResourceOffsetYCache = {}
		ScreenAnchors.CallLock = {}
		ScreenPresentationData = {}
		ScreenPresentationData.ResourceRunningThreads = {}
		ScreenPresentationData.ResourceFloating = {}
		ActiveScreens = {}

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
		if SessionState.FormattersParsed == nil then
			for formatName, formatTable in pairs( TextFormats ) do
				formatTable.Name = formatName
				formatTable.AutoSetDataProperties = true
				CreateFormatContainer( formatTable )
			end
			SessionState.FormattersParsed = true
		end
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
		thread( UpdateManaMeterUIReal )
	end
	if UIScriptsDeferred.ElementalCountDirty then
		thread( ElementalTraitUpdatedPresentationReal )
	end
end

OnMenuOpened{ "PauseScreen",
	function( triggerArgs )
		SessionState.PrevEasyMode = ConfigOptionCache.EasyMode
		SessionState.PrevShowGameplayTimer = ConfigOptionCache.ShowGameplayTimer
		PauseSpeech({ })
		if AudioState.TraversalSoundId ~= nil then
			PauseSound({ Id = AudioState.TraversalSoundId })
		end
		if CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.PauseMusicOnPauseScreen then
			PauseMusic()
		end
		if SessionMapState.PauseMenuTakeoverCue ~= nil then
			PlaySound({ Name = "/SFX/TimeSlowStart" })
		end
	end
}

OnMenuCloseFinished{ "PauseScreen",
	function( triggerArgs )
		PauseMenuTakeoverClosed()
		ResumeSpeech({ })
		if CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.PauseMusicOnPauseScreen then
			ResumeMusic()
		end
		if AudioState.TraversalSoundId ~= nil then
			ResumeSound({ Id = AudioState.TraversalSoundId })
		end
		if SessionState.PrevEasyMode ~= ConfigOptionCache.EasyMode then
			if ConfigOptionCache.EasyMode then
				if not HeroHasTrait( "GodModeTrait") and ScreenAnchors.TraitBacking then
					AddTraitToHero({ TraitName = "GodModeTrait" })
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

	-- skip this except for every fourth run since the last remembrance, starting after Flashback
	local completedRuns = GetCompletedRuns()
	--[[
	if completedRuns > 0 and not GameState.TextLinesRecord.Flashback_Mother_01 then
		return
	end
	]]--
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
		if IsGameStateEligible( currentRun, entryData.GameStateRequirements ) then
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
		if CanReceiveGift( useTarget ) then
			SessionMapState.ActiveGiftableUseTarget = true
			AddControlBlock( "Shout", "ActiveUseTarget" )
		end
		ShowUseButton( triggerArgs.triggeredById, useTarget )
	end
}

OnActiveUseTargetLost{
	function( triggerArgs )
		if triggerArgs.AutoActivate then
			return
		end
		SessionMapState.ActiveGiftableUseTarget = nil
		
		local useTarget = triggerArgs.AttachedTable
		HideUseButton( triggerArgs.triggeredById or triggerArgs.PrevUseTargetId, useTarget )
		RemoveControlBlock( "Shout", "ActiveUseTarget" )
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
		if not IsEmpty( RequiredKillEnemies ) or not IsEmpty( MapState.AggroedUnits ) then
			return useTarget.AggroedEnemyUseText
		end
	end

	if useTarget.BlockedLootInteractionText ~= nil and not CurrentRun.CurrentRoom.AlwaysAllowLootInteraction then
		for enemyId, enemy in pairs( ActiveEnemies ) do
			if enemy.BlocksLootInteraction then
				return useTarget.BlockedLootInteractionText
			end
		end
	end

	if useTarget.FamiliarUseText then
		if useTarget.LinkedToolName and OnlyFamiliarHasAccessToTool( useTarget.LinkedToolName) then
			customUseText = useTarget.FamiliarUseText
		end
	end

	if useTarget.ExitsLockedUseText ~= nil and not CurrentRun.CurrentRoom.ExitsUnlocked then
		customUseText = useTarget.ExitsLockedUseText
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

	if useTarget.UseIneligibleText ~= nil and useTarget.OnUsedGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, useTarget, useTarget.OnUsedGameStateRequirements ) then
		return useTarget.UseIneligibleText
	end

	local canTalk = false
	if useTarget.OnUsedFunctionName == "UseNPC" then
		if useTarget.AlwaysShowDefaultUseText or useTarget.NextInteractLines ~= nil then
			canTalk = true
		end
	elseif useTarget.OnUsedFunctionName ~= nil and ( useTarget.OnUsedGameStateRequirements == nil or IsGameStateEligible( CurrentRun, useTarget, useTarget.OnUsedGameStateRequirements ) ) then
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

	if useTarget.RefreshExtractValuesOnApproach then
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
	component.Id = CreateScreenObstacle( params )
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

	local obstacleId = SpawnObstacle({ Name = params.Name, Group = params.Group or "Events", OffsetX = params.X, OffsetY = params.Y, UseScreenLocation = true, SortById = true, TriggerOnSpawn = false })
	if (params.Scale or 1.0) ~= 1.0 then
		SetScale({ Id = obstacleId, Fraction = params.Scale })
	end
	if (params.ScaleX or 1.0) ~= 1.0 then
		SetScaleX({ Id = obstacleId, Fraction = params.ScaleX })
	end
	if (params.ScaleY or 1.0) ~= 1.0 then
		SetScaleY({ Id = obstacleId, Fraction = params.ScaleY })
	end
	if params.Alpha ~= nil then
		SetAlpha({ Id = obstacleId, Fraction = params.Alpha, Duration = 0 })
	end
	if params.AlphaTarget ~= nil then
		SetAlpha({ Id = obstacleId, Fraction = params.AlphaTarget, Duration = params.AlphaTargetDuration or 0 })
	end
	if params.Color ~= nil then
		SetColor({ Id = obstacleId, Color = params.Color, Duration = 0 })
	end
	if params.Angle ~= nil then
		SetAngle({ Id = obstacleId, Angle = params.Angle })
	end
	if params.Animation ~= nil then
		SetAnimation({ DestinationId = obstacleId, Name = params.Animation })
	end

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
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		local weaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponNames ~= nil then
			for k, linkedWeaponName in ipairs( weaponNames ) do
				SetWeaponProperty({ WeaponName = linkedWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			end
		end
	end
	for k, weaponName in ipairs( WeaponSets.HeroNonPhysicalWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		local weaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponNames ~= nil then
			for k, linkedWeaponName in ipairs( weaponNames ) do
				SetWeaponProperty({ WeaponName = linkedWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
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
	SetConfigOption({ Name = "ScreenEdgeIndicatorOpacity", Value = 0.0 })
	HideAllUseButtons()
	ZeroMouseTether( screen.Name )
	FreezePlayerUnit( screen.Name, screen.FreezePlayerArgs )
	EnableGamepadCursor( screen.Name )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	if not args.SkipBlockTimer then
		AddTimerBlock( CurrentRun, screen.Name )
	end
	thread( GenericScreenOpenStartPresentation, screen )
end

function IsScreenOpen( screenName )
	return ActiveScreens[screenName] ~= nil
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

	CombatUI.AutoHideEnabled = true
	StartHideAfterDelayThread()

	if not screen.SkipCheckQuestStatus and IsEmpty( ActiveScreens ) then
		thread( CheckQuestStatus )
	end

	UnfreezePlayerUnit( screen.Name )
	UnzeroMouseTether( screen.Name )
	RemoveTimerBlock( CurrentRun, screen.Name )

	if IsEmpty( ActiveScreens ) then
		ShowAllUseButtons()
		SetConfigOption({ Name = "UseOcclusion", Value = true })
	end

	for i, defaultOption in pairs( GamepadNavigationDefaults ) do
		SetConfigOption({ Name = defaultOption, Value = "Default" })
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
	end

end

function IsPauseBlocked()

	if SessionMapState.HandlingDeath then
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

function OnLanguageChanged( args )
	-- Warning: this can be called from the shell
	if ActiveScreens ~= nil then
		for screenName, screen in pairs( ActiveScreens ) do
			if screen.Components then
				for componentName, component in pairs( screen.Components ) do
					if component.Id then
						ModifyTextBox({ 
							Id = component.Id, 
							UseLastHelpTextIdOrDefaultText = true,
							UseDefaultFont = true,
							UseDefaultScale = true,
							ReReadTextImmediately = true,
						})
					end
				end
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
		return not IsEmpty( ActiveScreens )
	end
	return ActiveScreens[flag] ~= nil
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
	screen.AllowHold = false
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
		NotifyOnInteract({ Ids = buttonIds, Notify = notifyName })
		NotifyOnControlPressed({ Names = hotkeyControls, Notify = notifyName, AllowHold = screen.AllowHold })
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
			if button ~= nil and button.OnPressedFunctionName ~= nil and not button.Disabled then
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
		if screen.AllowInputRepeat then
			thread( CheckInputRepeat, screen, notifyName, hotkeyControls )
		end
	end
end

function CheckInputRepeat( screen, notifyName, hotkeyControls )
	local threadName = "RepeatThread"
	if HasThread( threadName ) then
		return
	end
	wait( 0.1, threadName )
	if IsControlDown({ Names = hotkeyControls }) then
		if not screen.AllowHold then
			wait( 0.5, threadName )
			if IsControlDown({ Names = hotkeyControls }) then
				screen.AllowHold = true
			else
				screen.AllowHold = false
			end
		end
	else
		screen.AllowHold = false
	end
	if screen.AllowHold then
		NotifyOnControlPressed({ Names = hotkeyControls, Notify = notifyName, AllowHold = screen.AllowHold })
	end
end

function CloseScreen( componentIds, delay, screen )
	HideTopMenuScreenTooltips( {Ids = componentIds} )
	ModifyTextBox({ Ids = componentIds, BlockTooltip = true })
	if delay ~= nil and delay > 0 then
		waitUnmodified( delay )
	end
	local fadeOutTime = 0.2
	if screen ~= nil then
		fadeOutTime = screen.FadeOutTime or fadeOutTime
	end
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime, EaseIn = 0, EaseOut = 1 })
	ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime, EaseIn = 0, EaseOut = 1 })
	waitUnmodified( fadeOutTime )
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

function CreateComponentFromData( screenData, data )

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
	data.Group = data.Group or data.GroupName or screenData.DefaultGroup
	local component = CreateScreenComponent( data )
	component.Data = data
	
	if data.AnimationName ~= nil then		
		SetAnimation({ Name = data.AnimationName, DestinationId = component.Id })		
	end
	if data.Animation ~= nil then
		SetAnimation({ Name = data.Animation, DestinationId = component.Id })
	end

	if data.Scale ~= nil then
		SetScale({ Id = component.Id, Fraction = data.Scale })
	end
	if data.PillarboxLeft or data.PillarboxRight then
		data.ScaleX = (data.ScaleX or 1.0) * ScreenState.PillarboxScaleX
	end
	if data.UseScreenScaleX then
		data.ScaleX = (data.ScaleX or 1.0) * ScreenScaleX
	end
	if data.ScaleX ~= nil then
		SetScaleX({ Id = component.Id, Fraction = data.ScaleX })
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

	if data.InteractProperties ~= nil then
		for propertyName, propertyValue in pairs( data.InteractProperties ) do
			SetInteractProperty({ DestinationId = component.Id, Property = propertyName, Value = propertyValue })
		end
	end
	if data.UseableOff then
		UseableOff({ Id = component.Id })
	end

	if data.Text or data.TextArgs then
		if data.TextArgs ~= nil and data.TextArgs.Format ~= nil then
			CreateTextBoxWithFormat( MergeTables( { Id = component.Id, Text = data.Text, }, data.TextArgs ) )	
		else
			CreateTextBox( MergeTables( { Id = component.Id, Text = data.Text, }, data.TextArgs ) )	
		end
	end

	if data.Color ~= nil then
		SetColor({ Id = component.Id, Color = data.Color, Duration = 0 })
	end
	if data.Alpha ~= nil then
		SetAlpha({ Id = component.Id, Fraction = data.Alpha, Duration = 0 })
	end
	if data.AlphaTarget ~= nil then
		SetAlpha({ Id = component.Id, Fraction = data.AlphaTarget, Duration = data.AlphaTargetDuration or 0 })
	end

	if data.Data ~= nil then
		component = MergeTables( component, data.Data )
	end

	if data.Angle ~= nil then
		SetAngle({ Id = component.Id, Angle = data.Angle })
	end
	
	AttachLua({ Id = component.Id, Table = component })
	return component
end

function CreateScreenFromData( screen, componentData, args )

	args = args or {}
	local skipComponents = ToLookup( args.SkipComponents or {} )

	if componentData ~= nil then

		if componentData.Order ~= nil then
			for i, componentName in ipairs( componentData.Order ) do
				local data = componentData[componentName]
				if data ~= nil and not skipComponents[componentName] and (data.Requirements == nil or IsGameStateEligible( CurrentRun, screen, data.Requirements ) ) then
					--DebugPrint({ Text = "componentName = "..componentName })
					if data.FunctionName ~= nil then
						CallFunctionName( data.FunctionName, screen, data )
					else
						local component = CreateComponentFromData( componentData, data )
						component.Screen = screen
						screen.Components[componentName] = component
						if data.Children ~= nil then
							AttachChildrenFromData( screen, component, data, componentData )
						end
					end
					data.Ordered = true
				end
			end
		end

		for name, data in pairs( componentData ) do
			--DebugPrint({ Text = "componentName = "..name })
			if type(data) == "table" and not data.Skip and not data.Ordered and name ~= "Ordered" and not skipComponents[name] and (data.Requirements == nil or IsGameStateEligible( CurrentRun, screen, data.Requirements ) ) then
				local component = CreateComponentFromData( componentData, data )
				component.Screen = screen
				screen.Components[name] = component				
				if data.Children ~= nil then
					AttachChildrenFromData( screen, component, data, componentData )
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

function AttachChildrenFromData( screen, parentComponent, childData, screenData )
	if childData.Children ~= nil then

		if childData.ChildrenOrder ~= nil then
			local accumOffsetX = 0
			for i, componentName in ipairs( childData.ChildrenOrder ) do
				local data = childData.Children[componentName]
				if data ~= nil and (data.Requirements == nil or IsGameStateEligible( CurrentRun, screen, data.Requirements ) ) then
					local component = CreateComponentFromData( screenData, data )
					component.Screen = screen
					screen.Components[componentName] = component
					if parentComponent.AutoAlignContextualButtons and data.TextArgs then
						Attach({ Id = component.Id, DestinationId = parentComponent.Id, OffsetX = accumOffsetX })
						local dataWidth = data.TextArgs.Width or UIData.ContextualButtonSpacing
						local label = GetDisplayName({ Text = data.Text })
						local labelAlt = GetDisplayName({ Text = data.AltText })
						local fontSize = data.TextArgs.FontSize or 20
						local len = math.max(utf8strlen( label ), utf8strlen( labelAlt ))
						local approxTextSize = fontSize * len - UIData.AutoAlignContextualButtonGlyphWidth
						
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
						AttachChildrenFromData( screen, component, data, screenData )
					end
				end
			end
		end

		for name, data in pairs( childData.Children ) do
			if not data.Ordered and (data.Requirements == nil or IsGameStateEligible( CurrentRun, screen, data.Requirements ) ) then
				local component = CreateComponentFromData( screenData, data )	
				component.Screen = screen
				screen.Components[name] = component
				Attach({ Id = component.Id, DestinationId = parentComponent.Id, OffsetX = data.OffsetX, OffsetY = data.OffsetY })
				if data.Children ~= nil then
					AttachChildrenFromData( screen, component, data, screenData )
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
	local textBoxParams = MergeTables( format, args )
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

	ScreenAnchors.BossHealthFill = CreateScreenObstacle( {Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })

	CreateAnimation({ Name = "BossNameShadow", DestinationId = ScreenAnchors.BossHealthBack })

	SetScaleX({ Ids = { ScreenAnchors.BossHealthBack, ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 1, Duration = 0 })

	local barName = EncounterData[encounter.Name].HealthBarTextId or encounter.Name

	CreateTextBox({ Id = ScreenAnchors.BossHealthBack, Text = barName,
			Font = "CaesarDressing", FontSize = 22, ShadowRed = 0, ShadowBlue = 0, ShadowGreen = 0,
			OutlineColor = {0, 0, 0, 1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 3, ShadowOffsetX = 0, Justification = "Center", OffsetY = -30,
			OpacityWithOwner = false,
			AutoSetDataProperties = true,
			})

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 0, FadeDuration = 0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 1.0, Duration = 2.0 })
	EnemyHealthDisplayAnchors[encounter.Name.."back"] = ScreenAnchors.BossHealthBack

	encounter.HealthBarFill = "EnemyHealthBarFillBoss"
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1, DestinationId = ScreenAnchors.BossHealthFill })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 1, Duration = 2.0 })
	EnemyHealthDisplayAnchors[encounter.Name] = ScreenAnchors.BossHealthFill
	EnemyHealthDisplayAnchors[encounter.Name.."falloff"] = fallOffBar
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
		wait(0.005)
	end
	StopSound({ Id = bossHealthBarSoundId, Duration = 0.25 })
	thread( UpdateHealthBar, encounter, 0, { Force = true })
end

function CheckRemoveGroupHealthBar(encounter)

	local notifyName = encounter.Name.."GroupHealthBarDead"
	NotifyOnAllDead({ Ids = encounter.HealthBarUnitIds, Notify = notifyName })
	waitUntil( notifyName )

	if ScreenAnchors.BossHealthTitles ~= nil then
		DestroyTextBox({ Id = ScreenAnchors.BossHealthTitles[encounter.Name] })
		ScreenAnchors.BossHealthTitles[ encounter.Name ] = nil
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name.."back"] })
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name] })
		Destroy({ Id = EnemyHealthDisplayAnchors[encounter.Name.."falloff"] })
	end
end

function CreateBossHealthBar( boss )
	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter ~= nil and encounter.UseGroupHealthBar ~= nil then
		if not boss.HasHealthBar then
			local offsetY = -155
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
	boss.BarXScale = xScale
	local totalWidth = ScreenWidth * xScale
	local xOffset = ( totalWidth / ( 2 * numBars )) * ( 1 + index * 2 ) + (ScreenWidth - totalWidth) / 2

	if numBars == 0 then
		return
	end

	ScreenAnchors.BossHealthBack = CreateScreenObstacle({ Name = "BossHealthBarBack", Group = "Combat_UI", X = xOffset , Y = 70 + yOffset })
	ScreenAnchors.BossHealthTitles[boss.ObjectId] = ScreenAnchors.BossHealthBack
	
	local fallOffBar = CreateScreenObstacle({ Name = "BossHealthBarFillFalloff", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })
	SetColor({ Id = fallOffBar, Color = Color.HealthFalloff })
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 0, DestinationId = fallOffBar, Instant = true })
	
	ScreenAnchors.BossHealthFill = CreateScreenObstacle({ Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset })	

	CreateAnimation({ Name = "BossNameShadow", DestinationId = ScreenAnchors.BossHealthBack })

	SetScaleX({ Ids = { ScreenAnchors.BossHealthBack, ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = xScale, Duration = 0 })

	local bossName = boss.HealthBarTextId or boss.Name

	if boss.AltHealthBarTextIds ~= nil then
		local eligibleTextIds = {}
		for k, altTextIdData in pairs(boss.AltHealthBarTextIds) do
			if IsGameStateEligible( CurrentRun, altTextIdData.Requirements) then
				table.insert(eligibleTextIds, altTextIdData.TextId)
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
			OpacityWithOwner = false,
			AutoSetDataProperties = true,
			})

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 0, FadeDuration = 0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 1.0, Duration = 2.0 })
	EnemyHealthDisplayAnchors[boss.ObjectId.."back"] = ScreenAnchors.BossHealthBack

	boss.HealthBarFill = "EnemyHealthBarFillBoss"
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = boss.Health / boss.MaxHealth, DestinationId = screenId })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 1, Duration = 2.0 })
	EnemyHealthDisplayAnchors[boss.ObjectId] = ScreenAnchors.BossHealthFill
	EnemyHealthDisplayAnchors[boss.ObjectId.."falloff"] = fallOffBar

	thread( BossHealthBarPresentation, boss )
end

function BossHealthBarPresentation( boss )
	local screenId = EnemyHealthDisplayAnchors[boss.ObjectId]
	local falloffId = EnemyHealthDisplayAnchors[boss.ObjectId.."falloff"]
	local healthFraction = 0
	local bossHealthBarSoundId = PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraHealthFillUp", Id = screenId })
	if boss.HitShields > 0 then
		SetColor({ Id = screenId, Color = Color.HitShield})
	else
		SetColor({ Id = screenId, Color = Color.Red })
	end
	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 1, FadeDuration = 2 })
	while healthFraction < boss.Health / boss.MaxHealth do
		healthFraction = healthFraction + 0.01
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - healthFraction, DestinationId = screenId })
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 1 - healthFraction, DestinationId = falloffId, Instant = true })
		wait(0.005)
	end
	StopSound({ Id = bossHealthBarSoundId, Duration = 0.25 })
	thread( UpdateHealthBar, boss, 0, { Force = true })
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
					LuaValue = { Current = GameState.Resources[resourceName] or 0, Amount = resourceCostData[resourceName], IconPath = ResourceData[resourceName].IconPath },
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

	--local inventoryAmountIcon = screen.Components.InventoryAmountIcon
	local inventoryAmountOffsetY = args.InventoryAmountOffsetY or 80
	local resourceIconOffsetY = args.ResourceIconOffsetY or -10
	local iconOffsetX = args.InventoryIconOffsetX or -60
	--[[
	if inventoryAmountIcon == nil then
		inventoryAmountIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = args.GroupName or "Combat_Menu_Overlay",
			X = locationX + iconOffsetX,
			Y = locationY + inventoryAmountOffsetY + resourceIconOffsetY,
			Scale = args.InventoryIconScale or 0.5 })
		SetAnimation({ DestinationId = inventoryAmountIcon.Id, Name = "GUI\\Screens\\Inventory\\Icon-Inventory" })
		screen.Components.InventoryAmountIcon = inventoryAmountIcon
		screen.CostIds = screen.CostIds or {}
		table.insert( screen.CostIds, inventoryAmountIcon.Id )
		SetAlpha({ Id = inventoryAmountIcon.Id, Fraction = 1, Duration = 0.1 })
	else
		Teleport({ Id = inventoryAmountIcon.Id, OffsetX = locationX + iconOffsetX, OffsetY = locationY + inventoryAmountOffsetY + resourceIconOffsetY })
		SetAlpha({ Id = inventoryAmountIcon.Id, Fraction = 1, Duration = 0.1 })
	end
	]]

	screen.CostIds = screen.CostIds or {}
	
	local costDisplayNum = args.CostDisplayNum or 1
	local resourceNum = 1
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if resourceCostData[resourceName] then

			local resourceData = ResourceData[resourceName]

			local resourceNameFormat = ScreenData.GhostAdmin.CostDisplay.ResourceNameAffordableFormat
			local resourceAmountFormat = ScreenData.GhostAdmin.CostDisplay.ResourceAmountAffordableFormat
			if not HasResource( resourceName, resourceCostData[resourceName] ) then
				resourceAmountFormat = ScreenData.GhostAdmin.CostDisplay.ResourceAmountUnaffordableFormat
				resourceNameFormat = ScreenData.GhostAdmin.CostDisplay.ResourceNameUnaffordableFormat
			end

			local backingKey = "ResourceIconBacking"..costDisplayNum..resourceNum
			local resourceIconBacking = screen.Components[backingKey]
			--if resourceIconBacking == nil then
				resourceIconBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = args.GroupName or "Combat_Menu_Overlay", X = locationX, Y = locationY })
				screen.Components[backingKey] = resourceIconBacking				
				table.insert( screen.CostIds, resourceIconBacking.Id )
			--[[
			else
				Teleport({ Id = resourceIconBacking.Id, OffsetX = locationX, OffsetY = locationY })
				SetAlpha({ Id = resourceIconBacking.Id, Fraction = 1, Duration = 0.1 })
			end
			]]
			SetAnimation({ DestinationId = resourceIconBacking.Id, Name = "ResourceCardBacking" })

			local iconKey = "ResourceIcon"..costDisplayNum..resourceNum
			local resourceIcon = screen.Components[iconKey]
			--if resourceIcon == nil then
				resourceIcon =  CreateScreenComponent({ Name = "BlankObstacle", Group = args.GroupName or "Combat_Menu_Overlay", X = locationX, Y = locationY + resourceIconOffsetY })
				screen.Components[iconKey] = resourceIcon
				table.insert( screen.CostIds, resourceIcon.Id )
			--[[
			else
				Teleport({ Id = resourceIcon.Id, OffsetX = locationX, OffsetY = locationY + resourceIconOffsetY })
				SetAlpha({ Id = resourceIcon.Id, Fraction = 1, Duration = 0.1 })
			end
			]]
			SetScale({ Id = resourceIcon.Id, Fraction = (args.ResourceIconScale or 0.85) * (resourceData.IconScale or 1.0) })
			SetAnimation({ DestinationId = resourceIcon.Id, Name = resourceData.IconPath })

			-- Name
			local name = resourceData.CostTextId or resourceName
			local inventoryAmountFormat = ShallowCopyTable( resourceNameFormat )
			inventoryAmountFormat.Id = resourceIcon.Id
			inventoryAmountFormat.Text = name
			CreateTextBox( inventoryAmountFormat )

			-- Cost
			local costText = resourceCostData[resourceName]
			if source ~= nil and source.CostAmountTextIds ~= nil and source.CostAmountTextIds[resourceName] ~= nil then
				costText = source.CostAmountTextIds[resourceName]
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

function AddContextualAction( screen, textData, args )
	if not screen or not screen.Components then
		return
	end
	local reversedTextData = {}
	for i = #textData, 1, -1 do
		table.insert( reversedTextData, textData[i] )
	end

	local maxActions = 5
	if #reversedTextData < maxActions then
		while #reversedTextData < maxActions do
			table.insert( reversedTextData, "Blank" )
		end
	end
	ModifyTextBox({ Id = screen.Components.ContextualActionString.Id, Text = "Contextual_Action", LuaKey = "TempTextData", Font = "LatoBold", FontSize = 24, LuaValue = { Action = reversedTextData }} )

end

function MouseOverContextualAction( button )
	ModifyTextBox({ Id = button.Id, ColorTarget = { 0.50, 0.90, 0.80, 1.0 }, ColorDuration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOut", Id = button.Id })
end

function MouseOffContextualAction( button )
	ModifyTextBox({ Id = button.Id, ColorTarget = { 0.58, 0.34, 0.78, 1.0 }, ColorDuration = 0.2 })
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

function HandleWASDInput( screen )
	while screen.KeepOpen do
		local notifyName = "WASDInput"
		NotifyOnControlPressed({ Names = { "Up", "Down", "Left", "Right" }, Notify = notifyName })
		waitUntil( notifyName )
		if screen.KeepOpen then
			if GetConfigOptionValue({ Name = "UseMouse" }) then
				CallFunctionName( screen.OnWASDHotSwapFunctionName, screen )
			end
			SetConfigOption({ Name = "UseMouse", Value = false })
			CallFunctionName( screen.OnWASDInputFunctionName, screen )
		end
		wait( 0.01, RoomThreadName )
	end
end

function ScreenResetCursorToStartLocation( screen )
	TeleportCursor({ OffsetX = screen.CursorStartX, OffsetY = screen.CursorStartY, ForceUseCheck = true })
end