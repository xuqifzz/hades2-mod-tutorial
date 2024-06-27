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
				Multiplier = 1.34,
			},
			Epic =
			{
				Multiplier = 1.67,
			},
			Heroic =
			{
				Multiplier = 2.00,
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckPoseidonSplash",
			Args = 
			{
				ProjectileName = "PoseidonSplashSplinter",
				ExcludeLinked = true,
				MultihitWeaponWhitelist = 
				{
					"WeaponStaffSwing5",

					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxeSpin",

					"WeaponTorch",

					"WeaponLob",
					"WeaponLobChargedPulse",

				},
				MultihitWeaponConditions = 
				{
					WeaponStaffSwing5 = { Cooldown = 0.02 },
					
					WeaponAxe = { Cooldown = 0.04 },
					WeaponAxe2 = { Cooldown = 0.04 },
					WeaponAxe3 = { Cooldown = 0.02 },
					WeaponAxeSpin = { Cooldown = 0.05 },

					WeaponTorch = { Cooldown = 0.3 },

					WeaponLob = { Cooldown = 0.05 },
					WeaponLobChargedPulse = { Cooldown = 0.05 },
				},
				DamageMultiplier = 
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 0.334,
						--[2] = 0.170,
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
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger",
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
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
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
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Poseidon",
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
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Poseidon",
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
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			FunctionName = "CheckPoseidonSplash",
			Args = 
			{
				ProjectileName = "PoseidonSplashSplinter",
				MultihitWeaponWhitelist = 
				{
					"WeaponAxeSpecialSwing",

					"WeaponTorchSpecial",
					"WeaponLobSpecial"
				},
				MultihitWeaponConditions = 
				{
					WeaponAxeSpecialSwing = { Cooldown = 0.02 },
					WeaponTorchSpecial = { Cooldown = 0.3 },
					WeaponLobSpecial = { Cooldown = 0.1 },
				},
				DamageMultiplier = 
				{
					BaseValue = 1.34,
					MinMultiplier = 3/15,
					IdenticalMultiplier =
					{
						Value = -0.5,
						DiminishingReturnsMultiplier = 0.80,
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
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Poseidon",
				ChangeType = "Absolute",
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
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Poseidon",
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
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Poseidon",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Poseidon",
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
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Poseidon",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Poseidon",
				ChangeType = "Absolute",
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
					MinMultiplier = 3/15,
					IdenticalMultiplier =
					{
						Value = -0.5,
						DiminishingReturnsMultiplier = 0.80,
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
		}
	},
	PoseidonExCastBoon =
	{
		Icon = "Boon_Poseidon_29",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		RequiredFalseTraits = { "ZeusExCastBoon", "ApolloExCastBoon" },		
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
				ProjectileProperties = 
				{
					ArmedExpirationDamage = 0,
					DetonateWhenArmed = true,
				}
			},
			{
				WeaponName = "WeaponCast",
				WeaponProperty = "FireFx2",
				ChangeValue = "OlympianAttackFx_Poseidon",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

		},
		
		OnProjectileArmFunction =
		{
			FunctionName = "OnPoseidonCastArmed",
			FunctionArgs = 
			{
				ProjectileName = "PoseidonCast",
				
				DamageMultiplier = 
				{ 
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 0.20,
						[2] = 0.15,
						[3] = 0.10,
					},
				},
				
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		StatLines =
		{
			"OmegaCastDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonCast",
				BaseProperty = "Damage",
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
				Multiplier = 1.00,
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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckExProjectileOnHit",
			Args = 
			{
				ProjectileName = "PoseidonOmegaProjectile",
				DamageMultiplier = 
				{
					BaseValue = 1,
					AbsoluteStackValues = 
					{
						[1] = 0.20,
						[2] = 0.10,
					},
				},
				Cooldown = 0.75,
				ProjectileCap = 1,
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
				BaseName = "PoseidonOmegaProjectile",
				BaseProperty = "Damage",
			},
		}
	},
	PoseidonSprintBoon =
	{
		Icon = "Boon_Poseidon_28",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Rush",
		PreEquipWeapons = {"PoseidonSprintWeapon"},
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
					IdenticalMultiplier =
					{
						Value = -0.5,
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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FunctionName = "CheckPoseidonManaDrop",
			Args = 
			{
				Chance = 
				{ 
					BaseValue = 0.10, 
					AbsoluteStackValues =
					{
						[1] = 0.02,
						[2] = 0.01,
					},
				},
				Duration = 30,
				UpwardForceMin = 600,
				UpwardForceMax = 800,
				ForceMin = 600,
				ForceMax = 850,
				Sound = "/Leftovers/Menu Sounds/CoinFlash",
				Name = "ManaDropMinorPoseidon",
				ExpireFx = "PoseidonManaDropletDissipate",
				ReportValues = { ReportedDropChance = "Chance", ReportedDuration = "Duration" }
			},
		},
		StatLines =
		{
			"ManaRegenStatDisplay3",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDropChance",
				ExtractAs = "TooltipManaRecovery",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				DecimalPlaces = 1,
				SkipAutoExtract = true
			},
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "ManaDropMinorPoseidon",
				BaseProperty = "AddMana",
				ExtractAs = "ManaDropRecovery",
				SkipAutoExtract = true,
			}
		}
	},

	EncounterStartOffenseBuffBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "WaterBoon" },
		Icon = "Boon_Poseidon_39",
		EncounterStartWeapon = "EncounterStartBuffWeapon",
		PreEquipWeapons = { "EncounterStartBuffWeapon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.33,
			},
			Epic =
			{
				Multiplier = 1.66,
			},
			Heroic =
			{
				Multiplier = 2.0,
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
				IdenticalMultiplier =
				{
					Value = -0.77,
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
			ReportValues = {ReportedMinMoney = "ExtractAmount"},
			LootOptions =
			{
				{
					Name = "Currency",
					MinAmount = 90,
					MaxAmount = 90,
				},
				{
					Name = "HealDropMinor",
					MinAmount = 2,
					MaxAmount = 2,
				},
				{
					Name = "MemPointsCommonDrop",
					Chance = 0.5,
					GameStateRequirements = 
					{
						{ 
							Path = { "CurrentRun", "CurrentRoom", "ForcedReward", "Name"},
							IsNone = { "Story" }
						}
					},
				},
				{
					Name = "MetaCardPointsCommonDrop",
					Chance = 0.5,
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
		BlockStacking = true,
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
		DamageShave = {
			BaseValue = 2, 
			MinValue = 1, 
			AsInt = true, 
			IdenticalMultiplier =
			{
				Value = DuplicateWeakMultiplier,
			},
		},
		StatLines =
		{
			"DamageShaveStatDisplay1",
		},
		ExtractValues = {
			{
				Key = "DamageShave",
				ExtractAs = "Damage",
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},
	SlamExplosionBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "WaterBoon" },
		God = "Poseidon",
		Icon = "Boon_Poseidon_38",
		OnEnemySlamProjectile = 
		{
			Cooldown = 0.65,
			ProjectileName = "PoseidonCollisionBlast",
			Force = 3000,
			DamageMultiplier =
			{
				BaseValue = 1.0,
				IdenticalMultiplier =
				{
					Value = -0.5,
				},
			},
			ReportValues = { ReportedMultiplier = "DamageMultiplier"},
		},	
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PoseidonCollisionBlast",
				BaseProperty = "Damage",
				ExtractAs = "Damage",
			},
		},
		StatLines =
		{
			"SlamExplosionDamageStatDisplay1",
		},
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

		DoubleRewardChance = 
		{
			BaseValue = 0.20,
			MinValue = 0.01, 
			IdenticalMultiplier =
			{
				Value = -0.75,
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
				Format = "Percent",
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
				Multiplier = 2.0,
			},
			Epic =
			{
				Multiplier = 3.0,
			},
			Heroic =
			{
				Multiplier = 4.0,
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
			Args = 
			{
				Modifier = { 
					BaseValue = 1.05, 
					SourceIsMultiplier = true,
					IdenticalMultiplier = 
					{
						Value = -0.2,
					}, 
				},
				ReportValues = { ReportedIncrease = "Modifier" }
			}
		},
		StatLines =
		{
			"PoseidonStatusStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedIncrease",
				ExtractAs = "TooltipVulnerability",
				Format = "PercentDelta",
				DecimalPlaces = 1,
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
		}
	},
})