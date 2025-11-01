OverwriteTableKeys( TraitData, {
	-- Zeus
	ZeusWeaponBoon = 
	{
		Icon = "Boon_Zeus_27",
		Slot = "Melee",
		InheritFrom = { "BaseTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0.8,
			},
			Rare =
			{
				Multiplier = 1.2,
			},
			Epic =
			{
				Multiplier = 1.6,
			},
			Heroic =
			{
				Multiplier = 2.0,
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			EffectName = "DamageEchoEffect",
			Args = 
			{
				Modifier = 
				{ 
					BaseValue = 1.0,
					MinMultiplier = 0.10, 
					AbsoluteStackValues =
					{
						[1] = 0.20,
						[2] = 0.15,
					},
				},
				ReportValues = { ReportedMultiplier  = "Modifier"}
			},
		},
		StatLines = 
		{
			"StrainDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ZeusEchoStrike",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "EchoDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "EchoThreshold",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "DamageThreshold",
			},
		},
		WeaponDataOverride = 
		{
			WeaponSuitCharged = 
			{
				BlockGraphic = "SuitDeflect_Zeus",
			}
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Zeus",
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
				ChangeValue = "StaffComboAttack3Dissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Zeus",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Zeus",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Zeus",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Zeus",
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
				ChangeValue = "DaggerCharge_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Zeus_In",
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
				ChangeValue = "ProjectileTorchGhostExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Zeus",
				ChangeType = "Absolute",
			},
		}
	},

	ZeusSpecialBoon = 
	{
		Icon = "Boon_Zeus_30",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Secondary",
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
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			EffectName = "DamageEchoEffect",
			Args = 
			{
				Modifier = 
				{
					BaseValue = 1.00,
					AbsoluteStackValues =
					{
						[1] = 0.3,
						[2] = 0.2,
						[3] = 0.1,
					},
				},
				ReportValues = { ReportedMultiplier  = "Modifier"}
			}
		},
		StatLines = 
		{
			"StrainDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ZeusEchoStrike",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "EchoDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "EchoThreshold",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "DamageThreshold",
			},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial"},
			ExcludeLinked = true,
			AddWeaponProperties = 
			{
				FireFx = "TorchOrbitStartSwirl_Zeus",
			}
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "ZeusStaffProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "StaffBallProjectileCharged_Zeus_Shadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Zeus",
				ChangeType = "Absolute",
			},

			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Zeus",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Zeus", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Zeus",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ZeusLightningSlash",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Zeus",
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
				ChangeValue = "AxeSwipeUpper_Zeus",
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
				ChangeValue = "AxeSpinDouble_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Zeus",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx", },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Zeus",
				ChangeType = "Absolute",
			},				
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Zeus",
				ChangeType = "Absolute",
			},	
			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Zeus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Zeus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Zeus",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Zeus",
			},
		}
	},

	ZeusCastBoon = 
	{
		Icon = "Boon_Zeus_29",
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
				Multiplier = 30/25,
			},
			Epic =
			{
				Multiplier = 35/25,
			},
			Heroic =
			{
				Multiplier = 40/25,
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
					Graphic = "CastCircleInZeus",
					ArmedGraphic = "CastCircleArmedZeus",
					DetonateFx = "CastCircleOutZeus",
					HideGraphicOnDetonate = false
				}
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "OnZeusCast",
			FunctionArgs = 
			{
				SourceName = "ProjectileCast",
				ProjectileName = "ZeusCastStrike",
				DamageMultiplier =
				{
					BaseValue = 1.0,
					AbsoluteStackValues =
					{
						[1] = 0.2,
					},
				},
				Range = 440,
				StrikeInterval = 0.35,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedStrikes = "StrikeCount",
					ReportedInterval = "StrikeInterval",
				},
			}
		},
		StatLines =
		{
			"BoltDamageStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ZeusCastStrike",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 2,
			}
		}
	},

	ZeusSprintBoon = 
	{
		Icon = "Boon_Zeus_28",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Rush",
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
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponBlink", "WeaponSprint"},
			FunctionName = "ZeusSprintZap",
			FunctionArgs = 
			{
				ProjectileName = "ZeusSprintStrike",
				Cooldown = 0.35,
				RunFunctionNameOnTarget = "ZeusSprintSpend",
				Range = 455,
				DamageMultiplier =
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 0.25,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCost = "CostPerStrike",
					ReportedFuse = "Cooldown",
				},
			},
		},
		StatLines =
		{
			"BoltDamageStatDisplay3",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ZeusSprintStrike",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
					Key = "ReportedFuse",
				SkipAutoExtract = true,
				DecimalPlaces = 2,
			},
		}
	},
	
	ZeusManaBoon = 
	{
		Icon = "Boon_Zeus_34",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Mana",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			},
		},
		SetupFunction =
		{
			Name = "CheckZeusManaSpawn",
			Threaded = true,
			RunOnce = true,
			Args =
			{
				ConsumableName = "ManaDropZeus",
				Interval = 
				{
					BaseValue = 10,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -1,
						--[2] = -1,
					},
				},
				MinRange = 450,
				MaxRange = 1200,
				DespawnRange = 2500,
				
				ThreadName = "HeraManaBoonRespawn",
				Sound = "/SFX/Player Sounds/ZeusLightningWrathImpact",
				ReportValues = { ReportedInterval = "Interval" },
			},
		},
		StatLines = 
		{
			"ManaRespawnIntervalStatDisplay1"
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Amount",
				DecimalPlaces = 1,
				Format = "SpeedModifiedDuration",
			},
		}
	},

	ZeusManaBoltBoon = 
	{
		Icon = "Boon_Zeus_36",
		InheritFrom = { "BaseTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 40/30,
			},
			Epic =
			{
				Multiplier = 50/30,
			},
			Heroic =
			{
				Multiplier = 60/30,
			},
		},
	
		OnManaSpendAction = 
		{
			FunctionName = "CheckZeusManaBolt",
			FunctionArgs = 
			{
				Cooldown = 0.25,
				ProjectileName = "ZeusZeroManaStrike",
				Range = 380,
				DamageMultiplier =
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 10/30,
						[2] = 10/30,
						[3] = 5/30,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown",
				}
			},
		},
		StatLines =
		{
			"BoltDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ZeusZeroManaStrike",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Fuse",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
		}
	},

	BoltRetaliateBoon = 
	{
		Icon = "Boon_Zeus_33",
		InheritFrom = { "BaseTrait", "AirBoon" },
		God = "Zeus",
		OnSelfDamagedFunction = 
		{
			Name = "ZeusRetaliate",
			FunctionArgs = 
			{
				ProjectileName = "ZeusRetaliateStrike",
				Cooldown = 0.15,
				ConsecutiveStrikeChance = 0.5,
				MaxStrikes = { 
					BaseValue = 2,
					MinValue = 1,
					IdenticalMultiplier = 
					{
						Value = -0.5,
					},
				},
				ReportValues = 
				{ 
					ReportedMaxStrikes = "MaxStrikes",
					ReportedStrikeChance = "ConsecutiveStrikeChance"
				},
			}
		},
		StatLines =
		{
			"BoltMultiCastStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMaxStrikes",
				ExtractAs = "MaxStrikes",
			},
			{
				Key = "ReportedStrikeChance",
				ExtractAs = "StrikeChance",
				SkipAutoExtract = true,
				Format = "LuckModifiedPercent",
			},
			{
				ExtractAs = "Damage",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ZeusRetaliateStrike",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
		}
	},

	CastAnywhereBoon = 
	{
		Icon = "Boon_Zeus_48",
		InheritFrom = {"BaseTrait", "AirBoon" },
		PreEquipWeapons = { "WeaponAnywhereCast" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "CastProjectileBoon", "HadesCastProjectileBoon", "CastLobBoon", "SelfCastBoon" },
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
				Multiplier = 1.4,
			},
			Epic =
			{
				Multiplier = 1.8,
			},
			Heroic =
			{
				Multiplier = 2.2,
			},
		},
		OverrideWeaponFireNames =
		{
			RangedWeapon = "nil",
			WeaponAnywhereCast = "WeaponCast",
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
			Name = "SetupAnywhereCast",
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
				WeaponName = "WeaponAnywhereCast",
				ProjectileProperty = "Damage",
				BaseValue = 50,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamage = "ChangeValue" },
				IdenticalMultiplier =
				{
					Value = -0.6,
					MinMultiplier = 0.4,
				},
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
				ChangeValue = "WeaponAnywhereCast",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd",
				ChangeValue = "WeaponAnywhereCast",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponAnywhereCast",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnFire",
				ChangeValue = "WeaponAnywhereCast",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnChargeCancel",
				ChangeValue = "WeaponAnywhereCast",
			}
		},
		StatLines =
		{
			"CastProjectileDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		}
	},

	FocusLightningBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Zeus_32",
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
			FunctionName = "CheckZeusProjectile",
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			Args = 
			{
				ProjectileName = "ProjectileZeusSpark",
				FirstHitOnly = true,
				WindowCount = 3, -- "clip fire cooldown. no more than Count projectiles every Duration"
				WindowDuration = 0.75,
				DamageMultiplier =
				{
					BaseValue = 1.0,
					AbsoluteStackValues =
					{
						[1] = 0.50,
						[2] = 0.30,
						[3] = 0.20,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
				}
			},
		},
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusLightningBoon",
				ManaReservationCost = 50,
				ReportValues = 
				{ 
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		OnExpire = 
		{
			FunctionName = "TraitUnreserveMana",
			FunctionArgs = { Name = "FocusLightningBoon" },
		},
		StatLines =
		{
			"LightningDamageStatDisplay1",
		},
		ExtractValues = {
			{
				Key = "ReportedMultiplier",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileZeusSpark",
				BaseProperty = "Damage",
				ExtractAs = "Damage",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ProjectileZeusSpark",
				BaseProperty = "NumJumps",
				Format = "TotalTargets",
				ExtractAs = "Bounces",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},

	DoubleBoltBoon = 
	{
		Icon = "Boon_Zeus_37",
		InheritFrom = { "BaseTrait", "LegacyTrait", "AirBoon" },
		God = "Zeus",
		NumStrikes = 2, -- used only for text
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
		DoubleBoltChance =
		{
			BaseValue = 0.10,
			AbsoluteStackValues =
			{
				[1] = 0.05,
				[2] = 0.03,
				[3] = 0.02,
				--[4] = 0.01,
			},
		},
		StatLines = 
		{
			"DoubleBoltChanceStatDisplay1"
		},
		ExtractValues = {
			{
				Key = "DoubleBoltChance",
				ExtractAs = "DoubleChance",
				Format = "LuckModifiedPercent"
			},
		}
	},

	EchoExpirationBoon = 
	{
		Icon = "Boon_Zeus_38",
		InheritFrom = { "BaseTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 40/30,
			},
			Epic =
			{
				Multiplier = 50/30,
			},
			Heroic =
			{
				Multiplier = 60/30,
			},
		},
		DamageEchoOmegaDamageBonus =
		{
			BaseValue = 1.3,
			SourceIsMultiplier = true,
			AbsoluteStackValues =
			{
				[1] = 1.10,
				[2] = 1.05,
				[3] = 1.03,
				[4] = 1.02,
			},
		},
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckOmegaBlitzTrigger",
			ValidWeapons = WeaponSets.HeroAllWeaponsAndSprint,
		},
		StatLines =
		{
			"EchoExpirationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "DamageEchoOmegaDamageBonus",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "EchoDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "EchoThreshold",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "DamageThreshold",
			},
		}
	},

	LightningDebuffGeneratorBoon =
	{
		Icon = "Boon_Zeus_40",
		InheritFrom = { "BaseTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
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
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = {"ProjectileZeusSpark"},
			ValidWeaponMultiplier =
			{
				BaseValue = 1.2,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.10,
					[2] = 1.05,
				},
			},
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier" },
		},
		ZeusSparkBonusBounces = 3,
		StatLines =
		{
			"LightningDamageStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				Format = "PercentDelta",
				ExtractAs = "Damage",
			},
			{
				Key = "ZeusSparkBonusBounces",
				ExtractAs = "Bounces",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "EchoDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "EchoThreshold",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "DamageThreshold",
			},
		},
	},

	SpawnKillBoon = -- Legendary
	{
		InheritFrom = { "LegendaryTrait", "AirBoon" },
		Icon = "Boon_Zeus_39",
		OnEnemyDamagedAction =
		{
			FunctionName = "CheckSpawnZeusDamage",
			Args = 
			{
				Chance = 0.25,
				Damage = 9999,
				Vfx = "ZeusLightningIris",
				ExcludeProjectileName = "MedeaCurse",
				ReportValues = { ReportedChance = "Chance" },
			}
		},
		StatLines =
		{
			"KillChanceStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
				HideSigns = true,
			},
		},
		FlavorText = "SpawnKillBoon_FlavorText",
		SpeakerNames = { "Zeus" },
	},
})