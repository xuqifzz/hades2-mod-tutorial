function CodexUnlockPresentation( args )
	args = args or {}
	DisplayInfoToast( nil, { Title = "ThingUnlocked", Text = "Codex_Unlocked_Subtitle", } )
	wait( 0.25 )
	thread( ShowCodexUpdate )
end

function ShowCodexUpdate( args )
	args = args or {}
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end
	if not CodexStatus.Enabled then
		return
	end

	wait(0.5)

	local callLockName = "CodexUpdate"
	if not CheckCallLock( callLockName ) then
		return
	end

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 770, Group = "Combat_UI", })
	SetAnimation({ Name = args.Animation or "CodexUpdateIn", DestinationId = toastAnchor })
	PlaySound({ Name = "/SFX/Menu Sounds/CodexUpdatedShk", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = "Codex_EntryUnlocked",
		Group = "Combat_UI",
		Justification = "Center",
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 1},
		OutlineThickness = 2,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		Color = Color.White,
		Font="P22UndergroundSCHeavy",
		TextSymbolScale = 1,
		FontSize = 28,
		CharFadeTime = 0.02,
		CharFadeInterval = .002,
		CharFadeColor = Color.White,
		CharFadeColorLag = 0.25,
		OffsetX = 0,
		OffsetY = 80,
	})

	wait(1.0)

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })

	wait(2.0)

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })

	wait(1.0)

	Destroy({ Id = toastAnchor })
	ReleaseCallLock( callLockName )

end

function CannotOpenCodexPresentation()
	if not IsEmpty( ActiveScreens ) then
		return
	end
	if CheckCooldown( "CanOpenCodex", 5 ) then

		thread( InCombatTextArgs, { Text = "CodexNotFoundMessage", TargetId = CurrentRun.Hero.ObjectId, SkipRise = true, SkipFlash = true, SkipShadow = true, Duration = 1.25, OffsetY = -160 } )
		-- PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = CurrentRun.Hero.ObjectId })
		-- thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	end
end

function MouseOverCodexChapter( button )
	local screen = button.Screen
	SetAnimation({ Name = button.TabData.Highlight, DestinationId = button.Id })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
	local previousShift = not IsEmpty( button.IconShiftRequests )
	button.IconShiftRequests.MouseOver = true
	if not previousShift then
		Move({ Id = button.IconId, Angle = 90, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
	end
end

function MouseOffCodexChapter( button )
	local screen = button.Screen
	SetAnimation({ Name = button.TabData.Animation, DestinationId = button.Id })
	local previousShift = not IsEmpty( button.IconShiftRequests )
	button.IconShiftRequests.MouseOver = nil
	if previousShift and IsEmpty( button.IconShiftRequests ) then
		Move({ Id = button.IconId, Angle = 270, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
	end
end

function MouseOverCodexEntry( button )
	local screen = button.Screen
	TriggerCooldown( "MouseOverCodexEntry"..button.Id )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })
end

function MouseOffCodexEntry( button )
	local screen = button.Screen
	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = screen.MouseOverScaleDuration })
end

function CodexScreenOpenChapterPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU", Id = button.Id })
end

function CodexScreenOpenEntryPresentation( screen, button, args )
	if not args.AutoOpen and CheckCooldown( "MouseOverCodexEntry"..button.Id, 0.03 ) then
		PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU", Id = button.Id })
	end
end