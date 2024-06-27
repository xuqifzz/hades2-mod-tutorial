
SurfaceShopData = 
{
	DelayMin = 1,
	DelayMax = 5,
	ImpatienceMultiplier = 2.0, -- Total multiplier you pay of the base cost to get it delivered immediately.
	DelayPriceDiscount = 
	{
		[1] = 0.8,
		[2] = 0.7,
		[3] = 0.6,
		[4] = 0.5,
		[5] = 0.4,
		[6] = 0.3,
	}
}
StoreData =
{
	RoomShop =
	{
		MaxOffers = 3,
		HealingOffers =
		{
			Min = 1,
			Max = 1,
			WeightedList =
			{
				{
					Name = "DamageSelfDrop",
					Type = "Consumable",
					Weight = 0.2,
				},
				{
					Name = "HealDropRange",
					Type = "Consumable",
					Weight = 2,
				},
				{
					Name = "EmptyMaxHealthShopItem",
					Type = "Consumable",
					Weight = 0.2,
				},
				{
					Name = "FirstHitHealTrait",
					Type = "Trait",
					Weight = 1,
				},
				{
					Name = "TemporaryDoorHealTrait",
					Type = "Trait",
					Weight = 1,
				},
				{
					Name = "TemporaryHealExpirationTrait",
					Type = "Trait",
					Weight = 1,
				},
				{					
					Name = "LastStandShopItem",
					Type = "Consumable",
					Weight = 2,
				},
			}
		},
		Traits =
		{
			"TemporaryImprovedSecondaryTrait",
			"TemporaryImprovedCastTrait",
			"TemporaryMoveSpeedTrait",
			"TemporaryBoonRarityTrait",
			"TemporaryImprovedExTrait",
			"TemporaryImprovedDefenseTrait",
			"TemporaryDiscountTrait",
			"TemporaryForcedSecretDoorTrait",
			"ExtendedShopTrait",
		},
		Consumables =
		{
			"MetaCurrencyRange",
			"MetaCardPointsCommonRange",
			"MemPointsCommonRange",
			"SeedMysteryRange",
			"RandomStoreItem",
		},
	},
	SurfaceShop = 
	{
		GroupsOf = 
		{
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "BlindBoxLoot", ReplaceRequirements = { NamedRequirements = { "BlindBoxLootRequirements" }, } },
					--{ Name = "RandomLoot", Weight = 5 },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "MetaCardPointsCommonDrop", Weight = 1.0 },
					{ Name = "MetaCurrencyDrop", Weight = 0.50 },
					{ Name = "MemPointsCommonDrop", Weight = 0.75 },
					{ Name = "GiftDrop", Weight = 0.25, ReplaceRequirements = { NamedRequirements = { "GiftDropLootRequirements" }, } },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ 
						Name = "WeaponUpgradeDrop",
						ReplaceRequirements = 
						{ 
							NamedRequirements = { "HammerLootRequirements" },
						},
					},
					{ Name = "ShopHermesUpgrade", },
					{ Name = "MaxHealthDrop", },
					{ Name = "MaxManaDrop", },
					{ 
						Name = "TalentDrop",
						ReplaceRequirements = 
						{
							NamedRequirements = { "TalentLegal", },
						}
					},
				},
			},
		}
	},
	WorldShop =
	{
		GroupsOf = 
		{
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "RandomLoot", Weight = 5 },
					{ Name = "BlindBoxLoot", },
					{ Name = "ShopHermesUpgrade", },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ 
						Name = "WeaponUpgradeDrop", Weight = 2.5,
						ReplaceRequirements = 
						{ 
							NamedRequirements = { "HammerLootRequirements" },
						},
					},
					{ 
						Name = "WeaponUpgradeDrop", Weight = 2.5,
						ReplaceRequirements = 
						{ 
							NamedRequirements = { "LateHammerLootRequirements" },
						},
					},
					-- Healing
					{ Name = "RoomRewardHealDrop", Weight = 2.5 },
					{ Name = "MaxHealthDrop", Weight = 1.5 },
					{ Name = "ArmorBoost", Weight = 1.0 },
					--{ Name = "HitShieldDrop", Weight = 0.50 },

					-- Metas
					{ Name = "MetaCardPointsCommonDrop", Weight = 1.0 },
					{ Name = "MemPointsCommonDrop", Weight = 0.75 },
					{ Name = "MetaCurrencyDrop", Weight = 0.50 },
					{ Name = "GiftDrop", Weight = 0.25, ReplaceRequirements = { NamedRequirements = { "GiftDropLootRequirements" }, } },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "MaxManaDrop", },
					{ Name = "StackUpgrade", Cost = 100, ReplaceRequirements = { NamedRequirements = { "StackUpgradeLegal" }, } },
					{ Name = "StoreRewardRandomStack", Cost = 50, ReplaceRequirements = { NamedRequirements = { "StackUpgradeLegal" }, } },
					{
						Name = "SpellDrop", 
						ReplaceRequirements = 
						{
							{
								PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
							},
							{
								PathFalse = { "CurrentRun", "HubRewardLookup", "SpellDrop" },
							},
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
							},
						}
					},
					{
						Name = "TalentDrop",
						ReplaceRequirements =
						{
							NamedRequirements = { "TalentLegal", },
							{
								Path = { "CurrentRun", "ClearedBiomes" },
								Comparison = ">",
								Value = 1,
							},
							{
								PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
							},
						},
					},
				},
			},

		}
	},
	I_WorldShop =
	{
		GroupsOf =
		{

			{
				Offers = 1,
				OptionsData =
				{
					{ Name = "BoostedRandomLoot", },
					{ Name = "StackUpgradeBig", Cost = 300, },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "RandomLoot", Weight = 3.0 },
					{ Name = "BlindBoxLoot", Weight = 1.0 },
					{ Name = "MaxHealthDrop", Weight = 0.3 },
					{ Name = "MaxManaDrop", Weight = 0.3 },
					{ Name = "StackUpgrade", Weight = 0.3, Cost = 100, },
					{ Name = "TalentDrop", Weight = 0.3 },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "HealBigDrop", Weight = 1.0 },
					{ Name = "ArmorBigBoost", Weight = 0.75 },
					--{ Name = "HitShieldBigDrop", Weight = 0.50 },
					{ Name = "LastStandDrop", Weight = 0.50, Cost = 200 },
				},
			},
			{
				Offers = 1,
				OptionsData =
				{
					{ Name = "ShopHermesUpgrade", Cost = 500, UpgradeChance = 1.0, UpgradedCost = 500, ReplaceRequirements = { RequiredTextLines = {  "HermesFirstPickUp" },}},
					{ Name = "ChaosWeaponUpgrade", Cost = 650 },
					{ Name = "BoostedRandomLoot", },
					{ Name = "MaxHealthDropBig" },
					{ Name = "MaxManaDropBig" },
				},
			},
			{
				Offers = 1,
				OptionsData =
				{
					{
						Name = "WeaponPointsRareDrop",
						Cost = 1300,
						ReplaceRequirements =
						{
							{
								PathTrue = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
							}
						},
					},
					{
						Name = "CardUpgradePointsDrop",
						Cost = 1000,
						ReplaceRequirements =
						{
							{
								PathTrue = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
							}
						},
					},
					{ Name = "CharonPointsDrop",
						ReplaceRequirements =
						{
							{
								PathTrue = { "GameState", "LifetimeResourcesGained", "CharonPoints" },
							}
						},
					},

				},
			},
		}
	},
	D_WorldShop =
	{
		GroupsOf =
		{
			{
				Offers = 2,
				Options =
				{
					"MaxHealthDrop",
					"RandomLoot",
					"RandomLoot",
				},
			},
			{
				Offers = 2,
				Options =
				{
					"BoostedRandomLoot",
				},
			},
			{
				Offers = 1,
				OptionsData =
				{
					{ Name = "ShopHermesUpgrade", Cost = 500, UpgradeChance = 1.0, UpgradedCost = 500, ReplaceRequirements = { RequiredTextLines = {  "HermesFirstPickUp" },}},
					{ Name = "ChaosWeaponUpgrade", Cost = 650 },
					--{ Name = "WeaponUpgradeDrop", Cost = 650, SkipRequirements = true },
				},
			}
		}
	},
}

-- Well of Charon
ScreenData.WellShop =
{
	Components = {},
	TraitTrayArgs = 
	{
		IgnoreHideMoney = true,
	},
	FreezePlayerArgs =
	{
		DisableTray = false,
	},			
	BlockPause = true,
	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton
	CloseAnimationName = "WellShopOut",

	GamepadNavigation =
	{
		FreeFormSelectWrapY = true,
		FreeFormSelecSearchFromId = 0,
		FreeFormSelectStepDistance = 10,
	},

	ShopItemStartX = ScreenCenterX,
	ShopItemSpacerX = 820,
	ShopItemStartY = 300,
	ShopItemSpacerY = 240,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		
		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_UI",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.15, 0.15, 0.15, 0.85}
		},

		ShopBackground = 
		{
			AnimationName = "WellShopIn",
			GroupName = "Combat_Menu_Backing", 
			OffsetX = 0, 
			OffsetY = 190,
			ScaleX = 1.3,
			ScaleY = 1.3,
			Children = 
			{
				--[[
				ShopTitle = 
				{
					Text = "WellShop_Title",
					TextArgs =  
					{
						FontSize = 32, 
						OffsetX = 0, 
						OffsetY = -445, 
						Color = Color.White, 
						Font = "SpectralSCLightTitling", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 3}, 
						Justification = "Center" 
					}
				},
				]]--

				ShopSubtitle = 
				{
					Text = "Store_Hint",
					TextArgs =  
					{
						FontSize = 18, 
						OffsetX = 0, 
						OffsetY = 380, 
						Width = 840, 
						Color = Color.Gray, 
						Font = "LatoMedium", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 2}, 
						Justification = "Center",
					}
				},

				ShopFlavor = 
				{
					GroupName = "Combat_Menu_Overlay",
					Text = "Store_Hint",
					TextArgs =  
					{
						FontSize = 22,
						OffsetY = -385, Width = 840,
						Color = {0.698, 0.702, 0.514, 1.0},
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = "Center",
						Scale = 0,
					}
				},
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
			UseScreenScaleX = true,
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"TraitTrayButton",
				"SelectButton",
				"RerollButton",
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_Buy",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
				
				RerollButton =
				{
					Graphic = "ContextualActionButton",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "AttemptPanelReroll",
						ControlHotkeys = { "Reroll", },
					},
					Text = " ",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
				CloseButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseStoreScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
				TraitTrayButton = 
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "UpgradeChoiceScreenOpenTraitTray",
						ControlHotkeys = { "AdvancedTooltip", },
					},
					Text = "Menu_OpenTraitTray",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	}
}

-- Shrine of Hermes
ScreenData.SurfaceShop = 
{
	Components = {},

	OpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
	CloseSound = "/Leftovers/Menu Sounds/InfoPanelOutURSA",

	BlockPause = true,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = true,
		FreeFormSelecSearchFromId = 0,
		FreeFormSelectStepDistance = 10,
	},

	ShopItemStartX = ScreenCenterX,
	ShopItemSpacerX = 820,
	ShopItemStartY = 300,
	ShopItemSpacerY = 240,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_UI",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.15, 0.15, 0.15, 0.85}
		},

		ShopBackground = 
		{
			Children = 
			{
				--[[
				ShopTitle = 
				{
					GroupName = "Combat_Menu_Overlay",
					Text = "SurfaceShop_Title",
					TextArgs =  
					{
						FontSize = 32, 
						OffsetX = 0, 
						OffsetY = -445, 
						Color = Color.White, 
						Font = "SpectralSCLightTitling", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 3}, 
						Justification = "Center" 
					}
				},
				]]--

				ShopSubtitle = 
				{
					GroupName = "Combat_Menu_Overlay",
					Text = "Store_Hint",
					TextArgs =  
					{
						FontSize = 18, 
						OffsetX = 0, 
						OffsetY = 380, 
						Width = 840, 
						Color = Color.Gray, 
						Font = "LatoMedium", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 2}, 
						Justification = "Center" 
					}
				},

				ShopFlavor = 
				{
					GroupName = "Combat_Menu_Overlay",
					Text = "Store_Hint",
					TextArgs =  
					{
						FontSize = 22,
						OffsetY = -385, Width = 840,
						Color = {0.698, 0.702, 0.514, 1.0},
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = "Center",
						Scale = 0,
					}
				},
			},
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight - 200,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"SelectButton",
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_Buy",
					AltText = "Menu_Rush",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseSurfaceShopScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	}
}
