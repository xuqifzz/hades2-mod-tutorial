function WeaponShopScreenOpenedPresentation( screen, args )
	if not args.IgnoreCamera then
		LockCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0 })
	end
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopOpenNew" })
	-- SetAnimation({ Name = "MelinoeGatherStart", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.WeaponShopOpenedVoiceLines, true )
end

function WeaponShopScreenOpenFinishedPresentation( screen )

	if screen.OfferedVoiceLines ~= nil then
		if PlayVoiceLines( screen.OfferedVoiceLines, true ) then
			return
		end
	end

	if screen.NumItemsPurchaseable == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.GhostAdminSoldOutVoiceLines, true )
	elseif screen.NumItemsAffordable == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.GhostAdminCantAffordAnyVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedGhostAdminScreenVoiceLines, true )
	end

end

function WeaponShopScreenSelectCategoryPresentation( screen, button )

	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

end

function WeaponShopScreenScrollPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function WeaponShopScreenCloseStartPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopCloseNew" })
end

function WeaponShopScreenCloseFinishedPresentation( screen, button )
	if button.Id == screen.Components.CloseButton.Id then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, FromCurrentLocation = true, Retarget = true, EaseIn = 0 })
	end
	thread( PlayVoiceLines, GlobalVoiceLines.WeaponShopClosedVoiceLines, true )
end


function WeaponShopSessionCompletePresentation( usee, screen )
	if screen == nil then
		return
	end
	if screen.NumSales == 0 then
		if CheckCooldown( "MarketNoSale", 60 ) then
			PlayEmote( { TargetId = usee.NoSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	else
		if CheckCooldown( "MarketMadeSale", 60 ) then
			PlayEmote( { TargetId = usee.MadeSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	end
end

function WeaponShopItemPurchasedPresentation( button, upgradeData, args )
	if button.Free then
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAffectionSFX" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
	end
end

function WeaponShopPurchaseNoEquipPresentation( screen, button, saleData, weaponData )
	AddInputBlock({ Name = "WeaponShopPurchaseNoEquipPresentation" })

	UseableOff({ Id = button.Id, ForceHighlightOff = true })
	thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines[saleData.PreRevealGlobalVoiceLines] or GlobalVoiceLines.WeaponUnlockGlobalVoiceLines )

	wait( 0.3 )

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	local weaponKit = GetWeaponOrToolKit( button.Data.ToolName or button.Data.WeaponName or button.Data.Name )
	if weaponKit ~= nil then
		ShakeScreen({ Speed = 100, Distance = 2, Duration = 0.5, FalloffSpeed = 2000 })
		Flash({ Id = weaponKit.ObjectId, Speed = 0.85, MinFraction = 0.2, MaxFraction = 0.5, Color = Color.White, Duration = 1.5 })
 		CreateAnimation({ Name = "ManaSparkleShower", DestinationId = weaponKit.ObjectId, Scale = 1.5 })
		CreateAnimation({ Name = "PowerUpComboReadyWeaponKit", DestinationId = weaponKit.ObjectId, Scale = 1.5 })	
		if weaponKit.Name == GetEquippedWeapon() then
			SetAnimation({ Name = weaponKit.EquippedKitAnimation, GrannyModel = button.TraitData.WeaponKitGrannyModel, DestinationId = weaponKit.ObjectId })
		else
			SetAnimation({ Name = weaponKit.UnequippedKitAnimation, GrannyModel = button.TraitData.WeaponKitGrannyModel, DestinationId = weaponKit.ObjectId })
		end
	end

	wait( 0.8 )

	RemoveInputBlock({ Name = "WeaponShopPurchaseNoEquipPresentation" })
	FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.3 })

end

function WeaponShopPurchasePreActivatePresentation( screen, button, saleData, weaponData )

	FreezePlayerUnit( "WeaponShopActivate" )
	AddInputBlock({ Name = "WeaponShopActivate" })
	MapState.CosmeticPresentationActive = true

	local focusId = screen.OpenedFrom.ObjectId
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	local weaponKit = GetWeaponOrToolKit( button.Data.ToolName or button.Data.WeaponName or button.Data.Name )
	if weaponKit ~= nil then
		PanCamera({ Id = weaponKit.ObjectId, Duration = 1.0, Retarget = true, OffsetX = 0, OffsetY = -60, FromCurrentLocation = true })
	end
	
	AdjustFullscreenBloom({ Name = "SaturatedLight", Duration = 0.5 })
	ShakeScreen({ Speed = 500, Distance = 5, Duration = 0.5, FalloffSpeed = 500 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })

	thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines[saleData.PreRevealGlobalVoiceLines] or GlobalVoiceLines.WeaponUnlockGlobalVoiceLines )

	wait( saleData.PanDuration or 1.0 )

	PlaySound({ Name = "/SFX/GhostEvaporate", Id = focusId })
	SetAnimation({ Name = "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof" })
	
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	
	if weaponKit ~= nil then
		CreateAnimation({ Name = saleData.ItemPreActivationVfx or "CosmeticUnlockFx", DestinationId = weaponKit.ObjectId })
		if weaponKit.UpgradeTextures ~= nil and weaponKit.UpgradeTextures[saleData.Name] ~= nil then
			SetThingProperty({ Property = "GrannyTexture", Value = weaponKit.UpgradeTextures[saleData.Name], DestinationId = weaponKit.ObjectId })
		end
	end

	thread( PlayVoiceLines, GlobalVoiceLines.PostRevealGlobalVoiceLines, true )
	thread( LegendaryAspectPresentation, nil, { } )

	if not saleData.SkipSpawnSkelly then
		thread( SpawnSkelly, 3.0 )
	end

	FocusCamera({ Fraction = 1.35, Duration = 0.2 })
	wait( 0.3 )
	FocusCamera({ Fraction = 1.47, Duration = ( (saleData.PostActivationHoldDuration or 0) * 2 ) or 6.0 })
end

function WeaponShopPurchasePostActivatePresentation( button, saleData, weaponKit )

	if weaponKit ~= nil then
		SetAlpha({ Id = weaponKit.ObjectId, Fraction = 1.0, Duration = 0.5 })
		SetAnimation({ Name = weaponKit.UnequippedKitAnimation or GetWeaponKitAnimation( weaponKit.Name, "Unequipped" ), DestinationId =  weaponKit.ObjectId })
	end

	thread( DisplayInfoBanner, nil, {
		TitleText = saleData.UnlockTextId or "WeaponShopUnlock",
		SubtitleText = saleData.Name,
		Icon = saleData.Icon,
		FontScale = 0.76,
		IconScale = 0.7,
		IconMoveSpeed = 0.00001,
		IconOffsetY = 6,
		Duration = 3.0,
	} )

	wait( 3.25 )

	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })

	wait( saleData.PostActivationHoldDuration or 0 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
	AdjustZoom({ Fraction = 1.0, LerpTime = 0.75 })

	wait( 0.45 )

	if weaponKit ~= nil then
		if weaponKit.FirstTimeWeaponFire then
			SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 325, CompleteAngle = true })
			FireWeaponFromUnit({ Weapon = weaponKit.FirstTimeWeaponFire, Id = CurrentRun.Hero.ObjectId })
		elseif weaponKit.FirstTimeEquipAnimation ~= nil then
			SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 325, CompleteAngle = true })
			SetAnimation({ Name = weaponKit.FirstTimeEquipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		end

		wait( 0.25 )
		SetAnimation({ Name = weaponKit.EquippedKitAnimation or GetWeaponKitAnimation( weaponKit.Name, "Unequipped" ), DestinationId =  weaponKit.ObjectId })
		wait( 0.7 )

		if weaponKit.ShopPurchasaeFunctionName ~= nil then
			CallFunctionName( weaponKit.ShopPurchasaeFunctionName, weaponKit )
		else
			CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
		end

	end

	RemoveInputBlock({ Name = "WeaponShopActivate" })
	MapState.CosmeticPresentationActive = false
	UnfreezePlayerUnit( "WeaponShopActivate" )

end

function MouseOverWeaponShopItem( button )

	GenericMouseOverPresentation( button )

	local screen = button.Screen
	local components = screen.Components
	screen.SelectedItem = button

	SetAnimation({ DestinationId = button.Id, Name = button.HighlightAnimation })
	PlaySound({ Id = button.Id, Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

	if not button.Purchased then
		SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
	end
	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })

	if button.TraitData ~= nil then
		SetAnimation({ Name = button.TraitData.Icon, DestinationId = components.InfoBoxIcon.Id })
		SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 1.0, Duration = 0.2 })
	end

	local weaponKit = GetWeaponOrToolKit( button.Data.WeaponName or button.Data.ToolName or button.Data.Name )
	if weaponKit ~= nil then
		if weaponKit.InfoBackingAnimation ~= nil then
			SetAnimation({ DestinationId = components.InfoBoxBacking.Id, Name = weaponKit.InfoBackingAnimation })
		end
		if weaponKit.UnequippedKitAnimation ~= nil then
			if not IsWeaponUnlocked( weaponKit.Name ) then
				SetAlpha({ Id = weaponKit.ObjectId, Fraction = 0.5, Duration = 0.2 })
				PlaySound({ Name = weaponKit.MouseOverSound, Id = weaponKit.ObjectId })
			end
		end
		PanCamera({ Id = weaponKit.ObjectId, Duration = 1.0, Retarget = false, OffsetX = screen.KitCameraOffsetX, OffsetY = 50, FromCurrentLocation = true })
	elseif button.Data.MouseOverViewHero then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, Retarget = false, OffsetX = 0, FromCurrentLocation = true })
	end

	local text = button.Data.Name
	local upgradedRarity = nil
	if button.TraitData ~= nil then
		text = button.TraitData.Name
		if button.Data.TraitUpgrade ~= nil and not button.Purchased then
			upgradedRarity = GetUpgradedRarity( button.TraitData.Rarity, TraitRarityData.WeaponRarityUpgradeOrder )
		else
			upgradedRarity = button.TraitData.Rarity
		end
	end
	
	local rarityName = "Common"
	local rarityColor = Color.White
	if button.TraitData ~= nil and button.TraitData.Rarity and upgradedRarity ~= nil then
		rarityName = upgradedRarity
		rarityColor = Color["BoonPatch"..rarityName]
		SetAnimation({ DestinationId = components.InfoBoxFrame.Id, Name = "Frame_Boon_Menu_"..rarityName })
		ModifyTextBox({ Id = components.InfoBoxName.Id,
			Text = button.TraitData.Title,
			FadeTarget = 1.0,
			LuaKey = "TooltipData",
			LuaValue = button.TraitData,
			Color = rarityColor,
		})
		local rarityLevel = GetRarityValue( rarityName )
		SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = components.InfoBoxRarity.Id,
			Text = TraitRarityData.AspectRarityText[rarityLevel],
			Color = rarityColor,
		})
	else
		if button.Data.Level ~= nil then
			local rarityLevel = button.Data.Level
			local rarityName = TraitRarityData.WeaponRarityUpgradeOrder[rarityLevel]
			rarityColor = Color["BoonPatch"..rarityName]
			SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 1.0, Duration = 0.2 })
			ModifyTextBox({ Id = components.InfoBoxRarity.Id,
				Text = TraitRarityData.AspectRarityText[rarityLevel],
				Color = rarityColor,
			})
		else
			SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 0.0, Duration = 0.2 })
		end

		ModifyTextBox({ Id = components.InfoBoxName.Id,
			Text = text,
			FadeTarget = 1.0,
			LuaKey = "TooltipData",
			LuaValue = button.TraitData or weaponKit,
			Color = rarityColor,
		})
	end
	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = text,
		UseDescription = true,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.TraitData or weaponKit,
	})

	if button.TraitData then
		local traitData = button.TraitData
		local appendToId = nil
		if #traitData.StatLines <= 1 then
			appendToId = components.InfoBoxDescription.Id
		end
		local statLine = traitData.StatLines[1]
		ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0, AppendToId = appendToId })
		ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0, AppendToId = appendToId })
		ModifyTextBox({ Id = components.InfoBoxFlavor.Id, Text = traitData.FlavorText or " ", FadeTarget = 1.0 })
	elseif button.Data and button.Data.FlavorText then
		ModifyTextBox({ Id = components.InfoBoxFlavor.Id, Text = button.Data.FlavorText or " ", FadeTarget = 1.0 })
	end

	if not button.Purchased then
		AddResourceCostDisplay( button.Screen, button.Data.Cost, button.Screen.CostDisplay )
	end

	local newButtonKey = "NewIcon"..button.Index
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	UpdateWeaponShopInteractionText( button.Screen, button )
end

function MouseOffWeaponShopItem( button )

	local screen = button.Screen
	local components = screen.Components
	screen.SelectedItem = nil

	SetAnimation({ DestinationId = button.Id, Name = button.Animation })

	ModifyTextBox({ Id = components.InfoBoxName.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })

	SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 0.0, Duration = 0.2 })

	local weaponKit = GetWeaponOrToolKit( button.Data.Name )
	if weaponKit ~= nil and not IsWeaponUnlocked( button.Data.Name ) then
		SetAlpha({ Id = weaponKit.ObjectId, Fraction = 0.0, Duration = 0.2 })
	end

	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
end

function WeaponShopCloseCategory( screen, button )
	if screen.ItemNames == nil then
		return
	end
	for k, itemName in pairs( screen.ItemNames ) do
		local weaponKit = GetWeaponOrToolKit( itemName )
		if weaponKit ~= nil and not IsWeaponUnlocked( itemName ) then
			SetAlpha({ Id = weaponKit.ObjectId, Fraction = 0.0, Duration = 0.2 })
		end
	end
end

function WeaponShopRevealCategoryPresentation( screen, category, categoryButton )
	AddInputBlock({ Name = "WeaponShopRevealCategory" })
	SetAlpha({ Id  = categoryButton.Id, Fraction = 0.0 })
	thread( PlayVoiceLines, GlobalVoiceLines.WeaponShopOpenedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })
	wait( 0.5 )
	SetAlpha({ Id  = categoryButton.Id, Fraction = 1.0 })
	local categoryButtonRevealAnimation = "ShopCategoryButtonReveal"
	if categoryButton.Animations ~= nil then
		categoryButtonRevealAnimation = categoryButton.Animations.Reveal
	end
	SetAnimation({ Name = categoryButtonRevealAnimation, DestinationId = categoryButton.Id })
	wait( 1.0 )
	RemoveInputBlock({ Name = "WeaponShopRevealCategory" })
end

function UpdateWeaponShopInteractionText( screen, button )
	
	local components = screen.Components
	
	if button ~= nil and not button.Purchased then
		if button.Data ~= nil and button.Data.Cost ~= nil and HasResources( button.Data.Cost ) then
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
		if GameState.WorldUpgrades.WorldUpgradePinning then
			SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end		
	
	if screen.NumCategories >= 2 then
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
	else
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
	end	

end