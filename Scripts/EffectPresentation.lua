function EffectApplyPresentation( victim, effectData, args )
	if effectData == nil then
		return
	end
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end
	if not args.Reapplied and ( not victim.IsDead or ( victim == CurrentRun.Hero and victim.IsDead and CurrentHubRoom ~= nil )) and (not effectData.VfxRequiresTimeSlow or not victim.IgnoreTimeSlowEffects) then
		local effectZ = effectData.OffsetZ or 0
		local victimZ = victim.EffectVfxOffsetZ or 0
		local scale = victim.EffectVfxScale or 1 
		if effectData.Vfx ~= nil then
			CreateAnimation({ Name = effectData.Vfx, DestinationId = victim.ObjectId, OffsetZ = victimZ + effectZ * scale, Scale = scale})
		end
		if effectData.BackVfx ~= nil then
			CreateAnimation({ Name = effectData.BackVfx, DestinationId = victim.ObjectId, OffsetZ = victimZ + effectZ * scale, Scale = scale })
		end
	end
end

function UpdateEffectStacks( unit, effectName )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local unitId = unit.ObjectId
	local effectData = EffectData[effectName]
	if effectData == nil or effectData.DisplaySuffix == nil or ( unit.HideHealthBar and (not effectData.IgnoreHideHealthBarOnUnits or not effectData.IgnoreHideHealthBarOnUnits[unit.Name] )) then
		return
	end 
	if unit == CurrentRun.Hero and effectData.HideOnHero then
		return
	end
	local displaySuffix = effectData.DisplaySuffix
	local numShared = 0
	
	for activeEffectName, stacks in pairs( unit.ActiveEffects ) do
		local activeEffectData = EffectData[activeEffectName]
		if activeEffectData and activeEffectData.DisplaySuffix == displaySuffix then
			numShared = numShared + stacks
		end
	end

	unit.EffectTextBoxes = unit.EffectTextBoxes or {}
	
	local baseKey = unitId..displaySuffix
	local timerKey = baseKey.."timer"
	if numShared == 0 then
		if unit.CreatedDisplayAnchors[baseKey] ~= nil then
			SetAlpha({ Id = unit.CreatedDisplayAnchors[baseKey], Fraction = 0, Duration = 0.1 })
			if effectData.AttachIconToUnit and effectData.AttachToMarker and unit.UniqueIconAttachments and unit.UniqueIconAttachments[effectData.DisplaySuffix] then
				-- Need to Unattach in case of Polymorph
				Unattach({ Id = unit.CreatedDisplayAnchors[unit.ObjectId..effectData.DisplaySuffix], DestinationId = unit.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset })
			end
		end
		if unit.CreatedDisplayAnchors[timerKey] ~= nil then			
			SetAlpha({ Id = unit.CreatedDisplayAnchors[timerKey], Fraction = 0, Duration = 0.1 })
		end
	else

		local icon = effectData.Icon
		local startIconScale = 1.3
		local scaleTarget = 1.0
		local statusFontColor = effectData.Color or Color.White

		if EnemyHealthDisplayAnchors[unitId] == nil then
			CreateHealthBar( unit )
			UpdateHealthBar( unit, 0, { Force = true })
		end
		if icon ~= nil then
			if unit.CreatedDisplayAnchors[baseKey] == nil then
				local backingId = nil
				local scale = 1
				if unit.BarXScale then
					scale = unit.BarXScale
				end
				if unit.UseBossHealthBar and not ( effectData.AttachIconToUnit or unit.UseGroupHealthBar) then
					unit.EffectTextBoxes[displaySuffix] = true
					backingId = CreateScreenObstacle({ Name = icon, Group = "Combat_Menu", DestinationId = EnemyHealthDisplayAnchors[unitId] })
					CreateTextBox({ Id = backingId, FontSize = 20, OffsetX = 15, OffsetY = 17,
						Font = "P22UndergroundSCHeavy",
						Justification = "Left",
						ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 2}, ShadowBlur = 0,
						OutlineThickness = 10, OutlineColor = {0,0,0,1},
					})
				else
					backingId = SpawnObstacle({ Name = icon, Group = "Combat_UI_World", DestinationId = unitId, TriggerOnSpawn = false, OffsetY = -30 })
				end
				SetAlpha({ Id = backingId, Fraction = 0, Duration = 0 })
				
				if effectData.ShowDuration and effectData.EffectData and effectData.EffectData.Duration then
					local timerId = nil
					if unit.UseBossHealthBar and not ( effectData.AttachIconToUnit or unit.UseGroupHealthBar) then
						timerId = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_Menu", DestinationId = unitId })
					else
						timerId = SpawnObstacle({Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = unitId })
					end
					Attach({ Id = timerId, DestinationId = backingId })
					SetAnimation({ Name = "PortraitRespawnFill10", DestinationId = timerId, PlaySpeed = 1 / effectData.EffectData.Duration, Scale = 0.37 })
					local timeRemaining = GetEffectTimeRemaining({ Id = unitId, EffectName = effectData.Name})
					if timeRemaining ~= 0 then
						SetAnimationFrameTarget({ Name = "PortraitRespawnFill10", Fraction = 1 - timeRemaining / effectData.EffectData.Duration, DestinationId = timerId, Instant = true })
						SetAnimationFrameTarget({ DestinationId = timerId, Name = "PortraitRespawnFill10", Fraction = 1 })
					end

					unit.CreatedDisplayAnchors[timerKey] = timerId
					if effectData.DurationAlpha then
						SetAlpha({ Id = timerId, Fraction = effectData.DurationAlpha, Duration = 0 })
					end
				end

				SetAlpha({ Id = backingId, Fraction = 1, Duration = 0.1 })
				unit.CreatedDisplayAnchors[baseKey] = backingId
			else
				local iconId = unit.CreatedDisplayAnchors[baseKey]
				SetAlpha({ Id = iconId, Fraction = 1, Duration = 0.1 })
				
				if unit.CreatedDisplayAnchors[timerKey] then
					local timerId = unit.CreatedDisplayAnchors[timerKey]
					SetAlpha({ Id = timerId, Fraction = 1, Duration = 0.1 })
					SetAnimation({ Name = "PortraitRespawnFill10", DestinationId = timerId, PlaySpeed = 1 / effectData.EffectData.Duration, Scale = 0.37 })
					local timeRemaining = GetEffectTimeRemaining({ Id = unitId, EffectName = effectData.Name})
					if timeRemaining == 0 then
						timeRemaining = effectData.EffectData.Duration
					end
					if timeRemaining ~= 0 then
						SetAnimationFrameTarget({ Name = "PortraitRespawnFill10", Fraction = 1 - timeRemaining / effectData.EffectData.Duration, DestinationId = timerId, Instant = true })
						SetAnimationFrameTarget({ DestinationId = timerId, Name = "PortraitRespawnFill10", Fraction = 1 })
					end

					if effectData.DurationAlpha then
						SetAlpha({ Id = timerId, Fraction = effectData.DurationAlpha, Duration = 0 })
					end
				end
			end
		end
		
		if unit.CreatedDisplayAnchors[timerKey] and effectData.ShowDuration and effectData.EffectData and effectData.EffectData.Duration and ( effectData.EffectData.ExtendDurationOnReapply == nil or effectData.EffectData.ExtendDurationOnReapply ) then
			SetAnimationFrameTarget({ DestinationId = unit.CreatedDisplayAnchors[timerKey], Name = "PortraitRespawnFill10", Fraction = 0, Instant = true })
			SetAnimationFrameTarget({ DestinationId = unit.CreatedDisplayAnchors[timerKey], Name = "PortraitRespawnFill10", Fraction = 1 })
		end
		if effectData.ScaleArgs then
			local args = effectData.ScaleArgs
			local targetScale = startIconScale
			if numShared <= args.ScaleMinBelow then
				targetScale = args.MinScale
			elseif numShared >= args.ScaleMaxAbove then
				targetScale = args.MaxScale
			else
				targetScale = Lerp( args.MinScale, args.MaxScale, (numShared - args.ScaleMinBelow) / ( args.ScaleMaxAbove - args.ScaleMinBelow))
			end
			SetScale({ Id = unit.CreatedDisplayAnchors[baseKey], Fraction = targetScale })
		else
			SetScale({ Id = unit.CreatedDisplayAnchors[baseKey], Fraction = startIconScale })
		end
		if effectData.TextSizeArgs then
			local args = effectData.TextSizeArgs
			if numShared <= args.MinBelow then
				scaleTarget = args.MinScale
			elseif numShared >= args.MaxAbove then
				scaleTarget = args.MaxScale
			else
				scaleTarget= Lerp( args.MinScale, args.MaxScale, (numShared - args.MinBelow) / ( args.MaxAbove - args.MinBelow))
			end
		end
		if numShared > 1 and not effectData.HideStacks then
			if unit.EffectTextBoxes[displaySuffix] then
				ModifyTextBox({ Id = unit.CreatedDisplayAnchors[baseKey], Text = numShared, ScaleTarget = scaleTarget, Color = statusFontColor })
			else
				unit.EffectTextBoxes[displaySuffix] = true
				CreateTextBox({ Id = unit.CreatedDisplayAnchors[baseKey], FontSize = 20, OffsetX = 0, OffsetY = -2,
					Text = numShared,
					Font = "P22UndergroundSCHeavy",
					Justification = "Center",
					ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 2}, ShadowBlur = 0,
					OutlineThickness = 10, OutlineColor = {0,0,0,1},
					Color = statusFontColor
				})
			end
		else
			if unit.EffectTextBoxes[displaySuffix] then
				ModifyTextBox({ Id = unit.CreatedDisplayAnchors[baseKey], Text = " ", ScaleTarget = scaleTarget, Color = statusFontColor })
			end
		end
	end
	PositionEffectStacks( unit )
end

function PositionEffectStacks( unit )
	local id = unit.ObjectId

	local effects = {}
	local effectsAdded = {}
	for effectName in pairs( unit.ActiveEffects ) do
		local effectData = EffectData[effectName]
				
		if effectData and effectData.DisplaySuffix and not effectsAdded[effectData.DisplaySuffix] then
			if effectData.AttachIconToUnit then
				if not unit.IsPolymorphed and effectData.AttachToMarker and unit.UniqueIconAttachments and unit.UniqueIconAttachments[effectData.DisplaySuffix] then
					local offset = { X = effectData.IconXOffset or 0 , Y = effectData.IconYOffset or 0 }
					if unit.UniqueIconOffsets and unit.UniqueIconOffsets[effectData.DisplaySuffix] then
						offset.X = offset.X + unit.UniqueIconOffsets[effectData.DisplaySuffix].X
						offset.Y = offset.Y + unit.UniqueIconOffsets[effectData.DisplaySuffix].Y
					end
					Attach({ Id = unit.CreatedDisplayAnchors[ id .. effectData.DisplaySuffix ], DestinationId = unit.ObjectId, OffsetY = offset.Y, OffsetX = offset.X, MarkerName = unit.UniqueIconAttachments[effectData.DisplaySuffix] })
				else
					Attach({ Id = unit.CreatedDisplayAnchors[ id .. effectData.DisplaySuffix ], DestinationId = unit.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset })
				end
			elseif effectData.AttachIconToHealthbar and not unit.UseGroupHealthBar and EnemyHealthDisplayAnchors[id] then
				--taken from Minos
				local offsetX = effectData.OffsetX or 0
				local offsetY = effectData.OffsetY or 0
				if unit.UseBossHealthBar then
					offsetX = offsetX + 360
					if unit.BarXScale then
						offsetX = offsetX * unit.BarXScale
					end
				else
					local barScale = unit.BarXScale or 1
					offsetX = offsetX + barScale * 98 /2 + 25
					offsetY = offsetY + 3
				end
				Attach({ Id = unit.CreatedDisplayAnchors[ id .. effectData.DisplaySuffix ], DestinationId = EnemyHealthDisplayAnchors[id], OffsetX = offsetX, OffsetY = offsetY,  })
			elseif effectData.Icon then
				table.insert( effects, unit.CreatedDisplayAnchors[ id .. effectData.DisplaySuffix ])
			end
			effectsAdded[effectData.DisplaySuffix] = true 
		end
	end
	local spacing = 45
	if unit.UseBossHealthBar and not unit.UseGroupHealthBar then
		spacing = 60
	end
	local width = (TableLength( effects ) - 1) * spacing

	for i, effectId in pairs( effects ) do
		if unit.UseBossHealthBar and not unit.UseGroupHealthBar then
			Attach({ Id = effectId, DestinationId = EnemyHealthDisplayAnchors[id], OffsetY = 25, OffsetX = ((i - 1) * spacing - width/2) })
		else
			Attach({ Id = effectId, DestinationId = EnemyHealthDisplayAnchors[id], OffsetY = -27, OffsetX = ((i - 1) * spacing - width/2) })
		end
	end
end

function OctofishInkApply( triggerArgs, args )

	if not triggerArgs.Reapplied then
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = args.AnimationName })
	end
end

function OctofishInkClear( triggerArgs, args )
	StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = args.AnimationName })
end

function CastSpeedPresentation()
	PlaySound({ Name = "/SFX/Player Sounds/MelDashPressPoof", Id = CurrentRun.Hero.ObjectId })
end