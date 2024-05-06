
function OpenElementalPromptScreen( parentScreen )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.ElementalPromptLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)

	
	for index, data in pairs(parentScreen.UpgradeButtons) do
		ModifyTextBox({ Id = parentScreen.Components["PurchaseButton"..index].Id, BlockTooltip = true })
	end
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function ExitElementalPromptScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
	local parentScreen = screen.ParentScreen
	for index, data in pairs(parentScreen.UpgradeButtons) do
		if not Contains( parentScreen.BlockedIndexes, index ) then
			ModifyTextBox({ Id = parentScreen.Components["PurchaseButton"..index].Id, BlockTooltip = false })
		end
	end
end