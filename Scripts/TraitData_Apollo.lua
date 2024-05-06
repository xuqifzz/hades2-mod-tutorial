OverwriteTableKeys( TraitData, {
	-- Apollo
	ApolloWeaponBoon =
	{
		Icon = "Boon_Apollo_27",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Melee",
		ReferenceWeapon = "WeaponSpellLaser",
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
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.40,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.10,
					[2] = 1.05,
				},
			},
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges = {
			-- Range/Area Properties
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponLob",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},		
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ApolloSwipeSFX",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxe3",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ApolloAxeFinishSFX",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponLob",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},	
			{
				WeaponName = "WeaponLobChargedPulse",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},															
			-- Apollo VFX
			{
				WeaponName = "WeaponStaffSwing",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx1_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack1Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack1Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack2_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack2Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack2Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack3_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "StaffComboAttack3Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "DeathFx",
				ChangeValue = "StaffComboAttack3Dissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffDash",
				ProjectileName = "ProjectileStaffDash",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffComboAttack1Dash_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileName = "ProjectileSwing5Magic",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "StaffChargedAttackFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFx4_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFast_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger2",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlip_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDash",
				ProjectilName = "ProjectileDaggerDash",
				WeaponProperty = "FireFx",
				ChangeValue = "DaggerSwipeFastFlipDash_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ProjectileName = "ProjectileDagger",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerJab_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "DaggerSwipeDouble_Apollo",
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
				ChangeValue = "DaggerCharge_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperty = "StartFx",
				ChangeValue = "DaggerSwipe_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			

			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe1_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipe2_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileName = "ProjectileAxeOverhead",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "FireFx",
				ChangeValue = "AxeSwipeUpper_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileName = "ProjectileAxeSpin",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeSwipe2Spin_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectile_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "BounceFx",
				ChangeValue = "LobProjectileBounceFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2Close_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosion_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobProjectileCharged_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "LobProjectileChargedSecondaryEmitter_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DescentStartFx",
				ChangeValue = "LobEXDescentStart_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "LobEXFireFx_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "LobExplosionCharged_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileSmallIn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrike",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchRepeatStrikeLarge",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Apollo",
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
					Key = "ReportedAoEIncrease",
					ExtractAs = "AOEBonus",
					Format = "PercentDelta",
					SkipAutoExtract = true,
			},
		}
	},
	ApolloSpecialBoon =
	{
		Icon = "Boon_Apollo_30",
		InheritFrom = { "BaseTrait", "AirBoon" },
		Slot = "Secondary",
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
		WeaponDataOverride =
		{
			WeaponAxeBlock2 =
			{
				Sounds = 
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/ApolloAxeBlockLoop",
							StoppedBy = { "ChargeCancel", "TriggerRelease" },
						},
					},
				}
			}
		},
		PropertyChanges = {
			-- Range/Area Properties
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},		
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxeBlock2",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
			-- Apollo VFX
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "FireFx",
				ChangeValue = "StaffProjectileFireFxRing_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "ApolloGroundGlow",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagram_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx2_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/ApolloDaggerSwipe",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "DeathFx",
				ChangeValue = "DaggerProjectileFxFade_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeBlock2",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeDeflect_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNovaEX_Apollo",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeStartFx",
				ChangeValue = "LobCharge_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Apollo",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Apollo",
				ChangeType = "Absolute",
			},	

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Apollo",
				ChangeType = "Absolute",
			},			

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Apollo",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Apollo",
				ChangeType = "Absolute",
			},

		},
		
		StatLines =
		{
			"SpecialDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "PercentDelta",
			},
			{
					Key = "ReportedAoEIncrease",
					ExtractAs = "AOEBonus",
					Format = "PercentDelta",
					SkipAutoExtract = true,
			},
		},
	},
	ApolloCastBoon =
	{
		Icon = "Boon_Apollo_31",
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
		StatLines =
		{
			"OmegaCastDamageOverTimeStatDisplay1",
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckArmedApolloCast",
			Args = 
			{
				ValidProjectileName = "ProjectileCast",
				ProjectileName = "ApolloCast",
				DamageMultiplier = 
				{ 
					BaseValue = 1,
					IdenticalMultiplier =
					{
						Value = -0.5,
						DiminishingReturnsMultiplier = 0.8,
					},
				},
				
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ApolloCast",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ApolloCast",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
			},
			{
				ExtractAs = "BeamDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ApolloCast",
				BaseProperty = "TotalFuse",
			}
		}
	},
	ApolloSprintBoon =
	{
		Icon = "Boon_Apollo_28",
		InheritFrom = { "BaseTrait", "FireBoon"},
		Slot = "Rush",
		WeaponDataOverride =
		{
			WeaponSprint =
			{
				SprintVfx = 
				{
					Cooldown = 0.2,
					Name = "null",
				},
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/ApolloSprintLoop" ,
							StoppedBy = { "ChargeCancel" }
						},
					},
				},
			}
		},
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
		OnSprintAction = 
		{
			EffectName = "BlindEffect",
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocity",
				BaseValue = 330,
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
				MinMultiplier = 0.17,
				IdenticalMultiplier =
				{
					Value = -0.67,
				},
			},
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 375,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "ApolloControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintFx",
				EffectProperty = "BackFx",
				ChangeValue = "MelSprintFxSpawner_Apollo"
			},
		},
		
		StatLines =
		{
			"SprintSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "PercentOfBase",
				BaseType = "Weapon",
				BaseName = "WeaponSprint",
				BaseProperty = "SelfVelocity",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
		}
	},
	ApolloManaBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Apollo_29",
		Slot = "Mana",
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
		SetupFunction =
		{
			Name = "InCastCircleManaRegenSetup",
			RunOnce = true
		},
		StatLines =
		{
			"ManaRegenStatDisplay1",
		},
		CastCircleManaRegen = { 
			BaseValue = 12, 
			IdenticalMultiplier =
			{
				Value = -0.5,
			},
			MinMultiplier = 1/12,
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Graphic = "CastCircleInApolloRegen",
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "CastCircleManaRegen",
				ExtractAs = "TooltipManaRecovery",
				IncludeSigns = true,
				DecimalPlaces = 1,
			},
		
		},
	},

	ApolloRetaliateBoon =
	{
		Icon = "Boon_Apollo_33",
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
			},
		},
		OnSelfDamagedFunction = 
		{
			Name = "ApolloRetaliate",
			FunctionArgs = 
			{
				ProjectileName = "ApolloRetaliateStrike",
				EffectName = "BlindEffect",
				Cooldown = 0.15,
				DamageMultiplier =
				{
					BaseValue = 1,
					MinMultiplier = 0.1,
					IdenticalMultiplier =
					{
						Value = -0.5,
					},
				},
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		StatLines =
		{
			"RevengeDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ApolloRetaliateStrike",
				BaseProperty = "Damage",
				ExtractAs = "Damage",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	PerfectDamageBonusBoon = 
	{
		Icon = "Boon_Apollo_36",
		InheritFrom = { "BaseTrait", "AirBoon"},
		PriorityDisplay = true,
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
			UndamagedMultiplier =
			{
				BaseValue = 1.10,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.5,
				},
			},
			ReportValues = { ReportedMultiplier = "UndamagedMultiplier"},
		},
	
		StatLines =
		{
			"UnscathedDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
		}
	},
	BlindChanceBoon = 
	{
		Icon = "Boon_Apollo_39",
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
			},
		},

		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			EffectName = "BlindEffect",
			Chance = 
			{ 
				BaseValue = 0.10,
				AbsoluteStackValues =
				{
					[1] = 0.05,
					[2] = 0.03,
					[3] = 0.02,
					[4] = 0.01,
				},
			},
			ReportValues = { ReportedChance = "Chance"}
		},
		StatLines =
		{
			"BlindChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "Percent",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	ApolloBlindBoon = 
	{
		Icon = "Boon_Apollo_37",
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
			},
		},
	
		AddOutgoingDamageModifiers =
		{
			HitVulnerabilityMultiplier =
			{
				BaseValue = 1.50,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.5,
					DiminishingReturnsMultiplier = 0.8,
				},
			},
			ValidActiveEffectGenus = "Blind",
			ReportValues = { ReportedMultiplier = "HitVulnerabilityMultiplier"},

		},
		StatLines =
		{
			"BackstabStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	ApolloMissStrikeBoon =
	{
		Icon = "Boon_Apollo_38",
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
		OnDodgeFunction = 
		{
			FunctionName = "ApolloBlindStrike",
			RunOnce = true,
			FunctionArgs =
			{
				ValidActiveEffectGenus = "Blind",
				ProjectileName = "ApolloPerfectDashStrike",
				DamageMultiplier = { 
					BaseValue = 1,
					MinMultiplier = 0.1,
					IdenticalMultiplier =
					{
						Value = -0.5,
						DiminishingReturnsMultiplier = 0.8,
					}, 
				},
				Cooldown = 0.2,
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			},
		},
		StatLines =
		{
			"MissDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ApolloPerfectDashStrike",
				BaseProperty = "Damage",
				ExtractAs = "Damage",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
		}
	},
	ApolloCastAreaBoon = 
	{
		Icon = "Boon_Apollo_32",
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
		
		CastProjectileModifiers =
		{
			AreaIncrease = 
			{ 
				BaseValue = 1.4,
				SourceIsMultiplier = true,
				MinMultiplier = 0.1,
				IdenticalMultiplier =
				{
					Value = -0.75,
					DiminishingReturnsMultiplier = 0.75,
				},
			},
			ReportValues = { ReportedMultiplier = "AreaIncrease"}
		},
		StatLines =
		{
			"AreaCastStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		}
	},
	DoubleStrikeChanceBoon = 
	{
		Icon = "Boon_Apollo_45",
		InheritFrom = { "BaseTrait", "FireBoon" },
		StringTextNumeral = 2, -- used for string

		PropertyChanges = 
		{
			{
				WeaponNames = 
				{
					"WeaponStaffSwing",
					"WeaponStaffSwing2",
					"WeaponStaffSwing3",
					"WeaponStaffDash",
					
					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxeDash",
					
					"WeaponDagger",
					"WeaponDagger2",
					"WeaponDaggerDouble",
					"WeaponDaggerMultiStab",
					"WeaponDaggerDash",

					"WeaponTorch",
		
					"WeaponLob",
				},
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.2,
				ExcludeLinked = true,
			},
			{
				WeaponNames = 
				{
					"WeaponStaffSwing",
					"WeaponStaffSwing2",
					"WeaponStaffSwing3",
					"WeaponStaffDash",
					
					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxeDash",
					
					"WeaponDagger",
					"WeaponDagger2",
					"WeaponDaggerDouble",
					"WeaponDaggerMultiStab",
					"WeaponDaggerDash",

					"WeaponTorch",
		
					"WeaponLob",
				},
				ExcludeLinked = true,
				WeaponProperty = "AdditionalProjectileWaveChance",
				BaseValue = 0.05,
				AbsoluteStackValues =
				{
					[1] = 0.03,
					[2] = 0.02,
					[3] = 0.01
				},
				ReportValues = { ReportedChance= "ChangeValue" }
			}
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
			},
		},
		StatLines = 
		{
			"DoubleStrikeChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "DoubleChance",
				Format = "Percent",
			},
		}
	},
	DoubleExManaBoon = -- Legendary
	{
		Icon = "Boon_Apollo_40",
		InheritFrom = { "LegendaryTrait", "AirBoon" },
		ApplyAfterHammerTraits = true,
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
			ExWeapons = true,
			ManaCostAdd = { BaseValue = 20 },
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		ChargeStageModifiers = 
		{
			WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
			ExWeapons = true,
			AddWeaponProperties = 
			{
				NumProjectileWaves = 2,
				ProjectileWaveInterval = 0.2,
			}
		},
		PropertyChanges = 
		{
			{
				FalseTraitName = "StaffOneWayAttackTrait",
				WeaponNames = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponLobChargedPulse", "WeaponAxeSpecialSwing" },
				WeaponProperties = 
				{
					NumProjectileWaves = 2,
					ProjectileWaveInterval = 0.2,
				},
				ExcludeLinked = true,
			},
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponNames = { "WeaponStaffSwing5" },
				ExcludeLinked = true,
				WeaponProperty = "NumProjectileWaves",
				ChangeType = "Multiply",
				ChangeValue = 2,
			},
		},
		StatLines =
		{
			"MagicCostStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCostAddition",
				IncludeSigns = true,
			},
		}
	},
})