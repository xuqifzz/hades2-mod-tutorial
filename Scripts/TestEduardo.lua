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

function BeginTestRoomInro()
	-- Pan the camera to the enemy spawn location
	PanCamera({ Id = GetIdsByType({ Name = "EnemyPoint" }), Duration = 2 })
	wait(2)

	thread(ReturnToHero)
end

function ReturnToHero()
	wait(1)
	PanCamera({ Id = GetIdsByType({ Name = "_PlayerUnit" }), Duration = 2 })
	wait(2)

	-- Testing additional presentation techniques
	SpawnTestRoomObstacle()
	ShakeScreen({Distance = 8, Speed = 800, FalloffSpeed = 2000, Duration = 2.0})
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 1.5 })
end

function SpawnTestRoomObstacle()
	local upgradeRelicId = SpawnObstacle({ Name = "DemeterUpgrade", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 100, OffsetY = 100, Group = "Standing" })
	Flash({ Id = upgradeRelicId, Speed = 1, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = duration })

	local textBoxAnchor = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = upgradeRelicId, OffsetY = 50 })
	Attach({ Id = textBoxAnchor, DestinationId = upgradeRelicId})
	CreateTextBox({ Id = textBoxAnchor, Text = "Pick me up!", FontSize = 18 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/RosterPickup" })
end