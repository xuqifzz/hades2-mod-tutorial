function SpellReloadPresentation( owner, weaponData )
	local traitData = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
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

	CreateAnimation({ Name = "BoonGetBlack", DestinationId = buttonId, Scale = 1.0, GroupName = "Combat_Menu" })
	CreateAnimation({ Name = "BoonGet", DestinationId = buttonId, Scale = 1.0, GroupName = "Combat_Menu_Additive" })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonChoiceConfirm", Id = buttonId })

	thread( PlayVoiceLines, voiceLines, true, screen.Source )

	waitUnmodified(0.4, RoomThreadName)
end

function SpellPotionUsedPresentation( owner, weaponData )
	thread( PlayVoiceLines, GlobalVoiceLines.UsedHealDropVoiceLines, true )
end

function SpellSummonPresentation( newEnemy )
	PlaySound({ Name = "/SFX/Menu Sounds/LegendaryBoonShimmer2", Id = newEnemy.ObjectId })
	CreateAnimation({ Name = "SorcerySummonPresentationFx", DestinationId = newEnemy.ObjectId })
end
function TeleportSummonPresentation( enemyId )
	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = enemyId })
end

function SpellFailToFirePresentation( triggerArgs )
	if SessionMapState.ActiveGiftableUseTarget then
		return
	end
	
	local traitData = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Slot == "Spell" then
			traitData = trait
			break
		end
	end
	if traitData then
		local existingTraitData = GetExistingUITrait( traitData )
		if existingTraitData and existingTraitData.TraitActiveOverlay then
			CreateAnimation({ Name = "ActiveTraitCooldownSpellNotReady", DestinationId = existingTraitData.TraitActiveOverlay })
			PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = CurrentRun.Hero.ObjectId })
		end
		if existingTraitData and existingTraitData.TraitInfoCardId then
			thread( PulseText, { Id = existingTraitData.TraitInfoCardId, Color = Color.Red, OriginalColor = Color.White, ScaleTarget = 1.2, ScaleDuration = 0.1, HoldDuration = 0.1, PulseBias = 0.1 } )
		end

		if CheckCountInWindow( "SpellFailedToFire", 1.0, 4 ) and CheckCooldown("AttackNotReady", 1.0) then
			thread( PlayVoiceLines, HeroVoiceLines.SpellNotReadyVoiceLines, true )
			thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Spell_NotReady", PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
		end

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
		if not SessionMapState.SpellWorldReadyFxId then
			SessionMapState.SpellWorldReadyFxId = SpawnObstacle({ Name = "BlankObstacle", Destination = CurrentRun.Hero.ObjectId, Group = "Combat_UI_World_Backing" })
			SetAnimation({ Name = "SorceryReadyMoonLoopIn", DestinationId = SessionMapState.SpellWorldReadyFxId })
			Attach({ Id = SessionMapState.SpellWorldReadyFxId, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end

-- note: PolymorphApplyPresentation & others in CombatPresentation
function SpellPolymorphResistedPresentation( enemy )
	if enemy.ResistedVoiceLines then
		thread( PlayVoiceLines, enemy.ResistedVoiceLines, nil, enemy )
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
		return
	end

	if trait.TraitInfoCardId == nil then
		trait.TraitInfoCardId = CreateScreenObstacle({ Name = "TraitTray_LevelBacking", Group = "Combat_Menu_TraitTray_Labels" })
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 1, Duration = 0.2 })
		Attach({ Id = trait.TraitInfoCardId, DestinationId = anchorId, OffsetY = 32 })
	else
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 1, Duration = 0.2 })	
	end

	local data = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
	local manaSpend = GetManaSpendCost( data )
	local remainingSpend = math.max( manaSpend - CurrentRun.SpellCharge, 0 )
	if remainingSpend > 0 then
		CreateTextBox({
			Id = trait.TraitInfoCardId,
			Text = "UI_SpellCharge", Font = "NumericP22UndergroundSCMedium",
			Color = Color.White, FontSize = 22, 
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
			OffsetX = xOffset - 2, OffsetY = yOffset - 1,
			Justification = "Center",
			LuaKey = "TempTextData",
			LuaValue = { CurrentSpend = math.min( CurrentRun.SpellCharge, manaSpend ), RequiredSpend = manaSpend, RemainingSpend = remainingSpend },
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})
	else	
		SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 0, Duration = 0.2 })
	end

	yOffset = yOffset - 70
	if ( trait.RemainingUses ~= nil or trait.Uses ~= nil ) and not trait.UsesAsRooms then
		local time = trait.RemainingUses or trait.Uses
		if trait.TraitInfoUsesId == nil then
			trait.TraitInfoUsesId  = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Labels" })
			SetAlpha({ Id = trait.TraitInfoUsesId , Fraction = 1, Duration = 0.2 })
			Attach({ Id = trait.TraitInfoUsesId , DestinationId = anchorId, OffsetY = 32 })
			CreateTextBox({
				Id = trait.TraitInfoUsesId,
				Text = "UI_Uses",
				Font = "NumericP22UndergroundSCMedium", 
				FontSize = 22,
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				OffsetX = xOffset, OffsetY = yOffset,
				Justification = "Center",
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			})
		else
			SetAlpha({ Id = trait.TraitInfoUsesId, Fraction = 1, Duration = 0.2 })	
			ModifyTextBox({ 
				Text = "UI_Uses",
				Id = trait.TraitInfoUsesId,
				LuaKey = "TempTextData",
				LuaValue = { Time = math.floor(time) },
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			})
		end
		
		xOffset = xOffset + 40
	end
end

function SpellChargeNumber( traitData, manaSpendCost, remainingSpend)
	ModifyTextBox({ Id = traitData.TraitInfoCardId, Text = "UI_SpellCharge", LuaKey = "TempTextData", LuaValue = { CurrentSpend = math.min( CurrentRun.SpellCharge, manaSpendCost ), RequiredSpend = manaSpendCost, RemainingSpend = remainingSpend },})
	PulseText({ Id = traitData.TraitInfoCardId, ScaleTarget = 1.04, ScaleDuration = 0.1, HoldDuration = 0.05, Color = Color.LightBlue, OriginalColor = Color.White})
end

function SpellActivateTrait( traitData )
	TraitUIDeactivateTrait( traitData ) 
	if traitData.TraitInfoCardId ~= nil then
		Destroy({ Id = traitData.TraitInfoCardId })
		traitData.TraitInfoCardId = nil
	end
	if traitData.AnchorId then
		StopAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId })
		CreateAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
	end
end

function SpellUnreadyPresentation( traitData )
	-- Stop any looping animations here 
	StopAnimation({ Name = "HexReadyLoop", DestinationId = traitData.AnchorId })	
	if SessionMapState.SpellWorldReadyFxId then
		SetAnimation({ Name = "SorceryReadyMoonLoopOut", DestinationId = SessionMapState.SpellWorldReadyFxId })
		thread( DestroyOnDelay, { SessionMapState.SpellWorldReadyFxId },  0.5 )
		SessionMapState.SpellWorldReadyFxId = nil
	end
end

function SpellHasManaPresentation()
	local traitData = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
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
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
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
		for i, trait in pairs( CurrentRun.Hero.Traits ) do
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
	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
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

function SpellChargeEndPresentation()
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
	thread( PlayVoiceLines, GlobalVoiceLines.SpellReactionVoiceLines )
end
