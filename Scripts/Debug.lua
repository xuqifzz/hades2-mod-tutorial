--[[ * DEBUG SCRIPTS ]]

OnAnyLoad
{
	function( triggerArgs )
		if verboseLogging then
			if GetConfigOptionValue({ Name = "AutoSafeMode" }) or GetConfigOptionValue({ Name = "EditingMode" }) then
				SafeModeOn()
			end
			if GetConfigOptionValue({ Name = "UseAutoPlaySaveQueue" }) then
				AutoPlayOn()
			end
		end
	end
}

OnKeyPressed{ "ControlShift L", Name = "LoadCheckpoint", Safe = true,
	function( triggerArgs )
		DebugPrint({ Text = "Game Loading" })
		LoadCheckpoint({ })
		DebugPrint({ Text = "Game Loaded" })
	end
}


OnKeyPressed{ "Control G", Name = "SafeMode",
	function( triggerArgs )
		-- Cannot run out of health or mana
		if not SessionState.SafeMode then
			SafeModeOn()	
		else
			SafeModeOff()
		end
	end
}

OnKeyPressed{ "ControlAlt C", Name = "TogglePlayerCollision",
	function( triggerArgs )
		ToggleConfigOption( "SkipCollisionCheck" )
	end
}

OnKeyPressed{ "ControlAlt V", Name = "ToggleVfx",
	function( triggerArgs )
		ToggleConfigOption( "EnableVfx" )
	end
}

OnKeyPressed{ "Alt H", Name = "TestCombatText",
	function( triggerArgs )
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_ExtraChance", 0.9, { ShadowScaleX = 1.5 } )
	end
}

local languages = {
	"de",
	"el",
	"es",
	"fr",
	"it",
	"ja",
	"ko",
	"pt-BR",
	"pl",
	"ru",
	"tr",
	"uk",
	"zh-CN",
	"zh-TW",
}

OnKeyPressed{ "Alt L", Name = "TestAllLanguages", Safe = true,
	function( triggerArgs )
		thread(function( args )
			local startLang = GetLanguage({})

			for langIndex, lang in ipairs(languages) do
				DebugPrint({ Text="Testing Language: "..lang })
				SetLanguage(lang)
				wait(0.75)
			end

			SetLanguage(startLang)
		end)
	end
}

OnKeyPressed{ "Control L", Name = "LocTestDialogLineBreak",
	function( triggerArgs )
		thread(function( args )
			local startLang = GetLanguage({})
			local testCases = {
				["el"] = {
					"MelinoeField_0312",	
					"Polyphemus_0008",	-- {#Emph}«Δε
				},
				["en"] = {
					"Scylla_0036",
				},
				["fr"] = {
					"Scylla_0002",
					"Eris_0251",		-- {#Emph} « + space near end of line
					"Hecate_0627",
				},
				["ja"] = {
					"Hestia_0069",		-- Hard-coded '2' in line assert
					"Arachne_0112",		-- Arachne, lots of ellipses
				},
				["ko"] = {
					"Arachne_0112",		-- Arachne, lots of ellipses
				},
				["ru"] = {
					"ErisField_0154",	-- Em-dash
				},
				["zh-CN"] = { 
					"Arachne_0046",		-- {#Emph} + quote
					"Arachne_0112",		-- Arachne, lots of ellipses
					"Dora_0054",		-- Dora angle brackets (though they were removed)
				},
				["zh-TW"] = {
					"Arachne_0112",		-- Arachne, lots of ellipses
				},
			}

			if ActiveScreens ~= nil and not IsScreenOpen( "Dialog" ) then
				DebugAssert({ Condition=false, Owner="Dexter", Text="Please open an NPC dialog before running the line break tests. You may dimiss this assert." })
				return
			end

			DebugPrint({ Text="Beginning Line Break Tests!" })
			DebugPrint({ Text="---------------------------------" })

			for langIndex, lang in ipairs(languages) do
				local langTestCases = testCases[lang]
				if langTestCases ~= nil then
					SetLanguage(lang)
					DebugPrint({ Text="Testing Language: "..lang })
					DebugPrint({ Text=" " })
					wait(0.75)
					for caseIndex, case in ipairs(langTestCases) do
						local textId = case
						DebugPrint({ Text="CASE: "..case })
						if ActiveScreens ~= nil and IsScreenOpen( "Dialog" ) then
							local screen = ActiveScreens["Dialog"]
							if screen.BackgroundId ~= nil then
								ModifyTextBox({ 
									Id = screen.BackgroundId, 
									Text = case,
									UseLastHelpTextIdOrDefaultText = true,
									UseDefaultFont = true,
									UseDefaultScale = true,
									ReReadTextImmediately = true,
								})

								-- If desired, can test in LineHistory view as well
								-- table.insert(CurrentRun.LineHistory, {
								-- 	SpeakerName = "TestLineBreak",
								-- 	Text = case,
								-- 	SubtitleColor = Color.NarratorVoice
								-- })
							end
						end
						wait(1.5)
					end
				end
			end
			
			DebugPrint({ Text="---------------------------------" })
			DebugPrint({ Text="Line Break Tests Complete!" })
			DebugPrint({ Text="---------------------------------" })
			SetLanguage(startLang)

		end)
	end
}

OnKeyPressed{ "ControlAlt L", Name = "Loc Gauntlet", --Safe = true,
	function( triggerArgs )
		thread(function( args )
			local startLang = GetLanguage({})

			if ActiveScreens ~= nil and not IsScreenOpen( "Dialog" ) and TextLinesCache ~= nil then
				DebugAssert({ Condition=false, Owner="Dexter", Text="Please open an NPC dialog before running the Loc Gauntlet. You may dimiss this assert." })
				return
			end

			DebugPrint({ Text="Beginning Loc Gauntlet for: "..startLang.."!" })
			DebugPrint({ Text="---------------------------------" })

			-- for langIndex, lang in ipairs(languages) do
				-- DebugPrint({ Text="Testing Language: "..lang })
				-- if lang ~= "en" then
				-- SetLanguage(lang)
				wait(0.05)

				local waitTime = 2 * 16.67 / 1000 -- wait 2 frames
				local ordered = CollapseTableOrdered(TextLinesCache)
				local total = TableLength(ordered)
				local linesTested = 0
				for caseIndex, case in ipairs(ordered) do
					if case ~= nil and case[1] ~= nil then

						for lineIndex, line in ipairs(case) do
							local helpTextId = nil
							local text = nil
							local rawText = line.Text
							if line.Cue ~= nil then
								if line.Cue ~= "/EmptyCue" then
									helpTextId = string.sub( line.Cue, 5 )
								end
								rawText = nil
								text = helpTextId
								if not HasDisplayName({ Text = helpTextId }) then
									rawText = line.Text
									text = nil
								end
							elseif line.IgnoreRawText then
								rawText = nil
								text = line.Text
							end

							if text ~= nil then
								local screen = ActiveScreens["Dialog"]
								if screen.BackgroundId ~= nil then
									ModifyTextBox({ 
										Id = screen.BackgroundId, 
										Text = text,
										UseLastHelpTextIdOrDefaultText = true,
										UseDefaultFont = true,
										UseDefaultScale = true,
										ReReadTextImmediately = true,
									})
									linesTested = linesTested + 1
								end
								wait(waitTime)
							end
						end
					end

					if caseIndex % 250 == 0 then
						DebugPrint({ Text="Tested: "..tostring(linesTested).." lines from "..tostring(caseIndex).." of "..tostring(total).." events" })
					end
				end
				DebugPrint({ Text="Done! : "..tostring(linesTested).." lines from "..tostring(caseIndex).." of "..tostring(total).." events" })
			-- end

			SetLanguage(startLang)
		end)
	end
}

OnKeyPressed{ "ControlAlt O", Name = "TyphonIncursion",
	function( triggerArgs )
		thread( TyphonIncursion, CurrentRun.CurrentRoom.Encounter,
		{
			DelayMin = 2.0, DelayMax = 9.0,
			CameraMotion = true,
			IncursionOptions =
			{
				TyphonIncursionTailImpale = { SpawnGroup = "TyphonTailIncursion" },
				TyphonIncursionArmSlam = { SpawnGroup = "TyphonArmIncursion" },
				TyphonIncursionArmFlick = { SpawnGroup = "TyphonArmIncursion" },
			},
		} )
	end
}

function SafeModeOn()
	SessionState.SafeMode = true
	SessionState.BlockHeroDeath = true
	SessionState.BlockHeroDamage = true
	SessionState.UnlimitedMana = true
	DebugPrint({ Text = "Unlimited health and mana ON" })
end

function SafeModeOff()
	SessionState.SafeMode = false
	SessionState.BlockHeroDeath = false
	SessionState.BlockHeroDamage = false
	SessionState.UnlimitedMana = false
	DebugPrint({ Text = "Unlimited health and mana OFF" })
end

OnKeyPressed{ "ControlShift X", Name = "DamageActiveUnit",
	function( triggerArgs )
		SacrificeHealth({ SacrificeHealthMin = 45, SacrificeHealthMax = 45, })
	end
}

OnKeyPressed{ "Control X", Name = "DestroyActiveUnit",
	function( triggerArgs )
		Kill( CurrentRun.Hero, triggerArgs )
	end
}

OnKeyPressed{ "Control H", Name = "RestoreHealthAndMana",
	function( triggerArgs )
		Heal( CurrentRun.Hero, { HealAmount = 9999 } )
		ManaDelta( 9999 )
	end
}

OnKeyPressed{ "ControlAlt I", Name = "AddMailboxItems",
	function( triggerArgs )
		for index = 1, 2 do
			local newItem = ShallowCopyTable( ScreenData.MailboxScreen.ItemCategories[1][index] )
			table.insert( ScreenData.MailboxScreen.ItemCategories[1], newItem )
		end
		ScreenData.MailboxScreen.MaxNonPriorityOffers = 5
		GenerateMailboxItems( { ForceRegenerate = true } )
	end
}

function ToggleConfigOption( name )
	local newValue = nil
	if GetConfigOptionValue({ Name = name }) then
		newValue = false
	else
		newValue = true
	end
	SetConfigOption({ Name = name, Value = newValue })
	DebugPrint({ Text = name.." = "..tostring(newValue), Priority = true })
	return newValue
end

OnKeyPressed{ "ControlShift P", Name = "Toggle AutoPlay",
	function( triggerArgs )

		if GetConfigOptionValue({ Name = "FastForward" }) then
			AutoPlayOff()
		else
			AutoPlayOn()
			SetConfigOption({ Name = "AutoPlayEnemiesOnly", Value = false })
		end

	end
}

OnKeyPressed{ "ControlAltShift P", Name = "Toggle AutoPlay Invulnerable",
	function( triggerArgs )

		if GetConfigOptionValue({ Name = "FastForward" }) then
			AutoPlayOff()
			SessionState.BlockHeroDeath = nil
		else
			AutoPlayOn()
			SetConfigOption({ Name = "AutoPlayEnemiesOnly", Value = false })
			SessionState.BlockHeroDeath = true
		end

	end
}

function AutoPlayOn()
	SetConfigOption({ Name = "FastForward", Value = true })
	SetConfigOption({ Name = "RequireFocusToUpdate", Value = false })
	SetConfigOption({ Name = "UseMouse", Value = false })
	UpdateConfigOptionCache()
end

function AutoPlayOff()
	SetConfigOption({ Name = "FastForward", Value = false })
	SetConfigOption({ Name = "UseAutoPlaySaveQueue", Value = false })
	SetConfigOption({ Name = "RequireFocusToUpdate", Value = true })
	SetConfigOption({ Name = "DamageMultiplier", Value = 1.0 })
	SetConfigOption({ Name = "DamageTakenMultiplier", Value = 1.0 })
	SetConfigOption({ Name = "AutoPlayEnemiesOnly", Value = false })
	UpdateConfigOptionCache()
end

function LiveFillInShopOptions()
	CurrentRun.CurrentRoom.Store = FillInShopOptions( { StoreData = StoreData.RoomShop , RoomName = CurrentRun.CurrentRoom.Name } )
end

OnKeyPressed{ "Control N", Name = "Force Next Room & Encounter",
	function( triggerArgs )
		ForceNextRoom = "G_Story01"

		-- Stomp any rooms already assigned to doors
		for doorId, door in pairs( MapState.OfferedExitDoors ) do
			local room = door.Room
			if room ~= nil then
				ForceNextEncounter = "Story_Narcissus_01"

				if ForceNextRoom ~= nil then
					DebugPrint({ Text = "ForceNextRoom = "..tostring(ForceNextRoom) })
				end

				local forcedRoomData = RoomData[ForceNextRoom]
				local forcedRoom = CreateRoom( forcedRoomData )
				AssignRoomToExitDoor( door, forcedRoom )
			end
		end
	end
}

function DebugSpawnEnemy( source, args )
	
	args = args or {}
	args.Name = args.Name
	local attributeNames =
	{
		"Blink",
		--"ExtraDamage",
		--"Fog",
		--"Frenzy",
		--"HeavyArmor",
		--"Hex",
		--"Homing",
		--"Massive",
		--"ManaDrain",
		--"Metallic",
		--"Miasma",
		--"Molten",
		--"Orbit",
		--"Radial",
		--"Rifts",
		--"Rooting",
		--"SpreadHitShields",
		--"StasisDeath",
		--"Unflinching",
		--"Vacuuming",
	}

	SessionState.LastDebugSpawnEnemyArgs = args

	local enemyData = EnemyData[args.Name]
	local newEnemy = DeepCopyTable( enemyData )

	if not args.Active then
		newEnemy.DisableAIWhenReady = true
	end

	if args.HealthBuffer ~= nil then
		newEnemy.HealthBuffer = args.HealthBuffer
	end
	newEnemy.BlocksLootInteraction = false

	local invaderSpawnPoint = nil
	if GetConfigOptionValue({ Name = "DebugEnemySpawnAtHero" }) and CurrentRun.Hero ~= nil then
		invaderSpawnPoint = CurrentRun.Hero.ObjectId
	else
		invaderSpawnPoint = args.SpawnPointId or SelectSpawnPoint( CurrentRun.CurrentRoom, newEnemy, {}, { CycleSpawnPoints = true } ) or CurrentRun.Hero.ObjectId
	end

	if newEnemy.IsUnitGroup then
		return SpawnUnitGroup( newEnemy, nil, nil, invaderSpawnPoint)
	end
	
	newEnemy.ObjectId = SpawnUnit({
			Name = enemyData.Name,
			Group = "Standing",
			DestinationId = invaderSpawnPoint, OffsetX = args.OffsetX, OffsetY = args.OffsetY })

	if GetConfigOptionValue({ Name = "DebugEnemySpawnIdle" }) then
		args.SkipAISetup = true
	end

	if GetConfigOptionValue({ Name = "DebugEnemySpawnWithAttribute" }) then
		CurrentRun.CurrentRoom.EliteAttributes[newEnemy.Name] = attributeNames
	else
		CurrentRun.CurrentRoom.EliteAttributes[newEnemy.Name] = nil
	end

	newEnemy.OccupyingSpawnPointId = invaderSpawnPoint
	SetupUnit( newEnemy, CurrentRun, args )

	if args.Health ~= nil then
		newEnemy.MaxHealth = args.Health
		newEnemy.Health = args.Health
	end

	if args.SkipAISetup then
		Track({ Ids = { newEnemy.ObjectId }, DestinationIds = { CurrentRun.Hero.ObjectId } })
	end

	return newEnemy
end


OnKeyPressed{ "Control R", Name = "Repeat Last Spawn",
	function( triggerArgs )
		if SessionState.LastDebugSpawnEnemyArgs ~= nil then
			DebugSpawnEnemy( nil, SessionState.LastDebugSpawnEnemyArgs )
		else
			DebugPrint({ Text = "No last spawn to repeat" })
		end
	end
}


OnKeyPressed{ "ControlShift E", Name = "Toggle DrawExtentsForPassable",
	function( triggerArgs )
		ToggleConfigOption( "DrawExtentsForPassable" )
	end
}

OnKeyPressed{ "Shift X", Name = "Spawn God Boon",
	function(triggerArgs)
		--local debugBoons = {GetRandomValue(GetEligibleLootNames())}
		local debugBoons = { "ZeusUpgrade" }
		for k, debugBoon in pairs( debugBoons ) do
			CreateLoot({ Name = debugBoon, OffsetX = k * 100 })
		end

	end
}

OnKeyPressed{ "Shift C", Name = "Spawn Consumable",
	function(triggerArgs)
	local consumableName = "LastStandDrop"
	local spawnPoint = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints" })
	local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = spawnPoint, Group = "Standing", })
	local consumable = CreateConsumableItem( consumableId, consumableName, 0, { RunProgressUpgradeEligible = true } )
		MapState.RoomRequiredObjects[consumableId] = consumable
	end
}

OnKeyPressed{ "Alt R", Name = "Add Rerolls & TalentPoints", Safe = true,
	function(triggerArgs)
		AddRerolls( nil, { Amount = 99 } )
		CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints + 9
	end
}

function DebugUnlockMetaUpgrades( source, args )
	args = args or {}
	for i, upgradeName in ipairs( args.UpgradeNames ) do
		GameState.MetaUpgradeState[upgradeName].Equipped = true
	end
	EquipMetaUpgrades( CurrentRun.Hero, { SkipNewTraitHighlight = true } )
end

OnKeyPressed{ "Alt M", Name = "Spawn Money", Safe = true,
	function(triggerArgs)
		thread( GushMoney, { Amount = 50, LocationId = CurrentRun.Hero.ObjectId, Radius = 100, Source = "DebugSpawnMoney" } )
	end
}

OnKeyPressed{ "ControlAltShift C", Name = "Fully Unlock GhostAdmin",
	function(triggerArgs)
		for cosmeticName, cosmeticData in pairs( WorldUpgradeData ) do
			cosmeticData.GameStateRequirements = nil
		end
		CurrentRun.ViewableWorldUpgrades = {}
		CurrentRun.AllowedRevealsThisRun = 9999
		CurrentRun.ScreenViewRecord.WorldUpgradeScreen_Critical = 0
		CurrentRun.ScreenViewRecord.WorldUpgradeScreen_Repeatable = 0
		CurrentRun.ScreenViewRecord.CosmeticsShop_Tent = 0
		CurrentRun.ScreenViewRecord.CosmeticsShop_Main = 0
		CurrentRun.ScreenViewRecord.CosmeticsShop_Taverna = 0
		CurrentRun.ScreenViewRecord.CosmeticsShop_PreRun = 0
	end
}

OnKeyPressed{ "ControlShift G", Name = "Dump WorldUpgrade Costs",
	function(triggerArgs)
		local costs = {}
		for cosmeticName, cosmeticData in pairs( WorldUpgradeData ) do
			if cosmeticData.Cost ~= nil then
				for resource, amount in pairs( cosmeticData.Cost ) do
					costs[resource] = (costs[resource] or 0) + amount
				end
			end
		end
		for weaponName, weaponData in pairs( WeaponShopItemData ) do
			if weaponData.Cost ~= nil then
				for resource, amount in pairs( weaponData.Cost ) do
					costs[resource] = (costs[resource] or 0) + amount
				end
			end
		end
		local costString = ""
		for resource, total in pairs( costs ) do
			costString = costString.."\n"..resource..": "..total
		end
		costString = costString.."\n"
		DebugPrint({ Text = "WORLDUPGRADE COST DUMP: "..costString })
	end
}

OnKeyPressed{ "ControlAltShift L", Name = "Unlock Surface",
	function(triggerArgs)
		AddWorldUpgrade("WorldUpgradeAltRunDoor")
		AddWorldUpgrade("WorldUpgradeSurfacePenaltyCure")
	end
}

OnKeyPressed{ "ControlAlt B", Name = "Add Badge Rank",
	function(triggerArgs)
		if (GameState.BadgeRank or 0) < #BadgeOrderData then
			GameState.BadgeRank = (GameState.BadgeRank or 0) + 1
		end
		DebugPrint({ Text = "GameState.BadgeRank = "..GameState.BadgeRank, Priority = true })
	end
}

OnKeyPressed{ "ControlAlt E", Name = "Spawn Test Enemy",
	function(triggerArgs)

		if GetConfigOptionValue({ Name = "EditingMode" }) then
			return
		end

		--ConfigOptionCache.LogCombatMultipliers = true
		OpenDebugEnemySpawnScreen()
		
		--DebugSpawnEnemy( nil, { Name = "Brawler", Health = 2000, Active = true, SpawnPointId = CurrentRun.Hero.ObjectId } )
	end
}

function ToggleDebugEnemySpawnIdle( screen, button )
	if ToggleConfigOption( "DebugEnemySpawnIdle" ) then
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_on" })
	else
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end
end

function ToggleDebugEnemySpawnAtHero( screen, button )
	if ToggleConfigOption( "DebugEnemySpawnAtHero" ) then
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_on" })
	else
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end
end

function ToggleDebugEnemySpawnWithAttribute( screen, button )
	if ToggleConfigOption( "DebugEnemySpawnWithAttribute" ) then
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_on" })
	else
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end
end

function DebugEnemySpawnScreenClose( screen, button )
	SaveProfile({ })
	CloseScreenButton( screen, button )
end

function OpenDebugEnemySpawnScreen()

	local screen = DeepCopyTable( ScreenData.DebugEnemySpawn )

	if IsScreenOpen( screen.Name ) then
		return
	end
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	local components = screen.Components
	
	local buttonLocationX = screen.PageStartX
	local buttonLocationY = 150

	if SessionMapState.DebugEnemySpawnBiomeIndex == nil then
		SessionMapState.DebugEnemySpawnBiomeIndex = 1
		local currentBiome = false
		for i, page in ipairs( screen.Pages ) do
			for biomeIndex, biomeName in ipairs( page.Biomes ) do
				if CurrentRun.CurrentRoom.RoomSetName == page.RoomSetName or stringends( biomeName, CurrentRun.CurrentRoom.RoomSetName ) then
					SessionMapState.DebugEnemySpawnBiomeIndex = i
					break
				end
			end
		end
	end

	for i, page in ipairs( screen.Pages ) do
		local pageButton = CreateScreenComponent({ Name = "DebugEnemySpawnButton",
			X = buttonLocationX,
			Y = buttonLocationY,
			Scale = 1.0,
			Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			Group = "Combat_Menu" })
		pageButton.OnPressedFunctionName = "DebugEnemySpawnPageButton"
		pageButton.Page = page
		page.Index = i
		screen.Components["PageButton"..page.Name] = pageButton
		local pageTextColor = Color.White
		
		SetThingProperty({ Property = "AddColor", Value = "true", DestinationId = pageButton.Id })
		if SessionMapState.DebugEnemySpawnBiomeIndex == i then
			TeleportCursor({ DestinationId = pageButton.Id, ForceUseCheck = true })
			SetColor({ Id = pageButton.Id, Color = screen.PageHighlightColor })
		else
			SetColor({ Id = pageButton.Id, Color = Color.Black })
		end

		CreateTextBox({ Id = pageButton.Id,
			RawText = page.Name,
			FontSize = 24,
			Color = pageTextColor,
			Font = "LatoBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center",
			FadeOpacity = 1.0,
		})
		CreateTextBox({ Id = pageButton.Id,
			Text = page.Name.."_Short",
			FontSize = 20,
			OffsetX = 0,
			OffsetY = 30,
			Color = Color.Yellow,
			Font = "LatoMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center"
		})
		if i % screen.PagesPerRow == 0 then
			buttonLocationY = buttonLocationY + screen.PageSpacingY
			buttonLocationX = screen.PageStartX
		else
			buttonLocationX = buttonLocationX + screen.PageSpacingX
		end
	end
	CreateDebugEnemySpawnPage( screen, screen.Pages[SessionMapState.DebugEnemySpawnBiomeIndex] )

	if GetConfigOptionValue({ Name = "DebugEnemySpawnIdle" }) then
		SetAnimation({ DestinationId = components.ToggleSpawnIdle.Id, Name = "GUI\\Shell\\settings_toggle_on" })
	else
		SetAnimation({ DestinationId = components.ToggleSpawnIdle.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end
	if GetConfigOptionValue({ Name = "DebugEnemySpawnAtHero" }) then
		SetAnimation({ DestinationId = components.ToggleSpawnAtHero.Id, Name = "GUI\\Shell\\settings_toggle_on" })
	else
		SetAnimation({ DestinationId = components.ToggleSpawnAtHero.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end
	if GetConfigOptionValue({ Name = "DebugEnemySpawnWithAttribute" }) then
		SetAnimation({ DestinationId = components.ToggleSpawnWithAttribute.Id, Name = "GUI\\Shell\\settings_toggle_on" })
	else
		SetAnimation({ DestinationId = components.ToggleSpawnWithAttribute.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen
end

function DebugEnemySpawnPageButton( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
	--Flash({ Id = button.Id, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, Duration = 0.1 })
	for i, page in ipairs( screen.Pages ) do
		local buttonId = screen.Components["PageButton"..page.Name].Id
		SetColor({ Id = buttonId, Color = Color.Black })
	end
	SetColor({ Id = button.Id, Color = screen.PageHighlightColor })
	CreateDebugEnemySpawnPage( screen, button.Page )
end

function CreateDebugEnemySpawnPage( screen, page )

	Destroy({ Ids = screen.PageIds })
	screen.PageIds = {}
	SessionMapState.DebugEnemySpawnBiomeIndex = page.Index

	local buttonLocationY = 420

	local biomeName = GetFirstValue( page.Biomes ) or ""
	local currentBiome = false
	if biomeName ~= nil and stringends( biomeName, CurrentRun.CurrentRoom.RoomSetName ) then
		currentBiome = true
	end

	local buttonLocationX = 110
	local buttonStartX = buttonLocationX + 150
	buttonLocationX = buttonStartX

	local dedupedEnemies = {}
	if EnemySets[biomeName] ~= nil then
		for enemyIndex, enemyName in ipairs( EnemySets[biomeName] ) do
			if not Contains( dedupedEnemies, enemyName ) then
				table.insert( dedupedEnemies, enemyName )
			end
		end
	end
	if page.ManualEnemies ~= nil then
		for enemyIndex, enemyName in ipairs( page.ManualEnemies ) do
			table.insert( dedupedEnemies, enemyName )
		end
	end

	for enemyIndex, enemyName in ipairs( dedupedEnemies ) do
		local spawnButton = CreateScreenComponent({ Name = "DebugEnemySpawnButton",
			X = buttonLocationX,
			Y = buttonLocationY,
			Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
		screen.Components["Spawn"..biomeName..enemyIndex..enemyName] = spawnButton
		table.insert( screen.PageIds, spawnButton.Id )
		spawnButton.OnPressedFunctionName = "DebugEnemySpawnButton"
		spawnButton.EnemyName = enemyName
		local enemyNameCodex = GetDisplayName({ Text = enemyName })
		CreateTextBox({ Id = spawnButton.Id,
			RawText = enemyName,
			FontSize = 20,
			OffsetY = -10,
			Color = Color.White,
			Font = "LatoMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center",
			FadeOpacity = 1.0,
		})
		CreateTextBox({ Id = spawnButton.Id,
			Text = enemyName,
			FontSize = 20,
			OffsetY = 26,
			Color = Color.Yellow,
			Font = "LatoMedium",
			Justification = "Center",
			FadeOpacity = 1.0,
		})
		if enemyIndex % screen.ButtonsPerRow == 0 then
			buttonLocationX = buttonStartX
			buttonLocationY = buttonLocationY + screen.SpacingY
		else
			buttonLocationX = buttonLocationX + screen.SpacingX
		end
	end

end

function DebugEnemySpawnButton( screen, button )
	thread( DebugSpawnEnemy, screen, { Name = button.EnemyName, Active = true } )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
	Flash({ Id = button.Id, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, Duration = 0.1 })
end


OnKeyPressed{ "Alt Y", Name = "LogCombatMultipliers",
	function(triggerArgs)
		ConfigOptionCache.LogCombatMultipliers = true
	end
}

OnKeyPressed{ "ControlAlt R", Name = "Reload All Traits",
	function(triggerArgs)
		ReloadAllTraits()
	end
}

OnKeyPressed{ "Alt T", Name = "Add Traits",
	function(triggerArgs)
		-- If you want a different equip set than Amir's add it to the above data table
		local debugEquipData = UserDebugEquip[GetUsername({ })] or UserDebugEquip.Amir
		if debugEquipData.Weapon ~= nil then
			EquipPlayerWeapon( WeaponData[debugEquipData.Weapon] )
		end
		if debugEquipData.Traits ~= nil then
			for i, name in pairs( debugEquipData.Traits ) do
				AddTraitToHero( { FromLoot = true, TraitData = GetProcessedTraitData( { Unit = CurrentRun.Hero, TraitName = name, Rarity = "Rare" } ) } )
			end
		end
	end
}

OnKeyPressed{ "Alt B", Name = "Set Summon Trait Enemy",
	function(triggerArgs)
		AddTraitToHero( { FromLoot = true, TraitData = GetProcessedTraitData( { Unit = CurrentRun.Hero, TraitName = "SpellSummonTrait", Rarity = "Rare" } ) } )
		ChargeSpell( -1000, {Force = true} )
		FrameState.RequestUpdateHealthUI = true
		thread( UpdateManaMeterUI, triggerArgs )
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
		CurrentRun.CurrentRoom.SummonEnemyName = "Mage2"
	end
}

OnKeyPressed{ "Alt K", Name = "Clear Encounter",
	function(triggerArgs)
		if GetConfigOptionValue({ Name = "FastForward" }) then
			AutoPlayOff()
			SetConfigOption({ Name = "AutoPlayEnemiesOnly", Value = false })
		else
			AutoPlayOn()
			SetConfigOption({ Name = "AutoPlayEnemiesOnly", Value = true })
			SetConfigOption({ Name = "DamageMultiplier", Value = 99.0 })
			SetConfigOption({ Name = "DamageTakenMultiplier", Value = 0.0 })
			UpdateConfigOptionCache()
		end
	end
}

OnKeyPressed{ "ControlAltShift K", Name = "Max Cheat Damage Multiplier",
	function(triggerArgs)
		SetConfigOption({ Name = "DamageMultiplier", Value = 100.0 })
		UpdateConfigOptionCache()
	end
}

OnKeyPressed{ "ControlAltShift J", Name = "Reset Cheat Damage Multiplier",
	function(triggerArgs)
		SetConfigOption({ Name = "DamageMultiplier", Value = 1.0 })
		UpdateConfigOptionCache()
	end
}

OnKeyPressed{ "Control M", Name = "Add Resources", Safe = true,
	function( triggerArgs )
		if HasThread( "ResourceCheat" ) then
			return
		end
		-- skipping MysteryResource, the last item in ResourceDisplayOrderData
		for i = 1, (#ResourceDisplayOrderData - 1) do
			AddResource( ResourceDisplayOrderData[i], 99999, "Debug" )
			wait( 0.01, "ResourceCheat" )
		end
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	end
}

OnKeyPressed{ "Alt U", Name = "Boost Life and Mana",
	function( triggerArgs )
		CurrentRun.Hero.MaxHealth = CurrentRun.Hero.MaxHealth + 100
		CurrentRun.Hero.Health = CurrentRun.Hero.Health + 100
		CurrentRun.Hero.MaxMana = CurrentRun.Hero.MaxMana + 100
		CurrentRun.Hero.Mana = CurrentRun.Hero.Mana + 100
		
		ChargeSpell( -1000, {Force = true} )
		FrameState.RequestUpdateHealthUI = true
		thread( UpdateManaMeterUI, triggerArgs )
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	end
}

OnKeyPressed{ "ControlAlt T", Name = "DebugConversations", Safe = true,
	function(triggerArgs)
		OpenDebugConversationScreen()
	end
}

OnKeyPressed{ "ControlShift M", Name = "Activate Extreme Measures",
	function(triggerArgs)
		GameState.ShrineUpgrades.BossDifficultyShrineUpgrade = 4
	end
}

function OpenDebugConversationScreen()

	local screen = DeepCopyTable( ScreenData.DebugConversations )

	if IsScreenOpen( screen.Name ) then
		return
	end

	SessionState.BlockSpawns = true
	RemoveInputBlock({ All = true })

	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	local components = screen.Components
	-- Global Stats
	CreateTextBox({ Id = components.BackgroundDim.Id, Text = "Current Run: "..(GetCompletedRuns() + 1),
		FontSize = 20, OffsetX = -950, OffsetY = -516, Color = Color.LightGray, Font = "LatoMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Left",
	})
	if GameState.IllegalConversationModification then
		CreateTextBox({ Id = components.BackgroundDim.Id, Text = "IllegalConversationModification = true",
			FontSize = 20, OffsetX = -950, OffsetY = -490, Color = Color.Red, Font = "LatoMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Left",
		})
	end

	local buttonLocationX = screen.ButtonStartX
	local buttonLocationY = screen.ButtonStartY
	local count = 0
	if CurrentRun.Hero.IsDead then
		for k, unitName in ipairs( NarrativeData.ConversationOrder ) do
			local textColor = Color.White
			local source = EnemyData[unitName]
			if source == nil then
				DebugAssert({ Condition = false, Text = "unitName "..unitName.." does not exist" })
			end
			for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if enemy.Name == unitName then
					source = enemy
					textColor = Color.Yellow
					break
				end
			end
			if not IsEmpty( source.InteractTextLineSets ) then
				local button = CreateScreenComponent({ Name = "ButtonGhostAdminTab", Group = screen.ComponentData.DefaultGroup,
					X = buttonLocationX + (screen.SpacingX * (count % screen.ColumnsPerRow)), Y = buttonLocationY + (screen.SpacingY * math.floor(count / screen.ColumnsPerRow)),
					ScaleX = screen.ButtonScaleX, 
					ScaleY = screen.ButtonScaleY, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU" })
				screen.Components["Spawn"..unitName] = button
				button.OnPressedFunctionName = "DebugConversationsEnemyButton"
				button.Source = source
				CreateTextBox({ Id = button.Id,
					Text = unitName,
					FontSize = 17,
					Color = textColor,
					Font = "LatoMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
					Justification = "Center"
				})
				count = count + 1
			end
		end
	else
		local allSources = MergeTables( MapState.RoomRequiredObjects, ActiveEnemies )
		for objectId, object in pairs( allSources ) do
			if not IsEmpty( object.BossIntroTextLineSets ) or not IsEmpty( object.InteractTextLineSets ) then
				local textColor = Color.Yellow
				local button = CreateScreenComponent({ Name = "ButtonGhostAdminTab", Group = screen.ComponentData.DefaultGroup,
					X = buttonLocationX + (screen.SpacingX * (count % screen.ColumnsPerRow)), Y = buttonLocationY + (screen.SpacingY * math.floor(count / screen.ColumnsPerRow)),
					Scale = 1.0, ScaleY = screen.ButtonScaleY, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU" })
				screen.Components["Spawn"..object.Name] = button
				button.OnPressedFunctionName = "DebugConversationsEnemyButton"
				button.Source = object
				CreateTextBox({ Id = button.Id,
					Text = object.Name,
					FontSize = 20,
					Color = textColor,
					Font = "LatoMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
					Justification = "Center"
				})
				count = count + 1
			end
		end
	end

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function DebugConversationsEnemyButton( screen, button )
	
	screen.ButtonLocationX = screen.ListStartX
	screen.ButtonLocationY = screen.ListStartY
	
	local source = button.Source
	local enemyData = button.Source
	local count = 0
	if screen.ContentListButtons ~= nil then
	end
	local toggleButtonIds = GetAllKeys( screen.ContentListButtons )
	DestroyTextBox({ Ids = toggleButtonIds })
	Destroy({ Ids = toggleButtonIds })
	screen.ContentListButtons = {}
	screen.ColumnOffset = 0
	screen.NumColumns = 1

	local textLineSet = enemyData.InteractTextLineSets or enemyData.BossIntroTextLineSets
	local textLineSetPriorities = GetNarrativeDataValue( enemyData, enemyData.InteractTextLinePriorities or "InteractTextLinePriorities" ) or GetNarrativeDataValue( enemyData, "BossIntroTextLinePriorities" )

	local allConversationKeys = {}
	local priorities = {}

	if textLineSetPriorities ~= nil then
		for k, priority in ipairs( textLineSetPriorities ) do
			if type(priority) == "table" then
				for j, textLinesName in ipairs( priority ) do
					priorities[textLinesName] = true
					local textLinesData = textLineSet[textLinesName]
					allConversationKeys[textLinesData.Name] = true
					SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count, { OffsetX = screen.OffsetXBucket } )
					screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
					if screen.ButtonLocationY > screen.ListMaxY then
						screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
						screen.ButtonLocationY = screen.ListStartY
						screen.NumColumns = screen.NumColumns + 1
					end
					count = count + 1
				end
				screen.ButtonLocationY = screen.ButtonLocationY + (screen.ListSpacingY - screen.ListSpacingYBucket)
			else
				priorities[priority] = true
				local textLinesData = textLineSet[priority]
				allConversationKeys[textLinesData.Name] = true
				SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
				screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingY
				if screen.ButtonLocationY > screen.ListMaxY then
					screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
					screen.ButtonLocationY = screen.ListStartY
					screen.NumColumns = screen.NumColumns + 1
				end
				count = count + 1
			end
		end
	end

	local oneTimeConversations = {}
	local repeatableConversations = {}

	for conversationName, conversationData in pairs( textLineSet ) do
		if not priorities[conversationName] then
			if conversationData.PlayOnce then
				table.insert( oneTimeConversations, conversationData.Name )				
			else
				table.insert( repeatableConversations, conversationData.Name )
			end
		end
	end

	table.sort( repeatableConversations )
	for k, textLinesName in ipairs( repeatableConversations ) do
		local textLinesData = textLineSet[textLinesName]
		allConversationKeys[textLinesData.Name] = true
		SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count, { OffsetX = screen.OffsetXBucket } )
		screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
		if screen.ButtonLocationY > screen.ListMaxY then
			screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
			screen.ButtonLocationY = screen.ListStartY
			screen.NumColumns = screen.NumColumns + 1
		end
		count = count + 1
	end

	-- Gifts

	textLineSet = source.GiftTextLineSets
	textLineSetPriorities = GetNarrativeDataValue( enemyData, "GiftTextLinePriorities" )

	priorities = {}

	screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
	screen.ButtonLocationY = screen.ListStartY
	screen.NumColumns = screen.NumColumns + 1

	if textLineSetPriorities ~= nil then
		for k, priority in ipairs( textLineSetPriorities ) do
			if type(priority) == "table" then
				for j, textLinesName in ipairs( priority ) do
					priorities[textLinesName] = true
					local textLinesData = textLineSet[textLinesName]
					allConversationKeys[textLinesData.Name] = true
					SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count, { OffsetX = screen.OffsetXBucket } )
					screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
					if screen.ButtonLocationY > screen.ListMaxY then
						screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
						screen.ButtonLocationY = screen.ListStartY
						screen.NumColumns = screen.NumColumns + 1
					end
					count = count + 1
				end
			else
				priorities[priority] = true
				local textLinesData = textLineSet[priority]
				allConversationKeys[textLinesData.Name] = true
				SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
				screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
				if screen.ButtonLocationY > screen.ListMaxY then
					screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
					screen.ButtonLocationY = screen.ListStartY
					screen.NumColumns = screen.NumColumns + 1
				end
				count = count + 1
			end
		end
	end

	oneTimeConversations = {}
	repeatableConversations = {}

	if textLineSet ~= nil then
		for conversationName, conversationData in pairs( textLineSet ) do
			if not priorities[conversationName] then
				if conversationData.PlayOnce then
					table.insert( oneTimeConversations, conversationData.Name )				
				else
					table.insert( repeatableConversations, conversationData.Name )
				end
			end
		end
	end

	screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
	screen.ButtonLocationY = screen.ListStartY
	count = 0

	table.sort( oneTimeConversations )
	for k, textLinesName in ipairs( oneTimeConversations ) do
		local textLinesData = textLineSet[textLinesName]
		allConversationKeys[textLinesData.Name] = true
		SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
		screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
		if screen.ButtonLocationY > screen.ListMaxY then
			screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
			screen.ButtonLocationY = screen.ListStartY
			screen.NumColumns = screen.NumColumns + 1
		end
		count = count + 1
	end

	screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
	screen.ButtonLocationY = screen.ListStartY
	count = 0

	table.sort( repeatableConversations )
	for k, textLinesName in ipairs( repeatableConversations ) do
		local textLinesData = textLineSet[textLinesName]
		allConversationKeys[textLinesData.Name] = true
		SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
		screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
		if screen.ButtonLocationY > screen.ListMaxY then
			screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
			screen.ButtonLocationY = screen.ListStartY
			screen.NumColumns = screen.NumColumns + 1
		end
		count = count + 1
	end

	-- Print conversations in descending order from most recent run
	for runIndex = #GameState.RunHistory + 1, 1, -1 do
		local prevRun = GameState.RunHistory[runIndex] or CurrentRun
		if prevRun.TextLinesRecord == nil then
			break
		end
		for conversationName, v in pairs( prevRun.TextLinesRecord ) do
			if allConversationKeys[conversationName] then
				DebugPrint({ Text = "Run "..runIndex..": "..conversationName })
			end
		end
	end

	DebugConversationsUpdateVisibility( screen, button )
	
end

function SetupDebugConversationsTextLinesButton( screen, unitButton, textLinesData, count, args )

	if textLinesData.Partner ~= nil and textLinesData[1] == nil then
		-- Actual data is on Partner
		local partnerData = EnemyData[textLinesData.Partner]
		if textLinesData.PartnerVariant ~= nil then
			partnerData = NPCVariantData[textLinesData.PartnerVariant]
		end
		textLinesData = partnerData.InteractTextLineSets[textLinesData.Name]
		--DebugPrint({ Text = "PartnerData = ".. textLinesData.Name })
	end

	args = args or {}
	local button = CreateScreenComponent({ Name = "ToggleButton", X = screen.ButtonLocationX, Y = screen.ButtonLocationY,
			Scale = 0.5, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = screen.ComponentData.DefaultGroup })
	screen.ContentListButtons[button.Id] = button
	screen.Components["TextLines"..textLinesData.Name] = button
	button.TooltipId = screen.Components.TooltipBacking.Id
	button.OnPressedFunctionName = "DebugConversationsTextLinesButton"
	button.OnMouseOverFunctionName = "DebugConversationMouseOver"
	button.OnMouseOffFunctionName = "DebugConversationMouseOff"
	button.LocationX = screen.ButtonLocationX
	button.LocationY = screen.ButtonLocationY
	button.ColumnNum = screen.NumColumns
	AttachLua({ Id = button.Id, Table = button })
	button.TextLinesName = textLinesData.Name
	button.Source = unitButton.Source
	local color = Color.Red
	if GameState.TextLinesRecord[button.TextLinesName] then
		color = Color.Cyan
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_on" })
		local lastRunOccured = GetLastRunTextLinesOccured( textLinesData.Name )
		local color = Color.White
		if lastRunOccured == TableLength( GameState.RunHistory ) + 1 then
			-- This run
			color = Color.Yellow
		end
		CreateTextBox({ Id = button.Id,
			Text = lastRunOccured,
			FontSize = 20,
			Color = color,
			Font = "LatoMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Right", OffsetX = -20,
			FadeOpacity = 1.0,
		})
	else
		SetAnimation({ DestinationId = button.Id, Name = "GUI\\Shell\\settings_toggle_off" })
	end

	if textLinesData.GameStateRequirements ~= nil then
		DebugTestAllRequirements( textLinesData, textLinesData.GameStateRequirements )
	end

	local requirementsArgs = {}
	if IsTextLineEligible( CurrentRun, button.Source, textLinesData, nil, nil, requirementsArgs ) then
		color = Color.LimeGreen
	else
		button.FirstFailedRequirement = requirementsArgs.FirstFailedRequirement
	end
	--local filter = GetConfigOptionValue({ Name = "ScriptDebugFilter" })
	if textLinesData.DebugHighlight then --or string.find( button.TextLinesName, filter ) then
		color = Color.DeepPink
	end

	local typeIds = GetIdsByType({ Name = button.Source.Name })
	for k, id in pairs( typeIds ) do
		local enemy = ActiveEnemies[id]
		if enemy ~= nil and enemy.NextInteractLines ~= nil and enemy.NextInteractLines.Name == textLinesData.Name then
			color = Color.Yellow
			screen.ActiveConversationButton = button
		end
	end

	CreateTextBox({ Id = button.Id,
		Text = textLinesData.Name,
		FontSize = 19,
		Color = color,
		Font = "LatoMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left", OffsetX = 20,
		FadeOpacity = 1.0,
	})
end

function DebugConversationsTextLinesButton( screen, button )

	local source = button.Source
	if source ~= nil then
		-- Assign the conversation immediately
		local textLinesData = nil
		if source.BossIntroTextLineSets ~= nil and source.BossIntroTextLineSets[button.TextLinesName] then
			textLinesData = source.BossIntroTextLineSets[button.TextLinesName]
			source.QueuedBossIntroTextLines = nil
			if NarrativeData[source.Name] ~= nil then
				NarrativeData[source.Name].BossIntroTextLinePriorities = { button.TextLinesName }
			end
		else
			textLinesData = source.InteractTextLineSets[button.TextLinesName] or source.GiftTextLineSets[button.TextLinesName]
		end
		textLinesData.Force = true
		source.NextInteractLines = textLinesData
		SetNextInteractLines( source, source.NextInteractLines )
		GameState.IllegalConversationModification = true
		DebugPrint({ Text = "Illegal conversation modification made.  Saving disabled." })
		ModifyTextBox({ Id = button.Id, AffectText = textLinesData.Name, Color = Color.Yellow })
		UseableOn({ Id = source.ObjectId })
		if screen.ActiveConversationButton ~= nil then
			local prevTextLinesData = source.InteractTextLineSets[screen.ActiveConversationButton.TextLinesName] or source.GiftTextLineSets[screen.ActiveConversationButton.TextLinesName]
			if prevTextLinesData ~= nil then
				prevTextLinesData.Force = false
				local color = Color.Red
				if IsTextLineEligible( CurrentRun, button.Source, prevTextLinesData, nil, nil, nil ) then
					color = Color.LimeGreen
				end
				ModifyTextBox({ Id = screen.ActiveConversationButton.Id, AffectText = prevTextLinesData.Name, Color = color })
			end
		end
		screen.ActiveConversationButton = button
	end

end

function DebugConversationMouseOver( button )
	if button.FirstFailedRequirement ~= nil then
		if button.LocationX < 1400 then
			Teleport({ Id = button.TooltipId, DestinationId = button.Id, OffsetX = 200, OffsetY = -60 })
		else
			Teleport({ Id = button.TooltipId, DestinationId = button.Id, OffsetX = -200, OffsetY = -60 })
		end
		
		SetAlpha({ Id = button.TooltipId, Fraction = 1.0 })
		CreateTextBox({ Id = button.TooltipId,
			Text = "Failed: "..button.FirstFailedRequirement,
			FontSize = 15,
			Color = Color.Pink,
			Font = "MonospaceTypewriterBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 2},
			Justification = "Center",
		})
	end
	ClipboardText = button.TextLinesName
end

function DebugConversationMouseOff( button )
	if button.FirstFailedRequirement ~= nil then
		SetAlpha({ Id = button.TooltipId, Fraction = 0.0 })
		DestroyTextBox({ Id = button.TooltipId, AffectText = "Failed: "..button.FirstFailedRequirement })
	end
	ClipboardText = nil
end

function DebugConversationsPageLeft( screen, button )
	if screen.ColumnOffset <= 0 then
		return
	end
	screen.ColumnOffset = screen.ColumnOffset - screen.ListColumnsPerScreen
	for id, button in pairs( screen.ContentListButtons ) do
		button.LocationX = button.LocationX + (screen.ListSpacingX * screen.ListColumnsPerScreen)
		Teleport({ Id = id, OffsetX = button.LocationX, OffsetY = button.LocationY })
	end
	DebugConversationsUpdateVisibility( screen, button )
end

function DebugConversationsPageRight( screen, button )
	if screen.ColumnOffset + screen.ListColumnsPerScreen >= screen.NumColumns then
		return
	end
	screen.ColumnOffset = screen.ColumnOffset + screen.ListColumnsPerScreen
	for id, button in pairs( screen.ContentListButtons ) do
		button.LocationX = button.LocationX - (screen.ListSpacingX * screen.ListColumnsPerScreen)
		Teleport({ Id = id, OffsetX = button.LocationX, OffsetY = button.LocationY })
	end
	DebugConversationsUpdateVisibility( screen, button )
end

function DebugConversationsUpdateVisibility( screen, button )
	if screen.ColumnOffset <= 0 then
		SetAlpha({ Id = screen.Components.PageLeft.Id, Fraction = 0.0, Duration = 0.1 })
	else
		SetAlpha({ Id = screen.Components.PageLeft.Id, Fraction = 1.0, Duration = 0.1 })
	end
	if screen.ColumnOffset >= screen.NumColumns - screen.ListColumnsPerScreen then
		SetAlpha({ Id = screen.Components.PageRight.Id, Fraction = 0.0, Duration = 0.1 })
	else
		SetAlpha({ Id = screen.Components.PageRight.Id, Fraction = 1.0, Duration = 0.1 })
	end
	for id, button in pairs( screen.ContentListButtons ) do
		if button.ColumnNum <= screen.ColumnOffset then
			SetAlpha({ Id = id, Fraction = 0.0, Duration = 0.1 })
		else
			SetAlpha({ Id = id, Fraction = 1.0, Duration = 0.1 })
		end
	end
end

function DebugConversationsClose( screen, button )
	CloseScreenButton( screen, button )
	SessionState.BlockSpawns = false
	notify( "BlockSpawnsOff" )
end

OnKeyPressed{ "ControlShift Y", Name = "Show RunClearScreen",
	function( triggerArgs )
		OpenRunClearScreen()
	end
}

OnKeyPressed{ "ControlShift T", Name = "Show Epilogue Interstitial",
	function( triggerArgs )
		PostEpiloguePresentation( nil , { SkipInitialWait = true, Title = "EpilogueReached", Stinger = "/Music/IrisVictoryStingerSMALL" } )
		--DisplayTrueEndingInfoBanner( nil, { Title = "TrueEndingReached", Stinger = "/Music/IrisVictoryStingerLARGE" })
		--wait( 1.0 )
		--DisplayTrueEndingInfoBanner( nil, { Title = "EpilogueReached", Stinger = "/Music/IrisVictoryStingerSMALL" })
	end
}

OnKeyPressed{ "Alt P", Name = "HubTimeTick",
	function( triggerArgs )
		if not CurrentRun.Hero.IsDead then
			return
		end
		thread( GardenTimeTick, { Ticks = 5, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.1 } )
		thread( CookTimeTick, { Ticks = 8, UpdatePresentation = true, TickInterval = 0.2, } )
		thread( MailboxTimeTick, { Ticks = 21, UpdatePresentation = true, TickInterval = 0.03, } )
	end
}

function CreateDevSaveName( currentRun, args )
	-- Only legal Windows file path characters allowed
	-- Ordering is now such that sorting by name sorts by 'deepest' saves
	local name = ""
	name = name.."Run "..(GetCompletedRuns() + 1)..", "
	if args ~= nil and args.StartNextMap ~= nil then
		name = name.."Dead, "..args.StartNextMap
		if args.PostDeath then
			if currentRun.ActiveBounty then
				name = name.." (BountyRevive)"
			-- @ ending
			elseif currentRun.PlayedTrueEnding then
				name = name.." (PostCredits)"
			else
				name = name.." (TentRevive)"
			end
		end
	else
		name = name.."Depth "..GetRunDepth( currentRun )..", "
		name = name..currentRun.CurrentRoom.Name..", "
		name = name..currentRun.CurrentRoom.Encounter.Name
		if currentRun.CurrentRoom.TimesVisited ~= nil and currentRun.CurrentRoom.TimesVisited > 1 then
			name = name.." Visit "..currentRun.CurrentRoom.TimesVisited
		elseif args ~= nil and args.PostReward then
			name = name.." (PostReward)"
		elseif currentRun.CurrentRoom.ChosenRewardType ~= nil then
			name = name.." ("..currentRun.CurrentRoom.ChosenRewardType
			if currentRun.CurrentRoom.ForceLootName ~= nil then
				name = name.." - "..currentRun.CurrentRoom.ForceLootName
			end
			name = name..")"
		end
	end
	return name
end

function OnHotLoadXML()
	thread( PostHotloadXML )
end

function PostHotloadXML()
	if CurrentRun ~= nil then
		HideCombatUI( "HotloadXML" )
		ShowCombatUI( "HotloadXML" )
	end
end

function OnHotLoadLua( fileName )

	--DebugPrint({ Text = "fileName = "..fileName })

	if SetupRunData ~= nil then
		SetupRunData( { IgnoreValidation = true } )
	end

	--[[
	if ActiveScreens ~= nil then
		for screenName, screen in pairs( ActiveScreens ) do
			local screenData = ScreenData[screenName]
			if screenData ~= nil then
				OverwritePrimitiveTableKeys( screen, screenData )
				if screenData.ComponentData ~= nil then
					DestroyScreenDataComponents( screen )
					screen.ComponentData = DeepCopyTable( screenData.ComponentData )
					CreateScreenFromData( screen, screen.ComponentData )
				end
				if screen.Components ~= nil then
					for componentName, component in pairs( screen.Components ) do
						if component.Format ~= nil then
							DestroyTextBox({ Id = component.Id })
							OverwriteTableKeys( component.Format, screenData[component.FormatName] )
							CreateTextBox( component.Format )
						end
					end
				end
			end
		end
	end
	--]]

	if HotLoadInfo ~= nil then
		if HotLoadInfo.CurrentTextLines ~= nil then
			HotLoadInfo.CurrentTextLines = TextLinesCache[HotLoadInfo.CurrentTextLines.Name]
		end

		if HotLoadInfo.TextBoxCache ~= nil then
			for id, formatName in pairs( HotLoadInfo.TextBoxCache ) do
				local params = ShallowCopyTable( TextFormats[formatName] )
				params.Id = id
				params.AutoSetDataProperties = true
				ModifyTextBox( params )
			end
		end
	end

	if fileName == "UIData.lua" then
		DebugPrint({ Text="Reloading TextFormats from UIData.lua" })
		SetupFormatContainers({ HotLoad = true })
	end

end

OnKeyPressed{ "ControlAlt K", Name = "Unlock All Keepsakes",
	function(triggerArgs)
		SessionState.AllKeepsakeUnlocked = true
		if CurrentRun.CurrentRoom.TestRoom then
			OpenKeepsakeRackScreen( CurrentRun.Hero )
		end
	end
}

OnKeyPressed{ "ControlShift R", Name = "SkipCreditsPreamble",
	function(triggerArgs)
		SessionMapState.SkipCreditsPreamble = true
	end
}

OnKeyPressed{ "ControlShift C", Name = "UnlockEntireCodex",
	function(triggerArgs)
		UnlockEntireCodex()
		thread( ShowCodexUpdate )
	end
}

function UnlockEntireCodex()
	CodexStatus.Enabled = true
	SessionState.CodexDebugUnlocked = true
	UnlockWorldUpgrade( "WorldUpgradeRelationshipBar" )
	UnlockWorldUpgrade( "WorldUpgradeBoonList" )
end

function UnlockElementalIcons()
	UnlockWorldUpgrade( "WorldUpgradeElementalBoons" )
	GameState.Flags.SeenElementalIcons = true
end

function DebugPrintTable( printTable, deepPrint, depth )
	if printTable == nil then
		DebugPrint({ Text= "DebugPrintTable is nil" })
		return
	end
	depth = depth or 0
	local tab = "   "
	local indent = ""
	for i = 1, depth do
		indent = indent..tab
	end
	DebugPrint({ Text = indent.."{" })
	for k, v in pairs( printTable ) do
		if type(v) == "boolean" then
			if v then
				v = "true"
			else 
				v = "false"
			end
		end	
		if type(v) == "table" then
			if deepPrint then
				if type(k) ~= "number" then
					DebugPrint({ Text = indent..tab..k.." = " })
				end
				DebugPrintTable( v, deepPrint, depth + 1 )
			else
				DebugPrint({ Text = indent..tab..k.." = {...}" })
			end
		else
			DebugPrint({ Text = indent..tab..k.." = "..v })
		end
	end
	DebugPrint({ Text = indent.."}" })
end

function AnimateOnDistance(eventSource, args)
	local notifyName = "WithinDistance"..args.Name

	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = GetIdsByType({ Name = args.Name }), Distance = args.Distance, Notify = notifyName })
	waitUntil( notifyName )

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = args.AnimationName })

	SetUnitProperty({ Property = "MoveGraphic", Value = args.AnimationName, DestinationId = CurrentRun.Hero.ObjectId })
	--SetThingProperty({ Property = "Graphic", Value = "HeroDeadIdle", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 200, DestinationId = CurrentRun.Hero.ObjectId })

	thread(AnimateOutsideDistance(eventSource, args))
end

function AnimateOutsideDistance(eventSource, args)
	local notifyName = "OutsideDistance"..args.Name

	NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = GetIdsByType({ Name = args.Name }), Distance = args.Distance, Notify = notifyName })
	waitUntil( notifyName )

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = args.AnimationName })

	SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeRun", DestinationId = CurrentRun.Hero.ObjectId })
	--SetThingProperty({ Property = "Graphic", Value = "HeroDeadIdle", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 500, DestinationId = CurrentRun.Hero.ObjectId })

	thread(AnimateOnDistance(eventSource, args))
end

OnKeyPressed{ "Alt D1", Name = "ChangeWeaponStaff",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.WeaponStaffSwing, { LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D2", Name = "ChangeWeaponDagger",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.WeaponDagger, { LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D3", Name = "ChangeWeaponAxe",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.WeaponAxe, { LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D4", Name = "ChangeWeaponTorch",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.WeaponTorch, { LoadPackages = true } )
			local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponTorch") 
			RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	end
}

OnKeyPressed{ "Alt D5", Name = "ChangeWeaponLob",
      function(triggerArgs)
            EquipPlayerWeapon( WeaponData.WeaponLob, { PreLoadBinks = true, LoadPackages = true } )
			local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponLob") 
			RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	  end
}

OnKeyPressed{ "Alt D6", Name = "ChangeWeaponSuit",
      function(triggerArgs)
            EquipPlayerWeapon( WeaponData.WeaponSuit, { PreLoadBinks = true, LoadPackages = true } )
			local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSuit") 
			RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	  end
}

function EditorActivateAllHarvestPoints()
	CurrentRun.CurrentRoom.HarvestPointsAllowed = 9
	CurrentRun.CurrentRoom.PickaxePointSuccess = true
	CurrentRun.CurrentRoom.PickaxePointsAllowed = 9
	CurrentRun.CurrentRoom.ExorcismPointSuccess = true
	CurrentRun.CurrentRoom.ExorcismPointsAllowed = 9
	CurrentRun.CurrentRoom.ShovelPointSuccess = true
	CurrentRun.CurrentRoom.ShovelPointsAllowed = 9
	CurrentRun.CurrentRoom.FishingPointSuccess = true
	CurrentRun.CurrentRoom.FishingPointsAllowed = 9
end

function PreEditingModeOn()
	EditorActivateAllHarvestPoints()
	SetupHarvestPoints( CurrentRun.CurrentRoom )

	local objectNames = { "ShadeMerc" }
	local room = CurrentRun.CurrentRoom
	room.ShadeMercInactiveIds = GetInactiveIdsByType({ Names = objectNames })
	room.ShadeMercActiveIds = {}
	DoShadeMercActivations( room, { StartingCountMin = 99, StartingCountMax = 99, ObjectNames = objectNames, MaxActive = 99 } )
end

function EditingModeOn()	
	ConfigOptionCache.EditingMode = true
	SessionState.BlockSpawns = true
	GameState.IllegalConversationModification = true
	if CurrentHubRoom ~= nil then
		if CurrentHubRoom.Name == "Hub_Main" then
			ActivateConditionalItems( nil, { CosmeticsShopCategoryIndex = 1, GhostAdminCategoryIndex = 1 } )
			ActivateConditionalItems( nil, { CosmeticsShopCategoryIndex = 2 } )
			ActivateConditionalItems( nil, { CosmeticsShopCategoryIndex = 3 } )
			local critterGroups = GetGroupWithSubGroups({ Name = "Critters" })
			for _, critterGroup in ipairs( critterGroups ) do
				local critterIds = GetIds({ Name = critterGroup })
				for _, critterId in ipairs( critterIds ) do
					SetAlpha({ Ids = critterIds, Fraction = 1 })
					SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = ids })
				end
			end
		else
			ActivateConditionalItems( nil, { CosmeticsShopCategoryIndex = 4 } )
		end
	end
	SafeModeOn()
end

function EditingModeOff()
	if CurrentHubRoom ~= nil and CurrentHubRoom.ZoomFraction ~= nil then
		FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.01 })
	elseif CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.ZoomFraction ~= nil then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.01 })
	else
		FocusCamera({ Fraction = 1.0, Duration = 0.01 })
	end
	ConfigOptionCache.EditingMode = false
	notify( "EditingModeOff" )
end

OnKeyPressed{ "Alt E", Name = "ToggleBlockSpawns",
	function( triggerArgs )
		if SessionState.BlockSpawns then
			SessionState.BlockSpawns = false
			notify( "BlockSpawnsOff" )
			EnableRoomTraps()
			DebugPrint({ Text = "BlockSpawns OFF" })
		else
			SessionState.BlockSpawns = true
			DisableRoomTraps()
			DebugPrint({ Text = "BlockSpawns ON" })
		end
	end
}

OnKeyPressed{ "ControlAltShift F", Name = "Toggle ForceUnflipMapThings",
	function( triggerArgs )
		ToggleConfigOption( "ForceUnflipMapThings" )
	end
}

function ReloadAllTraits()
	-- Remove all traits, then readd them in order
	local weaponName = GetEquippedWeapon()
	local removedTraitData = {}
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		table.insert(removedTraitData, { Name = traitData.Name, Rarity = traitData.Rarity })
		DebugPrint({Text = "Reloading trait" .. traitData.Name })
	end

	for i, traitData in pairs(removedTraitData) do
		RemoveTrait( CurrentRun.Hero, traitData.Name )
	end
	-- re-equip all weapons to flush Absolute change values

	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	MapState.EquippedWeapons[weaponName] = nil
	local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in pairs( weaponSetNames ) do
			UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
			MapState.EquippedWeapons[linkedWeaponName] = nil
		end
	end

	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	MapState.EquippedWeapons[weaponName] = true
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in pairs( weaponSetNames ) do
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
			MapState.EquippedWeapons[linkedWeaponName] = true
		end
	end


	for i, traitData in pairs(removedTraitData) do
		if traitData.Name then
			if traitData.Rarity then
				AddTraitToHero({ TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, Rarity = traitData.Rarity}) })
			else
				AddTraitToHero({ TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name }) })
			end
		end
	end
	UpdateHeroTraitDictionary()
	CheckActivatedTraits( CurrentRun.Hero )
	DebugPrint({Text = "Finished reloading "})
end

OnKeyPressed{ "ControlAlt N", Name = "AnimationTest",
	function( triggerArgs )

		-- AllAIStop()
 		CreateAnimation({ Name = "SpellMeteorDetonateImpactFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
}

OnKeyPressed{ "ControlAlt M", Name = "Show Memory Sequence",
	function( triggerArgs )

		ShowMemorySequence()
	end
}

function DebugSpawnConsumables( eventSource, args )
	local spawnPointIds = GetIds({ Name = "ConsumablePoints" })
	table.sort( spawnPointIds )
	for k, name in ipairs( args.Names ) do
		DebugAssert({ Condition = spawnPointIds[k] ~= nil, Text = "Not enough ConsumablePoints for all items", Owner = "Gavin", })
		local consumableId = SpawnObstacle({ Name = name, DestinationId = spawnPointIds[k], Group = "Standing" })
		local rampedData = GetRampedConsumableData( ConsumableData[name] )
		local consumable = CreateConsumableItemFromData( consumableId, rampedData, 0, args )
		--CreateTextBox({ Id = consumableId, Text = name, FontSize = 19, OffsetY = 70, Color = Color.White, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
		--CreateTextBox({ Id = consumableId, RawText = name, FontSize = 15, OffsetY = 100, Color = Color.DarkGray, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
		SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumable.ObjectId })
		if args.StopAnimations ~= nil then
			StopAnimation({ Names = args.StopAnimations, DestinationId = consumable.ObjectId })
		end
	end
end

function UnlockAllWeapons( eventSource, args)
	GameState.WorldUpgrades.WorldUpgradeWeaponUpgradeSystem = true
	for upgradeName, upgradeData in pairs ( WeaponShopItemData ) do
		if TraitData[upgradeName] then
			GameState.WeaponsUnlocked[upgradeName] = true
			UnlockWorldUpgrade( upgradeName )
		end
	end
end

function CreateNPCSpawnButtons( eventSource, args )

	local names = {}
	for enemyName, enemyData in pairs( EnemyData ) do
		if not IsEmpty( enemyData.InteractTextLineSets ) then --or not IsEmpty( enemyData.BossIntroTextLineSets ) then
			table.insert( names, enemyName )
		end
	end
	table.sort( names )

	local spawnButtonIds = ShallowCopyTable( args.SpawnButtonIds )
	table.sort( spawnButtonIds )
	for i, name in ipairs( names ) do
		local spawnPointId = spawnButtonIds[i]
		--local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = spawnButtonIds })
		--RemoveValueAndCollapse( spawnButtonIds, spawnPointId )
		local spawnButton = { DisableOnUse = true, OnUsedFunctionName = "DebugNPCSpawn", OnUsedFunctionArgs = { Name = name, SpawnOnId = spawnPointId } }
		AttachLua({ Id = spawnPointId, Table = spawnButton })
		CreateTextBox({ Id = spawnPointId, Text = name, FontSize = 19, OffsetY = 50, Color = Color.White, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
		CreateTextBox({ Id = spawnPointId, RawText = name, FontSize = 15, OffsetY = 80, Color = Color.DarkGray, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
	end

end

function DebugNPCSpawn( usee, args, user )
	local enemyData = EnemyData[args.Name]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = args.SpawnOnId })
	if newEnemy.BossIntroTextLineSets ~= nil then
		-- Force bosses to interact like NPCs
		newEnemy.InteractTextLineSets = newEnemy.BossIntroTextLineSets
		newEnemy.OnUsedFunctionName = "UseNPC",
		SetInteractProperty({ DestinationId = newEnemy.ObjectId, Property = "Distance", Value = 200 })
	end
	thread( SetupUnit, newEnemy, CurrentRun, { SkipAISetup = true } )
	newEnemy.ForceKeepUseable = true
	for lineSetName, lineSet in pairs( newEnemy.InteractTextLineSets ) do
		lineSet.GameStateRequirements = {}
	end
	CheckAvailableTextLines( newEnemy )
	SetAvailableUseText( newEnemy )
	if GetConfigOptionValue({ Name = "DebugEnemySpawnIdle" }) then
		AngleTowardTarget({ Id = newEnemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	else
		Track({ Ids = { newEnemy.ObjectId }, DestinationIds = { CurrentRun.Hero.ObjectId } })
	end
end

function SetupTestWeaponKit( source, args )
	local weaponData = WeaponData[args.WeaponName]
	local mergedSource = MergeTables( source, weaponData )
	AttachLua({ Id = source.ObjectId, Table = mergedSource })
end

function EquipTestWeapon( usee, args, user )
	PickupWeaponKit( usee )
end

function AnimTest1( usee, args, user )
	FreezePlayerUnit( "AnimTest" )
	AddInputBlock({ Name = "AnimTest" })
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusInteractionTalkStart", DestinationId = user.ObjectId })
	wait( 2.0 )
	
	UnfreezePlayerUnit( "AnimTest" )
	RemoveInputBlock({ Name = "AnimTest" })
end

function AnimTest2( usee, args, user )
	FreezePlayerUnit( "AnimTest" )
	AddInputBlock({ Name = "AnimTest" })
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusInteractionFishing_Start", DestinationId = user.ObjectId })
	wait( 2.0 )
	
	UnfreezePlayerUnit( "AnimTest" )
	RemoveInputBlock({ Name = "AnimTest" })
end

function AnimTest3( usee, args, user )
	FreezePlayerUnit( "AnimTest" )
	AddInputBlock({ Name = "AnimTest" })
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusPetting", DestinationId = user.ObjectId })
	wait( 2.0 )
	
	UnfreezePlayerUnit( "AnimTest" )
	RemoveInputBlock({ Name = "AnimTest" })
end