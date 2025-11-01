OverwriteTableKeys( TraitData, {
	-- Poseidon
	PoseidonWeaponBoon =
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_27",
		Slot = "Melee",
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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckPoseidonSplash",
			Args = 
			{
				CooldownName = "PoseidonPrimary",
				ProjectileName = "PoseidonSplashSplinter",
				ExcludeLinked = true,
				MultihitWeaponWhitelist = 
				{
				},
				MultihitWeaponConditions = 
				{
				},
				MultihitProjectileWhitelist = 
				{
					-- Staff
					"ProjectileSwing5",
					"ProjectileStaffSingle",
					"ProjectileStaffWall",

					-- Axe
					"ProjectileAxe3",
					"ProjectileAxe2",
					"ProjectileAxeOverhead",
					"ProjectileAxeNergalSlow",
					"ProjectileAxeNergalFast",
					"ProjectileAxeNergalFastDash",
					"ProjectileAxeSpin",

					-- Dagger
					"ProjectileDaggerSliceDouble",
					"ProjectileDaggerBackstab",
					"ProjectileDaggerSpinMorrigan",
					"ProjectileDaggerExecuteMorrigan",

					-- Torch
					"ProjectileTorchWave",
					"ProjectileTorchBallEos",
					"ProjectileTorchRepeatStrike",
					"ProjectileTorchGhostLarge",
					"ProjectileTorchGhostExplosion",
					"ProjectileTorchGhostLargeExplosion",
					"ProjectileTorchSupayBallEx",

					-- Lob
					"ProjectileLob",
					"ProjectileLobCharged",
					"ProjectileLobChargedPulse",
					"ProjectileLobOverheat",

					-- Suit
					"ProjectileSuitCharged",
					"ProjectileSuitDash",
				},
				MultihitProjectileConditions = 
				{
					ProjectileSwing5 = { Count = 5, Window = 0.3 },
					ProjectileStaffSingle = { Count = 3, Window = 0.25 },
					ProjectileStaffWall = { Count = 3, Window = 0.25 },

					ProjectileAxe3 = { Count = 4, Window = 0.15 },
					ProjectileAxe2 = { Count = 4, Window = 0.15 },
					ProjectileAxeOverhead = { Count = 5, Window = 0.45 },
					ProjectileAxeNergalSlow = { Count = 5, Window = 0.45 },
					ProjectileAxeNergalFast = { Count = 4, Window = 0.15 },
					ProjectileAxeNergalFastDash = { Count = 4, Window = 0.15 },
					ProjectileAxeSpin = { Count = 3, Window = 0.15 },

					ProjectileDaggerSliceDouble = { Count = 3, Window = 0.1 },
					ProjectileDaggerBackstab = { Count = 3, Window = 0.1 },
					ProjectileDaggerSpinMorrigan = { Count = 3, Window = 0.3 },
					ProjectileDaggerExecuteMorrigan = { Count = 3, Window = 0.1 },

					ProjectileTorchWave = { Count = 3, Window = 0.24 },
					ProjectileTorchBallEos = { Cooldown = 0.12 },
					ProjectileTorchRepeatStrike = { Count = 3, Window = 0.35 },
					ProjectileTorchGhostLarge  = { Cooldown = 0.12 },
					ProjectileTorchGhostExplosion  = { Count = 3, Window = 0.2 },
					ProjectileTorchGhostLargeExplosion  = { Count = 3, Window = 0.2 },
					ProjectileTorchSupayBallEx  = { Count = 3, Window = 0.26 },

					ProjectileLob = { Count = 3, Window = 0.08 },
					ProjectileLobCharged = { Count = 4, Window = 0.24 },
					ProjectileLobChargedPulse = { Count = 4, Window = 0.24 },
					ProjectileLobOverheat = { Count = 5, Window = 0.22 },

					ProjectileSuitCharged = { Count = 4, Window = 0.15 },
					ProjectileSuitDash = { Count = 4, Window = 0.21 },
				},
				Cooldown = 0.033,
				DamageMultiplier = 
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						--[1] = 0.334,
						[1] = 0.25,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
			},
		},
		StatLines = 
		{
			"SplashDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonSplashSplinter",
				BaseProperty = "Damage",
			},
		},
		WeaponDataOverride = 
		{
			WeaponSuitCharged = 
			{
				BlockGraphic = "SuitDeflect_Poseidon",
			}
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Poseidon",
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
				ChangeValue = "StaffComboAttack3Dissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffChargedAttackFxEmitter_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffWallIn_Poseidon",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing5",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffWall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "AnubisWallImpactFx_Poseidon",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				ProjectileName = "ProjectileStaffSingle",
				ProjectileProperty = "Graphic",
				ChangeValue = "AnubisRingFx_Poseidon",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponStaffSwing",
				TraitName = "StaffRaiseDeadAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx3_Poseidon",
				ChangeType = "Absolute",
			},

			{
				WeaponName = "WeaponDagger",
				FalseTraitName = "DaggerTripleAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDaggerDash",
				FalseTraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Poseidon",
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
				ChangeValue = "DaggerCharge_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerSpinMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerMorriganSpin_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				TraitName = "DaggerTripleAspect",
				ProjectileName = "ProjectileDaggerExecuteMorrigan",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Morrigan_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponAxe",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				FalseTraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
				FalseTraitName = "AxeRallyAspect",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalSlow",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe4",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe5",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFast",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				TraitName = "AxeRallyAspect",
				ProjectileName = "ProjectileAxeNergalFastDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaNergal_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileBullet_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "DeathFx",
				ChangeValue = "LobProjectileBulletFade_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "MedeaLoadFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "LobCloseAttackAspect",
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "MedeaFuseFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostIn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileGhostLargeIn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				FalseTraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},		
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				TraitName = "TorchEnhancedAttackTrait",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				TraitName = "TorchSprintRecallAspect",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Poseidon_In",
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
				ChangeValue = "ProjectileTorchGhostExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLargeExplosion",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "ProjectileTorchGhostExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "TorchEnhancedAttackTrait",
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlowWave_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuit",
				ProjectileName = "ProjectileSuit2",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				ProjectileName = "ProjectileSuitDouble",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunch_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitPunchFlare_R_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitDouble",
				WeaponProperty = "FireFx2",
				ChangeValue = "SuitPunchFlare_L_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitPunchLarge_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "StartFx",
				ChangeValue = "SuitNovaBurn_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitDashAttackTrait",
				WeaponName = "WeaponSuitDash",
				ProjectileName = "ProjectileSuitDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitDash",
				WeaponProperty = "FireFx",
				ChangeValue = "SuitExhaustDashTrail_R_Spawner_Poseidon",
				ChangeType = "Absolute",
			},
		},
	},

	PoseidonSpecialBoon =
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Secondary",
		Icon = "Boon_Poseidon_30",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
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
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			FunctionName = "CheckPoseidonSplash",
			Args = 
			{
				ProjectileName = "PoseidonSplashSplinter",
				CooldownName = "PoseidonSpecial",
				MultihitWeaponWhitelist = 
				{
				},
				MultihitWeaponConditions = 
				{

				},
				MultihitProjectileWhitelist =
				{
					-- Staff
					"ProjectileStaffBallCharged",

					-- Axe
					"ProjectileAxeBlock2",

					-- Dagger
					"ProjectileDaggerThrow",
					"ProjectileDaggerThrowCharged",

					-- Torch
					"ProjectileTorchOrbit",
					"ProjectileTorchOrbitEx",

					-- Lob
					"ProjectileThrowBlink",
					"ProjectileThrowCharged",
					"ProjectileLobSpecialBounce",

					-- Suit
					"ProjectileSuitGrenade",
					"ProjectileSuitBomb",
					"ProjectileSuitGrenadeStraight",
					"ProjectileSuitBombStraight",
				},
				MultihitProjectileConditions =
				{
					ProjectileStaffBallCharged = { Count = 3, Window = 0.12 },

					ProjectileAxeBlock2 = { Count = 4, Window = 0.2 },

					ProjectileDaggerThrow = { Cooldown = 0.12, },
					ProjectileDaggerThrowCharged = 
					{ 
						TraitNameRequirements  = 
						{
							{
								TraitName = "DaggerTripleAspect",
								Cooldown = 0.12,
							},
						},
					},

					ProjectileTorchOrbit = { Count = 3, Window = 0.32 },
					ProjectileTorchOrbitEx = { Cooldown = 0.12 },

					ProjectileThrowBlink = { Cooldown = 0.12 },
					ProjectileThrowCharged = { Count = 4, Window = 0.3 },
					ProjectileLobSpecialBounce = { Cooldown = 0.12 },

					ProjectileSuitGrenade = { Count = 3, Window = 0.15 },
					ProjectileSuitBomb = { Count = 3, Window = 0.2 },
					ProjectileSuitGrenadeStraight = { Count = 3, Window = 0.15 },
					ProjectileSuitBombStraight = { Count = 3, Window = 0.2 },
				},
				Cooldown = 0.033,
				DamageMultiplier = 
				{
					BaseValue = 25/20,
					AbsoluteStackValues =
					{
						[1] = 0.25,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
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
							Name = "/SFX/Player Sounds/PoseidonWaterProjectileLoop",
							StoppedBy = { "ChargeCancel", "TriggerRelease" },
						},
					},
				}
			}
		},
		StatLines = 
		{
			"SplashDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonSplashSplinter",
				BaseProperty = "Damage",
			},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial"},
			ExcludeLinked = true,
			AddWeaponProperties = 
			{
				FireFx = "TorchOrbitStartSwirl_Poseidon",
			}
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "PoseidonStaffProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "StaffBallProjectileCharged_Poseidon_Shadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Poseidon",
				ChangeType = "Absolute",
			},

			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileCurved_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Poseidon",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Poseidon", 
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerThrowMorrigan_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "DaggerHomingThrowAspect",
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan_Poseidon",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Poseidon",
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
				ChangeValue = "/SFX/Player Sounds/PoseidonWaterArrowFire",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
				WeaponName = "WeaponAxeSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSpinDouble_Poseidon",
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
				ChangeValue = "AxeSwipeUpper_Poseidon",
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
				ChangeValue = "AxeSpinDouble_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
				WeaponName = "WeaponAxeSpecial",
				ProjectileProperty = "StartFx",
				ChangeValue = "AxeSwipeUpper_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				FalseTraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hel_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "LobGunAspect",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileHel_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Poseidon",
				ChangeType = "Absolute",
			},				
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Poseidon",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				TraitName = "TorchDetonateAspect",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedChargedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravel_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocket_Poseidon",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketUnguided_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Graphic",
				ChangeValue = "SuitRocketTravelUnguided_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitRocketExplosion_Poseidon",
				ChangeType = "Absolute",
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenade",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBomb",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenade_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitGrenadeStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "Graphic",
				ChangeValue = "ShivaGrenadeBig_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitComboAspect",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitBombStraight",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "GrenadeExplosion_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Poseidon",
				ChangeType = "Absolute",
			},		
			{
				TraitName = "SuitSpecialJumpTrait",
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion_Poseidon",
			},
		}
	},

	PoseidonCastBoon =
	{
		Icon = "Boon_Poseidon_29",
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
					Graphic = "CastCircleInPoseidon",
					ArmedGraphic = "CastCircleArmedPoseidon",
					DetonateFx = "CastCircleOutPoseidon",
					HideGraphicOnDetonate = false
				}
			},
		},
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckSlipApply",
			FunctionArgs = 
			{
				EffectName = "AmplifyKnockbackEffect",
			},
		},

		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponCast"},
			ExcludeLinked = true,
			FunctionName = "CheckPoseidonCastSplash",
			FunctionArgs = 
			{
				ProjectileName = "PoseidonCastSplashSplinter",
				DamageMultiplier = 
				{
					BaseValue = 1.0,
					AbsoluteStackValues =
					{
						[1] = 0.5,
						[2] = 0.25,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
			},
		},
		StatLines = 
		{
			"SplashDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonCastSplashSplinter",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "KnockbackAmplifyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Duration",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "FontChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Chance",
				Format = "LuckModifiedPercent"
			},
			{
				External = true,
				ExtractAs = "FontDamage",
				BaseType = "ProjectileBase",
				BaseName = "PoseidonEffectFont",
				BaseProperty = "Damage",
			},
		}
	},

	PoseidonExCastBoon =
	{
		Icon = "Boon_Poseidon_46",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 200/150,
			},
			Epic =
			{
				Multiplier = 250/150,
			},
			Heroic =
			{
				Multiplier = 300/150,
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
				OnHitFunctionNames = { },
				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					},

					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
						BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					},
				},
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperty = "FireFx2",
				ChangeValue = "OlympianAttackFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "ArmedExpirationDamage",
				BaseValue = 150,
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = { ReportedDamage = "ChangeValue" },
				AbsoluteStackValues =
				{
					[1] = 50,
					[2] = 30,
					[3] = 20,
				},
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "ArmedDeathFx",
				ChangeValue = "PoseidonCastBoonFx",
			}
		},
		OnProjectileArmFunction = 
		{
			FunctionName = "ProjectileExCastPreview",
			FunctionArgs = 
			{
				Animation = "PoseidonCastBallIn",
			}
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckArmedPoseidonCast",
			Args = 
			{
				ValidProjectileName = "ProjectileCast",
				ProjectileName = "PoseidonCastImpulse",
			}
		},
		StatLines =
		{
			"OmegaCastDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				IncludeSigns = true,
			},
		}
	},

	OmegaPoseidonProjectileBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_38",
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
			WeaponNames = ConcatTableValues(WeaponSets.HeroAllWeaponsAndSprint, {"WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" }),
			ExWeapons = true,
			ManaCostAdd = 5,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		OnWeaponFiredFunctions =
		{
			WeaponNames = ConcatTableValues(WeaponSets.HeroAllWeaponsAndSprint, {"WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" }),	
			FunctionName = "CheckPoseidonExProjectileOnSpawn",
			FunctionArgs = 
			{
				ProjectileName = "PoseidonOmegaWave",
				DamageMultiplier = 
				{
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 0.50,
						[2] = 0.25,
					},
				},
				Spacing = 200,
				Cooldown = 0.75,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
			}
		},
		StatLines = 
		{
			"PoseidonOmegaProjectileDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonOmegaWave",
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

	PoseidonSprintBoon =
	{
		Icon = "Boon_Poseidon_28",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Rush",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 80/80,
			},
			Rare =
			{
				Multiplier = 100/80,
			},
			Epic =
			{
				Multiplier = 120/80,
			},
			Heroic =
			{
				Multiplier = 140/80,
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSprint"},
			FunctionName = "PoseidonSprintSplash",
			FunctionArgs = 
			{
				ProjectileName = "PoseidonSprintBlast",
				SprintSound = "/SFX/Player Sounds/PoseidonWaterWrathAttackLoop",
				Cooldown = 0.05,
				ManaCost = 5,
				FizzleOldestProjectileCount = 5,
				DamageMultiplier = 
				{
					BaseValue = 1,
					DecimalPlaces = 3,
					AbsoluteStackValues = 
					{
						[1] = 20/80,
						[2] = 10/80,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCost = "ManaCost",
				},
			},
		},
		OnEnemyDamagedAction = 
		{
			FirstHitOnly = true,
			ValidProjectiles = {"PoseidonSprintBlast" },
			FunctionName = "PoseidonSprintSpend",
			Args = 
			{
				BarrelLength = 100,
				ProjectileName = "PoseidonSprintSecondaryBlast",
				DamageMultiplier = 
				{
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 0.185,
						[2] = 0.09,
						--[3] = 0.41,
					},
				},
			},
		},
		
		OnSprintEndAction = 
		{
			FunctionName = "ResetPoseidonSprint",
		},
		StatLines =
		{
			"ImpactDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonSprintBlast",
				BaseProperty = "Damage",
			},
			{
				SkipAutoExtract = true,
				Key = "ReportedCost",
				ExtractAs = "ManaCost",
			},
		}
	},

	PoseidonManaBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_31",
		Slot = "Mana",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 5/4,
			},
			Epic =
			{
				Multiplier = 6/4,
			},
			Heroic =
			{
				Multiplier = 7/4,
			},
		},
		IntermittentClearCast = true,
		OnManaSpendAction = 
		{
			FunctionName = "CheckClearCastManaRefund",
			FunctionArgs = 
			{
				AnimationName = "ManaRegenFlashFx",
				Duration = 1,
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeaponsAndSprint,
			FunctionName = "CheckClearCastStart",
			FunctionArgs = 
			{
				
				EffectName = "ClearCastPoseidon",
				Duration =
				{
					BaseValue = 4,
					AbsoluteStackValues = 
					{
						[1] = 1.0,
						[2] = 0.5,
					},
				},
				ReportValues =
				{
					ReportedDuration = "Duration",
				}
			}
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "PoseidonIntermittentClearCast",
			Args = 
			{	
				Interval = 8,
				ReportValues = {
					ReportedInterval = "Interval",
				}
			},
		},
		StatLines =
		{
			"ManaIntervalStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				SkipAutoExtract = true,
				Format = "SpeedModifiedDuration",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "ExDamageMultiplier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				Format = "PercentDelta",
				BaseName = "ClearCastPoseidon",
				BaseProperty = "Amount",
				DecimalPlaces = 1,
			},
		},
		Using =
		{
			"CirceCrystalRotateFront1", "CirceCrystalRotateFront2", "CirceCrystalRotateFront3", "CirceCrystalRotateFront4", "CirceCrystalRotateFront5",
			"CirceCrystalRotateBack1", "CirceCrystalRotateBack2", "CirceCrystalRotateBack3", "CirceCrystalRotateBack4", "CirceCrystalRotateBack5",
		},
	},

	EncounterStartOffenseBuffBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_39",
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
		EncounterStartEffect = 
		{
			Name = "EncounterStartOffense",
		},		
		AddOutgoingDamageModifiers =
		{
			RequiredSelfEffectsMultiplier =
			{
				BaseValue = 2.0,
				SourceIsMultiplier = true,
				AbsoluteStackValues = 
				{
					[1] = 1.25,
					[2] = 1.20,
					[3] = 1.15,
				}, 
			},
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			RequiredEffects = { "EncounterStartOffense" },
			ReportValues = { ReportedMultiplier = "RequiredSelfEffectsMultiplier"},
		},
		StatLines =
		{
			"EncounterStartDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "EncounterStartOffense",
				BaseProperty = "Duration",
			},
		}
	},

	RoomRewardBonusBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_36",
		BlockStacking = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom" },
				HasNone = { "BlockGiftBoons" },
			},
		},
		BlockOfferIfPreviouslyPicked = true,
		-- DescriptionTextSymbolScale = 0.70,
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
		AcquireFunctionName = "GiveRandomConsumables",
		AcquireFunctionArgs =
		{ 
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = true,
			RunProgressUpgradeEligible = true,
			MultiplyMoney = true,
			KeepCollision = true,
			GlobalVoiceLines = "PoseidonRoomRewardBonusReactionLines",
			ReportValues = {ReportedMinMoney = "ExtractAmount"},
			LootOptions =
			{
				{
					Name = "RoomMoneySmallDrop",
				},
				{
					Name = "RoomMoneyTinyDrop",
					MinAmount = 2,
					MaxAmount = 2,
				},
				{
					Name = "HealDropMinor",
					MinAmount = 2,
					MaxAmount = 2,
				},
				{
					Name = "MetaCurrencyDrop",
					Chance = 1,
					Overrides = 
					{
						MetaConversionEligible = false,
					},
					GameStateRequirements = 
					{
						{ 
							Path = { "CurrentRun", "CurrentRoom", "ForcedReward", "Name"},
							IsNone = { "Story" }
						}
					},
				},
			}
		},
		MoneyRewardBonus =
		{
			BaseValue = 1.5,
			SourceIsMultiplier = true,
			MinMultiplier = 0.02,
			IdenticalMultiplier =
			{
				Value = -0.9,
			},
		},
		RoomRewardBonus = 
		{
			MetaCardPointsCommon =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				IdenticalMultiplier =
				{
					Value = -0.9,
				},
			},
			MemPointsCommon =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				IdenticalMultiplier =
				{
					Value = -0.9,
				},
			},
			MetaCurrency =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				IdenticalMultiplier =
				{
					Value = -0.9,
				},
			},
		},
		StatLines =
		{
			"RoomRewardStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "MoneyRewardBonus",
				ExtractAs = "TooltipPercentIncrease",
				Format = "PercentDelta",
			}
		}
	},

	FocusDamageShaveBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_32",
		
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
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				RunOnce = true,
				Name = "DamageShave",
				ManaReservationCost = 30,
				ReportValues = 
				{ 
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		OnExpire = 
		{
			FunctionName = "TraitUnreserveMana",
			FunctionArgs = { Name = "DamageShave" },
		},
		OnAttackWindUpAction =
		{
			FunctionName = "PoseidonAttackPunish",
			Args = 
			{
				ProjectileName = "PoseidonSplashSplinter",
				DamageMultiplier = 
				{ 
					BaseValue = 2,
					AbsoluteStackValues = 
					{
						[1] = 0.50,
					}, 
				},
				ProximityThreshold = 430,
				Force = 900,
				Scale = 1.0,
				ProximityThresholdExclusionBoon = "AllCloseBoon",
				ReportValues = { ReportedMultiplier = "DamageMultiplier"}
			}
		},
		StatLines = 
		{
			"SplashDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonSplashSplinter",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},

	DoubleRewardBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_33",
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
			},
		},

		SpeakerNames = { "Poseidon" },

		DoubleRewardChance = 
		{
			BaseValue = 0.25,
			MinValue = 0.05, 
			AbsoluteStackValues =
			{
				[1] = 0.05,
			},
		},
		StatLines =
		{
			"RewardChanceStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "DoubleRewardChance",
				ExtractAs = "RewardChance",
				Format = "LuckModifiedPercent",
				HideSigns = true,
			},
		}
	},

	PoseidonStatusBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_37",
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
	
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = 
			{
				"PoseidonSplashSplinter",
				"PoseidonCastSplashSplinter",
				"PoseidonSplashBackSplinter",
			},
			EffectName = "AmplifyKnockbackEffect",
		},
		PoseidonFontMultiplier = 
		{ 
			BaseValue = 1.2, 
			AbsoluteStackValues = 
			{
				[1] = 0.2,
				[2] = 0.1,
			}
		},
		StatLines =
		{
			"PoseidonStatusStatDisplay",
		},
		ExtractValues =
		{
			{
				ExtractAs = "KnockbackAmplifyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Duration",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "FontChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Chance",
				Format = "LuckModifiedPercent"
			},
			{
				Key = "PoseidonFontMultiplier",
				ExtractAs = "FontAmp",
				Format = "PercentDelta",
			},
			{
				Key = "PoseidonFontMultiplier",
				ExtractAs = "FontDamage",
				BaseType = "Projectile",
				BaseName = "PoseidonEffectFont",
				Format = "MultiplyByBase",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
		}
	},

	AmplifyConeBoon = -- Legendary
	{
		Icon = "Boon_Poseidon_40",
		InheritFrom = { "LegendaryTrait", "WaterBoon" },
		ConeModifier = 
		{
			ScaleIncrease = 1.35,
			MaxScale = 1.70,			--Search for DefaultKnockbackScale to see normal scales
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = 
			{
				"PoseidonSplashSplinter",
				"PoseidonCastSplashSplinter",
				"PoseidonSplashBackSplinter",
			},
			BossDamageMultiplier = 3.0,
			ReportValues = { ReportedWeaponMultiplier = "BossDamageMultiplier"},
		},
		StatLines =
		{
			"BossDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
		},
		FlavorText = "AmplifyConeBoon_FlavorText",
	},
})