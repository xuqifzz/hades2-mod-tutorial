function EffectApplyPresentation( victim, effectData, args )
	if effectData == nil then
		return
	end
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end
	if not args.Reapplied and not victim.IsDead then
		if effectData.Vfx ~= nil then
			CreateAnimation({ Name = effectData.Vfx, DestinationId = victim.ObjectId, OffsetZ = victim.EffectVfxOffsetZ, Scale = victim.EffectVfxScale })
		end
		if effectData.BackVfx ~= nil then
			CreateAnimation({ Name = effectData.BackVfx, DestinationId = victim.ObjectId, OffsetZ = victim.EffectVfxOffsetZ, Scale = victim.EffectVfxScale })
		end
	end
end

function UpdateEffectStacks( unit, effectName )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local unitId = unit.ObjectId
	local effectData = EffectData[effectName]
	if not effectData or not effectData.DisplaySuffix or unit.HideHealthBar then
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
	
	if numShared == 0 then
		Destroy({ Ids = { EnemyHealthDisplayAnchors[ unitId .. displaySuffix ], EnemyHealthDisplayAnchors[ unitId .. displaySuffix .. "timer" ] }})
		EnemyHealthDisplayAnchors[ unitId .. displaySuffix ] = nil
		EnemyHealthDisplayAnchors[ unitId .. displaySuffix .. "timer" ] = nil
		if unit.EffectSuffixNames then
			unit.EffectSuffixNames[displaySuffix] = nil
		end
	else
		unit.EffectSuffixNames = unit.EffectSuffixNames or {}
		unit.EffectSuffixNames[displaySuffix] = true

		local icon = effectData.Icon
		local startIconScale = 1.3		
		local scaleTarget = 1.0
		local statusFontColor = effectData.Color or Color.White

		if not EnemyHealthDisplayAnchors[unitId]  then
			CreateHealthBar( unit )
			UpdateHealthBar( unit, 0, { Force = true })
		end
		if not EnemyHealthDisplayAnchors[ unitId .. displaySuffix ] then
			local backingId = nil
			local scale = 1
			if unit.BarXScale then
				scale = unit.BarXScale
			end
			if unit and unit.UseBossHealthBar and not ( effectData.AttachIconToUnit or unit.UseGroupHealthBar) then
				backingId = CreateScreenObstacle({ Name = icon, Group = "Combat_Menu", DestinationId = EnemyHealthDisplayAnchors[unitId] })
				CreateTextBox({ Id = backingId, FontSize = 20, OffsetX = 15, OffsetY = 17,
					Font = "P22UndergroundSCHeavy",
					Justification = "Left",
					ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 2}, ShadowBlur = 0,
					OutlineThickness = 10, OutlineColor = {0,0,0,1},
				})
			else
				backingId = SpawnObstacle({ Name = icon, Group = "Combat_UI_World", DestinationId = unitId, TriggerOnSpawn = false, OffsetY = -30})
				CreateTextBox({ Id = backingId, FontSize = 20, OffsetX = 0, OffsetY = -2,
					Font = "P22UndergroundSCHeavy",
					Justification = "Center",
					ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 2}, ShadowBlur = 0,
					OutlineThickness = 10, OutlineColor = {0,0,0,1},
				})
			end
			if effectData.ShowDuration and effectData.EffectData and effectData.EffectData.Duration then
				local timerId = SpawnObstacle({Name = "BlankObstacle", Group = "Combat_UI_World_Backing", DestinationId = unitId })
				Attach({ Id = timerId, DestinationId = backingId })
				SetAnimation({ Name = "PortraitRespawnFill10", DestinationId = timerId, PlaySpeed = 1 / effectData.EffectData.Duration, Scale = 0.65, Group = "Combat_UI_World_Backing"})
				local timeRemaining = GetEffectTimeRemaining({ Id = unitId, EffectName = effectData.Name})
				if timeRemaining ~= 0 then
					SetAnimationFrameTarget({ Name = "PortraitRespawnFill10", Fraction = 1 - timeRemaining / effectData.EffectData.Duration, DestinationId = timerId, Instant = true })
					SetAnimationFrameTarget({ DestinationId = timerId, Name = "PortraitRespawnFill10", Fraction = 1 })
				end
				EnemyHealthDisplayAnchors[ unitId .. displaySuffix .. "timer" ] = timerId 
				if effectData.DurationAlpha then
					SetAlpha({ Id = timerId, Fraction = effectData.DurationAlpha, Duration = 0 })
				end
			end
			EnemyHealthDisplayAnchors[ unitId .. displaySuffix ] = backingId
		end
		
		if EnemyHealthDisplayAnchors[ unitId .. displaySuffix .. "timer" ] and effectData.ShowDuration and effectData.EffectData and effectData.EffectData.Duration and ( effectData.EffectData.ExtendDurationOnReapply == nil or effectData.EffectData.ExtendDurationOnReapply ) then
			SetAnimationFrameTarget({ DestinationId = EnemyHealthDisplayAnchors[ unitId .. displaySuffix .. "timer" ], Name = "PortraitRespawnFill10", Fraction = 0, Instant = true })
			SetAnimationFrameTarget({ DestinationId = EnemyHealthDisplayAnchors[ unitId .. displaySuffix .. "timer" ], Name = "PortraitRespawnFill10", Fraction = 1 })
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
			SetScale({ Id = EnemyHealthDisplayAnchors[ unitId .. displaySuffix ], Fraction = targetScale})
		else
			SetScale({ Id = EnemyHealthDisplayAnchors[ unitId .. displaySuffix ], Fraction = startIconScale })
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
			ModifyTextBox({ Id = EnemyHealthDisplayAnchors[ unitId .. displaySuffix ], Text = tostring( numShared ), ScaleTarget = scaleTarget, Color = statusFontColor })
		else
			ModifyTextBox({ Id = EnemyHealthDisplayAnchors[ unitId .. displaySuffix ], Text = " ", ScaleTarget = scaleTarget, Color = statusFontColor })
		end
	end
	PositionEffectStacks( unit.ObjectId )
end

function PositionEffectStacks( id )
	local unit = ActiveEnemies[id]
	if not EnemyHealthDisplayAnchors[id] or not unit then
		return
	end

	local effects = {}
	local effectsAdded = {}
	for effectName in pairs( unit.ActiveEffects ) do
		local effectData = EffectData[effectName]
		
		if effectData and effectData.DisplaySuffix and not effectsAdded[effectData.DisplaySuffix] then
			if effectData.AttachIconToUnit then
				Attach({ Id = EnemyHealthDisplayAnchors[ id .. effectData.DisplaySuffix ], DestinationId = unit.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset })
			elseif effectData.AttachIconToHealthbar and not unit.UseGroupHealthBar then
				--taken from Minos
				local offsetX = 0
				local offsetY = 0
				if unit.UseBossHealthBar then
					offsetX = 360
					if unit.BarXScale then
						offsetX = offsetX * unit.BarXScale
					end
				else
					local barScale = unit.BarXScale or 1
					offsetX = barScale * 98 /2 + 25
					offsetY = 3
				end
				Attach({ Id = EnemyHealthDisplayAnchors[ id .. effectData.DisplaySuffix ], DestinationId = EnemyHealthDisplayAnchors[id], OffsetX = offsetX, OffsetY = offsetY,  })
			elseif effectData.Icon then
				table.insert( effects, EnemyHealthDisplayAnchors[ id .. effectData.DisplaySuffix ])
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