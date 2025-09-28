function PlayInteractAnimation( interactableObjectId, args )
	args = args or {}

	if not args.SkipInputBlock then
		AddTimerBlock( CurrentRun, "MelinoeInteractEquip" )
		AddInputBlock({ Name = "MelinoeInteractEquip" })
	end

	SetAnimation({ Name = args.Animation or GetEquippedWeaponValue( "InteractAnimation" ) or "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = interactableObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.1 }, } )
	if interactableObjectId then
		waitUnmodified( 0.08 )
	end
	if not args.SkipInputBlock then
		thread( RemoveInteractAnimationInputBlock )
	end
	waitUnmodified( 0.08 )
end

function GetEquippedWeaponValue( key )
	local weaponInteractAnim = nil
	for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = WeaponData[weaponName]
		if weaponData ~= nil and weaponData[key] ~= nil then
			return weaponData[key]
		end
	end
	return nil
end

function PickupWeaponKitInteractPresentation( weaponKit )
	AddInputBlock({ Name = "MelinoeInteractEquip" })
	SetAnimation({ Name = "Melinoe_InteractToEquip", DestinationId = CurrentRun.Hero.ObjectId })
	--CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = weaponKit.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )
	if interactableObjectId then
	--	wait( 0.08 )
	--	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	end
	thread( RemoveInteractAnimationInputBlock )
	wait( 0.11 )
	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.5 })
end


function PlayUnequipAnimation( args )
	wait( 0.35 )
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
		wait( 0.34 )
		CreateAnimation({ Name = "HecateTeleportFxFrontFast", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, Scale = 0.60, DrawGroup = "FX_Standing_Add" })
	end
end

function PreNarrativeUnequipAnimation()
	if SessionMapState.WeaponsDisabled then
		return false
	end
	Halt({ Id = CurrentRun.Hero.ObjectId })
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
	else
		SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function RemoveInteractAnimationInputBlock()
	wait( 0.25 )
	RemoveInputBlock({ Name = "MelinoeInteractEquip" })
	RemoveTimerBlock( CurrentRun, "MelinoeInteractEquip" )
end

function SpecialInteractSaluteInterrupt( usee, args )
	ActivityInterrupt( usee, args )
	SpecialInteractSalute( usee, args )
end

function SpecialInteractSalute( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractSalute" })

	if SessionMapState.WeaponsDisabled then
		wait( 0.10 )
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	else
		local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
		SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
		wait( 0.65 )
	end
	--SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, usee.InteractVoiceLines or GlobalVoiceLines.SaluteVoiceLines, true, usee )

	wait( 0.5 )
	if usee.TurnInPlaceAnimation ~= nil then
		AngleNPCToHero( usee )
	end
	wait( 0.75 )
	RemoveInputBlock({ Name = "SpecialInteractSalute" })
end

function SpecialInteractSaluteBroker( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractSalute" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	wait( 0.10 )
	--SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, usee.InteractVoiceLines or GlobalVoiceLines.SaluteVoiceLines, true, usee )
	local emoteName = "StatusIconSmile"
	if RandomChance( 0.25 ) then
		emoteName = "StatusIconEmbarrassed"
	end
	thread( PlayEmoteSimple, usee, { AnimationName = emoteName, OffsetZ = usee.EmoteOffsetZ, Group = "Combat_UI_Backing", Delay = 1.15, BlockIfSourceHasStatusAnimation = true } )
	wait( 1.15 )
	PlaySound({ Name = usee.SaluteSound or "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = usee.ObjectId })
	wait( 0.15 )
	RemoveInputBlock({ Name = "SpecialInteractSalute" })
end

function SpecialInteractThreatenChronos( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractSalute" })

	if SessionMapState.WeaponsDisabled then
		wait( 0.10 )
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	else
		local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
		SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
		wait( 0.65 )
	end
	--SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, usee.InteractVoiceLines, true, usee )

	wait( 0.5 )
	if usee.TurnInPlaceAnimation ~= nil then
		AngleNPCToHero( usee )
	end
	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractSalute" })
end

function SpecialInteractShade( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractShade" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	wait( 0.10 )
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, true, usee )
	if RandomChance( 0.75 ) then
		thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconSmile", OffsetZ = 58, Delay = 0.6 } )
	else
		--
	end
	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractShade" })
	wait( 29.25, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
end

function SpecialInteractDieHardFanShade( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractShade" })

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, true, usee )

	wait( 0.65 )

	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	if GameState.SpecialInteractRecord.DieHardFanShade == 1 then
		thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconSmileRed", OffsetZ = usee.EmoteOffsetZ, Delay = 2.0 } )
	else
		thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconSmileRed", OffsetZ = usee.EmoteOffsetZ, Delay = 0.6 } )
	end
	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractShade" })
end

function SpecialInteractLightRanged( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractShade" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	wait( 0.10 )
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Enemy_LightRanged_CastFire", DestinationId = usee.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, true, usee )
	thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconSmile", OffsetZ = 60, Delay = 0.25 } )
	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractShade" })
	wait( 29.25, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
end

function LightRangedSalute( usee, args )
	args = args or {}

	local frontShadeIds = { 575866, 575867 }
	local rearShadeIds = { 575859, 575860 }
	local shade1 = RemoveRandomValue( frontShadeIds )
	local shade2 = RemoveRandomValue( frontShadeIds )
	local shade3 = RemoveRandomValue( rearShadeIds )
	local shade4 = RemoveRandomValue( rearShadeIds )

	local saluePlaySpeed = RandomFloat( 0.5, 1.0 )

	wait(args.WaitTime or 0.2)
	SetAnimation({ Name = "Enemy_LightRanged_Salute", DestinationId = shade1, SpeedMultiplier = saluePlaySpeed })
	-- thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconDisgruntled", Delay = 0.2, ChanceToPlay = 0.25, TargetId = shade1 } )
	wait(0.15)
	SetAnimation({ Name = "Enemy_LightRanged_Salute", DestinationId = shade2, SpeedMultiplier = saluePlaySpeed })
	-- thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconDisgruntled", Delay = 0.2, ChanceToPlay = 0.25, TargetId = shade2 } )
	wait(0.45)
	SetAnimation({ Name = "Enemy_LightRanged_Salute", DestinationId = shade3, SpeedMultiplier = saluePlaySpeed })
	-- thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconDisgruntled", Delay = 0.2, ChanceToPlay = 0.25, TargetId = shade3 } )
	wait(0.15)
	SetAnimation({ Name = "Enemy_LightRanged_Salute", DestinationId = shade4, SpeedMultiplier = saluePlaySpeed })
	-- thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconSmile", Delay = 0.2, ChanceToPlay = 0.25, TargetId = shade4 } )
end

function SpecialInteractSirenFan( source, args )
	wait( 0.10 )
	-- local reactionId = GetId({ Name = "CrowdReaction" })
	local reactionId = 595279
	if RandomChance( 0.25 ) then
		thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconFiredUp", OffsetZ = 125, Delay = 1.15, TargetId = reactionId } )
	else
		thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconDisgruntled", OffsetZ = 125, Delay = 1.15, TargetId = reactionId } )
	end
	wait( 1.15 )
	PlaySound({ Name = source.SaluteSound or "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = reactionId })
end

function HugZagreus( usee, args )

	args = args or {}
	AddInteractBlock( usee, "Hugging" )
	AddInputBlock({ Name = "HugZagreus" })
	SetupMelWalk( usee, args )

	-- Move to hugging position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "MelinoeIdle", DestinationId = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngle({ Id = usee.ObjectId })
	local offset = CalcOffset( math.rad(angle), 70 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId, Duration = 0 })
	wait( 0.3 )
	SetAnimation({ Name = "Zagreus_Hug_Start", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Hug_Start", DestinationId = CurrentRun.Hero.ObjectId })
	if not args.Silent then
		thread( PlayVoiceLines, usee.InteractVoiceLines )
	end
	wait( 2.5 )
	SetAnimation({ Name = "Zagreus_Hug_End", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Hug_End", DestinationId = CurrentRun.Hero.ObjectId })

	RestoreMelRun( usee, { SkipWalkStopAnimation = true } )
	RemoveInputBlock({ Name = "HugZagreus" })

	-- allow hugging again after a brief cooldown
	wait( 2.0, RoomThreadName )
	RemoveInteractBlock( usee, "Hugging" )

end

function HugHecate( usee )

	AddInputBlock({ Name = "HugHecate" })

	-- Move to hugging position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngle({ Id = usee.ObjectId })
	local offset = CalcOffset( math.rad(angle), 50 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId, Duration = 0 })
	wait( 0.3 )
	SetAnimation({ Name = "Hecate_Hub_Hug_Start", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Hug_Start", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 4.0 )
	SetAnimation({ Name = "Hecate_Hub_Hug_End", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Hug_End", DestinationId = CurrentRun.Hero.ObjectId })

	RemoveInputBlock({ Name = "HugHecate" })

end

function HugPersephone( usee, args )

	args = args or {}

	AddInteractBlock( usee, "Hugging" )
	AddInputBlock({ Name = "HugPersephone" })
	SetupMelWalk( usee, args )

	-- Move to hugging position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "MelinoeIdle", DestinationId = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngle({ Id = usee.ObjectId })
	local offset = CalcOffset( math.rad(angle), 70 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId, Duration = 0 })
	wait( 0.3 )
	SetAnimation({ Name = "Persephone_Hug_Start", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Hug_Start", DestinationId = CurrentRun.Hero.ObjectId })
	if not args.Silent then
		thread( PlayVoiceLines, usee.InteractVoiceLines )
	end
	wait( 2.5 )
	SetAnimation({ Name = "Persephone_Hug_End", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Hug_End", DestinationId = CurrentRun.Hero.ObjectId })

	RestoreMelRun( usee, { SkipWalkStopAnimation = true } )
	RemoveInputBlock({ Name = "HugPersephone" })

	-- allow hugging again after a brief cooldown
	wait( 2.0, RoomThreadName )
	RemoveInteractBlock( usee, "Hugging" )

end

function PlantAdmirePresentation( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "PlantAdmirePresentation" })

	--SetAnimation({ Name = "MelinoeGatherStart", DestinationId = CurrentRun.Hero.ObjectId })
	--AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	-- PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.1 )
	thread( PlayVoiceLines, HeroVoiceLines.PlantInteractVoiceLines, true, usee )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 1.85 )
	RemoveInputBlock({ Name = "PlantAdmirePresentation" })
end

function GhostRecruitSpecialInteractPresentation( ghost, user )
	UseableOff({ Id = ghost.ObjectId })
	AddInputBlock({ Name = "GhostRecruitSpecialInteractPresentation" })
	if SessionMapState.WeaponsDisabled then
		wait( 0.10 )
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = ghost.ObjectId })
	else
		local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
		SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = ghost.ObjectId })
		wait( 0.65 )
	end
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, false, ghost )
	if RandomChance( 0.75 ) then
		thread( PlayEmoteSimple, ghost, { AnimationName = "StatusIconSmile", Delay = 1.2 } )
	else
		thread( PlayEmoteSimple, ghost, { AnimationName = "StatusIconOhBoy", Delay = 1.2 } )
	end
	wait( 1.25 )
	RemoveInputBlock({ Name = "GhostRecruitSpecialInteractPresentation" })
	wait( 120, RoomThreadName )
	if not ghost.UseableToggleBlocked then
		UseableOn({ Id = ghost.ObjectId })
	end
end

function NarcissusDropPresentation( consumable, args )
	CreateAnimation({ Name = "MoneyShowerLarge", DestinationId = args.DestinationId})
	SetScale({ Id = consumable.ObjectId, Fraction = 1.5, Duration = 0.5 })
	wait(0.5)
	SetScale({ Id = consumable.ObjectId, Fraction = 1.0, Duration = 0.5 })
end

function SpellPotionRefillPresentation( fountain, user, potionTrait, delay )
	wait(delay)
	CreateAnimation({ Name = "SpellPotionRefill", DestinationId = fountain.ObjectId, })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "SpellPotionRefilled", 1.0 )
end

function ErisLitterPresentation( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Enemy_Eris_Hub_Toss" })
end

function ManaDropUsePresentation( args, consumable )
	SetAnimation({ Name = "PoseidonManaDropletDissipate", DestinationId = consumable.ObjectId })
	if CurrentRun.Hero.Mana < CurrentRun.Hero.MaxMana then
		CreateAnimation({ Name = "ManaRegenFlashFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
	PlaySound({ Name = "/SFX/ManaDropSFX", Id = CurrentRun.Hero.ObjectId })
	Move({ Id = consumable.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, SuccessDistance = 50, Duration = 0.2 })
	wait ( 0.15 )
end

function BloodDropUsePresentation( args, consumable )
	PlaySound({ Name = "/SFX/Player Sounds/AresBlooddropPickup", Id = CurrentRun.Hero.ObjectId })
	Move({ Id = consumable.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, SuccessDistance = 50, Duration = 0.2 })
end