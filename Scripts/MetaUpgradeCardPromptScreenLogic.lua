function CancelExitMetaUpgradeCardPrompt( screen )
	CloseMetaUpgradeCardPromptScreen( screen )
end

function ConfirmExitMetaUpgradeCardPrompt( screen )
	screen.ParentScreen.Exit = true
	CloseMetaUpgradeCardPromptScreen( screen )

end

function CloseMetaUpgradeCardPromptScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
	notifyExistingWaiters("CardPromptScreenClosed")
end

function OpenGraspLimitScreen( parentScreen, args )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.GraspLimitLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	if args.UnlockedCards then
		ModifyTextBox({ Id = components.TitleText.Id, Text = "MetaUpgradeTable_UnableToEquip_Alt"})
		ModifyTextBox({ Id = components.DescriptionText.Id, UseDescription = true, Text = "MetaUpgradeTable_UnableToEquip_Alt"})
	elseif args.CanAfford then
		ModifyTextBox({ Id = components.TitleText.Id, Text = "MetaUpgradeTable_UnableToEquip_Alt2"})
		ModifyTextBox({ Id = components.DescriptionText.Id, UseDescription = true, Text = "MetaUpgradeTable_UnableToEquip_Alt2"})
	end
	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray_Overlay" })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)

	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CloseGraspLimitScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end
function OpenBelowLimitScreen( parentScreen )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.BelowLimitLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray_Overlay" })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)

	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CancelExitBelowLimitScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end
function ConfirmExitBelowLimitScreen( screen )
	screen.ParentScreen.Exit = true
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end

function OpenNoUpgradeInfoScreen( parentScreen )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.NoUpgradeInfoLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray_Overlay" })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)

	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CancelExitNoUpgradeInfoScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end

function ConfirmExitNoUpgradeInfoScreen( screen )
	screen.ParentScreen.Exit = true
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end
function OpenCardUpgradeInfoScreen( parentScreen )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.CardUpgradeInfoLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray_Overlay" })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)

	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CancelExitCardUpgradeInfoScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end