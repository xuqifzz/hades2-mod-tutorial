function OpenTradeScreen( source, args, chosenGiveOption, chosenGetOption )

	InvalidateCheckpoint()

	local screen = DeepCopyTable( ScreenData.TradeScreen )
	screen.Source = source
	screen.Args = args
	screen.ChosenGiveOption = chosenGiveOption
	screen.ChosenGetOption = chosenGetOption

	local giveItemData = nil
	local frameAnim = nil
	if screen.ChosenGiveOption.SellTrait then
		GenerateSellTraitShop( CurrentRun.CurrentRoom, { SellOptionCount = 1, PrioritizeCommonTraits = true } )
		for i, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
			giveItemData = CurrentRun.Hero.TraitDictionary[sellData.Name][1]
			frameAnim = GetTraitFrame( giveItemData )
			SetTraitTextData( giveItemData )
		end
	elseif screen.ChosenGiveOption.UseGetCost then
		chosenGiveOption.Cost = RandomInt( chosenGetOption.CostResourceMin, chosenGetOption.CostResourceMax )
		giveItemData = ShallowCopyTable( ResourceData[chosenGetOption.CostResourceName] )
		giveItemData.Cost = chosenGiveOption.Cost
		giveItemData.DisplayName = "TradeScreen_TradeCost"
		giveItemData.ResourceName = chosenGetOption.CostResourceName
	elseif screen.ChosenGiveOption.UseGetDamage then
		chosenGiveOption.DamageAmount = RandomInt( chosenGetOption.DamageAmountMin, chosenGetOption.DamageAmountMax )
		giveItemData = chosenGiveOption
		giveItemData.DisplayName = "TradeScreen_DamageAmount"
	else
		giveItemData = TraitData[chosenGiveOption.Name] or ConsumableData[chosenGiveOption.Name]
		if TraitData[chosenGiveOption.Name] then
			SetTraitTextData( giveItemData )
		end
	end

	HideCombatUI( screen.Name )
	UnblockCombatUI( "PlayTextLines" )

	OnScreenOpened( screen )	
	CreateScreenFromData( screen, screen.ComponentData )

	local components = screen.Components

	-- Give Option

	local rarity = giveItemData.Rarity or "Common"
	local rarityColor = Color["BoonPatch"..rarity]
	local rarityText = "Boon_"..rarity

	local giveItemIcon = giveItemData.TradeIcon or giveItemData.Icon or giveItemData.SurfaceShopIcon or giveItemData.IconPath
	if giveItemIcon ~= nil then
		SetAnimation({ Name = giveItemIcon, DestinationId = components.GiveInfoBoxIcon.Id })
		SetAlpha({ Id = components.GiveInfoBoxIcon.Id, Fraction = 1.0, Duration = 0.2 })
		
		if frameAnim ~= nil then
			SetAnimation({ Name = frameAnim, DestinationId = components.GiveInfoBoxFrame.Id })
			SetAlpha({ Id = components.GiveInfoBoxFrame.Id, Fraction = 1.0, Duration = 0.2 })
			SetScale({ Id = components.GiveInfoBoxIcon.Id, Fraction = components.GiveInfoBoxFrame.Scale })
		end

		rarityColor = giveItemIcon.CustomRarityColor or rarityColor
		rarityText = giveItemIcon.CustomRarityName or rarityText
	end

	ModifyTextBox({ Id = components.GiveInfoBoxName.Id,
		Text = giveItemData.DisplayName or giveItemData.Name,
		Color = rarityColor,
		LuaKey = "TooltipData",
		LuaValue = giveItemData,
	})

	ModifyTextBox({ Id = components.GiveInfoBoxBacking.Id,
		Text = giveItemData.DisplayName or giveItemData.Name,
		UseDescription = true,
		LuaKey = "TooltipData",
		LuaValue = giveItemData,
	})

	if giveItemData.ResourceName ~= nil then
		local text = "TradeScreen_CurrentMoney"
		if not HasResource( giveItemData.ResourceName, chosenGiveOption.Cost ) then
			text = "TradeScreen_CurrentMoney_CantAfford"
		end
		ModifyTextBox({ Id = components.GiveInfoBoxSubText.Id,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = { Amount = GameState.Resources[giveItemData.ResourceName] },
		})
	end

	--[[
	local backingAnim = ScreenData.UpgradeChoice.RarityBackingAnimations[rarity]
	if backingAnim ~= nil then
		SetAnimation({ Name = backingAnim, DestinationId = components.GiveInfoBoxBacking.Id })
	end
	]]

	--[[
	ModifyTextBox({ Id = components.GiveInfoBoxRarity.Id,
		Text = rarityText,
		Color = rarityColor
	})
	]]

	--[[
	if giveItemData.StatLines ~= nil then
		local statLine = giveItemData.StatLines[1]
		ModifyTextBox({ Id = components.GiveInfoBoxStatLineLeft.Id, AppendToId = components.GiveInfoBoxBacking.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = giveItemData, FadeTarget = 1.0 })
		ModifyTextBox({ Id = components.GiveInfoBoxStatLineRight.Id, AppendToId = components.GiveInfoBoxBacking.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = giveItemData, FadeTarget = 1.0 })
	end
	]]

	-- Get Option
	--DebugPrint({ Text = "chosenGetOption.Name = "..tostring(chosenGetOption.Name) })

	local getItemData = ShallowCopyTable( TraitData[chosenGetOption.Name] or ConsumableData[chosenGetOption.Name] or LootData[chosenGetOption.Name] )
	if chosenGetOption.Overrides ~= nil then
		for key, value in pairs( chosenGetOption.Overrides ) do
			if getItemData[key] ~= nil then
				getItemData[key] = value
			end
		end
	end
	if getItemData.AddResources ~= nil then
		getItemData.DisplayName = "TradeScreen_ResourceCost"
		getItemData.ResourceName = chosenGetOption.DisplayName or getItemData.Name
		getItemData.Cost = GetFirstValue( getItemData.AddResources )
	end
	if getItemData.DropMoney ~= nil then
		local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
		if giveItemData.MoneyMultiplier then
			moneyMultiplier = moneyMultiplier - ( giveItemData.MoneyMultiplier - 1 )
		end
		getItemData.DropMoney = round(getItemData.DropMoney * moneyMultiplier)
	end

	local getItemIcon = getItemData.TradeIcon or getItemData.Icon or getItemData.SurfaceShopIcon
	if getItemIcon ~= nil then
		SetAnimation({ Name = getItemIcon, DestinationId = components.GetInfoBoxIcon.Id })
		SetAlpha({ Id = components.GetInfoBoxIcon.Id, Fraction = 1.0, Duration = 0.2 })
		--SetAlpha({ Id = components.GetInfoBoxFrame.Id, Fraction = 1.0, Duration = 0.2 })
	end

	ModifyTextBox({ Id = components.GetInfoBoxName.Id,
		Text = getItemData.DisplayName or chosenGetOption.DisplayName or getItemData.Name,
		LuaKey = "TooltipData",
		LuaValue = getItemData,
	})

	ModifyTextBox({ Id = components.GetInfoBoxBacking.Id,
		Text = chosenGetOption.DisplayName or getItemData.Name,
		UseDescription = true,
		LuaKey = "TooltipData",
		LuaValue = getItemData,
	})

	if getItemData.AddResources ~= nil then
		ModifyTextBox({ Id = components.GetInfoBoxSubText.Id,
			Text = "TradeScreen_CurrentMoney",
			LuaKey = "TempTextData",
			LuaValue = { Amount = GameState.Resources[getItemData.ResourceName] },
		})
	elseif getItemData.DropMoney ~= nil then
		ModifyTextBox({ Id = components.GetInfoBoxSubText.Id,
			Text = "TradeScreen_CurrentMoney",
			LuaKey = "TempTextData",
			LuaValue = { Amount = GameState.Resources.Money },
		})
	end

	--[[
	if getItemData.StatLines ~= nil then
		local statLine = getItemData.StatLines[1]
		ModifyTextBox({ Id = components.GetInfoBoxStatLineLeft.Id, AppendToId = components.GetInfoBoxBacking.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = getItemData, FadeTarget = 1.0 })
		ModifyTextBox({ Id = components.GetInfoBoxStatLineRight.Id, AppendToId = components.GetInfoBoxBacking.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = getItemData, FadeTarget = 1.0 })
	end
	]]

	if giveItemData.ResourceName ~= nil and not HasResource( giveItemData.ResourceName, giveItemData.Cost ) then
		SetAlpha({ Id = components.AcceptButton.Id, Fraction = 0.0, Duration = 0.0 })
		UseableOff({ Id = components.AcceptButton.Id })
	end
	
	-- Short delay to let animations finish and prevent accidental input
	wait(0.5)
	--TeleportCursor({ DestinationId = components.SpellDescription.Id, ForceUseCheck = true })
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function TradeScreenAccept( screen, button )
	AddInputBlock({ Name = "TradeScreenAccept" })
	CloseTradeScreen( screen, button )
	TradeScreenAcceptPresentation( screen, button )
	screen.Source.Accepted = true
	RemoveInputBlock({ Name = "TradeScreenAccept" })
end

function TradeDoExchange( screen, args )

	AddInputBlock({ Name = "TradeDoExchange" })

	if args.TradePreCostFunctionName ~= nil then
		CallFunctionName( args.TradePreCostFunctionName, screen, args )
	end

	local giveOption = args.ChosenGiveOption
	local getOption = args.ChosenGetOption

	if giveOption.SellTrait then
		for traitName, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
			RemoveWeaponTrait( sellData.Name )	
		end
		CurrentRun.CurrentRoom.SellOptions = {}
	end
	if giveOption.UseGetCost ~= nil then
		SpendResource( getOption.CostResourceName, giveOption.Cost )
	end
	if giveOption.DamageAmount ~= nil then
		Damage( CurrentRun.Hero, { triggeredById = CurrentRun.Hero.ObjectId, DamageAmount = giveOption.DamageAmount, PureDamage = true, } )
	end

	if args.TradePostCostFunctionName ~= nil then
		CallFunctionName( args.TradePostCostFunctionName, screen, args )
	end

	local item = nil
	if ConsumableData[getOption.Name] ~= nil or getOption.Name == "SpellDrop" then
		local consumableId = SpawnObstacle({ Name = getOption.Name, DestinationId = screen.Source.ObjectId, Group = "Standing" })
		item = CreateConsumableItem( consumableId, getOption.Name, 0, { RunProgressUpgradeEligible = true, DataOverrides = getOption.Overrides } )
		item.NPCDrop = true
		ApplyConsumableItemResourceMultiplier( CurrentRun.CurrentRoom, item )
	else
		getOption.SpawnPoint = screen.Source.ObjectId
		item = CreateLoot( getOption )
	end
	item.FromTrade = true
	screen.Source.ItemGiven = item
	MapState.RoomRequiredObjects[item.ObjectId] = item

	local forceAngle = GetAngleBetween({ Id = screen.Source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	ApplyForce({ Id = item.ObjectId, Speed = getOption.Force or args.GetItemForce, Angle = forceAngle, SelfApplied = true })
	ApplyUpwardForce({ Id = item.ObjectId, Speed = getOption.UpwardForce or args.GetItemUpwardForce })

	RemoveInputBlock({ Name = "TradeDoExchange" })

	if screen.Source.PostTradeEvents ~= nil then
		RunEventsGeneric( screen.Source.PostTradeEvents, screen.Source )
	end

end

function TradeScreenDecline( screen, button )
	CloseTradeScreen( screen, button )
	TradeScreenDeclinePresentation( screen, button )
	if screen.Source.PostTradeEvents ~= nil then
		RunEventsGeneric( screen.Source.PostTradeEvents, screen.Source )
	end
end

function CloseTradeScreen( screen, button )
	OnScreenCloseStarted( screen )
	--WeaponShopCloseCategory( screen )
	--WeaponShopScreenCloseStartPresentation( screen )
	CloseScreen( GetAllIds( screen.Components ) )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	--WeaponShopScreenCloseFinishedPresentation( screen, button )
end