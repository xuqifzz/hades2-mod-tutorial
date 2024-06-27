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
					[2] = { LinkTo = { 3 }},
					[4] = { LinkTo = { 3 }},
					[5] = { LinkTo = { 5 }, GridOffsetX = -0.5 },
					[3] = { GridOffsetY = -2, GridOffsetX = -1.5 },
					[6] = { GridOffsetY = -1, GridOffsetX = -1.5 },
				},
				[4] = 
				{
					[1] = { Pool = { Keystone = 1 }, GridOffsetX = -0.5 },
					[3] = { LinkTo = { 2, 4 }},
					[5] = { Pool = { Keystone = 1}, GridOffsetX = -0.5 },
				},
				[5] = 
				{
					[2] = { LinkTo = {3} },
					[4] = { LinkTo = {3} },
				},
				[6] = 
				{
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
					[2] = { LinkTo = { 3 }, GridOffsetY = 0.5 },
					[3] = { LinkTo = { 3 }, GridOffsetY = 0.5 },
					[4] = { LinkTo = { 4 }, GridOffsetY = 0.5 },
				},
				[3] = 
				{
					[2] = { LinkTo = { 2 }},
					[3] = { Pool = { Keystone = 1} },
					[4] = { LinkTo = { 3 }},
				},
				[4] = 
				{
					[2] = { LinkTo = { 1, 3 }, GridOffsetY = 0.5 },
					[3] = { LinkTo = { 3, 5 }, GridOffsetY = 0.5 },
				},
				[5] = 
				{
					[1] = { Pool = { Keystone = 1 }},
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
					[3] = { Pool = { Keystone = 1 }},
					[4] = { LinkTo = { 4 }},
					[5] = { Pool = { Keystone = 1 }, LinkTo = { 5, 6 }, GridOffsetX = -1 },
				},
				[5] = 
				{
					[1] = { GridOffsetX = -3 },
					[3] = { GridOffsetX = -1, GridOffsetY = -2 },
					[2] = { LinkTo = { 2 }, GridOffsetX = -0.35 },
					[4] = { LinkTo = { 4 }, GridOffsetX = -0.35 },
					[5] = { GridOffsetX = - 3 },
					[6] = { GridOffsetX = - 1, GridOffsetY = -1 },
				},
				[6] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetX = -0.7 },
					[4] = { LinkTo = { 4 }, GridOffsetX = -0.7 },
				},
				[7] = 
				{
					[2] = { Pool = { Legendary = 1 }, GridOffsetX = -1 },
					[4] = { Pool = { Legendary = 1 }, GridOffsetX = -1},
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
					[2] = { LinkTo = { 0, 1, 2, 3 }, GridOffsetY = -0.5 },
					[4] = { LinkTo = { 3, 4, 5, 6 }, GridOffsetY = 0.5 },
				},
				[3] = 
				{
					[0] = { LinkTo = { 2 }, GridOffsetY = 0.5, },
					[1] = { LinkTo = { 2 }, GridOffsetY = 1.5, },
					[2] = { Pool = { Keystone = 1 }, GridOffsetY = -0.5},
					[3] = { LinkTo = { 3 }, GridOffsetX = -1, },
					[4] = { Pool = { Keystone = 1 }, GridOffsetY = 0.5},
					[5] = { LinkTo = { 4 }, GridOffsetY = -1.5, },
					[6] = { LinkTo = { 4 }, GridOffsetY = -0.5, },
				},
				[4] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetY = -0.5 },
					[3] = { Pool =  { Keystone = 1 }, GridOffsetX = - 3 },
					[4] = { LinkTo = { 4 }, GridOffsetY = 0.5 },
				},
				[5] = 
				{
					[2] = { LinkTo = { 2 }, GridOffsetY = -0.5 },
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
	SpellTraitOrdering = 
	{
		"SpellTimeSlowTrait",
		"SpellPolymorphTrait",
		"SpellLaserTrait",
		"SpellLeapTrait",
		"SpellPotionTrait",
		"SpellSummonTrait",
		"SpellMeteorTrait",
		"SpellTransformTrait",
	}
}

SpellData = 
{
	Debug = 
	{
		Skip = true,
	},
	Polymorph = 
	{
		Objective = "SpellPolymorphPrompt",
		TraitName = "SpellPolymorphTrait",
		Talents = 
		{
			Repeatable = 
			{
				"CooldownDamageTalent",
				--"MinorManaDiscountTalent",
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
				"MeteorInvulnerableChargeTalent",
				"MeteorVulnerabilityDecalTalent",
				"MeteorSlowDecalTalent",
				"MeteorShowerTalent",
			},
			Legendary = 
			{
				"MeteorDoubleTalent",
				"MeteorExCastTalent",
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
				"TransformBossDamageTalent",
				"TransformDurationTalent",
				"TransformDamageTalent",
				"TransformCooldownDodgeTalent",
				"ChargeRegenTalent",
			},
			Unique = 
			{
				"TransformCastDamageTalent",
				"TransformLastStandRechargeTalent",
				"TransformSpecialCritTalent",
				"TransformAttackSpeedTalent",
			},
			Legendary = 
			{
				"TransformPrimaryTalent",
				"TransformSpecialTalent",
				"TransformExCastTalent",
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
				--"MinorManaDiscountTalent",
				"ChargeRegenTalent",
				"LeapDamageTalent",
				"LeapArmorDamageTalent",
				"LeapCooldownSpeedTalent",
			},
			Unique = 
			{
				"LeapLaunchAoETalent",
				"LeapAoETalent",
				"LeapShieldTalent",
				"LeapCritTalent",
			},
			Legendary = 
			{
				"LeapTwiceTalent",
				"LeapSprintTalent",
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
				--"MinorManaDiscountTalent",
				"ChargeRegenTalent",
				"LaserDamageTalent",
				"LaserDefenseTalent",
			},
			Unique = 
			{
				"LaserPrimaryTalent",
				"LaserAoETalent",
				"LaserPenetrationTalent",
				"LaserDurationTalent",
			},
			Legendary = 
			{
				"LaserTripleTalent",
				"LaserCrystalTalent",
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
		Talents = 
		{
			Repeatable = 
			{
				"CooldownDamageTalent",
				--"MinorManaDiscountTalent",
				"ChargeRegenTalent",
				"PreChargeTalent",
				"SummonDamageTalent",
			},
			Unique = 
			{
				"SummonSpeedTalent",
				"SummonTeleportTalent",
				"SummonDamageSplitTalent",
				"SummonPermanenceTalent",
				"SummonRetaliateTalent"
			},
			Legendary = 
			{
				"SummonExplodeTalent",
				"SummonSpecialTalent",
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
				--"SpellChargeBonusTalent",
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
			},
		}
	},
}