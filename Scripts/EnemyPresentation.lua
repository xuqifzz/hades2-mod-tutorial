function PrometheusMemoryIntroPresentation( prometheus, aiData, currentRun, args )

	local notifyName = "PrometheusNotify"
	local initialSpeed = GetUnitDataValue({ Id = prometheus.ObjectId, Property = "Speed" })
	prometheus.IgnoreSpeedMultiplier = true
	
	if CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
		local trait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell)
		weaponName = trait.PreEquipWeapons[1]
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	ClearEffect({ Id = prometheus.ObjectId, All = true })
	SetUnitInvulnerable( prometheus, "PrometheusMemoryPresentation" )
	LockCameraMotion("Prometheus")

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpPreFire", })

	AngleTowardTarget({ Id = prometheus.ObjectId, DestinationId = args.LandingId })
	wait(0.33)

	LockCamera({ Id = args.CameraTargetId, Duration = 1.25 })
	FocusCamera({ Fraction = 0.65, Duration = 1.25, ZoomType = "Ease" })
	ZeroMouseTether( "PrometheusMemory" )

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpInAir", })

	thread( PlayVoiceLines, prometheus.MemoryAttackIntroVoiceLines, nil, prometheus )

	IgnoreGravity({ Id = prometheus.ObjectId })
	SetScale({ Id = prometheus.ObjectId, Fraction = args.Scale or 3, Duration = 0.3 })
	AdjustZLocation({ Id = prometheus.ObjectId, Distance = 450 - GetZLocation({ Id = prometheus.ObjectId }), Duration = 0.3 })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = args.Speed or 4000 })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithUnits", Value = false })
	Move({ Id = prometheus.ObjectId, DestinationId = args.LandingId, })
	NotifyWithinDistance({ Id = prometheus.ObjectId, DestinationId = args.LandingId, Distance = 75, Notify = notifyName, Timeout = 5.0 })
	waitUntil( notifyName )

	RemoveFromGroup({ Id = prometheus.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = prometheus.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })
	Stop({ Id = prometheus.ObjectId })
	Halt({ Id = prometheus.ObjectId })
	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpLand", })
	SetGoalAngle({ Id = prometheus.ObjectId, Angle = 145, CompleteAngle = true })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = initialSpeed })
end

function PrometheusMemoryOutroPresentation( prometheus, aiData, currentRun, args )

	local notifyName = "PrometheusNotify"
	local initialSpeed = GetUnitDataValue({ Id = prometheus.ObjectId, Property = "Speed" })

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_Memory_End", })
	wait( 1.0 )

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpPreFire", })
	AngleTowardTarget({ Id = prometheus.ObjectId, DestinationId = args.LandingId })
	wait(0.33)

	UnlockCameraMotion("Prometheus")
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.25 })
	FocusCamera({ Fraction = currentRun.CurrentRoom.ZoomFraction, Duration = 1.25, ZoomType = "Ease" })
	UnzeroMouseTether( "PrometheusMemory" )

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpInAir", })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = args.Speed or 4000 })
	Move({ Id = prometheus.ObjectId, DestinationId = args.LandingId, })
	SetScale({ Id = prometheus.ObjectId, Fraction = 1.0, Duration = 0.3 })
	NotifyWithinDistance({ Id = prometheus.ObjectId, DestinationId = args.LandingId, Distance = 300, Notify = notifyName, Timeout = 5.0 })
	waitUntil( notifyName )	

	AddToGroup({ Id = prometheus.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = prometheus.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
	AdjustZLocation({ Id = prometheus.ObjectId, Distance = 0 - GetZLocation({ Id = prometheus.ObjectId }), Duration = 0.15 })

	NotifyWithinDistance({ Id = prometheus.ObjectId, DestinationId = args.LandingId, Distance = 75, Notify = notifyName, Timeout = 1.0 })
	waitUntil( notifyName )
	thread( PlayVoiceLines, prometheus.MemoryAttackOutroVoiceLines, nil, prometheus )

	Stop({ Id = prometheus.ObjectId })
	Halt({ Id = prometheus.ObjectId })
	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpLand", })
	AngleTowardTarget({ Id = prometheus.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = initialSpeed })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithObstacles", Value = true })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithUnits", Value = true })
	ObeyGravity({ Id = prometheus.ObjectId })
	SetUnitVulnerable( prometheus, "PrometheusMemoryPresentation" )
	prometheus.IgnoreSpeedMultiplier = false
	if CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
		local trait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell)
		thread( CallFunctionName, trait.CheckChargeFunctionName, CurrentRun.Hero )
	end
end

function PrometheusSummonPresentation( prometheus, aiData, currentRun, args )

	local enemyData = EnemyData[args.SpawnName]
	enemyData.ActivateAnimation = nil
	enemyData.ActivateDuration = 0
	enemyData.WakeUpDelay = 2

	local flyByEnemy = DeepCopyTable( enemyData )
	flyByEnemy.ObjectId = SpawnUnit({ Name = args.SpawnName, Group = "Combat_Menu_TraitTray_Overlay_Text", DestinationId = args.HarpyStartId, })
	SetupUnit( flyByEnemy, currentRun )
	SetUnitInvulnerable({ Id = flyByEnemy.ObjectId })

	AdjustZLocation({ Id = flyByEnemy.ObjectId, Distance = args.ZHeight - GetZLocation({ Id = flyByEnemy.ObjectId }) })
	IgnoreGravity({ Id = flyByEnemy.ObjectId })
	SetAnimation({ DestinationId = flyByEnemy.ObjectId, Name = "Enemy_HarpyCutter_Move" })
	SetGoalAngle({ Id = flyByEnemy.ObjectId, Angle = 45, CompleteAngle = true })

	SetUnitProperty({ DestinationId = flyByEnemy.ObjectId, Property = "CollideWithUnits", Value = false })
	SetUnitProperty({ DestinationId = flyByEnemy.ObjectId, Property = "CollideWithObstacles", Value = false })

	SetScale({ Id = flyByEnemy.ObjectId, Fraction = args.Scale or 5 })
	SetUnitProperty({ DestinationId = flyByEnemy.ObjectId, Property = "Speed", Value = args.Speed })

	Move({ Id = flyByEnemy.ObjectId, DestinationId = args.HarpyEndId })
	NotifyWithinDistance({ Id = flyByEnemy.ObjectId, DestinationId = args.HarpyEndId, Distance = 75, Notify = "HarpySummon", Timeout = 1.0 })
	waitUntil( "HarpySummon" )

	SetAlpha({ Id = flyByEnemy.ObjectId, Fraction = 0.0, Duration = 0.0 })
	KillEnemy( flyByEnemy, {} )
	Destroy({ Id = flyByEnemy.ObjectId })
end

function EagleFlyOverPresentation( eagle, aiData, CurrentRun, args )

	local initialSpeed = GetUnitDataValue({ Id = eagle.ObjectId, Property = "Speed" })
	local initialScale = GetThingDataValue({ Id = eagle.ObjectId, Property = "Scale" })
	local initialZHeight = GetZLocation({ Id = eagle.ObjectId })

	AdjustZLocation({ Id = eagle.ObjectId, Distance = args.ZHeight - initialZHeight })
	Teleport({ Id = eagle.ObjectId, DestinationId = args.TeleportToId })
	IgnoreGravity({ Id = eagle.ObjectId })
	SetAnimation({ DestinationId = eagle.ObjectId, Name = "Enemy_Eagle_Glide" })
	SetGoalAngle({ Id = eagle.ObjectId, Angle = 45, CompleteAngle = true })

	SetUnitProperty({ DestinationId = eagle.ObjectId, Property = "CollideWithUnits", Value = false })
	SetUnitProperty({ DestinationId = eagle.ObjectId, Property = "CollideWithObstacles", Value = false })

	RemoveFromGroup({ Id = eagle.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = eagle.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

	SetScale({ Id = eagle.ObjectId, Fraction = args.Scale or 5, Duration = 0.1 })
	SetUnitProperty({ DestinationId = eagle.ObjectId, Property = "Speed", Value = args.Speed })

	Move({ Id = eagle.ObjectId, DestinationId = args.MoveToId })
	NotifyWithinDistance({ Id = eagle.ObjectId, DestinationId = args.MoveToId, Distance = 75, Notify = "EagleSummon", Timeout = 1.0 })
	waitUntil( "EagleSummon" )

	Stop({ Id = eagle.ObjectId })
	Halt({ Id = eagle.ObjectId })
	ObeyGravity({ Id = eagle.ObjectId })
	AdjustZLocation({ Id = eagle.ObjectId, Distance = initialZHeight - GetZLocation({ Id = eagle.ObjectId }) })

	SetUnitProperty({ DestinationId = eagle.ObjectId, Property = "Speed", Value = initialSpeed })
	SetScale({ Id = eagle.ObjectId, Fraction = initialScale, Duration = 0.1 })
	SetUnitProperty({ DestinationId = eagle.ObjectId, Property = "CollideWithUnits", Value = true })
	SetUnitProperty({ DestinationId = eagle.ObjectId, Property = "CollideWithObstacles", Value = true })
	AddToGroup({ Id = eagle.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = eagle.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
	SetAnimation({ DestinationId = eagle.ObjectId, Name = "Enemy_Eagle_Invisible" })
end