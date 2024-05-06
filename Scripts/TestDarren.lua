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

OnKeyPressed{ "None Q", Name = "TestSound",
	function( triggerArgs )
		SetSoundCueValue({ Id = GetMixingId({}), Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		PlaySound({ Name = "/SFX/Match SFX/DemonScorePoseSFX", Id = 120000 })
		wait(3.0)
		SetSoundCueValue({ Id = GetMixingId({}), Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
	end
}
