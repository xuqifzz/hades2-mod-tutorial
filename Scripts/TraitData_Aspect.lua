TraitSetData.Aspects =
{
	-- Staff
	BaseStaffAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Staff_39",
		RequiredWeapon = "WeaponStaffSwing",
		WeaponKitGrannyModel = "WeaponStaff_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Mesh"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = { BaseValue = 10 },
			ReportValues = { ReportedBonus = "ValidBaseDamageAddition" }
		},
		
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 10,
				ChangeType = "Add",
			},
		},
		StatLines =
		{
			"SpecialAndManaStatDisplay1",
		},
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 0,
				MaxMultiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect = 
			{
				Multiplier = 5,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "DamageBonus",
				IncludeSigns = true,
			},
		},
		FlavorText = "BaseStaffAspect_FlavorText",
	},
	StaffClearCastAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Staff_40",
		RequiredWeapon = "WeaponStaffSwing",
		WeaponKitGrannyModel = "WeaponStaff_Circe_Mesh",	
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Circe_Mesh"
		},

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 15/10,
			},
			Epic =
			{
				Multiplier = 20/10,
			},
			Heroic =
			{
				Multiplier = 25/10,
			},
			Legendary =
			{
				Multiplier = 30/10,
			},
			Perfect =
			{
				Multiplier = 45/10,
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroRangedWeapons,
			FunctionName = "CheckFamiliarLink",
			FunctionArgs = 
			{
				ProjectileName = "FamiliarLinkLaser",
				DamageMultiplier = { BaseValue = 1.0 },
				ReportValues = { ReportedDamage = "DamageMultiplier" }
			},
			ExcludeLinked = true,
		},
		StatLines =
		{
			"ClearCastDurationDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "FamiliarLinkLaser",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "FamiliarLinkLaser",
				BaseProperty = "Fuse",
			},
			{
				ExtractAs = "Interval",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "FamiliarLinkLaser",
				BaseProperty = "ImmunityDuration",
				DecimalPlaces = 1,
			},
		},
		FlavorText = "StaffClearCastAspect_FlavorText",
		
		Using =
		{
			"CirceCrystalRotateFront1", "CirceCrystalRotateFront2", "CirceCrystalRotateFront3", "CirceCrystalRotateFront4", "CirceCrystalRotateFront5",
			"CirceCrystalRotateBack1", "CirceCrystalRotateBack2", "CirceCrystalRotateBack3", "CirceCrystalRotateBack4", "CirceCrystalRotateBack5",
			ProjectileName = "FamiliarLinkLaser",
		},
	},
	StaffSelfHitAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 3.5/4,
			},
			Epic =
			{
				Multiplier = 3.0/4,
			},
			Heroic =
			{
				Multiplier = 2.5/4,
			},
			Legendary =
			{
				Multiplier = 2.0/4,
			},
			Perfect = 
			{
				Multiplier = 1.0/4,
			},
		},
		Icon = "Hammer_Staff_41",
		RequiredWeapon = "WeaponStaffSwing",
		-- 'I have a good idea for a prank for this Asclepius character' ~Momus
		WeaponKitGrannyModel = "WeaponStaff_Asclepius_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Asclepius_Mesh"
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "DropOriginMarker",
			FunctionArgs = 
			{
				AnimationName = "MomusCastPointSpawn",
				AttackAnimationName = "MomusCastPointAttack",
				PreAttackDuration = 0.25,
				ExpiringAnimationName = "MomusCastPointOut",
				DestroyDelay = 0.5,
				Repeats = 3,
				Interval = { BaseValue = 4.0 },
				ReportValues = { ReportedStrikeCount = "Repeats"},
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "ClearOriginMarker",
			Args = 
			{
				AttackAnimationName = "MomusCastPointAttack",
				PreAttackDuration = 0.25,
				ExpiringAnimationName = "MomusCastPointOut",
				DestroyDelay = 0.5,
				CastRepeats = 3,
				Interval = { BaseValue = 4 },
				ReportValues = { ReportedPulseInterval = "Interval"},
			},
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing5"},
				ExcludeLinked = true,
				WeaponProperties = 
				{
					NumProjectileWaves = 3,
				},
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 10,	--Handled via StartPrimaryRepeatThread
			},
		},
		OnExpire = 
		{
			FunctionName = "ClearAllOriginMarkers"
		},
		StatLines =
		{
			"PulseIntervalStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedPulseInterval",
				ExtractAs = "PulseInterval",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedStrikeCount",
				ExtractAs = "StrikeCount",
				SkipAutoExtract = true
			}
		},
		FlavorText = "StaffSelfHitAspect_FlavorText",
	},
	StaffRaiseDeadAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" },
			},
		},
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
			Legendary =
			{
				Multiplier = 3,
			},
			Perfect =
			{
				Multiplier = 4.5,
			},
		},
		Icon = "Hammer_Staff_42",
		RequiredWeapon = "WeaponStaffSwing",
		WeaponKitGrannyModel = "WeaponStaff_Anubis_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Anubis_Mesh"
		},
		
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ExMultiplier = { BaseValue = 1.1, SourceIsMultiplier = true},
			ReportValues = 
			{
				ReportedDamage = "ExMultiplier",
			}
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroAllWeaponsAndSprint,
			Value = 
			{
				BaseValue = 0.9,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupAnubisAnimationSwaps",
		},
		OnUnequipFunctionName = "EndAnubisAnimationSwaps",
		
		WeaponDataOverride =
		{
			WeaponStaffSwing =
			{
				CancelSlowFrames = true, 
				HitSimSlowCooldown = "nil",
				HitSimSlowParameters = "nil",
				HitRumbleParameters = "nil",
				ExpireDashWeaponOnDash = false,
				FireRumbleParameters =
				{
					{ ScreenPreWait = 0.06, Fraction = 0.1, Duration = 0.1 },
				},
				FireScreenshake = { Distance = 5, Speed = 300, FalloffSpeed = 1400, Duration = 0.08, Angle = 90, ScreenPreWait = 0.055 },
				HitScreenshake = "nil",

				CompleteObjectivesOnFire = { "WeaponStaffSwing_Anubis" },

				Sounds =
				{
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteAttacking1" },
						{ Name = "/SFX/Player Sounds/MelStaffSwipeWhoosh" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/BurnDamageTorches",
						Brick = "/SFX/BurnDamageTorches",
						Stone = "/SFX/BurnDamageTorches",
						Organic = "/SFX/BurnDamageTorches",
						StoneObstacle = "/SFX/BurnDamageTorches",
						BrickObstacle = "/SFX/BurnDamageTorches",
						MetalObstacle = "/SFX/BurnDamageTorches",
						BushObstacle = "/SFX/BurnDamage",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
			WeaponStaffDash =
			{
				HitSimSlowParameters = "nil",
				HitRumbleParameters = "nil",
				FireRumbleParameters =
				{
					{ ScreenPreWait = 0.06, Fraction = 0.1, Duration = 0.1 },
				},

				Sounds =
				{
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteAttacking1" },
						{ Name = "/SFX/Player Sounds/MelStaffSwipeWhoosh" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/BurnDamageTorches",
						Brick = "/SFX/BurnDamageTorches",
						Stone = "/SFX/BurnDamageTorches",
						Organic = "/SFX/BurnDamageTorches",
						StoneObstacle = "/SFX/BurnDamageTorches",
						BrickObstacle = "/SFX/BurnDamageTorches",
						MetalObstacle = "/SFX/BurnDamageTorches",
						BushObstacle = "/SFX/BurnDamage",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponStaffSwing5 = 
			{
				CancelSlowFrames = true, 
				--CancelCameraShake = true,
				ManaCost = 25,
				HitSimSlowParameters = "nil",
				HitRumbleParameters = "nil",
				ChargeScreenshake = "nil",
				ChargeCameraMotion = "nil",
				ChargeRumbleParameters =
				{
					{ ScreenPreWait = 0.02, Fraction = 0.11, Duration = 0.9 },
				},

				FireRumbleParameters =
				{
					{ ScreenPreWait = 0.06, Fraction = 0.3, Duration = 0.1 },
				},

				FireScreenshake = { Distance = 5, Speed = 180, FalloffSpeed = 1400, Duration = 0.09, Angle = 0 },
				HitScreenshake = "nil",

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteCharging1",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteAttacking2" },
						{ Name = "/SFX/Player Sounds/StaffAnubisSlamWallSpawn" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/BurnDamageTorches",
						Brick = "/SFX/BurnDamageTorches",
						Stone = "/SFX/BurnDamageTorches",
						Organic = "/SFX/BurnDamageTorches",
						StoneObstacle = "/SFX/BurnDamageTorches",
						BrickObstacle = "/SFX/BurnDamageTorches",
						MetalObstacle = "/SFX/BurnDamageTorches",
						BushObstacle = "/SFX/BurnDamage",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
			WeaponStaffBall =
			{
				FireScreenshake = { },
				HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.34, Angle = 90, DistanceThreshold = 200 },
				RumbleDistanceThreshold = 480,
				HitRumbleParameters =
				{
					{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
				},

				CompleteObjectivesOnNonStagedFire = { "WeaponStaffBall_Anubis" },
				
				ExParameters = 
				{
					HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.35, FalloffSpeed = 3000 },
					HitRumbleParameters =
					{
						RumbleDistanceThreshold = 480,
						{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
					},
				},
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 10, 
						Wait = 0.85,
						WeaponProperties =
						{
							Projectile = "ProjectileStaffBallCharged",
							AdditionalProjectileWaveChance = 0,
							Cooldown = 0.31,
							ClipRegenInterval = 0,
							FireGraphic = "Melinoe_Staff_SpecialEx1_Fire",
							SelfVelocity = 0,
						},
						ProjectileProperties =
						{
							DamageRadius = 435,
							Damage = 110,
						},
						ApplyEffects = { "Special1DisableMoveHold", },
						FxOnStart = "StaffBoltCharge", 
						ChannelSlowEventOnStart = true,

					},
				},
				Sounds =
				{
					ChargeSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/EmoteCharging" },
						{
							Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					ChargeStageSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCharging",
							StoppedBy = { "ChargeCancel", "Fired", "ChargeStage" }
						},
						{
							Name = "/SFX/Player Sounds/ZagreusWeaponChargeup",
							StoppedBy = { "ChargeCancel", "Fired", }
						}
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
						},
						{ Name = "/VO/MelinoeEmotes/EmoteLaunchingSuit" },
					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteSpecial" },
						{ Name = "/Leftovers/SFX/AuraThrowSmall" },
					},
					-- ImpactSounds handled in ProjectileData
				},

			},
		},
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			ExWeapons = true,
			ManaCostAdd = 20,
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponStaffSwing5", "WeaponCastArm" },
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
			},
			-- Staff ground pound changes	
			{
				WeaponName = "WeaponStaffSwing",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					Projectile = "ProjectileStaffSingle",
					SwapOnFire = "null",
					BarrelLength = 100,
					ChargeStartAnimation = "Melinoe_Staff_Anubis_AttackSlam_Start",
					FireGraphic = "Melinoe_Staff_Anubis_AttackSlam_Fire",
					FireFx = "StaffProjectileFireFx3_Anubis",
					ChargeCancelGraphic = "Melinoe_Staff_Anubis_AttackSlam_End",
					ChargeTime = 0.46,
				},
			},
			{
				WeaponName = "WeaponStaffSwing",
				EffectName = "Swing1Disable",
				EffectProperty = "Duration",
				ChangeValue = 9/60,
			},
			{
				WeaponName = "WeaponStaffSwing",
				EffectName = "Swing1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 18/60,
			},
			{
				WeaponName = "WeaponStaffSwing",
				EffectName = "Swing1DisableMoveHold",
				EffectProperty = "Duration",
				ChangeValue = 30/60,
			},
			{
				WeaponName = "WeaponSprint",
				WeaponProperty = "DisableFireWithEffect",
				ChangeValue = "SwingDashMoveCancellable",
			},
			{
				WeaponName = "WeaponStaffDash",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					Projectile = "ProjectileStaffSingle",
					BarrelLength = 100,
					ChargeStartAnimation = "Melinoe_Staff_Anubis_AttackSlam_Start_Fast",
					FireGraphic = "Melinoe_Staff_Anubis_AttackSlam_Fire",
					FireFx = "StaffProjectileFireFx3",
					ChargeCancelGraphic = "Melinoe_Staff_Anubis_AttackSlam_End",
					ChargeTime = 0.18,
				},
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Anubis",
				ChangeType = "Absolute",
			},	
			{
				WeaponName = "WeaponStaffDash",
				EffectName = "SwingDashDisable",
				EffectProperty = "Duration",
				ChangeValue = 9/60,
			},
			{
				WeaponName = "WeaponStaffDash",
				EffectName = "SwingDashDisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 18/60,
			},
			{
				WeaponName = "WeaponStaffDash",
				EffectName = "SwingDashMoveCancellable",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			-- Staff power wall changes
			{
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Staff_Anubis_AttackWall_Start",
					FireGraphic = "Melinoe_Staff_Anubis_AttackWall_Fire",
					ChargeCancelGraphic = "Melinoe_Staff_Anubis_AttackWall_End",
					Projectile = "ProjectileStaffWall",
					AutoLockArcDistance = math.rad(160),
					AutoLockRange = 520,
					BarrelLength = 520,
					NumProjectiles = 1,
					ProjectileOffsetStart = "LEFT",
					ShowFreeAimLine = true,
					AimLineDistanceOverride = 80,
					AimLineAnimation = "AnubisStaffWallAimLineDecal",
					FizzleOldSpawns = true,
					ActiveProjectileCap = 1,
				},
				ProjectileProperties =
				{
					Damage = 50
				}
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.88/0.8, -- new attack time on left, base staff omega attack on the right
				ChangeType = "Multiply"
			},
			-- Staff special changes
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				WeaponProperties =
				{
					ChargeStartAnimation = "Melinoe_Staff_Anubis_Special1_Start",
					FireGraphic = "Melinoe_Staff_Anubis_Special1_Fire",
					ChargeCancelGraphic = "Melinoe_Staff_Anubis_Special1_End",
					SelfVelocity = 0,
					Cooldown = 0.33,
					ChargeTime = 0.1,
					ClipRegenInterval = 0.32,
				},
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperties = 
				{
					UnlimitedUnitPenetration = false,
					Damage = 20,
				}
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				EffectName = "Special1Disable",
				EffectProperty = "Duration",
				ChangeValue = 7/60,
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				EffectName = "Special1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 12/60,
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				EffectName = "Special1DisableMoveHold",
				EffectProperty = "Duration",
				ChangeValue = 23/60,
			},

			{
				WeaponName = "WeaponStaffBall",
				EffectName = "Special1AspectTriggerLock",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				EffectName = "StaffAspectStun",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
		},
		
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "ProjectileStaffSingle" },
			Name = "FizzleOldAnubisProjectiles",
			Args = 
			{
				ProjectileCap = 1,
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponStaffBall",},
			FirstHitOnly = true,
			FunctionName = "CheckStaffProjectilePull",
			Args = 
			{
				Radius = 500,
				RadiusEx = 900,
				ScaleY = 0.55,
				PlayerDistance = 400,
				PlayerDistanceEx = 550,
				DeadZoneRadius = 10,			-- Radius within which the pull has no effect
				DistanceMultiplier = 1.7,		-- How strong the pull is relative to distance
				PullVfx = "AnubisVacuumFxFront_Base",
				ExPullVfx = "AnubisExVacuumFxFront_Base",
				TraitPullVfxOverride  = 
				{
					AphroditeSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Aphrodite",
						ExPullVfx = "AnubisExVacuumFxFront_Aphrodite",	
					},
					ApolloSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Apollo",
						ExPullVfx = "AnubisExVacuumFxFront_Apollo",	
					},
					DemeterSpecialBoon = {

						PullVfx = "AnubisVacuumFxFront_Demeter",
						ExPullVfx = "AnubisExVacuumFxFront_Demeter",	
					} ,
					HephaestusSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Hephaestus",
						ExPullVfx = "AnubisExVacuumFxFront_Hephaestus",	
					},
					HestiaSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Hestia",
						ExPullVfx = "AnubisExVacuumFxFront_Hestia",	
					},
					HeraSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Hera",
						ExPullVfx = "AnubisExVacuumFxFront_Hera",	
					},
					PoseidonSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Poseidon",
						ExPullVfx = "AnubisExVacuumFxFront_Poseidon",
					},
					ZeusSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Zeus",
						ExPullVfx = "AnubisExVacuumFxFront_Zeus",	
					},
					AresSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Ares",
						ExPullVfx = "AnubisExVacuumFxFront_Ares",	
					},
				},
			}
		},
		EncounterEndFunctionName = "EndEncounterShadeDissipate",
		EncounterEndFunctionArgs =
		{
			Name = "ShadeMercAspect",
			SmileChance = 0.05,
		},
		OnEnemyDeathFunction = 
		{
			Name = "CreateShadeMerc",
			FunctionArgs = 
			{
				MaxCount = 8,
				Chance = 1.0,
				Name = "ShadeMercAspect",
				AngleMin = 190,
				AngleMax = 350,
			}
		},
		
		OnProjectileDeathFunction = 
		{
			Name = "CleanupShadeMerc",
			ValidProjectiles = {"ShadeMercAspectSpiritball"},
		},
		StatLines =
		{
			"RaiseDeadOmegaBuffStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipSpeed",
				Format = "PercentDelta",
			},
		},
		FlavorText = "StaffRaiseDeadAspect_FlavorText",
	},

	-- Dagger
	DaggerBackstabAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_38",
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDagger_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Mesh"
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 2.0,
			},
			Legendary =
			{
				Multiplier = 2.5,
			},
			Perfect =
			{
				Multiplier = 5,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			HitVulnerabilityMultiplier =
			{
				BaseValue = 1.40,
				SourceIsMultiplier = true,
			},
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
		},
		FlavorText = "DaggerBackstabAspect_FlavorText",
	},
	DaggerHomingThrowAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_40",
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDaggerMultiple_Pan_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Pan_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Pan_Mesh"
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = {"WeaponDaggerThrow"},
			AddProjectedChargeStages = 
			{
				NumStages = { BaseValue = 1 },
				ProjectedChanges =
				{
					NumProjectiles = 1,
					ManaCost = 3,
				},
				ReportValues = { ReportedProjectiles = "NumStages" }
			},
			AddWeaponPropertiesStageRequirementMin = 5,
			AddWeaponProperties = 
			{
				FireGraphic = "Melinoe_Dagger_SpecialEx_Fire_Slow",
			},
			HideStageReachedFxExceptForFinal = true ,
		},
		ScaledStageEffects = 
		{
			WeaponDaggerThrowEXDisableCancellable = { Base = 7/60, StageIncrement = 0.075 },
			WeaponDaggerThrowEXDisableMoveHold = { Base = 14/60, StageIncrement = 0.075 },
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponBlink"},
			FunctionName = "ExpireDaggersOnBlink",
		},
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckDaggerPenetration",
			ValidProjectiles = { "ProjectileDaggerThrowCharged" },
		},
		StatLines = 
		{
			"ExThrowStatDisplay1",
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponDaggerThrow" },
				ExcludeLinked = true,
				ProjectileProperties = 
				{
					AdjustRateAcceleration = math.rad(10000),
					MaxAdjustRate = math.rad(2160),
					RequireTargetsHaveEffect = "ImpactSlow",
				}

			},

			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan",
				ChangeType = "Absolute",
			},

		},
		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Projectiles",
				IncludeSigns = true,
			},
		},
		FlavorText = "DaggerHomingThrowAspect_FlavorText",
	},
	DaggerBlockAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_39",
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDaggerMultiple_Artemis_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Artemis_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Artemis_Mesh"
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2.0
			},
			Heroic =
			{
				Multiplier = 2.5
			},
			Legendary =
			{
				Multiplier = 3.0
			},
			Perfect =
			{
				Multiplier = 4.5,
			},
		},
		PriorityDisplay = true,
		AddOutgoingCritModifiers =
		{
			ValidVolleyChance = 0.5,
			ReportValues = { ReportedChance = "ValidVolleyChance"},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "DaggerBlockSetup",
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveCritVolley",
		},
		OnWeaponChargeFunctions = 
		{
			ValidWeapons = {"WeaponDagger5"},
			FunctionName = "CheckDaggerBlock",
			FunctionArgs = 
			{
				Cooldown = 12,
				CritCount = 9,
				InvulnerableEffectName = "DaggerBlockInvincibubble",
				InvulnerableDuration = 1,
				Vfx = "ArtemisParryShield",
				BackVfx = "ArtemisParryShieldBack",
				ActivatedVfx = "DaggerBlockActiveFx",
				ReportValues = 
				{ 
					ReportedCooldown = "Cooldown",
					ReportedHits = "CritCount",
					ReportedDuration = "InvulnerableDuration",
					ReportedSpeedIncrease = "ExAttackSpeed",
				},
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = CombineTables( WeaponSets.HeroPrimarySecondaryWeapons, {"WeaponTransformAttack","WeaponTransformSpecial", } ),
			FunctionName = "CheckDaggerCritCharges",
		},
		WeaponSpeedMultiplier = 
		{
		
			WeaponNames = {"WeaponDagger5"},
			Value = 
			{
				BaseValue = 0.80,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeedIncrease = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponNames = {"WeaponDagger5"},
				BaseValue = 0.80,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
		},
		StatLines = 
		{
			"EXAttackSpeedStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta"
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHits",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "InvulnerableDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedChance",
				ExtractAs = "CritChance",
				SkipAutoExtract = true,
				Format = "LuckModifiedPercent",
			},
		},
		FlavorText = "DaggerBlockAspect_FlavorText",
		Using = { Animation = "ArtemisParryFlare" },
	},
	DaggerTripleAspect =
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect" },
			},
		},
		Icon = "Hammer_Daggers_42",
		NumHits = 3, -- used only for text
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDaggerMultiple_Morrigan_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Morrigan_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Morrigan_Mesh"
		},
		PriorityDisplay = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 3,
			},
			Rare =
			{
				Multiplier = 4,
			},
			Epic =
			{
				Multiplier = 5,
			},
			Heroic =
			{
				Multiplier = 6,
			},
			Legendary =
			{
				Multiplier = 7,
			},
			Perfect = 
			{
				Multiplier = 9,
			},
		},
		WeaponDataOverride =
		{
			WeaponDagger =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteChargingSuit" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/MorriganEmoteSpecial2" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmashShort",
						Brick = "/SFX/MetalStoneClangShort",
						Stone = "/SFX/MetalStoneClangShort",
						Organic = "/SFX/DaggerImpactOrganic",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},

				},
			},

			WeaponDagger5 =
			{
				ManaCost = 15,
				--HideChargeDuration = 0.05,
				Sounds =
				{
					ChargeSounds =
					{


						{
							Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingSuit" },
						{ Name = "/SFX/Player Sounds/MelDaggerMagicAttack" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/Player Sounds/ZagreusCriticalFire",
						Brick = "/SFX/Player Sounds/ZagreusCriticalFire",
						Stone = "/SFX/Player Sounds/ZagreusCriticalFire",
						Organic = "/SFX/Player Sounds/ZagreusCriticalFire",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponDaggerThrow = 
			{
				MinWeaponChargeTime = 0.16,
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 15, 
						WeaponProperties = 
						{ 
							Projectile = "ProjectileDaggerThrowCharged", 
							NumProjectiles = 3, 
							AdditionalProjectileWaveChance = 0
						}, 
						ApplyEffects = 
						{ 
							"WeaponDaggerMorriganThrowEXDisable", 
							"WeaponDaggerMorriganThrowEXDisableCancellable", 
							"WeaponDaggerMorriganThrowEXDisableMoveHold" 
						}, 
						Wait = 0.45, 
						ChannelSlowEventOnEnter = true,
						HideStageReachedFx = true,
					},
				},
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
						},
						{ Name = "/SFX/Player Sounds/BowFire" },
						{ Name = "/VO/MelinoeEmotes/MorriganEmoteAttacking2" },
					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
						{ Name = "/SFX/Player Sounds/MelDaggerKnifeThrowSwishGROUP" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/ArrowMetalBoneSmash",
						Brick = "/SFX/ArrowMetalStoneClang",
						Stone = "/SFX/ArrowMetalStoneClang",
						Organic = "/SFX/DaggerThrowImpact",
						StoneObstacle = "/SFX/ArrowWallHitClankSmall",
						BrickObstacle = "/SFX/ArrowWallHitClankSmall",
						MetalObstacle = "/SFX/ArrowWallHitClankSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponDaggerDouble =
			{
				HitSimSlowParameters =
				{
					{ ScreenPreWait = 0.03, Fraction = 0.15, LerpTime = 0 },
					{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.06 },
				},
				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/MorriganEmoteCharging2" },
						{ Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/MorriganEmoteAttacking1" },
						{ Name = "/SFX/Player Sounds/MelDaggerKnifeThrowSwishGROUP" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmashShort",
						Brick = "/SFX/MetalStoneClangShort",
						Stone = "/SFX/MetalStoneClangShort",
						Organic = "/SFX/StabSplatterSmall",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponDaggerDash =
			{
				Sounds =
				{
					FireSounds =
					{
						{ Name = "/SFX/Player Sounds/MelDaggerKnifeThrowSwishGROUP" },
						{ Name = "/VO/MelinoeEmotes/MorriganEmoteAttacking1" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/DaggerImpactWoodHard",
						Brick = "/SFX/DaggerImpactWoodSoft",
						Stone = "/SFX/DaggerImpactWoodSoft",
						Robot = "/SFX/MetalStoneClangShort",
						Organic = "/SFX/DaggerImpactOrganic",
						StoneObstacle = "/SFX/SwordWallHitClankSmall",
						BrickObstacle = "/SFX/SwordWallHitClankSmall",
						MetalObstacle = "/SFX/SwordWallHitClankSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},

		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetBaseChargeTimes",
			Args = {
				WeaponNames = 
				{
					"WeaponDagger5",
					"WeaponDaggerThrow",
				}
			}
		},
		CustomExDefinitions = 
		{
			ProjectileDaggerThrow = false,
			ProjectileDaggerThrowMorrigan = true
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponDagger" },
			FunctionName = "ResetClipRegenTriggerLock",
			FunctionArgs = 
			{
				WeaponDagger = "WeaponDaggerDouble",
			},
		},
		DaggerAdditionalTargetData = 
		{
			AdditionalTargets = 2,
			Range = 850,
			Vfx = "DashStreakShortBlink",
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckFinisher",
			Args =
			{
				ProjectileName = "WomboStrike",
				DamageMultiplier = { BaseValue = 1 },
				ReportValues = { ReportedMultiplier = "DamageMultiplier" },
				EffectNames = { "ComboSpecialIndicator", "ComboExIndicator", "ComboAttackIndicator" }, -- for packaging
				CompleteObjectivesOnFire = { "WeaponDaggerWombo" },
			}
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperties = 
				{
					ChargeTime = 0.3,
					MinChargeToFire = 0.34,
					Cooldown = 1.5,
					ProjectileAngleOffset = 12,
					ChargeStartAnimation = "Melinoe_Dagger_Special_Start_Slow",
					ClipSize = 1,
					ClipRegenInterval = 0.8,
					LockTriggerForMinCharge = true,
				},
				ProjectileProperties = 
				{
					MaxAdjustRate = 0,
					ImmunityDuration = 0.20,
					RepeatHitOnReturn = true,
					MultiDetonate = true,
					MultipleUnitCollisions = true,
					ReturnToOwnerAfterInactiveSeconds = 0.6,
					Speed = 900,
					Graphic = "DaggerThrowMorrigan",
					Damage = 20,
				},
			},
			{
				WeaponName = "WeaponDagger",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					Projectile = "ProjectileDaggerSpinMorrigan",
					SwapOnFire = "WeaponDaggerDouble",
					FireFx = "null",
					ChargeTime = 0.10,
					ChargeStartAnimationUseCharge = false,
					ChargeStartAnimation = "Melinoe_Dagger_Morrigan_Attack1_Start",
					FireGraphic = "Melinoe_Dagger_Morrigan_Attack1_Fire",
					ChargeCancelGraphic = "Melinoe_Dagger_Morrigan_Attack1_End",
					BarrelLength = 60,
					NumProjectiles = 3,
					ProjectileInterval = 0.07,
					ProjectileIntervalStart = 0.07,
				},
				ProjectileProperties =
				{
					StartDelay = 0.02,
					Damage = 11,
				},
			},
			{
				WeaponName = "WeaponDaggerDash",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					Projectile = "ProjectileDaggerSpinMorrigan",
					SwapOnFire = "WeaponDaggerDouble",
					FireFx = "null",
					ChargeTime = 0.01,
					ChargeStartAnimationUseCharge = false,
					FireGraphic = "Melinoe_Dagger_Morrigan_AttackDash_Fire",
					ChargeCancelGraphic = "Melinoe_Dagger_Morrigan_AttackDash_End",
					BarrelLength = 60,
					NumProjectiles = 1,
					ProjectileInterval = 0.06,
				},
				ProjectileProperties =
				{
					StartDelay = 0.05,
				},
			},

			{
				WeaponName = "WeaponDaggerMultiStab",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					ControlWindow = 0.8,
					ChargeStartAnimation = "Melinoe_Dagger_Morrigan_AttackStabs_Start",
					FireGraphic = "Melinoe_Dagger_Morrigan_AttackStabs_Fire",
					ChargeCancelGraphic = "Melinoe_Dagger_Morrigan_AttackStabs_End",
					ChargeTime = 0.2,
					NumProjectiles = 3,
					ProjectileInterval = 0.12,
					ProjectileIntervalStart = 0.15,
				},
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					NumProjectiles = 3,
					ProjectileInterval = 0.04,
					ProjectileIntervalStart = 0.08,

					ChargeTime = 0.32,
					ChargeStartAnimation = "Melinoe_Dagger_Morrigan_AttackDouble_Start",
					FireGraphic = "Melinoe_Dagger_Morrigan_AttackDouble_Fire",
					ChargeCancelGraphic = "Melinoe_Dagger_Morrigan_AttackDouble_End",
					ClipRegenInterval = 0.05,
					
				},
				ProjectileName = "ProjectileDaggerSliceDouble",
				ProjectileProperties =
				{
					AttachToOwner = false,
					Range = 600,
					Speed = 600,
					Damage = 33,
					DetonateFx = "DaggerSwipeDouble_Morrigan_Combo"
				},
			},
			{
				WeaponName = "WeaponDagger5",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					Projectile = "ProjectileDaggerExecuteMorrigan",
					FireGraphic = "Melinoe_Dagger_Morrigan_BlinkAttack_Fire",
				},
				ProjectileProperties =
				{
					StartDelay = 0.02,
				},
			},
			{
				WeaponName = "WeaponDagger",
				ExcludeLinked = true,
				ProjectileProperty = "Damage",
				ChangeValue = 50,
			},
			{
				WeaponName = "WeaponDaggerDash",
				ExcludeLinked = true,
				EffectName = "SwingDashDisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 18/60,
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ExcludeLinked = true,
				EffectName = "DaggerSpecial1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 10/60,
			},
			{
				WeaponName = "WeaponDagger",
				ExcludeLinked = true,
				EffectName = "Swing1Disable",
				EffectProperty = "Duration",
				ChangeValue = 15/60,
			},
			{
				WeaponName = "WeaponDagger",
				ExcludeLinked = true,
				EffectName = "Swing1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 28/60,
			},
			{
				WeaponName = "WeaponDagger",
				ExcludeLinked = true,
				EffectName = "Swing1SelfSlowFire",
				EffectProperty = "Duration",
				ChangeValue = 12/60,
			},
			{
				WeaponName = "WeaponDaggerMultiStab",
				ExcludeLinked = true,
				ProjectileProperty = "Damage",
				ChangeValue = 30,
			},
			{
				WeaponName = "WeaponDaggerDouble",
				ExcludeLinked = true,
				ProjectileProperty = "Damage",
				ChangeValue = 40,
			},
		},
		StatLines = 
		{
			"ComboDamageStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "WomboStrike",
				BaseProperty = "Damage",
			},
		},
		FlavorText = "DaggerTripleAspect_FlavorText",
	},

	-- Lob
	LobAmmoBoostAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 7,
			},
		},
		Icon = "Hammer_Lob_13",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Mesh"
		},
	
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponLob", "WeaponLobPulse" },
			SourceWeapon = "WeaponLob",
			LinkedWeapon = "WeaponLobPulse",
			ExcludeLinked = true,
			MissingAmmoBaseDamageAddition = { BaseValue = 3 },
			ReportValues = { ReportedWeaponMultiplier = "MissingAmmoBaseDamageAddition"},
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveWeaponAmmoFire",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckWeaponAmmoFire",
		}, 
		StatLines =
		{
			"AmmoDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				IncludeSigns = true
			},
		},
		FlavorText = "LobAmmoBoostAspect_FlavorText",
	},
	LobCloseAttackAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Lob_14",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Medea_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Medea_Mesh"
		},
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
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3.0,
			},
			Perfect =
			{
				Multiplier = 4.5,
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponLobSpecial"},
			FunctionName = "CheckLobDetonate",
			FirstHitOnly = true,
			Args = 
			{
			}
		},
		AddOutgoingDamageModifiers =
		{
			NonExMultiplier =
			{
				BaseValue = 1.3,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "NonExMultiplier"},
		},
		OnWeaponChargeFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "ResetLobSpecialCooldown",
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponLob",
				WeaponProperties = 
				{
					ShowFreeAimLine = false,
					BarrelLength = 50,
					SelfVelocity = 0,
					ProjectileToArm = "ProjectileLob",

					SetCompleteAngleOnFire = false,
					ChargeTime = 0.10,
					ChargeStartAnimation = "Melinoe_Lob_Attack1_Start_Fast",
					FireGraphic = "Melinoe_Lob_Attack1_Fire_Fast",
				},
				ExcludeLinked = true,
				ProjectileName = "ProjectileLob",
				ProjectileProperties = 
				{
					Fuse = 3.0,
					LaunchAngle = 0,
					Range = 0,
					DamageRadius = 460,
					Gravity = 1500,
					SpinRate = 0,
					Type = "STRAIGHT",
					AttachToOwner = false,
					CheckObstacleImpact = false,
					AttachToMarker = "Melinoe_Rig:hand_00_R_JNT",
					IgnoreCancelAttachedProjectiles = true,
					RotateWithOwner = true,
					CheckUnitImpact = false,
					DetonateWhenArmed = true,
					ReportValues = { ReportedFuse = "Fuse"},
					GroupName = "FX_Standing_Add",
					AttachedAnim = "MedeaFuseBacking",
					Graphic = "MedeaFuseFx_Base",
					StartFx = "MedeaLoadFx_Base",
					SortMode = "Secondary"
				},
			},

			{
				WeaponName = "WeaponLob",
				EffectName = "Lob1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.15,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

		},
		WeaponDataOverride =
		{
			WeaponLob =
			{
				CoalesceDoubleDamageNumbersInterval = 0.1,
				OnProjectileDeathFunctionArgs = 
				{
					Cooldown = 0.75,
					CollideForces = 
					{
						UpwardForceMin = 630,
						UpwardForceMax = 650,
						ForceMin = 0,
						ForceMax = 0,
						Scatter = 0,
					},
					DropForces = 
					{
						UpwardForceMin = 535,
						UpwardForceMax = 545,
						ForceMin = 0,
						ForceMax = 0,
						Scatter = 0,
					},
				},
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelinoeSkullsChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},			
					FireSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/EmoteEvading" },
					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
						{ Name = "/SFX/Player Sounds/MelSkullsOmegaAttack" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/ArrowMetalBoneSmash",
						Brick = "/SFX/ArrowMetalStoneClang",
						Stone = "/SFX/ArrowMetalStoneClang",
						Organic = "/SFX/GunBulletOrganicImpact",
						StoneObstacle = "/SFX/ArrowWallHitClankSmall",
						BrickObstacle = "/SFX/ArrowWallHitClankSmall",
						MetalObstacle = "/SFX/ArrowWallHitClankSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
				
			}
		},
		
		SkipAutoLobMagnetism = true,
		StatLines =
		{
			"NonExDamageStatDisplay1",
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupMedeaAnimationSwaps",
		},
		
		OnUnequipFunctionName = "EndMedeaAnimationSwaps",
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		},
		FlavorText = "LobCloseAttackAspect_FlavorText",
	},
	LobImpulseAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		PreEquipWeapons = {"WeaponSkullImpulse"},
		Icon = "Hammer_Lob_15",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Persephone_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Persephone_Mesh"
		},
		Charge = 0,
		PropertyChanges = {
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Persephone",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Persephone",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Persephone",
				ChangeType = "Absolute",
			},	
		},
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
				Multiplier = 5/2,
			},
			Legendary =
			{
				Multiplier = 6/2,
			},
			Perfect =
			{
				Multiplier = 9/2,
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSkullImpulseUI",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponLobSpecial", "WeaponSkullImpulse"},
			FunctionName = "SkullImpulseTransform",
			FunctionArgs = 
			{
				BaseDuration = 0.5,			-- Duration of ex attack w/ no charge
				Interval = 200,
			}
		},
		MaxBonusBoonRankWeighted = 
		{
			BaseValue = 2,
		},
		MaxBonusBoonRankDistribution = 
		{
			[2] =
			{
				-- Weighted list, so all values should add up to 1 for best distribution
				-- Don't add entries for 1 because that's the same as 0 boon and causes 'level 1' to show up on boon menus
				[0] = 0.70,
				[2] = 0.30,
			},
			[3] = 
			{
				[0] = 0.65,
				[2] = 0.30,
				[3] = 0.05,
			},
			[4] = 
			{
				[0] = 0.60,
				[2] = 0.25,
				[3] = 0.10,
				[4] = 0.05,
			},
			[5] = 
			{
				[0] = 0.55,
				[2] = 0.20,
				[3] = 0.15,
				[4] = 0.10,
				[5] = 0.05,
			},
			[6] = 
			{
				[0] = 0.50,
				[2] = 0.16,
				[3] = 0.14,
				[4] = 0.12,
				[5] = 0.06,
				[6] = 0.02,
			},
			[9] = 
			{
				[0] = 0.28,
				[2] = 0.16,
				[3] = 0.14,
				[4] = 0.12,
				[5] = 0.10,
				[6] = 0.08,
				[7] = 0.06,
				[8] = 0.04,
				[9] = 0.02,
			}
		},
		OnEnemyDamagedAction = 
		{
			AllEffectsTrigger = true,
			FunctionName = "ChargeSkullImpulse",
			Args = 
			{
				-- One "charge" is equal to full one second of skull car
				-- 0.001 means 100 damage = 0.1 seconds of skull car charge
				ValidProjectiles = WeaponSets.OlympianProjectileNames,
				ValidEffectNames = WeaponSets.OlympianEffectNames,
				ChargePerDamage = 0.00100,
				MaxCharge = 2,
				MinChargeToFire = 0.5,
				ReportValues = 
				{
					ReportedMinChargeToFire = "MinChargeToFire",
					ReportedMaxCharge = "MaxCharge",
				}
			}
		},
		StatLines = 
		{
			"ExDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "MaxBonusBoonRankWeighted",
				ExtractAs = "BoonRank",
				IncludeSigns = true,
			},
			{
				Key = "ReportedMaxCharge",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedMinChargeToFire",
				ExtractAs = "MinCharge",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "LobImpulseAspect_FlavorText",
	},
	LobGunAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
			},
		},
		Icon = "Hammer_Lob_16",
		RarityLevels =
		{
			-- Chance the 130/140/150 number to be the percent increase at each rarity
			Common =
			{
				Multiplier = (1-(100/105))/0.5,
			},
			Rare =
			{
				Multiplier = (1-(100/110))/0.5,
			},
			Epic =
			{
				Multiplier = (1-(100/115))/0.5,
			},
			Heroic =
			{
				Multiplier = (1-(100/120))/0.5,
			},
			Legendary =
			{
				Multiplier = (1-(100/125))/0.5,
			},
			Perfect =
			{
				Multiplier = (1-(100/135))/0.5,
			},
		},
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Hel_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Hel_Mesh"
		},
		WeaponDataOverride = 
		{
			WeaponLob = 
			{
				HideChargeDuration = 1.6,
				ChannelSlowIneligible = true,
				ShowAmmoUI = false,
				OnProjectileDeathFunction = "nil",
				CustomManaIndicatorOffsetY = -210,
				CompleteObjectivesOnFire = { "WeaponLob_Hel" },
				CompleteObjectivesOnStagedFire = { "WeaponLobCharged_Hel" },
				ChargeWeaponStages = 
				{
					{
						ManaCost = 35,
						Wait = 3,
						ResetChargeOnFire = true,
						SkipManaSpendOnFire = true,
						WeaponProperties = 
						{
							Projectile = "ProjectileLobOverheat",
							FireGraphic = "Melinoe_Lob_Hel_AttackEx1_Fire",
							AdditionalProjectileWaveChance = 0,
						},
					},
				},

				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelinoeSkullsChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},			
					FireSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/EmoteAttackingBombLob" },
					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/HelEmoteSpecial2" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/ArrowMetalBoneSmash",
						Brick = "/SFX/ArrowMetalStoneClang",
						Stone = "/SFX/ArrowMetalStoneClang",
						Organic = "/SFX/GunBulletOrganicImpact",
						StoneObstacle = "/SFX/ArrowWallHitClankSmall",
						BrickObstacle = "/SFX/ArrowWallHitClankSmall",
						MetalObstacle = "/SFX/ArrowWallHitClankSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
			WeaponLobSpecial = 
			{
				ScaledFireEndEffects = {},
				CustomThrowEx = true,
				CompleteObjectivesOnNonStagedFire = { "WeaponLobSpecial_Hel" },
				HitSimSlowParameters = "nil",
				HitSimSlowCooldown = "nil",
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 50,
						Wait = 1.1,
						WeaponProperties = 
						{ 
							Projectile = "ProjectileLobGunRift",
							BlinkDetonateOnInterval = 0,
							BlinkDetonateAtOrigin = true,
							WeaponRange = 1,
							BlinkMaxRange = 1,
							BlinkSpeed = 3500,
							ShowFreeAimLine = true,
							AimLineDistanceOverride = 1200,
							UnblockedBlinkFx = "null",
							ProjectileAngleStartOffset = 0,
						},
						ChannelSlowEventOnStart = true,
						--DeferRevert = true,
						SkipManaSpendOnFire = true,
					},
				},

				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" ,
							StoppedBy = { "TriggerRelease" }
						},
						{
							Name = "/VO/MelinoeEmotes/AnubisEmoteCharging2" ,
							StoppedBy = { "TriggerRelease" }
						},
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
						},
						{ Name = "/SFX/Player Sounds/MelSkullsDash" },
						{
							Name = "/VO/MelinoeEmotes/HelEmoteAttacking2",
							Cooldown = 0.5
						},
					},
					FireStageSounds = 
					{
						{ Name = "/SFX/Player Sounds/MelSkullsOmegaSpecialFire" },
						{ Name = "/VO/MelinoeEmotes/HelEmoteSpecial2" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/FistImpactBig",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			}
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "ProjectileLobOverheat" },
			Name = "OnGunOverheatCreated",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "HandleGunBehavior",
			FunctionArgs = 
			{
				EffectName = "HelOverheat",
				EffectData = 
				{
					Modifier = { BaseValue = 0.5, SourceIsMultiplier = true, DecimalPlaces = 4,},
					Duration = 3,
					ReportValues = 
					{
						ReportedDuration = "Duration",
						ReportedSpeed = "Modifier",
					},
				},
				ExAttackApplyEffects = { "WeaponLobHelAttackEXDisable", "WeaponLobHelAttackEXDisableCancellable", },
					
				ClipSize = 3,
				ClipReload = 0.48,
				ClipRegenInterval = 0.48,
			}
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "HideGunUI"
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLob",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					Projectile = "ProjectileLobBullet",
					ChargeStartAnimation = "Melinoe_Lob_Hel_Attack1_Start",
					FireGraphic = "Melinoe_Lob_Hel_Attack1_Fire",
					ChargeCancelGraphic = "null",
					FullyAutomatic = true,
					FireOnRelease = false,
					UseAttackTurbo = false,
					SelfVelocity = 0,
					OnlyChargeOnce = true,
					BarrelLength = 0,
					ManualAiming = false,
					Cooldown = 0.1,
					AutoLockRange = 535,
					-- Clip Regen interrupts omega  attack, so this is done through HandleGunBehavior
				},
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperties = 
				{
					Projectile = "ProjectileLobSpecialBounce",
					BlinkDetonateOnInterval = 0,
					BlinkDetonateAtOrigin = true,
					BlinkDisableBehavior = true,
					ShowFreeAimLine = true,
					UnblockedBlinkFx = "null",
					ProjectileAngleStartOffset = 0,
					ChargeRangeMultiplier = 0,
					RemoveControlOnFire= "WeaponLobSpecial",
				},
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperties =
				{
					Graphic = "LobSpecialFx_Hel",
				},
			},

			{
				WeaponName = "WeaponLob",
				EffectName = "Lob1DisableMovement",
				EffectProperty = "Duration",
				ChangeValue = 0.49,
				ChangeType = "Absolute",
			},
		},
		UnlimitedAmmo = true,
		StatLines = 
		{
			"OverheatDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				CheckAutomaticPropertyChanges = true,
				Key = "ReportedDuration",
				ExtractAs = "OverheatDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedSpeed",
				ExtractAs = "AspectModifier",
				Format = "PercentReciprocalDelta",
			},
		},
		FlavorText = "LobGunAspect_FlavorText",
	},

	-- Torch
	TorchSpecialDurationAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 2,
			},
			Legendary =
			{
				Multiplier = 2.5,
			},
			Perfect =
			{
				Multiplier = 4,
			},
		},
		Icon = "Hammer_Torch_39",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponHecateMultiple_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Mesh"
		},
		AddOutgoingCritModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			Chance = { BaseValue = 0.04 },
			ReportValues = {ReportedChance = "Chance"}
		},
		StatLines =
		{
			"SpecialDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Bonus",
				Format = "LuckModifiedPercent",
			},
		},
		FlavorText = "TorchSpecialDurationAspect_FlavorText",
	},
	TorchSprintRecallAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
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
			Legendary =
			{
				Multiplier = 3.0,
			},
			Perfect =
			{
				Multiplier = 4.0,
			},
		},
		Icon = "Hammer_Torch_41",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Eos_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Eos_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Eos_Mesh"
		},
		WeaponDataOverride =
		{
			WeaponTorch = 
			{	
				HideChargeDuration = 0.75,
				BlockChargeStageModifiers = 
				{
					NumProjectileWaves = true,
				},
				ChargeWeaponStages = 
				{
					{ 
						Wait = 1.75, 
						ManaCost = 15, 
						WeaponProperties = 
						{ 
							Projectile = "ProjectileTorchBallEos",
							AdditionalProjectileWaveChance = 0,
						}, 
						RelativeWeaponProperties = 
						{
							Cooldown = { Value = 0.25/0.35, ChangeType = "Multiply" },
						},
						ResetChargeOnFire = false,
						ForceRelease = false,
						SkipManaSpendOnFire = true,
						CompleteObjective = "WeaponTorchCharged",
					},
				},
			},

			WeaponTorchSpecial = 
			{
				ChargeWeaponStages = 
				{
					{
						ManaCost = 25,
						Wait = 0.925,
						ChannelSlowEventOnStart = true,
						ForceRelease = true,
						WeaponProperties =
						{
							Projectile = "ProjectileTorchOrbitEx",
							NumProjectiles = 2,
							ProjectileAngleStartOffset = math.rad(-180),
							ProjectileAngleOffset = math.rad(180),
							FireGraphic = "Melinoe_Torch_Special1Ex_Fire",
							FireFx = "TorchOrbitStartSwirl_Eos",
							AdditionalProjectileWaveChance = 0,
						},
						ProjectileProperties = 
						{
							ArcEnd = -1080,
						},
						CompleteObjective = "WeaponTorchSpecialCharged",
					},
				},
			},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ExWeapons = true,
			HasSessionMapStateValue = "CurrentExProjectile",
			AddWeaponProperties = 
			{
				NumProjectiles = 2,
				ProjectileAngleOffset = math.rad(180),
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FunctionName = "HandleAttachRecord",
			FunctionArgs = 
			{
				Repeats = 5,
				StartInterval = 0.5,
				Interval = 2,
				ReportValues = 
				{ 
					ReportedFuse = "Interval" 
				},
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveAttachedExProjectiles",
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "ProjectileTorchRepeatStrike" },
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 25,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperties = 
				{
					MultiDetonate = true,
					TotalFuse = 1000,
					Speed = 186,
					MaxSpeed = 266,
					Acceleration = 54,
					DamageRadius = 200,
					BlastSpeed = 500,
					SpinFromOwnerVelocityMultiplier = 0,
					MaxAdjustRate = math.rad(90),
					CheckObstacleImpact = false,
					AllowRepeatedJumpHit = true,
				}
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ActiveProjectileCap2",
				ChangeValue = 4,
				ChangeType = "Absolute",
				ExcludeLinked = true
			},
			-- Attack
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Eos",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Eos",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Eos",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Eos",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			-- EX Attack
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "Graphic",
				ChangeValue = "EosProjectile_Base_In",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "EosProjectileShadow",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Eos",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			-- Special

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Eos",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Eos",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Eos",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Eos",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Eos",
				ChangeType = "Absolute",
			},
		},
		StatLines =
		{
			"PulsePowerStatDisplay1",
		},
		ReportedMaxPulses = 1,
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "Damage",
				Format = "AddToBase",
				BaseType = "Projectile",
				BaseName = "ProjectileTorchRepeatStrike",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Fuse",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		},
		FlavorText = "TorchSprintRecallAspect_FlavorText",
	},
	TorchDetonateAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.15,
			},
			Epic =
			{
				Multiplier = 1.30,
			},
			Heroic =
			{
				Multiplier = 1.45,
			},
			Legendary =
			{
				Multiplier = 1.60,
			},
			Perfect =
			{
				Multiplier = 2.05,
			},
		},
		Icon = "Hammer_Torch_40",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Moros_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Moros_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Moros_Mesh"
		},
		WeaponDataOverride = 
		{
			
			WeaponTorch =
			{
				ChargeWeaponStages = 
				{
					{
						SkipManaSpendOnFire = true,
						ManaCost = 5,
						Wait = 1.35,
						ResetChargeOnFire = true,
						WeaponProperties = 
						{
							Projectile = "ProjectileTorchGhostLarge",
							AdditionalProjectileWaveChance = 0,
						},
						CompleteObjective = "WeaponTorchCharged",
					},
				},
			}
		},
		StatLines = 
		{
			"DetonateDamageStatDisplay1",
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = 
			{
				"ProjectileTorchGhostExplosion",
				"ProjectileTorchGhostLargeExplosion",
			},
			ValidWeaponMultiplier = {BaseValue = 1 },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponTorch", },
				WeaponProperties = 
				{
					Projectile = "ProjectileTorchGhost",
				},
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchSpecialProjectileGroundGlow_Moros",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchSpecialProjectileDissipate_Moros",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchSpecialProjectileIn_Moros_Ex",
				ChangeType = "Absolute",
			},			
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckTorchDetonation",
			Args = 
			{
				ProjectileTorchGhost = "ProjectileTorchGhostExplosion",
				ProjectileTorchGhostLarge = "ProjectileTorchGhostLargeExplosion"
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipExplosionDamage",
				Format = "PercentDelta",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ProjectileTorchGhost",
				BaseProperty = "TotalFuse",
				ExtractAs = "TotalDuration",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "TorchDetonateAspect_FlavorText",
	},
	TorchAutofireAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect" },
			},
		},
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
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3.0,
			},
			Perfect =
			{
				Multiplier = 4.5,
			},
		},
		Icon = "Hammer_Torch_42",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Supay_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Supay_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Supay_Mesh"
		},
		OnUnequipFunctionName = "EndAutofire",
		WeaponDataOverride = 
		{
			WeaponTorch = 
			{
				
				ShowManaIndicator = true,
				HideChargeDuration = 0.25,
				SkipManaDisableCheck = true,
				CancelCameraShake = true,
				CancelSlowFrames = true,
				ChannelSlowIneligible = false,
				ChargeWeaponStages = 
				{
					{
						ManaCost = 25,
						Wait = 0.925,
						ChannelSlowEventOnStart = true,
						ForceRelease = true,
						CompleteObjective = "WeaponTorchCharged_Supay",
					},
				},
				SwapAnimations =
				{
					["MelinoeIdle"] = "Melinoe_Torch_Supay_Idle",
					["MelinoeDashStart"] = "Melinoe_Torch_Supay_Dash_Start",
					["MelinoeDash"] = "Melinoe_Torch_Supay_Dash_Fire",
					["MelinoeSprint"] = "Melinoe_Supay_Torch_Sprint_FireLoop",
					["MelinoeStart"] = "Melinoe_Torch_Supay_Run_Start",
					["MelinoeRun"] = "Melinoe_Torch_Supay_Run_FireLoop",
					["MelinoeStop"] = "Melinoe_Torch_Supay_Run_End",
					["MelinoeGetHit"] = "Melinoe_Torch_Supay_GetHit",
					["Melinoe_GetHit_LastStand"] = "Melinoe_Torch_Supay_GetHit_LastStand",

					["Melinoe_Cast_Start"] = "Melinoe_Torch_Supay_AttackEx1_Fire",
					["Melinoe_Cast_StartLoop"] = "Melinoe_Torch_Supay_AttackEx1_Fire",
					["Melinoe_Cast_Fire"] = "Melinoe_Torch_Supay_AttackEx1_Fire",
					["Melinoe_Cast_End"] = "Melinoe_Torch_Supay_AttackEx1_Fire",
					["Melinoe_Cast_Fire_Quick"] = "Melinoe_Torch_Supay_AttackEx1_Fire",

					--["Melinoe_CrossCast_Start"] = "Melinoe_Torch_Supay_AttackEx1_Fire",
					--["Melinoe_ForwardCast_Unequip"] = "Melinoe_Torch_ForwardCast_Unequip",

					["MelinoeEquip"] = "Melinoe_Torch_Supay_Equip",
					["MelinoeActionIdle"] = "Melinoe_Torch_Supay_Idle",
					["MelinoeInteract"] = "Melinoe_Torch_Supay_InteractUnequip",
					["MelinoeBoonPreInteract"] = "Melinoe_Torch_Supay_InteractUnequip",
				},

				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					FireSounds =
					{
						{ Name = "/SFX/Player Sounds/MelTorchFireBasic" },
					},
					FireStageSounds = 
					{
						{ Name = "/SFX/Player Sounds/MelTorchFireOmega" },
					},			
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/BurnDamageTorches",
						Brick = "/SFX/BurnDamageTorches",
						Stone = "/SFX/BurnDamageTorches",
						Organic = "/SFX/BurnDamageTorches",
						StoneObstacle = "/SFX/BurnDamageTorches",
						BrickObstacle = "/SFX/BurnDamageTorches",
						MetalObstacle = "/SFX/BurnDamageTorches",
						BushObstacle = "/SFX/BurnDamage",
						Shell = "/SFX/ShellImpact",
					},
				},

				--UnequipAnimation = "Melinoe_Torch_Unequip",
				--WeaponInteractAnimation = "Melinoe_Torch_Interact",
			},
			WeaponTorchSpecial = 
			{
				ChannelSlowIneligible = false,
				CancelCameraShake = true,
				CancelSlowFrames = true,
				ChargeStageModifiers = 
				{
					ValidWeapons = { "WeaponTorchSpecial"},
					ExcludeLinked = true,
					AddWeaponProperties = 
					{
						FireFx = "TorchOrbitStartSwirl_Supay",
					}
				},
				ChargeWeaponStages = 
				{
					{
						ManaCost = 30,
						Wait = 0.925,
						ChannelSlowEventOnStart = true,
						ForceRelease = true,
						WeaponProperties =
						{
							Projectile = "ProjectileTorchOrbitEx",
							ProjectileAngleStartOffset = math.rad(-90),
							ProjectileAngleOffset = math.rad(60),
							FireGraphic = "Melinoe_Torch_Special1Ex_Fire",
							FireFx = "TorchOrbitStartSwirl_Base",
							AdditionalProjectileWaveChance = 0,
						},
						ProjectileProperties = 
						{
							ArcEnd = -1080,
						},
						CompleteObjective = "WeaponTorchSpecialCharged",
					},
				},
				SkipManaDisableCheck = true,
				IsExWithMapStateVariable = "TorchExSpecial",

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/EmptyCue" },
						{
							Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					FireSounds =
					{
						{ Name = "/SFX/Player Sounds/MelTorchSpecialPreSpin" },

					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/EmoteAttackingBombLob" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/BurnDamageTorches",
						Brick = "/SFX/BurnDamageTorches",
						Stone = "/SFX/BurnDamageTorches",
						Organic = "/SFX/BurnDamageTorches",
						StoneObstacle = "/SFX/BurnDamageTorches",
						BrickObstacle = "/SFX/BurnDamageTorches",
						MetalObstacle = "/SFX/BurnDamageTorches",
						BushObstacle = "/SFX/BurnDamage",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
		},
		PropertyChanges =
		{
			{
				UnitProperty = "CosmeticRotationSpeed",
				ChangeValue = 8,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperties = 
				{
					AllowFire = false,
					ChargeStartAnimation = "Melinoe_Torch_Supay_AttackEx1_Fire",
					FireGraphic = "null",
					ChargeCancelGraphic = "Melinoe_Torch_Supay_AttackEx1_End",
					TriggerReleaseGraphic = "null",
					FullyAutomatic = true,
					ChargeTime = 0.35,
					Cooldown = 0.4,
					MinChargeToFire = 0,
					FireOnRelease = true,
					SetTargetAngleOnRequest = false,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ExcludeLinked = true,
				ProjectileProperties = 
				{
					InheritOwnerVelocityMultiplier = 0,
					SpinFromOwnerVelocityMultiplier = 0,
					ActiveBlinkSpeedMultiplier = 1,
					ActiveBlinkRangeMultiplier = 1,
					MaxAdjustRate = math.rad(90),
					Damage = 15,
					TotalFuse = 0.60
				},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ExcludeLinked = true,
				ProjectileProperties = 
				{
					Damage = 10,
					Speed = 220,
				},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Torch_Supay_AttackEx1_FireAlt",
					FireGraphic = "null",
					ChargeCancelGraphic = "Melinoe_Torch_Supay_AttackEx1_End",
					TriggerReleaseGraphic = "null",
					SetTargetAngleOnRequest = false,
				},
				ProjectileProperties = 
				{
					Fuse = 5,
					ReturnToOwnerAfterInactiveSeconds = 4,
					SizeDuration = 0.1,
					MaxSize = 1.4,
					MinRange = 150,
					Range = 300,
					MaxRange = 600,
					ArcEnd = 9000,
					Speed = 440,
					Damage = 15,
				},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "AllowFire",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "UseAttackTurbo",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchBallIn_Supay",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Supay",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchBallDissipate_Supay",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWave_Supay",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchBallGroundGlow_Supay",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ImpactFx",
				ChangeValue = "TorchImpactFx_Supay",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Supay",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileProperty = "AmbientSound",
				ChangeValue = "null",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx", },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Supay",
				ChangeType = "Absolute",
			},
		},
		SetupFunction =
		{
			Name = "SetupTorchAutofire",
			Args = 
			{
				PrimaryInterval = 0.75,
				BurstCount = 1,
				FlameStagger = 0.75,
				PrimaryExIntervalOverride = 0,	-- If set at above 0, overrides the stagger/interval with this value during EX moves
				PrimaryExIntervalMultiplier = 1.0,
				--PrimaryCastIntervalMultiplier = { BaseValue = 0.9, SourceIsMultiplier = true }, -- Might be worth revisiting
				PrimaryExInterval = 4,
				PrimaryExVfx = "SupayEXStart",
				SpecialRefreshInterval = 0.25,
				SpecialSounds = 
				{
					SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
					SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					AresSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					AphroditeSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					ApolloSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					DemeterSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					HephaestusSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					HestiaSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					HeraSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					PoseidonSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					ZeusSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
				},
				ReportValues = 
				{ 
					--ReportedSpeed = "PrimaryCastIntervalMultiplier",
					ReportedDuration = "PrimaryExInterval",
				}
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "UpdateProjectileLedger",
			ValidProjectiles = {"ProjectileTorchBall", "ProjectileTorchSupayBallEx", "ProjectileTorchOrbit", "ProjectileTorchOrbitEx", "ProjectileCast"},
		},
		AddOutgoingDamageModifiers =
		{
			ValidProjectiles = WeaponSets.SprintProjectileNames,
			ValidWeaponMultiplier =
			{
				BaseValue = 1.10,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"},
		},
		
		StatLines =
		{
			"RaiseDeadStatLine1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "SprintDamageBonus",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipAutofireDuration",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "TorchAutofireAspect_FlavorText",
	},

	-- Axe
	AxeRecoveryAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.17,
			},
			Heroic =
			{
				Multiplier = 1.34,
			},
			Legendary =
			{
				Multiplier = 1.67,
			},
			Perfect =
			{
				Multiplier = 2.00,
			},
		},
		Icon = "Hammer_Axe_40",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Mesh1",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Mesh1"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			NonExBaseDamageAddition = { BaseValue = 30 },
			ReportValues = 
			{ 
				ReportedDamage = "NonExBaseDamageAddition"
			},
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 30,
				ChangeType = "Add",
			},
		},
		StatLines =
		{
			"AxeDamageHealthStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				IncludeSigns = true,
			},
		},
		FlavorText = "AxeRecoveryAspect_FlavorText",
	},
	AxeArmCastAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Axe_41",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Charon_Mesh",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Charon_Mesh"
		},
		CastFlatFuseModifier = true,
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
			Legendary =
			{
				Multiplier = 3,
			},
			Perfect = 
			{
				Multiplier = 4.5,
			}
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
		AddOutgoingDamageModifiers =
		{
			ValidProjectileIdMultiplier =
			{
				BaseValue = 1.1,
				SourceIsMultiplier = true,
			},
			
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidProjectileIdMultiplier" 
			},
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "ProjectileAxeBlock2" },
			Name = "CheckAxeCastArm",
			Args = 
			{
				ProjectileName = "ProjectileAxeBlock2",
				BlastMultiplier = { BaseValue = 1.15, SourceIsMultiplier = true },
				Animation = "CharonAspectDetonateFx",
			},
		},
		StatLines = 
		{
			"AxeArmStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
		},
		FlavorText = "AxeArmCastAspect_FlavorText",
	},
	AxePerfectCriticalAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
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
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 1.75,
			},
			Legendary =
			{
				Multiplier = 2.0,
			},
			Perfect =
			{
				Multiplier = 2.75,
			},
		},
		Icon = "Hammer_Axe_42",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Thanatos_Mesh",
		WeaponDataOverride =
		{
			WeaponAxeSpin = 
			{
				HideChargeDuration = 0.1,
			},
		},	
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Thanatos_Mesh"
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			IsEx = true,
			HeroTraitValue = "PerfectCritChance",
		},
		PerfectCritChance = 0,
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupPerfectCritUI",
		},
		StopVfxOnUnequip = "ThanatosMaxMortalityFx",
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckPerfectAxeCrit",
			FirstHitOnly = true,
			Args = 
			{
				Increment = 0.02,
				MaxCrit = 0.20,
				ReportValues = 
				{
					ReportedIncrement = "Increment",
					ReportedMaxCrit = "MaxCrit",
				}
			}
		},
		OnSelfDamagedFunction = 
		{
			Name = "ResetPerfectAxeCrit",
			NotDamagingRetaliate = true,
		},
		PropertyChanges = 
		{
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1SelfSlowFire",
				EffectProperty = "Duration",
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				DeriveSource = "DeriveSource",
				ReportValues = 
				{
					ReportedSpeed = "ChangeValue"
				},
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1Disable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1DisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1MoveDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashDisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2Disable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2DisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				EffectName = "Swing3Disable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				EffectName = "Swing3DisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
		},
		StatLines = 
		{
			"AttackSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedIncrement",
				ExtractAs = "TooltipIncrement",
				Format = "Percent",
				DecimalPlaces = 1,
				SkipAutoExtract = true
			},
			{
				Key = "ReportedMaxCrit",
				ExtractAs = "TooltipMax",
				Format = "LuckModifiedPercent",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedSpeed",
				ExtractAs = "TooltipSpeedIncrease",
				Format = "NegativePercentDelta",
			},
		},
		FlavorText = "AxePerfectCriticalAspect_FlavorText",
	},
	AxeRallyAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect" },
			},
		},
		PreEquipWeapons = { "WeaponAxe4", "WeaponAxe5"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 18/21,
			},
			Epic =
			{
				Multiplier = 15/21,
			},
			Heroic =
			{
				Multiplier = 12/21,
			},
			Legendary =
			{
				Multiplier = 9/21,
			},
			Perfect =
			{
				Multiplier = 4/21,
			},
		},
		Icon = "Hammer_Axe_43",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Nergal_Mesh",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Nergal_Mesh"
		},
		WeaponDataOverride =
		{
			WeaponAxe =
			{
				FireScreenshake = { ScreenPreWait = 0.1, Distance = 14, Speed = 700, FalloffSpeed = 3000, Duration = 0.22, Angle = 90 },
				HitSimSlowParameters =
				{
					{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
					{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.03 },
				},
				
				BlockDashSwapIfCharging = true,

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteCharging1" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking1" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
			WeaponAxe2 =
			{
				FireScreenshake = { Distance = 7, Speed = 600, FalloffSpeed = 3000, Duration = 0.18, Angle = 90, ScreenPreWait = 0.1 },
				HitSimSlowParameters =
				{
					{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
					{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.03 },
				},

				Sounds =
				{
					ChargeSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/NergalEmoteCharging2" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking2" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
			WeaponAxe3 =
			{
				ChargeCameraMotion = "nil",
				FireScreenshake = { Distance = 7, Speed = 600, FalloffSpeed = 3000, Duration = 0.18, Angle = 90, ScreenPreWait = 0.1 },
				HitSimSlowParameters =
				{
					{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
					{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.03 },
				},

				Sounds =
				{
					ChargeSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/NergalEmoteCharging2" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking2" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponAxe4 =
			{
				Sounds =
				{
					ChargeSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/NergalEmoteCharging2" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking4" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponAxe5 =
			{
				Sounds =
				{
					ChargeSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/NergalEmoteCharging1" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking3" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
			WeaponAxeSpin = 
			{
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 10, 
						WeaponProperties = 
						{ 
							NumProjectiles = 1, 
							ProjectileBlastIncrement = 0.15, 
							ProjectileIntervalStart = 0.44, ProjectileInterval = 0.44 
						}, 
						ProjectileProperties = 
						{ 
							DamageMultiplier = 3,
						}, 
						Wait = 0.32, 
						ChannelSlowEventOnEnter = true, 
						HideStageReachedFx = true 
					},
					{ 
						ManaCost = 15, 
						WeaponProperties = 
						{
							NumProjectiles  = 3
						}, 
						ProjectileProperties = 
						{ 
							DamageMultiplier = 2 
						}, 
						Wait = 0.15, 
						HideStageReachedFx = true 
						},
					{ 
						ManaCost = 20, 
						WeaponProperties = 
						{ 
							NumProjectiles  = 5
						}, 
						ProjectileProperties = 
						{
							DamageMultiplier = 2 
						}, Wait = 0.15, 
					},
				},

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteChargingAxe" },
						{
							Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							Key = "SpearWeaponSpin",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
							SetPitchToPropertyValue = "ChargeTime",
						},
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteSpecial2" },
						{ Name = "/Leftovers/SFX/AuraThrow" }
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},

				},
			},
			WeaponAxeDash = 
			{
				FireScreenshake = { Distance = 11, Speed = 800, FalloffSpeed = 3000, Duration = 0.22, Angle = 90, ScreenPreWait = 0.15 },

				Sounds =
				{
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking3" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwingShort" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
			WeaponAxeSpecial =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteCharging1" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking4" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/DaggerImpactOrganic",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},

				},
			},

			WeaponAxeSpecialSwing =
			{
				CustomManaIndicatorOffsetY = -340,
				Sounds =
				{
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmashSHIELD",
						Brick = "/SFX/MetalStoneClangSHIELD",
						Stone = "/SFX/MetalStoneClangSHIELD",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
						BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
						MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
		},		
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxe",
				WeaponProperties = 
				{
					ChargeTime = 0.68,
					Projectile = "ProjectileAxeNergalSlow",
					ChargeStartAnimation = "Melinoe_Axe_Nergal_Attack1_Start",
					ChargeFx = "null",
					FireFx = "null",
					FireGraphic = "Melinoe_Axe_Nergal_Attack1_Fire",
					ChargeCancelGraphic = "Melinoe_Axe_Nergal_Attack1_Cancel",
					BarrelLength = 200,
					RootOwnerWhileFiring = false,
					BlockMoveInput = false,
					ChargeSelfVelocity = 0,
					ChargeStartAnimationUseCharge = true,
					ClipRegenInterval = 0.6,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperties = 
				{
					ControlWindow = 0.65,
					ChargeTime = 0.45,
					Projectile = "ProjectileAxeNergalFast",
					ChargeStartAnimation = "Melinoe_Axe_Nergal_Attack2_Start",
					ChargeFx = "null",
					FireFx = "null",
					FireGraphic = "Melinoe_Axe_Nergal_Attack2_Fire",
					ChargeCancelGraphic = "Melinoe_Axe_Nergal_Attack2_End",
					RootOwnerWhileFiring = true,
					BarrelLength = 200,
				},
				ExcludeLinked = true,
				ProjectileProperties =
				{
					StartDelay = 0.09,
				},
			},
			{
				WeaponName = "WeaponAxe3",
				WeaponProperties = 
				{
					ControlWindow = 0.55,
					ChargeTime = 0.45,
					Projectile = "ProjectileAxeNergalFast",
					ChargeStartAnimation = "Melinoe_Axe_Nergal_Attack3_Start",
					FireGraphic = "Melinoe_Axe_Nergal_Attack3_Fire",
					ChargeCancelGraphic = "Melinoe_Axe_Nergal_Attack3_End",
					SwapOnFire = "WeaponAxe4",
					RootOwnerWhileFiring = true,
					BarrelLength = 200,
				},
				ExcludeLinked = true,
				ProjectileProperties =
				{
					StartDelay = 0.09,
				},
			},
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperties = 
				{
					ChargeTime = 0.33,
					Projectile = "ProjectileAxeNergalFastDash",
					ChargeStartAnimation = "Melinoe_Axe_Nergal_AttackDash_Start",
					ChargeFx = "null",
					FireFx = "null",
					FireGraphic = "Melinoe_Axe_Nergal_AttackDash_Fire",
					ChargeCancelGraphic = "Melinoe_Axe_Nergal_AttackDash_Cancel",
					SwapOnFire = "WeaponAxe",
					BarrelLength = 200,
					RootOwnerWhileFiring = false,
					BlockMoveInput = false,
					ChargeSelfVelocity = 0
				},
				ExcludeLinked = true,
				ProjectileProperties =
				{
					StartDelay = 0.15,
				},
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashDisable",
				EffectProperty = "Duration",
				ChangeValue = 14/60,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashDisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 32/60,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashMoveDisable",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1SelfSlowFire",
				EffectProperty = "Duration",
				ChangeValue = 0.50,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1SelfSlowCharge",
				EffectProperty = "Modifier",
				ChangeValue = 1.04,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1Disable",
				EffectProperty = "Duration",
				ChangeValue = 0.24,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.34,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1MoveDisable",
				EffectProperty = "Duration",
				ChangeValue = 0.64,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2Disable",
				EffectProperty = "Duration",
				ChangeValue = 6/60,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 12/60,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2MoveDisable",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxe3", "WeaponAxe4" },
				EffectName = "Swing3Disable",
				EffectProperty = "Duration",
				ChangeValue = 6/60,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxe3", "WeaponAxe4" },
				EffectName = "Swing3DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 10/60,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileProperties = 
				{	
					DetonateSound = "/SFX/Player Sounds/MelinoeHugeAxeSwing",
				},
				WeaponProperties = 
				{
					FireGraphic = "Melinoe_Axe_AttackEx1_Fire_Slow", 
					FireEndGraphic = "Melinoe_Axe_AttackEx1_End", 
				}
			},
			{
				WeaponName = "WeaponAxeSpecial",
				WeaponProperties = 
				{
					NumProjectiles = 1,
					ChargeTime = 0.15,
					ChargeStartAnimation = "Melinoe_Axe_Nergal_Special_Start",
					FireGraphic = "Melinoe_Axe_Nergal_Special_Fire",
					FireFx = "null",

					RootOwnerWhileFiring = false,
					BlockMoveInput = false,
					CancelMovement = false,
					ChargeCancelMovement = false,
				},
				ProjectileProperties = 
				{
					Damage = 60,
					MultipleUnitCollisions = false,
					StartDelay = 0.12,
					StartFx = "AxeSwipeUpper",
				},
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisable",
				EffectProperty = "Duration",
				ChangeValue = 0.23,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisable",
				EffectProperty = "DisableMove",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisable",
				EffectProperty = "DisableRotate",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableCancelable",
				EffectProperty = "Duration",
				ChangeValue = 0.23,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableCancelable",
				EffectProperty = "DisableMove",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableCancelable",
				EffectProperty = "DisableRotate",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableMovementCancelable",
				EffectProperty = "DisableMove",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableMovementCancelable",
				EffectProperty = "DisableRotate",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AspectSlowCharge",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AspectSlowFire",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Axe_Nergal_SpecialEx_Start",
					FireGraphic = "Melinoe_Axe_Nergal_SpecialEx_Fire",
					ChargeCancelGraphic = "Melinoe_Axe_Nergal_SpecialEx_Cancel",
					BarrelLength = 70,
					ProjectileSpacing = 0,
					ProjectileInterval = 0.40,
					ProjectileBlastIncrement = 0.33,
					ChargeTime = 0.72,

					ChargeCancelMovement = false,
					BlockMoveInput = false,
					CancelMovement = false,
					RootOwnerWhileFiring = false,
				},
				ProjectileProperties = 
				{	
					DamageRadius = 460/1.4,
					Damage = 70,
					DetonateSound = "/SFX/Player Sounds/MelinoeAxeSwingFinisherNergal",
				},
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecialSwing" },
				EffectName = "BigDisable",
				EffectProperty = "Duration",
				ChangeValue = 0.66,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecialSwing" },
				EffectName = "BigDisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.88,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecialSwing" },
				EffectName = "BigSelfSlowCharge",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AspectSlowCharge2",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
		},
		
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupFrenzyUI",
		},

		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponAxe5" },
			FunctionName = "ResetClipRegenTriggerLock",
			FunctionArgs = 
			{
				WeaponAxe5 = "WeaponAxe",
			},
		},
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckFrenzyCount",
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FirstHitOnly = true,
			Args = 
			{ 
				RequiredCount = { BaseValue = 21 },
				EffectName = "Frenzy",
				DataProperties = 
				{
					Duration = 10,
					ReportValues = { ReportedDuration = "Duration"},
				},
				ReportValues = { ReportedCount = "RequiredCount"}
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = {"ProjectileAxeSpin"},
			SuccessiveProjectileMultiplier = 0.2,
		},
		AddOutgoingLifestealModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			Unmultiplied = true,
			RequiredEffect = "Frenzy",
			AddHeroTraitValue = "FrenzyLifestealBonus",
			ValidMultiplier = 0.01,
			MinLifesteal = 1,
			MaxLifesteal = 1,
			ReportValues = 
			{ 
				ReportedLifeStealAmount = "MinLifesteal",
			},
		},
		StatLines = 
		{
			"RallyHealthStatDisplay"
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
			{
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "Frenzy",
				BaseProperty = "BaseLifeSteal",
				ExtractAs = "FrenzyLifeStealAmount",
			},
			{
				ExtractAs = "FrenzyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "Frenzy",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "ReportedSpeed",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "Frenzy",
				Format = "PercentReciprocalDelta",
				BaseProperty = "Modifier",
			},
		},
		FlavorText = "AxeRallyAspect_FlavorText",
	},

	-- Suit
	BaseSuitAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Suit_01",
		RequiredWeapon = "WeaponSuit",
		WeaponKitGrannyModel = "WeaponSuitMultiple_Base_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Base_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Base_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Base_Mesh",
		},

		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			Value = 
			{
				BaseValue = 0.95,
				SourceIsMultiplier = true,
			},
		},
		PropertyChanges = 
		{
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.95,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
			},
			{
				UnitProperty = "Speed",
				BaseValue = 1.05,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedChange = "ChangeValue" }
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocity",
				BaseValue = 99,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 44.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
		},
		StatLines =
		{
			"MoveSprintAttackSpeedStatDisplay",
		},
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 0,
				MaxMultiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect = 
			{
				Multiplier = 7,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedChange",
				ExtractAs = "SpeedBonus",
				Format = "PercentDelta"
			},
		},
		FlavorText = "BaseSuitAspect_FlavorText",
	},
	SuitMarkCritAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		PreEquipWeapons = { "WeaponSprintEx" },
		Icon = "Hammer_Suit_03",
		RequiredWeapon = "WeaponSuit",
		WeaponKitGrannyModel = "WeaponSuitMultiple_Nyx_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Nyx_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Nyx_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Nyx_Mesh",
		},
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
			Legendary =
			{
				Multiplier = 5,
			},
			Perfect = 
			{
				Multiplier = 7,
			},
		},

		WeaponDataOverride =
		{
			WeaponSprint =
			{
				SkipManaIndicatorIfOutOfMana = true,
				OnChargeFunctionNames = { "DoWeaponCharge", },
				ChargeWeaponData =
				{
					OnStageReachedFunctionName = "SprintChargeStage",
					EmptyChargeFunctionName = "EmptySprintCharge",
				},
				ShowManaIndicator = true,
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 30,
						SkipManaSpendOnFire = true,
						Wait = 1.0,
						WeaponName = "WeaponSprintEx",
						EffectName = "NyxBlastReady",
						ReportValues = 
						{
							ReportedChargeDuration = "Wait",
							ReportedCost = "ManaCost",
						},
					},
				},
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponSprint"},
			FunctionName = "CheckSprintCollision",
			FunctionArgs = 
			{
				Range = 165,
			}
		},
		SprintStrikeDamageMultiplier = 1,
		OnProjectileDeathFunction = 
		{
			Name = "CheckProjectileSpawn",
			ValidProjectiles = {"ProjectileSuit", "ProjectileSuit2", "ProjectileSuitRangedGuided" },
			Args = 
			{
				UseOriginalProjectileForPropertyChanges = true,
				IgnoreImpactId = true,
				MatchProjectileName = true,
				SpawnCount = 2,
				SpawnArc = 60,
				Alpha = 0.3,
				RetargetChance = 0,	-- Chance split missiles can hit the same target
				ProjectileOffsets = 
				{
					ProjectileSuit = 200,
					ProjectileSuit2 = 250,
					--ProjectileSuitCharged = 300,
				},
				ProjectileVfx = 
				{
					ProjectileSuitRangedGuided = "NyxMissileSpawner",
					--ProjectileSuitRangedCharged = "NyxMissileSpawner",
				},
				ProjectileNameMap = 
				{
					ProjectileSuitRangedGuided = "ProjectileSuitRangedGuidedSplit",
					--ProjectileSuitRangedCharged = "ProjectileSuitRangedChargedSplit",
					ProjectileSuit = "ProjectileSuitSplit",
					ProjectileSuit2 = "ProjectileSuitSplit2",
					--ProjectileSuitCharged = "ProjectileSuitChargedSplit",
				},
				DamageMultiplier = { BaseValue = 0.15 },
				ReportValues = 
				{ 
					ReportedCount = "SpawnCount",
					ReportedMultiplier = "DamageMultiplier" 
				}
			}
		},
		OnEnemyDamagedAction = 
		{
			FunctionName = "SplitSelfBuff",
			ValidProjectiles = { "NyxSprintBlast" },
			Args = 
			{
				EffectName = "NyxHitBuff",
				Duration = 5,
				ReportValues = 
				{
					ReportedDuration = "Duration",
				}
			},
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = {"ProjectileSuitRangedUnguided", "ProjectileSuit", "ProjectileSuit2", --[["ProjectileSuitCharged", "ProjectileSuitRangedChargedUnguided"]] },
			Name = "CheckSplitValidity",
			Args = 
			{
				RequiredEffect = "NyxHitBuff",
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSuitUI",
		},
		StatLines =
		{
			"SplitDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "SplitDamage",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedCount",
				ExtractAs = "AspectSplitCount",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedChargeDuration",
				ExtractAs = "ChargeDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCost",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "SprintStrikeDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "NyxSprintBlast",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "SuitMarkCritAspect_FlavorText",
	},
	SuitHexAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Suit_02",
		RequiredWeapon = "WeaponSuit",
		WeaponKitGrannyModel = "WeaponSuitMultiple_Selene_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Selene_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Selene_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Selene_Mesh",
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect = 
			{
				Multiplier = 6,
			},
		},
		LinkedSpell = "MoonBeam",
		StatLines =
		{
			"SuitSpellCostStatLine",
		},
		TalentPointCount = 2,	-- First Selene drop will give 1, so this boosts it to 3 on first pick-up baseline
		ManaSpendCostModifiers = 
		{
			Add = { BaseValue = -10 },
			ReportValues = { ReportedManaCost = "Add" }
		},
		ExtractValues =
		{
			{
				Format = "AdjustedBaseManaSpendCost",
				WeaponName = "WeaponSpellMoonBeam",
				ExtractAs = "ManaCost",
				Key = "ReportedManaCost",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseProperty = "FiredFunctionArgs",
				BaseName = "WeaponSpellMoonBeam",
				FiredFunctionArg = "Count",
				ExtractAs = "MoonBeamCount",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ProjectileMoonBeam",
				BaseProperty = "Damage",
				ExtractAs = "MoonBeamDamage",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Modifier",
				Format = "PercentDelta",
				ExtractAs = "MoonBeamVulnerability",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Duration",
				ExtractAs = "MoonBeamDuration",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "SuitHexAspect_FlavorText",
	},
	SuitComboAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		Icon = "Hammer_Suit_16",
		RequiredWeapon = "WeaponSuit",
		WeaponKitGrannyModel = "WeaponSuitMultiple_Shiva_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Shiva_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Shiva_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Shiva_Mesh",
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
			Legendary =
			{
				Multiplier = 3
			},
			Perfect =
			{
				Multiplier = 4
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSuitUI",
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponSuitCharged"},
			ExcludeLinked = true,
			AddScaledWeaponProperties = 
			{
				SelfVelocity = { Base = 800, Scale = 30 },
				SelfVelocityCap = { Base = 800, Scale = 30 },
			},
			AddProperty = 
			{
				ForceRelease = "null",
			},
			AddProjectileProperties = 
			{
				AttachToOwner = true,
			}
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponSuitCharged"},
			ValidSuitProjectile = true,
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckSelfBuffBlast",
			ValidProjectiles = { "ProjectileSuitBomb", "ProjectileSuitBombStraight" },
			Args = 
			{
				NumBounces = 2,
				EffectName = "ShivaAttackBoost",
			},
		},
		WeaponDataOverride = 
		{
			WeaponSuit = 
			{
				Sounds =
				{
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/ShivaEmoteAttacking1" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/FistImpactBig",
						Brick = "/SFX/FistImpactBig",
						Stone = "/SFX/FistImpactBig",
						Organic = "/SFX/FistImpactBig",
						StoneObstacle = "/SFX/FistImpactSmall",
						BrickObstacle = "/SFX/FistImpactSmall",
						MetalObstacle = "/SFX/FistImpactSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},

			WeaponSuitDouble =
			{
				Sounds =
				{
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/SupayEmoteAttacking2" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/FistImpactBig",
						Brick = "/SFX/FistImpactBig",
						Stone = "/SFX/FistImpactBig",
						Organic = "/SFX/FistImpactBig",
						StoneObstacle = "/SFX/FistImpactSmall",
						BrickObstacle = "/SFX/FistImpactSmall",
						MetalObstacle = "/SFX/FistImpactSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},

			WeaponSuitDash =
			{
				Sounds =
				{
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/ShivaEmotePowergAttacking1" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/FistImpactBig",
						Brick = "/SFX/FistImpactBig",
						Stone = "/SFX/FistImpactBig",
						Organic = "/SFX/FistImpactBig",
						StoneObstacle = "/SFX/FistImpactSmall",
						BrickObstacle = "/SFX/FistImpactSmall",
						MetalObstacle = "/SFX/FistImpactSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},

			WeaponSuitCharged =
			{
				Sounds =
				{		
					ChargeSounds =
					{
						{
							Name = "/VO/MelinoeEmotes/ShivaEmoteCharging1" ,
							Key = "SpearWeaponSpin",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
							SetPitchToPropertyValue = "ChargeTime",
						},
					},
					MaxStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/ShivaEmotePowergAttacking2" },
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
						},
						{ Name = "/VO/MelinoeEmotes/ShivaEmotePowergAttacking1" },
						-- handled in Suit_Attacks_Animation
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			},

			WeaponSuitRanged = 
			{
				DisableSeek = true,
				SkipFunctionFire = true,
				OnChargeFunctionNames = { "DoWeaponCharge" },
				OnProjectileDeathFunction = "nil",
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelShivaChargingLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},	
					ChargeStageSounds =
					{
						{
							Name = "/VO/MelinoeEmotes/ShivaEmoteCharging2",
							StoppedBy = { "ChargeCancel", "Fired", }
						}
					},
					FireSounds =
					{
						{ Name = "/SFX/Player Sounds/MelinoeSuitShivaSpecial" },
						{ Name = "/VO/MelinoeEmotes/ShivaEmoteSpecial1" },
					},
					FireStageSounds = 
					{
						{ Name = "/SFX/Player Sounds/MelinoeSuitShivaOmegaSpecial" },
						{ Name = "/VO/MelinoeEmotes/ShivaEmoteAttacking3" },
					},
				},
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 45,
						Wait = 0.35,
						EarlyPropertySwaps = 
						{
							Delay = 0.2,
							SwapProperties = 
							{
								WeaponProperties =
								{
									TargetReticleAnimation = "ShivaReticle",
									AutoLock = false,
									ManualAiming = true,
      								ShowFreeAimLine = true,
									WeaponRange = 505,
									AutoLockRange = 900,
									AutoLockArcDistance = 120,
									ManualAimingInitialOffset = 540,
								},
							},
						},
						WeaponProperties = 
						{ 
							NumProjectiles = 1,
							Projectile = "ProjectileSuitBomb",
      						SelfVelocity = 0,
							AdditionalProjectileWaveChance = 0,
						},
						CompleteObjective = "WeaponSuitRangedCharged_Shiva",
						ChannelSlowEventOnStart = true
					},
				},
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuit",
				WeaponProperties = 
				{
					ChargeTime = 0.04,
					SelfVelocity = 0,
				},
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit",
				ExcludeLinked = true,
				EffectName = "SuitAttack1Disable",
				EffectProperty = "Duration",
				ChangeValue = 4/60,
			},
			{
				WeaponName = "WeaponSuit",
				ExcludeLinked = true,
				EffectName = "SuitAttack1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 8/60,
			},

			{
				WeaponName = "WeaponSuit2",
				WeaponProperties = 
				{
					ChargeTime = 0.08,
					ControlWindow = 0.25,
					SelfVelocity = 0,
					SwapOnFire = "WeaponSuitDouble"
				},
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSuit2",
				ExcludeLinked = true,
				EffectName = "SuitAttack2Disable",
				EffectProperty = "Duration",
				ChangeValue = 6/60,
			},
			{
				WeaponName = "WeaponSuit2",
				ExcludeLinked = true,
				EffectName = "SuitAttack2DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 12/60,
			},

			{
				WeaponName = "WeaponSuitRanged",
				WeaponProperties = 
				{
					Projectile = "ProjectileSuitGrenade",
					ChargeStartAnimation = "Melinoe_Suit_Shiva_SpecialMissile_Start",
					FireGraphic = "Melinoe_Suit_Shiva_SpecialMissile_Fire",
					ChargeCancelGraphic = "Melinoe_Suit_Shiva_SpecialMissile_End",
					NumProjectiles = 1,
					Spread = 0,
					LockTriggerForMinCharge = true,
					Cooldown = 0.6,
					ClipSize = 1,
					ChargeTime = 0.1,
					ClipRegenInterval = 0.4,
					AcceptTriggerLockRequests = true,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					PriorityFireRequest = true,
					ShowFreeAimLine = true,
					AimLineWidthOverride = 200,
					AimLineAnimation = "AuraAimLineShield",
				},
				ProjectileProperties = 
				{
					StartDelay = 0,		
					Fuse = 0.45,
				}
			},

			{
				WeaponName = "WeaponSuitDash",
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Suit_AttackDash_StartSlow",
					FireGraphic = "Melinoe_Suit_AttackDash_FireSlow",
					ChargeTime = 0.22,
					NumProjectiles = 1,
				},
				ProjectileProperties =
				{
					Damage = 55,
					DamageRadius = 455,
				},
				ExcludeLinked = true,
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSuitCharged", "WeaponSuitRanged" },
			FunctionName = "CheckSuitComboAttackBuff",
			FunctionArgs = 
			{
				EffectName = "ShivaAttackBoost",
				SelfEffectStackMultiplier = 0.50,
				SelfEffectMaxStacks = { BaseValue = 2 },
				ReportValues = 
				{
					ReportedMaxStacks = "SelfEffectMaxStacks",
					ReportedStackMultiplier = "SelfEffectStackMultiplier",
				}
			}
		},
		OnUnequipFunctionName = "EndShivaBuff",
		StatLines = 
		{
			"ExecuteThresholdStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMaxStacks",
				ExtractAs = "StackCount",
			},
			{
				Key = "ReportedStackMultiplier",
				ExtractAs = "ExecuteBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},

		},
		FlavorText = "SuitComboAspect_FlavorText",
	},
}

OverwriteTableKeys( TraitData, TraitSetData.Aspects )