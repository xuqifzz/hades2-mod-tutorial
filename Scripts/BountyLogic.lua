function UseBountyBoard( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )

	local screen = OpenBountyBoardScreen( usee )
	UseableOn({ Id = usee.ObjectId })
end

function OpenBountyBoardScreen( openedFrom, args )

	args = args or {}
	local screen = DeepCopyTable( ScreenData.BountyBoard )
	local components = screen.Components
	local hasViewed = GameState.ScreensViewed.BountyBoard

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1

	wait(0.1)

	BountyBoardScreenDisplayCategory( screen, screen.ActiveCategoryIndex )
	WeaponShopUpdateVisibility( screen )

	thread( BountyBoardOpenedPresentation, screen )

	wait(0.1)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	if not hasViewed then
		GenericInfoPresentation( screen )
	end

	screen.KeepOpen = true
	HandleScreenInput( screen )

	thread( MarkObjectiveComplete, "BountyPrompt" )

end

function HasUnviewedBounty( source, args )
	for k, itemName in ipairs( ScreenData.BountyBoard.ItemCategories[1] ) do
		local bountyData = BountyData[itemName]
		if not GameState.QuestsViewed[itemName] and IsGameStateEligible( bountyData, bountyData.UnlockGameStateRequirements ) then
			return true
		end
	end
	return false
end

function HasUnclearedBounty( source, args )
	for k, itemName in ipairs( ScreenData.BountyBoard.ItemCategories[1] ) do
		local bountyData = BountyData[itemName]
		if (GameState.PackagedBountyClears[itemName] or 0) == 0 and IsGameStateEligible( bountyData, bountyData.UnlockGameStateRequirements ) then
			return true
		end
	end
	return false
end

function BountyBoardScreenDisplayCategory( screen, categoryIndex )

	local components = screen.Components
	local category = screen.ItemCategories[categoryIndex]
	local slotName = category.Name

	screen.ActiveCategoryIndex = categoryIndex

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local activeBounties = {}
	local completedBounties = {}

	for i, bountyName in ipairs( screen.ItemCategories[screen.ActiveCategoryIndex] ) do
		local bountyData = BountyData[bountyName]
		if not bountyData.DebugOnly and IsGameStateEligible( bountyData, bountyData.UnlockGameStateRequirements ) then
			if GameState.PackagedBountyClears[bountyName] ~= nil then
				table.insert( completedBounties, bountyData )
			else
				table.insert( activeBounties, bountyData )
			end
		end
	end

	local firstUseable = false
	screen.NumItems = 0

	for k, bountyData in ipairs( activeBounties ) do

		-- BountyButton
		screen.NumItems = screen.NumItems + 1
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		button.MouseOverSound = "/SFX/Menu Sounds/MirrorMenuToggle"
		button.OnPressedFunctionName = "StartPackagedBounty"
		button.OnMouseOverFunctionName = "MouseOverBounty"
		button.OnMouseOffFunctionName = "MouseOffBounty"
		button.Data = bountyData
		button.Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = button.Id, Table = button })
		local bountyButtonKey = screen.ButtonName..screen.NumItems
		components[bountyButtonKey] = button

		local activeFormat = screen.ActiveFormat
		activeFormat.Id = button.Id
		activeFormat.Text = bountyData.Text or bountyData.Name
		activeFormat.LuaKey = "TempTextData"
		activeFormat.LuaValue = bountyData
		CreateTextBox( activeFormat )

		newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[bountyData.Name] then
			-- New icon
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "QuestLogNewQuest" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[bountyButtonKey].Id, OffsetX = screen.NewIconOffsetX, OffsetY = screen.NewIconOffsetY })
		end

		if IsGameStateEligible( bountyData, bountyData.CompleteGameStateRequirements ) then
			local activeFlash = screen.ActiveFlash
			activeFlash.Id = button.Id
			Flash( activeFlash )
		end

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end

	for k, bountyData in ipairs( completedBounties ) do

		-- BountyButton
		screen.NumItems = screen.NumItems + 1
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		button.MouseOverSound = "/SFX/Menu Sounds/MirrorMenuToggle"
		if GameState.WorldUpgrades.WorldUpgradeBountyBoardRepeat then
			button.OnPressedFunctionName = "StartPackagedBounty"
		else
			button.OnPressedFunctionName = "BountyBoardIneligiblePresentation"
		end
		button.OnMouseOverFunctionName = "MouseOverBounty"
		button.OnMouseOffFunctionName = "MouseOffBounty"
		button.Data = bountyData
		button.Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = button.Id, Table = button })
		local bountyButtonKey = screen.ButtonName..screen.NumItems
		components[bountyButtonKey] = button

		local completedFormat = screen.CompletedFormat
		completedFormat.Id = button.Id
		completedFormat.Text = bountyData.Text or bountyData.Name
		completedFormat.LuaKey = "TempTextData"
		completedFormat.LuaValue = bountyData
		CreateTextBox( completedFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

end

function CloseBountyBoardScreen( screen, button )
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = "ChaosTrialOut" })
	CreateAnimation({ DestinationId = button.Id, Name = "ChaosTrialMousePress" }) --nopkg
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function BountyScreenUpdateIntensityEyes( screen )

	local threadName = "BountyScreenUpdateIntensityEyes"
	local delay = 0.3
	if SetThreadWait( threadName, delay ) then
		return
	end
	wait( delay, threadName )

	local button = screen.MouseOverButton
	for i = 1, 5 do
		local intensityComponent = screen.Components["IntensityEye"..i]
		if button ~= nil and (button.Data.DifficultyRating or 0) >= i then
			SetAnimation({ DestinationId = intensityComponent.Id, Name = intensityComponent.Data.ActiveAnimationName })
			if i >= 2 then
				local intensityFlameComponent = screen.Components["IntensityEye"..i.."Flame"]
				SetAlpha({ Id = intensityFlameComponent.Id, Fraction = 1.0, Duration = 0.3 })
			end
		else
			SetAnimation({ DestinationId = intensityComponent.Id, Name = intensityComponent.Data.AnimationName })
			if i >= 2 then
				local intensityFlameComponent = screen.Components["IntensityEye"..i.."Flame"]
				SetAlpha({ Id = intensityFlameComponent.Id, Fraction = 0.0, Duration = 0.3 })
			end
		end
		wait( 0.04 )
	end

end

function MouseOverBounty( button )

	local screen = button.Screen
	screen.MouseOverButton = button

	local bountyName = button.Data.Name
	screen.ClipboardText = bountyName
	local bountyComplete = (GameState.PackagedBountyClears[bountyName] ~= nil)

	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })

	Teleport({ Id = screen.Components.SelectionMarker.Id, DestinationId = button.Id, OffsetX = screen.Components.SelectionMarker.Data.ButtonOffsetX, OffsetY = screen.Components.SelectionMarker.Data.ButtonOffsetY })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = screen.Components.SelectionMarker.Id, Name = "ChaosTrialMouseHighlightIn" }) --nopkg

	GenericMouseOverPresentation( button )

	SetAlpha({ Id = button.Screen.Components.ItemTitleText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.ItemTitleText.Id, Text = bountyName })

	SetAlpha({ Id = button.Screen.Components.DescriptionText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.DescriptionText.Id, Text = bountyName, UseDescription = true, })

	-- Location
	if button.Data.StartingBiome ~= nil then
		SetAlpha({ Id = button.Screen.Components.LocationIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		CreateAnimation({ DestinationId = button.Screen.Components.LocationIconOverlay.Id, Name = "ChaosTrialDetailCardWipe" }) --nopkg
		SetAlpha({ Id = button.Screen.Components.LocationIcon.Id, Fraction = 1.0, Duration = 0.2 })
		local baseRoomData = RoomSetData[button.Data.StartingBiome]["Base"..button.Data.StartingBiome]
		SetAnimation({ DestinationId = button.Screen.Components.LocationIcon.Id, Name = button.Data.BiomeIcon or baseRoomData.Icon })
		ModifyTextBox({ Id = button.Screen.Components.LocationIcon.Id, Text = button.Data.BiomeText or "Biome"..button.Data.StartingBiome })
	end

	-- Weapon
	if button.Data.WeaponKitName ~= nil then
		SetAlpha({ Id = button.Screen.Components.WeaponIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		CreateAnimation({ DestinationId = button.Screen.Components.WeaponIconOverlay.Id, Name = "ChaosTrialDetailCardWipe2" }) --nopkg
		SetAlpha({ Id = button.Screen.Components.WeaponIcon.Id, Fraction = 1.0, Duration = 0.2 })
		local weaponKitName = button.Data.WeaponKitName
		local weaponUpgradeName = button.Data.WeaponUpgradeName
		local weaponTraitData = TraitData[weaponUpgradeName] or TraitData[weaponKitName]
		local weaponData = WeaponData[weaponUpgradeName] or WeaponData[weaponKitName]
		SetAnimation({ DestinationId = button.Screen.Components.WeaponIcon.Id, GrannyModel = weaponTraitData.WeaponKitGrannyModel, Name = screen.WeaponAnimationOverrides[weaponUpgradeName] or weaponData.BountyScreenKitAnimation })
		local weaponName = weaponKitName
		if GameState.WorldUpgrades.WorldUpgradeWeaponUpgradeSystem and button.Data.WeaponUpgradeName ~= nil then
			weaponName = weaponUpgradeName
		end
		ModifyTextBox({ Id = button.Screen.Components.WeaponIconBacking.Id, Text = weaponName })
	elseif button.Data.RandomWeaponKitNames ~= nil then
		SetAlpha({ Id = button.Screen.Components.WeaponIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		CreateAnimation({ DestinationId = button.Screen.Components.WeaponIconOverlay.Id, Name = "ChaosTrialDetailCardWipe2" }) --nopkg
		SetAlpha({ Id = button.Screen.Components.WeaponIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.WeaponIcon.Id, Name = "Weapon_Random" }) --nopkg
		ModifyTextBox({ Id = button.Screen.Components.WeaponIconBacking.Id, Text = "BountyBoard_RandomWeapon" })
	end

	-- Keepsake
	if button.Data.KeepsakeName ~= nil then
		SetAlpha({ Id = button.Screen.Components.KeepsakeIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		CreateAnimation({ DestinationId = button.Screen.Components.KeepsakeIconOverlay.Id, Name = "ChaosTrialDetailCardWipe3" }) --nopkg
		SetAlpha({ Id = button.Screen.Components.KeepsakeIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.KeepsakeIcon.Id, Name = TraitData[button.Data.KeepsakeName].Icon })
		ModifyTextBox({ Id = button.Screen.Components.KeepsakeIcon.Id, Text = button.Data.KeepsakeName })
	elseif button.Data.RandomKeepsakeNames ~= nil then
		SetAlpha({ Id = button.Screen.Components.KeepsakeIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		CreateAnimation({ DestinationId = button.Screen.Components.KeepsakeIconOverlay.Id, Name = "ChaosTrialDetailCardWipe3" }) --nopkg
		SetAlpha({ Id = button.Screen.Components.KeepsakeIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.KeepsakeIcon.Id, Name = "Keepsake_Random" }) --nopkg
		ModifyTextBox({ Id = button.Screen.Components.KeepsakeIcon.Id, Text = "BountyBoard_RandomKeepsake" })
	end

	-- Reward
	local rewardColor = screen.RewardAvailableColor
	local rewardText = screen.Components.RewardText.Data.Text
	if bountyComplete and not GameState.WorldUpgrades.WorldUpgradeBountyBoardRepeat then
		rewardColor = screen.RewardCashedOutColor
		rewardText = screen.Components.RewardText.Data.CompletedText
	end

	-- Reward string
	local dropData = nil
	if button.Data.LootOptions ~= nil then
		local loot = button.Data.LootOptions[1]
		if loot.Overrides ~= nil and loot.Overrides.AddResources ~= nil then
			dropData = loot.Overrides
		else
			dropData = ConsumableData[loot.Name]
		end
	elseif bountyComplete and GameState.WorldUpgrades.WorldUpgradeBountyBoardRepeat then
		dropData = ConsumableData[button.Data.ForcedRewardRepeat]
	else
		dropData = ConsumableData[button.Data.ForcedReward]
	end
	local resourceName = GetFirstKey( dropData.AddResources )
	local resourceAmount = dropData.AddResources[resourceName]
	local resourceData = ResourceData[resourceName]
	SetAlpha({ Id = button.Screen.Components.RewardText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.RewardText.Id, 
		Text = rewardText,
		LuaKey = "TempTextData",
		LuaValue = { Icon = resourceData.TextIconPath or resourceData.IconPath, Amount = resourceAmount },
		Color = rewardColor,
		})

	local newButtonKey = "NewIcon"..button.Index
	if button.Screen.Components[newButtonKey] ~= nil then
		SetAlpha({ Id = button.Screen.Components[newButtonKey].Id, Fraction = 0, Duration = 0.2 })
	end
	GameState.QuestsViewed[button.Data.Name] = true

	-- Clear hint / clear message
	if bountyComplete then
		SetAlpha({ Id = button.Screen.Components.ClearMessage.Id, Fraction = 1.0, Duration = 0.2 })
		if GameState.WorldUpgrades.WorldUpgradeBountyBoardRepeat then
			if BountyData[bountyName].RandomWeaponKitNames ~= nil then
				local clearData = { CurrentStreak = GameState.PackagedBountyClearStreak[bountyName], BestStreak = GameState.PackagedBountyHighestClearStreak[bountyName] }
				ModifyTextBox({ Id = button.Screen.Components.ClearMessage.Id, Text = "BountyBoard_ClearMessageStreaks", LuaKey = "TempTextData", LuaValue = clearData })
			else
				local clearData = { BestClearTimeString = GetTimerString( GameState.PackagedBountyClearRecordTime[bountyName], 2 ), ClearCount = GameState.PackagedBountyClears[bountyName] }
				ModifyTextBox({ Id = button.Screen.Components.ClearMessage.Id, Text = "BountyBoard_ClearMessage", LuaKey = "TempTextData", LuaValue = clearData })
			end
		else
			ModifyTextBox({ Id = button.Screen.Components.ClearMessage.Id, Text = "BountyBoard_ClearMessage_NonRepeatable" })
		end
	end

	-- Select button
	if not bountyComplete or GameState.WorldUpgrades.WorldUpgradeBountyBoardRepeat then
		SetAlpha({ Id = button.Screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		if bountyComplete then
			ModifyTextBox({ Id = button.Screen.Components.SelectButton.Id, Text = "BountyBoard_RepeatChallenge" })
		else
			ModifyTextBox({ Id = button.Screen.Components.SelectButton.Id, Text = "BountyBoard_StartChallenge" })
		end
	end

	thread( BountyScreenUpdateIntensityEyes, screen )

end

function MouseOffBounty( button )
	local screen = button.Screen
	if screen.MouseOverButton ~= button then
		return
	end
	screen.MouseOverButton = nil

	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })

	SetAlpha({ Id = button.Screen.Components.ItemTitleText.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.DescriptionText.Id, Fraction = 0.0, Duration = 0.2 })	

	SetAlpha({ Id = button.Screen.Components.LocationIconBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.LocationIcon.Id, Fraction = 0.0, Duration = 0.2 })

	SetAlpha({ Id = button.Screen.Components.WeaponIconBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.WeaponIcon.Id, Fraction = 0.0, Duration = 0.2 })

	SetAlpha({ Id = button.Screen.Components.KeepsakeIconBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.KeepsakeIcon.Id, Fraction = 0.0, Duration = 0.2 })

	for i = 1, 5 do
		local intensityComponent = screen.Components["IntensityEye"..i]
		SetAnimation({ DestinationId = intensityComponent.Id, Name = intensityComponent.Data.AnimationName })
		if i >= 2 then
			local intensityFlameComponent = screen.Components["IntensityEye"..i.."Flame"]
			SetAlpha({ Id = intensityFlameComponent.Id, Fraction = 0.0, Duration = 0.3 })
		end
	end
	
	SetAlpha({ Id = button.Screen.Components.RewardText.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.ClearMessage.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })

	SetAnimation({ DestinationId = screen.Components.SelectionMarker.Id, Name = "ChaosTrialMouseHighlightOut" }) --nopkg

	thread( BountyScreenUpdateIntensityEyes, screen )

	wait( 0.2 )
	if screen.MouseOverButton == nil then
		ModifyTextBox({ Id = button.Screen.Components.ItemTitleText.Id, Text = button.Screen.Components.ItemTitleText.Data.Text })
		ModifyTextBox({ Id = button.Screen.Components.DescriptionText.Id, Text = button.Screen.Components.ItemTitleText.Data.Text, UseDescription = true, })
		SetAlpha({ Id = button.Screen.Components.ItemTitleText.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.DescriptionText.Id, Fraction = 1.0, Duration = 0.2 })
	end
	
end

function BountyScreenScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	WeaponShopUpdateVisibility( screen )
	GenericScrollPresentation( screen, button )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function BountyScreenScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	WeaponShopUpdateVisibility( screen )
	GenericScrollPresentation( screen, button )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function CheckShrineBounties()
	local bountyData = BountyData[GameState.ActiveShrineBounty]
	if bountyData == nil or not Contains( bountyData.Encounters, CurrentRun.CurrentRoom.Encounter.Name ) then
		return
	end
	if not IsGameStateEligible( bountyData, bountyData.UnlockGameStateRequirements ) or not IsGameStateEligible( bountyData, bountyData.CompleteGameStateRequirements ) then
		return
	end

	wait( 0.5, RoomThreadName )
	thread( ShrineBountyEarnedPresentation, bountyData )
	GiveRandomConsumables(
	{
		LootOptions = bountyData.LootOptions,
		AddUnthreadedOnUseEvent =
		{
			FunctionName = "MarkShrineBountyComplete",
			Args = { BountyName = bountyData.Name },
		},
		ForceToValidLocation = true,
		KeepCollision = true,
	})
	thread( CheckQuestStatus )
	wait( 0.5, RoomThreadName )
end

function CheckPackagedBountyCompletion()

	local bountyData = BountyData[CurrentRun.ActiveBounty]
	if bountyData == nil or not Contains( bountyData.Encounters, CurrentRun.CurrentRoom.Encounter.Name ) then
		return false
	end

	AddInputBlock({ Name = "BountyComplete" })
	SetPlayerInvulnerable( "BountyComplete" )
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "StopsProjectiles", Value = false })

	PackagedBountyEarnedPresentation( bountyData )

	GameState.PackagedBountyClears[bountyData.Name] = (GameState.PackagedBountyClears[bountyData.Name] or 0) + 1
	CurrentRun.ActiveBountyClears = (CurrentRun.ActiveBountyClears or 0) + 1

	local currentStreak = (GameState.PackagedBountyClearStreak[bountyData.Name] or 0) + 1
	GameState.PackagedBountyClearStreak[bountyData.Name] = currentStreak
	local prevBestStreak = GameState.PackagedBountyHighestClearStreak[bountyData.Name] or 0
	if currentStreak > prevBestStreak then
		GameState.PackagedBountyHighestClearStreak[bountyData.Name] = currentStreak
	end

	if bountyData.RandomBountyStreakEligible then
		GameState.RandomBountyClearStreak = GameState.RandomBountyClearStreak + 1
		if GameState.RandomBountyClearStreak > GameState.RandomBountyHighestClearStreak then
			GameState.RandomBountyHighestClearStreak = GameState.RandomBountyClearStreak
		end
	end

	local prevBestClearTime = GameState.PackagedBountyClearRecordTime[bountyData.Name] or 999999
	if CurrentRun.GameplayTime < prevBestClearTime then
		GameState.PackagedBountyClearRecordTime[bountyData.Name] = CurrentRun.GameplayTime
	end

	SetPlayerVulnerable( "BountyComplete" )
	RemoveInputBlock({ Name = "BountyComplete" })

	thread( EndBountyRunPresentation )
	thread( CheckQuestStatus )
	return true

end

function CheckRandomBounties()
	local bountyData = BountyData[CurrentRun.ActiveBounty]
	if bountyData == nil or bountyData.LootOptions == nil or not Contains( bountyData.Encounters, CurrentRun.CurrentRoom.Encounter.Name ) then
		return
	end
	wait( 0.5, RoomThreadName )
	GiveRandomConsumables(
	{
		LootOptions = bountyData.LootOptions,
		ForceToValidLocation = true,
		KeepCollision = true,
	})
end

function MarkShrineBountyComplete( source, args )
	CurrentRun.ShrineBountiesCompleted[args.BountyName] = true
	GameState.ShrineBountiesCompleted[args.BountyName] = true
	GameState.ActiveShrineBounty = nil
end

function StoredGameStateInit( originalState )
	StoredGameState = {}
	StoredGameState.PrimaryWeaponName = originalState.PrimaryWeaponName
	StoredGameState.LastWeaponUpgradeName = ShallowCopyTable( originalState.LastWeaponUpgradeName ) or {}
	StoredGameState.LastAwardTrait = originalState.LastAwardTrait
	StoredGameState.EquippedFamiliar = originalState.EquippedFamiliar
	StoredGameState.ShrineUpgrades = ShallowCopyTable( originalState.ShrineUpgrades ) or {}
	StoredGameState.ActiveShrineBounty = originalState.ActiveShrineBounty
	StoredGameState.MetaUpgradeState = DeepCopyTable( originalState.MetaUpgradeState ) or {}
end

function StartPackagedBounty( screen, button )
	AddInputBlock({ Name = "StartPackagedBounty" })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeIdleWeaponless" })
	CloseBountyBoardScreen( screen, button )

	local bountyData = button.Data

	StoredGameStateInit( GameState )

	if GameState.NextRunSeed ~= nil then
		RandomSetNextInitSeed( { Seed = GameState.NextRunSeed } )
		GameState.NextRunSeed = nil
	end
	RandomSynchronize()

	if not bountyData.RandomBountyStreakEligible then
		GameState.RandomBountyClearStreak = 0
	end
	
	if bountyData.WeaponKitName ~= nil then
		EquipPlayerWeapon( WeaponData[bountyData.WeaponKitName], { SkipPresentation = true } )
	elseif bountyData.RandomWeaponKitNames ~= nil then
		local eligibleWeaponKitNames = ShallowCopyTable( bountyData.RandomWeaponKitNames )
		RemoveValueAndCollapse( eligibleWeaponKitNames, GameState.LastRandomBountyWeaponName )
		local randomWeaponName = GetRandomValue( eligibleWeaponKitNames )
		GameState.LastRandomBountyWeaponName = randomWeaponName
		EquipPlayerWeapon( WeaponData[randomWeaponName], { SkipPresentation = true } )
	end
	if bountyData.WeaponUpgradeName ~= nil then
		local weaponName = GetEquippedWeapon()
		if HasAnyAspectUnlocked( weaponName ) then
			GameState.LastWeaponUpgradeName[weaponName] = bountyData.WeaponUpgradeName
		end
	elseif bountyData.UseRandomWeaponUpgrade then
		local weaponName = GetEquippedWeapon()
		GameState.LastWeaponUpgradeName[weaponName] = GetRandomValue( ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName] )
	end
	
	if bountyData.KeepsakeName ~= nil then
		GameState.LastAwardTrait = bountyData.KeepsakeName
	elseif bountyData.RandomKeepsakeNames ~= nil then
		local eligibleKeepsakeNames = CombineTables( bountyData.RandomKeepsakeNames, bountyData.RandomFatedKeepsakeNames )
		RemoveValueAndCollapse( eligibleKeepsakeNames, GameState.LastRandomBountyKeepsakeName )
		GameState.LastAwardTrait = GetRandomValue( eligibleKeepsakeNames )
		GameState.LastRandomBountyKeepsakeName = GameState.LastAwardTrait
	end

	if bountyData.RemoveFamiliar then
		GameState.EquippedFamiliar = nil
	elseif bountyData.FamiliarName ~= nil then
		GameState.EquippedFamiliar = bountyData.FamiliarName
	elseif bountyData.RandomFamiliarNames ~= nil then
		GameState.EquippedFamiliar = GetRandomValue( bountyData.RandomFamiliarNames )
	end

	-- Clear all non-specified ShrineUpgrades
	for shrineUpgradeName, shrineUpgradeLevel in pairs( GameState.ShrineUpgrades ) do
		GameState.ShrineUpgrades[shrineUpgradeName] = 0
	end
	if bountyData.ShrineUpgradesActive ~= nil then
		for shrineUpgradeName, shrineUpgradeLevel in pairs( bountyData.ShrineUpgradesActive ) do
			GameState.ShrineUpgrades[shrineUpgradeName] = shrineUpgradeLevel
		end
	elseif bountyData.RandomShrineUpgradePointTotal ~= nil then
		-- For now, mark all purely 1-pointer upgrades as reserved.
		-- We may need them later to fill in gaps.
		local reservedShrineUpgrades = {}
		local totalReservedPoints = 0
		for i, name in ipairs( ShrineUpgradeOrder ) do
			local shrineUpgradeData = MetaUpgradeData[name]
			if not shrineUpgradeData.IgnoredByRandomBounties then
				local pointSum = 0
				for j, rank in ipairs( shrineUpgradeData.Ranks ) do
					if rank.Points == 1 then
						pointSum = pointSum + 1
					end
				end
				if pointSum == #shrineUpgradeData.Ranks then
					reservedShrineUpgrades[name] = pointSum
					totalReservedPoints = totalReservedPoints + pointSum
				end
			end
		end

		-- We only need to reserve 3 shrine points, so let's whittle down the list.
		local maxPointsPerRank = 3
		DebugAssert({ Condition = totalReservedPoints >= maxPointsPerRank, Text = "Not enough potential reserves!", Owner = "Caleb" })
		while totalReservedPoints > maxPointsPerRank do
			local shrineUpgrade = GetRandomKey( reservedShrineUpgrades )
			reservedShrineUpgrades[shrineUpgrade] = reservedShrineUpgrades[shrineUpgrade] - 1
			totalReservedPoints = totalReservedPoints - 1
			if reservedShrineUpgrades[shrineUpgrade] <= 0 then
				reservedShrineUpgrades[shrineUpgrade] = nil
			end
		end

		-- Determine the available list of shrine upgrades (excluding reserved ranks)
		local availableShrineUpgradeRanks = {}
		for i, name in ipairs( ShrineUpgradeOrder ) do
			local shrineUpgradeData = MetaUpgradeData[name]
			if not shrineUpgradeData.IgnoredByRandomBounties then
				local maxRank = GetShrineUpgradeMaxRank( shrineUpgradeData ) - (reservedShrineUpgrades[name] or 0)
				if maxRank > 0 then
					availableShrineUpgradeRanks[name] = maxRank
				end
			end
		end

		local budget = bountyData.RandomShrineUpgradePointTotal
		local currentCostTotal = 0
		while currentCostTotal < budget do
			local outOfOptions = IsEmpty( availableShrineUpgradeRanks )
			if outOfOptions and reservedShrineUpgrades == nil then
				-- This should never happen, but just in case, prevent an infinite loop...
				DebugAssert({ Condition = false, Text = "Ran completely out of shrine point options!", Owner = "Caleb" })
				break
			end

			-- If we're out of affordable options, or if we're close to the budget, add the reserves to the pool.
			if reservedShrineUpgrades ~= nil and ( outOfOptions or (budget - currentCostTotal) <= maxPointsPerRank ) then
				for name, ranks in pairs( reservedShrineUpgrades ) do
					availableShrineUpgradeRanks[name] = (availableShrineUpgradeRanks[name] or 0) + ranks
				end
				reservedShrineUpgrades = nil
			end

			-- Pick a random upgrade to level up.
			-- If we can't afford it, we'll remove it from the pool and pick something else.
			local randomUpgradeName = GetRandomKey( availableShrineUpgradeRanks )
			local currentLevel = GameState.ShrineUpgrades[randomUpgradeName] or 0
			local nextCost = MetaUpgradeData[randomUpgradeName].Ranks[currentLevel + 1].Points
			if currentCostTotal + nextCost > budget then
				-- priced out, remove the upgrade from the pool!
				availableShrineUpgradeRanks[randomUpgradeName] = nil
			else
				-- purchased!
				availableShrineUpgradeRanks[randomUpgradeName] = availableShrineUpgradeRanks[randomUpgradeName] - 1
				if availableShrineUpgradeRanks[randomUpgradeName] <= 0 then
					-- maxed out, remove the upgrade from the pool!
					availableShrineUpgradeRanks[randomUpgradeName] = nil
				end
				GameState.ShrineUpgrades[randomUpgradeName] = (GameState.ShrineUpgrades[randomUpgradeName] or 0) + 1
				currentCostTotal = currentCostTotal + nextCost
			end
		end
	end
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	GameState.ActiveShrineBounty = nil

	-- Clear all non-specified MetaUpgrades
	for metaUpgradeName, metaUpgradeState in pairs( GameState.MetaUpgradeState ) do
		GameState.MetaUpgradeState[metaUpgradeName].Equipped = false
	end
	if bountyData.MetaUpgradeStateEquipped ~= nil then
		for k, metaUpgradeName in pairs( bountyData.MetaUpgradeStateEquipped ) do
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
		end
	elseif bountyData.RandomMetaUpgradeCostTotal ~= nil then
		-- Gather all non-AutoEquip cards that don't conflict with the keepsake
		local metaUpgradeNames = {}
		for rowNum, upgradeNames in pairs( MetaUpgradeDefaultCardLayout ) do
			for i, upgradeName in ipairs( upgradeNames ) do
				if MetaUpgradeCardData[upgradeName].AutoEquipRequirements == nil then
					if not FatedEnableKeepsakes[GameState.LastAwardTrait] or not FatedDisableMetaUpgrades[upgradeName] then
						table.insert( metaUpgradeNames, upgradeName )
					end
				end
			end
		end

		-- Sum up their Grasp costs
		local totalGraspCost = 0
		for i, upgradeName in ipairs( metaUpgradeNames ) do
			totalGraspCost = totalGraspCost + MetaUpgradeCardData[upgradeName].Cost
		end

		-- Use a recursive subset-sum algorithm to determine a random combination of cards summing up to the budget
		local budget = bountyData.RandomMetaUpgradeCostTotal
		local cardState = {}
		local equippedGraspCost = 0
		RandomBountyProcessMetaUpgrades( 0, totalGraspCost, 0, budget, metaUpgradeNames, cardState )
		for i, enabled in ipairs( cardState ) do
			if enabled then
				GameState.MetaUpgradeState[metaUpgradeNames[i]].Equipped = true
				equippedGraspCost = equippedGraspCost + MetaUpgradeCardData[metaUpgradeNames[i]].Cost
			end
		end
		DebugAssert({ Condition = (equippedGraspCost == budget), Text = "Equipped grasp for random Arcana does not match budget!", Owner = "Caleb" })
		CheckAutoEquipCards()
	end
	GetCurrentMetaUpgradeCost()

	-- Bounties shouldn't have biome states unless explicitly provided
	if GameState.NextBiomeStateName ~= nil then
		local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
		if biomeStateData ~= nil and biomeStateData.BiomeEndPresentationFunctionName ~= nil then
			thread( CallFunctionName, biomeStateData.BiomeEndPresentationFunctionName )
		end
	end
	GameState.NextBiomeStateName = bountyData.ForcedBiomeState or BiomeStateData.DefaultBiomeState

	GameState.PackagedBountyAttempts[bountyData.Name] = (GameState.PackagedBountyAttempts[bountyData.Name] or 0) + 1
	
	BountyPackagePreRunStartPresentation( bountyData, { ActiveBounty = bountyData.Name, ActiveBountyClears = GameState.PackagedBountyClears[bountyData.Name] or 0, ActiveBountyAttempts = GameState.PackagedBountyAttempts[bountyData.Name] } )
	WaitForSpeechFinished()

	StartOver( { StartingBiome = bountyData.StartingBiome, ForcedRewards = bountyData.ForcedRewards, ActiveBounty = bountyData.Name, RunOverrides = bountyData.RunOverrides, StartingRoomOverrides = bountyData.StartingRoomOverrides  } )
	RemoveInputBlock({ Name = "StartPackagedBounty" })
end

function RestorePackagedBountyGameState()
	if StoredGameState == nil then
		return
	end

	EquipPlayerWeapon( WeaponData[StoredGameState.PrimaryWeaponName], { SkipPresentation = true, SkipAnimSwap = true, } )
	GameState.LastWeaponUpgradeName = StoredGameState.LastWeaponUpgradeName
	GameState.LastAwardTrait = StoredGameState.LastAwardTrait
	GameState.EquippedFamiliar = StoredGameState.EquippedFamiliar
	GameState.ShrineUpgrades = StoredGameState.ShrineUpgrades
	GameState.ActiveShrineBounty = StoredGameState.ActiveShrineBounty
	GameState.MetaUpgradeState = StoredGameState.MetaUpgradeState

	GetCurrentMetaUpgradeCost()
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()

	StoredGameState = nil
end

function RandomBountyProcessMetaUpgrades( sum, remaining, index, budget, candidates, cardState )
	if sum > budget or (sum+remaining) < budget then
		return false
	end
	if sum == budget then
		return true
	end
	if index < #candidates then
		local nextCost = MetaUpgradeCardData[candidates[index + 1]].Cost
		if CoinFlip() then
			cardState[index + 1] = true
			if RandomBountyProcessMetaUpgrades( sum + nextCost, remaining - nextCost, index + 1, budget, candidates, cardState ) then
				return true
			end
			cardState[index + 1] = false
			if RandomBountyProcessMetaUpgrades( sum, remaining - nextCost, index + 1, budget, candidates, cardState ) then
				return true
			end
		else
			cardState[index + 1] = false
			if RandomBountyProcessMetaUpgrades( sum, remaining - nextCost, index + 1, budget, candidates, cardState ) then
				return true
			end
			cardState[index + 1] = true
			if RandomBountyProcessMetaUpgrades( sum + nextCost, remaining - nextCost, index + 1, budget, candidates, cardState ) then
				return true
			end
			cardState[index + 1] = false
		end
	end
	return false
end

function LoadActiveBountyPackages()
	if CurrentRun.ActiveBounty ~= nil then
		local bountyData = BountyData[CurrentRun.ActiveBounty]
		local lootSources = {}
		if bountyData ~= nil and bountyData.StartingTraits ~= nil then
			for _, traitData in ipairs( bountyData.StartingTraits ) do
				for lootName, lootData in pairs( LootData ) do
					if lootData.TraitIndex[traitData.Name] then
						lootSources[lootName] = true
						break
					end
				end
			end
		end
		for sourceLootName, v in pairs( lootSources ) do
			LoadPackages({ Name = sourceLootName, IgnoreAssert = true })
		end
	end
end
