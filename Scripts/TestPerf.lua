--[[ * IMPORTS * ]]

Import "Color.lua"
Import "Debug.lua"

local testButtonId = 320001
local perfTestId = 0
local isTestRunning = false
local spawnObstacles = false

local testAnim = "PerfTestAnimSpawner"
local testObstacles = {"VisibleTarget", "BonePile01", "Shells08", "Crystal04" }
local fpsCutoff = 59

function StartMaxAnimationsTest()

	DebugPrint({ Text = "MaxAnimationsTest" })
	CreateAnimation({ Name = testAnim, DestinationId = testButtonId })

	wait(1)

	local avgFps = GetAvgFps({})
	
	while avgFps > fpsCutoff do
		wait(1)
		avgFps = GetAvgFps({})
	end

	StopMaxAnimationsTest()

end

function StopMaxAnimationsTest()

	DebugPrint({ Text = "Stopping MaxAnimationsTest"})
	StopAnimation({ DestinationId = testButtonId })
end

function StartMaxObstaclesTest()

	DebugPrint({ Text = "MaxObstaclesTest" })

	spawnObstacles = true
	while spawnObstacles do
		for index = 1, 50, 1 do
			local randomOffsetX = RandomInt(-960, 960)
			local randomOffsetY = RandomInt(-540, 540)
			local randomObstacle = RandomInt(1, #testObstacles)
			local randomScale = RandomFloat(0.0, 0.25)
			local testObstacle = testObstacles[randomObstacle]

			local obstacle = SpawnObstacle({ Name = testObstacle, DestinationId = testButtonId, OffsetX = randomOffsetX, OffsetY = randomOffsetY })
			SetScale({ Id = obstacle, Fraction = randomScale })
		end

		wait(1)
		if GetAvgFps({}) < fpsCutoff then
			wait(1)
			if GetAvgFps({}) < fpsCutoff then
				StopMaxObstaclesTest()
			end
		end
	end

end

function StopMaxObstaclesTest()

	DebugPrint({ Text = "Stop MaxObstaclesTest "})
	spawnObstacles = false
end

local perfTests = 
{
	{
		Label = "Max Animations",
		Start = StartMaxAnimationsTest,
		Stop = StopMaxAnimationsTest,
	},
	{
		Label = "Max Obstacles",
		Start = StartMaxObstaclesTest,
		Stop = StopMaxObstaclesTest,
	}
}

local perfTestCount = #perfTests


function SetupButton()

	local buttonPrompt = perfTests[perfTestId + 1].Label
	DestroyTextBox({ DestinationId = testButtonId })
	CreateTextBox({ Id = testButtonId, Text = buttonPrompt, OffsetY = 100 })

end

OnAnyLoad
{
	function( triggerArgs )
		SetConfigOption({ Name = "ShowFPS", Value = true })
		SetConfigOption({ Name = "PerfDash", Value = true })
		SetInteractProperty({ DestinationId = testButtonId, Property = "Distance", Value = 300 })
		SetupButton()
	end
}

OnControlPressed{ "Shout",
	function( triggerArgs )
		LoadMap({ Name = "TestPerf", ResetApp = true })
	end
}

OnControlPressed{ "Rush",

	function( triggerArgs )
		perfTestId = (perfTestId + 1) % perfTestCount
		SetupButton()
	end
}

OnControlPressed{ "Attack1",

	function( triggerArgs )
		perfTestId = (perfTestId + perfTestCount - 1) % perfTestCount
		SetupButton()
	end	
}
