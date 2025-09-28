function MarketScreenOpenPresentation( screen )
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedMarketVoiceLines, true )
end

function MarketScreenClosePresentation( screen, button )
	SetAnimation({ DestinationId = screen.Components.Background.Id, Name = screen.CloseAnimation })
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedMarketVoiceLines, true )
end

function MarketSessionCompletePresentation( usee, screen )
	if screen.NumItems == 0 then
		return
	end
	if screen.NumSales == 0 and CheckCooldown( "MarketNoSale", 60 ) then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = usee.ObjectId })
	end
end

function MarketPurchaseFailPresentation( screen, button )
	local item = button.Data
	Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 3, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	Flash({ Id = screen.Components.BasicResourceButton.Id, Speed = 1.5, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	for resourceName, resourceAmount in pairs( item.Cost ) do
		local resourceData = ResourceData[resourceName]
		if IsEmpty( resourceData.BrokerCannotSpendVoiceLines ) then
			thread( PlayVoiceLines, HeroVoiceLines.NotEnoughCurrencyVoiceLines, true )
		else
			thread( PlayVoiceLines, resourceData.BrokerCannotSpendVoiceLines, true )
		end
		break
	end
end

function MarketPurchaseSuccessPresentation( screen, button )
	local item = button.Data
	local brokerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BrokerGhost01", Distance = 800 })
	PlaySound({ Name = screen.ItemCategories[screen.ActiveCategoryIndex].PurchaseSound or item.PurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	SetAnimation({ DestinationId = button.Id, Name = button.PurchaseAnimation })
	thread( PlayVoiceLines, item.ExchangeVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines.TradedMarketItemVoiceLines, true, nil, { ItemData = item } )
	if CheckCooldown( "PurchasedMarketItemRecently", 7 ) then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = brokerId, Delay = 1.5 })
	end
	thread( PulseText, { Id = screen.Components.BasicResourceButton.Id, ScaleTarget = 1.1, ScaleDuration = 0.3, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
	thread( PulseText, { Id = screen.Components["CurrentAmount"..button.Index].Id, ScaleTarget = 1.2, ScaleDuration = 0.3, Color = Color.White, OriginalColor = screen.ItemAmountFormat.Color, ColorDuration = 0.3, HoldDuration = 0.2, PulseBias = 0.2 })
end

function MarketPurchaseSuccessRepeatablePresentation( button )
	--Flash({ Id = button.Id, Speed = 2, MinFraction = 0.3, MaxFraction = 0.0, Color = Color.LightGold, ExpireAfterCycle = true })
	SetAnimation({ DestinationId = button.Id, Name = button.PurchaseAnimation })
	CreateAnimation({ Name = "MarketPurchaseSparkles", DestinationId = button.Id, GroupName = "Overlay" })
end

function MarketRapidPurchasePresentation( screen, button )
	PlaySound({ Name = button.Data.RapidPurchaseSound or "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract2" })
end

function MarketSellAllPresentation( screen, button )
	local item = button.Data
	local brokerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BrokerGhost01", Distance = 800 })
	PlaySound({ Name = item.PurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	thread( PlayVoiceLines, item.ExchangeVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines.TradedMarketItemVoiceLines, true )
	if CheckCooldown( "PurchasedMarketItemRecently", 7 ) then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = brokerId, Delay = 1.5 })
	end
	thread( PulseText, { Id = screen.Components.BasicResourceButton.Id, ScaleTarget = 1.1, ScaleDuration = 0.3, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
end

function MarketScreenPurchaseFinishPresentation( screen, button, item )
	if CoinFlip() then
		for resourceName, resourceAmount in pairs( item.Cost ) do
			local resourceData = ResourceData[resourceName]
			thread( PlayVoiceLines, resourceData.BrokerSpentVoiceLines, true )
			break
		end
	else
		thread( PlayVoiceLines, ResourceData[item.BuyName].BrokerPurchaseVoiceLines, true )
	end
end

function MarketScreenMouseOverItem( button )
	local screen = button.Screen
	screen.SelectedItem = button
	screen.ClipboardText = button.Data.BuyName
	SetAnimation({ DestinationId = button.Id, Name = button.HighlightAnimation })
	UpdateMarketScreenInteractionText( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
	if not button.Category.FlipSides then
		GameState.ItemsViewed[button.Data.BuyName] = true
	end
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
end

function MarketScreenMouseOffItem( button )
	local screen = button.Screen
	if screen.SelectedItem ~= button then
		return
	end
	screen.SelectedItem = nil
	SetAnimation({ DestinationId = button.Id, Name = button.MouseOffAnimation })
	UpdateMarketScreenInteractionText( screen )
end