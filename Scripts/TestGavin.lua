-- Imports
Import "Color.lua"
Import "UtilityLogic.lua"
Import "Debug.lua"

OnAnyLoad
{
	function( triggerArgs )
		local hero = {}
		HeroIds = GetIdsByType({ Name = "_PlayerUnit" })
		if not IsEmpty( HeroIds ) then
			hero.ObjectId = HeroIds[1]
		end
		
		AttachLua({ Id = hero.ObjectId, Table = hero })
		LockCamera({ Ids = HeroIds })
		SwitchActiveUnit({ Ids = HeroIds })
	end
}

OnKeyPressed{ "None Q", Name = "TestCheat1",
	function( triggerArgs )
		 --SetScale({ Id = 4517, Fraction = 3.0, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		 --SetAngle({ Id = 4517, Angle = 180, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		 --AngleTowardTarget({ Id = 4517, DestinationIds = HeroIds, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		 --SetScaleX({ Id = 4517, Fraction = 3.0, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		 --SetColor({ Id = 4517, Color = Color.Blue, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		 --SetRed({ Id = 4517, Fraction = 0.0, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		 CreateAnimation({ Name = "TestFlame", DestinationId = HeroId })
	end
}

OnKeyPressed{ "None W", Name = "TestCheat2",
	function( triggerArgs )
		--SetScale({ Id = 4517, Fraction = 0.5, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		--SetAngle({ Id = 4517, Angle = 0, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		--SetScaleX({ Id = 4517, Fraction = 1.0, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		--SetColor({ Id = 4517, Color = Color.White, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
		SetColor({ Id = 4517, Fraction = 1.0, Duration = 1.0, EaseIn = 1.0, EaseOut = 0.8 })
	end
}

OnKeyPressed{ "None E", Name = "TestCheat3",
	function( triggerArgs )
		LockCamera({ Id = 4517 })
	end
}

OnKeyPressed{ "None F", Name = "TestCheat4",
	function( triggerArgs )
		
	end
}
