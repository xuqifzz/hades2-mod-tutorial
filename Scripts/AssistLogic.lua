OnControlPressed{ "Assist",
	function( triggerArgs )

		if not IsEmpty( ActiveScreens ) then
			return
		end

		if CanFireAssist() then
			DoAssist( CurrentRun.Hero )
		else
			if GameState.LastAssistTrait ~= nil then
				AssistFailedPresentation( CurrentRun.Hero )
			end
		end
	end
}

function CanFireAssist()
	if not CurrentRun
		or not CurrentRun.Hero
		or CurrentRun.Hero.IsDead
		or not IsCombatEncounterActive( CurrentRun )
		or CurrentRun.CurrentRoom.UsedAssist
		or IsEmpty( CurrentRun.Hero.AssistWeapons )
		or not IsInputAllowed({}) then
		return false
	end

	for i, assistData in pairs ( CurrentRun.Hero.AssistWeapons ) do
		if assistData.GameStateRequirements and not IsGameStateEligible( CurrentRun, assistData.GameStateRequirements ) then
			return false
		end
	end
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.AddAssist and traitData.RemainingUses == 0 then
			return false
		end
	end

	return true
end

function CheckAssistHint( source, args )
	thread( AssistHintDelay, source, args )
end

function AssistHintDelay( source, args )
	wait( args.Delay, RoomThreadName )
	if CanFireAssist() then
		AssistHintPresentation( source, args )
	end
end

function DoAssist( unit )
	CurrentRun.CurrentRoom.UsedAssist = true
	for i, assistData in pairs ( unit.AssistWeapons ) do
		DoAssistPresentation( assistData )
		local weaponName = assistData.WeaponName

		if assistData.TraitName then
			CheckCodexUnlock( "Keepsakes", assistData.TraitName )
		end

		if weaponName then
			local locationId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = 1200 })
			if locationId == 0 then
				locationId = CurrentRun.Hero.ObjectId
			end
			local targetId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Terrain", DestinationId = locationId, OffsetX = 0, OffsetY = 0 })

			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
			FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, FireFromTarget = true })
			Destroy({ Id = targetId })
		end
		thread( DoAssistPresentationPostWeapon, assistData )
		local functionName = assistData.FunctionName
		if functionName and _G[functionName] ~= nil then
			_G[functionName]( assistData )
		end
		thread( AssistCompletePresentation, assistData )
		break
	end
	for i, traitData in pairs( unit.Traits ) do
		if traitData.AddAssist then
			UseTraitData( unit, traitData )
			UpdateTraitNumber( traitData )
		end
	end
end

function AddAssistWeapons( unit, traitData )
	if traitData.AddAssist == nil then
		return
	end

	if unit.AssistWeapons == nil then
		unit.AssistWeapons = {}
	end
	for i, data in pairs( unit.AssistWeapons ) do
		if data.TraitName == traitData.Name then
			return
		end
	end

	local assistData = DeepCopyTable( traitData.AddAssist )
	assistData.TraitName = traitData.Name
	table.insert( unit.AssistWeapons, assistData )
end

function RemoveAssistWeapons( unit, traitData )
	if unit.AssistWeapons == nil or traitData.AddAssist == nil then
		return
	end
	for i, value in pairs( unit.AssistWeapons ) do
		if value.TraitName == value.TraitName then
			RemoveValue( unit.AssistWeapons, value )
			return
		end
	end
end