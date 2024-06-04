function CreateDoorRewardPreview( exitDoor, chosenRewardType, chosenLootName, index, args )

	local room = exitDoor.Room

	args = args or {}

	if exitDoor.HideRewardPreview or room.HideRewardPreview then
		return
	end

	if not args.SkipCageRewards and room.CageRewards ~= nil and chosenRewardType == nil then
		for index, cageReward in ipairs( room.CageRewards ) do
			CreateDoorRewardPreview( exitDoor, cageReward.RewardType, cageReward.ForceLootName, index, { SkipCageRewards = true, } )
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
		backingId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Combat_UI_World" })
		SetThingProperty({ Property = "AllowDrawableCache", Value = false, DestinationId = backingId })
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
		doorIconId = SpawnObstacle({ Name = "RoomRewardPreview", Group = "Combat_UI", DestinationId = exitDoor.ObjectId,
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

		local doorAIconId = SpawnObstacle({ Name = "RoomRewardPreview", Group = "Combat_UI", DestinationId = exitDoor.ObjectId,
			OffsetX = doorIconOffsetX + doorIconIsometricShiftX + 18, OffsetY = doorIconOffsetY, OffsetZ = doorIconOffsetZ + doorIconIsometricShiftZ + 20 })
		local animName = LootData[room.Encounter.LootAName].DoorIcon
		SetAnimation({ DestinationId = doorAIconId, Name = animName })
		SetScale({ Id = doorAIconId, Fraction = 0.85 })
		exitDoor.AdditionalIcons[animName] = doorAIconId
		SetColor({ Id = doorAIconId, Color = {1.0, 1.0, 1.0, 0}, Duration = 0 })
		SetColor({ Id = doorAIconId, Color = {0, 0, 0, 1}, Duration = 0.2 })

		local doorBIconId = SpawnObstacle({ Name = "RoomRewardPreview", Group = "Combat_UI", DestinationId = exitDoor.ObjectId,
			OffsetX = doorIconOffsetX + doorIconIsometricShiftX - 18, OffsetY = doorIconOffsetY,  OffsetZ = doorIconOffsetZ + doorIconIsometricShiftZ - 20 })
		animName = LootData[room.Encounter.LootBName].DoorIcon
		SetAnimation({ DestinationId = doorBIconId, Name = animName })
		SetScale({ Id = doorBIconId, Fraction = 0.85 })
		exitDoor.AdditionalIcons[animName] = doorBIconId
		SetColor({ Id = doorBIconId, Color = {1.0, 1.0, 1.0, 0}, Duration = 0 })
		SetColor({ Id = doorBIconId, Color = {0, 0, 0, 1}, Duration = 0.2 })
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

	if exitDoor.RewardPreviewAnimName ~= nil then
		MapState.OfferedRewardPreviewTypes[exitDoor.RewardPreviewAnimName] = true
	end

	local subIcons = {}

	if not rewardHidden then
		local itemData = ConsumableData[chosenRewardType]
		if itemData ~= nil and itemData.AddResources ~= nil then
			for resourceName, amount in pairs( itemData.AddResources ) do
				if HasPinWithResource( resourceName ) then
					table.insert( subIcons, "RoomRewardSubIcon_ForgetMeNot" )
				end
			end
		end

		local existingIconId = exitDoor.AdditionalIcons.RoomRewardSubIcon_ForgetMeNot
		if existingIconId ~= nil then
			if Contains( subIcons, "RoomRewardSubIcon_ForgetMeNot" ) then
				SetAlpha({ Id = existingIconId, Fraction = 1.0, Duration = 0.2 })
			else
				SetAlpha({ Id = existingIconId, Fraction = 0.0, Duration = 0.2 })
			end
		end
	end

	local iconZ = 50
	local iconGroup = "Combat_UI_World"
	if HasHeroTraitValue( "AddDoorDetail" ) then
		if Contains( room.LegalEncounters, "HealthRestore" ) then
			table.insert( subIcons, "ExtraLifeHeart" )
		end
		if room.HarvestPointsAllowed > 0 then
			table.insert( subIcons, "GatherIcon" )
		end
		if room.ShovelPointSuccess and HasAccessToTool( "ToolShovel" ) then
			table.insert( subIcons, "ShovelIcon" )
		end
		if room.FishingPointSuccess and HasAccessToTool( "ToolFishingRod" ) then
			table.insert( subIcons, "FishingIcon" )
		end
		if room.PickaxePointSuccess and HasAccessToTool( "ToolPickaxe" ) then
			table.insert( subIcons, "PickaxeIcon" )
		end
		if room.ExorcismPointSuccess and HasAccessToTool( "ToolExorcismBook" ) then
			table.insert( subIcons, "ExorcismIcon" )
		end
	end
	if room.RewardPreviewIcon ~= nil and not HasHeroTraitValue( "HiddenRoomReward" ) then
		table.insert( subIcons, room.RewardPreviewIcon )
	end
	local hasQuestIcon = false
	local encountersChecked = {}
	if room.LegalEncounters ~= nil then
		for k, encounterName in pairs( room.LegalEncounters ) do
			if not encountersChecked[encounterName] and not GameState.EncountersCompletedCache[encounterName] and HasActiveQuestForName( encounterName ) then
				hasQuestIcon = true
				break
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
		table.insert( subIcons, "RoomRewardSubIcon_FatedList" )
	end

	local iconSpacing = 60
	local numSubIcons = #subIcons
	local isoOffset = 0
	if numSubIcons % 2 == 0 then
		isoOffset = isoOffset - (iconSpacing / 2)
	end
	for i, iconName in ipairs( subIcons ) do
		AddDoorInfoIcon({ Door = exitDoor, DoorIconId = doorIconId, Group = iconGroup, IsoOffset = isoOffset, Name = iconName, ReUseIds = args.ReUseIds })
		isoOffset = isoOffset + iconSpacing
	end

	if not args.ReUseIds and IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
		local ids = { doorIconId, backingId }
		FlipHorizontal({ Ids = ids })
	end

	PlaySound({ Id = exitDoor.ObjectId, Name = "/Leftovers/SFX/DoorStateChangeRewardAppearance" })

end

function AddDoorInfoIcon( args )
	args = args or {}
	local exitDoor = args.Door
	local iconId = nil
	if args.ReUseIds and exitDoor.AdditionalIcons[args.Name] ~= nil then
		iconId = exitDoor.AdditionalIcons[args.Name]
	else
		iconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = args.Group })
		SetThingProperty({ Property = "AllowDrawableCache", Value = false, DestinationId = iconId })
		local offsetAngle = 330
		if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
			offsetAngle = 30
			FlipHorizontal({ Id = iconId })
		end
		local offset = CalcOffset( math.rad( offsetAngle ), args.IsoOffset )
		Attach({ Id = iconId, DestinationId = args.DoorIconId, OffsetZ = -100, OffsetX = offset.X, OffsetY = offset.Y })
	end
	SetAnimation({ DestinationId = iconId, Name = args.Name })
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
end
