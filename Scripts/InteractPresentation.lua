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

function PlayWeaponEquipAnimation( weaponKit )
	AddInputBlock({ Name = "MelinoeInteractEquip" })
	SetAnimation({ Name = weaponKit.OwnerEquipAnimation or GetEquippedWeaponValue( "InteractAnimation" ) or "MelinoeSpellFire", DestinationId = CurrentRun.Hero.ObjectId })
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
	local requirements =
	{
		NamedRequirements = { "WeaponsNotAllowed" },
	}
	if IsGameStateEligible( CurrentRun, requirements ) then
		return false
	end
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

function CantAffordWeaponKitPresentation( weaponKit )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = weaponKit.ObjectId })
	Flash({ Id =  weaponKit.TextAnchorId, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	Shake({ Id = weaponKit.ObjectId, Distance = 6, Speed = 300, Duration = 0.2 })
	Shake({ Id = weaponKit.TextAnchorId, Distance = 6, Speed = 300, Duration = 0.2 })
	thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
end

function PreWeaponKitUnlockPresentation( weaponKit )
	HideUseButton( weaponKit.ObjectId, weaponKit )
	SetAnimation({ DestinationId = weaponKit.TextAnchorId, Name = "LockedIconRelease" })
	Shake({ Id = weaponKit.ObjectId, Distance = 3, Speed = 500, Duration = 0.65 })
	thread( PlayVoiceLines, HeroVoiceLines.WeaponKitUnlockedVoiceLines, true )
	PlayInteractAnimation( weaponKit.ObjectId )
	DestroyTextBox({ Id = weaponKit.TextAnchorId })
	wait(0.8)
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = weaponKit.ObjectId  })
	thread( WeaponUnlockedPresentation, weaponKit.Name )
end

function WeaponUnlockedPresentation( weaponName )

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.4 }, } )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	DisplayInfoBanner( nil, {
		TitleText = "WeaponUnlocked_Title",
		SubtitleText = "WeaponUnlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = weaponData.UnlockName or weaponName }},
		FontScale = 0.85,
		AnimationName = "LocationTextBGGeneric_WeaponUnlock",
		AnimationOutName = "LocationTextBGGenericOut_WeaponUnlock"
	})

end

function PostWeaponKitUnlockPresentation( weaponKit )
	wait( 1.5 )
	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.WeaponUnlockReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.WeaponUnlockReactionVoiceLines, true, enemy )
		end
	end
end

function SpecialInteractSaluteInterrupt( usee, args )
	ActivityInterrupt( usee, args )
	SpecialInteractSalute( usee, args )
end

function SpecialInteractSalute( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractSalute" })

	if CurrentHubRoom ~= nil and not CurrentHubRoom.AllowWeapons then
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
	if RandomChance( 0.25 ) then
		thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconEmbarrassed", OffsetZ = 150, Delay = 1.15 } )
	else
		thread( PlayEmoteSimple, usee, { AnimationName = "StatusIconSmile", OffsetZ = 150, Delay = 1.15 } )
	end
	wait( 1.15 )
	PlaySound({ Name = usee.SaluteSound or "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = usee.ObjectId })
	wait( 0.15 )
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

function PlantAdmirePresentation( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "PlantAdmirePresentation" })

	--SetAnimation({ Name = "MelinoeGatherStart", DestinationId = CurrentRun.Hero.ObjectId })
	--AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", DestinationId = CurrentRun.Hero.ObjectId })
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
	if CurrentHubRoom ~= nil and not CurrentHubRoom.AllowWeapons then
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

function NarcissusPreDropPresentation( source, args )
	--PanCamera({ Ids = args.DropSourceId, Duration = 2.0, EaseIn = 0.05, EaseOut = 0.3 })
	--wait(2.0)
	--LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 6.0 })
end
function NarcissusDropPresentation( consumable, args )
	CreateAnimation({ Name = "MoneyShowerLarge", DestinationId = args.DestinationId})
	SetScale({ Id = consumable.ObjectId, Fraction = 1.5, Duration = 0.5 })
	wait(0.5)
	SetScale({ Id = consumable.ObjectId, Fraction = 1.0, Duration = 0.5 })
end

function SpellPotionRefillPresentation( fountain, user, potionTrait )
	CreateAnimation({ Name = "SpellPotionRefill", DestinationId = fountain.ObjectId, })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "SpellPotionRefilled", 1.0, { ShadowScaleX = 1.2 } )
end

function ErisLitterPresentation( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Enemy_Eris_Hub_Toss" })
end

function ManaDropUsePresentation( args, consumable )
	SetAnimation({ Name = "PoseidonManaDropletDissipate", DestinationId = consumable.ObjectId })
	if CurrentRun.Hero.Mana < CurrentRun.Hero.MaxMana then
		CreateAnimation({ Name = "ManaRegenFlashFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
	PlaySound({ Name = "/SFX/BloodstoneAmmoPickup", Id = CurrentRun.Hero.ObjectId })
	Move({ Id = consumable.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, SuccessDistance = 50, Duration = 0.2 })
	wait ( 0.15 )
end