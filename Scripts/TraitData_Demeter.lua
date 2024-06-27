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
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
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
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponDagger",
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
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponAxeDash",
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
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Demeter",
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
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Demeter",
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
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Demeter",
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
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Demeter",
				ChangeType = "Absolute",
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
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Demeter",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Demeter",
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
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Demeter",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Demeter",
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
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Demeter",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Demeter",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Demeter",
				ChangeType = "Absolute",
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
		--[[
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			Value = 1.4,
			ReportValues = { ReportedSlowMultiplier = "Value"},
		},
		]]
		StatLines =
		{
			"SpecialDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedSlowMultiplier",
					ExtractAs = "TooltipSpeedSlow",
					Format = "PercentDelta",
					SkipAutoExtract = true,
			},
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
			ValidWeapons = WeaponSets.HeroRangedWeapons,
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
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Range = 600,
					DetonateFx = "DemeterIceRain",
					Graphic = "CastCircleInDemeter",
					ImpactFx = "DemeterSlowImpact",
					HideGraphicOnDetonate = false,
					FuseStart = 0,
					MultiDetonate = true,
					MaxDetonations = 6,
					ArmedImpactFx = "null",
					DeathFx = "CastCircleOut",
					ArmedDeathFx = "CastCircleOut"
				}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Damage",
				BaseValue = 10,
				ReportValues = {ReportedDamage = "ChangeValue"},
				AbsoluteStackValues =
				{
					[1] = 5,
					[2] = 3,
					[3] = 2,
				},
				AsInt = true
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.5,
				ReportValues = {ReportedFuse = "ChangeValue"}
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
				Key = "ReportedDamage",
				ExtractAs = "Damage",
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
		}
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
				ProjectileNames = {"DemeterSprintStorm","DemeterSprintDefense"},
				MaxProjectiles = 1,
				StartDelay = 0.12,
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
					BaseValue = 0.4,
					AbsoluteStackValues =
					{
						[1] = 0.20,
						[2] = 0.15,
						[3] = 0.10,
						[4] = 0.05,
					},
				},
				MovePenaltyDuration = 1,
				ManaRegenStartFx = "ManaRegenFlashFx",
				ManaRegenStartSound = "/Leftovers/SFX/SprintChargeUp",
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
			ValidProjectiles = { "DemeterSprintStorm" },
			EffectName = "LegacyChillEffect",
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "DemeterCastBlast",
			FunctionArgs =
			{
				ProjectileNames = {"DemeterSprintStorm","DemeterSprintDefense"},
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
				BaseName = "DemeterSprintStorm",
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
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,

			},
			Epic =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
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
		OnResourceMaxHealth =
		{
			ResourceNames =
			{
				"PlantFMoly",
				"SeedMystery",
				"PlantFNightshadeSeed",
				"PlantGCattailSeed",
				"PlantHWheatSeed",
				"PlantIPoppySeed",
				"PlantNGarlicSeed",
				"PlantOMandrakeSeed",
				"PlantChaosThalamusSeed",
				"PlantFNightshade",
				"PlantGLotus",
				"PlantHMyrtle",
				"PlantIShaderot",
				"PlantNMoss",
				"PlantODriftwood",
				"PlantMoney",
			},
			Amount = 
			{
				BaseValue = 5,
				AsInt = true,
				MinMultiplier = 0.05,
				IdenticalMultiplier =
				{
					Value = -0.5,
				},
			},
			ReportValues = {ReportedAmount = "Amount"}
		},
		StatLines =
		{
			"PlantHealthStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmount",
				ExtractAs = "TooltipHealthConversion",
				IncludeSigns = true,
			}
		}
	},
	BoonGrowthBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
		Icon = "Boon_Demeter_36",
		RequiredUpgradeableGodTraits = 1,
		BlockInRunRarify = true,
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

		AcquireFunctionName = "HarvestBoons",
		AcquireFunctionArgs = 
		{
			Name = "BoonGrowthBoon",
			NumTraits = { BaseValue = 1 },
			ReportValues = { ReportedNumTraits = "NumTraits" }
		},
		RoomsPerUpgrade = 
		{ 
			Amount = 3,
			Rarity = true,
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
	ReserveManaHitShieldBoon =
	{
		Icon = "Boon_Demeter_33",
		InheritFrom = { "BaseTrait", "EarthBoon" },

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 15/20,
			},
			Epic =
			{
				Multiplier = 10/20,
			},
			Heroic =
			{
				Multiplier = 5/20,
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
					BaseValue = 20,
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
		--RequiredFalseTraits = { "StaffAttackRecoveryTrait", "DaggerRapidAttackTrait", "AxeAttackRecoveryTrait" }, 
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
			ExMultiplier =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.5,
					DiminishingReturnsMultiplier = 0.8,
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
		RequiredFalseTraits = { "CastProjectileBoon", "CastAnywhereBoon", "HadesCastProjectileBoon", "PoseidonCastBoon" },
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
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroRangedWeapons,
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
			
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidWeaponMultiplier" 
			},
		},
		StatLines = 
		{
			"CastDamageStatDisplay1",
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
		OnDamageEnemyFunction = {
			FunctionName = "CheckChillKill",
			FunctionArgs = {
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
		}
	},
})