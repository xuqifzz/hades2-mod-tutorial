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

	local categoryTitleX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
			--[[
			local slotName = category.Name
			screen.Components["Category"..slotName] = CreateScreenComponent({ Name = "ResourceShopTab", X = categoryTitleX, Y = screen.CategoryStartY, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu_Overlay" })
			screen.Components["Category"..slotName].OnPressedFunctionName = "BountyBoardScreenSelectCategory"
			screen.Components["Category"..slotName].Category = slotName
			screen.Components["Category"..slotName].CategoryIndex = categoryIndex
			CreateTextBox({ Id = screen.Components["Category"..slotName].Id,
				Text = slotName,
				FontSize = 22,
				Color = Color.CodexTitleUnselected,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center"
			})
			if categoryIndex ~= screen.ActiveCategoryIndex and HasUnviewedBounty( category ) then
				-- New icon
				local newButtonKey = "NewIcon"..slotName
				components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
				SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "NewTabStar" })
				Attach({ Id = components[newButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = 0, OffsetY = -34 })
			end
			]]
		else
			category.Locked = true
			if categoryIndex == screen.ActiveCategoryIndex then
				screen.ActiveCategoryIndex = screen.ActiveCategoryIndex + 1
			end
		end

		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	wait(0.1)

	BountyBoardScreenDisplayCategory( screen, screen.ActiveCategoryIndex )
	WeaponShopUpdateVisibility( screen )

	BountyBoardOpenedPresentation( screen )

	wait(0.1)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	if not hasViewed then
		GenericInfoPresentation( screen )
	end

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

	thread( MarkObjectiveComplete, "BountyPrompt" )

end

function HasUnviewedBounty( source, args )
	for k, itemName in ipairs( ScreenData.BountyBoard.ItemCategories[1] ) do
		local bountyData = BountyData[itemName]
		if not GameState.QuestsViewed[itemName] and IsGameStateEligible( CurrentRun, bountyData, bountyData.UnlockGameStateRequirements ) then
			return true
		end
	end
	return false
end

function BountyBoardScreenDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	local slotName = screen.ItemCategories[categoryIndex].Name
	--ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })
	--DestroyTextBox({ Id = components.BackgroundDim.Id })

	--[[
	local newButtonKey = "NewIcon"..slotName
	if components[newButtonKey] ~= nil then
		SetAlpha({ Id = components[newButtonKey].Id, Fraction = 0.0, Duration = 0.1 })
	end
	]]

	-- Cleanup prev category
	--[[
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	for i, resourceName in ipairs( prevCategory ) do
		if components[resourceName] ~= nil then
			Destroy({ Id = components[resourceName].Id })
		end
	end
	ModifyTextBox({ Id = screen.Components["Category"..prevCategory.Name].Id, Color = Color.CodexTitleUnselected })
	]]

	local category = screen.ItemCategories[categoryIndex]
	local slotName = category.Name

	-- Highlight new category
	--ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })

	screen.ActiveCategoryIndex = categoryIndex

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local activeBounties = {}
	local completedBounties = {}
	local ineligibleBounties = {}

	for i, bountyName in ipairs( screen.ItemCategories[screen.ActiveCategoryIndex]  ) do
		local bountyData = BountyData[bountyName]
		if not bountyData.DebugOnly then

			bountyData.BestClearTime = 5999.99
			bountyData.BestClearTimeString = GetTimerString( bountyData.BestClearTime, 2 )
			local allRuns = ShallowCopyTable( GameState.RunHistory )
			table.insert( allRuns, CurrentRun )
			for runIndex, run in pairs( allRuns ) do
				if run.BountyCleared and run.ActiveBounty == bountyData.Name and run.GameplayTime < bountyData.BestClearTime then
					bountyData.BestClearTime = run.GameplayTime
					bountyData.BestClearTimeString = GetTimerString( bountyData.BestClearTime, 2 )
				end
			end

			if GameState.BountiesCompleted[bountyName] then
				table.insert( completedBounties, bountyData )
			elseif IsGameStateEligible( CurrentRun, bountyData, bountyData.UnlockGameStateRequirements ) then
				table.insert( activeBounties, bountyData )
			else
				table.insert( ineligibleBounties, bountyData )
			end
		end
	end

	local firstUseable = false
	screen.NumItems = 0

	for k, bountyData in ipairs( activeBounties ) do

		-- BountyButton
		screen.NumItems = screen.NumItems + 1
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
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

		if IsGameStateEligible( CurrentRun, bountyData, bountyData.CompleteGameStateRequirements ) then
			local activeFlash = screen.ActiveFlash
			activeFlash.Id = button.Id
			Flash( activeFlash )
		end

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end

	--[[
	for k, bountyData in ipairs( ineligibleBounties ) do

		-- BountyButton
		screen.NumItems = screen.NumItems + 1
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
		button.OnMouseOverFunctionName = "MouseOverBounty"
		button.OnMouseOffFunctionName = "MouseOffBounty"
		button.OnPressedFunctionName = "BountyBoardIneligiblePresentation"
		button.Data = bountyData
		button.Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = button.Id, Table = button })
		local bountyButtonKey = screen.ButtonName..screen.NumItems
		components[bountyButtonKey] = button

		local ineligibleFormat = screen.IneligibleFormat
		ineligibleFormat.Id = button.Id
		ineligibleFormat.Text = bountyData.Text or bountyData.Name
		ineligibleFormat.LuaKey = "TempTextData"
		ineligibleFormat.LuaValue = bountyData
		CreateTextBox( ineligibleFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end
	]]

	for k, bountyData in ipairs( completedBounties ) do

		-- BountyButton
		screen.NumItems = screen.NumItems + 1
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
		if bountyData.Repeatable then
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

function BountyBoardScreenSelectCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	AddInputBlock({ Name = "WeaponShopScreenSelectCategory" })
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	BountyBoardScreenDisplayCategory( screen, button.CategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	RemoveInputBlock({ Name = "WeaponShopScreenSelectCategory" })
end

function BountyBoardScreenNextCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex
	for i = 1, #screen.ItemCategories do
		nextCategoryIndex = nextCategoryIndex + 1
		if nextCategoryIndex > #screen.ItemCategories then
			nextCategoryIndex = 1
		end
		if not screen.ItemCategories[nextCategoryIndex].Locked then
			break
		end
	end
	if nextCategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	AddInputBlock({ Name = "WeaponShopScreenSelectCategory" })
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	BountyBoardScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	RemoveInputBlock({ Name = "WeaponShopScreenSelectCategory" })
end

function BountyBoardScreenPrevCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex
	for i = 1, #screen.ItemCategories do
		nextCategoryIndex = nextCategoryIndex - 1
		if nextCategoryIndex < 1 then
			nextCategoryIndex =  #screen.ItemCategories
		end
		if not screen.ItemCategories[nextCategoryIndex].Locked then
			break
		end
	end
	if nextCategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	AddInputBlock({ Name = "WeaponShopScreenSelectCategory" })
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	BountyBoardScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	RemoveInputBlock({ Name = "WeaponShopScreenSelectCategory" })
end

function CloseBountyBoardScreen( screen, button )
	if screen.CloseAnimation ~= nil then
		SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	end
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	thread( CheckProgressAchievements )

end

function MouseOverBounty( button )

	local screen = button.Screen
	screen.MouseOverButton = button

	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })

	Teleport({ Id = screen.Components.SelectionMarker.Id, DestinationId = button.Id, OffsetX = screen.Components.SelectionMarker.Data.ButtonOffsetX, OffsetY = screen.Components.SelectionMarker.Data.ButtonOffsetY })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 1.0, Duration = 0.2 })

	GenericMouseOverPresentation( button )

	SetAlpha({ Id = button.Screen.Components.ItemTitleText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.ItemTitleText.Id, Text = button.Data.Name })

	SetAlpha({ Id = button.Screen.Components.DescriptionText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.DescriptionText.Id, Text = button.Data.Name, UseDescription = true, })

	for i = 1, 5 do
		local intensityComponent = screen.Components["IntensityEye"..i]
		if (button.Data.DifficultyRating or 0) >= i then
			SetAnimation({ DestinationId = intensityComponent.Id, Name = intensityComponent.Data.ActiveAnimationName })
		else
			SetAnimation({ DestinationId = intensityComponent.Id, Name = intensityComponent.Data.AnimationName })
		end
	end

	-- Location
	if button.Data.StartingBiome ~= nil then
		SetAlpha({ Id = button.Screen.Components.LocationIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.LocationIcon.Id, Fraction = 1.0, Duration = 0.2 })
		local baseRoomData = RoomSetData[button.Data.StartingBiome]["Base"..button.Data.StartingBiome]
		SetAnimation({ DestinationId = button.Screen.Components.LocationIcon.Id, Name = button.Data.BiomeIcon or baseRoomData.Icon })
		ModifyTextBox({ Id = button.Screen.Components.LocationIcon.Id, Text = button.Data.BiomeText or "Biome"..button.Data.StartingBiome })
	end

	-- Weapon
	if button.Data.WeaponKitName ~= nil then
		SetAlpha({ Id = button.Screen.Components.WeaponIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.WeaponIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.WeaponIcon.Id, Name = (WeaponShopItemData[button.Data.WeaponUpgradeName] or WeaponShopItemData[button.Data.WeaponKitName]).Icon })
		local weaponName = button.Data.WeaponKitName
		if GameState.WorldUpgrades.WorldUpgradeWeaponUpgradeSystem and button.Data.WeaponUpgradeName ~= nil then
			weaponName = button.Data.WeaponUpgradeName
		end
		ModifyTextBox({ Id = button.Screen.Components.WeaponIcon.Id, Text = weaponName })
	elseif button.Data.RandomWeaponKitNames ~= nil then
		SetAlpha({ Id = button.Screen.Components.WeaponIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.WeaponIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.WeaponIcon.Id, Name = "Weapon_Random" })
		ModifyTextBox({ Id = button.Screen.Components.WeaponIcon.Id, Text = "BountyBoard_RandomWeapon" })
	end

	-- Keepsake
	if button.Data.KeepsakeName ~= nil then
		SetAlpha({ Id = button.Screen.Components.KeepsakeIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.KeepsakeIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.KeepsakeIcon.Id, Name = TraitData[button.Data.KeepsakeName].Icon })
		ModifyTextBox({ Id = button.Screen.Components.KeepsakeIcon.Id, Text = button.Data.KeepsakeName })
	elseif button.Data.RandomKeepsakeNames ~= nil then
		SetAlpha({ Id = button.Screen.Components.KeepsakeIconBacking.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.KeepsakeIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = button.Screen.Components.KeepsakeIcon.Id, Name = "Keepsake_Random" })
		ModifyTextBox({ Id = button.Screen.Components.KeepsakeIcon.Id, Text = "BountyBoard_RandomKeepsake" })
	end

	-- Reward
	local rewardColor = screen.RewardAvailableColor
	local rewardText = screen.Components.RewardText.Data.Text
	if GameState.BountiesCompleted[button.Data.Name] then
		rewardColor = screen.RewardCashedOutColor
		rewardText = screen.Components.RewardText.Data.CompletedText
	elseif IsGameStateEligible( CurrentRun, button.Data, button.Data.UnlockGameStateRequirements ) then
		if IsGameStateEligible( CurrentRun, button.Data, button.Data.CompleteGameStateRequirements ) then
			SetAlpha({ Id = button.Screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end

	-- Reward string
	local dropData = ConsumableData[button.Data.ForcedReward or button.Data.LootOptions[1].Name]
	local resourceName = GetFirstKey( dropData.AddResources )
	local resourceAmount = 1
	if BountyData[button.Data.Name].LootOptions ~= nil then
		resourceAmount = BountyData[button.Data.Name].LootOptions[1].Overrides.AddResources[resourceName]
	end
	local resourceData = ResourceData[resourceName]
	SetAlpha({ Id = button.Screen.Components.RewardText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.RewardText.Id, 
		Text = rewardText,
		LuaKey = "TempTextData",
		LuaValue = { Icon = resourceData.IconPath, Amount = resourceAmount },
		Color = rewardColor,
		})

	local newButtonKey = "NewIcon"..button.Index
	if button.Screen.Components[newButtonKey] ~= nil then
		SetAlpha({ Id = button.Screen.Components[newButtonKey].Id, Fraction = 0, Duration = 0.2 })
	end
	GameState.QuestsViewed[button.Data.Name] = true

	-- Unlock hint / requirements
	local bountyName = button.Data.Name
	if not IsGameStateEligible( CurrentRun, button.Data, button.Data.UnlockGameStateRequirements ) and not GameState.BountiesCompleted[bountyName] then
		SetAlpha({ Id = button.Screen.Components.UnlockHint.Id, Fraction = 1.0, Duration = 0.2 })	
		--ShowQuestProgress( button.Screen, button.Data, button.Data.UnlockGameStateRequirements )
	end

	-- Clear hint / clear message
	if GameState.BountiesCompleted[bountyName] then
		SetAlpha({ Id = button.Screen.Components.ClearMessage.Id, Fraction = 1.0, Duration = 0.2 })	
		ModifyTextBox({ Id = button.Screen.Components.ClearMessage.Id, LuaKey = "TempTextData", LuaValue = button.Data })
		--ShowQuestProgress( button.Screen, button.Data, button.Data.UnlockGameStateRequirements )
	end
end

function MouseOffBounty( button )
	local screen = button.Screen
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

	--SetAlpha({ Id = button.Screen.Components.DifficultyText.Id, Fraction = 0.0, Duration = 0.2 })
	for i = 1, 5 do
		local intensityComponent = screen.Components["IntensityEye"..i]
		SetAnimation({ DestinationId = intensityComponent.Id, Name = intensityComponent.Data.AnimationName })
	end
	
	SetAlpha({ Id = button.Screen.Components.RewardText.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.UnlockHint.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.ClearMessage.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })

	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 0.0, Duration = 0.2 })

	wait( 0.2 )
	if screen.MouseOverButton == nil then
		ModifyTextBox({ Id = button.Screen.Components.ItemTitleText.Id, Text = button.Screen.Components.ItemTitleText.Data.Text })
		ModifyTextBox({ Id = button.Screen.Components.DescriptionText.Id, Text = button.Screen.Components.ItemTitleText.Data.Text, UseDescription = true, })
		SetAlpha({ Id = button.Screen.Components.ItemTitleText.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = button.Screen.Components.DescriptionText.Id, Fraction = 1.0, Duration = 0.2 })
	end
	
end

function CheckBounties( source, args )
	args = args or {}

	local completedBountyData = {}

	for bountyName, bountyData in pairs( BountyData ) do
		if not bountyData.DebugOnly then
			if bountyData.RequireActiveForRun == nil or ( bountyData.Name == CurrentRun.ActiveBounty and GameState.ScreensViewed.BountyBoard ) then
				if not GameState.BountiesCompleted[bountyName] or bountyData.Repeatable then
					if (bountyData.Encounter == CurrentRun.CurrentRoom.Encounter.Name or bountyData.Room == CurrentRun.CurrentRoom.Name) then
						if IsGameStateEligible( CurrentRun, source, bountyData.UnlockGameStateRequirements ) and IsGameStateEligible( CurrentRun, source, bountyData.CompleteGameStateRequirements ) then
							table.insert( completedBountyData, bountyData )
						end
					end
				end
			end
		end
	end

	local endingRun = false
	for i, bountyData in ipairs( completedBountyData ) do
		if GameState.BountiesCompleted[bountyData.Name] and bountyData.Repeatable then
			-- Previously completed
			--AddInputBlock({ Name = "PreviouslyCompleteBounty" })
			BountyEarnedPresentation( bountyData, args )
			MarkBountyComplete( source, { BountyName = bountyData.Name } )
			--RemoveInputBlock({ Name = "PreviouslyCompleteBounty" })
		else
			if bountyData.LootOptions ~= nil then
				args.LootOptions = bountyData.LootOptions
				args.AddUnthreadedOnUseEvent =
				{
					FunctionName = "MarkBountyComplete",
					Args = { BountyName = bountyData.Name },
				}
				args.Delay = bountyData.LootDelay
				args.ForceToValidLocation = true
				args.KeepCollision = true
				thread( GiveRandomConsumables, args )
				BountyEarnedPresentation( bountyData, args )
			else
				AddInputBlock({ Name = "BountyComplete" })
				BountyEarnedPresentation( bountyData, args )
				MarkBountyComplete( source, { BountyName = bountyData.Name } )
				RemoveInputBlock({ Name = "BountyComplete" })
			end
		end
		if bountyData.EndRunOnCompletion then
			endingRun = true
		end
	end
	
	thread( CheckQuestStatus )
	return endingRun

end

function MarkBountyComplete( source, args )
	CurrentRun.BountiesCompleted[args.BountyName] = true
	GameState.BountiesCompleted[args.BountyName] = true
	local bountyData = BountyData[args.BountyName]
	if bountyData ~= nil then
		if bountyData.IsPackagedBounty then
			GameState.PackagedBountyClears[args.BountyName] = (GameState.PackagedBountyClears[args.BountyName] or 0) + 1
			if args.BountyName == CurrentRun.ActiveBounty then
				CurrentRun.ActiveBountyClears = (CurrentRun.ActiveBountyClears or 0) + 1
			end
		end
		if bountyData.EndRunOnCompletion then
			thread( EndBountyRunPresentation, bountyData )
		end
	end
	if args.BountyName == GameState.ActiveShrineBounty then
		GameState.ActiveShrineBounty = nil
	end
end

function HasEligibleBounty( source, args )
	if not GameState.ScreensViewed.BountyBoard then
		return false
	end
	
	for bountyName, bountyData in pairs( BountyData ) do
		if not GameState.BountiesCompleted[bountyName] or bountyData.Repeatable then
			if (bountyData.Encounter == CurrentRun.CurrentRoom.Encounter.Name or bountyData.Room == CurrentRun.CurrentRoom.Name) and not bountyData.DebugOnly and
				IsGameStateEligible( CurrentRun, source, bountyData.UnlockGameStateRequirements) and IsGameStateEligible( CurrentRun, source, bountyData.CompleteGameStateRequirements ) then
					return true
			end
		end
	end
	return false
end

function StartPackagedBounty( screen, button )
	AddInputBlock({ Name = "StartPackagedBounty" })
	CloseBountyBoardScreen( screen, button )

	local bountyData = button.Data

	StoredGameState = DeepCopyTable( GameState )	
	
	if bountyData.WeaponKitName ~= nil then
		EquipPlayerWeapon( WeaponData[bountyData.WeaponKitName], { SkipPresentation = true } )
	elseif bountyData.RandomWeaponKitNames ~= nil then
		local randomWeaponName = GetRandomValue( bountyData.RandomWeaponKitNames )
		EquipPlayerWeapon( WeaponData[randomWeaponName], { SkipPresentation = true } )
	end
	if bountyData.WeaponUpgradeName ~= nil then
		local weaponName = GetEquippedWeapon()
		if HasAnyAspectUnlocked( weaponName ) then
			GameState.LastWeaponUpgradeName[weaponName] = bountyData.WeaponUpgradeName
		end
	end
	
	if bountyData.KeepsakeName ~= nil then
		GameState.LastAwardTrait = bountyData.KeepsakeName
	elseif bountyData.RandomKeepsakeNames ~= nil then
		GameState.LastAwardTrait = GetRandomValue( bountyData.RandomKeepsakeNames )
	end

	if bountyData.RemoveFamiliar then
		GameState.EquippedFamiliar = nil
	elseif bountyData.FamiliarName ~= nil then
		GameState.EquippedFamiliar = bountyData.FamiliarName
	elseif bountyData.RandomFamiliarNames ~= nil then
		GameState.EquippedFamiliar = GetRandomValue( bountyData.RandomFamiliarNames )
	end

	if bountyData.MetaUpgradeStateEquipped ~= nil then
		-- Clear all non-specified MetaUpgrades
		for metaUpgradeName, metaUpgradeState in pairs( GameState.MetaUpgradeState ) do
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = false
		end
		for k, metaUpgradeName in pairs( bountyData.MetaUpgradeStateEquipped ) do
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
		end
	elseif bountyData.RandomMetaUpgradeCostTotal ~= nil then
		-- Clear all non-specified MetaUpgrades
		for metaUpgradeName, metaUpgradeState in pairs( GameState.MetaUpgradeState ) do
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = false
		end
		local currentCostTotal = 0
		local allMetaUpgradeNames = {}
		for rowNum, upgradeNames in pairs ( MetaUpgradeDefaultCardLayout ) do
			ConcatTableValues( allMetaUpgradeNames, upgradeNames )
		end
		--DebugPrint({ Text = "#allMetaUpgradeNames = "..tostring(#allMetaUpgradeNames) })
		while currentCostTotal < bountyData.RandomMetaUpgradeCostTotal and not IsEmpty( allMetaUpgradeNames ) do
			local randomUpgradeName = RemoveRandomValue( allMetaUpgradeNames )
			if currentCostTotal + MetaUpgradeCardData[randomUpgradeName].Cost <= bountyData.RandomMetaUpgradeCostTotal then
				GameState.MetaUpgradeState[randomUpgradeName].Equipped = true
				currentCostTotal = currentCostTotal + MetaUpgradeCardData[randomUpgradeName].Cost
				--DebugPrint({ Text = "randomUpgradeName = "..randomUpgradeName })
				--DebugPrint({ Text = "currentCostTotal = "..currentCostTotal })
			end
		end
	end
	GetCurrentMetaUpgradeCost()

	-- Clear all non-specified ShrineUpgrades
	for metaUpgradeName, metaUpgradeLevel in pairs( GameState.ShrineUpgrades ) do
		GameState.ShrineUpgrades[metaUpgradeName] = 0
	end
	if bountyData.ShrineUpgradesActive ~= nil then
		for metaUpgradeName, metaUpgradeLevel in pairs( bountyData.ShrineUpgradesActive ) do
			GameState.ShrineUpgrades[metaUpgradeName] = metaUpgradeLevel
		end
	elseif bountyData.RandomShrineUpgradePointTotal ~= nil then
		local currentCostTotal = 0
		local allShrineUpgradeNames = ShallowCopyTable( ShrineUpgradeOrder )
		--DebugPrint({ Text = "#allShrineUpgradeNames = "..tostring(#allShrineUpgradeNames) })
		while currentCostTotal < bountyData.RandomShrineUpgradePointTotal and not IsEmpty( allShrineUpgradeNames ) do
			local randomUpgradeName = GetRandomValue( allShrineUpgradeNames )
			--DebugPrint({ Text = "randomUpgradeName = "..randomUpgradeName })
			local currentLevel = GameState.ShrineUpgrades[randomUpgradeName] or 0
			--DebugPrint({ Text = "currentLevel = "..currentLevel })
			local maxLevel = #MetaUpgradeData[randomUpgradeName].Ranks
			--DebugPrint({ Text = "maxLevel = "..maxLevel })
			if currentLevel < maxLevel then
				local nextCost = MetaUpgradeData[randomUpgradeName].Ranks[currentLevel + 1].Points
				--DebugPrint({ Text = "nextCost = "..nextCost })
				if currentCostTotal + nextCost <= bountyData.RandomShrineUpgradePointTotal then
					GameState.ShrineUpgrades[randomUpgradeName] = (GameState.ShrineUpgrades[randomUpgradeName] or 0) + 1
					currentCostTotal = currentCostTotal + nextCost
					--DebugPrint({ Text = "currentCostTotal = "..currentCostTotal })
				end
			end
		end
	end
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()

	GameState.PackagedBountyAttempts[bountyData.Name] = (GameState.PackagedBountyAttempts[bountyData.Name] or 0) + 1
	
	BountyPackagePreRunStartPresentation( bountyData, { ActiveBounty = bountyData.Name, ActiveBountyClears = GameState.PackagedBountyClears[bountyData.Name] or 0, ActiveBountyAttempts = GameState.PackagedBountyAttempts[bountyData.Name] } )
	WaitForSpeechFinished()

	StartOver( { StartingBiome = bountyData.StartingBiome, ForcedRewards = bountyData.ForcedRewards, ActiveBounty = bountyData.Name, RunOverrides = bountyData.RunOverrides  } )
	RemoveInputBlock({ Name = "StartPackagedBounty" })
end

function RestorePackagedBountyGameState()
	if StoredGameState == nil then
		return
	end

	EquipPlayerWeapon( WeaponData[StoredGameState.PrimaryWeaponName], { SkipPresentation = true, SkipAnimSwap = true, } )
	GameState.LastAwardTrait = StoredGameState.LastAwardTrait
	GameState.EquippedFamiliar = StoredGameState.EquippedFamiliar
	GameState.MetaUpgrades = ShallowCopyTable( StoredGameState.MetaUpgrades ) or {}
	GameState.ShrineUpgrades = ShallowCopyTable( StoredGameState.ShrineUpgrades ) or {}
	GameState.MetaUpgradeState = ShallowCopyTable( StoredGameState.MetaUpgradeState ) or {}

	GetCurrentMetaUpgradeCost()
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()

	StoredGameState = nil
end

function BountyInfoBanner( source, args )
	args.Text = CurrentRun.ActiveBounty
	DisplayInfoBanner( source, args )
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
			LoadPackages({ Name = sourceLootName })
		end
		LoadVoiceBanks({ Name = "Chaos" })
	end
end
