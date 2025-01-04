function OpenSellAllMarketPromptScreen( parentScreen, button )
	args = args or {}

	local screen = DeepCopyTable( ScreenData.MarketSellAllLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	screen.ButtonId = button.Id
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	local sellKey = GetFirstKey(button.Data.Cost)
	local sellAmount = GameState.Resources[sellKey]
	local buyKey = button.Data.BuyName
	local buyAmount = button.Data.BuyAmount * sellAmount
	local textData =
	{
		SellAmount = sellAmount,
		SellResourceIcon = ResourceData[sellKey].TextIconPath,
		BuyAmount = buyAmount,
		BuyResourceIcon = ResourceData[buyKey].TextIconPath,
	}
	ModifyTextBox({ Id = components.DescriptionText.Id, Text = name, LuaKey = "TempTextData", LuaValue = textData })

	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)

	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CancelSellAllMarketPromptScreen( screen )
	TeleportCursor({ DestinationId = screen.ButtonId })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end

function ConfirmSellAllMarketPromptScreen( screen )
	screen.ParentScreen.DoSellAll = true
	TeleportCursor({ DestinationId = screen.ButtonId })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end