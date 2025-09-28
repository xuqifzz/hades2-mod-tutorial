function MailboxScreenOpenPresentation( screen )
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedMailboxVoiceLines, true )
end

function MailboxScreenClosePresentation( screen, button )
	SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "MailboxScreenOut" })
end

function MailboxPurchaseFailPresentation( screen, button, item )
	Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2.0, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	Flash({ Id = screen.Components.BasicResourceButton.Id, Speed = 2.0, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	thread( PlayVoiceLines, GlobalVoiceLines.CannotAffordMailboxItemVoiceLines, true )
end

function MailboxPurchaseSuccessPresentation( screen, button, item )
	local brokerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BrokerGhost01", Distance = 800 })
	PlaySound({ Name = item.PurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	SetAnimation({ DestinationId = button.Id, Name = "MailboxScreenButtonPurchase" }) --nopkg
	thread( PlayVoiceLines, GlobalVoiceLines.TradedMailboxItemVoiceLines, true )
	thread( PulseText, { Id = screen.Components.BasicResourceButton.Id, ScaleTarget = 1.1, ScaleDuration = 0.3, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
end

function MailboxScreenMouseOverItem( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Id, Name = screen.ItemMouseOverAnimation })
	UpdateMailboxScreenInteractionText( button.Screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
	SetAlpha({ Id = button.NewIconId, Fraction = 0, Duration = 0.2 })
	CurrentRun.WorldUpgradesViewed[button.WorldUpgradeName] = true
	GameState.WorldUpgradesViewed[button.WorldUpgradeName] = true
end

function MailboxScreenMouseOffItem( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Id, Name = screen.ItemMouseOffAnimation })
	UpdateMailboxScreenInteractionText( button.Screen )
end

function SetupMailboxDeliveryPendingPresentation( source, args )
	local mailboxStatus = GameState.MailboxStatus[source.ObjectId]
	local text = "MailboxStatus_DeliveryPending"
	if mailboxStatus.TimeRemaining <= 0 then
		PlayStatusAnimation( source, { Animation = "StatusIconWantsToTalkImportant", } )
		SetAnimation({ Name = "SupplyDropObjectFull", DestinationId = source.ObjectId }) --nopkg
		if SessionMapState.MailboxTimerId ~= nil then
			Destroy({ Id = SessionMapState.MailboxTimerId })
			SessionMapState.MailboxTimerId = nil
		end
	else
		SetAnimation({ Name = "SupplyDropObjectClosed", DestinationId = source.ObjectId }) --nopkg
		if SessionMapState.MailboxTimerId ~= nil then
			ModifyTextBox({
				Id = SessionMapState.MailboxTimerId,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = mailboxStatus,
			})
		else
			SessionMapState.MailboxTimerId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = source.ObjectId, OffsetY = -180 })
			SetAnimation({ Name = "CauldronCookTimeShadow", DestinationId = SessionMapState.MailboxTimerId })  --nopkg
			CreateTextBox({
				Id = SessionMapState.MailboxTimerId,
				Text = text,
				OffsetY = -4,
				Justification = "Center",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
				OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
				Font = "P22UndergroundSCMedium",
				FontSize = 34,
				LuaKey = "TempTextData",
				LuaValue = mailboxStatus,
				AutoSetDataProperties = false,
				TextSymbolScale = 0.8,
			})
		end
	end
end

function UseMailboxDeliveryPendingPresentation( usee, args )
	local mailboxStatus = GameState.MailboxStatus[usee.ObjectId]
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "MelUsedLockedMailbox" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1.0, Speed = 75, Duration = 0.15 })
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanJostle2", Id = usee.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.WaitingForMailboxItemVoiceLines, true )
	thread( InCombatText, usee.ObjectId, "MailboxCheckDeliveryPending", 3.0, { LuaKey = "MailboxStatus", LuaValue = mailboxStatus, ShadowScaleX = 1.5, OffsetY = -180 } )
	wait( 1.85 )
	RemoveInputBlock({ Name = "MelUsedLockedMailbox" })
	wait( 1.35, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
end

function UseMailboxDeliveryReadyPresentation( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "MelUsedMailbox" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/ChallengeChestUnlocked", Id = usee.ObjectId })
	CreateAnimation({ Name = "PickupFlareA", DestinationId = usee.ObjectId, Scale = 0.5})
	Shake({ Id = usee.ObjectId, Distance = 2.0, Speed = 75, Duration = 0.15 })
	thread( PlayVoiceLines, HeroVoiceLines.ReceivedSupplyDropVoiceLines, true )
	SetAnimation({ Name = "SupplyDropObjectEmpty", DestinationId = usee.ObjectId }) --nopkg
	wait(0.5)
	RemoveInputBlock({ Name = "MelUsedMailbox" })
	UseableOn({ Id = usee.ObjectId })
end

function CharonPointsGrantedPresentation( amount, sourceName )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Id = CurrentRun.Hero.ObjectId })
end