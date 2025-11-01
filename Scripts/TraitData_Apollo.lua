OverwriteTableKeys( TraitData, {
	-- Apollo
	ApolloWeaponBoon =
	{
		Icon = "Boon_Apollo_27",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Melee",
		ReferenceWeapon = "WeaponSpellLaser",
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
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.40,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.20,
					[2] = 1.15,
					[3] = 1.15,
					[4] = 1.15,
					[5] = 1.15,
					[6] = 1.10,
				},
			},
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ConditionalValidWeapon = 
			{
				TraitName = "TransformPrimaryTalent",
				WeaponName = "WeaponTransformAttack"
			},
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		WeaponDataOverride = 
		{
			WeaponSuitCharged = 
			{
				BlockGraphic = "SuitDeflect_Apollo",
			}
		},
		PropertyChanges = {
			-- Range/Area Properties
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.6,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponSuit",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 0.75,
				ChangeType = "Add",
			},		
			{
				WeaponName = "WeaponLob",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},		
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ApolloSwipeSFX",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxe3",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ApolloAxeFinishSFX",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponLob",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileProperty = "IgnoreObstacleImpactDuration",
				ChangeValue = 0.10,
			},															
			-- Apollo VFX
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack3Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx4_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Apollo",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Apollo",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Apollo",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Apollo",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Apollo",
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
				ChangeValue = "DaggerCharge_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Apollo_In",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "EosProjectileShadow",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Apollo",
				ChangeType = "Absolute",
			},
		},

		StatLines =
		{
			"AttackDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "PercentDelta",
			},
			{
					Key = "ReportedAoEIncrease",
					ExtractAs = "AOEBonus",
					Format = "PercentDelta",
					SkipAutoExtract = true,
			},
		}
	},
	ApolloSpecialBoon =
	{
		Icon = "Boon_Apollo_30",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Secondary",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.34,
			},
			Epic =
			{
				Multiplier = 1.67,
			},
			Heroic =
			{
				Multiplier = 2.00,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.6,
				SourceIsMultiplier = true,
				MinMultiplier = 0.17,
				IdenticalMultiplier =
				{
					Value = -0.67,
					DiminishingReturnsMultiplier = 0.5,
				},
			},
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ConditionalValidWeapon = 
			{
				TraitName = "TransformSpecialTalent",
				WeaponName = "WeaponTransformSpecial"
			},
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		WeaponDataOverride =
		{
			WeaponAxeBlock2 =
			{
				Sounds = 
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/ApolloAxeBlockLoop",
							StoppedBy = { "ChargeCancel", "TriggerRelease" },
						},
					},
				}
			}
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial"},
			ExcludeLinked = true,
			AddWeaponProperties = 
			{
				FireFx = "TorchOrbitStartSwirl_Apollo",
			}
		},
		PropertyChanges =
		{
			-- Range/Area Properties
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.6,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},		
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponSuitRanged",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.6,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			-- Apollo VFX
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "ApolloGroundGlow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Apollo",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Apollo",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Apollo", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Apollo",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ApolloDaggerSwipe",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitName = "AxeRallyAspect",
				FalseTraitName = "AxeBlockEmpowerTrait",
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitName = "AxeRallyAspect",
				FalseTraitName = "AxeBlockEmpowerTrait",
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitName = "AxeBlockEmpowerTrait",
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitName = "AxeBlockEmpowerTrait",
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSpinDouble_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Apollo",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Apollo",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Apollo",
			},
		},
		
		StatLines =
		{
			"SpecialDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "PercentDelta",
			},
			{
					Key = "ReportedAoEIncrease",
					ExtractAs = "AOEBonus",
					Format = "PercentDelta",
					SkipAutoExtract = true,
			},
		},
	},
	ApolloCastBoon =
	{
		Icon = "Boon_Apollo_29",
		InheritFrom = { "BaseTrait", "FireBoon" },
		Slot = "Ranged",
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
		WeaponDataOverride =
		{
			WeaponCast =
			{
				HitScreenshake = {},
				HitSimSlowParameters =
				{
				},

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					},

					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ElectricZapSmall",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/Player Sounds/ElectricZapSmall",
						Brick = "/SFX/Player Sounds/ElectricZapSmall",
						Stone = "/SFX/Player Sounds/ElectricZapSmall",
						Organic = "/SFX/Player Sounds/ElectricZapSmall",
						StoneObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						BrickObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						MetalObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						BushObstacle = "/SFX/Player Sounds/ElectricZapSmall",
					},
				},
			},
		},
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckBlindApply",
			FunctionArgs = 
			{
				EffectName = "BlindEffect",
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "ApolloDelayedBlast",
			FunctionArgs =
			{
				ProjectileName = "ApolloSingleCastStrike",
				Delay = 2.85,
				DamageMultiplier = 
				{ 
					BaseValue = 1.0,
					AbsoluteStackValues = 
					{
						[1] = 0.5,
						[2] = 0.25,
					},
				},
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			},
		},
		OnEarlyCastDetonation = 
		{
			FunctionName = "ApolloEarlyCastBlast",
			FunctionArgs = 
			{
				ProjectileName = "ApolloSingleCastStrike",
				DamageMultiplier = 
				{ 
					BaseValue = 1.0,
					AbsoluteStackValues = 
					{
						[1] = 0.500,
					},
				},
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperty = "FireFx",
				ChangeValue = "QuickFlashYellow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperties =
				{
					ImpactFx = "null",
					Graphic = "CastCircleInApollo",
					ArmedGraphic = "CastCircleArmedApollo",
					GroupName = "FX_Terrain_Add",
					DetonateFx = "CastCircleOutApollo",
					HideGraphicOnDetonate = false
				}
			},
		},
		
		StatLines =
		{
			"CastDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ApolloSingleCastStrike",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
		}
	},
	ApolloExCastBoon =
	{
		Icon = "Boon_Apollo_31",
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
			},
		},
		
		WeaponDataOverride =
		{
			WeaponCast =
			{
				HitScreenshake = {},
				HitSimSlowParameters =
				{
				},

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					},

					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ElectricZapSmall",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/Player Sounds/ElectricZapSmall",
						Brick = "/SFX/Player Sounds/ElectricZapSmall",
						Stone = "/SFX/Player Sounds/ElectricZapSmall",
						Organic = "/SFX/Player Sounds/ElectricZapSmall",
						StoneObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						BrickObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						MetalObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						BushObstacle = "/SFX/Player Sounds/ElectricZapSmall",
					},
				},
			},
		},
		StatLines =
		{
			"OmegaCastDamageOverTimeStatDisplay1",
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckArmedApolloCast",
			Args = 
			{
				ValidProjectileName = "ProjectileCast",
				ProjectileName = "ApolloCastRapid",
				DamageMultiplier = 
				{ 
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 0.5,
						[2] = 0.4,
						[3] = 0.3,
						[4] = 0.2,
					},
				},
				
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ApolloCast",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ApolloCast",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
			},
			{
				ExtractAs = "BeamDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ApolloCast",
				BaseProperty = "TotalFuse",
			}
		}
	},
	ApolloSprintBoon =
	{
		Icon = "Boon_Apollo_28",
		InheritFrom = { "BaseTrait", "FireBoon"},
		Slot = "Rush",
		WeaponDataOverride =
		{
			WeaponSprint =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/ApolloSprintLoop" ,
							StoppedBy = { "ChargeCancel" }
						},
					},
				},
			}
		},
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
				Multiplier = 2,
			},
		},
		OnSprintAction = 
		{
			EffectName = "BlindEffect",
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocity",
				BaseValue = 297,
				ChangeType = "Add",
				ExcludeLinked = true,
				MinMultiplier = 0.25,
				IdenticalMultiplier =
				{
					Value = -0.75,
				},
			},
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 133.5,
				ChangeType = "Add",
				ExcludeLinked = true,
				MinMultiplier = 0.25,
				IdenticalMultiplier =
				{
					Value = -0.75,
				},
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "ApolloControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintFx",
				EffectProperty = "BackFx",
				ChangeValue = "MelSprintFxSpawner_Apollo"
			},
		},
		
		StatLines =
		{
			"SprintSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "PercentOfBase",
				BaseType = "Weapon",
				BaseName = "WeaponSprint",
				BaseProperty = "SelfVelocityCap",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
		}
	},
	ApolloManaBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Apollo_35",
		Slot = "Mana",
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
		StatLines =
		{
			"ManaRestoreStatDisplay1",
		},
		
		OnProjectileDeathFunction = 
		{
			Name = "CheckApolloManaRestore",
			Args = 
			{
				ManaRestore = 
				{
					BaseValue = 40,
					AbsoluteStackValues = 
					{
						[1] = 20,
						[2] = 15,
						[3] = 10,
					},
				},
				ManaRestoreFx = "ApolloManaRegenFxEmitter",
				ReportValues = { ReportedManaRestore = "ManaRestore" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRestore",
				ExtractAs = "TooltipManaRecovery",
			},
		
		},
	},

	ApolloRetaliateBoon =
	{
		Icon = "Boon_Apollo_33",
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
			},
		},
		OnSelfDamagedFunction = 
		{
			Name = "ApolloRetaliate",
			FunctionArgs = 
			{
				ProjectileName = "ApolloRetaliateStrike",
				EffectName = "BlindEffect",
				Cooldown = 0.15,
				DamageMultiplier =
				{
					BaseValue = 1,
					MinMultiplier = 0.1,
					IdenticalMultiplier =
					{
						Value = -0.5,
					},
				},
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		StatLines =
		{
			"RevengeDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ApolloRetaliateStrike",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	PerfectDamageBonusBoon = 
	{
		Icon = "Boon_Apollo_36",
		InheritFrom = { "BaseTrait", "AirBoon"},
		PriorityDisplay = true,
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
		AddOutgoingDamageModifiers =
		{
			UndamagedMultiplier =
			{
				BaseValue = 1.10,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.5,
				},
			},
			ReportValues = { ReportedMultiplier = "UndamagedMultiplier"},
		},
		SetupFunction =
		{
			Name = "RoomStartResetPerfectDamageBonus",
		},
		OnSelfDamagedFunction = 
		{
			NotDamagingRetaliate = true,
			Name = "ResetPerfectDamageBonusBoon",
			FunctionArgs = 
			{
				Cooldown = 15,
				ReportValues  = { ReportedCooldown = "Cooldown" },
			}
		},
		StatLines =
		{
			"UnscathedDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
		}
	},
	BlindChanceBoon = 
	{
		Icon = "Boon_Apollo_39",
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
			},
		},

		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			EffectName = "BlindEffect",
			Chance = 
			{ 
				BaseValue = 0.10,
				AbsoluteStackValues =
				{
					[1] = 0.05,
					[2] = 0.03,
					[3] = 0.02,
					[4] = 0.01,
				},
			},
			ReportValues = { ReportedChance = "Chance"}
		},
		StatLines =
		{
			"BlindChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	ApolloBlindBoon = 
	{
		Icon = "Boon_Apollo_37",
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
			},
		},
	
		AddOutgoingDamageModifiers =
		{
			HitVulnerabilityMultiplier =
			{
				BaseValue = 1.50,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.5,
					DiminishingReturnsMultiplier = 0.8,
				},
			},
			ValidActiveEffectGenus = "Blind",
			ReportValues = { ReportedMultiplier = "HitVulnerabilityMultiplier"},

		},
		StatLines =
		{
			"BackstabStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	ApolloCastAreaBoon = 
	{
		Icon = "Boon_Apollo_32",
		InheritFrom = { "BaseTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
			},
		},
		
		CastProjectileModifiers =
		{
			AreaIncrease = 
			{ 
				BaseValue = 1.4,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.75,
					DiminishingReturnsMultiplier = 0.75,
				},
			},
			ReportValues = { ReportedMultiplier = "AreaIncrease"}
		},
		StatLines =
		{
			"AreaCastStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		}
	},
	DoubleStrikeChanceBoon = 
	{
		Icon = "Boon_Apollo_45",
		InheritFrom = { "BaseTrait", "AirBoon" },
		StringTextNumeral = 2, -- used for string

		PropertyChanges = 
		{
			{
				WeaponNames = 
				{
					"WeaponStaffSwing",
					"WeaponStaffSwing2",
					"WeaponStaffSwing3",
					"WeaponStaffDash",
					
					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxe4",
					"WeaponAxe5",
					"WeaponAxeDash",
					
					"WeaponDagger",
					"WeaponDagger2",
					"WeaponDaggerDouble",
					"WeaponDaggerMultiStab",
					"WeaponDaggerDash",

					"WeaponTorch",

					"WeaponSuit",
				},
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.2,
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.2,
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.05,
				ExcludeLinked = true,
			},
			{
				WeaponNames = 
				{
					"WeaponStaffSwing",
					"WeaponStaffSwing2",
					"WeaponStaffSwing3",
					"WeaponStaffDash",
					
					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxe4",
					"WeaponAxe5",
					"WeaponAxeDash",
					
					"WeaponDagger",
					"WeaponDagger2",
					"WeaponDaggerDouble",
					"WeaponDaggerMultiStab",
					"WeaponDaggerDash",

					"WeaponTorch",
		
					"WeaponLob",

					"WeaponSuit",
				},
				ExcludeLinked = true,
				WeaponProperty = "AdditionalProjectileWaveChance",
				BaseValue = 0.05,
				AbsoluteStackValues =
				{
					[1] = 0.03,
					[2] = 0.02,
					[3] = 0.01
				},
				ReportValues = { ReportedChance= "ChangeValue" }
			}
		},
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
		StatLines = 
		{
			"DoubleStrikeChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "DoubleChance",
				Format = "LuckModifiedPercent",
			},
		}
	},
	DoubleExManaBoon = -- Legendary
	{
		Icon = "Boon_Apollo_40",
		InheritFrom = { "LegendaryTrait", "FireBoon" },
		CustomNameWithWeaponName = 
		{
			WeaponName = "WeaponTorch",
			Name = "DoubleExManaBoon_Torch",
		},
		ApplyAfterHammerTraits = true,
		OnWeaponChargeFunctions =
		{
			ValidWeapons =  {"WeaponSuitCharged"},
			ExcludeLinked = true,
			FunctionName = "RevertSuitChanges",
		},
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
			ExWeapons = true,
			ManaCostAdd = { BaseValue = 30 },
			InvalidWeapon = 
			{
				WeaponName = "WeaponTorchSpecial",
			},
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		ChargeStageModifiersArray = 
		{
			{
				TraitNames = { "LobGunAspect", "LobGunAttackDoublerTrait"},
				ValidWeapons = WeaponSets.HeroPrimaryWeapons,
				ExWeapons = true,
				AddWeaponProperties = 
				{
					NumProjectileWaves = 4,
					ProjectileWaveInterval = 0.15,
				},
			},
			{
				TraitName = "LobGunAspect",
				FalseTraitName = "LobGunAttackDoublerTrait",
				ValidWeapons = WeaponSets.HeroPrimaryWeapons,
				ExWeapons = true,
				AddWeaponProperties = 
				{
					NumProjectileWaves = 2,
					ProjectileWaveInterval = 0.15,
				},
			},
			{
				TraitName = "LobGunAspect",
				ValidWeapons = WeaponSets.HeroSecondaryWeapons,
				ExWeapons = true,
				AddWeaponProperties = 
				{
					NumProjectiles = 2,
					ProjectileInterval = 0.15,
					ProjectileIntervalStart = 0.15,
				},
			},
			{
				ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
				FalseTraitNames = { "LobGunAspect", "TorchSprintRecallAspect" },
				InvalidWeapon = 
				{
					WeaponName = "WeaponTorchSpecial",
				},
				ExWeapons = true,
				MultiplyExistingWeaponProperties = 
				{
					NumProjectileWaves = true,
				},
				AddWeaponProperties = 
				{
					NumProjectileWaves = 2,
					ProjectileWaveInterval = 0.2,
				},
			},
			{
				ValidWeapons = WeaponSets.HeroPrimaryWeapons,
				FalseTraitNames = { "LobGunAspect", "TorchSprintRecallAspect" },
				AddProperty = 
				{
					RequiredWeapon = "WeaponSuit",
					DeferRevert = true,
				},
			},
			{
				ValidWeapons = WeaponSets.HeroSecondaryWeapons,
				FalseTraitNames = { "LobGunAspect", "TorchSprintRecallAspect", "SuitComboAspect"},
				AddProperty = 
				{
					RequiredWeapon = "WeaponSuit",
					DeferRevert = true,
				},
			},
		},
		PropertyChanges = 
		{
			{
				FalseTraitNames = { "StaffOneWayAttackTrait", "StaffSelfHitAspect" },
				WeaponNames = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponLobChargedPulse", },
				WeaponProperties = 
				{
					NumProjectileWaves = 2,
					ProjectileWaveInterval = 0.2,
				},
				ExcludeLinked = true,
			},
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponNames = { "WeaponStaffSwing5" },
				ExcludeLinked = true,
				WeaponProperty = "NumProjectileWaves",
				ChangeType = "Multiply",
				ChangeValue = 2,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "NumProjectileWaves",
				ChangeValue = 2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.2,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "ProjectileInterval",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
		},
		SetupFunction = 
		{
			Name = "ApolloExSetup"
		},
		StatLines =
		{
			"MagicCostStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCostAddition",
				IncludeSigns = true,
			},
		},
		FlavorText = "DoubleExManaBoon_FlavorText",
	},
})