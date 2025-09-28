function CheckProgressAchievements( args )

	if GameState == nil then
		return
	end

	args = args or {}
	
	local threadName = "CheckProgressAchievements"
	if not args.Silent then
		if SetThreadWait( threadName, 0.3 ) then
			return
		end
		wait( 0.3, threadName )
	end

	for i, achievementName in ipairs( AchievementOrderData ) do
		local achievementData = AchievementData[achievementName]
		-- Needs to check against the SessionState in case the achievements didn't go through to the platform previously (e.g. offline)
		if achievementData ~= nil and not achievementData.IgnoreProgressCheck and not SessionState.AchievementsUnlocked[achievementName] then
			if achievementData.CompleteGameStateRequirements ~= nil and IsGameStateEligible( achievementData, achievementData.CompleteGameStateRequirements ) then
				-- Completed
				UnlockAchievement({ Name = achievementName })
				SessionState.AchievementsUnlocked[achievementName] = true
				if not GameState.AchievementsUnlocked[achievementName] and GameState.CheckProgressAchievementsRuns then -- Don't print back-compat unlocks
					DebugPrint({ Text = "ACHIEVEMENT UNLOCKED: "..achievementName, Priority = true })
				end
				GameState.AchievementsUnlocked[achievementName] = true
				wait( 0.5, threadName )
			else
				wait( 0.02, threadName ) -- Distribute workload over frames
			end
		end
	end
	GameState.CheckProgressAchievementsRuns = true
end

function CheckAchievement( source, args, contextArgs )
	local achievementName = args.Name
	local achievementData = AchievementData[achievementName]
	if achievementData == nil then
		return
	end

	-- Needs to check against the SessionState in case the achievements didn't go through to the platform previously (e.g. offline)
	if SessionState.AchievementsUnlocked[achievementName] then
		return
	end

	if achievementData.CompleteGameStateRequirements == nil or IsGameStateEligible( source, achievementData.CompleteGameStateRequirements, contextArgs ) then
		UnlockAchievement({ Name = achievementName })
		SessionState.AchievementsUnlocked[achievementName] = true
		if not GameState.AchievementsUnlocked[achievementName] and GameState.CheckProgressAchievementsRun then -- Don't print back-compat unlocks
			DebugPrint({ Text = "ACHIEVEMENT UNLOCKED: "..achievementName, Priority = true })
		end
		GameState.AchievementsUnlocked[achievementName] = true
	end
end