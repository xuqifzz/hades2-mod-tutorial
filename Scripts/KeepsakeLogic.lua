function GetKeepsakeLevel( traitName, unmodified )
	local level = 1
	if not unmodified and HeroHasTrait( traitName ) then
		local traitData = GetHeroTrait( traitName )
		if traitData.Rarity then
			return GetRarityValue( traitData.Rarity)
		end
	end

	if HasHeroTraitValue("KeepsakeLevelBonus") and not unmodified and (not IsKeepsakeMaxed(traitName) or KeepsakeHasHeroicRarity(traitName)) then
		level = level + GetTotalHeroTraitValue("KeepsakeLevelBonus")
	end
	if TraitData[traitName].KeepsakeRarityGameStateRequirements then
		for i, requirements in ipairs( TraitData[traitName].KeepsakeRarityGameStateRequirements ) do
			if IsGameStateEligible( CurrentRun, requirements ) then
				level = i
			end
		end
		return level
	end

	if not GameState.KeepsakeChambers[traitName] or TraitData[traitName].ChamberThresholds == nil then
		return level
	end

	local threshold = 0
	for i, value in pairs(TraitData[traitName].ChamberThresholds) do
		threshold = threshold + value
		if threshold > GameState.KeepsakeChambers[traitName] then
			break;
		end
		level = level + 1
	end
	return level
end

function GetKeepsakeProgress( traitName )
	local currentLevel = GetKeepsakeLevel( traitName, true )
	if not GameState.KeepsakeChambers[traitName] or not TraitData[traitName].ChamberThresholds then
		return 0
	end

	if IsKeepsakeMaxed( traitName ) then
		return 1
	end
	local lastThreshold = 0
	if currentLevel > 1 then
		lastThreshold = TraitData[traitName].ChamberThresholds[currentLevel - 1]
	end
	return (GameState.KeepsakeChambers[traitName] - lastThreshold) / TraitData[traitName].ChamberThresholds[currentLevel]
end

function GetKeepsakeChambersToNextLevel( traitName )
	if IsKeepsakeMaxed( traitName ) then
		return 0
	end

	local currentLevel = GetKeepsakeLevel( traitName, true )
	local currentChambers = GameState.KeepsakeChambers[traitName] or 0
	local lastThreshold = 0
	if currentLevel > 1 then
		lastThreshold = TraitData[traitName].ChamberThresholds[currentLevel - 1]
	end
	return TraitData[traitName].ChamberThresholds[currentLevel] - ( currentChambers - lastThreshold )
end

function KeepsakeHasHeroicRarity( traitName )
	return TraitData[traitName] and TraitData[traitName].RarityLevels and TraitData[traitName].RarityLevels.Heroic
end

function IsKeepsakeMaxed( traitName )
	if TraitData[traitName] and TraitData[ traitName ].KeepsakeRarityGameStateRequirements then
		for i, requirements in ipairs( TraitData[traitName].KeepsakeRarityGameStateRequirements ) do
			if not IsGameStateEligible( CurrentRun, requirements ) then
				return false
			end
		end
		return true
	end

	if not GameState.KeepsakeChambers[traitName] then
		return false
	end

	if TraitData[traitName].ChamberThresholds == nil or TraitData[traitName].ChamberThresholds[GetKeepsakeLevel( traitName, true )] == nil then
		return true
	end
	return false
end

function EquipKeepsake( heroUnit, traitName, args )
	local unit = heroUnit or CurrentRun.Hero
	traitName = traitName or GameState.LastAwardTrait
	if traitName == nil or HeroHasTrait( traitName ) then
		return
	end

	local traitData = AddTrait( unit, traitName, GetRarityKey(GetKeepsakeLevel( traitName )), args)
	if not CurrentRun.Hero.IsDead then
		CurrentRun.TraitCache[traitName] = CurrentRun.TraitCache[traitName] or 1
	end

	if traitName == "DecayingBoostKeepsake" then
		traitData.CurrentKeepsakeDamageBonus = traitData.InitialKeepsakeDamageBonus
	end
	if traitName == "ReincarnationKeepsake" then
		AddLastStand({
			Name = "ReincarnationKeepsake",
			ExpiresKeepsake = "ReincarnationKeepsake",
			InsertAtEnd = true,
			IncreaseMax = true,
			Icon = "ExtraLifeSkelly",
			HealAmount = GetTotalHeroTraitValue( "KeepsakeLastStandHealAmount" ),
		})
		RecreateLifePips()
	end
end

function UnequipKeepsake( heroUnit, traitName )
	local unit = heroUnit or CurrentRun.Hero
	RemoveTrait( unit, traitName )
	if traitName == "ReincarnationKeepsake" then
		RemoveLastStand( unit, "ReincarnationKeepsake" )
		unit.MaxLastStands = unit.MaxLastStands - 1
		RecreateLifePips()
	end
	if traitName == "ArmorGainKeepsake" and MapState.HealthBufferSources and MapState.HealthBufferSources.ArmorGainKeepsake then
		CurrentRun.Hero.HealthBuffer = CurrentRun.Hero.HealthBuffer - MapState.HealthBufferSources.ArmorGainKeepsake
		MapState.HealthBufferSources.ArmorGainKeepsake = nil
		thread( UpdateHealthUI )
	end
end

function EquipAssist( heroUnit, traitName, args )
	local unit = heroUnit or CurrentRun.Hero
	traitName = traitName or GameState.LastAssistTrait
	if traitName == nil then
		return
	end

	AddTrait( unit, traitName, GetRarityKey(GetKeepsakeLevel( traitName )), args )
end

function UnequipAssist( heroUnit, traitName )
	local unit = heroUnit or CurrentRun.Hero
	RemoveTrait( unit, traitName )
end

function AdvanceKeepsake()
	local traitName = GameState.LastAwardTrait
	if GameState.LastAwardTrait ~= nil and HeroHasTrait(traitName) then
		local startingKeepsakeLevel = GetKeepsakeLevel( traitName, true )
		IncrementTableValue( GameState.KeepsakeChambers, traitName )
		if CurrentRun and CurrentRun.Hero and startingKeepsakeLevel ~= GetKeepsakeLevel( traitName, true ) then
			local accumulatedDamageBonus = 1
			local accumulatedDodgeBonus = 0
			local lastDamageBonus = 0
			local lastUses = 0
			local lastRoomNumber = 0
			local currentArmor = 0
			local currentTime = nil
			local customText = nil
			local escalatingBonus = 1
			for i, traitData in pairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == traitName then
					accumulatedDamageBonus = traitData.AccumulatedDamageBonus
					accumulatedDodgeBonus = traitData.AccumulatedDodgeBonus
					lastUses = traitData.Uses
					lastRoomNumber = traitData.CurrentRoom
					lastDamageBonus = traitData.CurrentKeepsakeDamageBonus
					currentArmor = traitData.CurrentArmor
					currentTime = traitData.CurrentTime
					escalatingBonus = traitData.EscalatingKeepsakeValue
					customText = traitData.CustomTrayText
					break
				end
			end
			
			UnequipKeepsake( CurrentRun.Hero, traitName )			
			EquipKeepsake( CurrentRun.Hero, traitName, { SkipSetup = true } )
			if traitName == "ReincarnationTrait" then
				RecreateLifePips()
			end
			for i, traitData in pairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == traitName then
					if accumulatedDodgeBonus then
						traitData.AccumulatedDodgeBonus = accumulatedDodgeBonus
						SetLifeProperty({ Property = "DodgeChance", Value = traitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
						SetUnitProperty({ Property = "Speed", Value = 1 + traitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
					end
					traitData.AccumulatedDamageBonus = accumulatedDamageBonus
					traitData.CurrentKeepsakeDamageBonus = lastDamageBonus
					traitData.EscalatingKeepsakeValue = escalatingBonus
					traitData.CurrentTime = currentTime
					traitData.Uses = lastUses
					traitData.CurrentRoom = lastRoomNumber
					traitData.CustomTrayText = customText
					
					if traitData.CostumeTrait and traitData.SetupFunction and traitData.SetupFunction.Name == "CostumeArmor" then
						traitData.CurrentArmor = currentArmor
						if currentArmor ~= 0 then
							AddHealthBuffer( currentArmor, traitData.Name )
							thread( UpdateHealthUI )
						end
					end
					UpdateTraitNumber(traitData)
					break
				end
			end
			thread( KeepsakeLevelUpPresentation, traitName )
			TraitUIActivateTraits()
			CheckAchievement({ Name = "AchLeveledKeepsakes" })
		end
	end
end

function SetupDodgeBonus( encounter, dodgeTraitData )
	if CurrentRun == nil or CurrentRun.Hero == nil or CurrentRun.Hero.IsDead then
		return
	end
	SetLifeProperty({ Property = "DodgeChance", Value = dodgeTraitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	SetUnitProperty({ Property = "Speed", Value = 1 + dodgeTraitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
	local clearTimeThreshold = encounter.FastClearThreshold or dodgeTraitData.FastClearThreshold
	FastClearTraitStartPresentation( clearTimeThreshold, dodgeTraitData )

	thread( FastClearThread, clearTimeThreshold, dodgeTraitData )
end

function FastClearThread( clearTimeThreshold, dodgeTraitData )
	wait( clearTimeThreshold, RoomThreadName )
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and not CurrentRun.CurrentRoom.Encounter.Completed and not CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		FastClearTraitFailedPresentation(dodgeTraitData)
	end
end

function SetupBlockDeathThread()
	local blockDeathTimer = GetTotalHeroTraitValue( "BlockDeathTimer" ) 
	thread( DamageAfterInterval, blockDeathTimer, 1000 )
end

function DamageAfterInterval( timer, damage )
	local encounter = nil
	if MapState.EncounterOverride then
		encounter = MapState.EncounterOverride
	elseif CurrentRun and CurrentRun.CurrentRoom then
		if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.InProgress then
			encounter = CurrentRun.CurrentRoom.Encounter
		elseif CurrentRun.CurrentRoom.ChallengeEncounter and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
			encounter = CurrentRun.CurrentRoom.ChallengeEncounter
		end
	end

	if encounter == nil then
		return
	end
	local encounterAlreadyCompleted = encounter.Completed

	SetPlayerInvulnerable( "BlockDeath" )
	local tollTimes = math.floor(timer)
	StartBlockDeathPresentation( tollTimes )
	while tollTimes > 0 do
		if encounter.BossKillPresentation or (encounter.Completed and not encounterAlreadyCompleted) then
			SetPlayerVulnerable( "BlockDeath" )
			return
		end
		if encounter.RecordActiveEnemies then
			local hasAliveEnemies = false
			for id in pairs( encounter.ActiveSpawns ) do
				if ActiveEnemies[id] and not ActiveEnemies[id].IsDead then
					hasAliveEnemies = true
				end
			end
			if not hasAliveEnemies then
				SetPlayerVulnerable( "BlockDeath" )
				return
			end
		end
		if PlayingTextLines then
			wait(0.3)
		else
			TickBlockDeathPresentation( tollTimes )
			wait (1, RoomThreadName )
			tollTimes = tollTimes - 1
		end
	end
	SetPlayerVulnerable( "BlockDeath" )
	if ( encounterAlreadyCompleted and ( not CurrentRun.Hero.InvulnerableFlags or not CurrentRun.Hero.InvulnerableFlags.LeaveRoom)) or ( not encounter.Completed and not encounter.BossKillPresentation and encounter.InProgress ) then
		CurrentRun.Hero.HealthBuffer = 0
		SacrificeHealth({SacrificeHealthMin = damage, SacrificeHealthMax = damage, MinHealth = 0, Silent = true })
	end
end

function CheckOverTimeManaRefund( functionArgs, manaDelta )
	if not IsEmpty(MapState.ClearCastWeapons) then
		return
	end
	local manaRestored = math.abs(manaDelta)
	local sourceTrait = GetHeroTrait( "ManaOverTimeRefundKeepsake" )
	if sourceTrait.TotalManaRecovered <= 0 then
		return
	end
	
	if manaRestored > sourceTrait.TotalManaRecovered then
		manaRestored = sourceTrait.TotalManaRecovered 
	end
	thread( ManaOverTimeRefund, functionArgs.Duration, functionArgs.Interval, manaRestored )
	sourceTrait.TotalManaRecovered = sourceTrait.TotalManaRecovered - manaRestored
	if sourceTrait.TotalManaRecovered <= 0 then
		sourceTrait.CustomTrayText = sourceTrait.ZeroBonusTrayText
		ReduceTraitUses( sourceTrait, { Force = true })
		thread( RefundKeepsakeExpiredPresentation, sourceTrait )
	else
		UpdateTraitNumber( sourceTrait )
	end
end

function ManaOverTimeRefund( duration, interval, value, force )
	local manaRegenPerSecond =  value / duration
	wait( HeroData.ManaData.MinManaTickRate, RoomThreadName)
	while value > 0 do
		local manaOverflow = 0
		if force or IsEmpty( MapState.ChargedManaWeapons ) and IsEmpty(CurrentRun.Hero.ManaDrain) and not HasThread("ManaRegenStartup") then
			if (1/manaRegenPerSecond) < HeroData.ManaData.MinManaTickRate then
				local manaRegen, fraction = math.modf( manaRegenPerSecond * HeroData.ManaData.MinManaTickRate )
				manaOverflow = manaOverflow + fraction
				if manaOverflow >= 1 then
					manaOverflow = manaOverflow - 1
					manaRegen = manaRegen + 1
				end
				ManaRegenPresentation(manaRegen)
				ManaDelta(manaRegen, { Silent = true })
				value = value - manaRegen
				wait( HeroData.ManaData.MinManaTickRate, RoomThreadName)
			else
				ManaDelta(1, { Silent = true })
				ManaRegenPresentation(1)
				value = value - 1
				wait( 1 / manaRegenPerSecond, RoomThreadName )
			end
		else
			wait( HeroData.ManaData.MinManaTickRate, RoomThreadName)
		end
	end
end

function CheckSpeedKeepsakeTrigger( unit, functionArgs )
	if not CurrentRun then
		return
	end
		
	if CurrentRun.Hero.IsDead then
		return
	end
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.EncounterType == "Boss" then
		if CurrentRun.BiomeTimeKeepsake > 0 then
			local trait = GetHeroTrait("SpeedRunBossKeepsake")
			thread( SpeedKeepsakeActivatedPresentation, trait)
			local effectName = trait.BossSpeedTriggerEffect.EffectName
			local dataProperties = MergeTables( EffectData[effectName].DataProperties, trait.BossSpeedTriggerEffect.DataProperties)
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties})
			
			CurrentRun.SpeedRunBossKeepsakeTriggered = true
			MapState.MapSpeedMultiplier = trait.BossSpeedTriggerEffect.AttackSpeedMultiplier

			local speedPropertyChange = 		
			{
				WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
				ChangeValue = MapState.MapSpeedMultiplier,
				SpeedPropertyChanges = true,
			}
			local allPropertyChanges= {}
			for q, weaponName in pairs(speedPropertyChange.WeaponNames) do
					
				local newPropertyChanges = DeepCopyTable(WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
				if WeaponData[weaponName] and WeaponData[weaponName].SpeedPropertyChanges then
					newPropertyChanges = DeepCopyTable( WeaponData[weaponName].SpeedPropertyChanges)
				end
				for s, newPropertyChange in pairs(newPropertyChanges) do
					newPropertyChange = MergeTables( newPropertyChange, speedPropertyChange )
					newPropertyChange.WeaponNames = nil
					newPropertyChange.WeaponName = weaponName
					newPropertyChange.ChangeType = "Multiply"
					if newPropertyChange.InvertSource then
						if newPropertyChange.ChangeValue then
							newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
						end
					end
					newPropertyChange.SpeedPropertyChanges = nil
					table.insert(allPropertyChanges, newPropertyChange )
				end
			end

			ApplyUnitPropertyChanges( CurrentRun.Hero, allPropertyChanges )
		end
	end
end

function UseKeepsakeRack( giftRack, user )
	if CurrentRun.CurrentRoom.BlockKeepsakeMenu and not CanFreeSwapKeepsakes() then
		CannotUseKeepsakeRackPresentation( giftRack.ObjectId )
		return
	end

	PlayInteractAnimation( giftRack.ObjectId )
	StopStatusAnimation( giftRack )
	OpenKeepsakeRackScreen( giftRack )
end

function HasNewTraits()
	return not IsEmpty( GameState.NewKeepsakeItem )
end

function UpdateGiftRackShineStatus( obstacle )
	if ScreenAnchors.AwardMenuSparkleId ~= nil then
		Destroy({ Id = ScreenAnchors.AwardMenuSparkleId })
	end
	local id = nil
	if not obstacle then
		obstacle = GetIdsByType({ Name = "GiftRack" })[1]
	else
		id = obstacle.ObjectId
	end
	if id ~= nil and HasNewTraits() and not CurrentRun.CurrentRoom.BlockKeepsakeMenu then
		ScreenAnchors.AwardMenuSparkleId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing_Top"})
		SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = ScreenAnchors.AwardMenuSparkleId })
		Attach({ Id = ScreenAnchors.AwardMenuSparkleId, DestinationId = id })
		SetAnimation({ Name = "GiftRackGlean", DestinationId = ScreenAnchors.AwardMenuSparkleId })
	end
end

function EquipLastAssistTrait( eventSource, hero )
	local existingHero = CurrentRun.Hero or hero
	if GameState.LastAssistTrait ~= nil then
		EquipAssist( existingHero, GameState.LastAssistTrait )
	end
end

function EquipLastAwardTrait( eventSource, hero )
	local existingHero = CurrentRun.Hero or hero
	if GameState.LastAwardTrait ~= nil then
		EquipKeepsake( existingHero, GameState.LastAwardTrait )
	end
end

function GetKeepsakeData( keepsakeName )
	-- For data backwards compat
	for npcName, giftData in pairs( GiftData ) do
		for i, giftLevelData in ipairs( giftData ) do
			if giftLevelData.Gift == keepsakeName then
				return { NPCName = npcName, GiftLevelData = giftLevelData }
			end
		end
	end
	return nil
end

function OpenKeepsakeRackScreen( source )
	local screen = DeepCopyTable( ScreenData.KeepsakeRack )
	screen.Source = source
	if IsScreenOpen( screen.Name ) then
		return
	end
	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.LastTrait = GameState.LastAwardTrait

	local components = screen.Components

	if GameState.LastAwardTrait ~= nil then
		thread( MarkObjectiveComplete, "GiftRackPrompt" )
	end

	LoadVoiceBanks({ Name = "*Keepsake" })

	screen.StartX = screen.StartX + ScreenCenterNativeOffsetX
	screen.StartY = screen.StartY + ScreenCenterNativeOffsetY
	
	local rowMin = math.ceil( screen.RowMax / 2 )
	screen.HasUnlocked = false
	screen.HasNew = false
	screen.FirstUsable = false
	for itemIndex, itemName in ipairs( screen.ItemOrder ) do

		local keepsakeData = GetKeepsakeData( itemName )
		if keepsakeData ~= nil then
			local itemData =
			{
				New = GameState.NewKeepsakeItem[keepsakeData.GiftLevelData.Gift],
				Gift = itemName,
				Level = 1,
				NPC = keepsakeData.NPCName,
				Unlocked = SessionState.AllKeepsakeUnlocked or IsGameStateEligible( CurrentRun, keepsakeData.GiftLevelData, keepsakeData.GiftLevelData.GameStateRequirements )
			}

			local localx = 0
			local localy = 0
			localx = screen.StartX - screen.SpacerX * rowMin/2 + ((itemIndex - 1) % screen.RowMax + 0.5) * screen.SpacerX
			localy = screen.StartY + math.floor( (itemIndex - 1) / screen.RowMax)* 2 * (screen.SpacerY / 2)
			CreateKeepsakeIcon( screen, components, { Index = itemIndex, UpgradeData = itemData, X = localx, Y = localy } )
		end
	end

	if not screen.HasUnlocked then
		TeleportCursor({ OffsetX = screen.StartX, OffsetY = screen.StartY, ForceUseCheck = true })
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuEmptyVoiceLines, false )
	elseif screen.HasNew then
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuNewAvailableVoiceLines, false )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedAwardMenuVoiceLines, false )
	end
	screen.KeepOpen = true
	HandleScreenInput( screen )

end

function CreateKeepsakeIcon( screen, components, args )
	args = args or {}
	local localx = args.X
	local localy = args.Y
	local rankOffsetY = args.RankOffsetY or 70
	local itemIndex = args.Index
	local upgradeData = args.UpgradeData
	local keyAppend = args.KeyAppend or ""
	local scale = args.Scale or 0.75

	local buttonKey = "UpgradeToggle"..itemIndex..keyAppend
	components[buttonKey.."Frame"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx, Y = localy + 10, Group = "Combat_Menu_Overlay_Backing" })
	SetAnimation({ DestinationId = components[buttonKey.."Frame"].Id , Name = "Keepsake_BackingMenu" })
	SetScale({ Id = components[buttonKey.."Frame"].Id, Fraction = scale })

	components[buttonKey] = CreateScreenComponent({ Name = "RadioButton", Scale = screen.BaseIconScale, X = localx, Y = localy, Group = "Combat_Menu_Overlay" })
	--components[buttonKey].TitleTextBoxId = components.InfoBackground.Id
	--components[buttonKey].DescriptionTextBoxId = components.InfoBackgroundDescription.Id
	--components[buttonKey].CurrentLevelId = components.CurrentLevel.Id
	components[buttonKey].LevelProgressId = components.LevelProgress.Id
	components[buttonKey].Data = upgradeData
	components[buttonKey].ButtonKey = buttonKey
	components[buttonKey].FrameId = components[buttonKey.."Frame"].Id
	
	components[buttonKey].OnMouseOverFunctionName = "MouseOverKeepsake"
	components[buttonKey].OnMouseOffFunctionName = "MouseOffKeepsake"
	components[buttonKey].Screen = screen
	AttachLua({ Id = components[buttonKey].Id, Table = components[buttonKey] })

	local traitName = upgradeData.Gift
	local traitData = nil
	if HeroHasTrait(traitName) then
		traitData = GetHeroTrait( traitName )
	else
		traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey(GetKeepsakeLevel( traitName )) })
	end
	ExtractValues( CurrentRun.Hero, traitData, traitData )
	components[buttonKey].TraitData = traitData

	if not upgradeData.Unlocked then
		SetColor({ Id = components[buttonKey].Id, Color = Color.DarkSlateGray })
	else
		-- Hidden description for tooltips
		SetInteractProperty({ DestinationId = components[buttonKey].Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = components[buttonKey].Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })
		CreateTextBox({ Id = components[buttonKey].Id,
			Text = traitName,
			UseDescription = true,
			OffsetX = 0, OffsetY = 0,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = traitData,
		})

		screen.HasUnlocked = true
		components[buttonKey.."Bar"] = CreateScreenComponent({ Name = "KeepsakeBar", X = localx, Y = localy + 80, Group = "Combat_Menu_Overlay" })
		components[buttonKey.."Rank"] = CreateScreenComponent({ Name = "KeepsakeRank" .. GetKeepsakeLevel( traitData.Name ), X = localx, Y = localy + rankOffsetY, Group = "Combat_Menu_Overlay" })
		components[buttonKey.."BarFill"] = CreateScreenComponent({ Name = "KeepsakeBarFill", X = localx, Y = localy + 80, Group = "Combat_Menu_Overlay" })
		SetAnimationFrameTarget({ Name = "KeepsakeBarFill", Fraction = GetKeepsakeProgress( traitData.Name ), DestinationId = components[buttonKey.."BarFill"].Id, Instant = true })
		SetAlpha({ Id = components[buttonKey.."Bar"].Id, Fraction = 0, Duration = 0 })
		SetAlpha({ Id = components[buttonKey.."BarFill"].Id, Fraction = 0, Duration = 0 })
		components[buttonKey].BarFillId = components[buttonKey.."BarFill"].Id
		components[buttonKey].BarId = components[buttonKey.."Bar"].Id
	end

	components[buttonKey].OnPressedFunctionName = "HandleUpgradeToggle"
	screen[components[buttonKey].Id] = components[buttonKey]
	if TraitData[upgradeData.Gift].Icon and upgradeData.Unlocked then
		local icon = TraitData[upgradeData.Gift].InRackIcon or TraitData[upgradeData.Gift].Icon
		SetAnimation({ DestinationId = components[buttonKey].Id, Name = icon })
		if not CanFreeSwapKeepsakes() and ( Contains(CurrentRun.BlockedKeepsakes, upgradeData.Gift) or ( HeroSlotFilled("Shout") and not HeroHasTrait("HadesShoutTrait") and upgradeData.Gift == "HadesShoutKeepsake" ) or ( GameState.LastAssistTrait ~= nil and TraitData[upgradeData.Gift].Slot == "Assist" and upgradeData.Gift ~= screen.LastAssist )) then
			components[buttonKey.."Lock"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx, Y = localy, Group = "Combat_Menu_Overlay" })
			SetAnimation({ DestinationId = components[buttonKey.."Lock"].Id , Name = "LockedKeepsakeIcon" })
			SetColor({ Id = components[buttonKey].Id, Color = Color.DarkSlateGray })
			if components[buttonKey.."Sticker"] then
				SetColor({ Id = components[buttonKey.."Sticker"].Id, Color = Color.SlateGray })
			end
			components[buttonKey].OnPressedFunctionName = "BlockedKeepsakePresentation"
			components[buttonKey].Blocked = true
		elseif not screen.FirstUsable and screen.LastTrait == nil and screen.LastAssist == nil then
			TeleportCursor({ OffsetX = localx, OffsetY = localy, ForceUseCheck = true })
			screen.FirstUsable  = true
		elseif screen.LastTrait == upgradeData.Gift or screen.LastAssist == upgradeData.Gift then
			SetSelectedFrame( screen, components[buttonKey] )
			TeleportCursor({ OffsetX = localx, OffsetY = localy, ForceUseCheck = true })
		end
	else
		SetAnimation({ DestinationId = components[buttonKey].Id, Name = "Keepsake_Unknown" })
	end

	if upgradeData.New then
		screen.HasNew = true
		local newIconKey = "NewIcon"..upgradeData.Gift
		components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Animation = "NewTabStar", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.1, })
		Attach({ Id = components[newIconKey].Id, DestinationId = components[buttonKey].Id, OffsetX = 0, OffsetY = -30 })
		components[buttonKey].NewIcon = components[newIconKey]
	end
end

function MouseOverKeepsake( button )
	if button.Screen and not button.Screen.KeepOpen then
		return
	end
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggleKeepsakes", Id = button.TitleTextBoxId })
	KeepsakeScreenShowInfo( button.Screen, button )
end


function MouseOffKeepsake( button )

	local screen = button.Screen
	local components = screen.Components

	if not button.Blocked then
		SetScale({ Id = button.Id, Fraction = screen.BaseIconScale, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
	end
	if button.Data.Unlocked then
		SetAlpha({ Id = button.BarId, Fraction = 0, Duration = 0.3 })
		SetAlpha({ Id = button.BarFillId, Fraction = 0, Duration = 0.1 })
	end
	KeepsakeScreenUpdateActionBar( button.Screen )


	SetAlpha({ Id = components.HoverFrame.Id, Fraction = 0.0, Duration = 0.2 })

	ModifyTextBox({ Id = components.InfoBoxName.Id,
		FadeTarget = 0.0,
	})
	ModifyTextBox({ Id = components.InfoBoxRarity.Id,
		FadeTarget = 0.0,
	})
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		FadeTarget = 0.0,
	})
	ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id,
		FadeTarget = 0.0,
	})
	ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id,
		FadeTarget = 0.0,
	})
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id,
		FadeTarget = 0.0,
	})
	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 0.0, Duration = 0.2 })
	
	--SetAlpha({ Id = components.RankProgressBox.Id, Fraction = 0.0, Duration = 0.2 })
	--SetAlpha({ Id = components.CurrentLevel.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.LevelProgress.Id, Fraction = 0.0, Duration = 0.2 })
	--SetAlpha({ Id = components.EquipSubtitle.Id, Fraction = 0.0, Duration = 0.2 })

end

function KeepsakeScreenShowInfo( screen, button )
	local components = screen.Components
	
	Teleport({ Id = screen.Components.HoverFrame.Id, DestinationId = button.Id })
	SetAlpha({ Id = screen.Components.HoverFrame.Id, Fraction = 1.0, Duration = 0.2 })

	if not button.Data.Unlocked then
		return
	end
		--[[
		if IsGameStateEligible( CurrentRun, GiftData[button.Data.NPC].MaxedRequirement ) then
			SetAnimation({ Name = GiftData[button.Data.NPC].MaxedSticker, DestinationId = components.Sticker.Id })
		else
			SetAnimation({Name = "Blank", DestinationId = components.Sticker.Id })
		end
		]]

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })
	
	--SetAlpha({ Id = components.RankProgressBox.Id, Fraction = 1.0, Duration = 0.2 })
	--SetAlpha({ Id = components.CurrentLevel.Id, Fraction = 1.0, Duration = 0.2 })
	SetAlpha({ Id = components.LevelProgress.Id, Fraction = 1.0, Duration = 0.2 })
	--SetAlpha({ Id = components.EquipSubtitle.Id, Fraction = 1.0, Duration = 0.2 })
	if button.TraitData ~= nil then
		SetAnimation({ Name = button.TraitData.Icon, DestinationId = components.InfoBoxIcon.Id })
		SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 1.0, Duration = 0.2 })
		--SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 1.0, Duration = 0.2 })
		if button.NewIcon ~= nil then
			Destroy({ Id = button.NewIcon.Id })
		end
	end

	local text = button.Data.Name
	if button.TraitData ~= nil then
		text = GetTraitTooltip(button.TraitData)
	end
	local rarityName = button.TraitData.Rarity
	local rarityColor = Color["BoonPatch"..rarityName]
	ModifyTextBox({ Id = components.InfoBoxName.Id,
		Text = text,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.TraitData or weaponKit,
		Color = rarityColor,
	})

	local rarityLevel = GetRarityValue( button.TraitData.Rarity )
	ModifyTextBox({ Id = components.InfoBoxRarity.Id,
		Text = button.TraitData.CustomRarityLevels[rarityLevel],
		FadeTarget = 1.0,
		Color = rarityColor,
	})

	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = text,
		UseDescription = true,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.TraitData or weaponKit,
	})

	local traitData = button.TraitData
	if traitData ~= nil then
		local statLines = traitData.StatLines or traitData.TrayStatLines
		if traitData.CustomStatLinesWithShrineUpgrade and GetNumShrineUpgrades( traitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 then
			statLines = traitData.CustomStatLinesWithShrineUpgrade.StatLines
		end
		if statLines ~= nil then
			local statLine = statLines[1]
			ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })
			ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0})
		end
		if traitData.SignoffText ~= nil then
			ModifyTextBox({ Id = components.InfoBoxFlavor.Id, Text = traitData.SignoffText, FadeTarget = 1.0 })
		end
	end

	KeepsakeScreenUpdateActionBar( screen, button )
	if not button.Data.Unlocked then
		--ModifyTextBox({ Id = button.TitleTextBoxId, Text = "UnknownAward" })
		--ModifyTextBox({ Id = button.DescriptionTextBoxId, Text = "UnknownAward", UseDescription = true })
		-- This should call Textbox.Clear instead of setting to a blank string
		--ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = " " })
		--ModifyTextBox({ Id = button.CurrentLevelId, Text = " " })
		ModifyTextBox({ Id = button.LevelProgressId, Text = " " })
	else
		local traitData = button.TraitData
		local showKeepsakePreview = true
		if not CurrentRun.Hero.IsDead and HeroHasTrait( traitData.Name ) then
			showKeepsakePreview = nil
		end
		local traitTooltip = GetTraitTooltip(traitData, { UnequippedKeepsakePreview = showKeepsakePreview })
		ModifyTextBox({ Id = button.TitleTextBoxId, Text = traitTooltip })

		ModifyTextBox({ Id = button.DescriptionTextBoxId, Text = traitTooltip, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
		--ModifyTextBox({ Id = button.CurrentLevelId, Text = "Keepsake_Level_"..GetKeepsakeLevel(button.TraitData.Name), LuaKey = "TempTextData", LuaValue = { Level = GetKeepsakeLevel(button.TraitData.Name) }})
		if IsKeepsakeMaxed( button.TraitData.Name ) then
			ModifyTextBox({ Id = button.LevelProgressId, Text = "Keepsake_Level_Progress_Max" })
		else
			if button.TraitData.KeepsakeRarityGameStateRequirements then
				if not IsKeepsakeMaxed( button.TraitData.Name ) then
					ModifyTextBox({ Id = button.LevelProgressId, Text = "Legendary_Keepsake_Level_Progress", LuaKey = "TempTextData", LuaValue = { NPCName = button.Data.NPC }})
				else
					ModifyTextBox({ Id = button.LevelProgressId, Text = "Keepsake_Level_Progress_Max" })
				end
			else
				local chambers = GetKeepsakeChambersToNextLevel(button.TraitData.Name)
				ModifyTextBox({ Id = button.LevelProgressId, Text = GetPluralizedForm( "Keepsake_Level_Progress", chambers ), LuaKey = "TempTextData", LuaValue = { Chambers = chambers }})
			end
		end

		if button.Blocked then
			--
		else
			SetScale({ Id = button.Id, Fraction = screen.HoverIconScale, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
			local upgradeName = button.Data.Gift
			if GameState.LastAwardTrait ~= upgradeName and GameState.LastAssistTrait ~= upgradeName then
				--ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "UnEquipped_Subtitle", ColorTarget = Color.White, ColorDuration = 0 })
				--ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = " ", ColorTarget = Color.Gold, ColorDuration = 0 })
			else
				--ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "Equipped_Subtitle", ColorTarget = Color.Gold, ColorDuration = 0 })
			end
			
			GameState.NewKeepsakeItem[upgradeName] = nil
		end
		if button and button.ButtonKey and components[button.ButtonKey.."Bar"] and TraitData[button.Data.Gift].Slot ~= "Assist" then
			SetAlpha({ Id = components[button.ButtonKey.."Bar"].Id, Fraction = 1, Duration = 0.1 })
			SetAlpha({ Id = components[button.ButtonKey.."BarFill"].Id, Fraction = 1, Duration = 0.3 })
		end
	end
	
	if screen.OpenedToButtonKey 
		and screen.OpenedToButtonKey ~= button.ButtonKey 
		and TraitData[button.Data.Gift].Slot ~= "Assist" 
		and components[screen.OpenedToButtonKey.."Bar"] 
		and components[screen.OpenedToButtonKey.."BarFill"]then

		SetAlpha({ Id = components[screen.OpenedToButtonKey.."Bar"].Id, Fraction = 0, Duration = 0.1 })
		SetAlpha({ Id = components[screen.OpenedToButtonKey.."BarFill"].Id, Fraction = 0, Duration = 0.3 })
	end
	screen.OpenedToButtonKey = button.ButtonKey
end

function KeepsakeScreenUpdateActionBar( screen, button )

	local components = screen.Components

	if button ~= nil and button.Data.Unlocked and not button.Blocked then
		if GameState.LastAwardTrait ~= button.Data.Gift and GameState.LastAssistTrait ~= button.Data.Gift then
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

end

function SetSelectedFrame( screen, button )
	SetAlpha({ Id = screen.Components.EquippedFrame.Id, Fraction = 1.0, Duration = 0.2 })
	Teleport({ Id = screen.Components.EquippedFrame.Id, DestinationId = button.Id })
end

function CanFreeSwapKeepsakes()
	return ( CurrentHubRoom ~= nil and CurrentHubRoom.KeepsakeFreeSwap ) or CurrentRun.CurrentRoom.KeepsakeFreeSwap
end

function KeepsakeScreenClose( screen, button )
	OnScreenCloseStarted( screen )
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CabinetClose" })
	if screen.LastAssist ~= GameState.LastAssistTrait then
		UnequipAssist( CurrentRun.Hero, screen.LastAssist )
		EquipAssist( CurrentRun.Hero, GameState.LastAssistTrait )
		InvalidateCheckpoint()
	end

	if screen.LastTrait ~= GameState.LastAwardTrait then
		UnequipKeepsake( CurrentRun.Hero, screen.LastTrait )
		EquipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait, { FromLoot = true } )
		InvalidateCheckpoint()

		if not CanFreeSwapKeepsakes() then
			if CurrentRun.BlockedKeepsakes == nil then
				CurrentRun.BlockedKeepsakes = {}
			end
			CurrentRun.CurrentRoom.BlockKeepsakeMenu = true
			table.insert( CurrentRun.BlockedKeepsakes, screen.LastTrait )

			if GameState.LastAwardTrait == "BonusMoneyKeepsake" then
				local traitData = GetHeroTrait(GameState.LastAwardTrait)
				AddResource( "Money", traitData.BonusMoney, "BonusMoneyKeepsake" )
			end

			if screen.Source ~= nil then
				screen.Source.UseText = "UseLockedGiftRack"
				SetAnimation({ Name = "GiftRackClosed", DestinationId = screen.Source.ObjectId })
			end
		end
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuClosedVoiceLines, false )
		if CurrentHubRoom ~= nil then
			RequestPreRunLoadoutChangeSave()
		end
	end

	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	OnScreenCloseFinished( screen )

	ShowCombatUI( screen.Name )
	UpdateGiftRackShineStatus( screen.Source )

	if GameState.LastAwardTrait ~= nil then
		thread(MarkObjectiveComplete, "KeepsakePrompt")
	end
	CurrentRun.ExpiredKeepsakes = {}
end

function HandleUpgradeToggle( screen, button, textOverride )
	local upgradeName = button.Data.Gift
	local upgradeData = TraitData[upgradeName]
	local buttonId = button.Id
	local components = screen.Components
	if not button.Data.Unlocked then
		return
	end
	local changed = false
	if upgradeData.Slot == "Keepsake" and GameState.LastAwardTrait ~= upgradeName then
		GameState.LastAwardTrait = upgradeName
		changed = true
	end

	if changed then
		SetSelectedFrame( screen, button )
		PlaySound({ Name = upgradeData.EquipSound or "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY" })
		KeepsakeScreenUpdateActionBar( screen, button )
		thread( PlayVoiceLines, upgradeData.EquipVoiceLines or GlobalVoiceLines.AwardSelectedVoiceLines, false )
		--RemoveValue( GameState.Gift[button.Data.NPC].NewTraits, upgradeName )
	end
end
function GetAssistKeepsakeLevel( giftName )
	local level = 1
	if GameState.AssistUnlocks and GameState.AssistUnlocks[giftName] then
		level = GameState.AssistUnlocks[giftName] + 1
	end
	return level
end