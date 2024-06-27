function OpenMetaUpgradeCardPromptScreen( parentScreen, args )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.MetaUpgradeCardPromptLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	if args.CustomText then
		GameState.PromptCustomTextViewed[args.CustomText] = true
		ModifyTextBox({ Id = components.Background.Id, Text = args.CustomText })
	end
	if args.CustomConfirmText then
		ModifyTextBox({ Id = components.ConfirmButton.Id, Text = args.CustomConfirmText })
	end
	if args.CustomCancelText then
		ModifyTextBox({ Id = components.CloseButton.Id, Text = args.CustomCancelText })
	end
	if args.CenterText then
		Destroy({ Id = components.ConfirmButton.Id })
		Destroy({ Id = components.CloseButton.Id })
		ModifyTextBox({ Id = components.CenteredButton.Id, Text = args.CustomCancelText or args.CustomConfirmText })
		TeleportCursor({ DestinationId = components.CenteredButton.Id, ForceUseCheck = true })
	else
		Destroy({ Id = components.CenteredButton.Id })
		TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	end
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)


	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
	screen.KeepOpen = true
	HandleScreenInput( screen )
	end


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

function OpenGraspLimitScreen( parentScreen, useAltText )
	args = args or {}
	local screen = DeepCopyTable( ScreenData.GraspLimitLayout )
	local components = screen.Components
	screen.ParentScreen = parentScreen
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	if useAltText then
		ModifyTextBox({ Id = components.TitleText.Id, Text = "MetaUpgradeTable_UnableToEquip_Alt"})
		ModifyTextBox({ Id = components.DescriptionText.Id, UseDescription = true, Text = "MetaUpgradeTable_UnableToEquip_Alt"})
	end
	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)


	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
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
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)


	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
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
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)


	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
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
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	wait(0.3)


	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CancelExitCardUpgradeInfoScreen( screen )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end

function ConfirmExitCardUpgradeInfoScreen( screen )
	screen.ParentScreen.Exit = true
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end