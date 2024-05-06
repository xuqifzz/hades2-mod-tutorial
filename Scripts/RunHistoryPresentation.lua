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

function RunHistorySwitchPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
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

	screen.RunIndex = button.RunIndex

	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })

	Teleport({ Id = screen.Components.SelectionMarker.Id, DestinationId = button.Id, OffsetX = screen.Components.SelectionMarker.Data.ButtonOffsetX, OffsetY = screen.Components.SelectionMarker.Data.ButtonOffsetY })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 1.0, Duration = 0.2 })

	ShowRunHistory( screen, button.Run, button.RunIndex )
end

function RunHistoryMouseOffRun( button )
	local screen = button.Screen
	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 0.0, Duration = 0.2 })
end