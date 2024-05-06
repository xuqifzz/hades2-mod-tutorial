function MarketScreenOpenPresentation( screen )
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedMarketVoiceLines, true )
end

function MarketScreenClosePresentation( screen, button )
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedMarketVoiceLines, true )
end

function MarketSessionCompletePresentation( usee, screen )
	if screen.NumItems == 0 then
		return
	end
	if screen.NumSales == 0 then
		if CheckCooldown( "MarketNoSale", 60 ) then
			PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = 558096 })
			PlayEmote( { TargetId = usee.NoSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	else
		if CheckCooldown( "MarketMadeSale", 60 ) then
			PlayEmote( { TargetId = usee.MadeSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	end
end

function MarketPurchaseFailPresentation( screen, button )
	local item = button.Data
	Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 3, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	Flash({ Id = screen.Components.MetaCurrencyBacking.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
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
	PlaySound({ Name = item.PurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	--thread( PlayVoiceLines, item.PurchasedLines, true )
	if item.Priority then
		thread( PlayVoiceLines, GlobalVoiceLines.TradedMarketItemVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.TradedMarketItemVoiceLines, true )
	end
	if CheckCooldown( "PurchasedMarketItemRecently", 5 ) then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = brokerId, Delay = 1.5 })
	end
	thread( PulseText, { Id = screen.Components.BasicResourceButton.Id, ScaleTarget = 1.1, ScaleDuration = 0.3, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
	thread( PulseText, { Id = screen.Components["CurrentAmount"..button.Index].Id, ScaleTarget = 1.2, ScaleDuration = 0.3, Color = Color.White, OriginalColor = screen.ItemAmountFormat.Color, ColorDuration = 0.3, HoldDuration = 0.2, PulseBias = 0.2 })
end

function MarketPurchaseSuccessRepeatablePresentation( button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 1, MaxFraction = 0.0, Color = Color.LightGold, ExpireAfterCycle = true })
	CreateAnimation({ Name = "MarketPurchaseSparkles", DestinationId = button.Id, GroupName = "Overlay" })
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
	SetAnimation({ DestinationId = button.Id, Name = button.HighlightAnimation })
	UpdateMarketScreenInteractionText( button.Screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOut", Id = button.Id })
	if not button.Category.FlipSides then
		GameState.ItemsViewed[button.Data.BuyName] = true
	end
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
end

function MarketScreenMouseOffItem( button )
	SetAnimation({ DestinationId = button.Id, Name = button.Animation })
	UpdateMarketScreenInteractionText( button.Screen )
end