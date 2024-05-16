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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,			
			FunctionName = "ApplyBurn",
			Args = 
			{
				EffectName = "BurnEffect",
				NumStacks = 
				{
					BaseValue = 20,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 5,
						[2] = 4,
						[3] = 3,
						[4] = 2,
						[5] = 1,
					},
					AsInt = true,
				},
				ReportValues = {ReportedDamage = "NumStacks"}
			},			
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
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponDagger",
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
				ProjectilName = "ProjectileDaggerDash",
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
				WeaponName = "WeaponAxe",
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
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
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
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Hestia",
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
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Hestia",
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
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
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
					BaseValue = 15,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 5,
						[2] = 4,
						[3] = 3,
						[4] = 2,
						[5] = 1,
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
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Hestia",
				ChangeType = "Absolute",
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
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Hestia",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hestia",
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
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Hestia",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Hestia",
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
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Hestia",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Hestia",
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
					ArmedImpactFx = "null",
					InflictedDamageFx = "GraspingHandsAttack",
					DissipateFx = "CastCircleOutHestia",
					HideGraphicOnDetonate = false
				}
			},

		},
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckCastBurnApply",
			FunctionArgs = 
			{
				Cooldown = 1.0,
				EffectName = "BurnEffect",
				NumStacks = 
				{
					BaseValue = 30,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 15,
						[2] = 10,
						[3] = 5,
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
		OnBlockDamageFunction = 
		{
			Name = "HestiaBlockSpend",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponBlink", "WeaponSprint"},
			FunctionName = "HestiaSprintDefense",
			FunctionArgs = 
			{
				ProjectileName = "HestiaSprintDefense",
				EffectArgs = 
				{
					EffectName = "BurnEffect",
					NumStacks = 
					{
						BaseValue = 2,
						MinValue = 1,
						AbsoluteStackValues =
						{
							[1] = 2,
							[2] = 1,
						},
						AsInt = true,
					},
					ReportValues = {ReportedDamage = "NumStacks"}
				},			
				Vfx = "HestiaFlameParticleDefense",
				FireSound = "/SFX/BurnDamageSizzle",
				BuffVfx = "HestiaFlameBuff",
				ReportValues = { ReportedDamage = "StackCount"}
			},
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
	HestiaManaBoon = 
	{
		Icon = "Boon_Hestia_31",
		InheritFrom = { "BaseTrait", "ManaOverTimeSource", "FireBoon" },
		Slot = "Mana",
		BlockStacking = true,
		MaxHealthMultiplier = 0.80,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 10/7,
			},
			Epic =
			{
				Multiplier = 13/7,
			},
			Heroic =
			{
				Multiplier = 16/7,
			}
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				ChangeValue = 0.80,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,
				MaintainDelta = true,
				ReportValues = { ReportedHealthPenalty = "ChangeValue"}
			},
		},
		StatLines =
		{
			"ManaRegenStatDisplay1",
		},
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "HestiaManaBoon",
				ManaRegenPerSecond = { BaseValue = 7 },
				ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
				IncludeSigns = true,
			},
			{
				Key = "ReportedHealthPenalty",
				ExtractAs = "HealthPenalty",
				Format = "PercentDelta",
				SkipAutoExtract = true,
			},
		},
	},

	SacrificeBoon = 
	{
		Icon = "Boon_Hestia_36",
		InheritFrom = { "BaseTrait", "FireBoon" },
		CodexName = "SacrificeBoon_Codex",
		AcquireFunctionName = "SacrificeBoon",
		PrePickSacrificeBoon = true,
		BlockStacking = true,
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "SacrificeTraitCount" },
				Comparison = ">",
				Value = 1,
			}
		},
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
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 50,
				ChangeType = "Add",	
				AsInt = true,
				ReportValues = { ReportedManaBonus = "ChangeValue"},
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
			},
			{
				LuaProperty = "MaxHealth",
				BaseValue = 50,
				ChangeType = "Add",
				AsInt = true,
				ReportValues = { ReportedHealthBonus = "ChangeValue"},
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
			},
		},
		
		StatLines =
		{
			"MaxLifeManaStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaBonus",
				ExtractAs = "TooltipMana",
				IncludeSigns = true,
			},
			{
				Key = "ReportedHealthBonus",
				ExtractAs = "TooltipHealth",
				IncludeSigns = true,
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
				Multiplier = 1.50,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.50,
			},
		},	
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			FunctionName = "CheckOmegaZeroBurn",
			Args = 
			{
				EffectName = "BurnEffect",
				NumStacks = 
				{ 
					BaseValue = 60,
					MinMultiplier = 0.1,
					IdenticalMultiplier =
					{
						Value = -0.5,
					}, 
				},
				ReportValues = { ReportedStacks = "NumStacks" },
			},		
		},
		StatLines =
		{
			"OmegaZeroBurnStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedStacks",
				ExtractAs = "Stacks",
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
		Icon = "Boon_Hestia_32",
		InheritFrom = { "BaseTrait", "FireBoon" },
		RequiredFalseTraits = { "HadesCastProjectileBoon", "CastAnywhereBoon", "CastAttachBoon" },
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
				BaseValue = 50,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamage = "ChangeValue" },
				AbsoluteStackValues =
				{
					[1] = 20,
					[2] = 15,
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
						[1] = 0.5,
						[2] = 0.25,
						[3] = 0.20,
						[4] = 0.10,
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
				EffectName = "BurnEffect",
				ReportValues = {
					ReportedDamageMultiplier = "ProjectileDamageMultiplier"
				}
			}
		},
		StatLines =
		{
			"DeathBlastStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedEffectThreshold",
				ExtractAs = "ExplosionThreshold",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedStacks",
				ExtractAs = "Stacks",
				SkipAutoExtract = true,
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
	BurnConsumeBoon = 
	{
		Icon = "Boon_Hestia_38",
		InheritFrom = {"BaseTrait", "FireBoon" },
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
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckBurnConsumption",
			FunctionArgs = 
			{
				Delay = 0.1,
				EffectName = "BurnEffect",
				BurnStacks = 300,
				ConsumptionDamage = 
				{ 
					BaseValue = 0.5,
					IdenticalMultiplier =
					{
						Value = -0.75,
					},
				},
				ProjectileName = "HestiaBurnConsumeStrike",
				ReportValues = 
				{
					ReportedDamage = "ConsumptionDamage",
					ReportedStacks = "BurnStacks",
				}
			},
		},
		StatLines =
		{
			"BurnConsumeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedStacks",
				ExtractAs = "Stacks",
				SkipAutoExtract = true,
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
				BaseValue = 2,
				SourceIsMultiplier = true,
				IdenticalMultiplier =
				{
					Value = -0.5,
				},
			},
			ValidEffects = { "BurnEffect" },
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferDamageMultiplier"},
		},
		StatLines =
		{
			"BurnArmorDamageIncreaseDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
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
	BurnStackBoon = -- Legendary
	{
		Icon = "Boon_Hestia_40",
		InheritFrom = { "LegendaryTrait", "FireBoon" },
		BurnDamageMultiplier = 2.0,
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
})