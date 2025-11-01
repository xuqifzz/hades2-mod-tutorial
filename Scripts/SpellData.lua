SpellTalentData = 
{
	InitialBonuses = 
	{
		[1] = 
		{
			BonusPoints = 0,
			Animation = "MoonPhase6",
			Text = "SpellNoTalentBonus",
		},
		[2] = 
		{
			BonusPoints = 1,
			Animation = "MoonPhase7",
			Text = "SpellMidTalentBonus",
		},
		[3] = 
		{
			BonusPoints = 2,
			Animation = "MoonPhase1",
			Text = "SpellHiTalentBonus",
		}
	},
	MinTalents = 3,
	MaxTalents = 6,
	MaxTalentsPerDepth = 3,
	MaxDepth = 3,
	DeadEndChance = 0.2,	-- chance for a first column talent to link to no additional talents.
	MaxPreReqs = 2,			--
	DuoChance = 1,		-- If eligible, the chance a duo will be served
	ServeDuoGameRequirements = 
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SeleneGrantsOlympianDuos01" },
		},
	},
	--DuplicateChance = 0.1,
	TalentTreeStructures = 
	{
		Lung = 
		{
			Structure = 
			{
				[1] = 
				{
					[2] = { LinkTo = { 2 }},
					[4] = { LinkTo = { 4 }},
				},
				[2] = 
				{
					[2] = { LinkTo = { 1 , 2 , 3 }},
					[4] = { LinkTo = { 4, 5, 6 }},
				},
				[3] = 
				{
					[1] = { LinkTo = { 1 }, GridOffsetX = -0.5 },
					[2] = { LinkTo = { 3 }, GridOffsetY = 0.25},
					[4] = { LinkTo = { 3 }, GridOffsetY = -0.25},
					[5] = { LinkTo = { 5 }, GridOffsetX = -0.5 },
					[3] = { GridOffsetY = -2, GridOffsetX = -1.5 },
					[6] = { GridOffsetY = -1, GridOffsetX = -1.5 },
				},
				[4] = 
				{
					[1] = { Pool = { Keystone = 1 }, GridOffsetX = -0.5 },
					[3] = { LinkTo = { 2, 3, 4 }},
					[5] = { Pool = { Keystone = 1}, GridOffsetX = -0.5 },
				},
				[5] = 
				{
					[2] = { LinkTo = {3}, GridOffsetY = -0.25},
					[3] = { Pool = { OlympianSpell = 1 }, LinkTo = {1}, GridOffsetX = -0.25 },
					[4] = { LinkTo = {3}, GridOffsetY = 0.25 },
				},
				[6] = 
				{
					[1] = { Pool = { OlympianCount = 1 }, GridOffsetY = 2, GridOffsetX = -0.65},
					[3] = { Pool = { Legendary = 1 }}
				}
			},
		},
		Pyramid = 
		{
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "UseRecord", "TalentDrop" }
				}
			},
			Structure = 
			{
				[1] = 
				{
					[1] = { LinkTo = { 1 }},
					[2] = { LinkTo = { 1, 2 }},
					[3] = { LinkTo = { 2, 3}},
					[4] = { LinkTo = { 3, 4 }},
					[5] = { LinkTo = { 4 }},
				},
				[2] = 
				{
					[1] = { LinkTo = { 2 }, GridOffsetY = 0.5 },
					[2] = { LinkTo = { 3 }, GridOffsetY = 0.5, GridOffsetX = -0.25 },
					[3] = { LinkTo = { 3 }, GridOffsetY = 0.5, GridOffsetX = -0.25 },
					[4] = { LinkTo = { 4 }, GridOffsetY = 0.5 },
				},
				[3] = 
				{
					[2] = { LinkTo = { 2 }},
					[3] = { Pool = { Keystone = 1}, GridOffsetX = -0.5, LinkTo = {3} },
					[4] = { LinkTo = { 4 }},
				},
				[4] = 
				{
					[2] = { LinkTo = { 1, 3 }, GridOffsetY = 0 },
					[3] = { Pool = { OlympianSpell = 1 } , LinkTo = { 2 }, GridOffsetX = - 0.75 },
					[4] = { LinkTo = { 3, 5 }, GridOffsetY = 0 },
				},
				[5] = 
				{
					[1] = { Pool = { Keystone = 1 }},
					[2] = { Pool = {OlympianCount = 1 }, GridOffsetY = 1, GridOffsetX = -1 },
					[3] = { LinkTo = { 3 }, },
					[5] = { Pool = { Keystone = 1 }},
				},
				[6] = 
				{
					[3] = { Pool = { Legendary = 1 }},
				},
			}
		},
		Maze = 
		{
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "UseRecord", "TalentDrop" }
				}
			},
			Structure = 
			{
				[1] = 
				{
					[3] = { LinkTo = { 2, 3, 4 }},
				},
				[2] = 
				{
					[2] = { LinkTo = { 2 }},
					[3] = { LinkTo = { 3 }},
					[4] = { LinkTo = { 4 }},
				},
				[3] = 
				{
					[2] = { LinkTo = { 1, 2 }},
					[3] = { LinkTo = { 3 }},
					[4] = { LinkTo = { 4, 5 }},
				},
				[4] = 
				{
					[1] = { Pool = { Keystone = 1 }, LinkTo = { 1, 3 }, GridOffsetX = -1 },
					[2] = { LinkTo = { 2 }},
					[3] = { Pool = { Keystone = 1 }, LinkTo = { 7 }},
					[4] = { LinkTo = { 4 }},
					[5] = { Pool = { Keystone = 1 }, LinkTo = { 5, 6 }, GridOffsetX = -1 },
				},
				[5] = 
				{
					[1] = { GridOffsetX = -3 },
					[3] = { GridOffsetX = -1, GridOffsetY = -2 },
					[2] = { LinkTo = { 2 }, GridOffsetX = -0.35, GridOffsetY = -0.5 },
					[4] = { LinkTo = { 4 }, GridOffsetX = -0.35, GridOffsetY = 0.5 },
					[5] = { GridOffsetX = - 3 },
					[6] = { GridOffsetX = - 1, GridOffsetY = -1 },
					[7] = { Pool = { OlympianSpell = 1 }, GridOffsetY = -4, LinkTo = { 3 } }
				},
				[6] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetX = -0.7, GridOffsetY = -0.5 },
					[3] = { Pool = {OlympianCount = 1 }},
					[4] = { LinkTo = { 4 }, GridOffsetX = -0.7, GridOffsetY = 0.5 },
				},
				[7] = 
				{
					[2] = { Pool = { Legendary = 1 }, GridOffsetX = -1, GridOffsetY = -0.5 },
					[4] = { Pool = { Legendary = 1 }, GridOffsetX = -1, GridOffsetY = 0.5},
				},
			}
		},
		
		Nacelle = 
		{ 
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "UseRecord", "TalentDrop" }
				}
			},
			Structure = 
			{
				OffsetY = 15,
				[1] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetY = -0.5 },
					[4] = { LinkTo = { 4 }, GridOffsetY = 0.5 },
				},
				[2] = 
				{
					[2] = { LinkTo = { 0, 1, 2, 3 }, GridOffsetY = -0.5, Bidirectional = true },
					[4] = { LinkTo = { 3, 4, 5, 6 }, GridOffsetY = 0.5, Bidirectional = true },
				},
				[3] = 
				{
					[0] = { LinkTo = { 2 }, GridOffsetY = 0.5, },
					[1] = { LinkTo = { 2, 5}, GridOffsetY = 1.5, },
					[2] = { Pool = { Keystone = 1 }, GridOffsetY = -0.5},
					[3] = { LinkTo = { 3 }, GridOffsetX = -1, },
					[4] = { Pool = { Keystone = 1 }, GridOffsetY = 0.5},
					[5] = { LinkTo = { 4, 5}, GridOffsetY = -1.5, },
					[6] = { LinkTo = { 4 }, GridOffsetY = -0.5, },
				},
				[4] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetY = -0.5 },
					[3] = { Pool =  { Keystone = 1 }, GridOffsetX = - 3 },
					[4] = { LinkTo = { 4 }, GridOffsetY = 0.5 },
					[5] = { Pool = {OlympianSpell = 1 }, LinkTo = { 3 }, GridOffsetY = -2 }
				},
				[5] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetY = -0.5 },
					[3] = { Pool = {OlympianCount = 1 }},
					[4] = { LinkTo = { 4 }, GridOffsetY = 0.5 },
				},
				[6] = 
				{
					[2] = { Pool = { Legendary = 1 }, GridOffsetY = -0.5 },
					[4] = { Pool = { Legendary = 1 }, GridOffsetY = 0.5 },
				},
			}
		},
	}
}
SpellChargeData = 
{
	EnemySpellChargeRadius = 950,
	EnemySpellChargeYScale = 0.5,
}

SpellDisplayData = 
{
	TraitSortOrder =
	{
		-- spells
		"SpellTimeSlowTrait",
		"SpellPolymorphTrait",
		"SpellLaserTrait",
		"SpellLeapTrait",
		"SpellPotionTrait",
		"SpellSummonTrait",
		"SpellMeteorTrait",
		"SpellTransformTrait",
		"SpellMoonBeamTrait",

		-- shared talents
		"CooldownDamageTalent",
		"ChargeRegenTalent",
		"PreChargeTalent",

		-- TimeSlow
		"TimeSlowAmountTalent",
		"CooldownDefenseTalent",

		"TimeSlowDestroyProjectilesTalent",
		"TimeSlowSpeedTalent",
		"TimeSlowLastStandRechargeTalent",
		"TimeSlowCumulativeBuffTalent",

		"TimeSlowCritTalent",
		"TimeSlowFreezeTimeTalent",
		"TimeSlowDemeterTalent",

		-- Polymorph
		"PolymorphDurationTalent",
		"PolymorphDamageTalent",

		"PolymorphBossDamageTalent",
		"PolymorphDeathExplodeTalent",
		"PolymorphTauntTalent",
		"PolymorphTeleportCastTalent",
		"PolymorphHealthCrushTalent",

		"PolymorphSandwichTalent",
		"PolymorphCurseTalent",
		"PolymorphZeusTalent",

		-- Laser
		"LaserDamageTalent",
		"LaserDefenseTalent",

		"LaserAoETalent",
		"LaserStartAoETalent",
		"LaserPenetrationTalent",
		"LaserDurationTalent",
		"LaserFirstHitDamageTalent",

		"LaserTripleTalent",
		"LaserCrystalTalent",
		"LaserApolloTalent",

		-- Leap
		"LeapDamageTalent",
		"LeapArmorDamageTalent",
		"LeapCooldownSpeedTalent",

		"LeapLaunchAoETalent",
		"LeapAoETalent",
		"LeapCritTalent",
		"LeapSprintTalent",

		"LeapShieldTalent",
		"LeapTwiceTalent",
		"LeapHephaestusTalent",

		-- Potion
		"PotionManaRestoreTalent",
		"PotionUsesTalent",
		"HealAmountTalent",
		"CurrencyUseTalent",

		"DamageBuffTalent",
		"ShieldTalent",
		"RolloverUsesTalent",
		"HealLastTalent",

		"ClearCastTalent",
		"HealRetaliateTalent",
		"PotionExCastTalent",
		"PotionPoseidonTalent",

		-- Summon
		"SummonDamageTalent",

		"SummonSpeedTalent",
		"SummonTeleportTalent",
		"SummonPermanenceTalent",
		"SummonRetaliateTalent",

		"SummonDamageSplitTalent",
		"SummonExplodeTalent",
		"SummonHeraTalent",

		-- Meteor
		"MeteorSizeTalent",
		"MeteorDamageTalent",

		"MeteorVulnerabilityDecalTalent",
		"MeteorSlowDecalTalent",
		"MeteorShowerTalent",
		"MeteorChargeTalent",

		"MeteorInvulnerableChargeTalent",
		"MeteorDoubleTalent",
		"MeteorExCastTalent",
		"MeteorHestiaTalent",

		-- Transform
		"TransformDurationTalent",
		"TransformDamageTalent",
		"TransformCooldownDodgeTalent",

		"TransformCastDamageTalent",
		"TransformLastStandRechargeTalent",
		"TransformSpecialCritTalent",
		"TransformAttackSpeedTalent",

		"TransformPrimaryTalent",
		"TransformSpecialTalent",
		"TransformExCastTalent",
		"TransformAphroditeTalent",

		-- Moonbeam
		"MoonBeamVulnerabilityTalent",
		"MoonBeamDamageTalent",
		"MoonBeamCountTalent",

		"MoonBeamConsecutiveDamageTalent",
		"MoonBeamDefenseTalent",
		"MoonBeamPrimaryTalent",

		"MoonBeamTargetTalent",
		"MoonBeamExBeamBonusTalent",
		"MoonBeamAresTalent",

		-- special talent
		"OlympianSpellCountTalent",
	},
}

SpellData = 
{
	Polymorph = 
	{
		Objective = "SpellPolymorphPrompt",
		TraitName = "SpellPolymorphTrait",
		Talents = 
		{
			Repeatable = 
			{
				"CooldownDamageTalent",
				"ChargeRegenTalent",
				"PolymorphDurationTalent",
				"PolymorphDamageTalent",
			},
			Unique = 
			{
				"PolymorphBossDamageTalent",
				"PolymorphDeathExplodeTalent",
				"PolymorphTauntTalent",
				"PolymorphTeleportCastTalent",
				"PolymorphHealthCrushTalent",
			},
			Legendary = 
			{
				"PolymorphSandwichTalent",
				"PolymorphCurseTalent",
				"PolymorphZeusTalent",
			},
		}
	},
	Meteor = 
	{
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp", },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SeleneFirstPickUp", },
			},
		},
		Objective = "SpellMeteorPrompt",
		TraitName = "SpellMeteorTrait",
		Talents = 
		{
			Repeatable = 
			{
				"CooldownDamageTalent",
				--"ManaDiscountTalent",
				"PreChargeTalent",
				"MeteorSizeTalent",
				"MeteorDamageTalent",
			},
			Unique = 
			{
				"MeteorVulnerabilityDecalTalent",
				"MeteorSlowDecalTalent",
				"MeteorShowerTalent",
				"MeteorChargeTalent",
			},
			Legendary = 
			{
				"MeteorInvulnerableChargeTalent",
				"MeteorDoubleTalent",
				"MeteorExCastTalent",
				"MeteorHestiaTalent",
			}
		}
	},
	Transform = 
	{
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp", },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SeleneFirstPickUp", },
			},
		},
		Objective = "SpellTransformPrompt",
		TraitName = "SpellTransformTrait",
		Talents = 
		{
			Repeatable = 
			{
				"TransformDurationTalent",
				"TransformDamageTalent",
				"TransformCooldownDodgeTalent",
				"ChargeRegenTalent",
			},
			Unique = 
			{
				"TransformCastDamageTalent",
				"TransformLastStandRechargeTalent",
				"TransformAttackSpeedTalent",
				"TransformSpecialTalent",
			},
			Legendary = 
			{
				"TransformPrimaryTalent",
				"TransformSpecialCritTalent",
				"TransformExCastTalent",
				"TransformAphroditeTalent",
			}
		}
	},

	Leap = 
	{
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp", },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SeleneFirstPickUp", },
			},
		},
		Objective = "SpellLeapPrompt",
		TraitName = "SpellLeapTrait",
		Talents = 
		{
			Repeatable = 
			{
				"ChargeRegenTalent",
				"LeapDamageTalent",
				"LeapArmorDamageTalent",
				"LeapCooldownSpeedTalent",
			},
			Unique = 
			{
				"LeapLaunchAoETalent",
				"LeapAoETalent",
				"LeapCritTalent",
				"LeapSprintTalent",
			},
			Legendary = 
			{
				"LeapShieldTalent",
				"LeapTwiceTalent",
				"LeapHephaestusTalent",
			}
		}
	},
	
	Laser = 
	{
		Objective = "SpellLaserPrompt",
		TraitName = "SpellLaserTrait",
		Talents = 
		{
			Repeatable = 
			{
				"CooldownDamageTalent",
				"ChargeRegenTalent",
				"LaserDamageTalent",
				"LaserDefenseTalent",
			},
			Unique = 
			{
				"LaserAoETalent",
				"LaserStartAoETalent",
				"LaserPenetrationTalent",
				"LaserDurationTalent",
				"LaserFirstHitDamageTalent",
			},
			Legendary = 
			{
				"LaserTripleTalent",
				"LaserCrystalTalent",
				"LaserApolloTalent"
			}
		}
	},
	Summon = 
	{
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp", },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SeleneFirstPickUp", },
			},
		},
		Objective = "SpellSummonPrompt",
		TraitName = "SpellSummonTrait",
		CheckSpellReadyOnAcquire = true,		-- Summon has additional requirements so cannot use the same 'insta-ready' presentation
		Talents = 
		{
			Repeatable = 
			{
				"CooldownDamageTalent",
				"ChargeRegenTalent",
				"PreChargeTalent",
				"SummonDamageTalent",
			},
			Unique = 
			{
				"SummonSpeedTalent",
				"SummonTeleportTalent",
				"SummonPermanenceTalent",
				"SummonRetaliateTalent"
			},
			Legendary = 
			{
				"SummonHeraTalent",
				"SummonDamageSplitTalent",
				"SummonExplodeTalent",
			}
		}
	},
	TimeSlow = 
	{
		Objective = "SpellTimeSlowPrompt",
		TraitName = "SpellTimeSlowTrait",
		Talents = 
		{
			Repeatable = 
			{
				--"ManaDiscountTalent",
				"PreChargeTalent",
				"ChargeRegenTalent",
				"TimeSlowAmountTalent",
				"CooldownDefenseTalent",
			},
			Unique = 
			{
				"TimeSlowDestroyProjectilesTalent",
				"TimeSlowSpeedTalent",
				"TimeSlowLastStandRechargeTalent",
				"TimeSlowCumulativeBuffTalent",
			},
			Legendary = 
			{
				"TimeSlowCritTalent",
				"TimeSlowFreezeTimeTalent",
				"TimeSlowDemeterTalent",
			}
		}
	},
	Potion = 
	{
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp",  },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SeleneFirstPickUp", },
			},
		},
		Objective = "SpellPotionPrompt",
		TraitName = "SpellPotionTrait",
		Talents = 
		{
			Repeatable = 
			{
				"PotionManaRestoreTalent",			
				"PotionUsesTalent",
				"HealAmountTalent",
				"CurrencyUseTalent",
			},
			Unique = 
			{
				"DamageBuffTalent",
				"ShieldTalent",
				"RolloverUsesTalent",
				"HealLastTalent",
			},
			Legendary = 
			{
				"ClearCastTalent",
				"HealRetaliateTalent",
				"PotionExCastTalent",
				"PotionPoseidonTalent",
			},
		}
	},
	MoonBeam = 
	{
		GameStateRequirements = 
		{
			Skip = true
		},
		--Objective = "SpellPotionPrompt",
		TraitName = "SpellMoonBeamTrait",
		Talents = 
		{
			Repeatable = 
			{
				"ChargeRegenTalent",
				"MoonBeamVulnerabilityTalent",
				"MoonBeamDamageTalent",
				"MoonBeamCountTalent",
			},
			Unique = 
			{
				"MoonBeamConsecutiveDamageTalent",
				"MoonBeamDefenseTalent",
				"MoonBeamPrimaryTalent",
			},
			Legendary = 
			{
				"MoonBeamAresTalent",
				"MoonBeamTargetTalent",
				"MoonBeamExBeamBonusTalent",
			},
		}
	},
}