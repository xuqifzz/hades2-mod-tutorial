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
						[1] = 0.4,
						[2] = 0.3,
						[3] = 0.2,
						[4] = 0.1,
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
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},


			{
				WeaponName = "WeaponDagger",
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
				ProjectilName = "ProjectileDaggerDash",
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
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},	
			{
				WeaponName = "WeaponAxeDash",
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
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Zeus",
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
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Zeus",
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
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
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
						[1] = 0.4,
						[2] = 0.3,
						[3] = 0.2,
						[4] = 0.1,
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
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Zeus",
				ChangeType = "Absolute",
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
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Zeus",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Zeus",
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
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Zeus",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Zeus",
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
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Zeus",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Zeus",
				ChangeType = "Absolute",
			},
		}
	},
	ZeusCastBoon =
	{
		Icon = "Boon_Zeus_35",
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
				Multiplier = 1.334,
			},
			Epic =
			{
				Multiplier = 1.667,
			},
			Heroic =
			{
				Multiplier = 2.000,
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

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					},

					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ElectricZapSmall",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/Player Sounds/ElectricZapSmall",
						Brick = "/SFX/Player Sounds/ElectricZapSmall",
						Stone = "/SFX/Player Sounds/ElectricZapSmall",
						Organic = "/SFX/Player Sounds/ElectricZapSmall",
						StoneObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						BrickObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						MetalObstacle = "/SFX/Player Sounds/ElectricZapSmall",
						BushObstacle = "/SFX/Player Sounds/ElectricZapSmall",
					},
				},
			},
		},
		OnProjectileArmFunction =
		{
			FunctionName = "OnZeusCastArmed",
			FunctionArgs = 
			{
				SourceName = "ProjectileCast",
				ProjectileName = "ZeusCastStrike",
				DamageMultiplier =
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 0.334,
						[2] = 0.167,
					},
				},
				Range = 440,
				StrikeInterval = 0.25,
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
			ValidWeapons = {"WeaponSprint"},
			FunctionName = "ZeusSprintZap",
			FunctionArgs = 
			{
				ProjectileName = "ZeusSprintStrike",
				Cooldown = 0.15,
				CostPerStrike = 3,
				RunFunctionNameOnTarget = "ZeusSprintSpend",
				Range = 380,
				DamageMultiplier =
				{
					BaseValue = 1,
					AbsoluteStackValues =
					{
						[1] = 0.25,
						[2] = 0.15,
						[3] = 0.10,
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
				SkipAutoExtract = true,
					Key = "ReportedCost",
					ExtractAs = "ManaCost",
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
		InheritFrom = { "BaseTrait", "AirBoon", "ManaOverTimeSource" },
		Slot = "Mana",
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
		StatLines =
		{
			"ManaRegenStatDisplay1",
		},
		MaxManaMultiplier = 0.3,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				ChangeValue = 0.3,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,
				MaintainDelta = true,
				ReportValues = { ReportedHealthPenalty = "ChangeValue"}
			},
		},
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ZeusManaBoon",
				ManaRegenPerSecond = { BaseValue = 4 },
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
				Key = "MaxManaMultiplier",
				ExtractAs = "TooltipMana",
				Format = "PercentDelta",
			},
		},
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
		ShowLowManaIndicator = true,
		SetupFunction =
		{
			Threaded = true,
			Name = "CheckZeusManaBolt",
			Args = 
			{
				ManaThreshold = 10,
				Cooldown = 5,
				ProjectileName = "ZeusZeroManaStrike",
				DamageMultiplier =
				{
					BaseValue = 1,
					IdenticalMultiplier =
					{
						Value = -0.75,
					},
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown",
					ReportedManaThreshold = "ManaThreshold"
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
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedManaThreshold",
				ExtractAs = "ManaThreshold",
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
				Format = "Percent",
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
		Icon = "Boon_Zeus_29",
		InheritFrom = {"BaseTrait", "AirBoon" },
		PreEquipWeapons = { "WeaponAnywhereCast" },
		RequiredFalseTraits = { "CastProjectileBoon", "HadesCastProjectileBoon", "CastAttachBoon" },
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
				WindowCount = 5, -- "clip fire cooldown. no more than Count projectiles every Duration"
				WindowDuration = 0.75,
				DamageMultiplier =
				{
					BaseValue = 1.0,
					IdenticalMultiplier =
					{
						Value = -0.5,
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
		DoubleBoltChance =
		{
			BaseValue = 0.05,
			AbsoluteStackValues =
			{
				[1] = 0.05,
				[2] = 0.03,
				[3] = 0.02,
				[4] = 0.01,
			},
		},
		StatLines = 
		{
			"DoublBoltChanceStatDisplay1"
		},
		ExtractValues = {
			{
				Key = "DoubleBoltChance",
				ExtractAs = "DoubleChance",
				Format = "Percent"
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
				Multiplier = 0.75/0.75,
			},
			Rare =
			{
				Multiplier = 1/0.75,
			},
			Epic =
			{
				Multiplier = 1.25/0.75,
			},
			Heroic =
			{
				Multiplier = 1.5/0.75,
			},
		},
		EchoExpirationMultiplier = 
		{
			BaseValue = 0.75,
			IdenticalMultiplier =
			{
				Value = -0.75,
			},
		},
		StatLines =
		{
			"EchoExpirationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "EchoExpirationMultiplier",
				ExtractAs = "Damage",
				Format = "Percent",
				HideSigns = true,
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
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckZeusProjectile",
			ValidProjectiles = {"ZeusEchoStrike"},
			FirstHitOnly = true,
			Args = 
			{
				ProjectileName = "ProjectileZeusSpark",
				WindowCount = 3, -- "clip fire cooldown. no more than Count projectiles every Duration"
				WindowDuration = 0.75,
				DamageMultiplier =
				{
					BaseValue = 1,
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
				}
			},
		},
		StatLines =
		{
			"LightningDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileZeusSpark",
				BaseProperty = "Damage",
				ExtractAs = "Damage",
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
		OnEnemySpawnFunction =
		{
			FunctionName = "CheckSpawnZeusDamage",
			Args = 
			{
				Chance = 0.07,
				Damage = 9999,
				Vfx = "ZeusLightningIris",
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
				Format = "Percent",
				HideSigns = true,
			},
		},
		FlavorText = "SpawnKillBoon_FlavorText",
	},
})