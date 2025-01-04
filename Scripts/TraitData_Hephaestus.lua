OverwriteTableKeys( TraitData, {
	-- Hephaestus
	HephaestusWeaponBoon = 
	{
		Icon = "Boon_Hephaestus_27",
		InheritFrom = { "BaseTrait", "FireBoon" },
		PriorityDisplay = true,
		Slot = "Melee",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 10/12,
			},
			Epic =
			{
				Multiplier = 8/12,
			},
			Heroic =
			{
				Multiplier = 6/12,
			}
		},
		SetupFunction =
		{
			Name = "MassiveAttackSetup",
			Args = 
			{
				TraitName = "HephaestusWeaponBoon",
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckMassiveAttack",
			Args = 
			{
				Name = "MassiveAttack",
				TraitName = "HephaestusWeaponBoon",
				ProjectileName = "MassiveSlamBlast",
				Cooldown = 
				{ 
					BaseValue = 12,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -2,
						[2] = -1,
					},
				},
				BlastDelay = 0.08,
				DamageMultiplier = 1.0,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			},
		},
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "MassiveSlamBlast",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
				DecimalPlaces = 1,
			},
		},
		WeaponDataOverride = 
		{
			WeaponSuitCharged = 
			{
				BlockGraphic = "SuitDeflect_Hephaestus",
			}
		},
		PropertyChanges = {

			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "GroupName",
				ChangeValue = "FX_Standing_Add",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack3Dissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				ProjectilName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "FireFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "DaggerCharge_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Hephaestus_In",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "EosProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchExplosionLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	

			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurn_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "Null",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Hephaestus",
				ChangeType = "Absolute",
			},
		},
	},
	HephaestusSpecialBoon = 
	{
		Icon = "Boon_Hephaestus_30",
		InheritFrom = { "BaseTrait", "FireBoon" },
		PriorityDisplay = true,
		Slot = "Secondary",
		RarityLevels =
		{ 
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 13/16,
			},
			Epic =
			{
				Multiplier = 11/16,
			},
			Heroic =
			{
				Multiplier = 9/16,
			}
		},
		SetupFunction =
		{
			Name = "MassiveAttackSetup",
			Args = 
			{
				TraitName = "HephaestusSpecialBoon",
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ExcludeProjectiles = {"ProjectileSuitRangedGuidedSplit", "ProjectileSuitSplit", "ProjectileSuitSplit2" },
			FunctionName = "CheckMassiveAttack",
			Args = 
			{
			
				ExcludeLinked = true,
				MultihitWeaponWhitelist = 
				{
					"WeaponTorchSpecial",
					"WeaponDaggerThrow"
				},
				Name = "MassiveSpecial",
				TraitName = "HephaestusSpecialBoon",
				ProjectileName = "MassiveSlamBlast",
				Cooldown = 
				{ 
					BaseValue = 16,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -2,
						[2] = -1,
					},
				},
				BlastDelay = 0.08,
				DamageMultiplier = 2.0,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			},
		},
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "MassiveSlamBlast",
				BaseProperty = "Damage",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		},
		PropertyChanges = {

			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "HephaestusStaffProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "StaffBallProjectileCharged_Hephaestus_Shadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Hephaestus", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Hephaestus",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "AxeBlockEmpowerTrait",
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitName = "AxeBlockEmpowerTrait",
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitName = "AxeBlockEmpowerTrait",
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSpinDouble_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hephaestus",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Hephaestus",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Hephaestus",
			},
		},

	},
	HephaestusCastBoon =
	{
		Icon = "Boon_Hephaestus_29",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Slot = "Ranged",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.4,
			},
			Epic =
			{
				Multiplier = 1.6,
			},
			Heroic =
			{
				Multiplier = 1.8,
			},
		},
		WeaponDataOverride =
		{
			WeaponCast =
			{
				FireScreenshake = { Distance = 3, Speed = 200, Duration = 0.5, FalloffSpeed = 3000 },
				HitScreenshake = { Distance = 0, Speed = 0, Duration = 0.0, FalloffSpeed = 0 },
				HitSimSlowParameters = { },
				OnFiredFunctionArgs = 
				{
					ProjectileDataProperties = { DamageRadius = true },
				},
			}
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Range = 600,
					DetonateFx = "HephMassiveHitFixed",
					PreDetonateFx = "HephMassiveHitHammerCast",
					PreDetonateFxDuration = 0.99,
					HideGraphicOnDetonate = false,
					FuseStart = 1.0,
					MultiDetonate = true,
					MaxDetonations = 3,
					ArmedImpactFx = "null",
					DeathFx = "CastCircleOut",
					ArmedDeathFx = "CastCircleOut",
					Graphic = "CastCircleInHephaestus",
					DissipateFx = "CastCircleOutHephaestus",

				}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Damage",
				BaseValue = 50,
				ReportValues = {ReportedDamage = "ChangeValue"},
				AbsoluteStackValues =
				{
					[1] = 20,
					[2] = 15,
					[3] = 10,
					[4] = 5,
				},
				AsInt = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "ArmedExpirationDamage",
				BaseValue = 50,
				ChangeType = "Add",
				IdenticalMultiplier =
				{
					Value = -0.6,
				},
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Fuse",
				ChangeValue = 1.0,
				ReportValues = {ReportedFuse = "ChangeValue"}
			},
		},
		StatLines =
		{
			"CastDamageOverTimeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Fuse",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ChillDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "ChillEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "ChillActiveDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "ChillEffect",
				BaseProperty = "ActiveDuration",
			},
		}
	},
	HephaestusSprintBoon = 
	{
		Icon = "Boon_Hephaestus_28",
		InheritFrom = { "BaseTrait", "FireBoon" },
		Slot = "Rush",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 10/10,
			},
			Rare =
			{
				Multiplier = 9/10,
			},
			Epic =
			{
				Multiplier = 8/10,
			},
			Heroic =
			{
				Multiplier = 7/10,
			}
		},
		SetupFunction =
		{
			Name = "MassiveAttackSetup",
			Args = 
			{
				TraitName = "HephaestusSprintBoon",
			},
		},
		OnBlinkEndAction = 
		{
			FunctionName = "FireHephaestusSprintProjectile",
			FunctionArgs = 
			{
				TraitName = "HephaestusSprintBoon",
				Name = "HephSprint",
				ProjectileName = "HephSprintBlast",
				Range = 300,
				DamageMultiplier = 1,
				Cooldown = 
				{ 
					BaseValue = 10,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -1,
						--[2] = -1,
					},
				},
				ReportValues = 
				{
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				}
			}
		},
				
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HephSprintBlast",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
		}
	},
	HephaestusManaBoon =
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hephaestus_31",
		Slot = "Mana",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.50,
			},
			Epic =
			{
				Multiplier = 2.00,
			},
			Heroic =
			{
				Multiplier = 2.50,
			},
		},	
		OnDamagedManaConversionFlat = { 
			BaseValue = 50,
			MinMultiplier = 0.1,
			IdenticalMultiplier =
			{
				Value = -0.5,
				DiminishingReturnsMultiplier = 0.5,
			},
		},
		AddIncomingDamageModifiers =
		{
			ValidWeaponMultiplier = 0.9,
			ReportValues = 
			{
				ReportedMultiplier = "ValidWeaponMultiplier"
			},
		},
		StatLines =
		{
			"ManaRevengeRegenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageResistance",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true
			},
			{
				Key = "OnDamagedManaConversionFlat",
				ExtractAs = "TooltipMana",
			},
		}
		--[[ from conversion version display
		StatLines =
		{
			"ManaRevengeRegenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "OnDamagedManaConversion",
				ExtractAs = "TooltipMana",
				Format = "Percent"
			},
		}
		]]
	},

	AntiArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "FireBoon" },
		Icon = "Boon_Hephaestus_39",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			}
		},
		AddOutgoingDamageModifiers =
		{
			HealthBufferDamageMultiplier =
			{
				BaseValue = 1.2,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.2,
					[2] = 1.1,
					[3] = 1.05,
				},
			},
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferDamageMultiplier"},
		},
		StatLines =
		{
			"ArmorDamageIncreaseDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		}
	},
	HeavyArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "CostumeTrait", "EarthBoon" },
		Frame = "nil",
		Icon = "Boon_Hephaestus_38",
		BlockStacking = true,
		Invincible = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			}
		},
		AcquireFunctionName = "HeavyArmorInitialPresentation",
		SetupFunctions =
		{
			{
				Name = "HeavyArmorSetup",
				Args = { Name = "HeavyArmor" },
			},
			{
				Name = "CostumeArmor",
				Args =
				{
					Source = "Tradeoff",
					Delay = 0.75,
					BaseAmount = 
					{ 
						BaseValue = 50,
					},
					ReportValues = 
					{ 
						ReportedArmor = "BaseAmount",
					}
				},
			},
		},
		StatLines =
		{
			"ArmorStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
		}
	},
	HeavyArmorExpired = 
	{
		Hidden = true,
	},
	ArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon", "CostumeTrait"},
		Frame = "nil",
		Icon = "Boon_Hephaestus_32",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		Invincible = true,
		SetupFunction =
		{
			Name = "HephaestusArmor",
			Args =
			{
				Source = "Renewable",
				Amount = 
				{ 
					BaseValue = 10, 
					AsInt = true,
					AbsoluteStackValues = 
					{
						[1] = 5,
						[2] = 3,
						[3] = 2,
						[4] = 2,
					}
				},
				ManaReservationCost = 30,
				ReportValues = 
				{ 
					ReportedArmor = "Amount",
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		OnLevelOrRarityChangeFunctionName = "RestoreHephaestusArmor",
		OnArmorBreakFunction= 
		{
			Name = "StopHephaestusVfx",
		},
		StatLines =
		{
			"StartingArmorStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
				IncludeSigns = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},
	EncounterStartDefenseBuffBoon =
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hephaestus_36",
		EncounterStartWeapon = "EncounterStartBuffWeapon",
		PreEquipWeapons = { "EncounterStartBuffWeapon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 6/6,
			},
			Rare =
			{
				Multiplier = 7/6,
			},
			Epic =
			{
				Multiplier = 8/6,
			},
			Heroic =
			{
				Multiplier = 9/6,
			}
		},
		EncounterStartInvulnerabilityDuration = 
		{
			BaseValue = 6,		
			AbsoluteStackValues = 
			{
				[1] = 1,
				--[2] = 1,
			},
		},
		StatLines =
		{
			"InvulnerableDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "EncounterStartInvulnerabilityDuration",
				ExtractAs = "TooltipAmount",
				DecimalPlaces = 2,
			},
		}
	},
	ManaToHealthBoon = 
	{
		Icon = "Boon_Hephaestus_33",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		MaxManaToMaxHealthConversion = { BaseValue = 0.2 },
		BlockStacking = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			}
		},
		StatLines =
		{
			"BonusManaLifeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "MaxManaToMaxHealthConversion",
				ExtractAs = "BonusHealth",
				Format = "Percent",
			},
		}
	},
	MassiveDamageBoon = 
	{	
		Icon = "Boon_Hephaestus_37",
		InheritFrom = { "BaseTrait", "FireBoon" },
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			}
		},
		MassiveAttackSizeModifier = 1.5,
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast" },
			ValidBaseDamageAddition = { BaseValue = 50 },
			AbsoluteStackValues =
			{
				[1] = 25,
				[2] = 20,
				[3] = 15,
				[4] = 10,
			},
			ReportValues = 
			{ 
				ReportedDamage = "ValidBaseDamageAddition",
			}
		},
		
		StatLines = 
		{
			"BlastDamageBoostStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
				IncludeSigns = true,
			},
			{
				Key = "MassiveAttackSizeModifier",
				ExtractAs = "AoEChange",
				Format = "PercentDelta",
				HideSigns = true,
				SkipAutoExtract = true,
			},
		}
	},
	MassiveKnockupBoon = 
	{
		Icon = "Boon_Hephaestus_35",
		InheritFrom = { "BaseTrait", "FireBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic =
			{
				Multiplier = 2.0,
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast"  },
			EffectName = "DelayedKnockbackEffect",
			Args = 
			{
				TriggerDamage = 
				{ 
					BaseValue = 300,
					AbsoluteStackValues = 
					{
						[1] = 50,
						[2] = 30,
						[3] = 20,
					},
				},
				ReportValues = 
				{ 
					ReportedDamage = "TriggerDamage",
				}
			},
		},
		StatLines = 
		{
			"DelayedKnockbackStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
			},
			{
				ExtractAs = "DelayedKnockbackDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DelayedKnockbackEffect",
				BaseProperty = "Duration",
				DecimalPlaces = 1,
			},
		}
	},
	WeaponUpgradeBoon = -- Legendary
	{
		InheritFrom = { "LegendaryTrait", "EarthBoon" },
		Icon = "Boon_Hephaestus_40",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		AcquireFunctionName = "UpgradeAspect",
		AcquireFunctionArgs = 
		{
			UpgradeLevels = 1,
			ReportValues = { ReportedUpgrade = "UpgradeLevels" }
		},
		StatLines = 
		{
			"AspectRankStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrade",
				ExtractAs = "Rank",
				IncludeSigns = true,
			},
		}
	},
})