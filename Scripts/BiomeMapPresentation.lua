function BiomeMapPresentation( source, args, contextArgs )

	contextArgs = contextArgs or {}
	args = ShallowCopyTable( args ) -- Prevent leaks as args is written to during the sequence
	local labelData =
	{
		{
			Text = "Hub", OffsetX = 20, OffsetY = -440,
			Glow = nil, GlowOffsetX = nil, GlowOffsetY = nil,
		},
		{
			Text = "BiomeF", OffsetX = -680, OffsetY = 263,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_F", GlowOffsetX = -690, GlowOffsetY = 270 + 355,
			SelectedLoopScale = 1.0, SelectedLoopOffsetX = -680, SelectedLoopOffsetY = 270 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_F", FogOffsetX = -680, FogOffsetY = 270 + 340,
			AmbienceGenerators = { "CreakingTreeAmbienceGenerator", "FogRiverAmbienceGenerator" },
		},
		{
			Text = "BiomeG", OffsetX = 20, OffsetY = 480,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_G", GlowOffsetX = 20, GlowOffsetY = 480 + 340,
			SelectedLoopScale = 0.5, SelectedLoopOffsetX = 20, SelectedLoopOffsetY = 480 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_G", FogOffsetX = 20, FogOffsetY = 480 + 340,
			AmbienceGenerators = { "SlowMovingBloodRiverAmbience", "OceanusBubblesAmbienceGenerator", },
		},
		{
			Text = "BiomeH", OffsetX = 633, OffsetY = 1335,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_H", GlowOffsetX = 643, GlowOffsetY = 750 + 320,
			SelectedLoopScale = 0.55, SelectedLoopOffsetX = 629, SelectedLoopOffsetY = 728 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_H", FogOffsetX = 661, FogOffsetY = 750 + 340,
			AmbienceGenerators = { "LeavesRustleAmbienceGenerator", "FieldsAmbienceGenerator", },
		},
		{
			Text = "BiomeI", OffsetX = 33, OffsetY = 1935,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_I", GlowOffsetX = 11, GlowOffsetY = 1260 + 290,
			SelectedLoopScale = 0.60, SelectedLoopOffsetX = 10, SelectedLoopOffsetY = 1160 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_I", FogOffsetX = 30, FogOffsetY = 1260 + 340,
			AmbienceGenerators = { "TickTockAmbienceGenerator", "TartarusAmbienceGenerator" },
		},

		{
			Text = "BiomeN", OffsetX = 626, OffsetY = -250,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_N", GlowOffsetX = 613, GlowOffsetY = -610,
			SelectedLoopScale = 0.5, SelectedLoopOffsetX = 604, SelectedLoopOffsetY = -614,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_N", FogOffsetX = 604, FogOffsetY = -614,
			AmbienceGenerators = { "EphyraAmbienceGenerator", },
		},

		{
			Text = "BiomeO", OffsetX = -460, OffsetY = -885,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_O", GlowOffsetX = 15, GlowOffsetY = -910,
			SelectedLoopScale = 0.65, SelectedLoopOffsetX = 12, SelectedLoopOffsetY = -905,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_O", FogOffsetX = 15, FogOffsetY = -910,
			AmbienceGenerators = { "OceanWavesAmbienceGenerator", },
		},

		{
			Text = "BiomeP", OffsetX = 16, OffsetY = -1875,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_P", GlowOffsetX = 16, GlowOffsetY = -1540,
			SelectedLoopScale = 0.5, SelectedLoopOffsetX = 16, SelectedLoopOffsetY = -1560,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_P", FogOffsetX = 16, FogOffsetY = -1560,
			AmbienceGenerators = { "WindAmbienceGenerator", "OlympusAmbienceGenerator", "ChimesAmbienceGenerator", },
		},
	}

	killTaggedThreads( "MetaUpgradePresentation" )
	killTaggedThreads( "RespawningCoverManager" )
	killWaitUntilThreads( "RespawningCoverDeath" )
	if source.RespawningCoverActiveIds ~= nil then
		Destroy({ Ids = GetAllValues( source.RespawningCoverActiveIds ) }) -- Need to remove before they interally chain back to another animation
		wait( 0.03 )
	end
	local destroyIds = GetIdsByType({ Name = "ShipsFishFlap" })
	if not IsEmpty( destroyIds ) then
		Destroy({ Ids = destroyIds })
		wait( 0.2 ) -- Need to wait for the sounds to finish before unloading them
	end
	for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		-- Should maybe call the full CleanupEnemy() but starting leaner
		killTaggedThreads( "EnemyHealthBarFalloff"..enemy.ObjectId )
		killTaggedThreads( "Activating"..enemy.ObjectId )
		killTaggedThreads( enemy.AIThreadName )
		killWaitUntilThreads( enemy.AINotifyName )
		BlockVfx({ DestinationId = enemyId })
		Destroy({ Id = enemyId })
	end
	if source.FootstepAnimationL ~= nil then
		SwapAnimation({ Name = "FireFootstepL-Spawner", DestinationName = source.FootstepAnimationL, Reverse = true })
	end
	if source.FootstepAnimationR ~= nil then
		SwapAnimation({ Name = "FireFootstepR-Spawner", DestinationName = source.FootstepAnimationR, Reverse = true })
	end
	for _, id in pairs(SessionMapState.ShownMetaUpgradeCardIds) do
		StopAnimation({  Names = { "MetaUpgradeCardFlip", "CardFlipGlowA", "CardFlipGlowB" }, DestinationId = id })
	end
	StopUnattachedAnimation({  Names = { "ErisBombardmentCrater", "ErisBombardmentCraterFade", }, PreventChain = true })
	Destroy({ Ids = CollapseTable(SessionMapState.ShownMetaUpgradeCardIds) })

	AddInputBlock({ Name = "BiomeMapPresentation" })
	BlockVfx({ DestinationNames = { "Standing_FX", "Standing_FX_02", } })
	UnloadPackageGroup({ Group = "Biome" })
	LoadPackages({ Name = "BiomeMap", IgnoreAssert = true })

	GameState.BiomeMapRecord[args.BiomeStart] = (GameState.BiomeMapRecord[args.BiomeStart] or 0) + 1

	-- setup biome map
	local groupName = "Combat_UI"
	local backgroundId = SpawnObstacle({ Name = "rectangle01", Group = groupName, LocationX = 0.0, LocationY = 0.0, SortById = true })
	SetColor({ Id = backgroundId, Color = Color.Black, Duration = 0 })
	SetScale({ Id = backgroundId, Fraction = 10.0 })
	local biomeMapId = SpawnObstacle({ Name = "BlankObstacle", Group = groupName, LocationX = 0.0, LocationY = 0.0, SortById = true })
	SetAnimation({ DestinationId = biomeMapId, Name = "GUI\\BiomeMap\\BiomeMap" }) -- nopkg
	CreateAnimation({ Name = "BiomeMapAnimations", DestinationId = biomeMapId }) -- nopkg
	ClearCameraClamp({ LerpTime = 0 })
	PanCamera({ Id = biomeMapId, Duration = 0.0 })
	LockCamera({ Id = biomeMapId, Duration = 0.0 })
	local mapIds = {}
	table.insert( mapIds, biomeMapId )
	local startingGlowId = nil
	local endingGlowId = nil
	local selectedCircleId = nil
	local selectedCircleEndScale = nil
	local endingFogId = nil
	local endingSpotlightId = nil

	-- setup vignette
	local vignetteId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay",
		X = ScreenCenterX, Y = ScreenCenterY,
		ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
		Animation = "BiomeMapVignetteLoop" })
	
	-- setup map glows & labels
	for k, label in pairs( labelData ) do

		--ShowBiomeMapLabel( label, biomeMapId ) -- don't show label in Biome Map version

		if label.Glow ~= nil then
			local startingAlpha = 0.0
			if label.Text == args.BiomeStart then
				startingAlpha = 1.0
			end
			local glowId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_Additive", LocationX = label.GlowOffsetX, LocationY = label.GlowOffsetY })
			SetAnimation({ DestinationId = glowId, Name = label.Glow })
			SetAlpha({ Id = glowId, Fraction = startingAlpha, Duration = 0 })
			if label.Text == args.BiomeStart then
				startingGlowId = glowId
			elseif label.Text == args.BiomeEnd then
				endingGlowId = glowId
			end
			table.insert( mapIds, glowId )
		end

		if label.AmbienceGenerators ~= nil then
			for i, ambienceGenerator in ipairs( label.AmbienceGenerators ) do
				local ambienceId = SpawnObstacle({ Name = ambienceGenerator, Group = "Combat_UI_Additive", LocationX = label.GlowOffsetX, LocationY = label.GlowOffsetY })
				table.insert( mapIds, ambienceId )
			end
		end

		if label.Text == args.BiomeEnd then
			local startingAlpha = 0.0
			selectedCircleId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", LocationX = label.SelectedLoopOffsetX, LocationY = label.SelectedLoopOffsetY })
			--SetAnimation({ DestinationId = selectedCircleId, Name = "BiomeMapSelectedLoop" }) -- nopkg
			SetAlpha({ Id = selectedCircleId, Fraction = startingAlpha, Duration = 0 })
			selectedCircleEndScale = label.SelectedLoopScale
			SetScale({ Id = selectedCircleId, Fraction = label.SelectedLoopScale * 1.12, Duration = 0 })
			table.insert( mapIds, selectedCircleId )
		end

		if label.Text ~= args.BiomeStart and label.Text ~= args.BiomeEnd and label.Fog ~= nil and not Contains( args.PreviousBiomes, label.Text ) then
			local fogId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", LocationX = label.FogOffsetX, LocationY = label.FogOffsetY })
			SetAnimation({ DestinationId = fogId, Name = label.Fog })
			SetAlpha({ Id = fogId, Fraction = 1.0, Duration = 0 })
			SetScale({ Id = fogId, Duration = 12, Fraction = 1.25 })
			table.insert( mapIds, fogId )
		end
		if label.Text == args.BiomeEnd and label.Fog ~= nil then
			endingFogId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", LocationX = label.FogOffsetX, LocationY = label.FogOffsetY })
			SetAnimation({ DestinationId = endingFogId, Name = label.Fog })
			SetAlpha({ Id = endingFogId, Fraction = 1.0, Duration = 0 })
			table.insert( mapIds, endingFogId )

			endingSpotlightId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", LocationX = label.FogOffsetX, LocationY = label.FogOffsetY })
			SetAnimation({ DestinationId = endingSpotlightId, Name = "GUI\\BiomeMap\\Spotlight_01"}) --nopkg
			SetAlpha({ Id = endingSpotlightId, Fraction = 0, Duration = 0 })
			SetScale({ Id = endingSpotlightId, Fraction = label.SpotlightScale or 1.0 })
			table.insert( mapIds, endingSpotlightId )
		end
	end

	-- setup marker units
	local melId = SpawnObstacle({ Name = "BlankObstacle3D", Group = "Combat_Menu_TraitTray", SortById = true,
		LocationX = args.HeroStartOffsetX, LocationY = args.HeroStartOffsetY })
	SetThingProperty({ Property = "GrannyModel", Value = "MelMarker_Mesh", DestinationId = melId })
	SetAnimation({ Name = "MelMarkerIdle", DestinationId = melId })
	
	-- adjust scale of Mel based on Circe's spells
	if HeroHasTrait( "CirceEnlargeTrait" ) then
		SetScale({ Id = melId, Fraction = 1.70 })
	elseif HeroHasTrait( "CirceShrinkTrait" ) then
		SetScale({ Id = melId, Fraction = 0.65 })
	end

	local playerTeamIds = { melId }
	local familiarId = nil
	if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.MarkerModel ~= nil then
		familiarId = SpawnObstacle({ Name = "BlankObstacle3D", Group = "Combat_Menu_TraitTray", SortById = true,
			LocationX = args.FamiliarStartOffsetX, LocationY = args.FamiliarStartOffsetY })
		SetThingProperty({ Property = "GrannyModel", Value = MapState.FamiliarUnit.MarkerModel, DestinationId = familiarId })
		SetAnimation({ Name = MapState.FamiliarUnit.MarkerIdleAnimation, DestinationId = familiarId })
		table.insert( playerTeamIds, familiarId )
	end

	local extraObjectIds = { }
	if args.ExtraObjects ~= nil then
		for i, objectData in pairs( args.ExtraObjects ) do
			local id = SpawnObstacle({ Name = objectData.Name, Group = "Combat_Menu_TraitTray", SortById = true,
				LocationX = objectData.OffsetX, LocationY = objectData.OffsetY })
			table.insert( extraObjectIds, id )
			if objectData.Model ~= nil then
				SetThingProperty({ Property = "GrannyModel", Value = objectData.Model, DestinationId = id })
			end
			if objectData.Animation ~= nil then
				SetAnimation({ Name = objectData.Animation, DestinationId = id })
			end
			if objectData.Angle ~= nil then
				SetAngle({ Angle = objectData.Angle, Id = id })
			end
		end
	end

	local melAngle = math.atan2( -args.HeroMoveOffsetY, args.HeroMoveOffsetX )
	SetAngle({ Ids = playerTeamIds, Angle = math.deg( melAngle ) })

	-- setup visual effects
	CreateAnimation({ Name = "BiomeMapDustEmitter", DestinationId = startingGlowId })
	CreateAnimation({ Name = "BiomeMapDustEmitter", DestinationId = endingGlowId })
	SetScale({ Id = vignetteId, Duration = 10, Fraction = 1.2 })

	-- camera start
	wait( 0.02 )
	if args.CrossroadsStart then
		AdjustZoom({ Fraction = 0.785, LerpTime = 0 })
	else
		LockCamera({ Id = melId, Duration = 0 })
		AdjustZoom({ Fraction = 0.950, LerpTime = 0 })
	end

	-- presentation starts
	FullScreenFadeInAnimation()
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	thread( PlayVoiceLines, HeroVoiceLines.RegionClearedVoiceLines, true )

	-- camera setup
	local destinationId = SpawnObstacle({ Name = "InvisibleTarget", Group = groupName, SortById = true,
		LocationX = args.HeroStartOffsetX + args.HeroMoveOffsetX, LocationY = args.HeroStartOffsetY + args.HeroMoveOffsetY })
	
	-- show completed bounties from previous region
	for bountyName, v in pairs( CurrentRun.ShrineBountiesCompleted ) do
		local bountyData = BountyData[bountyName]
		if bountyData ~= nil then
			local prevRoom = GetPreviousRoom( CurrentRun )
			if ContainsAny( bountyData.Encounters, { CurrentRun.CurrentRoom.Encounter.Name, prevRoom.Encounter.Name } ) then

				BiomeMapShowBounty( source, args, bountyData )

				SetAlpha({ Id = args.TargetItemId, Fraction = 1.0 })
				SetAlpha({ Id = args.BountyBackingId, Fraction = 1.0 })
				SetAlpha({ Id = args.ShrinePointItemId, Fraction = 1.0 })
				SetAlpha({ Id = args.WeaponItemId, Fraction = 1.0 })

				wait(0.8)
				CreateAnimation({ Name = "BiomeMapBountyComplete", DestinationId = args.TargetItemId, Group = "Combat_Menu_TraitTray_Overlay", Scale = 1.0, OffsetY = 0, OffsetX = 0 }) --nopkg
				PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon", Id = args.TargetItemId })
				wait(0.45)
				SetColor({ Id = args.TargetItemId, Color = Color.Black, Duration = 0.25, EaseIn = 0, EaseOut = 1})
				SetColor({ Id = args.BountyBackingId, Color = Color.Black, Duration = 0.25, EaseIn = 0, EaseOut = 1})
				SetColor({ Id = args.ShrinePointItemId, Color = Color.Black, Duration = 0.25, EaseIn = 0, EaseOut = 1})
				SetColor({ Id = args.WeaponItemId, Color = Color.Black, Duration = 0.25, EaseIn = 0, EaseOut = 1})
				ModifyTextBox({ Id = args.ShrinePointItemId, Color = Color.Black }) 
				SetAlpha({ Id = args.ShrinePointItemId, Fraction = 0, Duration = 0.25, EaseIn = 0, EaseOut = 1 })
				wait(0.05)
			end
		end
	end
	
	local cameraDuration = 1.0
	if args.CrossroadsStart then
		wait(1.5)
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		PanCamera({ Id = destinationId, Duration = cameraDuration, EaseIn = 0, EaseOut = 0.5 })
		FocusCamera({ Fraction = 0.90, Duration = cameraDuration, ZoomType = "Ease" })
	else
		cameraDuration = 1.95
		if args.ShrinePointItemId then
			wait(0.35)
			SetScale({ Id = args.TargetItemId, Fraction = 0, Duration = 0.2 })
			SetScale({ Id = args.BountyBackingId, Fraction = 0, Duration = 0.2 })
			SetScale({ Id = args.ShrinePointItemId, Fraction = 0, Duration = 0.2 })
			SetScale({ Id = args.WeaponItemId, Fraction = 0, Duration = 0.2 })
			StopAnimation({ Name = "StaffReloadTimerReady", DestinationId = args.TargetItemId })
		else
			wait(1.05)
		end

		if GameState.BiomeMapRecord[args.BiomeStart] <= 1 then
			wait( args.AdditionalFirstTimeWait )
		end

		PanCamera({ Id = destinationId, OffsetX = args.CameraEndOffsetX or 0, OffsetY = args.CameraEndOffsetY or 0, Duration = cameraDuration, EaseIn = 0, EaseOut = 0.5 })
		FocusCamera({ Fraction = 0.85, Duration = cameraDuration, ZoomType = "Ease" })
		SetAlpha({ Id = endingFogId, Fraction = 0.0, Duration = 1.5 })
		local currentScale = GetThingDataValue({ Id = endingFogId, Property = "Scale" })
		SetScale({ Id = endingFogId, Fraction = currentScale * 1.5, Duration = 1.5 })
		PlaySound({ Name ="/SFX/Menu Sounds/HadesMainMenuWhoosh" })
		SetAlpha({ Id = startingGlowId, Fraction = 0.0, Duration = 0.3 })
		SetAlpha({ Id = endingGlowId, Fraction = 1.0, Duration = 0.3 })
		SetAlpha({ Id = endingSpotlightId, Fraction = 0.55, Duration = 1.0 })
	end
	wait( 1.5 )

	-- move pieces
	SetAnimation({ Name = "MelMarkerMove", DestinationId = melId })
	local moveSound = PlaySound({ Name = "/SFX/Player Sounds/HermesRushSpeedTrailSFX", Id = melId })
	SetVolume({ Id = moveSound, Value = 0.8, Duration = 0.0 })
	Move({ Id = melId, OffsetX = args.HeroMoveOffsetX, OffsetY = args.HeroMoveOffsetY, Duration = args.HeroMoveDuration, EaseIn = args.MoveEaseIn, EaseOut = args.MoveEaseOut, ShiftThingsByOffset = true })
	thread( BiomeMapPresentationFamiliar, source, args, familiarId )
	
	wait( 1.0 )
	
	-- punctuation VFX
	if selectedCircleId ~= nil then
		SetAnimation({ DestinationId = selectedCircleId, Name = "BiomeHilightSummoningCircleAnim" }) -- nopkg
		--SetAlpha({ Id = selectedCircleId, Fraction = 1.0, Duration = 0.3 })
		SetScale({ Id = selectedCircleId, Fraction = selectedCircleEndScale, Duration = 0.3 })
	end
	PlaySound({ Name = "/SFX/Menu Sounds/MenuMagicFlashLong", Id = selectedCircleId })

	wait( 0.1 )

	-- marker land
	SetAnimation({ Name = "MelMarkerIdle", DestinationId = melId })
	CreateAnimation({ Name = "BiomeMapDustRingShadow", DestinationId = melId, GroupName = "Combat_UI", Scale = 0.31, OffsetY = 80, OffsetX = 10 })
	CreateAnimation({ Name = "BiomeMapDustRing", DestinationId = melId, GroupName = "Combat_UI", Scale = 0.62, OffsetY = 80, OffsetX = 10 })
	PlaySound({ Name = "/Leftovers/SFX/PlayerSkid", Id = melId })
	StopSound({ Id = moveSound, Duration = 0.3 })
	
	-- jump any banners
	if not IsEmpty( extraObjectIds ) then
		SetAnimation({ Name = "BannerMarkerJump", DestinationIds = extraObjectIds })
		Move({ Id = extraObjectIds, OffsetX = -200, OffsetY = -100, Duration = 10, EaseIn = 0.1, EaseOut = 2.0, ShiftThingsByOffset = true })
		PlaySound({ Name = "/SFX/CharonOarImpact", Id = melId })
	end

	-- show any bounties on the current region
	if args.ShrineBounty ~= nil and GameState.ActiveShrineBounty ~= nil and ( CurrentRun.ActiveBounty == nil or CurrentHubRoom ~= nil ) then
		local bountyData = BountyData[GameState.ActiveShrineBounty]
		if bountyData ~= nil and Contains( bountyData.Encounters, args.ShrineBounty ) then
			
			BiomeMapShowBounty( source, args, bountyData )		

			wait( 0.65 )
			CreateAnimation({ Name = "ShoutFlare", DestinationId = args.TargetItemId, Group = "Combat_Menu_TraitTray", Scale = 1.5, OffsetY = 120 })
			CreateAnimation({ Name = "BiomeMapActiveBountyTarget", DestinationId = args.TargetItemId, Group = "Combat_Menu_TraitTray", Scale = 1.5 })
			PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2" })

			wait( 0.10 )

			SetAlpha({ Id = args.TargetItemId, Fraction = 1.0 })
			SetAlpha({ Id = args.BountyBackingId, Fraction = 1.0 })
			SetAlpha({ Id = args.ShrinePointItemId, Fraction = 1.0 })
			SetAlpha({ Id = args.WeaponItemId, Fraction = 1.0 })

			wait( 0.88 )

			if not IsEmpty( extraObjectIds ) then
				SetAnimation({ Name = "BannerMarkerIdle", DestinationIds = extraObjectIds })
				PlaySound({ Name = "/SFX/CharonOarImpact", Id = melId })
				Stop({ Ids = extraObjectIds })
			end
		end
	end
	if args.CrossroadsStart then
		wait( 2.2 )
	else
		wait( 1.6 )
	end
	if GameState.BiomeMapRecord[args.BiomeStart] <= 1 then
		wait( args.AdditionalFirstTimeWait )
	end
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FullScreenFadeOutAnimation( "RoomTransitionIn_Down" )
	if contextArgs.NextRoom ~= nil then
		contextArgs.NextRoom.EnterWipeAnimationOverride = "RoomTransitionOut_Down"
	end
	RemoveInputBlock({ Name = "BiomeMapPresentation" })
end

function BiomeMapShowBounty( source, args, bountyData )

	local screen = ScreenData.Shrine
	local bountyGroupName = "Combat_Menu_TraitTray"

	local shrineBountyOffsets =
	{
		BossHecate01 =
		{
			X = -675, 
			Y = 842,
		},
		BossScylla01 =
		{
			X = 27, 
			Y = 1063,
		},
		BossInfestedCerberus01 =
		{
			X = 640, 
			Y = 1317,
		},
		BossChronos01 =
		{
			X = 40, 
			Y = 1717,
		},

		BossPolyphemus01 =
		{
			X = 625, 
			Y = -340,
		},
		BossEris01 =
		{
			X = 18, 
			Y = -560,
		},
		BossPrometheus01 =
		{
			X = 24, 
			Y = -1335,
		},
	}
	local offset = shrineBountyOffsets[bountyData.Encounters[1]]

	args.TargetItemId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X + screen.BountyTargetOffsetY, LocationY = offset.Y + screen.BountyTargetOffsetY })
	SetAnimation({ Name = screen.BountyTargetIcons[bountyData.Encounters[1]], DestinationId = args.TargetItemId })
	SetScale({ Id = args.TargetItemId, Fraction = screen.BountyBossIconScale })
	SetAlpha({ Id = args.TargetItemId, Fraction = 0 })

	args.BountyBackingId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X, LocationY = offset.Y })
	SetAnimation({ Name = "GUI\\Screens\\Shrine\\Testament", DestinationId = args.BountyBackingId })
	SetScale({ Id = args.BountyBackingId, Fraction = screen.BountyBossIconScale })
	SetAlpha({ Id = args.BountyBackingId, Fraction = 0 })

	local shrinePoints = 0
	local weaponName = nil
	if bountyData.CompleteGameStateRequirements ~= nil then
		for j, completeRequirement in ipairs( bountyData.CompleteGameStateRequirements ) do
			if completeRequirement.HasAny ~= nil then
				weaponName = completeRequirement.HasAny[1]
			end
			if completeRequirement.Value ~= nil then
				shrinePoints = completeRequirement.Value
			end
		end
	end

	args.ShrinePointItemId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X + screen.BountyShrinePointsOffsetX, LocationY = offset.Y + screen.BountyShrinePointsOffsetY })
	local bountyShrinePointsFormat = ShallowCopyTable( screen.BountyShrinePointsFormat )
	bountyShrinePointsFormat.Id = args.ShrinePointItemId
	bountyShrinePointsFormat.Text = "ShrineScreen_BountyShrinePoints"
	bountyShrinePointsFormat.LuaKey = "TempTextData"
	bountyShrinePointsFormat.LuaValue = { RequiredShrinePoints = shrinePoints }
	bountyShrinePointsFormat.DataProperties =
	{
		OpacityWithOwner = true,
	}
	CreateTextBox( bountyShrinePointsFormat )
	SetAlpha({ Id = args.ShrinePointItemId, Fraction = 0 })

	args.WeaponItemId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X + screen.BountyWeaponOffsetX, LocationY = offset.Y + screen.BountyWeaponOffsetY })
	SetAnimation({ Name = screen.BountyWeaponIcons[weaponName], DestinationId = args.WeaponItemId })
	SetScale({ Id = args.WeaponItemId, Fraction = screen.BountyWeaponIconScale })
	SetAlpha({ Id = args.WeaponItemId, Fraction = 0 })
end

function ShowBiomeMapLabel( label, biomeMapId )

	local labelBannerId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI", LocationX = label.OffsetX + 3, LocationY = label.OffsetY + 6, SortById = true })
	SetAnimation({ DestinationId = labelBannerId, Name = "GUI\\BiomeMap\\BiomeMap_Banner_01" }) --nopkg
	
	CreateTextBox({
		Id = biomeMapId,
		Text = label.Text,
		OffsetX = label.OffsetX,
		OffsetY = label.OffsetY,
		Font = "LatoBoldItalic",
		FontSize = 32,
		Color = Color.Purple,
		Justification = "Center"
	})

end

function BiomeMapPresentationFamiliar( source, args, familiarId )
	if familiarId == nil then
		return
	end
	local randomWait = RandomFloat( 0.44, 0.66 )
	wait( randomWait )
	-- PlaySound({ Name = "/SFX/CharonOarImpact", Id = melId })
	--SetAnimation({ Name = MapState.FamiliarUnit.MarkerMoveAnimation, DestinationId = familiarId })
	Move({ Id = familiarId, OffsetX = args.FamiliarMoveOffsetX, OffsetY = args.FamiliarMoveOffsetY, Duration = args.FamiliarMoveDuration, EaseIn = args.MoveEaseIn, EaseOut = args.MoveEaseOut, ShiftThingsByOffset = true })
	wait( args.FamiliarMoveDuration )
	SetAnimation({ Name = MapState.FamiliarUnit.MarkerJumpAnimation, DestinationId = familiarId })
	CreateAnimation({ Name = "BiomeMapDustRing", DestinationId = familiarId, GroupName = "Combat_UI", Scale = 0.5, OffsetY = 70 })
--	PlaySound({ Name = "/Leftovers/SFX/WyrmJump", Id = familiarId })
end