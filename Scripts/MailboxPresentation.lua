function MailboxScreenOpenPresentation( screen )
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedMailboxVoiceLines, true )
end

function MailboxScreenClosePresentation( screen, button )
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedMailboxVoiceLines, true )
end

function MailboxSessionCompletePresentation( usee, screen )
	if screen.NumItems == 0 then
		return
	end
	if screen.NumSales == 0 then
		if CheckCooldown( "MailboxNoSale", 60 ) then
			-- PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = 558096 })
			PlayEmote( { TargetId = usee.NoSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	else
		if CheckCooldown( "MailboxMadeSale", 60 ) then
			PlayEmote( { TargetId = usee.MadeSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	end
end

function MailboxPurchaseFailPresentation( screen, button, item )
	Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2.0, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	Flash({ Id = screen.Components.BasicResourceButton.Id, Speed = 2.0, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	thread( PlayVoiceLines, GlobalVoiceLines.CannotAffordMailboxItemVoiceLines, true )
end

function MailboxPurchaseSuccessPresentation( screen, item )
	local brokerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BrokerGhost01", Distance = 800 })
	PlaySound({ Name = item.PurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	thread( PlayVoiceLines, GlobalVoiceLines.TradedMailboxItemVoiceLines, true )
	if CheckCooldown( "PurchasedMailboxItemRecently", 3 ) then
		-- PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = brokerId, Delay = 1.5 })
	end
	thread( PulseText, { Id = screen.Components.BasicResourceButton.Id, ScaleTarget = 1.1, ScaleDuration = 0.3, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
end

function MailboxScreenPurchaseFinishPresentation( screen, button, item )
	if CoinFlip() then
		for resourceName, resourceAmount in pairs( item.Cost ) do
			local resourceData = ResourceData[resourceName]
			-- thread( PlayVoiceLines, resourceData.BrokerSpentVoiceLines, true )
			break
		end
	else
		-- thread( PlayVoiceLines, ResourceData[item.BuyName].BrokerPurchaseVoiceLines, true )
	end
end

function MailboxScreenMouseOverItem( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Id, Name = screen.ItemHighlightAnimation })
	UpdateMailboxScreenInteractionText( button.Screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOut", Id = button.Id })
end

function MailboxScreenMouseOffItem( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Id, Name = screen.ItemAnimation })
	UpdateMailboxScreenInteractionText( button.Screen )
end

function SetupMailboxDeliveryPendingPresentation( source, args )
	local mailboxStatus = GameState.MailboxStatus[source.ObjectId]
	--SetAnimation({ DestinationId = source.ObjectId, Name = GardenData.JustPlantedAnimation })
	local text = "MailboxStatus_DeliveryPending"
	if mailboxStatus.TimeRemaining <= 0 then
		text = "MailboxStatus_DeliveryReady"
		PlayStatusAnimation( source, { Animation = "StatusIconWantsToTalkImportant", } )
		SetAnimation({ Name = "SupplyDropObjectFull", DestinationId = source.ObjectId })
	else
		SetAnimation({ Name = "SupplyDropObjectClosed", DestinationId = source.ObjectId })
	end
	if SessionMapState.MailboxTextBoxCreated then
		ModifyTextBox({
			Id = source.ObjectId,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = mailboxStatus,
		})
	else
		SessionMapState.MailboxTextBoxCreated = true
		CreateTextBox({
			Id = source.ObjectId,
			Text = text,
			Justification = "Center",
			OffsetX = -30,
			OffsetY = -60,
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Font = "P22UndergroundSCMedium",
			FontSize = 26,
			LuaKey = "TempTextData",
			LuaValue = mailboxStatus,
			AutoSetDataProperties = false,
		})
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
	thread( InCombatText, usee.ObjectId, "MailboxCheckDeliveryPending", 3.0, { LuaKey = "MailboxStatus", LuaValue = mailboxStatus, ShadowScaleX = 1.5 } )
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
	SetAnimation({ Name = "SupplyDropObjectEmpty", DestinationId = usee.ObjectId })
	wait(0.5)
	RemoveInputBlock({ Name = "MelUsedMailbox" })
	UseableOn({ Id = usee.ObjectId })
end

function CharonPointsGrantedPresentation( amount, sourceName )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Id = CurrentRun.Hero.ObjectId })
end