function RunHistoryScreenOpenPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines, true )
end

function ShowRunHistoryPresentation( screen, run, index )
	if run.Cleared then
		thread( PlayVoiceLines, GlobalVoiceLines.PositiveRunHistoryScreenVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.NegativeRunHistoryScreenVoiceLines, true )
	end
end

function RunHistoryScreenClosedPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedRunHistoryScreenVoiceLines, true )
end

function RunHistoryMouseOverRun( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end

	-- Transitioning from item -> run
	if screen.LastMouseOffItemTime == _worldTimeUnmodified and screen.RunIndex ~= button.RunIndex then
		screen.LastMouseOffItemTime = 0
		TeleportCursor({ DestinationId = screen.Components[screen.ButtonName..screen.RunIndex].Id, ForceUseCheck = true })
		return
	end

	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })
	RunHistorySelectRun( button )
end

function RunHistoryMouseOffRun( button )
	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
	button.Screen.LastMouseOffRunTime = _worldTimeUnmodified
end

function MouseOverRunHistoryItem( button )
	local screen = button.Screen
	local components = screen.Components

	-- Transitioning from run -> item
	if screen.LastMouseOffRunTime == _worldTimeUnmodified and button ~= screen.FirstItem then
		screen.LastMouseOffRunTime = 0
		TeleportCursor({ DestinationId = screen.FirstItem.Id, ForceUseCheck = true })
		return
	end

	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle" })

	ModifyTextBox({ Id = components.TraitName.Id, Text = button.Data.Name, FadeTarget = 1.0, FadeDuration = 0.2 })

	Teleport({ Id = components.HoverFrame.Id, DestinationId = button.Id })
	SetAnimation({ DestinationId = components.HoverFrame.Id, Name = button.HighlightAnim })
	SetAlpha({ Id = components.HoverFrame.Id, Fraction = 1.0, Duration = 0.2 })
	SetScale({ Id = components.HoverFrame.Id, Fraction = button.HighlightScale })
end

function MouseOffRunHistoryItem( button )
	local screen = button.Screen
	local components = screen.Components
	ModifyTextBox({ Id = components.TraitName.Id, Text = button.Data.Name, FadeTarget = 0.0, FadeDuration = 0.2 })
	SetAlpha({ Id = components.HoverFrame.Id, Fraction = 0.0, Duration = 0.2 })
	screen.LastMouseOffItemTime = _worldTimeUnmodified
end
