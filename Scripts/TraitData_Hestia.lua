OverwriteTableKeys( TraitData, {
	-- Hestia
	HestiaWeaponBoon =
	{
		Icon = "Boon_Hestia_27",
		InheritFrom = { "BaseTrait", "FireBoon" },
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
			FunctionName = "ApplyBurn",
			Args = 
			{
				EffectName = "BurnEffect",
				NumStacks = 
				{
					BaseValue = 30,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 15,
						[2] = 10,
						[3] = 10,
						[4] = 10,
						[5] = 5,
					},
					AsInt = true,
				},
				ReportValues = {ReportedDamage = "NumStacks"}
			},			
		},
		WeaponDataOverride = 
		{
			WeaponSuitCharged = 
			{
				BlockGraphic = "SuitDeflect_Hestia",
			}
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack3Dissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Hestia",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Hestia",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Hestia",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Hestia",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx", 
				ChangeValue = "DaggerSwipeFastFlipDash_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Hestia",
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
				ChangeValue = "DaggerCharge_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger5",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HestiaSwipeBig",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HestiaSwipeSFX",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxe3",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HestiaFireballImpact",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Hestia_In",
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
				ChangeValue = "ProjectileTorchGhostExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Hestia",
				ChangeType = "Absolute",
			},
		},
		
		StatLines =
		{
			"BurnDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedDamage",
					ExtractAs = "TooltipDamage",
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},

	HestiaSpecialBoon =
	{
		InheritFrom = { "BaseTrait", "FireBoon" },
		Icon = "Boon_Hestia_30",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 45/35,
			},
			Epic =
			{
				Multiplier = 55/35,
			},
			Heroic =
			{
				Multiplier = 65/35,
			},
		},
		Slot = "Secondary",
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,	
			FunctionName = "ApplyBurn",
			Args = 
			{
				EffectName = "BurnEffect",
				NumStacks = 
				{
					BaseValue = 35,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 10,
						[2] = 10,
						[3] = 5,
					},
					AsInt = true,
				},
				ReportValues = {ReportedDamage = "NumStacks"}
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
							Name = "/SFX/Player Sounds/HestiaAxeBlockLoop",
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
				FireFx = "TorchOrbitStartSwirl_Hestia",
			}
		},
		PropertyChanges = {
			{
				WeaponNames = WeaponSets.HeroSecondaryWeapons,
				WeaponProperty = "FireFx2",
				ChangeValue = "OlympianAttackFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "HestiaGroundGlow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Hestia",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Hestia",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Hestia",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Hestia", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Hestia",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HestiaDaggerThrow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HestiaDaggerThrow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Hestia",
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
				ChangeValue = "AxeSwipeUpper_Hestia",
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
				ChangeValue = "AxeSpinDouble_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Hestia",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "GroupName",
				ChangeValue = "FX_Standing_Add",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Hestia",
				ChangeType = "Absolute",
			},				
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Hestia_Ex",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Hestia",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Hestia",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Hestia",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Hestia",
			},

		},
		StatLines =
		{
			"BurnDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedDamage",
					ExtractAs = "TooltipDamage",
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},

	HestiaCastBoon =
	{
		Icon = "Boon_Hestia_29",
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
				OnFiredFunctionArgs = 
				{
					ProjectileDataPropertiesMap = { TotalFuse = "FuseStart" },
				},
			}
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperty = "FireFx",
				ChangeValue = "QuickFlashRed",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					ImpactFx = "null",
					Graphic = "CastCircleInHestia",
					ArmedGraphic = "CastCircleArmedHestia",
					GroupName = "FX_Terrain_Add",
					DetonateFx = "null",
					DissipateFx = "CastCircleOutHestia",
					HideGraphicOnDetonate = false
				}
			},

		},
		OnCastEffectApplyFunction = 
		{
			FunctionName = "CheckCastBurnApply",
			FunctionArgs = 
			{
				Cooldown = 1.0,
				EffectName = "BurnEffect",
				NumStacks = 
				{
					BaseValue = 40,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 20,
						[2] = 15,
						[3] = 10,
					},
					AsInt = true,
				},
				ReportValues = 
				{
					ReportedDamage = "NumStacks",
					ReportedInterval = "Cooldown",
				}
			},
		},
		StatLines =
		{
			"BurnApplicationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "BurnDamage",
			},
			{
				Key = "ReportedInterval",
				ExtractAs = "ApplicationInterval",
				SkipAutoExtract = true,
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},

	HestiaSprintBoon = 
	{
		Icon = "Boon_Hestia_28",
		InheritFrom = { "BaseTrait", "FireBoon" },
		Slot = "Rush",
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
		DamageClamps = 
		{
			ValidProjectiles = 
			{
				"ZombieHRFire",
				"GreekFire",
				"OilPuddleFire",
				"OilPuddleFire02",
				"OilPuddleFire03",
				"OilPuddleFire04",
				"InfestedCerberusExplosiveFireball",
				"CerberusMagmaPuddle",
				"PrometheusFireCircle",
				"PrometheusFireCircleSmall",
				"PrometheusFireCircleLarge",
				"LavaTileWeapon",
				"LavaTileTriangle01Weapon",
				"LavaTileTriangle02Weapon"
			},
			Value = 1,
			ReportValues = { ReportedDamage = "Value"},
		},
		StatLines =
		{
			"SprintDamageStatDisplay1",
		},
		OnSprintAction = 
		{
			FunctionName = "HestiaSprintFlames",
			RunOnce = true,
			Args = 
			{
				ProjectileName = "HestiaSprintPuddle",
				Cooldown = 0.2,
				MinDistance = 150,
				MaxSpawns = 5,
				DamageMultiplier =
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 0.5,
						[2] = 0.3,
						[3] = 0.2,
					},
				},
			ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "DamageTaken",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "HestiaSprintPuddle",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "ReportedDamage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HestiaSprintPuddle",
				BaseProperty = "Damage",
			},
		}
	},

	HestiaManaBoon = 
	{
		Icon = "Boon_Hestia_31",
		InheritFrom = { "BaseTrait", "ManaOverTimeSource", "FireBoon" },
		Slot = "Mana",
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
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckManaOnHit",
			Args = 
			{
				FirstHitOnly = true,
				IsNotEx = true,
				ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
				MultihitProjectileWhitelist = 
				{
					"ProjectileStaffSingle",
				},
				MultihitProjectileConditions = 
				{
					ProjectileStaffSingle = { Cooldown = 0.5 },
				},
				ManaGain = 
				{
					BaseValue = 4,
					AbsoluteStackValues =
					{
						[1] = 2,
						[2] = 1,
					},
				},
				ReportValues = { ReportedManaRecovery = "ManaGain" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		},
		StatLines =
		{
			"ManaOnHitStatDisplay1",
		},
	},
	
	AloneDamageBoon = 
	{
		Icon = "Boon_Hestia_36",
		InheritFrom = { "BaseTrait", "FireBoon" },

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 18/15,
			},
			Epic =
			{
				Multiplier = 21/15,
			},
			Heroic =
			{
				Multiplier = 24/15,
			},
		},

		AddOutgoingDamageModifiers = 
		{
			AloneMultiplier =
			{
				BaseValue = 1.15,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.03,
					[2] = 1.02,
					[3] = 1.01,
				},
			},
			AloneDistance = 3000,
			ReportValues = 
			{ 
				ReportedMultiplier = "AloneMultiplier",
			}
		},
		StatLines = 
		{
			"AloneMultiplierStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Chance",
				Format = "PercentDelta",
			},
		}
	},

	OmegaZeroBurnBoon = 
	{
		Icon = "Boon_Hestia_35",
		InheritFrom = { "BaseTrait", "FireBoon" },
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
		BonusFirstTimeBurn = 
		{
			BaseValue = 80,
			AbsoluteStackValues =
			{
				[1] = 40,
				[2] = 20,
				[3] = 10,
			},
		},
		StatLines =
		{
			"OmegaZeroBurnStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "BonusFirstTimeBurn",
				ExtractAs = "Stacks",
				IncludeSigns = true,
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},

	CastProjectileBoon =
	{
		Icon = "Boon_Hestia_47",
		InheritFrom = { "BaseTrait", "FireBoon" },
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "HadesCastProjectileBoon", "CastAnywhereBoon", "CastLobBoon", "SelfCastBoon" },
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
		
		PreEquipWeapons = { "WeaponCastProjectile" },
		OverrideWeaponFireNames =
		{
			RangedWeapon = "nil",
			WeaponCastProjectile = "WeaponCast",
		},
		WeaponDataOverride = 
		{
			WeaponCast = 
			{
				UnarmedCastCompleteGraphic = "nil",
				Sounds = 
				{
					FireSounds = 
					{
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					}
				}
			}
		},
		SetupFunction =
		{
			Name = "SetupCastCast",
			RunOnce = true,
		},

		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperties = 
				{
					IgnoreOwnerAttackDisabled = true,
					Cooldown = 0,
					ChargeTime = 0,
					SelfVelocity = 0,
					FireGraphic = "null",
					AllowMultiFireRequest = true,
					RootOwnerWhileFiring = false,
					ChargeStartAnimation = "null",
					SetCompleteAngleOnFire = true,
					IgnoreForceCooldown = true,
					AllowExternalForceRelease = false,
					AddOnFire = "null",
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCastProjectile",
				ProjectileProperty = "Damage",
				BaseValue = 60,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamage = "ChangeValue" },
				AbsoluteStackValues =
				{
					[1] = 30,
					[2] = 20,
					[3] = 10,
				},
				AsInt = true,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow2",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponCastProjectile",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd",
				ChangeValue = "WeaponCastProjectile",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponCastProjectile",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnFire",
				ChangeValue = "WeaponCastProjectile",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnChargeCancel",
				ChangeValue = "WeaponCastProjectile",
			}
		},
		StatLines =
		{
			"FireballDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		}
	},

	FireballManaSpecialBoon = 
	{
		InheritFrom = { "BaseTrait", "FireBoon" },
		Icon = "Boon_Hestia_34",
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
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			ExWeapons = true,
			ManaCostAdd = 10,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			FunctionName = "CheckFireballSpawn",
			FunctionArgs = 
			{
				ProjectileName = "ProjectileFireball",
				DamageMultiplier = 
				{
					BaseValue = 1,
					MinMultiplier = 0.1,
					AbsoluteStackValues = 
					{
						[1] = 0.50,
						[2] = 0.40,
						[3] = 0.30,
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
			"FireballDamageStatDisplay1",
		},
		ExtractValues = 
		{
			
			{
				SkipAutoExtract = true,
				Key = "ReportedCost",
				ExtractAs = "TooltipManaCost",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileFireball",
				BaseProperty = "Damage",
			},
		}
	},

	BurnExplodeBoon = 
	{
		Icon = "Boon_Hestia_39",
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
		OnEnemyDeathFunction = 
		{
			Name = "CheckBurnDeathExplosion",
			FunctionArgs = 
			{
				ProjectileName = "BurnNova",
				ProjectileDamageMultiplier =
				{
					BaseValue = 1.0,
					IdenticalMultiplier =
					{
						Value = -0.75,
					},
				},
				ProjectileCap = 8,
				--EffectName = "BurnEffect",
				ReportValues =
				{
					ReportedDamageMultiplier = "ProjectileDamageMultiplier"
				},
			},
		},
		StatLines =
		{
			"DeathBlastStatDisplay1",
		},
		ExtractValues =
		{
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "BurnNova",
				BaseProperty = "Damage",
			},
		},
	},

	BurnArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "FireBoon" },
		Icon = "Boon_Hestia_37",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.04,	-- This should match BurnMissChance below
				AbsoluteStackValues =
				{
					[1] = 0.01,
				},
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeChance = "ChangeValue"},
			},
		},
		BurnMissChance = 
		{ 
			BaseValue = 0.04,
			AbsoluteStackValues =
			{
				[1] = 0.01,
			}, 
		}, -- This should match the property change above
		StatLines =
		{
			"BurnDodgeStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "DodgeChance",
				Format = "Percent",
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},

	BurnStackBoon =
	{
		Icon = "Boon_Hestia_40",
		InheritFrom = { "BaseTrait", "FireBoon" },
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
		BurnDamageMultiplier = 
		{ 
			BaseValue = 1.5, 
			SourceIsMultiplier = true,
			AbsoluteStackValues =
			{
				[1] = 1.50,
				[2] = 1.25,
				[3] = 1.20,
			},
		},
		StatLines =
		{
			"BurnIncreaseStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "BurnDamageMultiplier",
				ExtractAs = "BurnIncrease",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},

	BurnSprintBoon = --Legendary
	{
		InheritFrom = { "LegendaryTrait", "FireBoon" },
		Icon = "Boon_Hestia_33",
		OnBlockDamageFunction = 
		{
			Name = "HestiaBlockSpend",
			Args = 
			{
				ProjectileName = "HestiaSprintDefense",
				EffectArgs = 
				{
					EffectName = "BurnEffect",
					NumStacks = 400,
					ReportValues = {ReportedDamage = "NumStacks"},
				},		
				Vfx = "HestiaFlameParticleDefense",
				FireSound = "/SFX/BurnDamageSizzle",	
				Cooldown = 3,
				ReportValues = {ReportedCooldown = "Cooldown"},
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "HestiaCastDefense",
			FunctionArgs = 
			{
				ProjectileName = "HestiaSprintDefense",
				StartDelay = 0.1,
				BuffVfx = "HestiaFlameBuff",
				ReportValues = { ReportedDamage = "StackCount"}
			},
		},
		OnProjectileDeathFunction = 
		{
			ValidProjectiles = { "ProjectileCast" },
			Name = "RemoveCastDefense",
		},
		StatLines =
		{
			"ProjectileBurnDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "TooltipCooldown",
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		},
		FlavorText = "BurnSprintBoon_FlavorText",
	},
})