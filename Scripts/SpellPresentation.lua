function SpellReloadPresentation( owner, weaponData )
	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if traitData ~= nil then
		local existingTraitData = GetExistingUITrait( traitData )
		if existingTraitData ~= nil then
			StopAnimation({ DestinationId = existingTraitData.AnchorId, Name = "DarkSorceryReady" })
		end
	end
end

function SelectSpellPresentation( screen, button )
	local buttonId = button.Id

	local traitName = button.TraitName
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	local voiceLines = traitData.UpgradePickedVoiceLines
	SetAlpha({ Id = buttonId, Fraction = 0 })
	CreateAnimation({ Name = "BoonGetBlack", DestinationId = buttonId, Scale = 1.0, Group = "Combat_Menu" })
	CreateAnimation({ Name = "BoonGet", DestinationId = buttonId, Scale = 1.0, Group = "Combat_Menu_Additive" })
	StopAnimation({ Name = "BoonSlotHighlight", DestinationId = button.Highlight.Id })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonChoiceConfirmMoon", Id = buttonId })

	thread( PlayVoiceLines, voiceLines, true, screen.Source )

	waitUnmodified( 0.1 )
	SetAnimation({ Name = "SpellScreenOut", DestinationId = screen.Components.Background.Id })
end

function SpellPotionUsedPresentation( owner, weaponData )
	thread( PlayVoiceLines, GlobalVoiceLines.UsedHealDropVoiceLines, true )
end

function TeleportSummonPresentation( enemyId )
	CreateAnimation({ Name = "TeleportDisappear", DestinationId = enemyId })
end

function SpellFailToFirePresentation( triggerArgs )
	if SessionMapState.ActiveGiftableUseTarget then
		return
	end
	
	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if traitData then
		local existingTraitData = GetExistingUITrait( traitData )
		if not existingTraitData then
			return
		end
		if existingTraitData and existingTraitData.TraitActiveOverlay then
			CreateAnimation({ Name = "ActiveTraitCooldownSpellNotReady", DestinationId = existingTraitData.TraitActiveOverlay })
			PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = CurrentRun.Hero.ObjectId, ManagerCap = 46 })
		end
		if existingTraitData and existingTraitData.TraitInfoCardId then
			thread( PulseText, { Id = existingTraitData.TraitInfoChargeId, Color = Color.Red, OriginalColor = Color.White, ScaleTarget = 1.2, ScaleDuration = 0.1, HoldDuration = 0.1, PulseBias = 0.1 } )
		end
		local manaSpendCost = GetManaSpendCost(GetWeaponData( CurrentRun.Hero, traitData.PreEquipWeapons[1]))
		if CheckCountInWindow( "SpellFailedToFire", 1.0, 4 ) and CheckCooldown("AttackNotReady", 1.0) then
			thread( PlayVoiceLines, HeroVoiceLines.SpellNotReadyVoiceLines, true )
			if SessionMapState.BlockSpellCharge then
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "UseBlockedByMisc", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
			elseif existingTraitData.RemainingUses and existingTraitData.RemainingUses <= 0 then
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Hint_OutOfPotions", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
			elseif existingTraitData.Name == "SpellSummonTrait" and not CurrentRun.CurrentRoom.SummonEnemyName and CurrentRun.SpellCharge >= manaSpendCost then
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Spell_NotReady_NoValidSummon", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
			elseif not CanChargeSpell() then
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "UseBlockedByMisc", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
			elseif MapState.HostilePolymorph then
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "UseBlockedByMisc", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
			else
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Spell_NotReady", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
			end
			PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = traitData.AnchorId, ManagerCap = 54 })
		end
		thread( DoRumble, { { RightTriggerStrengthFraction = 0.9, RightTriggerTimeout = 1.0, IgnoreTriggersIfControlNotDefault = "Shout", }, } )
	end
end

function SpellReadyPresentation( traitData, delay ) 
	if delay and delay > 0 then
		waitUnmodified(delay, RoomThreadName)
	end
	local weaponName = traitData.PreEquipWeapons[1]
	if weaponName and GetWeaponDataValue({ WeaponName = weaponName, Id = CurrentRun.Hero.ObjectId, Property = "Enabled" }) then
		TraitUIDeactivateTrait( traitData )
		
		StopAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId })
		CreateAnimation({ Name = "HexReadyFlash", DestinationId = traitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })	
		CreateAnimation({ Name = "SpellReadyMelFx", DestinationId = CurrentRun.Hero.ObjectId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })	
		CreateAnimation({ Name = "HexReadyFlashLargeA", DestinationId = traitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })	
		CreateAnimation({ Name = "HexReadyFlashLargeB", DestinationId = traitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })	
		CreateAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
		if not SessionMapState.SpellWorldReadyFx then
			SessionMapState.SpellWorldReadyFx = true
			CreateAnimation({ Name = "SorceryReadyMoonLoopIn", DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end

-- note: PolymorphApplyPresentation & others in CombatPresentation
function SpellPolymorphResistedPresentation( enemy, triggerArgs )
	if enemy.ResistedVoiceLines then
		thread( PlayVoiceLines, enemy.ResistedVoiceLines, nil, enemy, triggerArgs )
	end
	if enemy.InvulnerableHitSound ~= nil then
		PlaySound({ Name = enemy.InvulnerableHitSound, Id = enemy.ObjectId })
	end
	PlaySound({ Name = "/SFX/Player Sounds/MelStaffFissureSizzle", Id = enemy.ObjectId })
	InCombatTextArgs ({ TargetId = enemy.ObjectId, Text = "NotPolymorphed", Duration = 1.25, Cooldown = 2.0 } )	
end

function CreateSpellHUD( trait, args )
	args = args or {}
	local anchorId = args.AnchorId or trait.AnchorId
	if anchorId == nil then
		return
	end
	local hasSubtitle = false
	local xOffset = 0
	local yOffset = 0
	
	local data = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
	local manaSpend = GetManaSpendCost( data )
	local remainingSpend = math.max( manaSpend - CurrentRun.SpellCharge, 0 )
	if remainingSpend <= 0 and not trait.RemainingUses then
		hasSubtitle = false
	else
		hasSubtitle = true
	end
	
	if not hasSubtitle then
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0.2 })
		SetAlpha({ Id = trait.TraitInfoChargeId, Fraction = 0, Duration = 0.2 })	
		return
	end

	if trait.TraitInfoCardId == nil then
		trait.TraitInfoCardId = CreateScreenObstacle({ Name = "TraitTray_LevelBacking", Group = "Combat_Menu_TraitTray",
			Alpha = 0.0, AlphaTarget = ConfigOptionCache.HUDOpacity, AlphaTargetDuration = 0.2,
			DestinationId = anchorId, Attach = true, OffsetY = ScreenData.HUD.TraitInfoCardOffsetY,
		})
	else
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })	
	end

	local data = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
	local manaSpend = GetManaSpendCost( data )
	local remainingSpend = math.max( manaSpend - CurrentRun.SpellCharge, 0 )
	if trait.TraitInfoChargeId == nil then		
		trait.TraitInfoChargeId = CreateScreenObstacle({ Name = "TraitTray_LevelBacking", Group = "Combat_Menu_TraitTray",
			Alpha = 0.0, AlphaTarget = ConfigOptionCache.HUDOpacity, AlphaTargetDuration = 0.2,
			DestinationId = anchorId, Attach = true, OffsetY = ScreenData.HUD.TraitInfoCardOffsetY,
		})
		CreateTextBox({
			Id = trait.TraitInfoChargeId,
			Font = "NumericP22UndergroundSCMedium",
			Color = Color.White, FontSize = 22, 
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset - 2, OffsetY = yOffset - 3,
			Justification = "Center",
		})
	else	
		SetAlpha({ Id = trait.TraitInfoChargeId, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })	
	end

	if remainingSpend > 0 and (trait.RemainingUses == nil or trait.RemainingUses > 0 ) then
		ModifyTextBox({
			Id = trait.TraitInfoChargeId,
			Text = "UI_SpellCharge", 
			LuaKey = "TempTextData",
			LuaValue = { CurrentSpend = math.min( CurrentRun.SpellCharge, manaSpend ), RequiredSpend = manaSpend, RemainingSpend = remainingSpend },
		})
	else	
		SetAlpha({ Id = trait.TraitInfoChargeId, Fraction = 0, Duration = 0.2 })
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0.2 })
	end

	if ( trait.RemainingUses ~= nil or trait.Uses ~= nil ) and not trait.UsesAsRooms then
		local time = trait.RemainingUses or trait.Uses
		if trait.TraitInfoUsesId == nil then
			trait.TraitInfoUsesId  = CreateScreenObstacle({ Name = "TraitTray_LevelBacking", Group = "Combat_Menu_TraitTray", Animation = "TraitTray_LevelBacking_Top",
				Alpha = 0.0, AlphaTarget = ConfigOptionCache.HUDOpacity, AlphaTargetDuration = 0.2,
				DestinationId = anchorId, Attach = true, OffsetY = -24,
			})
			CreateTextBox({
				Id = trait.TraitInfoUsesId,
				Text = "UI_Uses",
				Font = "NumericP22UndergroundSCMedium", 
				FontSize = 22,
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				OffsetX = xOffset, OffsetY = 3,
				Justification = "Center",
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
				DataProperties =
				{
					TextSymbolScale = 0.9,
					TextSymbolOffsetY = 3,
				},
			})
		else
			SetAlpha({ Id = trait.TraitInfoUsesId, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })	
			ModifyTextBox({ 
				Text = "UI_Uses",
				Id = trait.TraitInfoUsesId,
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
			})
		end
		
	end
end

function SpellChargeNumber( traitData, manaSpendCost, remainingSpend)
	ModifyTextBox({ Id = traitData.TraitInfoChargeId, Text = "UI_SpellCharge", LuaKey = "TempTextData", LuaValue = { CurrentSpend = math.min( CurrentRun.SpellCharge, manaSpendCost ), RequiredSpend = manaSpendCost, RemainingSpend = remainingSpend },})
	PulseText({ Id = traitData.TraitInfoChargeId, ScaleTarget = 1.04, ScaleDuration = 0.1, HoldDuration = 0.05, Color = Color.LightBlue, OriginalColor = Color.White})
end

function SpellActivateTrait( traitData )
	TraitUIDeactivateTrait( traitData ) 
	if traitData.TraitInfoCardId ~= nil then
		Destroy({ Id = traitData.TraitInfoCardId })
		traitData.TraitInfoCardId = nil
	end
	if traitData.TraitInfoChargeId ~= nil then
		Destroy({ Id = traitData.TraitInfoChargeId })
		traitData.TraitInfoChargeId = nil
	end
	if traitData.AnchorId then
		StopAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId })
		CreateAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
	end
	if not SessionMapState.SpellWorldReadyFx then
		SessionMapState.SpellWorldReadyFx = true
		CreateAnimation({ Name = "SorceryReadyMoonLoopIn", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function SpellUnreadyPresentation( traitData )
	-- Stop any looping animations here 
	StopAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId })	
	if SessionMapState.SpellWorldReadyFx then
		SessionMapState.SpellWorldReadyFx = nil
		StopAnimation({ Names = { "SorceryReadyMoonLoopIn", "SorceryReadyMoonLoop" }, DestinationId = CurrentRun.Hero.ObjectId, PreventChain = true })
	end
end

function SpellHasManaPresentation()
	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if not traitData then
		return
	end	
	local existingTraitData = GetExistingUITrait( traitData )
	local weaponData = GetWeaponData( CurrentRun.Hero, traitData.PreEquipWeapons[1] )
	if existingTraitData ~= nil 
		and not MapState.ActiveSpellPresentation 
		and CurrentRun.Hero.Mana >= GetManaCost( weaponData ) 
		and GetHeroMaxAvailableMana() >= GetManaReservationCost( weaponData ) 
		and ( GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "ClipShotsRemaining" }) or 0 ) > 0 
		and ( not existingTraitData.RemainingUses or existingTraitData.RemainingUses > 0 )  then
		CreateAnimation({ Name = "DarkSorceryReady", DestinationId = existingTraitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
		TraitUIActivateTrait( traitData, {PlaySpeed = 1 })
		MapState.ActiveSpellPresentation = true
	end
end

function SpellHasNoManaPresentation()

	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if not traitData then
		return
	end
	local existingTraitData = GetExistingUITrait( traitData )
	local weaponData = GetWeaponData( CurrentRun.Hero, traitData.PreEquipWeapons[1] )
	if existingTraitData ~= nil and ( CurrentRun.Hero.Mana < GetManaCost( weaponData ) or GetHeroMaxAvailableMana() < GetManaReservationCost( weaponData )) and 
		( GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "ClipShotsRemaining" }) or 0 ) > 0 then
		TraitUIDeactivateTrait( existingTraitData )
		StopAnimation({ DestinationId = existingTraitData.AnchorId, Name = "DarkSorceryReady" })
		
		MapState.ActiveSpellPresentation = false
	end
end

function CheckSpellOutOfManaPresentation( triggerArgs, weaponData, functionArgs)
	if not triggerArgs.AllowFire and triggerArgs.Charge >= 1 and not triggerArgs.OnCooldown then
		WeaponFailedNoManaPresentation ( weaponData, { Force = true } )
	end
end

function SpellHintPresentation()
	local notifyName = "SpellPressed"
	NotifyOnControlPressed({ Names = {"Shout"}, Notify = notifyName, Timeout = 1.0 })
	waitUntil( notifyName )
	if _eventTimeoutRecord[notifyName] and weaponData and CurrentRun.Hero.Mana >= GetManaCost( weaponData ) and GetHeroMaxAvailableMana() > GetManaReservationCost( weaponData ) then
		local traitData = nil
		for i, trait in ipairs( CurrentRun.Hero.Traits ) do
			if trait.Slot == "Spell" then
				traitData = trait
				break
			end
		end
		if traitData then
			local existingTraitData = GetExistingUITrait( traitData )
			if existingTraitData then
				if traitData.RemainingUses and traitData.RemainingUses <= 0 then
					return
				end
				CreateAnimation({ Name = "DarkSorceryReady", DestinationId = existingTraitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
			end
		end
	end
end

function SpellTransformStartPresentation( user, weaponData, functionArgs, triggerArgs )
	SetAudioEffectState({ Name = "Chipmunk", Value = -0.8 })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingAxe", Id = CurrentRun.Hero.ObjectId })
end

function SpellTransformWarnPresentation()
	if not MapState.TransformArgs then
		return
	end
	PlaySound({ Name = "/SFX/HexEndingWarning", Id = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function PoseidonPotionWarnPresentation()
	PlaySound({ Name = "/SFX/HexEndingWarning", Id = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function SpellTransformEndPresentation( user, weaponData, functionArgs, triggerArgs )

	SetAudioEffectState({ Name = "Chipmunk", Value = GetTotalHeroTraitValue("BaseChipmunkValue") })
	PlaySound({ Name = "/SFX/TimeSlowEnd", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteGasping", Id = CurrentRun.Hero.ObjectId })
end


function SpellMeteorPresentation( owner, weaponData )
	thread( SpellMeteorPresentationThreaded, owner, weaponData )
end

function SpellMeteorPresentationThreaded( owner, weaponData )

	if CurrentRun.CurrentRoom.Encounter.BossKillPresentation or SessionMapState.HandlingDeath then
		return
	end

	local meteorLandingSpot = SpawnObstacle({ Name = "BlankObstacle", DestinationId = owner.ObjectId })
	--local zoomFraction = CurrentRun.CurrentRoom.ZoomFraction or 1
	--PanCamera({ Ids = { meteorLandingSpot, CurrentRun.Hero.ObjectId }, Duration = 5, EaseIn = 0 })
	--FocusCamera({ Fraction = zoomFraction * 1.1, Duration = 5, ZoomType = "Ease" })
	AdjustColorGrading({ Name = "MoonDust", Duration = 8 })
	AdjustFullscreenBloom({ Name = "MoonDustBloom", Duration = 8 })
	ShakeScreen({ Speed = 300, Distance = 5, Duration = 0.5, FalloffSpeed = 1400 })
	wait(4.0)
	local distanceSquared = GetDistance({ Id = meteorLandingSpot, DestinationId = CurrentRun.Hero.ObjectId })^2
	local distanceThreshold = weaponData.SimSlowDistanceThreshold or 800
	if distanceSquared ~= -1 and distanceSquared <= ( distanceThreshold * distanceThreshold ) then
		ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	end
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	wait(0.5)
	if not CurrentRun.CurrentRoom.Encounter.BossKillPresentation and not SessionMapState.HandlingDeath then
	--	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseIn = 0.3 })
	--	FocusCamera({ Fraction = zoomFraction, Duration = 0.3, ZoomType = "Ease" })
	end
end

function SpellChargePresentation( triggerArgs, weaponData, args )
	CreateAnimation({ Name = "SpellChargeFx", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowTrigger", Id = CurrentRun.Hero.ObjectId })
	CurrentRun.Hero.SpellChargeSoundId = PlaySound({ Name = "/VO/MelinoeEmotes/EmoteChargingSpell", Id = CurrentRun.Hero.ObjectId })
end

function SpellChargeEndPresentation( isSuper )
	local spellChargeAnims =
	{
		"SpellChargeFx",
		"SpellChargeFxA",
		"SpellChargeFxB1",
		"SpellChargeFxB2",
		"SpellChargeFxB3",
		"SpellChargeFxC1",
		"SpellChargeFxC2",
		"SpellChargeFxC3",
		"SpellChargeParticle",
		"SpellChargeGlow",
		"SpellChargeDarkFx1",
		"SpellChargeDarkFx2",
		"SpellChargeDarkFx3",
		--"SpellChargeMoonbeam",
	}

	for i, spellAnim in pairs( spellChargeAnims ) do
		StopAnimation({ Name = spellAnim, DestinationId = CurrentRun.Hero.ObjectId })
	end

	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowStart", Id = CurrentRun.Hero.ObjectId })

	StopSound({ Id = CurrentRun.Hero.SpellChargeSoundId, Duration = 0.2 })
	CurrentRun.Hero.SpellChargeSoundId = nil

	CreateAnimation({ Name = "SpellFireFx", DestinationId = CurrentRun.Hero.ObjectId })
	if not isSuper then
		thread( PlayVoiceLines, GlobalVoiceLines.SpellReactionVoiceLines )
	end
end

function SpellBloodMoonBeamHitPresentation( victim, functionArgs, triggerArgs )
	if not victim then
		return
	end
	triggerArgs.ImpactAngle = GetAngleBetween({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId })
	thread( AresRendApplyPresentation, victim, triggerArgs, functionArgs )
	if functionArgs.EffectName then
		local dataProperties = MergeTables( EffectData[functionArgs.EffectName].EffectData)
		ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties })			
	end
end
function DoFullSuperPresentation( godName )
	local currentRun = CurrentRun
	SetPlayerInvulnerable( "Super" )
	HideCombatUI("SuperPresentation")

	thread( DoRumble, { { RightTriggerStart = 2, RightTriggerStrengthFraction = 0.3, RightTriggerFrequencyFraction = 0.15, RightTriggerTimeout = 0.25, }, } )

	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = currentRun.Hero.ObjectId })
	CreateAnimation({ Name = "WrathFire", DestinationId = CurrentRun.Hero.ObjectId, Color = LootData[godName .. "Upgrade"].LootColor }) --nopkg
	
	local dataProperties = EffectData.ShoutSelfSlow.DataProperties
	ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ShoutSelfSlow", DataProperties = dataProperties })
	Rumble({ RightFraction = 0.7, Duration = 0.3 })

	if IsEmpty( SessionMapState.LockCameraMotion ) then
		FocusCamera({ Fraction = 0.9, Duration = 0.02, ZoomType = "Ease" })
	end
	
	-- TODO:Bloom changes here!

	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03, Delay= 0 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03, Delay= 0 })
	-- audio
	local sourceName = godName.."Upgrade"
	local sourceData = LootData[sourceName]
	local dummySource = { Name = sourceName, SubtitleColor = sourceData.SubtitleColor }
	thread( PlayVoiceLines, sourceData.FullSuperActivatedVoiceLines or HeroVoiceLines.FullSuperActivatedVoiceLines, nil, dummySource )
	PlaySound({ Name = sourceData.ShoutActivationSound or "/Leftovers/SFX/MeteorStrikeShort" })
	AudioState.ShoutEffectSoundId = PlaySound({ Name = "/SFX/WrathStartNoEmote", Id = CurrentRun.Hero.ObjectId })

	local wrathPresentationOffsetY = 150
	local wrathStreak = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_UI" })
	SetScaleX({ Id = wrathStreak, Fraction = ScreenScaleX, Duration = 0 })
	Teleport({ Id = wrathStreak, OffsetX = ScreenCenterX, OffsetY = 800 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { wrathStreak } })
	CreateAnimation({ Name = "WrathPresentationStreak", DestinationId = wrathStreak, Color = LootData[godName .. "Upgrade"].LootColor })

	local godImage = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_Menu" })
	Teleport({ Id = godImage, OffsetX = -300, OffsetY = (1080/2) + 80 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { godImage } })
	SetAnimation({ Name = LootData[godName .. "Upgrade"].WrathPortrait, DestinationId = godImage, Scale = "1.0" })

	local wrathStreakFront = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_Menu_Overlay" })
	Teleport({ Id = wrathStreakFront, OffsetX = ScreenCenterX - (ScreenWidth * 0.03125), OffsetY = 1150 + wrathPresentationOffsetY })
	SetScaleX({ Id = wrathStreakFront, Fraction = ScreenScaleX, Duration = 0 })
	DrawScreenRelative({ Ids = { wrathStreakFront } })
	CreateAnimation({ Name = "WrathPresentationBottomDivider", DestinationId = wrathStreakFront, Scale = "1.25", Color = LootData[godName .. "Upgrade"].LootColor })

	local wrathVignette = CreateScreenObstacle({ Name = "BlankObstacle", Group = "FX_Standing_Top", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	CreateAnimation({ Name = "WrathVignette", DestinationId = wrathVignette, Color = LootData[godName .. "Upgrade"].LootColor })

	thread( ShoutSlow )

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	Move({ Id = godImage, Angle = 8, Distance = 800, Duration = 0.2, EaseIn = 0.2, EaseOut = 1, TimeModifierFraction = 0 })
	Move({ Id = wrathStreakFront, Angle = 8, Distance = 200, Duration = 0.5, EaseIn = 0.9, EaseOut = 1, TimeModifierFraction = 0 })
	Move({ Id = playerImage, Angle = 170, Speed = 50, TimeModifierFraction = 0 })

	SetColor({ Id = godImage, Color = {0, 0, 0, 1}, Duration = 0.05, TimeModifierFraction = 0 })
	SetColor({ Id = wrathVignette, Color = {0, 0, 0, 0.4}, Duration = 0.05, TimeModifierFraction = 0 })

	waitUnmodified( 0.25, RoomThreadName )
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1, Delay = 0 })
	Move({ Id = godImage, Angle = 8, Distance = 100, Duration = 1, EaseIn = 0.5, EaseOut = 0.5, TimeModifierFraction = 0 })
	Move({ Id = wrathStreakFront, Angle = 8, Distance = 25, Duration = 1, EaseIn = 0.5, EaseOut = 1, TimeModifierFraction = 0 })

	waitUnmodified( 0.35, RoomThreadName )
	thread( PlayVoiceLines, LootData[sourceName].ShoutVoiceLines, false, LootData[sourceName] )

	waitUnmodified( 0.35, RoomThreadName )

	if IsEmpty( SessionMapState.LockCameraMotion ) then
		FocusCamera({ Fraction = currentRun.CurrentRoom.ZoomFraction or 0.75, Duration = 0.25, ZoomType = "Ease" })
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })

	waitUnmodified( 0.1, RoomThreadName )
	SetColor({ Id = godImage, Color = {1,1,1,1}, Duration = 0.1, TimeModifierFraction = 0 })
	waitUnmodified( 0.1, RoomThreadName )

	SetAlpha({ Id = godImage, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })
	SetAlpha({ Id = wrathVignette, Fraction = 0, Duration = 0.06 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.06 })
	thread( CleanUpShoutPresentation, godName, godImage, { godImage, wrathStreak, wrathStreakFront, wrathVignette })

	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.WrathReactionVoiceLines ~= nil then
			local currentHealthFraction = enemy.Health / enemy.MaxHealth
			if enemy.WrathReactionVoiceLines ~= nil and currentHealthFraction > (enemy.WrathReactionVoiceLineMinHealthThreshold or 0) then
				thread( PlayVoiceLines, enemy.WrathReactionVoiceLines, nil, enemy )
			end
		end
	end
	
	SetPlayerVulnerable( "Super" )
	ShowCombatUI("SuperPresentation")
end

function ShoutSlow()
	for k, simData in ipairs( CurrentRun.Hero.ShoutSlowParameters or HeroData.ShoutSlowParameters ) do
		waitUnmodified(  simData.ScreenPreWait )
		if simData.Fraction < 1.0 then
			AddSimSpeedChange( "WeaponHit", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
		else
			RemoveSimSpeedChange( "WeaponHit", { LerpTime = simData.LerpTime } )
		end
	end
end

function CleanUpShoutPresentation( godName, portraitId, destroyIds )
	waitUnmodified(  0.08 )
	StopSound({ Id = AudioState.ShoutEffectSoundId, Duration = 0.2 })
	AudioState.ShoutEffectSoundId = nil
	waitUnmodified(0.28)
	Destroy({ Ids = destroyIds })
end

function DelayedHephaestusLeapPresentation( delay, animName, destinationId, playSpeed)
	wait( delay )
	CreateAnimation({ Name = animName, DestinationId = destinationId, PlaySpeed = playSpeed })
end

function FirstTimeDuoTalentPresentation( spellBackingId )
	CreateAnimation({ Name = "BoonEntranceDuo", DestinationId = spellBackingId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
end