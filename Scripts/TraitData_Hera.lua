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
				MinMultiplier = 0.125,
				IdenticalMultiplier =
				{
					Value = -0.75,
					DiminishingReturnsMultiplier = 0.5,
				},
			},
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
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
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponDagger",
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
				ProjectilName = "ProjectileDaggerDash",
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
				WeaponName = "WeaponAxe",
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
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponAxeDash",
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
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Hera",
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
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hera",
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
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
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
				MinMultiplier = 0.17,
				IdenticalMultiplier =
				{
					Value = -0.67,
					DiminishingReturnsMultiplier = 0.5,
				},
			},
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
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
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Hera",
				ChangeType = "Absolute",
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
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Hera",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hera",
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
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hera",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hera",
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
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Hera",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Hera",
				ChangeType = "Absolute",
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
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Slot = "Ranged",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.425,
			},
			Epic =
			{
				Multiplier = 1.850,
			},
			Heroic =
			{
				Multiplier = 2.075,
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
						[1] = 0.4250,
						[2] = 0.2125,
						[3] = 0.1423,
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
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "FuseStart",
				ChangeValue = 3,
				ChangeType = "Multiply",
				ReportValues = { DurationIncrease = "ChangeValue", SourceIsMultiplier = true },
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
				Key = "DurationIncrease",
				ExtractAs = "DurationIncrease",
				Format = "PercentDelta",
				SkipAutoExtract = true,
			},
		}
	},
	HeraSprintBoon = 
	{
		Icon = "Boon_Hera_28",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Slot = "Rush",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
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
				Radius = 200,
				Range = 600,
				StartDelay = 0.2,
				Cooldown = 0.2,
				Vfx = "HeraSprintPullFx",
				EffectName = "DamageShareEffect",
				NumJumps = 
				{
					BaseValue = 1,
					MinValue = 1,
					AsInt = true,
					IdenticalMultiplier =
					{
						Value = 0,
					},					
				},
				ReportValues = 
				{
					ReportedJumps = "NumJumps",
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
			"DamageShareJumpMaxStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedJumps",
				ExtractAs = "Jumps",
				IncludeSigns = true,
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
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Slot = "Mana",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 0.8,
			},
			Epic =
			{
				Multiplier = 0.6,
			},
			Heroic =
			{
				Multiplier = 0.4,
			},
		},

		LastMomentManaRechargeArgs = 
		{
			Amount =
			{
				BaseValue = 10,
				AsInt = true,
				MinMultiplier = -1,
				IdenticalMultiplier =
				{
					Value = -7/6,
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
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hera_39",
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
		InheritFrom = { "BaseTrait", "EarthBoon" },
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
		OnSelfDamagedFunction = 
		{
			Name = "HeraRetaliate",
			FunctionArgs = 
			{
				ProjectileName = "HeraDamageShareProjectile",
				Cooldown = 0.5,
				Multiplier =
				{
					BaseValue = 5,
					AbsoluteStackValues =
					{
						[1] = 1.50,
						[2] = 1.25,
						[3] = 1.20,
						[4] = 1.10,
						[5] = 1.05,
					},
				},
				ReportValues = { ReportedMultiplier = "Multiplier"},
			}
		},
		StatLines =
		{
			"RetaliateMultiplierStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "ReflectDamage",
				Format = "Percent",
				HideSigns = true,
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
	SwapBonusBoon = 
	{
		Icon = "Boon_Hera_37",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Uses = 1,
		ForceSwaps = true,		
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
			},
		},			
		ExchangeLevelBonus = 
		{
			BaseValue = 2,
			AsInt = true,	
		},
		StatLines = 
		{
			"BonusLevelStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ExchangeLevelBonus",
				ExtractAs = "Levels",
			},
		}
	},
	BoonDecayBoon =
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hera_36",
		BlockInRunRarify = true,
		RequiredUpgradeableGodTraits = 2,
		ExcludeTraitFromLastRunBoonPool = true,
		BlockStacking = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
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
		AcquireFunctionName = "HeroicDowngradeBoons",
		AcquireFunctionArgs = 
		{
			Name = "BoonGrowthBoon",
			NumTraits = 2,
			ReportValues = { ReportedNumTraits = "NumTraits" }
		},
		RoomsPerUpgrade = 
		{ 
			Amount = { BaseValue = 5 },
			DowngradeRarity = true,
			ReportValues = 
			{ 
				ReportedRoomsPerUpgrade = "Amount" 
			},
		},
		CurrentRoom = 0,
		StatLines =
		{
			"GodBoonsAffectedStatDisplay1",
		},
		TrayStatLines = 
		{
			"GodBoonsAffectedTrayStatDisplay1"
		},
		ExtractValues =
		{
			{
				Key = "ReportedNumTraits",
				ExtractAs = "TooltipTraitNum",
			},
			{
				Key = "ReportedRoomsPerUpgrade",
				ExtractAs = "TooltipRoomInterval",
			}
		},
	},
	DamageSharePotencyBoon = 
	{
		Icon = "Boon_Hera_38",
		InheritFrom = { "BaseTrait", "EarthBoon" },
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
	LinkedDeathDamageBoon = 
	{
		Icon = "Boon_Hera_35",
		InheritFrom = { "BaseTrait", "EarthBoon" }, 
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
			Name = "CheckLinkDeath",
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
	FullManaExBoostBoon = 
	{
		Icon = "Boon_Hera_31",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		TraitTextManaValue = 100, -- added for text extraction
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
			FullManaVolleyMultiplier =
			{
				BaseValue = 1.3,
				SourceIsMultiplier = true,
				IdenticalMultiplier =
				{
					Value = -0.5,
				},
			},
			ReportValues = { ReportedWeaponMultiplier = "FullManaVolleyMultiplier"},
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveWeaponFullManaFire",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckWeaponFullManaFire",
		},
		StatLines =
		{
			"BonusOmegaDamageDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "Amount",
					Format = "PercentDelta"
			},
		}
	},
	HeraManaShieldBoon = -- Legendary
	{
		Icon = "Boon_Hera_40",
		InheritFrom = { "LegendaryTrait", "EarthBoon" }, 
		RequiredFalseTraits = { "HephaestusManaBoon" },

		ManaShieldData = 
		{
			DamageBlocked = 0.5,					 --Percent of damage that is redirected
			ManaPerDamageBlocked =	5,			-- Amount of mana burned per damage blocked
			ReportValues = 
			{ 
				ReportedDamageBlocked = "DamageBlocked",
				ReportedManaConversion = "ManaPerDamageBlocked",
			}
		},
		
		StatLines =
		{
			"ManaShieldStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaConversion",
				ExtractAs = "TooltipManaConversion",
			},
			{
				Key = "ReportedDamageBlocked",
				ExtractAs = "TooltipDamageBlocked",
				Format = "Percent",
				SkipAutoExtract = true,
			},
		}
	},
})