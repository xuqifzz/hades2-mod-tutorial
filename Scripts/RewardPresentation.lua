function CreateDoorRewardPreview( exitDoor, chosenRewardType, chosenLootName, index, args )

	local room = exitDoor.Room

	args = args or {}

	if exitDoor.HideRewardPreview or room.HideRewardPreview then
		return
	end

	if not args.SkipCageRewards and room.CageRewards ~= nil and chosenRewardType == nil then
		for index, cageReward in ipairs( room.CageRewards ) do
			CreateDoorRewardPreview( exitDoor, cageReward.RewardType, cageReward.ForceLootName, index, { SkipCageRewards = true, SkipRoomSubIcons = (index < #room.CageRewards) } )
		end
		return
	end

	chosenRewardType = chosenRewardType or room.ChosenRewardType
	chosenLootName = chosenLootName or room.ForceLootName

	local doorIconOffsetX = exitDoor.RewardPreviewOffsetX or 0
	local doorIconOffsetY = exitDoor.RewardPreviewOffsetY or 0
	local doorIconOffsetZ = exitDoor.RewardPreviewOffsetZ or 130

	local doorIconIsometricShiftX = -6
	local doorIconIsometricShiftZ = -3

	index = index or 1

	doorIconOffsetZ = doorIconOffsetZ + ((index - 1) * 180)
	
	if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
		doorIconOffsetX = doorIconOffsetX * -1
		doorIconIsometricShiftX = doorIconIsometricShiftX * -1
	end
	exitDoor.AdditionalIcons = exitDoor.AdditionalIcons or {}

	exitDoor.RewardPreviewBackingIds = exitDoor.RewardPreviewBackingIds or {}
	local backingId = nil
	if args.ReUseIds then
		backingId = exitDoor.RewardPreviewBackingIds[index]
	else
		backingId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Combat_UI_World", SortById = true, })
		table.insert( exitDoor.RewardPreviewBackingIds, backingId )
		SetAlpha({ Id = backingId, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = backingId, Fraction = 1.0, Duration = 0.1 })
		Attach({ Id = backingId, DestinationId = exitDoor.ObjectId, OffsetZ = doorIconOffsetZ, OffsetY = doorIconOffsetY, OffsetX = doorIconOffsetX })
	end
	if (exitDoor.RewardStoreName or exitDoor.Room.RewardStoreName) == "MetaProgress" then
		SetAnimation({ Name = "RoomRewardAvailable_Back_Meta", DestinationId = backingId })
	else
		SetAnimation({ Name = "RoomRewardAvailable_Back_Run", DestinationId = backingId })
	end

	exitDoor.RewardPreviewIconIds = exitDoor.RewardPreviewIconIds or {}
	local doorIconId = nil
	if args.ReUseIds then
		doorIconId = exitDoor.RewardPreviewIconIds[index]
	else
		doorIconId = SpawnObstacle({ Name = "RoomRewardPreview", Group = "Combat_UI", DestinationId = exitDoor.ObjectId, SortById = true,
			OffsetY = doorIconOffsetY, OffsetX = doorIconOffsetX + doorIconIsometricShiftX, OffsetZ = doorIconOffsetZ + doorIconIsometricShiftZ })
		SetAlpha({ Id = doorIconId, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = doorIconId, Fraction = 1.0, Duration = 0.1 })
		table.insert( exitDoor.RewardPreviewIconIds, doorIconId )
	end

	local rewardHidden = false
	if room.RewardPreviewOverride ~= nil then
		exitDoor.RewardPreviewAnimName = room.RewardPreviewOverride
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	elseif room.NextRoomSet then
		exitDoor.RewardPreviewAnimName = room.ExitPreviewAnim or "ExitPreview"
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	elseif HasHeroTraitValue( "HiddenRoomReward" ) then
		exitDoor.RewardPreviewAnimName = "ChaosPreview"
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
		rewardHidden = true
	elseif chosenRewardType == nil or chosenRewardType == "Story" then
		if chosenRewardType ~= "Story" and exitDoor.DefaultRewardPreviewOverride then
			exitDoor.RewardPreviewAnimName = exitDoor.DefaultRewardPreviewOverride
		else
			exitDoor.RewardPreviewAnimName = "StoryPreview"
		end
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	elseif chosenRewardType == "Shop" then
		exitDoor.RewardPreviewAnimName = "ShopPreview"
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	elseif chosenRewardType == "Boon" and chosenLootName ~= nil then
		local lootData = LootData[chosenLootName]
		DebugAssert({ Condition = lootData ~= nil, Text = "Unable to find LootData for "..chosenLootName })
		exitDoor.RewardPreviewAnimName = lootData.DoorIcon or lootData.Icon
		if exitDoor.Room.BoonRaritiesOverride ~= nil and lootData.DoorUpgradedIcon ~= nil then
			exitDoor.RewardPreviewAnimName = lootData.DoorUpgradedIcon
		end
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	elseif chosenRewardType == "Devotion" then

		--DebugPrint({ Text = "room.Encounter.LootAName = "..tostring(room.Encounter.LootAName) })
		--DebugPrint({ Text = "room.Encounter.LootBName = "..tostring(room.Encounter.LootBName) })
		exitDoor.RewardPreviewAnimName = "Devotion"

		local doorAIconId = SpawnObstacle({ Name = "RoomRewardPreview", Group = "Combat_UI", DestinationId = exitDoor.ObjectId, SortById = true,
			OffsetX = doorIconOffsetX + doorIconIsometricShiftX + 18, OffsetY = doorIconOffsetY, OffsetZ = doorIconOffsetZ + doorIconIsometricShiftZ + 20 })
		local animName = LootData[room.Encounter.LootAName].DoorIcon
		SetAnimation({ DestinationId = doorAIconId, Name = animName })
		SetScale({ Id = doorAIconId, Fraction = 0.85 })
		exitDoor.AdditionalIcons[animName] = doorAIconId
		SetColor({ Id = doorAIconId, Color = {1.0, 1.0, 1.0, 0}, Duration = 0 })
		SetColor({ Id = doorAIconId, Color = {0, 0, 0, 1}, Duration = 0.2 })

		local doorBIconId = SpawnObstacle({ Name = "RoomRewardPreview", Group = "Combat_UI", DestinationId = exitDoor.ObjectId, SortById = true,
			OffsetX = doorIconOffsetX + doorIconIsometricShiftX - 18, OffsetY = doorIconOffsetY,  OffsetZ = doorIconOffsetZ + doorIconIsometricShiftZ - 20 })
		if room.Encounter.LootBName ~= nil then
			animName = LootData[room.Encounter.LootBName].DoorIcon
		end
		SetAnimation({ DestinationId = doorBIconId, Name = animName })
		SetScale({ Id = doorBIconId, Fraction = 0.85 })
		exitDoor.AdditionalIcons[animName] = doorBIconId
		SetColor({ Id = doorBIconId, Color = {1.0, 1.0, 1.0, 0}, Duration = 0 })
		SetColor({ Id = doorBIconId, Color = {0, 0, 0, 1}, Duration = 0.2 })

		if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
			FlipHorizontal({ Ids = { doorAIconId, doorBIconId } })
		end
	else
		local animName = chosenRewardType
		local lootData = LootData[chosenRewardType]
		if lootData ~= nil then
			animName = lootData.DoorIcon or lootData.Icon or animName
		end
		local consumableData = ConsumableData[chosenRewardType]
		if consumableData ~= nil then
			animName = consumableData.DoorIcon or consumableData.Icon or animName
		end
		exitDoor.RewardPreviewAnimName = animName
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	end

	if RoomData[CurrentRun.CurrentRoom.Name].UseDefaultRewardPreview and exitDoor.DefaultRewardPreviewOverride ~= nil then
		exitDoor.RewardPreviewAnimName = exitDoor.DefaultRewardPreviewOverride
		exitDoor.Room.RewardPreviewIcon = nil
		SetAnimation({ DestinationId = doorIconId, Name = exitDoor.RewardPreviewAnimName })
	end

	if exitDoor.RewardPreviewAnimName ~= nil then
		MapState.OfferedRewardPreviewTypes[exitDoor.RewardPreviewAnimName] = true
	end

	local subIcons = PopulateDoorRewardPreviewSubIcons( exitDoor, { ChosenRewardType = chosenRewardType, RewardHidden = rewardHidden, SkipRoomSubIcons = args.SkipRoomSubIcons, CageRewards = room.CageRewards } )
	local doorIconIndexForSubIcons = 1
	if room.CageRewards ~= nil then
		doorIconIndexForSubIcons = #room.CageRewards
	end
	local iconSpacing = 60
	local numSubIcons = #subIcons
	local isoOffset = iconSpacing * -0.5 * (numSubIcons - 1)
	for i, iconData in ipairs( subIcons ) do
		AddDoorInfoIcon({ Door = exitDoor, DoorIconId = exitDoor.RewardPreviewIconIds[doorIconIndexForSubIcons], Group = "Combat_UI_World", IsoOffset = isoOffset, Name = iconData.Name, Animation = iconData.Animation or iconData.Name, ReUseIds = args.ReUseIds })
		isoOffset = isoOffset + iconSpacing
	end

	if not args.ReUseIds and IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
		local ids = { doorIconId, backingId }
		FlipHorizontal({ Ids = ids })
	end

	PlaySound({ Id = exitDoor.ObjectId, Name = "/Leftovers/SFX/DoorStateChangeRewardAppearance" })

end

function PopulateDoorRewardPreviewSubIcons( exitDoor, args )
	local subIcons = {}
	local room = exitDoor.Room

	if not args.RewardHidden and not args.SkipRoomSubIcons then

		if room.RewardPreviewIcon ~= nil then
			table.insert( subIcons, { Name = room.RewardPreviewIcon } )
		end

		local chosenRewardTypes = {}
		if args.CageRewards ~= nil then
			for i, cageReward in ipairs( args.CageRewards ) do
				table.insert( chosenRewardTypes, cageReward.RewardType )
			end
		else
			table.insert( chosenRewardTypes, args.ChosenRewardType )
		end

		local resourcesInRoom = {}

		for i, rewardType in ipairs( chosenRewardTypes ) do
			local consumableData = ConsumableData[rewardType]
			if consumableData ~= nil and consumableData.AddResources ~= nil then
				for resourceName in pairs( consumableData.AddResources ) do
					resourcesInRoom[resourceName] = true
				end
			end
		end

		if not exitDoor.SkipResourcePinIcons then
			local requirementArgs = { RoomSetName = room.RoomSetName }
			if room.HarvestPointsAllowed > 0 then
				for i, option in ipairs( HarvestData.WeightedOptions ) do
					if option.AddResources ~= nil and IsGameStateEligible( option, option.GameStateRequirements, requirementArgs ) then
						for resourceName in pairs( option.AddResources ) do
							resourcesInRoom[resourceName] = true
						end
						break
					end
				end
			end
			if room.ShovelPointSuccess and HasAccessToTool( "ToolShovel" ) then
				for i, option in ipairs( ShovelPointData.WeightedOptions ) do
					if IsGameStateEligible( option, option.GameStateRequirements, requirementArgs ) then
						for resourceName in pairs( option.AddResources ) do
							-- Determine what plant this seed grows into
							local seedData = GardenData.Seeds[resourceName]
							if seedData ~= nil and #seedData.RandomOutcomes == 1 then
								for plantName in pairs( seedData.RandomOutcomes[1].AddResources ) do
									resourcesInRoom[plantName] = true
								end
							end
						end
						break
					end
				end
			end
			if room.PickaxePointSuccess and HasAccessToTool( "ToolPickaxe" ) then
				for i, option in ipairs( PickaxePointData.WeightedOptions ) do
					if IsGameStateEligible( option, option.GameStateRequirements, requirementArgs ) then
						resourcesInRoom[option.ResourceName] = true
						break
					end
				end
			end
			if room.ExorcismPointSuccess and HasAccessToTool( "ToolExorcismBook", requirementArgs ) then
				resourcesInRoom.MemPointsCommon = true
			end
			-- no need to check for fish; their appearance is random and they aren't used in recipes
		end

		local hasPin = false
		local hasEnoughForPins = true
		for resourceName in pairs( resourcesInRoom ) do
			local amountNeededByPins = GetResourceAmountNeededByPins( resourceName )
			if amountNeededByPins > 0 then
				hasPin = true
				if not HasResource( resourceName, amountNeededByPins ) then
					hasEnoughForPins = false
					break
				end
			end
		end

		if hasPin then
			local forgetMeNotIconData = { Name = "RoomRewardSubIcon_ForgetMeNot" }
			if hasEnoughForPins then
				forgetMeNotIconData.Animation = "RoomRewardSubIcon_ForgetMeNot_Complete"
			end
			table.insert( subIcons, forgetMeNotIconData )
		end

		local existingPinIconId = exitDoor.AdditionalIcons.RoomRewardSubIcon_ForgetMeNot
		if existingPinIconId ~= nil then
			if hasPin then
				SetAlpha({ Id = existingPinIconId, Fraction = 1.0, Duration = 0.2 })
			else
				SetAlpha({ Id = existingPinIconId, Fraction = 0.0, Duration = 0.2 })
			end
		end

		local hasOnion = false
		for i, rewardType in ipairs( chosenRewardTypes ) do
			if rewardType == "Boon" or rewardType == "HermesUpgrade" then
				if GetNumShrineUpgrades( "BoonSkipShrineUpgrade" ) > CurrentRun.BiomeBoonSkipCount then
					hasOnion = true
					table.insert( subIcons, { Name = "RoomRewardSubIcon_Onion" } )
					break
				end
			end
		end

		local existingOnionIconId = exitDoor.AdditionalIcons.RoomRewardSubIcon_Onion
		if existingOnionIconId ~= nil then
			if hasOnion then
				SetAlpha({ Id = existingOnionIconId, Fraction = 1.0, Duration = 0.2 })
			else
				SetAlpha({ Id = existingOnionIconId, Fraction = 0.0, Duration = 0.2 })
			end
		end

		
		if room.ZagreusContractSuccess then
			table.insert( subIcons, { Name = "RoomRewardSubIcon_Contract"})
		end

		local existingContractIconId = exitDoor.AdditionalIcons.RoomRewardSubIcon_Contract
		if existingContractIconId ~= nil then
			if room.ZagreusContractSuccess then
				SetAlpha({ Id = existingContractIconId, Fraction = 1.0, Duration = 0.2 })
			else
				SetAlpha({ Id = existingContractIconId, Fraction = 0.0, Duration = 0.2 })
			end
		end

		if room.ConditionalSubIcon ~= nil and room.ConditionalSubIconRequirements ~= nil and IsGameStateEligible( room, room.ConditionalSubIconRequirements ) then
			table.insert( subIcons, { Name = room.ConditionalSubIcon } )
		end

		local hasQuestIcon = false
		local encountersChecked = {}
		if room.LegalEncounters ~= nil then
			for k, encounterName in pairs( room.LegalEncounters ) do
				if not encountersChecked[encounterName] and not GameState.EncountersCompletedCache[encounterName] and HasActiveQuestForName( encounterName ) then
					local encounterData = EncounterData[encounterName]
					if encounterData.GameStateRequirements == nil or IsGameStateEligible( encounterData, encounterData.GameStateRequirements ) then
						hasQuestIcon = true
						break
					end
				end
				encountersChecked[encounterName] = true
			end
		end
		if not hasQuestIcon and room.ForceLootName ~= nil then
			local questTraitName = room.ForceLootName
			if SpellData[questTraitName] ~= nil then
				questTraitName = SpellData[questTraitName].TraitName or questTraitName
			end
			if not GameState.TraitsTaken[questTraitName] and HasActiveQuestForName( questTraitName ) then
				hasQuestIcon = true
			end
		end
		if hasQuestIcon then
			table.insert( subIcons, { Name = "RoomRewardSubIcon_FatedList" } )
		end
	end

	return subIcons
end

function AddDoorInfoIcon( args )
	args = args or {}
	local exitDoor = args.Door
	local iconId = nil
	if args.ReUseIds and exitDoor.AdditionalIcons[args.Name] ~= nil then
		iconId = exitDoor.AdditionalIcons[args.Name]
	else
		iconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = args.Group, SortById = true })
		local offsetAngle = 330
		if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
			offsetAngle = 30
			FlipHorizontal({ Id = iconId })
		end
		local offset = CalcOffset( math.rad( offsetAngle ), args.IsoOffset )
		Attach({ Id = iconId, DestinationId = args.DoorIconId, OffsetZ = 100, OffsetX = offset.X, OffsetY = offset.Y })
	end
	SetAnimation({ DestinationId = iconId, Name = args.Animation })
	exitDoor.AdditionalIcons[args.Name] = iconId
end

function RemoveRoomRewardPreviews()
	if MapState.OfferedExitDoors ~= nil then
		for doorId, door in pairs( MapState.OfferedExitDoors ) do
			Destroy({ Ids = door.RewardPreviewBackingIds })
			Destroy({ Ids = door.RewardPreviewIconIds })
			Destroy({ Ids = GetAllValues( door.AdditionalIcons ) })
		end
	end
	if MapState.ShipWheels ~= nil then
		for id, wheel in pairs( MapState.ShipWheels ) do
			Destroy({ Ids = wheel.RewardPreviewBackingIds })
			Destroy({ Ids = wheel.RewardPreviewIconIds })
			Destroy({ Ids = GetAllValues( wheel.AdditionalIcons ) })
		end
	end
end

function ForceBoonChosenPresentation( trait, lootData )
	thread( InCombatText, CurrentRun.Hero.ObjectId, "ForceBoonKeepsakeActivated", 2.0, { PreDelay = 1.0, LuaKey = "TempTextData", LuaValue = trait } )
	wait( 1.0 )
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData ~= nil then
		CreateAnimation({ Name = "ActiveTraitFlash", DestinationId = existingTraitData.TraitActiveOverlay })
	end
end