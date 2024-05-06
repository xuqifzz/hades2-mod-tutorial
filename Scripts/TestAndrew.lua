Import "RoomLogic.lua"

OnAnyLoad
{
	function( triggerArgs )
		HeroIds = GetIdsByType({ Name = "_PlayerUnit" })
	end
}

OnKeyPressed{ "None B", Name = "TestCheat2",
	function( triggerArgs )

		CreateTextBox({ Id = 240010, Text = "FontSize 16", FontSize = 16, 
						OffsetX = 0, OffsetY = 40, Color = Color.Gold, 
						Font = "P22UndergroundSCMedium", 
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 5}, 
						Justification = "Center" })

		CreateTextBox({ Id = 240010, Text = "FontSize 32", FontSize = 32, 
						OffsetX = 0, OffsetY = 150, Color = Color.Gold, 
						Font = "P22UndergroundSCMedium", 
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 5}, 
						Justification = "Center" })

		CreateTextBox({ Id = 240010, Text = "FontSize 48", FontSize = 48, 
						OffsetX = 0, OffsetY = 250, Color = Color.Gold, 
						Font = "P22UndergroundSCMedium", 
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 5}, 
						Justification = "Center" })


		CreateTextBox({ Id = 240010, Text = "FontSize 64", FontSize = 64, 
						OffsetX = 0, OffsetY = 350, Color = Color.Gold, 
						Font = "P22UndergroundSCMedium", 
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 5}, 
						Justification = "Center" })

		
	end
}

OnKeyPressed{ "None Q", Name = "TestCheat1",
	function( triggerArgs )

		local iterations = 5
		local numAnims = 100
		local perRow = 12
		local xSpacing = 1920.0 / perRow
		local perCol = numAnims / perRow
		local ySpacing = 1080 / perCol

		local textBox = CreateTextBox({ Id = HeroIds[1], Text = "Start Perf Test", 
			FontSize = 24, OffsetX = 0, OffsetY = -130, Width = 840, 
			Color = Color.White, 
			Font = "LatoMedium", 
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, 
			Justification = "Center" })

		PerfStartCapture({ })

		for j = 1,iterations do

		AdjustSimulationSpeed({ Fraction = 0.3, LerpTime = 0.0 })
		
			for i = 1,numAnims do
				local offsetX = xSpacing * ((i-1) % perRow) - 1920*0.9 / 2
				local offsetY = ySpacing * math.floor((i-1) / perRow) - 1080*0.9 / 2
				CreateAnimation({ Name = "PerfTestAnim", DestinationId = HeroIds[1], OffsetX = offsetX, OffsetY = offsetY })		
			end

			wait(0.5)
		
			AdjustSimulationSpeed({ Fraction = 1.0, LerpTime = 2.0 })
			
			wait(0.5)
		end

		wait(0.25)
		
		PerfStopCapture({ })
		
		ModifyTextBox({ Id = textBox, Text = "End Perf Test" })
		wait(0.25)
		DestroyTextBox({ Id = textBox })

	end
}
