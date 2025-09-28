function GetNumMetaUpgradeLastStands()
	return GetTotalHeroTraitValue( "AddMetaUpgradeLastStands" )
end

function CalculateHealingMultiplier()
	return MetaUpgradeData.HealingReductionShrineUpgrade.ChangeValue * GetTotalHeroTraitValue( "TraitHealingBonus", { IsMultiplier = true } )
end

function BiomeSpeedTimerLoop()
	while not CurrentRun.Hero.IsDead do
		if not HasTimerBlock( CurrentRun ) and not IsBiomeTimerPaused() and CurrentRun.ActiveBiomeTimer then
			if GetNumShrineUpgrades("BiomeSpeedShrineUpgrade") > 0 and CurrentRun.BiomeTime <= 0 and not CurrentRun.Hero.IsDead and not SessionMapState.TyphonStaggerPresentation then
				local minHealth = 0
				if CurrentRun.Hero.InvulnerableFlags ~= nil and not IsEmpty( CurrentRun.Hero.InvulnerableFlags ) and not OnlySourceOfInvulnerability("ManaReserveTraitInvulnerability")  then
					minHealth = 1
				end 
				Damage( CurrentRun.Hero, { SourceWeapon = "BiomeTimer", DamageAmount = BiomeTimeLimits.Penalty.Damage, MinHealth = minHealth, PureDamage = true, Silent = true } )			
				FrameState.RequestUpdateHealthUI = true
				if not CurrentRun.Hero.IsDead then
					BiomeDamagePresentation( BiomeTimeLimits.Penalty.Damage )
					SetMenuOptions({ Name = "InGameUI", Properties = { Run = "PulseExpiredBiomeTimeText" } })
				end
			elseif CurrentRun.BiomeTime <= 30 then
				-- critical time remaining
				SetMenuOptions({ Name = "InGameUI", Properties = { Run = "PulseElapsedBiomeTimeText" } })
			end
		end
		wait( BiomeTimeLimits.Penalty.Interval, RoomThreadName )
	end
end

function IsBiomeTimerPaused()
	if not CurrentRun.CurrentRoom or not CurrentRun.CurrentRoom.Encounter then
		return false
	end

	if CurrentRun.CurrentRoom.Encounter.PauseBiomeTimer then
		return true
	end

	return false
end


function StartSurfaceHealthPenalty( unit, args )
	thread( SurfaceHealthPenalty, args )
end

function SurfaceHealthPenalty( args )
	CurrentRun.SurfacePenaltyCumulativeDamage = CurrentRun.SurfacePenaltyCumulativeDamage or 0
	wait( 0.1 )
	while not CurrentRun.Hero.IsDead do
		if not HasTimerBlock( CurrentRun, { "ArtemisEncounter" } ) and not IsBiomeTimerPaused() and not CurrentRun.Hero.IsDead then
			local minHealth = 0
			if args.DamageIncrementPerTick then
				CurrentRun.SurfacePenaltyCumulativeDamage = CurrentRun.SurfacePenaltyCumulativeDamage + args.DamageIncrementPerTick
			end
			local damage = math.floor( args.Damage + CurrentRun.SurfacePenaltyCumulativeDamage )
			BiomeDamagePresentation( damage )
			Damage( CurrentRun.Hero, { SourceWeapon = "SurfaceHealthPenalty", DamageAmount = damage, MinHealth = minHealth, PureDamage = true, Silent = true, IgnoreLastStand = true } )					
			if CurrentRun.Hero.IsDead then
				return
			end
			FrameState.RequestUpdateHealthUI = true
		end
		wait( args.Interval )
	end
end