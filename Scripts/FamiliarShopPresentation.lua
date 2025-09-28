function GiftFamiliarUpgradePresentation( usee, args )

	StopStatusAnimation( usee )

	AngleNPCToHero( usee )
	wait(0.3)

	PlaySound({ Name = usee.HappySound or "/EmptyCue", Id = usee.ObjectId })
	
	wait(0.3)

end

function FamiliarShopScreenOpenedPresentation( screen, args )
	LockCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, OffsetX = -20 })
	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarShopOpenedVoiceLines, true )
end

function FamiliarShopScreenCloseStartPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/RunHistoryClose" })
end

function FamiliarShopScreenCloseFinishedPresentation( screen )
	if screen.ReadOnly then
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
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

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })
	PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, OffsetX = 0, Retarget = true })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })
	CreateAnimation({ Name = "FamiliarUpgradeSparkles", DestinationId = familiar.ObjectId })

	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarPostTreatVoiceLines, true, nil, { FamiliarName = familiar.Name } )

	wait( saleData.PanDuration or 1.0 )

	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = familiar.ObjectId })
	SetAnimation({ Name = familiar.HappyAnimation, DestinationId = familiar.ObjectId })
	SpendResources( saleData.Cost, button.Data.Name, { Silent = true } )
	
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	
	RunEventsGeneric( familiar.UpgradedEvents, familiar )
	RunEventsGeneric( familiar.SetupEvents, familiar ) -- refresh eligible interactions

	wait( 0.3 )
	thread( CleanUpUpgradeSparkles, familiar )
end

function CleanUpUpgradeSparkles( familiar )
	wait( 3 )
	StopAnimation({ Name = "FamiliarUpgradeSparkles", DestinationId = familiar.ObjectId })
	StopAnimation({ Name = "FamiliarGlow", DestinationId = familiar.ObjectId })
end

function FamiliarShopPurchasePostActivatePresentation( screen, button, saleData )

	SetAnimation({ Name = "MelinoeSaluteToEquip", DestinationId = CurrentRun.Hero.ObjectId })

	thread( DisplayInfoBanner, nil, {
		TitleText = saleData.UnlockTextId or "FamiliarShopUnlock",
		SubtitleText = saleData.Name,
		Icon = saleData.Icon,
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
		IconBackingColor = Color.Lavender,
		IconBackingHSV = { 0.3, -0.1, 0.1},
		AnimationName = "InfoBannerFamiliarUpgradeIn",
		AnimationOutName = "InfoBannerFamiliarUpgradeOut",
		IconOffsetY = 6,
		IconScale = 0.5,
		SubtitleOffsetY = 60,
		IconMoveSpeed = 0.00001,
		Duration = 2.8,
	} )

	wait( 2.75 )

	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })

	if GameState.EquippedFamiliar ~= screen.OpenedFrom.Name and screen.OpenedFrom.PostUpgradeUnequippedAnimation ~= nil then
		SetAnimation({ DestinationId = screen.OpenedFrom.ObjectId, Name = screen.OpenedFrom.PostUpgradeUnequippedAnimation })
	end

	wait( saleData.PostActivationHoldDuration or 0 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
	--AdjustZoom({ Fraction = 1.0, LerpTime = 0.75 })

	wait( 0.5 )

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

	if button.Data.Icon ~= nil then
		SetAnimation({ Name = button.Data.Icon, DestinationId = components.InfoBoxIcon.Id })
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
		Color = rarityColor,
	})
	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })

	local descriptionText = button.Data.Name
	if not GameState.FamiliarUpgrades[descriptionText] then
		descriptionText = descriptionText.."_Upgrade"
	end
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = descriptionText,
		UseDescription = true,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.TraitData,
	})

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
	SetAlpha({ Id = components.InfoBoxFlavor.Id, Fraction = 0.0, Duration = 0.2 })

	SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
end
