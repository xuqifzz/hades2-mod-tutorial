function GetKeepsakeLevel( traitName, unmodified )
	if SessionState.AllKeepsakeUnlocked then
		return 3
	end
	local level = 1
	if not unmodified and HeroHasTrait( traitName ) then
		local trait = GetHeroTrait( traitName )
		if trait.Rarity then
			return GetRarityValue( trait.Rarity )
		end
	end

	if HasHeroTraitValue("KeepsakeLevelBonus") and not unmodified and (not IsKeepsakeMaxed(traitName) or KeepsakeHasHeroicRarity(traitName)) then
		level = level + GetTotalHeroTraitValue("KeepsakeLevelBonus")
	end
	local traitData = TraitData[traitName] or GetHeroTrait( traitName )
	if traitData == nil then
		return level
	end
	if traitData.KeepsakeRarityGameStateRequirements then
		for i, requirements in ipairs( traitData.KeepsakeRarityGameStateRequirements ) do
			if IsGameStateEligible( requirements ) then
				level = i
			end
		end
		return level
	end

	if not GameState.KeepsakeChambers[traitName] or traitData.ChamberThresholds == nil then
		return level
	end

	local threshold = 0
	for i, value in pairs( traitData.ChamberThresholds ) do
		threshold = threshold + value
		if threshold > GameState.KeepsakeChambers[traitName] then
			break
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
	local chambersToGo = TraitData[traitName].ChamberThresholds[currentLevel] - ( currentChambers - lastThreshold )
	local perChamberIncrease = 1
	if GameState.WorldUpgrades.WorldUpgradeDoubleAdvanceKeepsakes then
		perChamberIncrease = 2
	end
	return math.ceil( chambersToGo / perChamberIncrease )
end

function KeepsakeHasHeroicRarity( traitName )
	return TraitData[traitName] and TraitData[traitName].RarityLevels and TraitData[traitName].RarityLevels.Heroic
end

function IsKeepsakeMaxed( traitName )
	if SessionState.AllKeepsakeUnlocked then
		return true
	end
	if TraitData[traitName] and TraitData[ traitName ].KeepsakeRarityGameStateRequirements then
		for i, requirements in ipairs( TraitData[traitName].KeepsakeRarityGameStateRequirements ) do
			if not IsGameStateEligible( requirements ) then
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
	args = args or {}
	traitName = traitName or GameState.LastAwardTrait
	if traitName == nil or HeroHasTrait( traitName ) then
		return
	end
	local rarity = args.ForceRarity or GetRarityKey(GetKeepsakeLevel( traitName ))
	local traitData = AddTrait( unit, traitName, rarity, args)
	if traitData == nil then
		return
	end
	if not CurrentRun.Hero.IsDead then
		CurrentRun.TraitCache[traitName] = CurrentRun.TraitCache[traitName] or 1
	end

	if args.AddToCache then
		table.insert( CurrentRun.KeepsakeCache, traitName )
	end

	if traitData.CapMaxHealth and not args.SkipSetup then
		ValidateMaxHealth( true )
		FrameState.RequestUpdateHealthUI = true
	end
	if traitData.SpeakerNames then
		LoadVoiceBanks( traitData.SpeakerNames, nil, true )
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
			Silent = true,
		})
		RecreateLifePips()
	end
	if traitName == "ManaOverTimeRefundKeepsake" then
		local hasTrait = false
		for i, trait in ipairs(CurrentRun.Hero.Traits) do
			if trait.Name == "RoomRewardMaxManaTrait" and trait.Source == traitName then
				if trait.PropertyChanges[1].ChangeValue ~= traitData.AcquireFunctionArgs.Amount then
					trait.PropertyChanges[1].ChangeValue = traitData.AcquireFunctionArgs.Amount 
				end
				hasTrait = true
			end
		end
		if not hasTrait then
			if traitData.AcquireFunctionName then
				thread( CallFunctionName, traitData.AcquireFunctionName, traitData.AcquireFunctionArgs, traitData )
			end
		end
	end
end

function UnequipKeepsake( heroUnit, traitName, args )
	if not traitName then
		return
	end
	args = args or {}
	local reAddTraitToUI = nil
	local unit = heroUnit or CurrentRun.Hero
	if traitName == "ArmorGainKeepsake" and MapState.HealthBufferSources and MapState.HealthBufferSources.ArmorGainKeepsake then

		local storedArmor = MapState.HealthBufferSources.ArmorGainKeepsake
		CurrentRun.Hero.HealthBuffer = CurrentRun.Hero.HealthBuffer - MapState.HealthBufferSources.ArmorGainKeepsake
		MapState.HealthBufferSources.ArmorGainKeepsake = nil
		if not unit.IsDead then
			AddArmor( storedArmor, { Silent = true } )
		end
		FrameState.RequestUpdateHealthUI = true
	end
	if traitName == "ManaOverTimeRefundKeepsake" then
		local trait = GetHeroTrait(traitName)
		if trait.AcquireFunctionName == "KeepsakeAddMaxMana" and CurrentRun.Hero.IsDead then
			AddMaxMana( -trait.AcquireFunctionArgs.Amount, {}, {Silent = true})
		end
	end
	
	if TraitData[traitName].Permanent and not CanFreeSwapKeepsakes() and not args.AdvanceKeepsakeMoment then 
		local trait = GetHeroTrait(traitName)
		local ignorePermafy = false
		if trait.BoonConversionUses and trait.BoonConversionUses <= 0 then
			ignorePermafy = true
		end
		if trait.RarityUpgradeData and trait.RarityUpgradeData.Uses <= 0 then
			ignorePermafy = true
		end
		if not ignorePermafy then
			TraitUIRemove( trait )

			trait.Slot = nil
			trait.ActiveSlotOffsetIndex = nil
			trait.HideInRunHistory = nil
			SessionMapState.HUDTraitsShown[trait.Name] = nil
			
			local expired = false
			if GameState.LastAwardTrait and FatedDisableKeepsakes[GameState.LastAwardTrait] then
				expired = true
			end
			if trait.Name == "HadesAndPersephoneKeepsake" or expired then
				trait.ShowInHUD = nil
				if trait.Name == "RarifyKeepsake" then
					trait.RarityUpgradeData.Uses = 0
				elseif trait.Name == "GoldifyKeepsake" then
					trait.BoonConversionUses = 0
				end
			else
				trait.Ordered = nil
				reAddTraitToUI = trait
			end
		else
			RemoveTrait( unit, traitName )
		end
	else
		RemoveTrait( unit, traitName )
	end
	if traitName == "RandomBlessingKeepsake" and not args.AdvanceKeepsakeMoment then
		for i, trait in pairs( CurrentRun.Hero.Traits ) do
			if trait.FromChaosKeepsake then
				-- Render ineligible for further transformation
				trait.FromChaosKeepsake = nil
			end
		end
	end
	if TraitData[traitName] and TraitData[traitName].CapMaxHealth and not args.SkipValidateHealth then
		ValidateMaxHealth()
	end
	if traitName == "ReincarnationKeepsake" then
		RemoveLastStand( unit, "ReincarnationKeepsake" )
		unit.MaxLastStands = unit.MaxLastStands - 1
		RecreateLifePips()
	end
	return reAddTraitToUI
end

function AdvanceKeepsake( fromTrait )
	local traitName = GameState.LastAwardTrait
	if GameState.LastAwardTrait ~= nil and HeroHasTrait(traitName) then
		local startingKeepsakeLevel = GetKeepsakeLevel( traitName, true )
		if not fromTrait then
			local incrementAmount = 1
			if GameState.WorldUpgrades.WorldUpgradeDoubleAdvanceKeepsakes then
				incrementAmount = 2
			end
			IncrementTableValue( GameState.KeepsakeChambers, traitName, incrementAmount )
		end
		if (CurrentRun and CurrentRun.Hero and startingKeepsakeLevel ~= GetKeepsakeLevel( traitName, true )) or fromTrait then
			local persistentValues = {}
			local lastRarifyCount = nil
			for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == traitName then
					for _, key in pairs( PersistentKeepsakeKeys ) do
						if key == "DoorHealReserve" and traitData[key] then
							traitData[key] = round(traitData[key])
						end
						persistentValues[key] = traitData[key]					
					end
					if traitName == "RarifyKeepsake" and traitData.RarityUpgradeData then
						lastRarifyCount = traitData.RarityUpgradeData.Uses
					end
				end
			end
			
			UnequipKeepsake( CurrentRun.Hero, traitName, { SkipValidateHealth = true, AdvanceKeepsakeMoment = true })			
			EquipKeepsake( CurrentRun.Hero, traitName, { SkipSetup = true } )
			if traitName == "ReincarnationTrait" then
				RecreateLifePips()
			end
			if traitName == "ManaOverTimeRefundKeepsake" then
				ValidateMaxMana()
			end
			for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == traitName then
					for key, value in pairs( persistentValues ) do
						traitData[key] = value
					end

					if traitData.CostumeTrait and traitData.SetupFunction and traitData.SetupFunction.Name == "CostumeArmor" then
						if traitData.CurrentArmor ~= 0 then
							AddHealthBuffer( traitData.CurrentArmor, traitData.Name )
							FrameState.RequestUpdateHealthUI = true
						end
					end
					if traitData.Name == "LowHealthCritKeepsake" then
						if not IsTraitActive(traitData) and traitData.PropertyChanges and traitData.PropertyChanges[1] then
							-- kludge, unfortunately, due to how we assume (correctly) that no one should be tweaking property changes like this
							traitData.PropertyChanges[1].ChangeValue = 1
						end
						ValidateMaxHealth( true )
						FrameState.RequestUpdateHealthUI = true
					end
					if traitData.Name == "ReincarnationKeepsake" or traitData.Name == "GoldifyKeepsake" then
						traitData.CustomTrayText = nil
					end
					if traitData.Name == "RarifyKeepsake" then
						traitData.CustomName = nil
						if lastRarifyCount then
							-- Value hard-coded to match the increment per level of Calling Card to avoid expensive comparison calculations
							traitData.RarityUpgradeData.Uses = lastRarifyCount + 2
						end
					end
					if traitData.Name == "SpellTalentKeepsake" then
						-- Another hard-coded optimization
						local count = 1
						if GetKeepsakeLevel( traitData.Name ) == 4 then
							count = 2
						end
						AddTalentPoints( { Count = count }, traitData )
					end
					if traitData.Name == "DecayingBoostKeepsake" then
						traitData.CurrentKeepsakeDamageBonus = traitData.InitialKeepsakeDamageBonus
					end
					UpdateTraitNumber(traitData)
					break
				end
			end
			if not fromTrait then
				thread( KeepsakeLevelUpPresentation, traitName )
			end
		end
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

	local dummySource = { LineHistoryName = "NPC_Moros_01", SubtitleColor = Color.MorosVoice },

	SetPlayerInvulnerable( "BlockDeath" )
	FrameState.RequestUpdateHealthUI = true
	local tollTimes = math.floor(timer)
	StartBlockDeathPresentation( tollTimes )
	while tollTimes > 0 do
		if encounter.BossKillPresentation or (encounter.Completed and not encounterAlreadyCompleted) or CurrentRun.CurrentRoom.Leaving or encounter.ChronosTransition or not encounter.InProgress then
			SetPlayerVulnerable( "BlockDeath" )
			BlockDeathCanceled( dummySource )
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
				BlockDeathCanceled( dummySource )
				return
			end
		end
		if PlayingTextLines or SessionMapState.TyphonStaggerPresentation or SessionMapState.ChronosPolymorphChallengeEndPresentation then
			wait( 0.3 )
		else
			TickBlockDeathPresentation( dummySource, tollTimes )
			wait( 1, RoomThreadName )
			tollTimes = tollTimes - 1
		end
	end
	-- Possible to be here while other presentation is active
	while SessionMapState.TyphonStaggerPresentation or SessionMapState.ChronosPolymorphChallengeEndPresentation do
		wait( 0.3 )
	end
	
	SetPlayerVulnerable( "BlockDeath" )
	if encounter.BossKillPresentation or (encounter.Completed and not encounterAlreadyCompleted) or CurrentRun.CurrentRoom.Leaving or encounter.ChronosTransition then
		BlockDeathCanceled( dummySource )
		return
	end
	if ( encounterAlreadyCompleted and ( not CurrentRun.Hero.InvulnerableFlags or not CurrentRun.Hero.InvulnerableFlags.LeaveRoom)) or ( not encounter.Completed and not encounter.BossKillPresentation and encounter.InProgress ) then
		CurrentRun.Hero.HealthBuffer = 0
		SacrificeHealth({SacrificeHealthMin = damage, SacrificeHealthMax = damage, MinHealth = 0, Silent = true, IgnoreCap = true  })
	else
		BlockDeathCanceled( dummySource )
	end
end

function BlockDeathCanceled( source )
	Heal( CurrentRun.Hero, { HealAmount = GetTotalHeroTraitValue("BlockDeathHealth") - 1, SourceName = "BlockDeathClear", Silent = true } )
	OnPlayerHealed( CurrentRun.Hero, { ActualHealAmount = CurrentRun.Hero.Health } )
	FrameState.RequestUpdateHealthUI = true
	BlockDeathCanceledPresentation( source )
end

function KeepsakeAddMaxMana( args )
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BiomeStartRoom then
		args.PreDelay = CurrentRun.CurrentRoom.IntroSequenceDuration
	end
	thread( AddMaxMana, args.Amount, {}, args)
end

function CheckOverTimeManaRefund( functionArgs, manaDelta )
	if not IsEmpty(MapState.ClearCastWeapons) or not HeroHasTrait( "ManaOverTimeRefundTrait" ) then
		return
	end
	local manaRestored = math.abs(manaDelta)
	local sourceTrait = GetHeroTrait( "ManaOverTimeRefundTrait" )
	if sourceTrait.TotalManaRecovered <= 0 then
		return
	end
	
	if manaRestored > sourceTrait.TotalManaRecovered then
		manaRestored = sourceTrait.TotalManaRecovered 
	end
	thread( ManaOverTimeRefund, functionArgs.Duration, functionArgs.Interval, manaRestored )
	sourceTrait.TotalManaRecovered = sourceTrait.TotalManaRecovered - manaRestored
	if sourceTrait.TotalManaRecovered <= 0 then
		thread( RefundKeepsakeExpiredPresentation, sourceTrait )
		RemoveTraitData( CurrentRun.Hero, sourceTrait )
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
				if manaRegen > value then
					manaRegen = value
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

function EquipLastAwardTrait( eventSource, hero )
	local existingHero = CurrentRun.Hero or hero
	if GameState.SaveFirstKeepsakeName ~= nil and not CurrentRun.SaveFirstKeepsakeSwapped then
		GameState.LastAwardTrait = GameState.SaveFirstKeepsakeName
		CurrentRun.SaveFirstKeepsakeSwapped = true
	end
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
	
	UpdateFateStatus()
	screen.LastTrait = GameState.LastAwardTrait
	screen.StartingHasLastStand = HasLastStand( CurrentRun.Hero )
	
	screen.StartingHealth = CurrentRun.Hero.MaxHealth
	screen.StartingMana = CurrentRun.Hero.MaxMana
	screen.StartingFateValid = PreRunIsFateValid()

	local components = screen.Components

	if GameState.LastAwardTrait ~= nil then
		thread( MarkObjectiveComplete, "GiftRackPrompt" )
	end

	screen.StartX = screen.StartX + ScreenCenterNativeOffsetX
	screen.StartY = screen.StartY + ScreenCenterNativeOffsetY
	
	local rowMin = math.ceil( screen.RowMax / 2 )
	screen.HasUnlocked = false
	screen.HasNew = false
	screen.FirstUsable = false
	wait( 0.2 )
	for itemIndex, itemName in ipairs( screen.ItemOrder ) do

		local keepsakeData = GetKeepsakeData( itemName )
		if keepsakeData ~= nil then
			local itemData =
			{
				New = GameState.NewKeepsakeItem[keepsakeData.GiftLevelData.Gift],
				Gift = itemName,
				Level = 1,
				NPC = keepsakeData.NPCName,
				Unlocked = SessionState.AllKeepsakeUnlocked or IsGameStateEligible( keepsakeData.GiftLevelData, keepsakeData.GiftLevelData.GameStateRequirements )
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

	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })

	screen.KeepOpen = true
	HandleScreenInput( screen )

end

function CreateKeepsakeIcon( screen, components, args )
	args = args or {}
	local localx = args.X
	local localy = args.Y
	local itemIndex = args.Index
	local upgradeData = args.UpgradeData
	local keyAppend = args.KeyAppend or ""
	local scale = args.Scale or 0.75

	local buttonKey = "UpgradeToggle"..itemIndex..keyAppend
	components[buttonKey.."Frame"] = CreateScreenComponent({ Name = "BlankObstacle",
		X = localx, Y = localy + 10,
		Group = "Combat_Menu_Overlay_Backing",
		Animation = "Keepsake_BackingMenu",
		Scale = scale,
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.15,
	})

	components[buttonKey] = CreateScreenComponent({ Name = "ButtonKeepsakeItem",
		Scale = screen.BaseIconScale,
		X = localx, Y = localy,
		Group = "Combat_Menu_Overlay",
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.15,
		InteractProperties =
		{
			TooltipX = screen.TooltipX + ScreenCenterNativeOffsetX,
			TooltipY = screen.TooltipY + ScreenCenterNativeOffsetY,
		},
	})
	components[buttonKey].LevelProgressId = components.LevelProgress.Id
	components[buttonKey].Data = upgradeData
	components[buttonKey].ButtonKey = buttonKey
	components[buttonKey].FrameId = components[buttonKey.."Frame"].Id	
	components[buttonKey].OnMouseOverFunctionName = "MouseOverKeepsake"
	components[buttonKey].OnMouseOffFunctionName = "MouseOffKeepsake"
	components[buttonKey].Screen = screen

	local traitName = upgradeData.Gift
	local traitData = nil
	if HeroHasTrait(traitName) then
		traitData = GetHeroTrait( traitName )		
		if traitData.SignOffData then
			for i, data in ipairs( traitData.SignOffData ) do
				if SessionState.AllKeepsakeUnlocked or data.GameStateRequirements == nil or IsGameStateEligible( traitData, data.GameStateRequirements ) then
					traitData.SignoffText = data.Text
					break
				end
			end
		end
	else
		traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey(GetKeepsakeLevel( traitName )) })
	end
	ExtractValues( CurrentRun.Hero, traitData, traitData )
	components[buttonKey].TraitData = traitData

	if not upgradeData.Unlocked then
		SetColor({ Id = components[buttonKey].Id, Color = Color.White })
	else
		-- Hidden description for tooltips
		
		local text = GetTraitTooltip(traitData)
		if HeroHasTrait(traitData.Name) and not CurrentRun.Hero.IsDead and traitData.CustomTrayText then
			text = traitData.CustomTrayText
		end
		CreateTextBox({ Id = components[buttonKey].Id,
			Text = text,
			UseDescription = true,
			OffsetX = 0, OffsetY = 0,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = traitData,
		})

		if traitData.ShowLastStandWarning then 
			local validLastStandState = true
			if CurrentRun.Hero.IsDead then 
				validLastStandState = GetNumMetaUpgradeLastStands() == 0 
			end
			-- We skip the Engraved Pin or Luckier tooth here because it's mutually exclusive with the Athena keepsake
			if TableLength( CurrentRun.Hero.LastStands ) > 1 
				or ( TableLength( CurrentRun.Hero.LastStands ) == 1 and GameState.LastAwardTrait ~= "ReincarnationKeepsake" ) then
				validLastStandState = false
			end
			
			if  not validLastStandState then
				CreateTextBox({ Id = components[buttonKey].Id,
					Text = "ExtraLivesWarning_Tooltip",
					UseDescription = true,
					OffsetX = 0, OffsetY = 0,
					Color = Color.Transparent,
				})
			end
		end
		
		if FatedEnableKeepsakes[traitData.Name] then
			local text = "RandomWarningAlt_Tooltip"
			local validFateState = IsFateValid()
			if CurrentRun.Hero.IsDead then
				text = "RandomWarning_Tooltip"
			end
			if not validFateState then
				CreateTextBox({ 
					Id = components[buttonKey].Id,
					Text = text,
					UseDescription = true,
					OffsetX = 0, OffsetY = 0,
					Color = Color.Transparent,
				})
			end
		end
		
		if TraitData[upgradeData.Gift].BlockedByEnding and not IsGameStateEligible( upgradeData, { NamedRequirementsFalse = {"SurfaceRouteLockedByTyphonKill"}} ) then
				CreateTextBox({ 
					Id = components[buttonKey].Id,
					Text = "BlockedByEnding_Tooltip",
					UseDescription = true,
					OffsetX = 0, OffsetY = 0,
					Color = Color.Transparent,
				})
		end

		screen.HasUnlocked = true
		local level = GetKeepsakeLevel( traitData.Name )
		components[buttonKey.."Bar"] = CreateScreenComponent({ Name = "KeepsakeBar", X = localx, Y = localy + 80, Group = "Combat_Menu_Overlay", Alpha = 0.0 })
		components[buttonKey.."Rank"] = CreateScreenComponent({ Name = "BlankObstacle",
			Animation = screen.RankAnimations[level],
			Scale = screen.RankScale,
			X = localx, Y = localy + screen.RankOffsetY,
			Group = screen.ComponentData.DefaultGroup,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.4,
		})
		
		components[buttonKey.."BarFill"] = CreateScreenComponent({ Name = "KeepsakeBarFill", X = localx, Y = localy + 80, Group = "Combat_Menu_Overlay", Alpha = 0.0 })
		SetAnimationFrameTarget({ Name = "KeepsakeBarFill", Fraction = GetKeepsakeProgress( traitData.Name ), DestinationId = components[buttonKey.."BarFill"].Id, Instant = true })
		components[buttonKey].BarFillId = components[buttonKey.."BarFill"].Id
		components[buttonKey].BarId = components[buttonKey.."Bar"].Id
	end

	components[buttonKey].OnPressedFunctionName = "HandleUpgradeToggle"
	screen[components[buttonKey].Id] = components[buttonKey]
	if TraitData[upgradeData.Gift].Icon and upgradeData.Unlocked then
		local icon = TraitData[upgradeData.Gift].InRackIcon or TraitData[upgradeData.Gift].Icon
		SetAnimation({ DestinationId = components[buttonKey].Id, Name = icon })
		local blocked = ( Contains(CurrentRun.BlockedKeepsakes, upgradeData.Gift) or ( CurrentRun.UseRecord.NPC_Athena_01 and not HeroHasTrait("AthenaEncounterKeepsake") and upgradeData.Gift == "AthenaEncounterKeepsake" ) ) 
		local blockedByEnding = false
		if not IsFateValid() and FatedEnableKeepsakes[upgradeData.Gift] then
			blocked = true
		end
		if TraitData[upgradeData.Gift].BlockedByEnding and not IsGameStateEligible( upgradeData, { NamedRequirementsFalse = {"SurfaceRouteLockedByTyphonKill"}} ) then
			blockedByEnding = true
		end

		if (not CanFreeSwapKeepsakes() and blocked) or blockedByEnding then
			components[buttonKey.."Lock"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx, Y = localy, Group = "Combat_Menu_Overlay", Animation = "LockedKeepsakeIcon" })
			SetColor({ Id = components[buttonKey].Id, Color = Color.DarkSlateGray })
			if components[buttonKey.."Sticker"] then
				SetColor({ Id = components[buttonKey.."Sticker"].Id, Color = Color.SlateGray })
			end
			components[buttonKey].OnPressedFunctionName = "BlockedKeepsakePresentation"
			components[buttonKey].Blocked = true
		elseif not screen.FirstUsable and screen.LastTrait == nil and screen.LastAssist == nil then
			TeleportCursor({ OffsetX = localx, OffsetY = localy, ForceUseCheck = true })
			KeepsakeScreenShowInfo( screen, components[buttonKey] )
			screen.FirstUsable  = true
		elseif screen.LastTrait == upgradeData.Gift or screen.LastAssist == upgradeData.Gift then
			SetSelectedFrame( screen, components[buttonKey], { Duration = 0.4 } )
			TeleportCursor({ OffsetX = localx, OffsetY = localy, ForceUseCheck = true })
			KeepsakeScreenShowInfo( screen, components[buttonKey] )
		end
	else
		SetAnimation({ DestinationId = components[buttonKey].Id, Name = "Keepsake_Unknown" })
	end
	
	if SessionState.AllKeepsakeUnlocked or ( GiftData[upgradeData.NPC].MaxedRequirement and IsGameStateEligible( CurrentRun, GiftData[upgradeData.NPC].MaxedRequirement )) then
		components[buttonKey.."Sticker"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx + 30, Y = localy - 40, Group = "Combat_Menu_Overlay" })
		SetAnimation({ Name = GiftData[upgradeData.NPC].MaxedIcon, DestinationId = components[buttonKey.."Sticker"].Id })
		SetAnimation({ DestinationId = components[buttonKey.."Frame"].Id , Name = "Keepsake_BackingMenu_StickerShadow" })
	end

	if upgradeData.New then
		screen.HasNew = true
		local newIconKey = "NewIcon"..upgradeData.Gift
		components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Animation = "NewTabStar", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.1, })
		Attach({ Id = components[newIconKey].Id, DestinationId = components[buttonKey].Id, OffsetX = 0, OffsetY = -30 })
		components[buttonKey].NewIcon = components[newIconKey]
	end

	if GameState.SaveFirstKeepsakeName == upgradeData.Gift then
		SetSaveFirstIcon( screen, components[buttonKey] )
	end
end

function MouseOverKeepsake( button )
	if button.Screen and not button.Screen.KeepOpen then
		return
	end
	local screen = button.Screen
	local components = screen.Components
	if not button.Data.Unlocked  then
		screen.SelectedButton = nil
	elseif CurrentRun.Hero.IsDead and GameState.WorldUpgrades.WorldUpgradeKeepsakeSaveFirst and GameState.SaveFirstKeepsakeName ~= button.TraitData.Name then
		screen.SelectedButton = button
	end

	if CheckCooldown( "MouseOverKeepsakeSound", 0.1 ) then
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggleKeepsakes", Id = button.TitleTextBoxId })
	end
	KeepsakeScreenShowInfo( button.Screen, button )
end


function MouseOffKeepsake( button )

	local screen = button.Screen
	local components = screen.Components

	if not button.Blocked then
		SetScale({ Id = button.Id, Fraction = screen.BaseIconScale, Duration = 0.1, EaseIn = 0, EaseOut = 1, SkipGeometryUpdate = true })
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
	SetAlpha({ Id = components.Sticker.Id, Fraction = 0.0, Duration = 0.2 })
	
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
	screen.SelectedButton = button
	screen.ClipboardText = button.TraitData.Name
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
	if HeroHasTrait(button.TraitData.Name) and not CurrentRun.Hero.IsDead and button.TraitData.CustomTrayText then
		text = button.TraitData.CustomTrayText
	end
	
	local rarityName = button.TraitData.Rarity or "Common"
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
		DataProperties =
		{
			TextSymbolOffsetY = button.TraitData.RarityTextSymbolOffset,
		},
	})

	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = text,
		UseDescription = true,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.TraitData or weaponKit,
		DataProperties = 
		{
			TextSymbolScale = button.TraitData.DescriptionTextSymbolScale or ScreenData.UpgradeChoice.DescriptionText.TextSymbolScale
		},
	})

	local traitData = button.TraitData
	if traitData ~= nil then
		local statLines = traitData.StatLines or traitData.TrayStatLines
		if traitData.CustomStatLinesWithShrineUpgrade and GetNumShrineUpgrades( traitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 then
			statLines = traitData.CustomStatLinesWithShrineUpgrade.StatLines
		end
		if statLines ~= nil then
			local statLine = statLines[1]
			ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, AppendToId = components.InfoBoxDescription.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })
			ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, AppendToId = components.InfoBoxDescription.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0})
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

		if SessionState.AllKeepsakeUnlocked or ( GiftData[button.Data.NPC].MaxedRequirement and IsGameStateEligible( CurrentRun, GiftData[button.Data.NPC].MaxedRequirement )) then
			
			SetAlpha({ Id = components.Sticker.Id, Fraction = 1.0, Duration = 0.2 })
			SetAnimation({ Name = GiftData[button.Data.NPC].MaxedSticker, DestinationId = components.Sticker.Id })
		else
			SetAnimation({Name = "Blank", DestinationId = components.Sticker.Id })
		end
		
		local upgradeName = button.Data.Gift		
		if upgradeName then
			GameState.NewKeepsakeItem[upgradeName] = nil
		end
		if button.Blocked then
			--
		else
			SetScale({ Id = button.Id, Fraction = screen.HoverIconScale, Duration = 0.1, EaseIn = 0, EaseOut = 1, SkipGeometryUpdate = true })
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

	if button ~= nil and button.Data.Unlocked then
		if not button.Blocked then
			if GameState.LastAwardTrait ~= button.Data.Gift then
				SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
			else
				SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
			end
		end

		
		if GameState.WorldUpgrades.WorldUpgradeKeepsakeSaveFirst then
			if GameState.SaveFirstKeepsakeName ~= button.TraitData.Name then
				ModifyTextBox({Id = components.SaveFirstButton.Id, Text = "Menu_SaveKeepsake" })
			else
				ModifyTextBox({Id = components.SaveFirstButton.Id, Text = "Menu_UnSaveKeepsake" })
			end
			SetAlpha({ Id = components.SaveFirstButton.Id, Fraction = 1.0, Duration = 0.2 })
			components.SaveFirstButton.Visible = true
			if not GameState.Flags.HasUsedSaveFirstSystem and not screen.FirstTimeSaveFirstPresentation then
				thread( PulseContextActionPresentation, components.SaveFirstButton, { InitialWait = 2.0, Color = Color.Gold, PulseOnce = true, ThreadName = "FirstTimeSaveFirstPulse" } )
				screen.FirstTimeSaveFirstPresentation = true
			end
		else
			SetAlpha({ Id = components.SaveFirstButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.SaveFirstButton.Id, Fraction = 0.0, Duration = 0.2 })
		components.SaveFirstButton.Visible = false
	end

end

function SetSelectedFrame( screen, button, args )
	args = args or {}
	if args.RestartAnimation then
		SetAnimation({ DestinationId = screen.Components.EquippedFrame.Id, Name = screen.Components.EquippedFrame.AnimationName, StartFrameFraction = 0 })
	end
	SetAlpha({ Id = screen.Components.EquippedFrame.Id, Fraction = 1.0, Duration = args.Duration or 0.2 })
	Teleport({ Id = screen.Components.EquippedFrame.Id, DestinationId = button.Id })
end

function CanFreeSwapKeepsakes()
	return ( CurrentHubRoom ~= nil and CurrentHubRoom.KeepsakeFreeSwap ) or CurrentRun.CurrentRoom.KeepsakeFreeSwap
end

function KeepsakeScreenSaveFirst( screen, button )
	if not GameState.WorldUpgrades.WorldUpgradeKeepsakeSaveFirst then
		return
	end
	if screen.SelectedButton and screen.SelectedButton and screen.SelectedButton.Data and screen.SelectedButton.Data.Unlocked then
		if GameState.SaveFirstKeepsakeName ~= screen.SelectedButton.Data.Gift then
			thread( KeepsakeScreenSaveFirstPresentation, button )
			GameState.Flags.HasUsedSaveFirstSystem = true
			GameState.SaveFirstKeepsakeName = screen.SelectedButton.Data.Gift
			CurrentRun.SaveFirstKeepsakeSwapped = true
			SetSaveFirstIcon( screen, screen.SelectedButton )
			if CurrentRun.Hero and CurrentRun.Hero.IsDead then
				HandleUpgradeToggle( screen, screen.SelectedButton )
			end
		else
			thread( KeepsakeScreenClearSaveFirstPresentation, button )
			GameState.SaveFirstKeepsakeName = nil
			ClearSaveFirstIcon( screen, screen.SelectedButton )
		end
		KeepsakeScreenUpdateActionBar( screen, screen.SelectedButton )
		killTaggedThreads( "FirstTimeSaveFirstPulse" )
	end
end

function SetSaveFirstIcon( screen, button )
	if button then
		SetAlpha({ Id = screen.Components.SaveFirstFrame.Id, Fraction = 1.0, Duration = 0.2 })
		Teleport({ Id = screen.Components.SaveFirstFrame.Id, DestinationId = button.Id })
	end
end

function ClearSaveFirstIcon( screen, button )
	if button then
		SetAlpha({ Id = screen.Components.SaveFirstFrame.Id, Fraction = 0.0, Duration = 0.2 })
		Teleport({ Id = screen.Components.SaveFirstFrame.Id, DestinationId = button.Id })
	end
end

function KeepsakeScreenClose( screen, button )
	killTaggedThreads( "FirstTimeSaveFirstPulse" )
	OnScreenCloseStarted( screen )
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = "AwardMenuBackgroundOut" })
	
	if screen.LastTrait ~= GameState.LastAwardTrait then
		local reAddTraitToUI = UnequipKeepsake( CurrentRun.Hero, screen.LastTrait )
		EquipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait, { FromLoot = true, AddToCache = ( CurrentHubRoom == nil ) } )
		if reAddTraitToUI ~= nil then
			TraitUIAdd( reAddTraitToUI )
		end
		local trait = GetHeroTrait( GameState.LastAwardTrait )
		if trait.SwapInvalidateCheckpoint then
			InvalidateCheckpoint()
		end

		if not CanFreeSwapKeepsakes() then
			CurrentRun.CurrentRoom.BlockKeepsakeMenu = true
			table.insert( CurrentRun.BlockedKeepsakes, screen.LastTrait )

			if GameState.LastAwardTrait == "BonusMoneyKeepsake" then
				AddResource( "Money", round(trait.BonusMoney * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )), "BonusMoneyKeepsake" )
			end
			local delay = 0.5
			if screen.StartingHasLastStand ~= HasLastStand(CurrentRun.Hero) then
				thread( LowHealthBonusBuffStatePresentation, delay )
			end

			if screen.Source ~= nil then
				screen.Source.UseText = "UseLockedGiftRack"
				SetAnimation({ Name = "GiftRackClosed", DestinationId = screen.Source.ObjectId })
			end

			if GameState.FatedStatus == "Fated" and FatedDisableKeepsakes[GameState.LastAwardTrait] then
				delay = delay + 0.5

				if HeroHasTrait("HadesAndPersephoneKeepsake") then
					local trait = GetHeroTrait("HadesAndPersephoneKeepsake")
					trait.ShowInHUD = nil
					TraitUIRemove( trait )
				end
				if HeroHasTrait("RarifyKeepsake") then
					local trait = GetHeroTrait("RarifyKeepsake")
					trait.ShowInHUD = nil
					trait.RarityUpgradeData.Uses = 0
					TraitUIRemove( trait )
				end
				
				if HeroHasTrait("GoldifyKeepsake") then
					local trait = GetHeroTrait("GoldifyKeepsake")
					trait.ShowInHUD = nil
					trait.BoonConversionUses = 0
					TraitUIRemove( trait )
				end
				thread( InRunFateDisabledPresentation, delay )
				
				for i, trait in pairs(CurrentRun.Hero.Traits) do
					if trait.GrantedTrait then
						RemoveTrait(CurrentRun.Hero, trait.Name )
						delay = delay + 0.5
						thread( InRunHadesBoonRemoved, trait.Name, delay )
						break
					end
				end
			end
		else
			local delay = 0.5
			if screen.StartingHasLastStand ~= HasLastStand(CurrentRun.Hero) then
				thread( LowHealthBonusBuffStatePresentation, delay )
				delay = delay + 0.5
			end
			-- Only show in prerun and only if you've equipped a fated keepsake			
			if FatedEnableKeepsakes[GameState.LastAwardTrait] then
				thread( FatedValidityStatePresentation, delay )
			end

		end
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuClosedVoiceLines, false )
		if CurrentHubRoom ~= nil and GameState.CompletedObjectiveSets.KeepsakePrompt then
			RequestPreRunLoadoutChangeSave()
		end

		
		if screen.StartingHealth ~= CurrentRun.Hero.MaxHealth then
			thread( MaxHealthChangedPresentation, CurrentRun.Hero.MaxHealth > screen.StartingHealth, 0.65)
		end
		if screen.StartingMana ~= CurrentRun.Hero.MaxMana then
			thread( MaxManaChangedPresentation, CurrentRun.Hero.MaxMana > screen.StartingMana, 0.65 )
		end
	end

	CloseScreen( GetAllIds( screen.Components ), 0.0, screen, { FadeOutTime = 0.2, CloseDestroyWait = 0.35 } )
	OnScreenCloseFinished( screen )

	ShowCombatUI( screen.Name )
	UpdateGiftRackShineStatus( screen.Source )
	UpdateFateStatus()
	CheckAndAddOlympianDuo( screen.Source )

	if GameState.LastAwardTrait ~= nil then
		thread( MarkObjectiveComplete, "KeepsakePrompt" )
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
		SetSelectedFrame( screen, button, { RestartAnimation = true } )
		PlaySound({ Name = upgradeData.EquipSound or "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY" })
		KeepsakeScreenUpdateActionBar( screen, button )
		thread( PlayVoiceLines, upgradeData.EquipVoiceLines or GlobalVoiceLines.AwardSelectedVoiceLines, false )
	end
end

function KeepsakeAcquireSpellDrop( args, trait )
	if not IsGameStateEligible( trait, args.GameStateRequirements) then
		return
	end
	AddTalentPoints( args, trait )
	if CurrentRun.Hero.SlottedSpell == nil then
		RewardStoreAddPriority( args, trait )
	else
		local alternateArgs = ShallowCopyTable( args )
		alternateArgs.Name = args.AlternatePriorityRewardName
		RewardStoreAddPriority( alternateArgs, trait )
	end
end

function GiftRackEquipRandomKeepsake( source, args )

	RandomSynchronize()

	-- lock out the gift rack
	CurrentRun.CurrentRoom.BlockKeepsakeMenu = true
	source.UseText = "UseLockedGiftRack"
	SetAnimation({ DestinationId = source.ObjectId, Name = "GiftRackClosed" })

	-- pick a random, non-blocked keepsake to equip
	local prevKeepsake = GameState.LastAwardTrait
	table.insert( CurrentRun.BlockedKeepsakes, prevKeepsake )
	if FatedEnableKeepsakes[prevKeepsake] then
		for keepsake in pairs( FatedDisableKeepsakes ) do
			table.insert( CurrentRun.BlockedKeepsakes, keepsake )
		end
	end
	local eligibleKeepsakes = ShallowCopyTable( BountyData[CurrentRun.ActiveBounty].RandomKeepsakeNames )
	for i, keepsake in ipairs( CurrentRun.BlockedKeepsakes ) do
		RemoveValueAndCollapse( eligibleKeepsakes, keepsake )
	end

	UnequipKeepsake( CurrentRun.Hero, prevKeepsake )
	GameState.LastAwardTrait = GetRandomValue( eligibleKeepsakes )
	EquipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait, { FromLoot = true, AddToCache = true, TraitAddedPresentationDelay = 1.75 } )

	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "KeepsakeRandomized", LuaKey = "TempTextData", LuaValue = { Name = GameState.LastAwardTrait }, PreDelay = 1.75, Duration = 1.8 } )
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosBoonChange", Delay = 1.75 })
	RunShopGeneration( CurrentRun.CurrentRoom )
	local trait = GetHeroTrait( GameState.LastAwardTrait )
	PlaySound({ Name = trait.EquipSound, Delay = 1.75 })
	if trait.Name == "BonusMoneyKeepsake" then
		AddResource( "Money", round( trait.BonusMoney * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } ) ), "BonusMoneyKeepsake" )
	end

end

function UpdateFateStatus( )
	for metaUpgradeName in pairs(FatedDisableMetaUpgrades) do
		if GameState.MetaUpgradeState[metaUpgradeName].Equipped then
			GameState.FatedStatus = "Unfated"
			return
		end
	end
	if GameState.LastAwardTrait then
		if FatedDisableKeepsakes[GameState.LastAwardTrait] then
			GameState.FatedStatus = "Unfated"
			return
		elseif FatedEnableKeepsakes[GameState.LastAwardTrait] and not CurrentRun.Hero.IsDead then
			GameState.FatedStatus = "Fated"
			return
		end
	end
	if CurrentRun.Hero.IsDead then
		GameState.FatedStatus = "Unknown"
	end
end

function IsFateValid()
	return GameState.FatedStatus ~= "Unfated"
end

function PreRunIsFateValid()
	if GameState.LastAwardTrait and FatedEnableKeepsakes[GameState.LastAwardTrait] then
		for metaUpgradeName in pairs(FatedDisableMetaUpgrades) do
			if GameState.MetaUpgradeState[metaUpgradeName].Equipped then
				return false
			end
		end
	end
	return true
end