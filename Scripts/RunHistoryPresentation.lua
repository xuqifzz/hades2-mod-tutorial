function RunHistoryScreenOpenPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines, true )

	local animationIndex = nil
	if WasBountyRun( CurrentRun ) then
		animationIndex = 5
	elseif WasSurfaceRun( CurrentRun ) then
		animationIndex = 3
	else
		animationIndex = 1
	end
	if not WasRunSuccess( CurrentRun ) then
		SetAlpha({ Id = screen.Components.ResultRibbonSuccess.Id, Fraction = 0.0 })
		animationIndex = animationIndex + 1
	end
	SetAnimation({ DestinationId = screen.Components.ForegroundTheme.Id, Name = screen.InAnimations[animationIndex] })

	wait( 0.5 )

end

function SetRunHistoryThemePresentation( screen, args )

	screen.TargetTransitionTime = _worldTimeUnmodified + 0.2
	screen.TargetAnimationIndex = args.NewAnimationIndex

	if screen.TransitioningTheme then
		return
	end

	if screen.LastSelectedAnimationIndex == nil or args.NewAnimationIndex == screen.LastSelectedAnimationIndex then
		return
	end

	screen.TransitioningTheme = true
	SetAnimation({ DestinationId = screen.Components.ForegroundTheme.Id, Name = screen.TransitionToBlankAnimations[screen.LastSelectedAnimationIndex] })
	while _worldTimeUnmodified < screen.TargetTransitionTime do
		wait( 0.02, "SetRunHistoryThemePresentation" )
	end
	SetAnimation({ DestinationId = screen.Components.ForegroundTheme.Id, Name = screen.TransitionFromBlankAnimations[screen.TargetAnimationIndex] })
	screen.TransitioningTheme = nil
	screen.TargetAnimationIndex = nil
	screen.TargetTransitionTime = nil
end

function ShowRunHistoryPresentation( screen, run )
	if WasRunSuccess( run ) then
		thread( PlayVoiceLines, GlobalVoiceLines.PositiveRunHistoryScreenVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.NegativeRunHistoryScreenVoiceLines, true )
	end
end

function RunHistoryScreenClosedPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedRunHistoryScreenVoiceLines, true )

	killTaggedThreads( "SetRunHistoryThemePresentation" )
	local runButton = screen.Components[screen.ButtonName..screen.RunIndex]
	SetAnimation({ DestinationId = screen.Components.ForegroundTheme.Id, Name = screen.OutAnimations[runButton.AnimationIndex] })
	SetAnimation({ DestinationId = screen.Components.ResultRibbonSuccess.Id, Name = "RunHistoryRibbon_Success_Out" }) --nopkg
	SetAnimation({ DestinationId = screen.Components.ResultRibbonFailure.Id, Name = "RunHistoryRibbon_Failure_Out" }) --nopkg
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

	screen.ViewingTraitTray = false

	Teleport({ Id = screen.Components.HoverMarker.Id, DestinationId = button.Id })
	SetAlpha({ Id = screen.Components.HoverMarker.Id, Fraction = 1.0 })

	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })
	RunHistorySelectRun( button )
end

function RunHistoryMouseOffRun( button )
	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.HoverMarker.Id, Fraction = 0.0 })
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

	screen.ViewingTraitTray = true

	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuToggle2" })

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
