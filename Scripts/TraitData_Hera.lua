OverwriteTableKeys( TraitData, {
	-- Hera 
	HeraWeaponBoon = 
	{
		Icon = "Boon_Hera_27",
		Slot = "Melee",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.20,
			},
			Epic =
			{
				Multiplier = 1.40,
			},
			Heroic =
			{
				Multiplier = 1.60,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.50,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.150,
					[2] = 1.100,
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
				BlockGraphic = "SuitDeflect_Hera",
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,			
			FunctionName = "ApplyDamageShare",
			Args = 
			{
				EffectName = "DamageShareEffect",
			},			
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack3Dissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Hera",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Hera",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Hera",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Hera",
				ChangeType = "Absolute",
			},
			
			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HeraSwipeSFX3",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Hera",
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
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "DaggerCharge_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			
			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HeraSwipeSFX1",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HeraSwipeSFX2",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	


			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Hera_In",
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
				ChangeValue = "ProjectileTorchGhostExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Hera",
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
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
				HideSigns = true,
			},
		},
	},
	HeraSpecialBoon = 
	{
		Icon = "Boon_Hera_30",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Slot = "Secondary",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 0.7/0.6,
			},
			Epic =
			{
				Multiplier = 0.8/0.6,
			},
			Heroic =
			{
				Multiplier = 0.9/0.6,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.6,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.150,
					[2] = 1.100,
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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,		
			FunctionName = "ApplyDamageShare",
			Args = 
			{
				EffectName = "DamageShareEffect",
			},
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
							Name = "/SFX/Player Sounds/HeraAxeBlockLoop",
							StoppedBy = { "ChargeCancel", "TriggerRelease" },
						},
					},
				}
			}
		},
		
		StatLines =
		{
			"SpecialDamageStatDisplay1",
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial"},
			ExcludeLinked = true,
			AddWeaponProperties = 
			{
				FireFx = "TorchOrbitStartSwirl_Hera",
			}
		},
		PropertyChanges = {

			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "HeraStaffProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "StaffBallProjectileCharged_Hera_Shadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hera",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Hera",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Hera", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Hera",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HeraSwipeSFXCombo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Hera",
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
				ChangeValue = "AxeSwipeUpper_Hera",
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
				ChangeValue = "AxeSpinDouble_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Hera",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_HeraEx",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_HeraEX",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Hera",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Hera",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Hera",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Hera",
			},

		},
		
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
				HideSigns = true,
			},
		}
	},
	HeraCastBoon = 
	{
		Icon = "Boon_Hera_29",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Ranged",
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
			},
		},
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckApplyDamageShare",
			FunctionArgs = 
			{
				EffectName = "DamageShareEffect",
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "HeraCastCountBlast",
			FunctionArgs =
			{
				ProjectileName = "HeraCastDamageProjectile",
				Delay = 0.05,
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
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			},
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Graphic = "CastCircleInHera",
				}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileName = "ProjectileCast",
				ProjectileProperties = 
				{
					DetonateFx = "CastCircleOutHera",
				}
			},
		},
		StatLines =
		{
			"CastMultipliedUnitDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HeraCastDamageProjectile",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
				HideSigns = true,
			},
		}
	},
	SpawnCastDamageBoon = 
	{
		Icon = "Boon_Hera_48",
		InheritFrom = { "BaseTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
				Multiplier = 6/3,
			},
		},
		OnEnemySpawnFunction =
		{
			FunctionName = "CheckCastSummonDamage",
			Args = 
			{
				ProjectileName = "HeraCastSummonProjectile",
				DamageMultiplier = 
				{ 
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 0.50,
						[2] = 0.25,
						[3] = 0.20,
						--[4] = 0.10,
					},
				},
				ReportValues = 
				{
					ReportedMultiplier = "DamageMultiplier",
				}
			},
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Graphic = "CastCircleInHera",
				}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileName = "ProjectileCast",
				ProjectileProperties = 
				{
					DetonateFx = "CastCircleOutHera",
				}
			},
		},
		StatLines = 
		{
			"CastSpawnDamageDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HeraCastSummonProjectile",
				BaseProperty = "Damage",
				ExtractAs = "Damage",
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
				HideSigns = true,
			},
		}
	},
	HeraSprintBoon = 
	{
		Icon = "Boon_Hera_28",
		InheritFrom = { "BaseTrait", "FireBoon" },
		Slot = "Rush",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintFx",
				EffectProperty = "BackFx",
				ChangeValue = "HeraSprintFxSpawner"
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintFx",
				EffectProperty = "FrontFx",
				ChangeValue = "MelSprintFxSpawner_Hera"
			},
		},
		OnSprintAction = 
		{
			FunctionName = "HeraSprintLink",
			RunOnce = true,
			Args = 
			{
				Radius = 430,
				Range = 600,
				StartDelay = 0.2,
				Cooldown = 0.2,
				Vfx = "HeraSprintPullFx",
				EffectName = "DamageShareEffect",
				NumJumps = 1,
				ProjectileName = "HeraSprintProjectile",
				VfxCooldown = 0.1, -- For the projectile link damage
				DamageMultiplier = { 
					BaseValue = 1,
					MinMultiplier = 0.1,
					AbsoluteStackValues = 
					{
						[1] = 0.50,
						[2] = 0.25,
					}, 
				},
				ReportValues = 
				{
					ReportedJumps = "NumJumps",
					ReportedMultiplier = "DamageMultiplier",
				}
			}
		},
		WeaponDataOverride =
		{
			WeaponSprint =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/HeraSprintLoop" ,
							StoppedBy = { "ChargeCancel" }
						},
					},
				},
			}
		},

		StatLines =
		{
			"DamageShareFirstHitDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HeraSprintProjectile",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
				HideSigns = true,
			},
		}
	},
	HeraManaBoon = 
	{
		Icon = "Boon_Hera_32",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Mana",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 0.9,
			},
			Epic =
			{
				Multiplier = 0.8,
			},
			Heroic =
			{
				Multiplier = 0.7,
			},
		},

		LastMomentManaRechargeArgs = 
		{
			Amount =
			{
				BaseValue = 20,
				AsInt = true,
				MinimumSourceValue = 5,
				AbsoluteStackValues =
				{
					[1] = -2,
					[2] = -1,
				},
			},
			Threshold = 5,
			FireSound = "/SFX/Player Sounds/HeraSwipeSFX3",
			FireText = "Hint_HeraManaRestore",
			FireFx = "ManaRegenFlashFx",
			ReportValues = 
			{ 
				ReportedAmount = "Amount",
				ReportedThreshold = "Threshold",	
			},
		},
		AcquireFunctionName = "UpdateLastMomentManaRestoreEligibility",
		StatLines =
		{
			"FocusManaStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmount",
				ExtractAs = "Amount",
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "Threshold",
				SkipAutoExtract = true,
			},
		}
	},
	
	CommonGlobalDamageBoon = 
	{
		InheritFrom = { "BaseTrait", "FireBoon" },
		Icon = "Boon_Hera_37",
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
		ActivationRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "GodBoonRarities", "Common" },
				Comparison = "<=",
				Value = 0,
			},
		},
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "GodBoonRarities", "Common" },
				Comparison = "<=",
				Value = 0,
			},
		},
		ExcludeFromRarityCount = true,
		StatLines =
		{
			"BonusDamageDisplay1",
		},
		AddOutgoingDamageModifiers = 
		{
			GameStateMultiplier =
			{
				BaseValue = 1.1,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.5,
					DiminishingReturnsMultiplier = 0.5,
				},
			},
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "Hero", "GodBoonRarities", "Common" },
					Comparison = "<=",
					Value = 0,
				},
			},
			ReportValues = 
			{ 
				ReportedTotalDamageChange = "GameStateMultiplier",
			}
		},
		ExtractValues =
		{
			{
					Key = "ReportedTotalDamageChange",
					ExtractAs = "TooltipSpeedBonus",
					Format = "PercentDelta",
			},
		}
	},	
	DamageShareRetaliateBoon = 
	{
		Icon = "Boon_Hera_33",
		InheritFrom = { "BaseTrait", "FireBoon" },
		BlockStacking = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
				Multiplier = 6/3,
			},
		},	
		AddOutgoingDamageModifiersArray = 
		{
			{
				ValidProjectiles = WeaponSets.OlympianProjectileNames,
				PerUniqueGodMultiplier =
				{
					BaseValue = 1.03,
					SourceIsMultiplier = true,
				},
				ReportValues = { ReportedMultiplier = "PerUniqueGodMultiplier"}
			},
			{
				ValidEffects = WeaponSets.OlympianEffectNames,
				PerUniqueGodMultiplier =
				{
					BaseValue = 1.03,
					SourceIsMultiplier = true,
				},
			}
		},
		MissingEffectDamageIncreasePerUniqueGod = { BaseValue = 0.03 },
		StatLines =
		{
			"RetaliateMultiplierStatDisplay1",
		},
		TrayStatLines= 
		{
			"TotalRetaliateMultiplierStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "OlympianMultiplier",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TotalOlympianMultiplier",
				Format = "UniqueGodPercentDelta",
				SkipAutoExtract = true
			},
		}
	},
	LinkedDeathDamageBoon = 
	{
		Icon = "Boon_Hera_35",
		InheritFrom = { "BaseTrait", "AirBoon" }, 
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
			},
		},		
		OnEnemyDeathFunction = 
		{
			Name = "CheckLinkDeathDamage",
			FunctionArgs = 
			{
				EffectName = "DamageShareEffect",
				DamageAmount = 
				{
					BaseValue = 40,
					MinMultiplier = 0.1,
					IdenticalMultiplier =
					{
						Value = -0.5,
						DiminishingReturnsMultiplier = 0.8,
					},
				},
				Vfx = "HeraRetaliateFx",
				Delay = 0.2,
				ReportValues = {
					ReportedDamage = "DamageAmount",
				}
			}
		},
		StatLines =
		{
			"LinkedDeathDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
			},
		}
	},
	BoonDecayBoon =
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			{
				FunctionName = "HasSuperchargeableBoon",
			},
		},
		Icon = "Boon_Hera_36",
		BlockStacking = true,
		BlockOfferIfPreviouslyPicked = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
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
		OnLevelOrRarityChangeFunctionName = "CreditMissingStacks",
		AcquireFunctionName = "HeraSuperchargeBoon",
		AcquireFunctionArgs = 
		{
			Stacks = {BaseValue = 1},
			ReportValues = {ReportedStacks = "Stacks"},
		},
		StatLines =
		{
			"LevelsGainedStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedStacks",
				ExtractAs = "TooltipTraitNum",
				IncludeSigns = true,
			},
		},
	},
	OmegaHeraProjectileBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hera_31",
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
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 1.75,
			}
		},
		ManaCostModifiers = 
		{
			WeaponNames = ConcatTableValues(WeaponSets.HeroAllWeaponsAndSprint, {"WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" }),
			ExWeapons = true,
			ManaCostAdd = 15,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		OnWeaponFiredFunctions =
		{
			WeaponNames = ConcatTableValues(WeaponSets.HeroAllWeaponsAndSprint, {"WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" }),	
			FunctionName = "CheckExProjectileSpawn",
			FunctionArgs = 
			{
				ProjectileName = "ProjectileHeraOmega",
				DamageMultiplier = 
				{
					BaseValue = 1,
					DecimalPlaces = 4, -- Needs additional precision due to the number being operated on
					AbsoluteStackValues = 
					{
						[1] = 0.25,
						[2] = 0.125,
						[3] = 10/120,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
			}
		},
		StatLines = 
		{
			"HeraRiftDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileHeraOmega",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCostAddition",
				IncludeSigns = true,
				SkipAutoExtract = true,
			},
		}
	},
	DamageSharePotencyBoon = 
	{
		Icon = "Boon_Hera_38",
		InheritFrom = { "BaseTrait", "WaterBoon" },
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		DamageShareDurationIncrease = 5,
		DamageShareAmountIncrease = {BaseValue = 0.1},
			
		StatLines = 
		{
			"DamageSharePotencyStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "DamageShareDurationIncrease",
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "DamageShareAmountIncrease",
				ExtractAs = "TooltipAmount",
				Format = "Percent",
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
			},
		}
	},
	AllElementalBoon =-- Legendary
	{
		Icon = "Boon_Hera_40",
		InheritFrom = {"LegendaryTrait"},
		Elements = { "Aether", "Earth", "Air", "Fire", "Water" }, 
		AcquireFunctionName = "GrantBoons",
		AcquireFunctionArgs = 
		{
			BoonSets = 
			{	
				-- Earth
				{ "ElementalDamageBoon", "ElementalOlympianDamageBoon" },
				-- Fire
				{ "ElementalBaseDamageBoon", "ElementalRallyBoon" },
				-- Air
				{ "ElementalDamageFloorBoon", "ElementalDodgeBoon" },
				-- Water
				{ "ElementalHealthBoon", "ElementalDamageCapBoon" },
			},
		},
		StatLines =
		{
			"AllElementStatDisplay",
		},
		FlavorText = "AllElementalBoon_FlavorText",
	},
})