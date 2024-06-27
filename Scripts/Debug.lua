--[[ * DEBUG SCRIPTS ]]

DebugData = DebugData or {}
DebugState = DebugState or {}
DebugState.TextLinesFilter = DebugState.TextLinesFilter or {}

OnAnyLoad
{
	function( triggerArgs )
		if verboseLogging and ( GetConfigOptionValue({ Name = "AutoSafeMode" }) or GetConfigOptionValue({ Name = "EditingMode" }) ) then
			SafeModeOn()
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
		-- thread( DisplayInfoBanner, nil, {
		-- 	SupertitleText = "Store_CosmeticUnlocked_Supertitle",
		-- 	TitleText = "Store_CosmeticUnlocked_Title",
		-- 	SubtitleText = "Store_CosmeticUnlocked_Subtitle",
		-- 	SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = "Cosmetic_TentMoodcrystal01" }}
		-- })
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
	DebugPrint({ Text = name.." = "..tostring(newValue) })
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
	SetConfigOption({ Name = "RequireFocusToUpdate", Value = true })
	SetConfigOption({ Name = "DamageMultiplier", Value = 1.0 })
	SetConfigOption({ Name = "DamageTakenMultiplier", Value = 1.0 })
	SetConfigOption({ Name = "AutoPlayEnemiesOnly", Value = false })
	UpdateConfigOptionCache()
end

HotLoadInfo = HotLoadInfo or {}

-- Minos Keys

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

	SessionState.LastDebugSpawnEnemyArgs = args

	local enemyData = EnemyData[args.Name]
	local newEnemy = DeepCopyTable( enemyData )

	if newEnemy.IsUnitGroup then
		return SpawnUnitGroup( newEnemy, nil, nil)
	end

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
	
	newEnemy.ObjectId = SpawnUnit({
			Name = enemyData.Name,
			Group = "Standing",
			DestinationId = invaderSpawnPoint, OffsetX = args.OffsetX, OffsetY = args.OffsetY })

	if GetConfigOptionValue({ Name = "DebugEnemySpawnIdle" }) then
		args.SkipAISetup = true
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

OnKeyPressed{ "Alt R", Name = "Add Rerolls", Safe = true,
	function(triggerArgs)
		AddRerolls( nil, { Amount = 99 } )
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
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			trackData.GameStateRequirements = nil
		end
	end
}

OnKeyPressed{ "ControlAltShift L", Name = "Unlock Surface",
	function(triggerArgs)
		AddWorldUpgrade("WorldUpgradeAltRunDoor")
		AddWorldUpgrade("WorldUpgradeSurfacePenaltyCure")
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

ScreenData.DebugEnemySpawn =
{
	Name = "DebugEnemySpawn",
	BlockPause = true,
	Components = {},
	
	ButtonsPerRow = 6,
	SpacingX = 280,
	SpacingY = 86,
	
	PagesPerRow = 5,
	PageStartX = 600,
	PageSpacingX = 240,
	PageSpacingY = 100,
	PageHighlightColor = { 0, 64, 64, 255 },
	
	FadeOutTime = 0.0,

	Pages =
	{
		-- Undwerworld
		{
			Name = "BiomeF",
			Biomes = { "BiomeF", },
			ManualEnemies =
			{
				"Treant",
				"FogEmitter",
				"Hecate",
			},
		},
		{
			Name = "BiomeG",
			Biomes = { "BiomeG", },
			ManualEnemies =
			{
				"WaterUnitMiniboss",
				"CrawlerMiniboss",
				"Scylla",
				"SirenKeytarist",
				"SirenDrummer",
			},
		},
		{
			Name = "BiomeH",
			RoomSetName = "H",
			Biomes = { "BiomeHDebugSpawnScreen", },
			ManualEnemies =
			{
				"InfestedCerberus",
			},
		},
		{
			Name = "BiomeI",
			Biomes = { "BiomeI", },
			ManualEnemies =
			{
				"GoldElemental_MiniBoss",
				"Chronos",
			},
		},
		{
			Name = "BiomeB",
			Biomes = { "BiomeB", },
		},
		
		-- Surface
		{
			Name = "BiomeN",
			Biomes = { "BiomeN", },
			ManualEnemies =
			{
				"SatyrCrossbow",
				"Polyphemus",
			},
		},
		{
			Name = "BiomeO",
			Biomes = { "BiomeO", },
			ManualEnemies =
			{
				"Charybdis",
				"Eris",
			},
		},
		{
			Name = "BiomeP",
			Biomes = { "BiomeP", },
		},
		{
			Name = "NPCs",
			Biomes = {},
			ManualEnemies =
			{
				"NPC_Hecate_01",
				"NPC_Odysseus_01",
				"NPC_Dora_01",
				"NPC_Nemesis_01",
				"NPC_Eris_01",
				"NPC_Moros_01",
				"NPC_Hypnos_01",
				"NPC_Charon_01",
				"NPC_Selene_01",
				"NPC_Skelly_01",

				"NPC_Chronos_01",
				"NPC_Chronos_Story_01",
				"NPC_Arachne_01",
				"NPC_Heracles_01",

				"NPC_Artemis_Field_01",
				"NPC_Artemis_01",
				"NPC_Hermes_01",

				"NPC_Narcissus_01",
				"NPC_Narcissus_Field_01",
				"NPC_Echo_01",
				"NPC_Icarus_01",
				"NPC_Medea_01",
				"NPC_Circe_01",

				"NPC_Hecate_Story_01",
				"NPC_Nyx_01",

				"NPC_Hades_Field_01",
				"NPC_Cerberus_Field_01",
				"NPC_Bouldy_01",
			},
		},
		--[[
		{
			Name = "BiomeQ",
			Biomes = { "BiomeQ", },
		},
		]]
		{
			Name = "TestEnemies",
			Biomes = { "TestEnemies", },
		},
	},
	PageIds = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 1,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = { 0.15, 0.15, 0.15, 0.85 },
			Children = 
			{
				--[[
				TitleText = 
				{
					Text = "DebugEnemySpawn",
					TextArgs =
					{
						FontSize = 32,
						OffsetX = 0, OffsetY = -480,
						Color = Color.White,
						Font = "SpectralSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						Justification = "Center",
						FadeOpacity = 1.0,
					},
				},
				]]

				ToggleSpawnIdle =
				{
					Graphic = "ToggleButton",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.8,
					OffsetX = -900,
					OffsetY = -400,
					Text = "DebugEnemySpawnIdle",
					TextArgs =
					{
						FontSize = 24,
						OffsetX = 36, OffsetY = 0,
						Color = Color.White,
						Font = "LatoBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						FadeOpacity = 1.0,
					},
					Data =
					{
						OnPressedFunctionName = "ToggleDebugEnemySpawnIdle",
					},
				},

				ToggleSpawnAtHero =
				{
					Graphic = "ToggleButton",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.8,
					OffsetX = -900,
					OffsetY = -340,
					Text = "DebugEnemySpawnAtHero",
					TextArgs =
					{
						FontSize = 24,
						OffsetX = 36, OffsetY = 0,
						Color = Color.White,
						Font = "LatoBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						FadeOpacity = 1.0,
					},
					Data =
					{
						OnPressedFunctionName = "ToggleDebugEnemySpawnAtHero",
					},
				},

				CloseButton = 
				{
					Graphic = "ButtonClose",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.5,
					OffsetX = 900,
					OffsetY = 500,
					Data =
					{
						OnPressedFunctionName = "CloseScreenButton",
						ControlHotkeys = { "Cancel", },
					},
				},
			},
		},
	},
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

	SessionMapState.DebugEnemySpawnBiomeIndex = SessionMapState.DebugEnemySpawnBiomeIndex or 1

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

		local currentBiome = false
		for biomeIndex, biomeName in ipairs( page.Biomes ) do
			if CurrentRun.CurrentRoom.RoomSetName == page.RoomSetName or stringends( biomeName, CurrentRun.CurrentRoom.RoomSetName ) then
				currentBiome = true
				break
			end
		end
		SetThingProperty({ Property = "AddColor", Value = "true", DestinationId = pageButton.Id })
		if currentBiome then
			SessionMapState.DebugEnemySpawnBiomeIndex = i
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

function DebugBiomeSpawnButton( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
	Flash({ Id = button.Id, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, Duration = 0.1 })
	for enemyIndex, enemyName in ipairs( EnemySets[button.BiomeName] ) do
		if not string.match( enemyName, "_Elite" ) then
			thread( DebugSpawnEnemy, screen, { Name = enemyName, Active = true } )
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

UserDebugEquip =
{
	Amir =
	{
		Weapon = "WeaponAxe",
		Traits =
		{
			"AxeSecondStageTrait",
			-- "OmegaZeroBurnBoon",
			-- "BlindChanceBoon",
			-- "ZeusSprintBoon",

			-- "SpellLaserTrait",
			-- "SpellTimeSlowTrait",
			-- "SpellPotionTrait",
			-- "SpellMeteorTrait",
			-- "SpellLeapTrait",
			-- "SpellPolymorphTrait",
			-- "SpellTransformTrait",
			-- "SpellSummonTrait",
		}
	},
	Alice = 
	{
		Traits =
		{
			"IcedEnemyBoon",
		}		
	},
	Josh = 
	{
		Traits = 
		{
			"MassiveAttackBoon",
		}
	},
	["Eduardo G"] = 
	{
		Traits = 
		{
			"SpellSummonTrait",
		}
	}
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
		thread( UpdateHealthUI, triggerArgs )
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

OnKeyPressed{ "Control M", Name = "Add Resources", Safe = true,
	function( triggerArgs )
		for k, resourceName in ipairs( ResourceDisplayOrderData ) do
			AddResource( resourceName, 999, "Debug" )
			wait( 0.01 )
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
		thread( UpdateHealthUI, triggerArgs )
		thread( UpdateManaMeterUI, triggerArgs )
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	end
}

OnKeyPressed{ "ControlAlt T", Name = "DebugConversations", Safe = true,
	function(triggerArgs)
		OpenDebugConversationScreen()
	end
}

ScreenData.DebugConversations =
{
	Name = "DebugConversations",
	BlockPause = true,
	Components = {},

	ButtonStartX = 50,
	ButtonStartY = 75,
	ButtonScaleX = 0.5,
	ButtonScaleY = 0.5,
	SpacingX = 120,
	SpacingY = 40,
	ColumnsPerRow = 2,
	
	ListStartX = 290,
	ListStartY = 100,
	ListSpacingX = 340,
	ListSpacingY = 50,
	ListMaxY = 1050,
	ListSpacingYBucket = 35,
	OffsetXBucket = 0,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_TraitTray",

		Order =
		{
			"BackgroundDim",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = { 0.090, 0.055, 0.157, 0.9 },
		},

		TooltipBacking = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Overlay",
			ScaleX = 1.5,
			ScaleY = 0.1,
			Color = Color.TransparentBlack,
		},

		CloseButton = 
		{
			Graphic = "ButtonClose",
			Scale = 0.7,
			Color = Color.TransparentBlack,
			X = 1920 - 50,
			Y = 1080 - 50,
			Data =
			{
				OnPressedFunctionName = "CloseScreenButton",
				ControlHotkey = "Cancel",
			},
		},
	},
}

function OpenDebugConversationScreen()

	local screen = DeepCopyTable( ScreenData.DebugConversations )

	if IsScreenOpen( screen.Name ) then
		return
	end

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
			for enemyId, enemy in pairs( ActiveEnemies ) do
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
		for objectId, object in pairs( MapState.RoomRequiredObjects ) do
			if not IsEmpty( object.InteractTextLineSets ) then
				local textColor = Color.White
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
		for enemyId, enemy in pairs( ActiveEnemies ) do
			if not IsEmpty( enemy.BossIntroTextLineSets ) then
				local textColor = Color.Yellow
				local button = CreateScreenComponent({ Name = "ButtonGhostAdminTab", Group = screen.ComponentData.DefaultGroup,
					X = buttonLocationX + (screen.SpacingX * (count % screen.ColumnsPerRow)), Y = buttonLocationY + (screen.SpacingY * math.floor(count / screen.ColumnsPerRow)),
					Scale = 1.0, ScaleY = screen.ButtonScaleY, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", })
				screen.Components["Spawn"..enemy.Name] = button
				button.OnPressedFunctionName = "DebugConversationsEnemyButton"
				button.Source = enemy
				CreateTextBox({ Id = button.Id,
					Text = enemy.Name,
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
	Destroy({ Ids = GetAllKeys( screen.ContentListButtons ) })
	screen.ContentListButtons = {}

	local textLineSet = enemyData.InteractTextLineSets or enemyData.BossIntroTextLineSets
	local textLineSetPriorities = GetNarrativeDataValue( enemyData, enemyData.InteractTextLinePriorities or "InteractTextLinePriorities" ) or GetNarrativeDataValue( enemyData, "BossIntroTextLinePriorities" )

	local priorities = {}

	if textLineSetPriorities ~= nil then
		for k, priority in ipairs( textLineSetPriorities ) do
			if type(priority) == "table" then
				for j, textLinesName in ipairs( priority ) do
					priorities[textLinesName] = true
					local textLinesData = textLineSet[textLinesName]
					SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count, { OffsetX = screen.OffsetXBucket } )
					screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
					if screen.ButtonLocationY > screen.ListMaxY then
						screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
						screen.ButtonLocationY = screen.ListStartY
					end
					count = count + 1
				end
				screen.ButtonLocationY = screen.ButtonLocationY + (screen.ListSpacingY - screen.ListSpacingYBucket)
			else
				priorities[priority] = true
				local textLinesData = textLineSet[priority]
				SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
				screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingY
				if screen.ButtonLocationY > screen.ListMaxY then
					screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
					screen.ButtonLocationY = screen.ListStartY
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
		SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count, { OffsetX = screen.OffsetXBucket } )
		screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
		if screen.ButtonLocationY > screen.ListMaxY then
			screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
			screen.ButtonLocationY = screen.ListStartY
		end
		count = count + 1
	end

	-- Gifts

	textLineSet = source.GiftTextLineSets
	textLineSetPriorities = GetNarrativeDataValue( enemyData, "GiftTextLinePriorities" )

	priorities = {}

	screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
	screen.ButtonLocationY = screen.ListStartY
	count = 0

	if textLineSetPriorities ~= nil then
		for k, priority in ipairs( textLineSetPriorities ) do
			if type(priority) == "table" then
				for j, textLinesName in ipairs( priority ) do
					priorities[textLinesName] = true
					local textLinesData = textLineSet[textLinesName]
					SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count, { OffsetX = screen.OffsetXBucket } )
					screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingYBucket
					count = count + 1
				end
			else
				priorities[priority] = true
				local textLinesData = textLineSet[priority]
				SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
				screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingY
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
		SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
		screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingY
		count = count + 1
	end

	screen.ButtonLocationX = screen.ButtonLocationX + screen.ListSpacingX
	screen.ButtonLocationY = screen.ListStartY
	count = 0

	table.sort( repeatableConversations )
	for k, textLinesName in ipairs( repeatableConversations ) do
		local textLinesData = textLineSet[textLinesName]
		SetupDebugConversationsTextLinesButton( screen, button, textLinesData, count )
		screen.ButtonLocationY = screen.ButtonLocationY + screen.ListSpacingY
		count = count + 1
	end
	
end

function SetupDebugConversationsTextLinesButton( screen, unitButton, textLinesData, count, args )

	if textLinesData.Partner ~= nil and textLinesData[1] == nil then
		-- Actual data is on Partner
		local partnerData = EnemyData[textLinesData.Partner]
		textLinesData = partnerData.InteractTextLineSets[textLinesData.Name]
		--DebugPrint({ Text = "PartnerData = ".. textLinesData.Name })
	end

	args = args or {}
	local button = CreateScreenComponent({ Name = "ToggleButton", X = screen.ButtonLocationX + (args.OffsetX or 0), Y = screen.ButtonLocationY,
			Scale = 0.5, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = screen.ComponentData.DefaultGroup })
	screen.ContentListButtons[button.Id] = button
	screen.Components["TextLines"..textLinesData.Name] = button
	button.TooltipId = screen.Components.TooltipBacking.Id
	button.OnPressedFunctionName = "DebugConversationsTextLinesButton"
	button.OnMouseOverFunctionName = "DebugConversationMouseOver"
	button.OnMouseOffFunctionName = "DebugConversationMouseOff"
	if screen.ButtonLocationX > 1400 then
		button.MouseOverJustification = "Right"
		button.MouseOverOffseX = 120
		button.MouseOverOffseY = -30
	end
	AttachLua({ Id = button.Id, Table = button })
	button.TextLinesName = textLinesData.Name
	button.Source = unitButton.Source
	if GameState.TextLinesRecord[button.TextLinesName] then
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

	local color = Color.Red
	local args = { IgnoreDebugFilter = true }
	if IsTextLineEligible( CurrentRun, button.Source, textLinesData, nil, nil, args ) then
		color = Color.LimeGreen
	else
		button.FirstFailedRequirement = args.FirstFailedRequirement
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
		FontSize = 20,
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
		local textLinesData = source.InteractTextLineSets[button.TextLinesName] or source.GiftTextLineSets[button.TextLinesName]
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
				if IsTextLineEligible( CurrentRun, button.Source, prevTextLinesData, nil, nil, { IgnoreDebugFilter = true } ) then
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
		Teleport({ Id = button.TooltipId, DestinationId = button.Id, OffsetX = 380, OffsetY = -26 })
		SetAlpha({ Id = button.TooltipId, Fraction = 1.0 })
		local width = nil
		if button.MouseOverJustification == "Right" then
			width = 520
		end
		CreateTextBox({ Id = button.TooltipId,
			Text = "Failed: "..button.FirstFailedRequirement,
			FontSize = 15,
			Color = Color.Pink,
			Font = "MonospaceTypewriterBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = button.MouseOverJustification or "Left",
			Width = width,
			OffsetX = -352,
			FadeOpacity = 1.0,
		})
	end
end

function DebugConversationMouseOff( button )
	if button.FirstFailedRequirement ~= nil then
		SetAlpha({ Id = button.TooltipId, Fraction = 0.0 })
		DestroyTextBox({ Id = button.TooltipId, AffectText = "Failed: "..button.FirstFailedRequirement })
	end
end

OnKeyPressed{ "ControlShift Y", Name = "Show RunClearScreen",
	function( triggerArgs )
		OpenRunClearScreen()
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
		thread( FamiliarTimeTick, { Ticks = 21, UpdatePresentation = true, TickInterval = 0.03, } )
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
			name = name.." (TentRevive)"
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

end

OnKeyPressed{ "ControlAlt K", Name = "Unlock All Keepsakes",
	function(triggerArgs)
		SessionState.AllKeepsakeUnlocked = true
		if CurrentRun.CurrentRoom.TestRoom then
			OpenKeepsakeRackScreen( CurrentRun.Hero )
		end
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
	GameState.WorldUpgradesAdded.WorldUpgradeRelationshipBar = true
	AddWorldUpgrade( "WorldUpgradeBoonList" )
end

function UnlockElementalIcons()
	GameState.WorldUpgradesAdded.WorldUpgradeElementalBoons = true
	GameState.Flags.SeenElementalIcons = true
end

function GetRewardsTaken( room, rewardsTakenTotals )
	if room.ChosenRewardType ~= nil then
		if rewardsTakenTotals[room.ChosenRewardType] == nil then
			rewardsTakenTotals[room.ChosenRewardType] = 0
		end
		rewardsTakenTotals[room.ChosenRewardType] = rewardsTakenTotals[room.ChosenRewardType] + 1

		-- Track boons individually as well, whereas "Boon" is the sum of all boons
		--if room.ChosenRewardType == "Boon" and room.ForceLootName ~= nil then
			--rewardsTakenTotals[room.ForceLootName] = (rewardsTakenTotals[room.ForceLootName] or 0) + 1
		--end
	end

	if room.ChosenRewardType == "Boon" and room.ForceLootName ~= nil then
		return tostring(room.ForceLootName)
	else
		return tostring(room.ChosenRewardType)
	end
end

function GetRewardsOffered( room, rewardsOfferedTotals, sep )
	local rewardsOfferedStr = nil
	if sep == nil then
		sep = ", "
	end
	if room.OfferedRewards ~= nil then
		for doorId, offeredReward in pairs( room.OfferedRewards ) do
			local rewardType = offeredReward.Type
			if rewardType ~= nil then
				if rewardsOfferedStr == nil then
					rewardsOfferedStr = rewardType
				else
					rewardsOfferedStr = rewardsOfferedStr..sep..rewardType
				end
				if MapState.OfferedExitDoors[doorId] ~= nil and MapState.OfferedExitDoors[doorId].Room ~= nil then
					rewardsOfferedStr = rewardsOfferedStr.." ("..MapState.OfferedExitDoors[doorId].Room.Name..")"
				end
				rewardsOfferedTotals[rewardType] = (rewardsOfferedTotals[rewardType] or 0) + 1
			end
		end
	end
	return tostring(rewardsOfferedStr)
end

OnKeyPressed{ "ControlAlt G", Name = "DumpGameStateStats", Safe = true,
	function(triggerArgs)
		DumpGameStateStats()
	end
}

OnKeyPressed{ "ControlShift CapsLock", Name = "DumpGameStateToFile",
	function(triggerArgs)
		DumpGameStateToFile()
	end
}

function DumpGameStateStats()
	local runs = TableLength( GameState.RunHistory ) + 1
	DebugPrint({ Text = "GameState:" })
	DebugPrint({ Text = "  Runs: "..runs })
	DebugPrint({ Text = "  Collected MetaPoints: "..GetTotalAccumulatedMetaPoints() })
	DebugPrint({ Text = "  Spent MetaPoints: "..GetTotalAccumulatedMetaPoints() - (GameState.Resources.MetaPoints or 0) })

	DebugPrint({ Text = "  Damage Dealers: " })
	for name, count in pairs( GameState.EnemySpawns ) do
		if GameState.EnemyDamage[name] ~= nil then
			DebugPrint({ Text = "    Name: "..name..", Spawns: "..count..", Kills: "..tostring(GameState.EnemyKills[name]).." Damage: "..tostring(GameState.EnemyDamage[name]) })
		end
	end

	DumpRunStats( CurrentRun, runs )
end

function DumpGameStateToFile()

	local gameData =
	{
		CurrentRun = CurrentRun,
		GameState =
		{
			MetaPoints = GameState.Resources.MetaPoints,
			MetaUpgrades = GameState.MetaUpgrades,
			LockKeys = GameState.Resources.LockKeys,
			GiftPoints = GameState.Resources.GiftPoints,
			ShrinePoints = GameState.Resources.ShrinePoints,
			SpentShrinePointsCache = GameState.SpentShrinePointsCache,
			TimesCleared = GameState.TimesCleared,
			CompletedRunsCache = GameState.CompletedRunsCache,
		}
	}
	local json = TableToJSONString(gameData, {}, "GameData")
	DebugPrint({ File = "GameData.json", Text = json })

end

function DumpRunHistoryStats()

	local runs = TableLength( GameState.RunHistory ) + 1
	local outFileBuf = ""

	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "GameState:" })
	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "  Runs: "..runs })
	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "  Collected MetaPoints: "..GetTotalAccumulatedMetaPoints() })
	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "  Spent MetaPoints: "..GetTotalAccumulatedMetaPoints() - GameState.Resources.MetaPoints })

	-- Full room history of all runs
	local gameStatsCsvBuf = DebugWriteCsvRow("", { "Room", "Depth", "Chosen Reward", "Reward Taken", "Next Rewards Offered" })
	local csvFile = "GameStatsDump.csv"
	local rewardsOfferedTotals = {}
	local rewardsTakenTotals = {}
	local roomDists = {}
	local runDepthHistogram = {}
	local runsSampled = 0
	local allRunHistory = CollapseTableOrdered( GameState.RunHistory )
	table.insert(allRunHistory, CurrentRun)
	if runs > 1 then
		for runIndex, run in pairs(allRunHistory) do
			outFileBuf = DumpRunStats( run, runIndex, outFileBuf )
			if run.RoomHistory ~= nil then
				for depth, room in ipairs(run.RoomHistory) do
					if room ~= nil then
						local row = {}
						-- Track room distributions
						if roomDists[room.Name] == nil then
							roomDists[room.Name] = { 1 }
						else
							roomDists[room.Name] = { roomDists[room.Name][1] + 1 }
						end
						table.insert(row, room.Name)
						table.insert(row, depth)
						table.insert(row, room.ChosenRewardType)
						table.insert(row, GetRewardsTaken(room, rewardsTakenTotals))
						table.insert(row, '"'..GetRewardsOffered(room, rewardsOfferedTotals)..'"')
						gameStatsCsvBuf = DebugWriteCsvRow(gameStatsCsvBuf, row)
					end
				end
				local depth = GetRunDepth(run)
				runDepthHistogram[depth] = (runDepthHistogram[depth] or 0) + 1
				runsSampled = runsSampled + 1
			end
		end
		--DebugPrint({ File = csvFile, Text = gameStatsCsvBuf })
		--DebugPrint({ File = "RunHistoryFullDump.txt", Text = outFileBuf })
	end

	-- RunDepthHistogram.csv
	-- We want this sorted by KEY, so use orderedPairs
	local depthHistogramCsv = "RunDepthHistogram.csv"
	local depthHistogramCsvBuf = DebugWriteCsvRow("", { "Depth", "# of runs at depth", "% of total runs sampled" })
	for depth, instances in pairs(runDepthHistogram) do
		local percentage = "0%"
		if runsSampled > 0 then
			percentage = tostring( instances / runsSampled * 100 ).."%"
		end
		depthHistogramCsvBuf = DebugWriteCsvRow(depthHistogramCsvBuf, { depth, instances, percentage })
	end
	--DebugPrint({ File = depthHistogramCsv, Text = depthHistogramCsvBuf })

	-- Room.csv aggregation
	local roomsCsv = "RoomDistributions.csv"
	local roomsCsvBuf = DebugWriteCsvRow("", { "Room Name", "Times Seen", "% Seen" })
	local totalRoomsSeen = 0
	roomDists = CollapseTableAsOrderedKeyValuePairs( roomDists )
	for i, kvp in ipairs(roomDists) do
		local timesSeen = kvp.Value[1]
		totalRoomsSeen = totalRoomsSeen + timesSeen
	end
	if totalRoomsSeen > 0 then
		for i, kvp in ipairs(roomDists) do
			local roomName = kvp.Key
			local timesSeen = kvp.Value[1]
			roomsCsvBuf = DebugWriteCsvRow(roomsCsvBuf, { kvp.Key, timesSeen, tostring(timesSeen / totalRoomsSeen * 100).."%" })
		end
	end
	--DebugPrint({ File = roomCsv, Text = roomsCsvBuf })

	-- Rewards taken/offered aggregation
	rewardsTakenTotals = CollapseTableAsOrderedKeyValuePairs(rewardsTakenTotals)
	rewardsOfferedTotals = CollapseTableAsOrderedKeyValuePairs(rewardsOfferedTotals)

	local rewardsCsv = "RewardsData.csv"
	local rewardsCsvBuf = ""
	header = { "Reward Name", "Times Taken", "Times Offered", "% Taken", "% Offered" }
	local rows = {}
	local totalRewardsTaken = 0
	local totalRewardsOffered = 0
	for i, kvp in ipairs(rewardsOfferedTotals) do
		local rewardName = kvp.Key
		local timesTaken = 0
		local timesOffered = kvp.Value
		for j, takenKvp in ipairs(rewardsTakenTotals) do
			if takenKvp.Key == rewardName then
				timesTaken = takenKvp.Value
				totalRewardsTaken = totalRewardsTaken + (timesTaken or 0)
			end
		end
		totalRewardsOffered = totalRewardsOffered + (timesOffered or 0)
		local row = { rewardName, timesTaken, timesOffered }
		table.insert(rows, row)
	end
	table.sort(rows, function (a, b)
		-- Sort by most taken, then by most offered
		if a[2] > b[2] == 0 then
			return a[3] > b[3]
		end
		return a[2] > b[2]
	end)
	if totalRewardsTaken > 0 then
		rewardsCsvBuf = DebugWriteCsvRow(rewardsCsvBuf, header)
		for i, row in ipairs(rows) do
			table.insert(row, tostring(row[2] / totalRewardsTaken * 100).."%")
			table.insert(row, tostring(row[3] / totalRewardsOffered * 100).."%")
			rewardsCsvBuf = DebugWriteCsvRow(rewardsCsvBuf, row)
		end
	end
	--DebugPrint({ File = rewardsCsv, Text = rewardsCsvBuf })
end

function DebugWriteCsvRow(buffer, row)
	return DebugWriteLine(buffer, table.concat(row, ","))
end

function DebugWriteLine(buffer, appendString)
	buffer = buffer..appendString.."\r\n"
	return buffer
end

function DebugPrintf(args)
	if args.File == nil then
		DebugPrint(args)
	else
		return DebugWriteLine(args.File, args.Text)
	end
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

function DumpRunStats( currentRun, runIndex, outFile )

	if runIndex == nil then
		runIndex = 1
	end
	if currentRun == nil then
		return outFile
	end
	if currentRun.RoomHistory == nil then
		return outFile
	end

	local runDepth = GetRunDepth(currentRun)

	outFile = DebugPrintf({ File = outFile, Text = "Run #"..runIndex..":" })

	outFile = DebugPrintf({ File = outFile, Text = "  Damage Sources: " })
	if currentRun.DamageTakenFromRecord ~= nil then
		for source, amount in pairs( currentRun.DamageTakenFromRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      "..source..": "..amount })
		end
	end

	local totalUseTime = {}
	for depth, room in ipairs( currentRun.RoomHistory ) do
		if room.Encounter.FirstDamageTime ~= nil and room.Encounter.ClearTime ~= nil then
			for sourceName, firstDamageTime in pairs( room.Encounter.FirstDamageTime ) do
				totalUseTime[sourceName] = (totalUseTime[sourceName] or 0) + (room.Encounter.ClearTime - firstDamageTime)
			end
		end
	end
	local dpsRecord = {}
	for sourceName, damageAmount in pairs( currentRun.DamageDealtRecord ) do
		if totalUseTime[sourceName] ~= nil then
			local dps = round( damageAmount / totalUseTime[sourceName], 2 )
			local dpsEntry = { SourceName = sourceName, Dps = dps }
			table.insert( dpsRecord, dpsEntry )
		end
	end
	table.sort( dpsRecord, DpsSort )
	outFile = DebugPrintf({ File = outFile, Text = "  DPS: " })
	for index, dpsEntry in ipairs( dpsRecord ) do
		outFile = DebugPrintf({ File = outFile, Text = "      "..dpsEntry.SourceName..": "..dpsEntry.Dps })
	end

	outFile = DebugPrintf({ File = outFile, Text = "  Health Sources: " })
	if currentRun.HealthRecord ~= nil then
		for source, amount in pairs( currentRun.HealthRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      "..source..": "..amount })
		end
	end
	outFile = DebugPrintf({ File = outFile, Text = "  Actual Health Sources: " })
	if currentRun.ActualHealthRecord then
		for source, amount in pairs( currentRun.ActualHealthRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      "..source..": "..amount })
		end
	end
	outFile = DebugPrintf({ File = outFile, Text = "  Hero Traits (Depth "..runDepth.."):" })
	if currentRun.Hero ~= nil and currentRun.Hero.Traits ~= nil then
		local collapsedTraits = {}
		local traitTxt = "traits_run "..runIndex.."_depth_"..runDepth..".txt"
		local traitTxtBuf = ""
		for k, traitData in pairs( currentRun.Hero.Traits ) do
			collapsedTraits[traitData.Name] = traitData
			if not currentRun.Hero.IsDead then
				traitTxtBuf = DebugPrintf({ File = traitTxtBuf, Text = traitData.Name..", Depth: "..runDepth })
			end
		end
		DebugPrint({ File = traitTxt, Text = traitTxtBuf })
		collapsedTraits = CollapseTableOrdered(collapsedTraits)

		-- No sense logging traits if the player is dead
		if not currentRun.Hero.IsDead then
			local traitsCsv = "Traits at Run "..runIndex..", Depth "..runDepth..".csv"
			local traitsCsvBuf = DebugWriteCsvRow( "", { "Trait", "Level", "Rarity", "God", "RemainingUses", "RemainingRooms" })
			local traitsCsvRows = {}

			for k, traitData in ipairs( collapsedTraits ) do
				local level = nil
				if currentRun.Hero.TraitDictionary ~= nil then
					level = TableLength( currentRun.Hero.TraitDictionary[traitData.Name] )
				end
				if level == nil then
					level = 1
				end
				table.insert( traitsCsvRows, { traitData.Name, level, tostring(traitData.Rarity), tostring(traitData.God), tostring(traitData.RemainingUses), tostring(traitData.RemainingRooms) })
				outFile = DebugPrintf({ File = outFile, Text = "      Trait: "..traitData.Name.." ("..tostring(traitData.Rarity)..", level "..level..") God: "..tostring(traitData.God) })
			end

			-- Sort by most upgraded, then Rarity
			table.sort(traitsCsvRows, function (a, b)
				if a[2] == b[2] then
					local rarityTable = {
						Common = 0,
						Rare = 1,
						Epic = 2,
						Legendary = 3
					}
					local aRarity = rarityTable[a[3]]
					local bRarity = rarityTable[b[3]]
					if aRarity == nil then
						aRarity = -1
					end
					if bRarity == nil then
						bRarity = -1
					end
					return aRarity > bRarity
				end
				return a[2] > b[2]
			end)
			for i, row in ipairs(traitsCsvRows) do
				traitsCsvBuf = DebugWriteCsvRow( traitsCsvBuf, row )
			end
			DebugPrint({ File = traitsCsv, Text = traitsCsvBuf })
		end
	end

	outFile = DebugPrintf({ File = outFile, Text = "    Room History:" })
	local rewardsOfferedTotals = {}
	local rewardsTakenTotals = {}
	for depth, room in ipairs( currentRun.RoomHistory ) do
		if room ~= nil then
			local rewardStr = GetRewardsTaken( room, rewardsTakenTotals )
			local rewardsOfferedStr = GetRewardsOffered( room, rewardsOfferedTotals )
			outFile = DebugPrintf({ File = outFile, Text = "      Depth: "..depth.." | Room: "..room.Name.." | Encounter: "..room.Encounter.Name.." | Reward: "..rewardStr.." | Next Rewards Offered: "..rewardsOfferedStr })
		end
	end
	if currentRun.CurrentRoom ~= nil then
		local rewardStr = GetRewardsTaken( currentRun.CurrentRoom, rewardsTakenTotals )
		local rewardsOfferedStr = GetRewardsOffered( currentRun.CurrentRoom, rewardsOfferedTotals )
		outFile = DebugPrintf({ File = outFile, Text = "      Current Depth: "..runDepth.." | Room: "..currentRun.CurrentRoom.Name.." | Reward: "..rewardStr.." | Next Rewards Offered: "..rewardsOfferedStr })
	else
		outFile = DebugPrintf({ File = outFile, Text = "      Current Depth:  (DeathArea)"})
	end

	outFile = DebugPrintf({ File = outFile, Text = "    Rewards Offered Totals:" })
	for rewardType, rewardCount in pairs( rewardsOfferedTotals ) do
		outFile = DebugPrintf({ File = outFile, Text = "      "..rewardType..": "..rewardCount })
	end

	outFile = DebugPrintf({ File = outFile, Text = "    Rewards Taken Totals:" })
	for rewardType, rewardCount in pairs( rewardsTakenTotals ) do
		outFile = DebugPrintf({ File = outFile, Text = "      "..rewardType..": "..rewardCount })
	end

	if currentRun.RewardStores ~= nil then
		for storeName, rewardStore in pairs( currentRun.RewardStores ) do
			local storeStr = ""
			for j, reward in pairs( rewardStore ) do
				storeStr = storeStr..tostring(reward.Name)..", "
			end
			outFile = DebugPrintf({ File = outFile, Text = "    Upcoming Rewards ("..storeName.."): "..storeStr })
		end
	end

	return outFile
end

function DpsSort( itemA, itemB )
	return itemA.Dps > itemB.Dps
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

function DebugSetupHarvestPointAnims()
	local harvestPoints = GetIdsByType({ Name = "HarvestPoint" })
	for i, id in pairs( harvestPoints ) do
		if CurrentRun.CurrentRoom.HarvestPointIds == nil or CurrentRun.CurrentRoom.HarvestPointIds[id] == nil then
			for k, option in pairs( HarvestData.WeightedOptions ) do
				if IsGameStateEligible( CurrentRun, option, option.GameStateRequirements ) then
					SetAnimation({ DestinationId = id, Name = option.Animation })
					AddToGroup({ Id = id, Name = option.DrawGroup or "Standing", DrawGroup = true })
					break
				end
			end
		end
	end
end

function EditingModeOn()	
	DebugSetupHarvestPointAnims()
	ConfigOptionCache.EditingMode = true
	SessionState.BlockSpawns = true
	GameState.IllegalConversationModification = true
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

function ReloadAllTraits()
	-- Remove all traits, then readd them in order
	local weaponName = GetEquippedWeapon()
	local removedTraitData = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		table.insert(removedTraitData, { Name = traitData.Name, Rarity = traitData.Rarity })
		DebugPrint({Text = "Reloading trait" .. traitData.Name })
	end

	for i, traitData in pairs(removedTraitData) do
		RemoveTrait( CurrentRun.Hero, traitData.Name )
	end
	-- re-equip all weapons to flush Absolute change values

	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in pairs( weaponSetNames ) do
			UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
		end
	end

	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in pairs( weaponSetNames ) do
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
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
 		CreateAnimation({ Name = "HephMassiveHit", DestinationId = CurrentRun.Hero.ObjectId })
 		
 		--[[
 		SetAnimation({ Name = "WheatClusterC", DestinationIds = {566182,566173,566146,566185} })
 		wait(0.25)
 		SetAnimation({ Name = "WheatClusterC_Burning", DestinationIds = {566182,566173,566146,566185} })
 		]]
	end
}

function DumpTableInfo( object )
	local string = tostring(object)
	if type(object) == "table" then
		string = "(TABLE VALUE)"
	end
	if object ~= nil then
		if object.Name then
			string = string .. ":Name " .. object.Name
		end
		local displayed = 0
		for i, key in pairs(object) do
			string = string.." ".. tostring(i) .. ":" .. tostring(key)
			displayed = displayed + 1
			if displayed > 4 then
				break
			end
		end
	end
	DebugPrint({Text = string })
end

function DebugSpawnConsumables( eventSource, args )
	local spawnPointIds = GetIds({ Name = "ConsumablePoints" })
	table.sort( spawnPointIds )
	for k, name in ipairs( args.Names ) do
		local consumableId = SpawnObstacle({ Name = name, DestinationId = spawnPointIds[k], Group = "Standing" })
		local rampedData = GetRampedConsumableData( ConsumableData[name] )
		local consumable = CreateConsumableItemFromData( consumableId, rampedData, 0, args )
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
			GameState.WorldUpgradesAdded[upgradeName] = true
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