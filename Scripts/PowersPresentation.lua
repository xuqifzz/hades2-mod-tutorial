function HeavyArmorInitialPresentation()
	CreateAnimation({ Name = "HephaestusArmorUp", DestinationId = CurrentRun.Hero.ObjectId })
end

function HandleAresSprintSound( args )
	args = args or {}
	wait( args.StartDelay )
	StopSound({ Id = SessionState.AresSprintSound, Duration = args.StartSoundFinishFade })
	if args.Sound then
		PlaySound({ Name = args.Sound })
		for i=2, args.Count do
			wait(args.Delay)
			PlaySound({ Name = args.Sound })
		end
	end
end

function CreateAlliedEnemyPresentation( newEnemy )
	PlaySound({ Name = "/SFX/Menu Sounds/LegendaryBoonShimmer2", Id = newEnemy.ObjectId })
	CreateAnimation({ Name = "SorcerySummonPresentationFx", DestinationId = newEnemy.ObjectId })
end

function CreateShadeMercAspectPresentation( newEnemy )
	CreateAnimation({ Name = "MercSummonPresentationFx", DestinationId = newEnemy.ObjectId })
end