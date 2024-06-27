OverwriteTableKeys( TraitData, {
	-- Aphrodite
	AphroditeWeaponBoon =
	{
		Icon = "Boon_Aphrodite_27",
		InheritFrom = { "BaseTrait", "WaterBoon"},
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
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ProximityThreshold = 430,
			ProximityThresholdExclusionBoon = "AllCloseBoon",
			ProximityMultiplier = 
			{ 
				BaseValue = 1.8,
				SourceIsMultiplier = true,

				AbsoluteStackValues =
				{
					[1] = 1.25,
					[2] = 1.15,
					[3] = 1.10,
				},
			},
			ReportValues = 
			{ 
				ReportedWeaponMultiplier = "ProximityMultiplier",
			},
		},
		StatLines =
		{
			"NearbyDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "PercentDelta",
			},
		},
		PropertyChanges = {

			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Aphrodite",
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
				ChangeValue = "StaffComboAttack3Dissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				ProjectileName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Aphrodite",
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
				ChangeValue = "DaggerCharge_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

		},
	},
	AphroditeSpecialBoon =
	{
		Icon = "Boon_Aphrodite_30",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Slot = "Secondary",
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
				Multiplier = 2.00,
			},
			Heroic =
			{
				Multiplier = 2.5,
			}
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ProximityThreshold = 430,
			ProximityThresholdExclusionBoon = "AllCloseBoon",
			ProximityMultiplier = 
			{ 
				BaseValue = 2.0,
				SourceIsMultiplier = true,
				AbsoluteStackValues = 
				{
					[1] = 1.5,
					[2] = 1.3,
					[3] = 1.2,
					[4] = 1.1,
				},
			},
			ReportValues = 
			{ 
				ReportedWeaponMultiplier = "ProximityMultiplier",
			}
		},
		StatLines =
		{
			"NearbyDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "PercentDelta",
			},
		},
		PropertyChanges = {

			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "AphroditeStaffProjectileShadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "StaffBallProjectileCharged_Aphrodite_Shadow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Aphrodite",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Aphrodite",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Aphrodite",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Aphrodite",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Aphrodite",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Aphrodite",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Aphrodite",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Aphrodite",
				ChangeType = "Absolute",
			},

		},
	},
	AphroditeCastBoon =
	{
		Icon = "Boon_Aphrodite_29",
		InheritFrom = { "BaseTrait", "AirBoon" },
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
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = { "WeaponCast" },
			FunctionName = "CheckProjectilePull",
			FunctionArgs = 
			{
				DeadZoneRadius = 100,
				DistanceMultiplier = 0.45,
				Interval = 0.85,
				PullVfx = "AphroditeCastPull",
				ProjectileName = "AphroditeCastProjectile",
				DamageMultiplier = { BaseValue = 1 },
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckCastAphroditeVulnerabilityApply",
			FunctionArgs = 
			{
				EffectName = "WeakEffect",
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperty = "FireFx",
				ChangeValue = "QuickFlashPink",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Graphic = "CastCircleInAphrodite",
				}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileName = "ProjectileCast",
				ProjectileProperties = 
				{
					DetonateFx = "CastCircleOutAphrodite",
				}
			},		},
		StatLines =
		{
			"AphroCastDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AphroditeCastProjectile",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
		}
	},
	AphroditeSprintBoon =
	{
		Icon = "Boon_Aphrodite_28",
		InheritFrom = { "BaseTrait", "LegacyTrait", "AirBoon" },
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
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"AphroditeRushProjectile"},
			FunctionName = "ApplyAphroditeVulnerability",
			Args = 
			{
				EffectName = "WeakEffect",
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponBlink" },
			ExcludeLinked = true,
			FunctionName = "FireAphroditeSprintProjectile",
			FunctionArgs = 
			{
				ProjectileName = "AphroditeRushProjectile",
				DamageMultiplier = 
				{ 
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 0.50,
						[2] = 0.25,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
			},
		},
		OnSprintEndAction = 
		{
			FunctionName = "FireAphroditeSprintProjectile",
		},
		OnBlinkEndAction = 
		{
			FunctionName = "FireAphroditeSprintProjectile",
			FunctionArgs = { CheckSprint = true },
		},
		StatLines =
		{
			"BlastDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AphroditeRushProjectile",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
		}
	},
	AphroditeManaBoon = 
	{
		Icon = "Boon_Aphrodite_40",
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
		SetupFunction =
		{
			Threaded = true,
			Name = "WeakCrowdMana",
			Args =
			{
				ManaRegen = { 
					BaseValue = 6,
					MinValue = 0.166,
					IdenticalMultiplier =
					{
						Value = -0.67,
					},
				},
				ManaRegenStartFx = "ManaRegenFlashFx",
				ActiveFx = "ManaRegenLoopingNoSound",
				Range = 430, -- should match AprhoditeWeapon definition of "close"
				ProximityThresholdExclusionBoon = "AllCloseBoon",
				Minimum = 1,
				ReportValues = {ReportedRegen = "ManaRegen"},
				EffectName = "WeakEffect",
			},
		},
		StatLines =
		{
			"ManaRegenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedRegen",
				ExtractAs = "TooltipRegen",
			},
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
		}
	},

	HighHealthOffenseBoon = 
	{
		Icon = "Boon_Aphrodite_38",
		InheritFrom = { "BaseTrait", "AirBoon" },
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
		PriorityDisplay = true,
		ShowHighHealthIndicator = true,
		HighHealthThresholdText =
		{
			-- Display variable only, to change the data value change the value below under "HighHealthSourceMultiplierData"
			PercentThreshold = 0.8,
			--Text = "Hint_HighHealthDamageTraitDeactivated",
		},
		AddOutgoingDamageModifiers =
		{
			HighHealthSourceMultiplierData = 
			{ 
				Threshold = 0.8,
				ThresholdMultiplier = 2, --to double bonus when above threshold
				Multiplier = 
				{ 
					BaseValue = 1.1, 
					SourceIsMultiplier = true,
					MinMultiplier = 0.1,
					IdenticalMultiplier =
					{
						Value = -0.5,
						DiminishingReturnsMultiplier = 0.8,
					}, 
				},
				ReportValues = 
				{ 
					ReportedThreshold = "Threshold",
					ReportedMultiplier = "Multiplier",
				}
			},
		},
		StatLines =
		{
			"BonusDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "Threshold",
				SkipAutoExtract = true,
				Format = "Percent",
			},
		}
	},
	HealthRewardBonusBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "AirBoon" },
		Icon = "Boon_Aphrodite_35",
		BlockStacking = true,
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
		StatLines = 
		{
			"BonusMaxLifeStatDisplay1",
		},
		AcquireFunctionName = "MultiplySameRoomRewards",
		AcquireFunctionArgs = 
		{
			Name = "MaxHealthDrop"
		},
		HealthRewardBonus =
		{
			BaseValue = 1.4,
			SourceIsMultiplier = true,
			MinMultiplier = 0.1,
			IdenticalMultiplier =
			{
				Value = -0.75,
			},
		},
		ExtractValues =
		{
			{
				Key = "HealthRewardBonus",
				ExtractAs = "TooltipPercentIncrease",
				Format = "PercentDelta",
			}
		}
	},
	DoorHealToFullBoon =
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Aphrodite_34",
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
		DoorFullHealThreshold = 
		{
			HealValue = 100, -- used for description
			BaseValue = 0.8,
			SourceIsMultiplier = true,
			MinValue = 0.01,
			IdenticalMultiplier =
			{
				Value = -0.5,
			},
		},
		StatLines = 
		{
		"HealthThresholdStatDisplay1",
		},
		ExtractValues =
		{
			{
				HideSigns = true,
				Key = "DoorFullHealThreshold",
				ExtractAs = "TooltipThreshold",
				Format = "Percent",
			}
		}
	},
	WeakPotencyBoon = 
	{
		Icon = "Boon_Aphrodite_36",
		InheritFrom = { "BaseTrait", "LegacyTrait", "WaterBoon" },
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
		EffectModifier = 
		{
			AmountAddition =
			{ 
				BaseValue = 0.1,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.8,
				},
			},
			ValidActiveEffectGenus = "Weak",
			ReportValues = { ReportedModifierAddition = "AmountAddition"}
		},
		StatLines =
		{
			"WeakPotencyStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedModifierAddition",
				ExtractAs = "Modifier",
				Format = "Percent",
			},
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
		}
	},
	WeakVulnerabilityBoon = 
	{
	
		Icon = "Boon_Aphrodite_39",
		InheritFrom = { "BaseTrait", "LegacyTrait", "WaterBoon" },
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
		StatLines =
		{
			"WeakDamageTakenStatDisplay1",
		},
		AddOutgoingDamageModifiers = 
		{
			ValidActiveEffectGenus = "Weak",
			ValidWeaponMultiplier = 
			{ 
				BaseValue = 1.1, 
				SourceIsMultiplier = true, 
				MinMultiplier = 0.1,
				IdenticalMultiplier = 
				{ 
					Value = -0.5, 
				},
			},
			ReportValues = { ReportedModifier = "ValidWeaponMultiplier"}
		},
		ExtractValues =
		{
			{
					Key = "ReportedModifier",
					ExtractAs = "Modifier",
					Format = "PercentDelta",
			},
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
		}
	},
	ManaBurstBoon = 
	{
		Icon = "Boon_Aphrodite_37",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
	
		OnManaSpendAction = 
		{
			FunctionName = "CheckManaBurst",
			FunctionArgs = 
			{
				ManaCost = 30,
				ProjectileName = "AphroditeBurst",
				DamageMultiplier = 
				{
					BaseValue = 1,
					MinMultiplier = 0.1,
					IdenticalMultiplier = 
					{ 
						Value = -0.5, 
						DiminishingReturnsMultiplier = 0.8,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedMana = "ManaCost",
				}
			}
		},
		StatLines =
		{
			"ManaBurstDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AphroditeBurst",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "AphroditeBurst",
				BaseProperty = "Fuse",
			},
			{
				Key = "ReportedMana",
				ExtractAs = "Mana",
				SkipAutoExtract = true
			},
		}
	},
	FocusRawDamageBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Aphrodite_32",
		BlockStacking = true,
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 7/5,
			},
			Epic =
			{
				Multiplier = 9/5,
			},
			Heroic =
			{
				Multiplier = 11/5,
			},
		},
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusRawDamageBoon",
				ManaReservationCost = 20,
				ReportValues = 
				{ 
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			NonExBaseDamageAddition = { BaseValue = 5 },
			ReportValues = 
			{ 
				ReportedDamage = "NonExBaseDamageAddition"
			},
		},
		StatLines =
		{
			"AdditiveDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "BonusDamage",
				IncludeSigns = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},
	RandomStatusBoon = -- Legendary
	{
		Icon = "Boon_Aphrodite_31",
		InheritFrom = { "LegendaryTrait", "AirBoon" },
		
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckRandomStatusCurse",
			FunctionArgs = 
			{
				Count = 3,
				Effects = 
				{
					AmplifyKnockbackEffect = 
					{
						CopyValuesFromTraits = 
						{
							Modifier = {"PoseidonStatusBoon" }
						}
					},
					BlindEffect = {},
					DamageEchoEffect = 
					{ 
						ExtendDuration = "EchoDurationIncrease", 
						DefaultModifier = 1,
						CopyValuesFromTraits = 
						{
							Modifier = {"ZeusWeaponBoon", "ZeusSpecialBoon"}
						}
					},
					
					DelayedKnockbackEffect = 
					{
						CopyValuesFromTraits = 
						{
							TriggerDamage = { "MassiveKnockupBoon" }
						}
					},
					ChillEffect = { CustomFunction = "ApplyRoot"},
					DamageShareEffect = { CustomFunction = "ApplyDamageShare" },
					
					BurnEffect = 
					{ 
						CustomFunction = "ApplyBurn", 
						DefaultNumStacks = 30,
						CopyNumStacksFromTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon" },
					},
				},
				ReportValues = { ReportedCount = "Count" }
			},
		},
		StatLines =
		{
			"RandomStatusStatDisplay1",
		},
		ExtractValues =
		{
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
			{
				ExtractAs = "Count",
				Key = "ReportedCount",
				SkipAutoExtract = true,
			}
		}
	},
})