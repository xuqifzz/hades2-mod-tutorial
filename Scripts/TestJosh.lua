--[[ **TEST JOSH** ]]

-- Imports

Import "UILogic.lua"
Import "Color.lua"
Import "UtilityLogic.lua"
Import "Debug.lua"
Import "RunData.lua"

OnAnyLoad
{
	function( triggerArgs )
		local heroIds = GetIdsByType({ Name = "_PlayerUnit" })
		LockCamera({ Ids = heroIds })
		SwitchActiveUnit({ Ids = heroIds })


	end
}


OnKeyPressed{ "None G", Name = "Test Animation",
	function( triggerArgs )
		CreateAnimation({ Name = "", DestinationId = 230019 })
	end
}