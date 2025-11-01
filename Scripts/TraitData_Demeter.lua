OverwriteTableKeys( TraitData, {
	-- Demeter	
	DemeterWeaponBoon =
	{
		Icon = "Boon_Demeter_27",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Melee",
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
			FunctionName = "ApplyRoot",
			Args = 
			{
				EffectName = "ChillEffect",
			},	
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.30,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.15,
					[2] = 1.10,
					[3] = 1.05,
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
				BlockGraphic = "SuitDeflect_Demeter",
			}
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "GroupName",
				ChangeValue = "Standing",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Demeter",
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
				ChangeValue = "StaffComboAttack3Dissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Demeter",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Demeter",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Demeter",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Demeter",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Demeter",
				ChangeType = "Absolute",
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
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "DaggerCharge_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobCloseAttackAspect",			
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Demeter_In",
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
				ChangeValue = "ProjectileTorchGhostExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Demeter",
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

	DemeterSpecialBoon =
	{
		Icon = "Boon_Demeter_30",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Secondary",
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
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			FunctionName = "ApplyRoot",
			Args = 
			{
				EffectName = "ChillEffect",
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
					[2] = 1.10,
					[3] = 1.05,
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
							Name = "/SFX/Player Sounds/DemeterProjectileLoop",
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
				FireFx = "TorchOrbitStartSwirl_Demeter",
			}
		},
		PropertyChanges = {

			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "DemeterStaffProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "StaffBallProjectileCharged_Demeter_Shadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Demeter",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Demeter",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Demeter", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Demeter",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/DemeterColdDaggerSwipe",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "FireFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Demeter",
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
				ChangeValue = "AxeSwipeUpper_Demeter",
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
				ChangeValue = "AxeSpinDouble_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Demeter",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Demeter",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Demeter",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Demeter",
			},
			--[[
			{
				WeaponNames = WeaponSets.HeroSecondaryWeapons,
				ChangeValue = 1.4,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
			]]
		},
		StatLines =
		{
			"SpecialDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipAttackBonus",
					Format = "PercentDelta",
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

	DemeterCastBoon =
	{
		Icon = "Boon_Demeter_29",
		InheritFrom = { "BaseTrait", "WaterBoon" },
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
		
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"DemeterCastBlast"},
			FunctionName = "ApplyRoot",
			Args = 
			{
				EffectName = "ChillEffect",
			},	
		},
		WeaponDataOverride =
		{
			WeaponCast =
			{
				FireScreenshake = { Distance = 3, Speed = 200, Duration = 0.5, FalloffSpeed = 3000 },
				HitScreenshake = { Distance = 0, Speed = 0, Duration = 0.0, FalloffSpeed = 0 },
				HitSimSlowParameters = { },
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = { "WeaponCast" },
			ExcludeLinked = true,
			FunctionName = "ContinuousDemeterCast",
			FunctionArgs = 
			{
				ProjectileName = "DemeterCastBlast",
				Delay = 0.5,
				Fx = "DemeterIceRainExact",
				DamageMultiplier = 
				{
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 5/10,
						[2] = 3/10,
						[3] = 2/10,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedFuse = "Delay",
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
					Graphic = "CastCircleInDemeter",
					ImpactFx = "DemeterSlowImpact",
					ArmedImpactFx = "null",
					-- DeathFx = "CastCircleOut",
				}
			},
			{
				WeaponName = "WeaponCast",
				WeaponProperty = "FireFx2",
				ChangeValue = "OlympianAttackFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileName = "ProjectileCast",
				EffectName = "OnHitStun",
				EffectProperty = "Active",
				ChangeValue = false,
			},

		},
		StatLines =
		{
			"CastDamageOverTimeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "DemeterCastBlast",
				BaseProperty = "Damage",
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
		},
	},

	DemeterSprintBoon = 
	{
		Icon = "Boon_Demeter_28",
		InheritFrom = { "BaseTrait", "WaterBoon"},
		Slot = "Rush",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.5
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
			ValidProjectiles = { "DemeterSprintStorm" },
			EffectName = "LegacyChillEffect",
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  {"WeaponSprint"},
			FunctionName = "DemeterSprintBlast",
			FunctionArgs =
			{
				ProjectileNames = {"DemeterSprintStorm"},
				MaxProjectiles = 1,
				StartDelay = 0.2,
				DamageMultiplier = 
				{ 
					BaseValue = 1.0,
					AbsoluteStackValues = 
					{
						[1] = 0.50,
						[2] = 0.25,
					},
				},
				BlastRadiusMultiplier = 1,
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			},
		},
		StatLines =
		{
			"StormDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "DemeterSprintStorm",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Duration",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterSprintStorm",
				BaseProperty = "TotalFuse",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "Fuse",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterSprintStorm",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ProjectileSlow",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterSprintDefense",
				BaseProperty = "SpeedMultiplierOfEnemyProjectilesInside",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ChillAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "LegacyChillEffect",
				BaseProperty = "ElapsedTimeMultiplier",
				Format = "NegativePercentDelta",
			},
			{
				ExtractAs = "ChillDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "LegacyChillEffect",
				BaseProperty = "Duration",
			},
		}
	},

	DemeterManaBoon = 
	{
		InheritFrom = { "BaseTrait", "ManaOverTimeSource", "EarthBoon"},
		Icon = "Boon_Demeter_31",
		Slot = "Mana",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		SetupFunction =
		{
			Name = "IdleManaRegenSetup",
			Args =
			{
				PercentManaRegenPerSecond =
				{
					BaseValue = 0.5,
					AbsoluteStackValues =
					{
						[1] = 0.5,
						[2] = 0.4,
						[3] = 0.3,
						[4] = 0.2,
					},
				},
				MovePenaltyDuration = 0.5,
				ManaRegenStartFx = "DemeterManaBoonFx",
				ManaRegenStartSound = "/SFX/Player Sounds/DemeterTranquilGainStart",
				ReportValues = { ReportedManaRecovery = "PercentManaRegenPerSecond", ReportedMovePenaltyDuration = "MovePenaltyDuration" }
			},
			RunOnce = true
		},
		StatLines =
		{
			"RelativeManaRegenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				Format = "Percent",
				DecimalPlaces = 1,
				HideSigns = true,
			},
			{
				Key = "ReportedMovePenaltyDuration",
				ExtractAs = "TooltipMovePenaltyDuration",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		}
	},

	CastNovaBoon =
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Demeter_32",
		God = "Demeter",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 2,
			},
			Epic =
			{
				Multiplier = 3,
			},
			Heroic =
			{
				Multiplier = 4,
			},
		},		

		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "DemeterCastStorm" },
			EffectName = "LegacyChillEffect",
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "DemeterCastBlast",
			FunctionArgs =
			{
				ProjectileNames = {"DemeterCastStorm"},
				MaxProjectiles = 1,
				StartDelay = 0.2,
				DamageMultiplier = 
				{ 
					BaseValue = 1.0,
					AbsoluteStackValues = 
					{
						[1] = 0.6,
						[2] = 0.4,
						[3] = 0.2,
					},
				},
				BlastRadiusMultiplier = 1,
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			},
		},
		StatLines =
		{
			"StormDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "DemeterCastStorm",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Duration",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterCastStorm",
				BaseProperty = "TotalFuse",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ProjectileSlow",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterSprintDefense",
				BaseProperty = "SpeedMultiplierOfEnemyProjectilesInside",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "Fuse",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterCastStorm",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ChillAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "LegacyChillEffect",
				BaseProperty = "ElapsedTimeMultiplier",
				Format = "NegativePercentDelta",
			},
			{
				ExtractAs = "ChillDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "LegacyChillEffect",
				BaseProperty = "Duration",
			},
		}
	},

	PlantHealthBoon =
	{
		Icon = "Boon_Demeter_34",
		InheritFrom = { "BaseTrait", "EarthBoon"},
		God = "Demeter",
		
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolShovel" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom" },
				HasNone = { "BlockGiftBoons" },
			},
		},

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.2,
			},
			Epic =
			{
				Multiplier = 1.4,
			},
			Heroic =
			{
				Multiplier = 1.6,
			}
		},
		AcquireFunctionName = "AddTraitResources",
		AcquireFunctionArgs = 
		{
			Delay = 0.5,
			GiftResources = 
			{
				SeedMystery = 1,
			},
		},
		ResourceGatherHeal = 
		{
			BaseValue = 0.1,
			AbsoluteStackValues =
			{
				[1] = 0.02,
				[2] = 0.01,
			},
		},
		StatLines =
		{
			"PlantHealthStatDisplay1",
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"PlantHealthStatDisplay1",
				"HealingReductionNotice",
			},
		},
		ExtractValues =
		{
			{
				Key = "ResourceGatherHeal",
				ExtractAs = "TooltipHealthConversion",
				Format = "PercentHeal",
				HideSigns = true,
			}
		}
	},
	BoonGrowthBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredUpgradeableGodTraits",
				FunctionArgs = { Count = 1 },
			},
		},
		Icon = "Boon_Demeter_36",
		BlockStacking = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 5/6,
			},
			Epic =
			{
				Multiplier = 4/6,
			},
			Heroic =
			{
				Multiplier = 3/6,
			},
		},
		AcquireFunctionName = "UpdateUpgradableTraitCount",
		RoomsPerUpgrade = 
		{ 
			Amount = { BaseValue = 6 },
			Rarity = true,
			LowPriorityTraitName = "BoonGrowthBoon",
			ReportValues = 
			{ 
				ReportedRoomsPerUpgrade = "Amount" 
			},
		},
		CurrentRoom = 0,
		OnLevelOrRarityChangeFunctionName = "CreditAccumulatedTime",
		StatLines =
		{
			"EncounterRarityStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedRoomsPerUpgrade",
				ExtractAs = "TooltipRoomInterval",
			}
		},
	},

	ReserveManaHitShieldBoon =
	{
		Icon = "Boon_Demeter_33",
		BlockStacking = true,
		InheritFrom = { "BaseTrait", "EarthBoon" },

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 20/25,
			},
			Epic =
			{
				Multiplier = 15/25,
			},
			Heroic =
			{
				Multiplier = 10/25,
			}
		},
		God = "Demeter",
		SetupFunction =
		{
			Name = "ActivateManaReserveInvulnerability",
			EffectName = "ReserveManaInvulnerability", -- for package builder
			
			Args =
			{
				ManaReservationCost =
				{
					BaseValue = 25,
					AsInt = true,
					MinimumSourceValue = 1,
					MinMultiplier = -1,
					IdenticalMultiplier =
					{
						Value = -7/6,
					},
				},
				ReportValues = { ReportedManaReservationCost = "ManaReservationCost" }
			},
		},
		OnExpire = 
		{
			FunctionName = "TraitUnreserveMana",
			FunctionArgs = { Name = "ManaReserveTraitInvulnerability" },
		},
		StatLines =
		{
			"ReserveManaStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaReservationCost",
				ExtractAs = "TooltipManaReservation",
			}
		}
	},

	SlowExAttackBoon = 
	{
		Icon = "Boon_Demeter_38",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.3,
			},
			Epic =
			{
				Multiplier = 1.6,
			},
			Heroic =
			{
				Multiplier = 1.9,
			}
		},
	
		AddOutgoingDamageModifiers =
		{
			ExMultiplier =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				--MinMultiplier = 0.1,
				AbsoluteStackValues =
				{
					[1] = 1.15,
					[2] = 1.10,
					[3] = 1.05,
				},
			},
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ExMultiplier"},
		},
		--[[
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponStaffSwing5","WeaponDagger5",},
				ChangeValue = 1.2,
				SpeedPropertyChanges = true,
			}
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponAxeSpin", "WeaponTorch" },
			Value = 1.2,
			ReportValues = { ReportedSpeedMultiplier = "Value" }
		},
		]]
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			ExWeapons = true,
			ManaCostAdd = 10,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		StatLines = 
		{
			"ExAttackDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipAttackBonus",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCostAddition",
				IncludeSigns = true,
			},
			--[[
			{
				Key = "ReportedSpeedMultiplier",
				ExtractAs = "TooltipSpeedMultiplier",
				Format = "PercentDelta",
				SkipAutoExtract = true,
			}
			]]
		},
	},

	CastAttachBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Demeter_35",
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
		--[[
		OnProjectileArmFunction =
		{
			FunctionName = "OnDemeterCastArmed",
			FunctionArgs = 
			{
				Speed = 1000,
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponCast"},
			FunctionName = "CheckArmImput",
		},
		OnWeaponChargeCanceledFunctions = 
		{
			ValidWeapons = {"WeaponCastArm"},
			FunctionName = "CheckCastDetach",
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "AttachToOwner",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "IgnoreCancelAttachedProjectiles",
				ChangeValue = true,
			}
		},]]
		AddOutgoingDamageModifiers =
		{
			ValidProjectiles = {"ProjectileCast"},
			ValidWeaponMultiplier =
			{
				BaseValue = 1.20,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.10,
					[2] = 1.05,
				},
			},
			RequiredEffects = { "InsideCastBuff" },
			RequiredSelfEffectsMultiplier =
			{
				BaseValue = 1.20,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.10,
					[2] = 1.05,
				},
			},
			
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidWeaponMultiplier" 
			},
		},
		StatLines = 
		{
			"ExCastDamageStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
		},
	},

	RootDurationBoon = 
	{
		Icon = "Boon_Demeter_39",
		InheritFrom = { "BaseTrait", "WaterBoon" },
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
	
		RootDurationExtension = 
		{
			BaseValue = 2,
			MinMultiplier = 0.1,
			IdenticalMultiplier =
			{
				Value = -0.5,
				DiminishingReturnsMultiplier = 0.5,
			},
		},
		StatLines =
		{
			"RootDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "RootDurationExtension",
				ExtractAs = "DurationExtension",
				IncludeSigns = true,
				DecimalPlaces = 1,
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

	InstantRootKill = -- Legendary
	{
		InheritFrom = { "LegendaryTrait", "EarthBoon" },
		Icon = "Boon_Demeter_40",
		OnDamageEnemyFunction =
		{
			FunctionName = "CheckChillKill",
			FunctionArgs =
			{
				ExecuteImmunities = 
				{
					Prometheus = 
					{
						GameStateRequirement = 
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 3,
							},
						}
					}
				},
				ChillDeathThreshold = 0.1,
				DamageMultiplier = 1.0,
				ProjectileName = "DemeterChillKill",
				ReportValues = 
				{ 
					ReportedThreshold = "ChillDeathThreshold",
					ReportedMultiplier = "DamageMultiplier",
				}
			}
		},
		StatLines =
		{
			"ShatterStatDisplay1",
		},
		SpeakerNames = { "Demeter" },
		ExtractValues =
		{
			{
				Key = "ReportedThreshold",
				ExtractAs = "TooltipDeathThreshold",
				Format = "Percent",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "DemeterChillKill",
				BaseProperty = "Damage",
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
		},
		FlavorText = "InstantRootKill_FlavorText",
	},
})