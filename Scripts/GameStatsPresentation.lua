function GameStatsScreenOpenPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedGameStatsScreenVoiceLines, true )
end

function GameStatsScreenShowCategoryPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })

	if not GameState.ScreensViewed.WeaponUpgradeScreen or not GameState.ScreensViewed.KeepsakeRack then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenEmptyVoiceLines, true )
	end

	if screen.CurrentFilter == "GameStats_Weapons" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenWeaponVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_Boons" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenBoonVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_WeaponUpgrades" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenHammerVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_Aspects" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenAspectVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_Keepsakes" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenKeepsakeVoiceLines, true )
	end
end

function GameStatsScreenScrollPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function GameStatScreenClosePresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedRunHistoryScreenVoiceLines, true )
end

function GameStatsSetActiveColumnPresentation( screen )
	local column = screen.Components[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]]
	local indicator = screen.Components.SortModeIndicator
	ModifyTextBox({ Id = column.Id, Color = screen.ActiveColumnColor })
	Move({ Id = indicator.Id, OffsetX = column.X + indicator.OffsetX, OffsetY = column.Y + indicator.OffsetY})
	SetAlpha({ Id = indicator.Id, Fraction = 1.0, Duration = 0.1 })
end