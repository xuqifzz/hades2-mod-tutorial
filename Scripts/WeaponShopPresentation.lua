function UsedWeaponShopPresentation( usee, args )
	AddInputBlock({ Name = "UsedWeaponShopPresentation" })
	LockCamera({ Id = usee.ObjectId, Duration = 1.0 })
	for itemName, itemData in pairs( WeaponShopItemData ) do
		if itemData.PreOpenRevealVoiceLines ~= nil and IsGameStateEligible( itemData, itemData.GameStateRequirements ) and not GameState.WorldUpgradesRevealed[itemName] then
			wait(0.75)
			SetAnimation({ Name = "MelinoeCauldronIncantationWeaponShop", DestinationId = CurrentRun.Hero.ObjectId, })
			PlayVoiceLines( itemData.PreOpenRevealVoiceLines, true )
			local categoryIndex = nil
			for i, data in ipairs( ScreenData.WeaponShop.ItemCategories ) do
				if Contains( data, itemName ) then
					categoryIndex = i
					break
				end
			end
			args.DefaultCategoryIndex = categoryIndex
		end
	end
	RemoveInputBlock({ Name = "UsedWeaponShopPresentation" })
end

function WeaponShopScreenOpenedPresentation( screen, args )
	-- moved to animation
	-- PlaySound({ Name = "/SFX/Menu Sounds/SilverPoolOpen" })
end

function WeaponShopScreenOpenFinishedPresentation( screen )

	if screen.OfferedVoiceLines ~= nil then
		if PlayVoiceLines( screen.OfferedVoiceLines, true ) then
			return
		end
	end

	thread( PlayVoiceLines, GlobalVoiceLines.WeaponShopOpenedVoiceLines, true )

	if screen.NumItemsPurchaseable == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.GhostAdminSoldOutVoiceLines, true )
	elseif screen.NumItemsAffordable == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.GhostAdminCantAffordAnyVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedGhostAdminScreenVoiceLines, true )
	end

end

function WeaponShopScreenSelectCategoryPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuSwitch" })
end

function WeaponShopScreenCloseStartPresentation( screen, args )
	args = args or {}
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopCloseNew" })
	SetAnimation({ DestinationId = screen.Components.WeaponShopBackground.Id, Name = screen.CloseAnimation })
	if not args.Purchasing then
		if screen.CurrentKit ~= nil and GetEquippedWeapon() == screen.CurrentKit.Name then
			SetAnimation({ DestinationId = screen.CurrentKit.ObjectId, Name = screen.CurrentKit.EquippedKitAnimation, CopyFromPrev = true })
		end
	end
end

function WeaponShopScreenCloseFinishedPresentation( screen, button )
	if button.Id == screen.Components.CloseButton.Id then
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, FromCurrentLocation = true, Retarget = true, EaseIn = 0 })
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
	HideCombatUI( "WeaponShopPurchaseNoEquipPresentation" )

	UseableOff({ Id = button.Id, ForceHighlightOff = true })
	thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines[saleData.PreRevealGlobalVoiceLines] or GlobalVoiceLines.WeaponUnlockGlobalVoiceLines )

	SetAnimation({ Name = "MelTalkGifting01", DestinationId = CurrentRun.Hero.ObjectId, })

	wait( 0.3 )


	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	local weaponKit = GetWeaponKit( button.Data.WeaponName or button.Data.Name )
	if weaponKit ~= nil then
		ShakeScreen({ Speed = 100, Distance = 2, Duration = 0.5, FalloffSpeed = 2000 })
		Flash({ Id = weaponKit.ObjectId, Speed = 0.6, MinFraction = 0.0, MaxFraction = 1, Color = Color.White, Duration = 1.5 })
 		CreateAnimation({ Name = "ManaSparkleShowerWeaponKit", DestinationId = weaponKit.ObjectId, Scale = 1.5 })
		CreateAnimation({ Name = "PowerUpComboReadyWeaponKit", DestinationId = weaponKit.ObjectId, Scale = 1.5 })	
		SetAnimation({ Name = weaponKit.UnequippedKitAnimation, GrannyModel = button.TraitData.WeaponKitGrannyModel, DestinationId = weaponKit.ObjectId, CopyFromPrev = true })
	end

	wait( 0.3 )

	SetAnimation({ Name = "MelTalkGifting01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId, })

	wait( 0.5 )

	ShowCombatUI( "WeaponShopPurchaseNoEquipPresentation" )
	RemoveInputBlock({ Name = "WeaponShopPurchaseNoEquipPresentation" })
	FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.3 })

end

function WeaponShopPurchasePreActivatePresentation( screen, button, saleData, weaponData )

	FreezePlayerUnit( "WeaponShopActivate" )
	HideCombatUI( "WeaponShopActivate" )
	AddInputBlock({ Name = "WeaponShopActivate" })
	MapState.CosmeticPresentationActive = true

	local focusId = screen.OpenedFrom.ObjectId
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	local weaponKit = GetWeaponKit( button.Data.WeaponName or button.Data.Name )
	if weaponKit ~= nil then
		PanCamera({ Id = weaponKit.ObjectId, Duration = 1.0, Retarget = true, OffsetX = 0, OffsetY = -60, FromCurrentLocation = true })
	else
		PanCamera({ Id = focusId, Duration = 1.0, Retarget = true, OffsetX = 30, OffsetY = -200, FromCurrentLocation = true })
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
		SubtitleOffsetY = 20,
		TextFadeColor = {160,165,180,255},
		Color = {160,165,180,255},
		FontScale = 0.76,
		-- No icon, the identical WeaponKit animation is directly below centered on camera
		Duration = 3.0,
		AnimationName = "InfoBannerWeaponUnlockIn",
		AnimationOutName = "InfoBannerWeaponUnlockOut",
		IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
		IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		IconBackingOffsetY = -12,

	} )

	wait( 1.5 )

	if saleData.PostActivateFunctionName ~= nil then
		CallFunctionName( saleData.PostActivateFunctionName )
	else
		wait( 1.75 )
	end

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
		SetAnimation({ Name = weaponKit.EquippedKitAnimation or GetWeaponKitAnimation( weaponKit.Name, "Unequipped" ), DestinationId =  weaponKit.ObjectId, CopyFromPrev = true })
		wait( 0.7 )

		CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
	end

	ShowCombatUI( "WeaponShopActivate" )
	RemoveInputBlock({ Name = "WeaponShopActivate" })
	MapState.CosmeticPresentationActive = false
	UnfreezePlayerUnit( "WeaponShopActivate" )

end

function MouseOverWeaponShopItem( button )

	GenericMouseOverPresentation( button )

	local screen = button.Screen
	local components = screen.Components
	screen.SelectedItem = button
	screen.ClipboardText = button.Data.Name

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

	WeaponShopPanToKit( screen, button.Data.WeaponName or button.Data.Name )

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
		local appendToId = components.InfoBoxDescription.Id
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
	CurrentRun.WorldUpgradesViewed[button.Data.Name] = true
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

	local weaponKit = GetWeaponKit( button.Data.Name )
	if weaponKit ~= nil and not IsWeaponUnlocked( button.Data.Name ) then
		SetAlpha({ Id = weaponKit.ObjectId, Fraction = 0.0, Duration = 0.2 })
	end

	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })

	UpdateWeaponShopInteractionText( screen )
end

function WeaponShopPanToKit( screen, kitName )
	local weaponKit = GetWeaponKit( kitName )
	if weaponKit ~= nil then
		if weaponKit.InfoBackingAnimation ~= nil then
			SetAnimation({ DestinationId = screen.Components.InfoBoxBacking.Id, Name = weaponKit.InfoBackingAnimation })
		end
		if weaponKit.UnequippedKitAnimation ~= nil then
			if not IsWeaponUnlocked( weaponKit.Name ) then
				SetAlpha({ Id = weaponKit.ObjectId, Fraction = 0.5, Duration = 0.2 })
				PlaySound({ Name = weaponKit.MouseOverSound, Id = weaponKit.ObjectId })
			end
		end
		PanCamera({ Id = weaponKit.ObjectId, Duration = 0.5, Retarget = false, OffsetX = screen.KitCameraOffsetX, OffsetY = 50, FromCurrentLocation = true })
	else
		PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 0.5, Retarget = false, OffsetX = 0, FromCurrentLocation = true })
	end

	if weaponKit ~= screen.CurrentKit then
		if screen.CurrentKit ~= nil and GetEquippedWeapon() == screen.CurrentKit.Name then
			SetAnimation({ DestinationId = screen.CurrentKit.ObjectId, Name = screen.CurrentKit.EquippedKitAnimation, CopyFromPrev = true })
		end
		screen.CurrentKit = weaponKit
		if weaponKit ~= nil then
			SetAnimation({ DestinationId = weaponKit.ObjectId, Name = weaponKit.UnequippedKitAnimation, CopyFromPrev = true })
		end
	end
end

function WeaponShopCloseCategory( screen, button )
	if screen.ItemNames == nil then
		return
	end
	for k, itemName in pairs( screen.ItemNames ) do
		local weaponKit = GetWeaponKit( itemName )
		if weaponKit ~= nil and not IsWeaponUnlocked( itemName ) then
			SetAlpha({ Id = weaponKit.ObjectId, Fraction = 0.0, Duration = 0.2 })
		end
	end
end

function WeaponShopRevealCategoryPresentation( screen, category, categoryButton )
	AddInputBlock({ Name = "WeaponShopRevealCategory" })
	SetAlpha({ Id  = categoryButton.Id, Fraction = 0.0 })
	thread( PlayVoiceLines, GlobalVoiceLines.WeaponShopExpandedVoiceLines, true )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonSlotHighlightShimmerSFX", Id = CurrentRun.Hero.ObjectId })
	wait( 0.5 )
	SetAlpha({ Id  = categoryButton.Id, Fraction = 1.0, Duration = 0.4 })
	local categoryButtonRevealAnimation = "ShopCategoryButtonReveal"
	if categoryButton.Animations ~= nil then
		categoryButtonRevealAnimation = categoryButton.Animations.Reveal
	end
	if categoryButton.IconId ~= nil then
		SetAlpha({ Id = categoryButton.IconId, Fraction = 1.0, Duration = 0.4 })
	end
	SetAnimation({ Name = categoryButtonRevealAnimation, DestinationId = categoryButton.Id })
	wait( 0.75 )
	RemoveInputBlock({ Name = "WeaponShopRevealCategory" })
end

function UpdateWeaponShopInteractionText( screen, button )
	
	local components = screen.Components

	if button == nil or button.Data == nil or button.Purchased then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		if GameState.WorldUpgrades.WorldUpgradePinning then
			SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
	
	if screen.NumCategories >= 2 then
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
	else
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
	end	

end

function ToolExorcismBookUnlockedPresentation()

	local heroId = CurrentRun.Hero.ObjectId

	PlaySound({ Name = "/Leftovers/SFX/AuraOnLoud", Id = heroId })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = heroId })
	SetAnimation({ Name = "Melinoe_Tablet_Intro", DestinationId = heroId })
	waitUnmodified( 1.5 )

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Delay = 0.25 })
	SetAnimation({ Name = "Melinoe_Tablet_ReturnToIdle", DestinationId = heroId })
	waitUnmodified( 0.5 )

end

function ToolPickaxeUnlockedPresentation()

	local heroId = CurrentRun.Hero.ObjectId

	SetAnimation({ Name = "MelinoePickAxeMineStart", DestinationId = heroId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = heroId })

	waitUnmodified( 0.06 )
	PlaySound({ Name = "/SFX/Player Sounds/WeaponSwing", Id = heroId })

	SetAnimation({ Name = "MelinoePickAxeMineSwing", DestinationId = heroId })
	waitUnmodified( 0.1 )
	CreateAnimation({ Name = "HarvestPickaxeSwing", DestinationId = heroId })
	waitUnmodified( 0.1 )

	local offset = CalcOffset( math.rad( GetAngle({ Id = heroId }) ), 150 )
	local strikePointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = heroId, OffsetX = offset.X, OffsetY = offset.Y })

	CreateAnimation({ Name = "OreHarvestSpark", DestinationId = strikePointId })
	CreateAnimation({ Name = "OreHarvestSpike", DestinationId = strikePointId, Group = "FX_Standing_Add" })
	PlaySound({ Name = "/SFX/PickaxeHitSFX", Id = strikePointId })

	waitUnmodified( 1.0 )

	Destroy({ Id = strikePointId })

end

function ToolShovelUnlockedPresentation()

	local heroId = CurrentRun.Hero.ObjectId

	SetAnimation({ Name = "Melinoe_Shovel_Start", DestinationId = heroId })
	waitUnmodified( 0.5 )
	CreateAnimation({ Name = "ShovelDirtIn", DestinationId = heroId })
	waitUnmodified( 0.17 )

	SetAnimation({ Name = "Melinoe_Shovel_FireLoop", DestinationId = heroId })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.7, Duration = 0.2 }, } )	
	ShakeScreen({ Speed = 300, Distance = 6, Duration = 0.1, FalloffSpeed = 10000, Angle = 90 })
	waitUnmodified( 0.3 )

	Shake({ Id = heroId, Speed = 100, Distance = 1, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.5, Duration = 0.5 }, } )
	waitUnmodified( 0.3 )

	Shake({ Id = heroId, Speed = 200, Distance = 2, Duration = 0.2 })
	waitUnmodified( 0.2 )

	SetAnimation({ Name = "Melinoe_Shovel_End", DestinationId = heroId })
	waitUnmodified( 0.1 )

	ShakeScreen({ Speed = 300, Distance = 6, Duration = 0.1, FalloffSpeed = 10000, Angle = 90 })	
	CreateAnimation({ Name = "ShovelDirtOutSpray", DestinationId = heroId })
	waitUnmodified( 0.8 )

end

function ToolFishingRodUnlockedPresentation()

	local heroId = CurrentRun.Hero.ObjectId

	SetAnimation({ Name = "Melinoe_Fishing_Start", DestinationId = heroId })
	waitUnmodified( 1.5 )

	PlaySound({ Name = "/SFX/CriticalHit" })
	SetAnimation({ Name = "Melinoe_Fishing_Success", DestinationId = heroId })
	waitUnmodified( 1.0 )

	SetAnimation({ Name = "MelinoeEquip", DestinationId = heroId })

end
