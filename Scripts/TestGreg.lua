--[[ **SETUP** ]]

-- Imports
Import "UILogic.lua"
Import "Color.lua"
Import "UtilityLogic.lua"
Import "Debug.lua"

OnAnyLoad
{
	function( triggerArgs )
		local heroIds = GetIdsByType({ Name = "_PlayerUnit" })
		LockCamera({ Ids = heroIds })
		SwitchActiveUnit({ Ids = heroIds })
	end
}
