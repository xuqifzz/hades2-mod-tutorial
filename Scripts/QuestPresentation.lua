function QuestLogOpenFinishPresentation( screen )
	if screen.AnyNew then
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogNewQuestsAddedVoiceLines, true )
	elseif screen.NumToCashOut == 1 then
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogSingleQuestCompleteVoiceLines, true )
	elseif screen.NumToCashOut >= 2 then
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogMultiQuestsCompleteVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogVoiceLines, true )
	end
end

function QuestIncompletePresentation( button )

end

function MouseOverQuest( button )

	local screen = button.Screen
	screen.ProgressPageOffset = 0
	QuestScreenShowDescription( button )
end

function QuestScreenShowDescription( button )

	if button == nil then
		return
	end

	local screen = button.Screen
	QuestScreenRemoveDescription( screen.SelectedButton )
	screen.SelectedButton = button

	ModifyTextBox({ Id = button.Id, ScaleTarget = screen.MouseOverScaleTarget, ScaleDuration = screen.MouseOverScaleDuration })

	Teleport({ Id = screen.Components.SelectionMarker.Id, DestinationId = button.Id, OffsetX = screen.Components.SelectionMarker.Data.ButtonOffsetX, OffsetY = screen.Components.SelectionMarker.Data.ButtonOffsetY })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 1.0, Duration = 0.2 })

	-- Remove previous description
	DestroyTextBox({ Id = button.Screen.Components.DescriptionBox.Id })

	GenericMouseOverPresentation( button )

	ModifyTextBox({ Id = button.Screen.Components.InfoBoxTitle.Id, Text = button.Data.Name })
	SetAlpha({ Id = screen.Components.InfoBoxTitle.Id, Fraction = 1.0, Duration = 0.2 })

	ModifyTextBox({ Id = button.Screen.Components.InfoBoxDescription.Id, Text = button.Data.Name, UseDescription = true })
	SetAlpha({ Id = screen.Components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })

	-- Reward
	local rewardColor = screen.RewardAvailableColor
	if GameState.QuestStatus[button.Data.Name] == "CashedOut" then
		rewardColor = screen.RewardCashedOutColor
	else
		if IsGameStateEligible( CurrentRun, button.Data, button.Data.CompleteGameStateRequirements ) then
			-- Hint
			--[[
			CreateTextBox({ Id = button.Screen.Components.DescriptionBox.Id,
				Text = "QuestLog_CashOutHint",
				FontSize = 22,
				OffsetX = 250, OffsetY = 185,
				Color = rewardColor,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left" })]]
			SetAlpha({ Id = button.Screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end

	local resourceData = ResourceData[button.Data.RewardResourceName]
	
	SetAlpha({ Id = button.Screen.Components.RewardText.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = button.Screen.Components.RewardText.Id, 
		LuaKey = "TempTextData",
		LuaValue = { Icon = resourceData.TextIconPath or resourceData.IconPath, Amount = button.Data.RewardResourceAmount },
		Color = rewardColor,
		})

	local newButtonKey = "NewIcon"..button.Index
	if button.Screen.Components[newButtonKey] ~= nil then
		SetAlpha({ Id = button.Screen.Components[newButtonKey].Id, Fraction = 0, Duration = 0.2 })
	end
	if button.Data.OnViewedVoiceLines ~= nil then
		thread( PlayVoiceLines, button.Data.OnViewedVoiceLines, true )
	end
	local functionPlayed = false
	if GameState.QuestsViewed[button.Data.Name] then
		functionPlayed = true
	end
	if button.Data.OnViewedFunctionName ~= nil then
		if not functionPlayed then
			thread( CallFunctionName, button.Data.OnViewedFunctionName, button, button.Data.OnViewedFunctionArgs, textLines, screen )
		end
	end
	GameState.QuestsViewed[button.Data.Name] = true

	ShowQuestProgress( button.Screen, button.Data )
end

function MouseOffQuest( button )
	
end

function QuestScreenRemoveDescription( button )
	if button == nil then
		return
	end
	local screen = button.Screen
	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
	DestroyTextBox({ Id = button.Screen.Components.DescriptionBox.Id })
	SetAlpha({ Id = button.Screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = button.Screen.Components.RewardText.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 0.0, Duration = 0.2 })
end

function QuestLogPrevProgressPage( screen, button )
	local prevOffset = screen.ProgressPageOffset
	screen.ProgressPageOffset = screen.ProgressPageOffset - 2
	if screen.ProgressPageOffset <= 0 then
		screen.ProgressPageOffset = 0
	end
	if prevOffset == screen.ProgressPageOffset then
		return
	end
	QuestScreenRemoveDescription( screen.SelectedButton )
	QuestScreenShowDescription( screen.SelectedButton )
end

function QuestLogNextProgressPage( screen, button )
	local prevOffset = screen.ProgressPageOffset
	screen.ProgressPageOffset = screen.ProgressPageOffset + 2
	local maxPageOffset = screen.NumRequirementsColumns - screen.RequirementEntriesMaxColumns
	if maxPageOffset % 2 == 1 then
		maxPageOffset = maxPageOffset + 1
	end
	if screen.ProgressPageOffset > maxPageOffset then
		screen.ProgressPageOffset = maxPageOffset
	end
	if prevOffset == screen.ProgressPageOffset then
		return
	end
	QuestScreenRemoveDescription( screen.SelectedButton )
	QuestScreenShowDescription( screen.SelectedButton )
end

--[[
function MouseOffQuestPresentation( button )
	if GetConfigOptionValue({ Name = "UseMouse" }) then

		local text ="QuestLog_SelectHint"
		if HasAllQuestsWithStatus( "CashedOut" ) then
			text ="QuestLog_SelectHintAllClear"
		end
		if button ~= nil then
			CreateTextBox({ Id = button.Screen.Components.DescriptionBox.Id,
				Text = text,
				FontSize = 34,
				OffsetX = 365, OffsetY = 245,
				Color = Color.White,
				TextSymbolScale = 0.9,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
				Justification = "Center" })
		end
	end
end
]]

function QuestAddedPresentation( questData, threadName )

	wait( 0.5, threadName )

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 400, Y = 770 })
	SetAnimation({ Name = "QuestAdded", DestinationId = toastAnchor })
	PlaySound({ Name = "/SFX/Menu Sounds/NewQuestToast", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = "QuestLog_QuestAdded",
		Group = "ScreenOverlay",
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
		OffsetY = 120,
	})
	wait( 1.0, threadName )

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })
	wait( 0.5, threadName )

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })
	wait( 1.0, threadName )

	Destroy({ Id = toastAnchor })

end

function QuestCompletedPresentation( questData, threadName )

	wait( 0.5, threadName )

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 400, Y = 770 })
	SetAnimation({ Name = "QuestComplete", DestinationId = toastAnchor })
	PlaySound({ Name = "/SFX/Menu Sounds/QuestCompleteToast", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = "QuestLog_QuestComplete",
		Group = "ScreenOverlay",
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
		OffsetY = 120,
	})
	wait( 1.0, threadName )

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })
	wait( 0.5, threadName )

	if CurrentHubRoom ~= nil then
		UpdateAffordabilityStatus()
	end

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })
	wait( 1.0, threadName )

	Destroy({ Id = toastAnchor })

end

function QuestCashedOutPresentation( screen, button )

	local newButtonKey = "NewIcon"..button.Index
	if screen.Components[newButtonKey] ~= nil then
		SetAlpha({ Id = screen.Components[newButtonKey].Id, Fraction = 0, Duration = 0.1 })
	end

	PlaySound({ Name = "/SFX/Menu Sounds/QuestCashIn" })

	local morosId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Moros_01" })
	local moros = ActiveEnemies[morosId]

	-- play Moros' lines if he is available, otherwise Mel lines
	if moros ~= nil and not moros.InPartnerConversation then
		thread( PlayVoiceLines, button.Data.CashedOutVoiceLines or HeroVoiceLines.CashedOutQuestVoiceLines )
	else
		thread( PlayVoiceLines, HeroVoiceLines.CashedOutQuestVoiceLines )
	end
end