function OpenStoryResetPromptScreen( usee, args )
	args = args or {}

	local screen = DeepCopyTable( ScreenData.StoryResetPromptLayout )
	screen.OpenedFrom = usee
	local components = screen.Components
	OnScreenOpened( screen )

	GenericInfoPresentation( screen )

	CreateScreenFromData( screen, screen.ComponentData )

	TeleportCursor({ DestinationId = components.CloseButton.Id, ForceUseCheck = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray" })
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.3 })
	UseableOff({ Id = components.ConfirmButton.Id })
	wait(0.3)

	thread( FadeInStoryResetConfirmButton, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function FadeInStoryResetConfirmButton( screen )
	wait( 2.0 )
	SetAlpha({ Id = screen.Components.ConfirmButton.Id, Fraction = 1.0, Duration = 0.5 })
	wait( 0.5 )
	UseableOn({ Id = screen.Components.ConfirmButton.Id })
end

function CancelStoryResetPromptScreen( screen )
	TeleportCursor({ DestinationId = screen.ButtonId })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
end

function ConfirmStoryResetPromptScreen( screen )
	TeleportCursor({ DestinationId = screen.ButtonId })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )
	thread( ConfirmStoryResetPresentation, screen.OpenedFrom )
	screen.OpenedFrom.OnUsedFunctionName = nil
end

function ConfirmStoryResetPresentation( usee )
	AddInputBlock({ Name = "ConfirmStoryReset" })

	StopMusicianMusic( { Duration = 0.2 } )

	SetAnimation({ Name = "Melinoe_DeathHover_Start", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.5)

	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawn" })

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	AdjustColorGrading({ Name = "Chaos", Duration = 0.3 })

	wait( 0.2 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	wait( 0.5 )

	thread( PlayVoiceLines, HeroVoiceLines.StoryResetStartVoiceLines )

	wait(1.35)
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedNergal", Delay = 0.3 })

	FullScreenFadeOutAnimation("RoomTransitionIn_TimeWarp")
	FadeOut({ Color = Color.Black, Duration = 0.0 })
	Destroy({ Id = ScreenAnchors.Transition })
	SetAudioEffectState({ Name = "Reverb", Value = 1.5 })
	EndAmbience( 0.5 )
	wait( 2.0 )

	FadeIn({ Color = Color.Black, Duration = 0.3 })

	local gameOutroData = DeepCopyTable( GameOutroData.Outro_StoryReset01 )
	GameState.PlayedRunOutros[gameOutroData.Name] = true
	gameOutroData.Header = gameOutroData.Header or gameOutroData.Name
	RunInterstitialPresentation( gameOutroData,
		{
			Animations =
			{
				{
					AnimationName = "RemBGOutroStart",
				},
			}
		} )

	DoStoryReset()

	RemoveInputBlock({ Name = "ConfirmStoryReset" })

	LoadMap({ Name = "Hub_Main" })

end

function DoStoryReset()

	for i, worldUpgrade in ipairs( StoryResetData.WorldUpgrades ) do
		GameState.WorldUpgradesAdded[worldUpgrade] = nil
		GameState.WorldUpgrades[worldUpgrade] = nil
		if worldUpgrade ~= "WorldUpgradeWakeHypnosT3" then
			GameState.WorldUpgradesViewed[worldUpgrade] = nil
			GameState.WorldUpgradesRevealed[worldUpgrade] = nil
		end
	end

	for i, questName in ipairs( StoryResetData.Quests ) do
		GameState.QuestsCompleted[questName] = nil
		if GameState.QuestStatus[questName] ~= nil then
			GameState.QuestStatus[questName] = "Unlocked"
		end
	end

	for i, resourceName in ipairs( StoryResetData.Resources ) do
		GameState.Resources[resourceName] = nil
		GameState.LifetimeResourcesGained[resourceName] = nil
	end

	for i, eventName in ipairs( StoryResetData.TextLines ) do
		GameState.TextLinesRecord[eventName] = nil
		CurrentRun.TextLinesRecord[eventName] = nil
	end

	for i, voiceLine in ipairs( StoryResetData.VoiceLines ) do
		GameState.SpeechRecord[voiceLine] = nil
		CurrentRun.SpeechRecord[voiceLine] = nil

		GameState.SpeechRecordContexts[voiceLine] = nil
		CurrentRun.SpeechRecordContexts[voiceLine] = nil

		GameState.LastPlayedRandomLines[voiceLine] = nil
	end

	-- reset game state
	GameState.ReachedTrueEnding = nil
	GameState.TyphonDefeatedWithStormStop = nil
	GameState.RoomsEntered.Q_Story01 = nil
	GameState.EnemyKills.Chronos = nil
	GameState.EnemyKills.TyphonHead = nil
	GameState.LastBossDifficultyRecord.Chronos = nil
	GameState.LastBossDifficultyRecord.TyphonHead = nil
	GameState.LastBossHealthBarRecord.Chronos = 0.99
	GameState.LastBossHealthBarRecord.TyphonHead = 0.99

	-- reset current run state
	CurrentRun.PlayedTrueEnding = nil
	CurrentRun.Cleared = nil
	CurrentRun.EnemyKills.Chronos = nil
	CurrentRun.EnemyKills.TyphonHead = nil
	CurrentRun.EnemyKills.Zagreus = nil
	CurrentRun.RoomsEntered.I_PostBoss01 = nil
	CurrentRun.RoomsEntered.Q_Story01 = nil
	CurrentRun.RoomsEntered.C_Boss01 = nil

	-- reset recent run states
	for i = #GameState.RunHistory, math.max( #GameState.RunHistory - 10, 1 ), -1 do
		if GameState.RunHistory[i] ~= nil then
			GameState.RunHistory[i].Cleared = nil
			GameState.RunHistory[i].EnemyKills.Chronos = nil
			GameState.RunHistory[i].EnemyKills.TyphonHead = nil
			GameState.RunHistory[i].EnemyKills.Zagreus = nil
			GameState.RunHistory[i].RoomsEntered.I_PostBoss01 = nil
			GameState.RunHistory[i].RoomsEntered.Q_Story01 = nil
			GameState.RunHistory[i].RoomsEntered.C_Boss01 = nil
		end
	end

	-- reset hub state
	CurrentRun.SuppressAmbientMusic = nil
	CurrentRun.ArtemisHubSong = nil
	CurrentHubRoom = nil
	PreviousDeathAreaRoom = nil

	-- hide SunMoonTime cosmetic
	GameState.WorldUpgrades.Cosmetic_SunMoonTimeSculpture01 = nil

	-- set up escrow for mixers
	if GameState.Resources.MixerIBoss > 0 then
		GameState.ResourcesInEscrow.MixerIBoss = GameState.Resources.MixerIBoss
	end
	if GameState.Resources.MixerQBoss > 0 then
		GameState.ResourcesInEscrow.MixerQBoss = GameState.Resources.MixerQBoss
	end
	GameState.Resources.MixerIBoss = 0
	GameState.Resources.MixerQBoss = 0

	CurrentRun.UsedStoryReset = true
	GameState.StoryResetCount = (GameState.StoryResetCount or 0) + 1

end