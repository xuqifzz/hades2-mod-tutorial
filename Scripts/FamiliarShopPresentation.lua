function GiftFamiliarUpgradePresentation( usee, args )

	StopStatusAnimation( usee )
	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarUpgradedGlobalVoiceLines )

	wait(0.5)

	PlaySound({ Name = usee.HappySound or "/EmptyCue", Id = usee.ObjectId })
	SetAnimation({ Name = usee.IdleAnimation, DestinationId = usee.ObjectId })
	
	wait(0.5)

end

function FamiliarShopScreenOpenedPresentation( screen, args )
	LockCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, OffsetX = -20 })
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopOpenNew" })
	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarShopOpenedVoiceLines, true )
end

function FamiliarShopScreenOpenFinishedPresentation( screen )

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

function FamiliarShopScreenSelectCategoryPresentation( screen, button )

	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

end

function FamiliarShopScreenScrollPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function FamiliarShopScreenCloseStartPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopCloseNew" })
end

function FamiliarShopScreenCloseFinishedPresentation( screen )
	if screen.NumSales <= 0 then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, FromCurrentLocation = true, Retarget = true, EaseIn = 0 })
	end
	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarShopClosedVoiceLines, true )
end


function FamiliarShopSessionCompletePresentation( usee, screen )
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

function FamiliarShopItemPurchasedPresentation( button, upgradeData, args )
	if button.Free then
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAffectionSFX" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
	end
end

function FamiliarShopPurchasePreActivatePresentation( screen, button, saleData, weaponData )

	FreezePlayerUnit( "FamiliarShopActivate" )
	AddInputBlock({ Name = "FamiliarShopActivate" })
	MapState.CosmeticPresentationActive = true
	local familiar = screen.OpenedFrom

	local focusId = screen.OpenedFrom.ObjectId
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })
	PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, OffsetX = 0, Retarget = true })

	--[[
	local weaponKit = GetWeaponOrToolKit( button.Data.Name )
	if weaponKit ~= nil then
		PanCamera({ Id = weaponKit.ObjectId, Duration = 1.0, Retarget = true, OffsetX = 0, OffsetY = -60, FromCurrentLocation = true })
	end

	
	ShakeScreen({ Speed = 500, Distance = 5, Duration = 0.5, FalloffSpeed = 500 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	]]

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })
	CreateAnimation({ Name = "FamiliarUpgradeSparkles", DestinationId = familiar.ObjectId })

	thread( PlayVoiceLines, GlobalVoiceLines.PositiveReactionVoiceLines, true )

	wait( saleData.PanDuration or 1.0 )

	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = familiar.ObjectId })
	SetAnimation({ Name = familiar.HappyAnimation, DestinationId = familiar.ObjectId })
	SpendResources( saleData.Cost, button.Data.Name, { Silent = true } )
	
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	
	RunEventsGeneric( familiar.UpgradedEvents, familiar )

	wait( 0.3 )
	thread( CleanUpUpgradeSparkles, familiar )
end

function CleanUpUpgradeSparkles( familiar )
	wait( 3 )
	StopAnimation({ Name = "FamiliarUpgradeSparkles", DestinationId = familiar.ObjectId })
	StopAnimation({ Name = "FamiliarGlow", DestinationId = familiar.ObjectId })
end

function FamiliarShopPurchasePostActivatePresentation( button, saleData, weaponKit )

	if weaponKit ~= nil then
		SetAlpha({ Id = weaponKit.ObjectId, Fraction = 1.0, Duration = 0.5 })
		SetAnimation({ Name = weaponKit.UnequippedKitAnimation or GetWeaponKitAnimation( weaponKit.Name, "Unequipped" ), DestinationId =  weaponKit.ObjectId })
		if weaponKit.FirstTimeEquipAnimation ~= nil then
			--PanCamera({ Id = weaponKit.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
			--SetAnimation({ Name = weaponKit.FirstTimeEquipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end

	thread( DisplayInfoBanner, nil, {
		TitleText = saleData.UnlockTextId or "FamiliarShopUnlock",
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
	--AdjustZoom({ Fraction = 1.0, LerpTime = 0.75 })

	wait( 0.76 )

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

	RemoveInputBlock({ Name = "FamiliarShopActivate" })
	MapState.CosmeticPresentationActive = false
	UnfreezePlayerUnit( "FamiliarShopActivate" )

end

function MouseOverFamiliarShopItem( button )

	GenericMouseOverPresentation( button )

	local screen = button.Screen
	local components = screen.Components

	SetAnimation({ DestinationId = button.Id, Name = button.HighlightAnimation })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle", Id = button.Id })

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })

	if button.TraitData ~= nil then
		SetAnimation({ Name = button.TraitData.Icon, DestinationId = components.InfoBoxIcon.Id })
		SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 1.0, Duration = 0.2 })
	end

	if button.Graphic ~= nil then
		SetAnimation({ Name = button.Graphic, DestinationId = components.InfoBoxGraphic.Id })
	end

	local rarityName = TraitRarityData.WeaponRarityUpgradeOrder[button.Data.RarityLevel or 1]
	local rarityColor = Color["BoonPatch"..rarityName]

	SetAlpha({ Id = components.InfoBoxName.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxName.Id,
		Text = button.Data.Name,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = luaValue,
		Color = rarityColor,
	})
	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = button.Data.Name,
		UseDescription = true,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.TraitData or {},
	})

	if button.TraitData then
		local traitData = button.TraitData
		if not IsEmpty( traitData.StatLines ) then
			local statLine = traitData.StatLines[1]
			SetAlpha({ Id = components.InfoBoxStatLineLeft.Id, Fraction = 1.0, Duration = 0.2 })
			SetAlpha({ Id = components.InfoBoxStatLineRight.Id, Fraction = 1.0, Duration = 0.2 })
			ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })
			ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0})
		end
	end

	if button.Data.RarityLevel ~= nil then		
		SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = components.InfoBoxRarity.Id,
			Text = TraitRarityData.AspectRarityText[button.Data.RarityLevel],
			Color = rarityColor,
			})
	end

	local newButtonKey = "NewIcon"..button.Index
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
	GameState.WorldUpgradesViewed[button.Data.Name] = true

	if not button.Purchased and not screen.ReadOnly then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	end
end

function MouseOffFamiliarShopItem( button )

	local screen = button.Screen
	local components = screen.Components

	SetAnimation({ DestinationId = button.Id, Name = button.Animation })

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxName.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxStatLineLeft.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxStatLineRight.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxFlavor.Id, Fraction = 0.0, Duration = 0.2 })

	SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
end
