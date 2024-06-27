function StartSurfacePenaltyPresentation()
	wait( 0.1 )
	thread( SurfacePenaltyPresentation )
end

function SurfacePenaltyPresentation()

	local preFountainBloom = GetBloomSettingName({ })
	HideCombatUI( "SurfacePenaltyPresentation" )
	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.05 )

	AddInputBlock({ Name = "SurfacePenaltyApply" })
	AdjustColorGrading({ Name = "Team03", Duration = 1.0 })
	SetAnimation({ Name = "MelinoeGetHitSurfacePenalty", DestinationId = CurrentRun.Hero.ObjectId })
	--Shake({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, Distance = 3, Speed = 300 })
	PlaySound({ Name = "/Leftovers/SFX/GoalScoredNEW" })

	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.85, MinFraction = 0.2, MaxFraction = 0.5, Color = Color.Purple, Duration = 1.5 })

	CreateAnimation({ Name = "PowerUpComboReady", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	CreateAnimation({ Name = "ThanatosDeathsHead_SurfacePenalty", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top", OffsetY = 100 })
	-- waitUnmodified( 0.5 )
	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.15, Duration = 2, ZoomType = "Ease" })
	-- ShakeScreen({ Distance = 8, Speed = 500, Duration = 1.5, FalloffSpeed = 1000 })

	thread( PlayVoiceLines, HeroVoiceLines.CurseActiveVoiceLines )

	Rumble({ Duration = 1.0, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })

	waitUnmodified( 2.0 )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1. })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = preFountainBloom, Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })

	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1, ZoomType = "Ease" })
--	RemoveSimSpeedChange( "WeaponCancelEffect", { LerpTime = 0.5 } )

--	waitUnmodified( 0.5 )

--	SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "SurfacePenaltyApply" })
	ShowCombatUI( "SurfacePenaltyPresentation" )

end

function EphyraZoomOut( usee )
	AddInputBlock({ Name = "EphyraZoomOut" })
	AddTimerBlock( CurrentRun, "EphyraZoomOut" )
	SessionMapState.BlockPause = true
	thread( HideCombatUI, "EphyraZoomOut", { SkipHideObjectives = true } )
	SetInvulnerable({ Id = CurrentRun.Hero.ObjectId })
	
	UseableOff({ Id = usee.ObjectId })

	ClearCameraClamp({ LerpTime = 0.8 })
	thread( SendCritters, { MinCount = 20, MaxCount = 20, StartX = 0, RandomStartOffsetX = 1200, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.001, MaxInterval = 0.001, GroupName = "CrazyDeathBats" } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = -350, Duration = 1.0, EaseIn = 0, EaseOut = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 0.95, Duration = 1, ZoomType = "Ease" })

	wait( 0.50 )

	local groupName = "Combat_Menu_Backing"
	local idsCreated = {}

	ScreenAnchors.EphyraZoomBackground = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	table.insert( idsCreated, ScreenAnchors.EphyraZoomBackground )
	SetScale({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.EphyraZoomBackground }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 0, Duration = 0 })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 1.0, Duration = 0.2 })

	local letterboxIds = {}
	if ScreenState.NeedsLetterbox then
		local letterboxId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu", Animation = "GUI\\Graybox\\NativeAspectRatioFrame", Alpha = 0.0 })
		table.insert( letterboxIds, letterboxId )
		SetAlpha({ Id = letterboxId, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	elseif ScreenState.NeedsPillarbox then
		local pillarboxLeftId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxLeftX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu", Animation = "GUI\\SideBars_01", Alpha = 0.0 })
		table.insert( letterboxIds, pillarboxLeftId )
		SetAlpha({ Id = pillarboxLeftId, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
		FlipHorizontal({ Id = pillarboxLeftId })
		local pillarboxRightId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxRightX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu", Animation = "GUI\\SideBars_01", Alpha = 0.0 })
		table.insert( letterboxIds, pillarboxRightId )
		SetAlpha({ Id = pillarboxRightId, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	end

	wait( 0.21 )

	ScreenAnchors.EphyraMapId = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY })
	table.insert( idsCreated, ScreenAnchors.EphyraMapId )
	SetAnimation({ Name = usee.MapAnimation, DestinationId = ScreenAnchors.EphyraMapId })
	SetHSV({ Id = ScreenAnchors.EphyraMapId, HSV = { 0, -0.15, 0 }, ValueChangeType = "Add" })

	local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )
	local attachedCircles = {}
	for index, door in ipairs( exitDoorsIPairs ) do
		if not door.SkipUnlock then
			local room = door.Room
			local rawScreenLocation = ObstacleData[usee.Name].ScreenLocations[door.ObjectId]
			if rawScreenLocation ~= nil then
				local screenLocation = { X = rawScreenLocation.X + ScreenCenterNativeOffsetX, Y = rawScreenLocation.Y + ScreenCenterNativeOffsetY }
				local rewardBackingId = CreateScreenObstacle({ Name = "BlankGeoObstacle", Group = groupName, X = screenLocation.X, Y = screenLocation.Y, Scale = 0.6 })
				if room.RewardStoreName == "MetaProgress" then
					SetAnimation({ Name = "RoomRewardAvailable_Back_Meta", DestinationId = rewardBackingId })
				else
					SetAnimation({ Name = "RoomRewardAvailable_Back_Run", DestinationId = rewardBackingId })
				end
				table.insert( attachedCircles, rewardBackingId )

				local rewardIconId = CreateScreenObstacle({ Name = "RoomRewardPreview", Group = groupName, X = screenLocation.X, Y = screenLocation.Y, Scale = 0.6 })
				SetColor({ Id = rewardIconId, Color = { 0,0,0,1} })
				table.insert( attachedCircles, rewardIconId )
				if HasHeroTraitValue( "HiddenRoomReward" ) then
					SetAnimation({ DestinationId = rewardIconId, Name = "ChaosPreview" })
				elseif room.ChosenRewardType == nil or room.ChosenRewardType == "Story" then
					SetAnimation({ DestinationId = rewardIconId, Name = "StoryPreview", SuppressSounds = true })
				elseif room.ChosenRewardType == "Shop" then
					SetAnimation({ DestinationId = rewardIconId, Name = "ShopPreview", SuppressSounds = true })
				elseif room.ChosenRewardType == "Boon" and room.ForceLootName then
					local previewIcon = LootData[room.ForceLootName].DoorIcon or LootData[room.ForceLootName].Icon
					if room.BoonRaritiesOverride ~= nil and LootData[room.ForceLootName].DoorUpgradedIcon ~= nil then
						previewIcon = LootData[room.ForceLootName].DoorUpgradedIcon
					end
					SetAnimation({ DestinationId = rewardIconId, Name = previewIcon, SuppressSounds = true })
				elseif room.ChosenRewardType == "Devotion" then

					local rewardIconAId = CreateScreenObstacle({ Name = "RoomRewardPreview", Group = groupName, X = screenLocation.X + 12, Y = screenLocation.Y - 11, Scale = 0.6 })
					SetColor({ Id = rewardIconAId, Color = { 0,0,0,1} })
					SetAnimation({ DestinationId = rewardIconAId, Name = LootData[room.Encounter.LootAName].DoorIcon, SuppressSounds = true })
					table.insert( attachedCircles, rewardIconAId )
					
					local rewardIconBId = CreateScreenObstacle({ Name = "RoomRewardPreview", Group = groupName, X = screenLocation.X - 12, Y = screenLocation.Y + 11, Scale = 0.6 })
					SetColor({ Id = rewardIconBId, Color = { 0,0,0,1} })
					SetAnimation({ DestinationId = rewardIconBId, Name = LootData[room.Encounter.LootBName].DoorIcon, SuppressSounds = true })
					table.insert( attachedCircles, rewardIconBId )
				else
					local animName = room.ChosenRewardType
					local lootData = LootData[room.ChosenRewardType]
					if lootData ~= nil then
						animName = lootData.DoorIcon or lootData.Icon or animName
					end
					local consumableData = ConsumableData[room.ChosenRewardType]
					if consumableData ~= nil then
						animName = consumableData.DoorIcon or consumableData.Icon or animName
					end
					SetAnimation({ DestinationId = rewardIconId, Name = animName, SuppressSounds = true })
				end

				local subIcons = {}

				if room.RewardPreviewIcon ~= nil and not HasHeroTraitValue( "HiddenRoomReward" ) then
					table.insert( subIcons, room.RewardPreviewIcon )
				end

				--[[
				local iconSpacing = 60
				local numSubIcons = #subIcons
				local isoOffset = 0
				if numSubIcons % 2 == 0 then
					isoOffset = isoOffset - (iconSpacing / 2)
				end
				]]
				for i, iconName in ipairs( subIcons ) do
					local iconId = CreateScreenObstacle({ Name = "BlankGeoObstacle", Group = groupName, X = screenLocation.X, Y = screenLocation.Y + 55, Scale = 0.6 })
					--local iconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = groupName })
					--local offset = CalcOffset( math.rad( 330 ), isoOffset )
					--Attach({ Id = iconId, DestinationId = rewardIconId, OffsetZ = -100, OffsetX = offset.X, OffsetY = offset.Y })
					SetAnimation({ DestinationId = iconId, Name = iconName })
					--isoOffset = isoOffset + iconSpacing
					table.insert( attachedCircles, iconId )
					if IsHorizontallyFlipped({ Id = door.ObjectId }) then
						FlipHorizontal({ Id = iconId })
					end
				end

				if IsHorizontallyFlipped({ Id = door.ObjectId }) then
					local ids = ( { rewardBackingId, rewardIconId } )
					if not IsEmpty( ids ) then
						FlipHorizontal({ Ids = ids })
					end
				end

			end
			
		end
	end
	local melScreenLocation = ObstacleData[usee.Name].ScreenLocations[usee.ObjectId]
	ScreenAnchors.MelIconId = nil
	if melScreenLocation ~= nil then
		ScreenAnchors.MelIconId = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, X = melScreenLocation.X + ScreenCenterNativeOffsetX, Y = melScreenLocation.Y + ScreenCenterNativeOffsetY, Scale = 1.5 })
		table.insert( idsCreated, ScreenAnchors.MelIconId )
		SetAnimation({ Name = "Mel_Icon", DestinationId = ScreenAnchors.MelIconId })
	end

	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 0.0, Duration = 0.35 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShort" })
	wait( 0.5 )

	local zoomOutTime = 0.5

	ScreenAnchors.EphyraZoomBackground = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY })
	table.insert( idsCreated, ScreenAnchors.EphyraZoomBackground )
	SetScale({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.EphyraZoomBackground }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 0, Duration = 0 })

	PlayInteractAnimation( usee.ObjectId )

	--FocusCamera({ Fraction = 0.195, Duration = 1, ZoomType = "Ease" })
	--PanCamera({ Id = 664260, Duration = 1.0, EaseIn = 0.3, EaseOut = 0.3 })

	wait(0.3)
	local notifyName = "ephyraZoomBackIn"
	NotifyOnControlPressed({ Names = { "Use", "Rush", "Shout", "Attack2", "Attack1", "Attack3", "AutoLock", "Cancel", }, Notify = notifyName })
	waitUntil( notifyName )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShort" })

	--FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.0, Duration = 0.5, ZoomType = "Ease" })
	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5 })

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 0.5 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 0.5 })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground, ScreenAnchors.MelIconId, ScreenAnchors.EphyraMapId, }, Fraction = 0, Duration = 0.25 })
	SetAlpha({ Ids = attachedCircles, Fraction = 0, Duration = 0.15 })
	SetAlpha({ Ids = letterboxIds, Fraction = 0, Duration = 0.15 })
	Destroy({ Ids = attachedCircles })
	
	local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )
	for index, door in ipairs( exitDoorsIPairs ) do
		if not door.SkipUnlock then
			SetScale({ Id = door.DoorIconId, Fraction = 1, Duration = 0.15 })
			AddToGroup({ Id = door.DoorIconId, Name = "FX_Standing_Top", DrawGroup = true })
		end
	end

	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 0, Duration = 0.65, EaseIn = 0, EaseOut = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.65, ZoomType = "Ease" })
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end
	wait(0.45)

	thread( ShowCombatUI, "EphyraZoomOut" )
	--SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom, }, Fraction = 0, Duration = 0.25 })
	
	RemoveTimerBlock( CurrentRun, "EphyraZoomOut" )
	RemoveInputBlock({ Name = "EphyraZoomOut" })
	SessionMapState.BlockPause = false

	wait( 0.4 )
	Destroy({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom, ScreenAnchors.EphyraZoomBackground, ScreenAnchors.MelIconId, ScreenAnchors.EphyraMapId } })
	
	wait( 0.35 )
	SetVulnerable({ Id = CurrentRun.Hero.ObjectId })
	UseableOn({ Id = usee.ObjectId })

	Destroy({ Ids = idsCreated })
	Destroy({ Ids = letterboxIds })
end

function ChronosRepulseFromObject( object, args, functionArgs, triggerArgs )
	triggerArgs = triggerArgs or {}
	if not triggerArgs.SourceWeapon then
		return
	end
	local validWeapons = ConcatTableValues( ShallowCopyTable( WeaponSets.HeroAllWeapons) , AddLinkedWeapons(WeaponSets.HeroAllWeapons))
	if not Contains(validWeapons, triggerArgs.SourceWeapon ) then
		return
	end
	RepulseFromObject( object, args)
end

function LeaveCharonFight( eventSource, args )
	args = args or {}
	AddInputBlock({ Name = "LeaveCharonFight" })
	wait(args.Delay or 1.0, RoomThreadName)

	PlaySound({ Name = "/Leftovers/SFX/NomadSprint", DestinationId = CurrentRun.Hero.ObjectId })

	RemoveInputBlock({ Name = "LeaveCharonFight" })
	LeaveRoom( CurrentRun, { Room = CreateRoom( ChooseNextRoomData( CurrentRun ) ) } )
end

function PlayScyllaTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Enemy_Scylla_Taunt", DestinationId = source.ObjectId })
		-- wait(0.5)
		-- ShakeScreen({ Speed = 500, Distance = 2, Duration = 0.3 })
	end
end

function PlayPolyphemusTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Enemy_Polyphemus_Taunt", DestinationId = source.ObjectId })
	end
end

function PlayErisTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Enemy_Eris_HubToCombatIdle", DestinationId = source.ObjectId })
		wait(1.2)
		SetAnimation({ Name = "Enemy_Eris_Reload_PreFight", DestinationId = source.ObjectId })
	end
end

function StyxFountainPresentation()

	local preFountainBloom = GetBloomSettingName({ })
	local preFountainCamera = GetCameraZoom({ })

	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/SwallowDrink", Id = CurrentRun.Hero.ObjectId })

	Rumble({ Duration = 0.3, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })

	ShakeScreen({ Distance = 30, Speed = 4, FalloffSpeed = 10, Duration = 3.0 })
	FocusCamera({ Fraction = preFountainCamera * 1.05, Duration = 3.0 })

	wait(1.0)

	SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.4 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.4 })
	AdjustFullscreenBloom({ Name = preFountainBloom, Duration = 0.4 })
	FocusCamera({ Fraction = preFountainCamera, Duration = 0.8 })

end


function CirceRemoveShrinePresentation( shrineUpgradeName, delay )
	wait( delay )
	local offsetY = -100
	PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ShrineUpgradeRemoved_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScale = 0.75, ShadowScaleX = 1.28, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = shrineUpgradeName }})	
end

function CirceEnlargePresentation()

	PlaySound({ Name = "/SFX/Enemy Sounds/Wringer/WringerChargeUp", Id = CurrentRun.Hero.ObjectId })


end

function CirceShrinkPresentation()

	PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail", Id = CurrentRun.Hero.ObjectId })

end

function IcarusPostChoicePresentation( screen, args )
	
	thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Icarus, nil )

end

function BouldyBlessingPresentation( traitName )

	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "GainedBouldyBlessing", SkipRise = false, SkipFlash = false, Duration = 1.0, ShadowScale = 0.75, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
end


function UnlockCosmeticsShop( source, args )

	args = args or {}

	OverwriteSelf( source, source.SetupFunctions[1].Args )

	DisplayInfoToast( source, { WaitTime = 3.1, Title = "Toast_CosmeticShop_Title", Text = "Toast_CosmeticShop_Subtitle", Duration = 2 } )

	wait(0.5)

	CheckObjectiveSet( "DoraDecorationIntroPrompt" )
end


function NemesisDamageContestStartPresentation( source, args )
	thread( PlayVoiceLines, source.StartDamageContestVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = true
	SetAnimation({ Name = "Nemesis_Hub_Equip", DestinationId = source.ObjectId })
	--wait( 0.5 )
	-- AudioState.FishingMusicId = PlaySound({ Name = "/Music/FishingMusicLoop" })
end

function NemesisDamageContestCountdownPresentation( source, args, timeRemaining )
	thread( InCombatText, source.ObjectId, "NemesisDamageContestCountdown", 0.65, { LuaKey = "TempTextData", LuaValue = { TimeRemaining = timeRemaining } } )
	local bellSound = PlaySound({ Name = "/SFX/ThanatosAttackBell", })
	SetVolume({ Id = bellSound, Value = 0.3 })
end

function NemesisDamageContestHitPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_OnHit", DestinationId = source.ObjectId })
end

function NemesisDamageContestFinalHitPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_Knockdown_Start", DestinationId = source.ObjectId })
end

function NemesisDamageContestSuccessPresentation( source, args )
	wait( 0.55 )
	SetAnimation({ Name = "Nemesis_Combat_Unequip", DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	--[[
	StopSound({ Id = AudioState.FishingMusicId, Duration = 0.5 })
	AudioState.FishingMusicId = nil
	]]--

	wait( 1.05 )
	thread( PlayVoiceLines, source.PlayerWonDamageContestVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = false	
	ShakeScreen({ Speed = 300, Distance = 2, FalloffSpeed = 4000, Duration = 0.5 })
	-- PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_3" })
	-- CreateAnimation({ Name = "PowerUpPerfectDash", DestinationId = source.ObjectId })
	wait (0.4)
end

function NemesisDamageContestGreatSuccessPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_Knockdown_End", DestinationId = source.ObjectId })

	--[[
	StopSound({ Id = AudioState.FishingMusicId, Duration = 0.5 })
	AudioState.FishingMusicId = nil
	]]--

	wait( 1.05 )
	SetAnimation({ Name = "Nemesis_Combat_Unequip", DestinationId = source.ObjectId })
	wait( 1.05 )
	thread( PlayVoiceLines, source.PlayerWonDamageContestBigVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = false	
	ShakeScreen({ Speed = 300, Distance = 2, FalloffSpeed = 4000, Duration = 0.5 })
	-- PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_3" })
	-- CreateAnimation({ Name = "PowerUpPerfectDash", DestinationId = source.ObjectId })
	wait (0.4)
end

function NemesisDamageContestFailPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_Unequip", DestinationId = source.ObjectId })

	--[[
	StopSound({ Id = AudioState.FishingMusicId, Duration = 0.5 })
	AudioState.FishingMusicId = nil
	]]--

	wait( 1.05 )
	thread( PlayVoiceLines, source.PlayerLostDamageContestVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = false
	ShakeScreen({ Speed = 300, Distance = 2, FalloffSpeed = 4000, Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	CreateAnimation({ Name = "ShoutFlare", DestinationId = source.ObjectId })
	wait (0.4)
end

function MedeaCursePostChoicePresentation( screen, args )
	
	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Medea, nil, screen.OpenedFrom, args )

	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = screen.Source.ColorGrade or "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = screen.Source.UpgradeAcquiredAnimation or "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( screen.Source.UpgradeAcquiredAnimationDelay or 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	ChaosBassStop()

	local cauldronPoints = GetIdsByType({ Name = "CrossroadsCauldron02"})
	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function CirceBlessingPreChoicePresentation( source, args )
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1.0, Duration = 1.0 })
end

function CirceBlessingPostChoicePresentation( screen, args )
	
	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Circe, nil, screen.OpenedFrom, args )

	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = screen.Source.ColorGrade or "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = screen.Source.UpgradeAcquiredAnimation or "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( screen.Source.UpgradeAcquiredAnimationDelay or 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	ChaosBassStop()

	local circeId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Circe_01" })
	CreateAnimation({ Name = "StatusIconNPCRescued", DestinationId = circeId })

	local cauldronPoints = GetIdsByType({ Name = "CrossroadsCauldron02"})
	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function NarcissusPostChoicePresentation( screen, args )
	args = args or {}
	local heroId = CurrentRun.Hero.ObjectId
	local npcId = screen.Source.ObjectId
	FreezePlayerUnit( "NarcissusPostChoicePresentation" )
	AngleTowardTarget({ Id = heroId, DestinationId = npcId })
	wait(0.25)
	SetAnimation({ Name = "MelinoeSaluteToEquip", DestinationId = heroId })
	wait(0.25)
	thread( PlayVoiceLines, HeroVoiceLines.ThankingCharacterVoiceLines, true )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	if args.CreateAnimation ~= nil then
		CreateAnimation({ Name = args.CreateAnimation, DestinationId = npcId })
	end
	wait(0.1)
	UnfreezePlayerUnit( "NarcissusPostChoicePresentation" )
end

function EchoPostChoicePresentation( screen, args )
	
	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	-- thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Medea, nil, screen.OpenedFrom, args )

	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = screen.Source.ColorGrade or "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = screen.Source.UpgradeAcquiredAnimation or "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( screen.Source.UpgradeAcquiredAnimationDelay or 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	ChaosBassStop()

	local cauldronPoints = GetIdsByType({ Name = "CrossroadsCauldron02"})
	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function EchoLastRunBoonPresentation( traitName )
	wait(1.25)
	CreateAnimation({ Name = "KeepsakeLevelUpFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "EchoLastRunBoon_CombatText", 2.0 , { ShadowScaleX = 1.35, LuaKey = "TempTextData", LuaValue = { Name = tostring(traitName) } })
end

function FirstPylonHubReturnPresentation(room, args)
	AddInputBlock({ Name = "FirstPylonHubReturnPresentation" })
	local shadeIds = { 664247, 664248, 664249 }
	Activate({ Ids = shadeIds })
	SetupUnits(shadeIds)
	HideCombatUI( "FirstPylonHubReturnPresentation" )
	CutsceneAddLetterbox()
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	--Shake({ Id = 645847, Distance = 1, Speed = 150, Duration = 2.5 })
	thread( PlayVoiceLines, HeroVoiceLines.BarrierWeakenedVoiceLines )

	wait( 1.35 )

	PanCamera({ Id = 645847, Duration = 2.5 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	
	wait( 2.25 )
	
	--PlaySound({ Name = "/SFX/Player Sounds/DemeterDashShardShatter", Id = 645847 })
	--CreateAnimation({ Name = "SoulPylonDestroyedFxStanding", DestinationId = 645847, Scale = 1.0, OffsetY = 0 })
	--CreateAnimation({ Name = "PowerUpComboReadyWeaponKit", DestinationId = 645847, Scale = 1.5, OffsetY = -200 })
	thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconSmile", Delay = 0.15, ChanceToPlay = 1.0, TargetId = 664247 } )
	thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconSmile", Delay = 0.25, ChanceToPlay = 1.0, TargetId = 664248 } )
	thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconSmile", Delay = 0.45, ChanceToPlay = 1.0, TargetId = 664249 } )

	wait( 2.25 )
	
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.3 })

	wait(0.5)
	
	RemoveInputBlock({ Name = "FirstPylonHubReturnPresentation" })

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	wait(0.35)
	thread( FirstPylonHubReturnPresentationEnd )
end

function FirstPylonHubReturnPresentationEnd()
	thread( HandlePylonObjective, room, args)
	wait( 0.85 )
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI( "FirstPylonHubReturnPresentation" )
end

function UseFieldsRewardFinderPresentation( source )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = source.ObjectId })
	PlaySound({ Name = "/SFX/GoldenBoughInteract", Id = source.ObjectId })
	SetAnimation({ DestinationId = source.ObjectId, Name = source.UseAnimation })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", source.UseAnimation )
	Shake({ Id = source.ObjectId, Distance = 1.5, Speed = 200, Duration = 0.125 })
	thread( PlayVoiceLines, GlobalVoiceLines.UsedRewardFinderVoiceLines, true )
	GameState.FieldsRewardFindersActivated = (GameState.FieldsRewardFindersActivated or 0) + 1
end


function FieldsEncounterEndPresentation( encounter, currentRun )
	wait( 0.1 )
	CurrentRun.CurrentRoom.EncountersCleared = (CurrentRun.CurrentRoom.EncountersCleared or 0) + 1

	thread( PlayVoiceLines, HeroVoiceLines.FieldsEncounterClearedVoiceLines, true )
	
	if encounter.RewardId then
		thread( DirectionHintPresentation, MapState.RoomRequiredObjects[encounter.RewardId], { Cooldown = 0, Delay = 0 } )
	end
end

function FieldsExitsReadyPresentation( encounter )

	PlaySound({ Name = "/Leftovers/SFX/DoorStateChangeRewardAppearance" })

	thread( PlayVoiceLines, GlobalVoiceLines.FieldsExitsUnlockedVoiceLines )

end

function ChaosRewardIncreasedPresentation( sourceId, delay )
	waitUnmodified(delay, RoomThreadName)
	PlaySound({ Name = "/Leftovers/SFX/DoorStateChangeRewardAppearance" })
	thread( InCombatTextArgs, { TargetId = sourceId, Text = "IncreasedResourceSuccess", Duration = 0.75 })
end

function ChaosManaDrainPresentation()
	if CheckCooldown("ChaosManaDrain", 0.5) then
		CreateAnimation({ Name = "SacrificeManaFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function CerberusStageExit(enemy, CurrentRun, aiStage)

	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_InfestedCerberus_BurrowStart" })
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_StageChange", Id = enemy.ObjectId })
	
	ClearEffect({ Id = enemy.ObjectId, All = true })

	thread( PlayVoiceLines, HeroVoiceLines.CerberusStageTransitionVoiceLines, true )

	BossStageTransition(enemy, currentRun, aiStage)
end

function CerberusStageEnter(enemy, CurrentRun, aiStage)

	thread(ProcessFireProjecile, enemy, { ProjectileName = "CerberusTransitionRadial", FireProjectileAtSelf = true, FireFromTarget = true, } )

	wait(2.85)

	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 2.5 })

	AdjustZoom({ Fraction = 0.55, LerpTime = 1.2 })
	CurrentRun.CurrentRoom.ZoomFraction = 0.55

	wait(0.5)

	local ghostWallIds = GetIds({ Name = "Phase1GhostWalls" })
	SetAlpha({ Ids = ghostWallIds, Fraction = 1.0, Duration = 0.5 })

	wait(1.2)

	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_InfestedCerberus_BurrowEmerge_Intro" })
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_PlagueRoar", Id = enemy.ObjectId })

	SetUnitVulnerable( enemy )

	for index, ghostWallId in ipairs( ghostWallIds ) do
		CreateAnimation({ Name = "GhostWallDissipate", DestinationId = ghostWallId })
		SetAlpha({ Id = ghostWallId, Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
		wait(0.02)
	end

	Destroy({ Ids = GetIds({ Name = "Phase1Obstacles" }) })
	Activate({ Name = "SpawnPointsPhase2" })
	CurrentRun.CurrentRoom.SpawnPoints = {}
	MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })

	wait(1.255)

	--AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 0.5 })

	BossStageTransition(enemy, currentRun, aiStage)
end


function TartarusChamberMoverPresentation( usee, args, user )
	args = args or {}
	AddInputBlock({ Name = "MelUsedSystemObject" })
	HideUseButton( usee.ObjectId, usee )
	UseableOff({ Id = usee.ObjectId })
	MapState.RoomRequiredObjects[usee.ObjectId] = nil

	--PlayInteractAnimation( usee.ObjectId, { Animation = "MelinoeBoonPreInteract" })
	thread( PlayVoiceLines, HeroVoiceLines.ChamberMoverUsedVoiceLines )

	PanCamera({ Id = usee.ObjectId, Duration = 1.1, FromCurrentLocation = true, Retarget = true, OffsetY = 0, EaseIn = 0 })
	FocusCamera({ Fraction = 1.02, Duration = 15, ZoomType = "Ease" })
	
	wait(0.1)

	Stop({ Id = CurrentRun.Hero.ObjectId })
	MoveHeroToRoomPosition({ DestinationId = 692127})
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	wait( 0.41 )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
  	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

  	--[[
	if GameState.RoomsEntered.I_Intro > 1 then
		wait( 0.7 )
	else
		wait( 4.0 )
	end
	]]

  	wait( 0.7 )
	
	--AdjustColorGrading({ Name = "Frozen", Duration = 0.9 })
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.9 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 1.5 }, } )

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	local vignetteA = CreateAnimation({ Name = "CauldronCastVignetteLoop", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = vignetteA })
	local vignetteB = CreateAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
	AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.1 })

	--SetAnimation({ DestinationId = usee.ObjectId, Name = usee.UseAnimation })
	--RecordObjectState( CurrentRun.CurrentRoom, usee.ObjectId, "Animation", usee.UseAnimation )	
	
	local loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_Gesture", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.2 })

	--SetAnimation({ Name = "Melinoe_Gesture_ToWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })

	CreateAnimation({ Name = "CWEntranceHadesSymbolIn", DestinationId = usee.ObjectId, OffsetZ = 120, OffsetX = -40, Group = "Combat_Menu_TraitTray" })

	wait(2.6)

	PlaySound({ Name = "/SFX/Menu Sounds/HadesSigilDoorUnlock" })
--	CreateAnimation({ Name = "GestureSequenceFxFront", DestinationId = usee.ObjectId, OffsetZ = 0 })
	
	StopAnimation({ Name = "CWEntranceHadesSymbolLoop", DestinationId = usee.ObjectId })
	SetAlpha({ Ids = usee.RewardPreviewIconIds, Fraction = 0.0, Duration = 0 })
	AdjustFullscreenBloom({ Name = "FullscreenFlash2", Duration = 0.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })

	-- CreateAnimation({ Name = "HadesSymbolShatter", DestinationId = usee.ObjectId, SpeedMultiplier = 1.0, Scale = 5.0, OffsetY = 90, Group = "Combat_Menu_TraitTray" })

	wait(0.3)
	StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })
	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })

	StopAnimation({ Name = "CauldronCastVignetteLoop", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	StopAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })

	ShakeScreen({ Distance = 8, Speed = 500, Duration = 0.3, FalloffSpeed = 1000 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 0.5 }, } )

	PlaySound({ Name = "/SFX/PostBossGears", Id = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.25 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.5 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.75 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId })

	--if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		--UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	--end

	wait( 1.0 )
	thread( InCombatText, usee.ObjectId, "ChamberMoverUsed", 2.0, { ShadowScaleX = 1.2, PreDelay = 0.5 } )
	--wait( 0.5 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/Hades360Swipe", Id = usee.ObjectId })

	SetAlpha({ Ids = usee.RewardPreviewIconIds, Fraction = 1.0, Duration = 0.25, EaseIn = 0, EaseOut = 1 })
	SetAnimation({ DestinationIds = usee.RewardPreviewIconIds, Name = "ClockworkCountdown"..(CurrentRun.RemainingClockworkGoals or 0) })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.19, Duration = 0.45 }, } )
	wait( 1.50 )

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "Speed", Value = 600 }) -- to get her out the gate
	wait( 0.45, RoomThreadName )
	RemoveInputBlock({ Name = "MelUsedSystemObject" })

end


function SpawnHermesInPerson( source, args )
	local unitData = EnemyData[args.UnitName]
	local unit = DeepCopyTable( unitData )

	unit.ObjectId = SpawnUnit({ Name = unitData.Name, Group = "Standing", DestinationId = args.SpawnPoints[CurrentRun.CurrentRoom.Name] or source.ObjectId })

	local runningSoundId = PlaySound({ Name = "/SFX/Player Sounds/HermesRushSpeedTrailSFX", Id = unit.ObjectId })
	SetVolume({ Id = runningSoundId, Value = 0.0, Duration = 1.6 })

	SetupUnit( unit )
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.0 })
	AngleTowardTarget({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Duration = 0.0 })

	wait(2.0)

	thread( PlayVoiceLines, GlobalVoiceLines.HermesFirstSpawnVoiceLines )

	SecretMusicPlayer( unit.ThemeMusic )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })
	SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })

	--HermesWipePresentation()
	PanCamera({ Ids = { unit.ObjectId, CurrentRun.Hero.ObjectId}, Duration = 3.0, Retarget = true })
	StartHermesVisualEffects( unit )
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.3 })
	CheckAvailableTextLines( unit, args )
	waitUntil( "HermesUsed" )
end

function StartHermesVisualEffects( unit )
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	CreateAnimation({ Name = "SorceryLeapBlastDetonateFx", DestinationId = unit.ObjectId })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.5 })
	CreateAnimation({ Name = "HermesWings", DestinationId = unit.ObjectId })
	PlaySound({ Name = "/SFX/HermesBoonWhoosh", Id = unit.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.3 }, } )
	thread( EndHermesEntranceVisuals )
end

function EndHermesEntranceVisuals( )
	wait( 2.0 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 3 })
	AdjustColorGrading({ Name = "Off", Duration = 3 })
end

function RemoveHermesInPerson( source, args )
	AddInteractBlock( source, "RemoveHermesInPerson" )
	
	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.1 })
   	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.1 })
   	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 1000, Duration = 1.0 })
   	PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.0, Retarget = true })

	wait( 1.0 )
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
   	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })
	CreateAnimation({ Name = "HadesDisappear_Player", DestinationId = source.ObjectId, Scale = 0.6 })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.3 })

	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.Mute = true
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })

	CreateAnimation({ Name = "HermesWings", DestinationId = source.ObjectId })
	--HermesWipePresentation()
	StartHermesVisualEffects( source )
	local runningSoundId = PlaySound({ Name = "/SFX/Player Sounds/HermesRushSpeedTrailSFX", Id = source.ObjectId })
	SetVolume({ Id = runningSoundId, Value = 0.0, Duration = 3 })

	local loot = GiveLoot({ SpawnPoint = source.ObjectId, OffsetX = 50, OffsetY = 50, ForceLootName = "HermesUpgrade" })
	loot.BlockTextLines = true
	loot.NotifyName = "HermesUsed"
end

function PoseidonSprintBallDetachPresentation( targetId )
	local attachedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
		
	PlaySound({ Name = "/SFX/Player Sounds/PoseidonWaterDashUpgrade", Id = attachedTargetId })

	thread(DestroyOnDelay, {attachedTargetId}, 0.1 )
end


function ChronosRemainsPresentation( usee, args )
	args = args or {}
	AddInputBlock({ Name = "MelUsedChronosRemains" })
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines[args.VoiceLines] or HeroVoiceLines.LockedQuestLogVoiceLines, true )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.7 )

	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.8 )

	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })
	
	wait( 0.5 )
	RemoveInputBlock({ Name = "MelUsedChronosRemains" })
end

function ResetScyllaMusicStem( scylla, args )

	args = args or {}
	scylla.TargetMusicStemVolume = scylla.TargetMusicStemVolume or 1

	if args.Delay then
		wait(args.Delay)
	end

	SetSoundCueValue({ Names = { scylla.MusicStem }, Id = AudioState.MusicId, Value = scylla.TargetMusicStemVolume, Duration = args.Duration or 1 })
end