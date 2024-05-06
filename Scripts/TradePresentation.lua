function TradeScreenAcceptPresentation( screen, button )
	if screen.Args.AcceptSourceVoiceLines ~= nil then
		thread( PlayVoiceLines, screen.Source[screen.Args.AcceptSourceVoiceLines], true, screen.Source )
	else
		thread( PlayVoiceLines, screen.Source.DealApprovedVoiceLines, true, screen.Source )
	end
end

function TradeScreenDeclinePresentation( screen, button )
	if screen.Args.DeclineSourceVoiceLines ~= nil then
		thread( PlayVoiceLines, screen.Source[screen.Args.DeclineSourceVoiceLines], true, screen.Source )
	else
		thread( PlayVoiceLines, screen.Source.DealDeclinedVoiceLines, true, screen.Source )
	end
end

function NemesisTradePostCostPresentation( screen, args )
	thread( PlayVoiceLines, screen.Source.DealApprovedVoiceLines, true, screen.Source )
	thread( NemesisDropPresentation, screen.Source, args )
	wait( 0.7 )
end

function NemesisDropPresentation( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Nemesis_Hub_Toss" })
	wait( 1.6 )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Nemesis_Hub_Equip" })
end

function TradeOptionPressedPresentation( screen, button )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	Flash({ Id = button.Id, Speed = 4.0, MinFraction = 0.0, MaxFraction = 0.7, Color = Color.Red, ExpireAfterCycle = true, })
	Flash({ Id = screen.Components.AcceptButton.Id, Speed = 0.7, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Gold, ExpireAfterCycle = true, })
end

function NemesisTakeDamagePreCostPresentation( screen, args )

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.25 })
	AngleTowardTarget({ Id = screen.Source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = screen.Source.ObjectId, Name = "Nemesis_Hub_Equip", SpeedMultiplier = 1.5 })
	wait(0.66)
	SetAnimation({ DestinationId = screen.Source.ObjectId, Name = "Nemesis_Combat_Attack1_Start", SpeedMultiplier = 0.45 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing", Id = screen.Source  })
	wait(1.2)
	SetAnimation({ DestinationId = screen.Source.ObjectId, Name = "Nemesis_Combat_Attack1_Fire", SpeedMultiplier = 1.4 })
	wait(0.15)
	AdjustRadialBlurDistance({ Fraction = 10, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.2, Duration = 0.2 })
	AddSimSpeedChange( "NemesisFreeShot", { Fraction = 0.2, LerpTime = 0.05, Priority = true } )
	PlaySound({ Name = "/SFX/StabSplatterSmall", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "MelinoeGetHit", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "BloodImpactA", DestinationId = CurrentRun.Hero.ObjectId })
	ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = 700, Angle = GetAngleBetween({ DestinationId = CurrentRun.Hero.ObjectId, Id = screen.Source.ObjectId}) })

end

function NemesisTakeDamagePostCostPresentation( screen, args )
	wait(0.1)
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = CurrentRun.Hero.ObjectId })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustFrame({ Duration = 0.8, Fraction = 0 })
	RemoveSimSpeedChange( "NemesisFreeShot", { LerpTime = 0.8 } )
	wait( 0.5 )
	SetAnimation({ DestinationId = screen.Source.ObjectId, Name = "Nemesis_Combat_Unequip", SpeedMultiplier = 2 })
	wait( 0.5 )
	thread( PlayVoiceLines, screen.Source.GivingItemVoiceLines, true, screen.Source )
	thread( NemesisDropPresentation, screen.Source, args )
	wait( 0.7 )
end