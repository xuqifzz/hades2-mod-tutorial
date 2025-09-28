function BadgeSellerUse( usee, args )

	local nextRank = (GameState.BadgeRank or 0) + 1
	local nextBadgeData = BadgeData[BadgeOrderData[nextRank]]
	if nextBadgeData == nil then
		-- Maxed out
		return
	end

	StopStatusAnimation( usee )

	if nextBadgeData.ResourceCost ~= nil then

		if not HasResources( nextBadgeData.ResourceCost ) then
			BadgeCannotAffordPresentation( usee, nextBadgeData )
			return
		end
		
		AddInputBlock({ Name = "BadgeResourceSpend" })
		BadgeResourceSpendPresentation( usee, resourceCost )

		for i, resourceName in ipairs( ResourceDisplayOrderData ) do
			if nextBadgeData.ResourceCost[resourceName] then
				SpendResource( resourceName, nextBadgeData.ResourceCost[resourceName], nextBadgeData.Name, { TextOffsetY = ScreenData.MusicPlayer.ResourceSpendTextOffsetY } )
				wait( 0.75 )
			end
		end
		RemoveInputBlock({ Name = "BadgeResourceSpend" })
	end

	GameState.BadgeRank = nextRank
	CurrentRun.BadgePurchased = nextRank
	
	BadgePurchasePresentation( usee, nextBadgeData )

end

function BadgeSellerSetupUseText( source, args )
	local nextRank = (GameState.BadgeRank or 0) + 1
	local nextBadgeData = BadgeData[BadgeOrderData[nextRank]]
	if nextBadgeData == nil then
		-- Maxed out
		source.OnUsedFunctionName = nil
		return
	end
	local nextRank = (GameState.BadgeRank or 0) + 1
	local nextBadgeData = BadgeData[BadgeOrderData[nextRank]]
	if nextBadgeData ~= nil then
		local resourceIndex = 1
		for i, resourceName in ipairs( ResourceDisplayOrderData ) do
			if nextBadgeData.ResourceCost[resourceName] then
				source["ResourceAmount"..resourceIndex] = nextBadgeData.ResourceCost[resourceName]
				source["ResourceIconPath"..resourceIndex] = ResourceData[resourceName].TextIconPath
				resourceIndex = resourceIndex + 1
			end
		end
		source.OnUsedFunctionName = "BadgeSellerUse"
		if HasResources( nextBadgeData.ResourceCost ) then
			source.UseText = "BadgeSeller_Use"
			source.UseTextTalkAndSpecial = "BadgeSeller_UseAndSpecial"
		else
			source.UseText = "BadgeSeller_Use_CantAfford"
			source.UseTextTalkAndSpecial = "BadgeSeller_UseAndSpecial_CantAfford"
		end
	end
end
