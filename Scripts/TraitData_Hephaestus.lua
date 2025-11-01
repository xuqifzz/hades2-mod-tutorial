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
				MultihitProjectileWhitelist = 
				{
					"ProjectileStaffSingle",
					"ProjectileStaffWall",
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
		BlastReadyVfx = "HephaestusAttackReadyFx",
		BlastReadyDarkVfx = "HephaestusAttackReadyFx_Dark",
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				Format = "SpeedModifiedDuration",
				DecimalPlaces = 1,
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
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Hephaestus",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Hephaestus",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Hephaestus",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Hephaestus",
				ChangeType = "Absolute",
			},


			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
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
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
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
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
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
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Hephaestus",
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
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Hephaestus",
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
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Hephaestus",
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
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Hephaestus_In",
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
				ChangeValue = "ProjectileTorchGhostExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Hephaestus",
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
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Hephaestus",
				ChangeType = "Absolute",
			},
			{
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
				ChangeValue = "SuitNovaBurnRapid_Hephaestus",
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
				Multiplier = 12/14,
			},
			Epic =
			{
				Multiplier = 10/14,
			},
			Heroic =
			{
				Multiplier = 8/14,
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
					BaseValue = 14,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -2,
						[2] = -1,
					},
				},
				BlastDelay = 0.08,
				DamageMultiplier = 2.5,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			},
		},
		BlastReadyVfx = "HephaestusSpecialReadyFx",
		BlastReadyDarkVfx = "HephaestusSpecialReadyFx_Dark",
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
					Format = "SpeedModifiedDuration",
				DecimalPlaces = 1,
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
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial"},
			ExcludeLinked = true,
			AddWeaponProperties = 
			{
				FireFx = "TorchOrbitStartSwirl_Hephaestus",
			}
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
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Hephaestus", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Hephaestus",
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
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/HephaestusSwipeBig",
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
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Hephaestus",
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
				ChangeValue = "AxeSwipeUpper_Hephaestus",
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
				ChangeValue = "AxeSpinDouble_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Hephaestus",
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
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Hephaestus",
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
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Hephaestus",
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
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Hephaestus",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Hephaestus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Hephaestus_EX",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Hephaestus",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Hephaestus",
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
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Hephaestus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
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
				Multiplier = 70/60,
			},
			Epic =
			{
				Multiplier = 80/60,
			},
			Heroic =
			{
				Multiplier = 90/60,
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
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					ArmedImpactFx = "null",
					Graphic = "CastCircleInHephaestus",
					DetonateFx = "CastCircleOutHephaestus",
				}
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = { "WeaponCast" },
			ExcludeLinked = true,
			FunctionName = "IntermittentHephCastStrike",
			FunctionArgs = 
			{
				ProjectileName = "HephCastBlast",
				Count = 3,
				Delay = 1,
				DamageMultiplier = 
				{
					BaseValue = 1,
					DecimalPlaces = 3,
					AbsoluteStackValues = 
					{
						[1] = 20/60,
						[2] = 15/60,
						[3] = 10/60,
						[4] = 5/60,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedFuse = "Delay",
					ReportedDetonations = "Count",
				},
			}
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
				BaseName = "HephCastBlast",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Fuse",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDetonations",
				ExtractAs = "Detonations",
				SkipAutoExtract = true,
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
				DamageMultiplier = 2,
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
		BlastReadyVfx = "HephaestusSprintReadyFx",
		BlastReadyDarkVfx = "HephaestusSprintReadyFx_Dark",
				
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
					Format = "SpeedModifiedDuration",
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
		BlockStacking = true,
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
		OnDamagedManaConversionFlat = 150,
		DamageShave =
		{
			BaseValue = 1,
			AsInt = true,
		},
		StatLines =
		{
			"DamageShaveStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "DamageShave",
				ExtractAs = "Damage",
				Negative = true
			},
			{
				Key = "OnDamagedManaConversionFlat",
				ExtractAs = "TooltipMana",
				SkipAutoExtract = true
			},
		}
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
				BaseValue = 1.4,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.2,
					[2] = 1.1,
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
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			ArmorToDamageFlatConversion = 0.2,
			ReportValues = { ReportedBonus = "ArmorToDamageFlatConversion"}
		},
		AcquireFunctionName = "HeavyArmorInitialPresentation",
		OnLevelOrRarityChangeFunctionName = "RestoreHephaestusArmor",
		SetupFunctions =
		{
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
			{
				Key = "ReportedBonus",
				ExtractAs = "TooltipBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},
		}
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
				Source = "Renewable",
				ManaReservationCost = 30,
				ReportValues = 
				{ 
					ReportedArmor = "Amount",
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		OnExpire = 
		{
			FunctionName = "TraitUnreserveMana",
			FunctionArgs = { Name = "HephaestusArmor" },
		},
		OnLevelOrRarityChangeFunctionName = "RestoreRenewableHephaestusArmor",

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
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 100/75,
			},
			Epic =
			{
				Multiplier = 125/75,
			},
			Heroic =
			{
				Multiplier = 150/75,
			}
		}, 
		Invincible = true,
		CostumeTrait = true,
		IsRenewableArmor = true,
		OnEncounterStartFunction =
		{
			Name = "EncounterStartTempArmor",
			Args = 
			{
				Vfx = "HephaestusLaurels",
				Source = "Temporary",
				Amount =
				{
					BaseValue = 75,
					AbsoluteStackValues =
					{
						[1] = 75,
						[2] = 50,
						[3] = 25,
		 			},
				},
				Duration = 7,
				ReportValues = 
				{
					ReportedDuration = "Duration",
					ReportedAmount = "Amount",
				},
			}
		},
		StatLines =
		{
			"InvulnerableDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedAmount",
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
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
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
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 100/75,
			},
			Epic =
			{
				Multiplier = 125/75,
			},
			Heroic =
			{
				Multiplier = 150/75,
			}
		},
		MassiveAttackSizeModifier = 1.5,
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast", "HephLeapBlast" },
			ValidBaseDamageAddition = { 
				BaseValue = 75, 
				AbsoluteStackValues =
				{
					[1] = 25,
					[2] = 20,
	 			},
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
				Multiplier = 1.20/1.15,
			},
			Epic =
			{
				Multiplier = 1.25/1.15,
			},
			Heroic =
			{
				Multiplier = 1.30/1.15,
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast", "HephLeapBlast"  },
			EffectName = "DelayedKnockbackEffect",
			Args = 
			{
				Modifier = 
				{ 
					BaseValue = 1.15,
					AbsoluteStackValues = 
					{
						[1] = 0.05,
						[2] = 0.03,
						[3] = 0.02,
					},
				},
				ReportValues = 
				{ 
					ReportedModifier = "Modifier",
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
				Key = "ReportedModifier",
				ExtractAs = "DelayedKnockbackModifier",
				Format = "PercentDelta",
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
		},
		FlavorText = "WeaponUpgradeBoon_FlavorText",
	},
})