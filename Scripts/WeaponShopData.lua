WeaponShopItemData =
{
	-- Base Weapons

	WeaponStaffSwing =
	{
		Icon = "Hammer_Staff_39",
		Cost =
		{
			--
		},
		PreRevealVoiceLines =
		{
			--
		},
		FlavorText = "WeaponStaffSwing_FlavorText",
	},
	
	WeaponDagger =
	{
		Icon = "Hammer_Daggers_38",
		Cost =
		{
			OreFSilver = 1,
		},
		OnActivateFunctionName = "ActivateWeaponKit",
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_0239", Text = "Join with me.", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_0729", Text = "Lim and Oros, Sister Blades. We're fellow sisters now.", PreLineWait = 0.8 },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
		FlavorText = "WeaponDagger_FlavorText",
		-- PostActivationHoldDuration = 3.0,
	},
	
	WeaponTorch =
	{
		Icon = "Hammer_Torch_39",
		Cost =
		{
			OreFSilver = 3,
			MixerFBoss = 3,
		},
		OnActivateFunctionName = "ActivateWeaponKit",
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_0178", Text = "Now...", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_3034", Text = "Ygnium, the Umbral Flames. Incinerate my foes and light my path.", PreLineWait = 0.8 },
				-- { Cue = "/VO/Melinoe_0735", Text = "Ygnium, Flames of Hecate! Burn my enemies, and light my way.", PreLineWait = 0.8 },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
		FlavorText = "WeaponTorch_FlavorText",
	},
	
	WeaponAxe =
	{
		Icon = "Hammer_Axe_40",
		Cost =
		{
			OreFSilver = 15,
		},
		OnActivateFunctionName = "ActivateWeaponKit",
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_0118", Text = "All right.", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_3031", Text = "Zorephet, the Moonstone Axe. You can split anything apart.", PreLineWait = 0.8 },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
		FlavorText = "WeaponAxe_FlavorText",
	},
	
	WeaponLob =
	{
		Icon = "Hammer_Lob_13",
		Cost =
		{
			OreNBronze = 1,
			OreHGlassrock = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = { "WeaponDagger", "WeaponTorch", "WeaponAxe" },
			}
		},
		OnActivateFunctionName = "ActivateWeaponKit",
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_0238", Text = "Sure.", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_3033", Text = "Revaal, the Argent Skull. I know the fury in your hollowed eyes.", PreLineWait = 0.8 },
				-- { Cue = "/VO/Melinoe_0733", Text = "Revaal, the Skull of the Adjudicator. No mercy to my foes.", PreLineWait = 0.8 },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
		FlavorText = "WeaponLob_FlavorText",
	},
	
	-- Base Aspects
	StaffClearCastAspect =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			PlantGLotus = 5,
			OreFSilver = 5,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2447", Text = "Grant me the Aspect of Circe!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0350", Text = "A witch most-powerful!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},

	StaffSelfHitAspect =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerGBoss = 1,
			OreGLime = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2448", Text = "Grant me the Aspect of Momus!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0194", Text = "I bet it's pretty good!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},

	DaggerBlockAspect =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreHGlassrock = 1,
			OreFSilver = 15,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2449", Text = "Grant me the Aspect of Artemis!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0196", Text = "She knows her blades!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},

	DaggerHomingThrowAspect =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			PlantIShaderot = 2,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2542", Text = "Grant me the Aspect of Pan!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0197", Text = "Never met him but I heard good things!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	
	TorchDetonateAspect =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerHBoss = 2,
			OreNBronze = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3014", Text = "Grant me the Aspect of Moros!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0348", Text = "I shoulda known!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	TorchSprintRecallAspect =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerOBoss = 2,
			PlantODriftwood = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3015", Text = "Grant me the Aspect of Eos!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				PreLineAnim = "Skelly_Explaining",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0349", Text = "{#Emph}Ah{#Prev}, rosy-fingered Dawn!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	AxeArmCastAspect =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerGBoss = 5,
			CharonPoints = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3012", Text = "Grant me the Aspect of Charon!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				PreLineAnim = "Skelly_Babbling",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0346", Text = "Wait, {#Emph}who?!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	AxePerfectCriticalAspect =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreHGlassrock = 3,
			Mixer6Common = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3013", Text = "Grant me the Aspect of Thanatos!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0347", Text = "Oh {#Emph}that {#Prev}guy huh?" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	LobCloseAttackAspect =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreOIron = 4,
			PlantFNightshade = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3016", Text = "Grant me the Aspect of Medea!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0193", Text = "Oh she's a scary one!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	LobImpulseAspect =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			PlantIPoppy = 5,
			PlantNMoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3017", Text = "Grant me the Aspect of my mother!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				PreLineAnim = "Skelly_Salute",
				TriggerCooldowns = { "SkellyQuipAnySpeech" },

				{ Cue = "/VO/Skelly_0351", Text = "Save the Queen!" },
			},
		},
		--OnActivateFunctionName = "ActivateWeaponKit",
	},
	-- Aspect Upgrades
	BaseWeaponUpgrade =
	{
		HideAfterPurchased = true,
		SkipAutoEquip = true,
		-- SkipSpawnSkelly = true,
		PreRevealGlobalVoiceLines = "AnyAspectUpgradedVoiceLines",
	},

	-- Staff, Base
	BaseStaffAspect2 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 20,
			OreFSilver = 2,
		},
		GameStateRequirements =
		{
			{
				-- None, PathTrue = { "GameState", "WeaponsUnlocked", "BaseStaffAspect" },
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	BaseStaffAspect3 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 30,
			OreFSilver = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "BaseStaffAspect2" },
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	BaseStaffAspect4 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 40,
			OreFSilver = 4,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "BaseStaffAspect3" },
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	BaseStaffAspect5 =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 100,
			OreFSilver = 10,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "BaseStaffAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_2613", Text = "Descura, we are as one." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
		},
	},	

	-- Staff, Clear Cast
	StaffClearCastAspect2 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffClearCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffClearCastAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffClearCastAspect3 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffClearCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffClearCastAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffClearCastAspect4 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffClearCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffClearCastAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffClearCastAspect5 =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffClearCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffClearCastAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_2614", Text = "The true power of the great enchantress..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},

	-- Staff, Self Hit
	StaffSelfHitAspect2 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffSelfHitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffSelfHitAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffSelfHitAspect3 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffSelfHitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffSelfHitAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffSelfHitAspect4 =
	{
		WeaponName = "WeaponStaffSwing",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffSelfHitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffSelfHitAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffSelfHitAspect5 =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Staff01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffSelfHitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffSelfHitAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3580", Text = "I'll make a mockery of all my foes with this." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUpgradeReactionVoiceLines,
		},
	},

	-- Dagger, Base
	DaggerBackstabAspect2 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 1,
			OreFSilver = 5,
		},
		GameStateRequirements =
		{
			{
				-- None, PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBackstabAspect", }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBackstabAspect3 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 1,
			OreFSilver = 10,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBackstabAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBackstabAspect4 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 1,
			OreFSilver = 15,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBackstabAspect3" }
			}
		},		
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBackstabAspect5 =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 5,
			OreFSilver = 30,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBackstabAspect4" }
			}
		},		
		PreRevealVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_2616", Text = "Lim and Oros, we are one." },
				{ Cue = "/VO/Melinoe_3581", Text = "Lim and Oros, forever we are bound." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},

	-- Dagger, Block
	DaggerBlockAspect2 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBlockAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBlockAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBlockAspect3 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBlockAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBlockAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBlockAspect4 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBlockAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBlockAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBlockAspect5 =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBlockAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBlockAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_2617", Text = "The Huntress unleashed..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},

	-- Dagger, Homing Throw
	DaggerHomingThrowAspect2 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerHomingThrowAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerHomingThrowAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerHomingThrowAspect3 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerHomingThrowAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerHomingThrowAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerHomingThrowAspect4 =
	{
		WeaponName = "WeaponDagger",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerHomingThrowAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerHomingThrowAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerHomingThrowAspect5 =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Dagger01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerHomingThrowAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerHomingThrowAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_2618", Text = "The full might of nature's wrath..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},	
	-- Lob, Base
	LobAmmoBoostAspect2 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobAmmoBoostAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaCardPointsCommon = 5,
			OreGLime = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobAmmoBoostAspect3 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobAmmoBoostAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaCardPointsCommon = 10,
			OreGLime = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobAmmoBoostAspect2" },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobAmmoBoostAspect4 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobAmmoBoostAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaCardPointsCommon = 15,
			OreGLime = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobAmmoBoostAspect3" },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobAmmoBoostAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobAmmoBoostAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaCardPointsCommon = 25,
			OreGLime = 25,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobAmmoBoostAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3588", Text = "Revaal, I see what you see now." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},	
	-- Axe, Base
	AxeRecoveryAspect2 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 1,
			OreFSilver = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	AxeRecoveryAspect3 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 1,
			OreFSilver = 6,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRecoveryAspect2" },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	AxeRecoveryAspect4 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 1,
			OreFSilver = 12,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRecoveryAspect3" },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	AxeRecoveryAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 15,
			OreFSilver = 15,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRecoveryAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3582", Text = "Zorephet, our connection is complete." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},	
	-- Torch, Base
	TorchSpecialDurationAspect2 =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 2,
			OreFSilver = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	TorchSpecialDurationAspect3 =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 3,
			OreFSilver = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSpecialDurationAspect2" },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	TorchSpecialDurationAspect4 =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 4,
			OreFSilver = 4,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSpecialDurationAspect3" },
			}
		},
		--PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	TorchSpecialDurationAspect5 =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 5,
			OreFSilver = 10,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSpecialDurationAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3585", Text = "Ygnium, we're forged together in flame." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},	
	-- Axe, Arm Cast

	AxeArmCastAspect2 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeArmCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeArmCastAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	AxeArmCastAspect3 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeArmCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeArmCastAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	AxeArmCastAspect4 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeArmCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeArmCastAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	AxeArmCastAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeArmCastAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeArmCastAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3583", Text = "The sheer might of Lord Charon..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},

	-- Axe, Perfect Critical

	AxePerfectCriticalAspect2 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxePerfectCriticalAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxePerfectCriticalAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	AxePerfectCriticalAspect3 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxePerfectCriticalAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxePerfectCriticalAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	AxePerfectCriticalAspect4 =
	{
		WeaponName = "WeaponAxe",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxePerfectCriticalAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxePerfectCriticalAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	AxePerfectCriticalAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Axe01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxePerfectCriticalAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxePerfectCriticalAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3584", Text = "I am not Death, but know his way..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},	

	-- Torch, Detonate
	
	TorchDetonateAspect2 =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchDetonateAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchDetonateAspect3 =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchDetonateAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect2" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchDetonateAspect4 =
	{
		WeaponName = "WeaponTorch",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchDetonateAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect3" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchDetonateAspect5 =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchDetonateAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
				},
			},
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3586", Text = "Much to look forward to, Lord Moros." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},
	-- Torch recall aspect
    TorchSprintRecallAspect2 =
    {
        WeaponName = "WeaponTorch",
        Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
        IconScale = 0.18,
        Graphic = "WeaponArt05",
        TraitUpgrade = "TorchSprintRecallAspect",
        InheritFrom = { "BaseWeaponUpgrade", },
        Cost =
        {
            WeaponPointsRare = 1,
        },
        GameStateRequirements =
        {
            {
                PathTrue = { "GameState", "WeaponsUnlocked", "TorchSprintRecallAspect" }
            }
        },
        --PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
    },
    TorchSprintRecallAspect3 =
    {
        WeaponName = "WeaponTorch",
        Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
        IconScale = 0.18,
        Graphic = "WeaponArt05",
        TraitUpgrade = "TorchSprintRecallAspect",
        InheritFrom = { "BaseWeaponUpgrade", },
        Cost =
        {
            WeaponPointsRare = 1,
        },
        GameStateRequirements =
        {
            {
                PathTrue = { "GameState", "WeaponsUnlocked", "TorchSprintRecallAspect2" }
            }
        },
        --PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
    },
    TorchSprintRecallAspect4 =
    {
        WeaponName = "WeaponTorch",
        Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
        IconScale = 0.18,
        Graphic = "WeaponArt05",
        TraitUpgrade = "TorchSprintRecallAspect",
        InheritFrom = { "BaseWeaponUpgrade", },
        Cost =
        {
            WeaponPointsRare = 2,
        },
        GameStateRequirements =
        {
            {
                PathTrue = { "GameState", "WeaponsUnlocked", "TorchSprintRecallAspect3" }
            }
        },
        --PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
    },
    TorchSprintRecallAspect5 =
    {
        WeaponName = "WeaponTorch",
        HideAfterPurchased = false,
        Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Torch01",
        IconScale = 0.18,
        Graphic = "WeaponArt05",
        TraitUpgrade = "TorchSprintRecallAspect",
        InheritFrom = { "BaseWeaponUpgrade", },
        Cost =
        {
            WeaponPointsRare = 3,
        },
        GameStateRequirements =
        {
            {
                PathTrue = { "GameState", "WeaponsUnlocked", "TorchSprintRecallAspect4" }
            }
        },
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3587", Text = "Such power in the break of Dawn..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
    },
	-- Lob close attack
	LobCloseAttackAspect2 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobCloseAttackAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobCloseAttackAspect" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	LobCloseAttackAspect3 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobCloseAttackAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobCloseAttackAspect2" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	LobCloseAttackAspect4 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobCloseAttackAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobCloseAttackAspect3" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	LobCloseAttackAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobCloseAttackAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobCloseAttackAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3589", Text = "A curse on all who oppose us..." },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},		
	LobImpulseAspect2 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobImpulseAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobImpulseAspect" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	LobImpulseAspect3 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobImpulseAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobImpulseAspect2" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	LobImpulseAspect4 =
	{
		WeaponName = "WeaponLob",
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobImpulseAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobImpulseAspect3" }
			}
		},
		--PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	LobImpulseAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		Icon = "GUI\\Screens\\WeaponShop\\Icons\\Weapon_Skull01",
		IconScale = 0.18,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobImpulseAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobImpulseAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3590", Text = "What would Mother have done...?" },
			},
			[2] = GlobalVoiceLines.SkellyWeaponUnlockReactionVoiceLines,
		},
	},
	-- Tools
	ToolPickaxe =
	{
		Icon = "GUI\\Icons\\Pickaxe",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		Cost =
		{
			MetaCardPointsCommon = 1,
		},
		OnActivateFunctionName = "ActivateToolKit",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1616", Text = "The Crescent Pick...", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_1911", Text = "Reveal to me the bounties of the earth.", PreLineWait = 1.0 },
			},
			[2] = GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines,
		},
		FlavorText = "ToolPickaxe_FlavorText",
	},
	
	ToolExorcismBook =
	{
		Icon = "GUI\\Icons\\ExorcismBook",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		Cost =
		{
			OreFSilver = 5,
			MemPointsCommon = 5,
		},
		OnActivateFunctionName = "ActivateToolKit",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1615", Text = "The Tablet of Peace...", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_0240", Text = "You are mine now.", PreLineWait = 1.0 },
			},
			[2] = GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines,
		},
		FlavorText = "ToolExorcismBook_FlavorText",
	},

	ToolShovel =
	{
		Icon = "GUI\\Icons\\Shovel",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		Cost =
		{
			OreFSilver = 10,
			--MetaFabric = 1,
		},
		OnActivateFunctionName = "ActivateToolKit",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1910", Text = "The Silver Spade.", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_0237", Text = "You're mine.", PreLineWait = 1.0 },
			},
			[2] = GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines,
		},
		FlavorText = "ToolShovel_FlavorText",
	},

	ToolFishingRod =
	{
		Icon = "GUI\\Icons\\FishingRod",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		Cost =
		{
			OreNBronze = 1,
			MetaFabric = 2,
		},
		OnActivateFunctionName = "ActivateToolKit",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1908", Text = "The Rod of Fishing.", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_1909", Text = "What shall the rivers yield to us?", PreLineWait = 1.0 },
			},
			[2] = GlobalVoiceLines.SkellyToolUnlockReactionVoiceLines,
		},
		FlavorText = "ToolFishingRod_FlavorText",
	},

	-- Tool Upgrades
	ToolPickaxe2 =
	{
		Icon = "GUI\\Icons\\Pickaxe",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		HelpTextId = "ToolPickaxe2_Shop",
		ToolName = "ToolPickaxe",
		MaxHealthBonus = 1,
		Level = 2,
		Cost =
		{
			OreHGlassrock = 6,
			OreOIron = 4,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolPickaxe", }
			}
		},
		TextureData =
		{
			Model = "ToolPickAxe_Mesh",
			Texture = "Models/Tools/ToolPickAxeLvl2_Color",
			Animation = "MelinoePickAxeMineStart",
		},
		SkipSpawnSkelly = true,
		FlavorText = "ToolPickaxe_FlavorText",
		PreRevealGlobalVoiceLines = "ToolPickaxeUpgradedVoiceLines",
	},

	ToolExorcismBook2 =
	{
		Icon = "GUI\\Icons\\ExorcismBook",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		HelpTextId = "ToolExorcismBook2_Shop",
		ToolName = "ToolExorcismBook",
		ResourceBonus = 1.2,
		Level = 2,
		SimpleExtractValues =
		{
			{
				Property = "ResourceBonus",
				Multiply = 100,
				Add = -100,
				NewProperty = "ResourceBonusPercent",
			},
		},
		Cost =
		{
			MetaCardPointsCommon = 50,
			OreIMarble = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolExorcismBook" },
			}
		},
		TextureData =
		{
			Model = "ToolTablet_Mesh",
			Texture = "Models/Tools/ToolTabletLvl2_Color",
			Animation = "Melinoe_Tablet_Idle",
		},
		SkipSpawnSkelly = true,
		FlavorText = "ToolExorcismBook_FlavorText",
		PreRevealGlobalVoiceLines = "ToolExorcismBookUpgradedVoiceLines",
	},

	ToolShovel2 =
	{
		Icon = "GUI\\Icons\\Shovel",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		HelpTextId = "ToolShovel2_Shop",
		ToolName = "ToolShovel",
		Level = 2,
		Cost =
		{
			PlantOMandrake = 2,
			OreNBronze = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolShovel" },
			}
		},
		SkipSpawnSkelly = true,
		FlavorText = "ToolShovel_FlavorText",
		PreRevealGlobalVoiceLines = "ToolShovelUpgradedVoiceLines",
	},

	ToolFishingRod2 =
	{
		Icon = "GUI\\Icons\\FishingRod",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		HelpTextId = "ToolFishingRod2_Shop",
		ToolName = "ToolFishingRod",
		Level = 2,
		Cost =
		{
			PlantODriftwood = 4,
			GiftPointsEpic = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" }
			}
		},
		SkipSpawnSkelly = true,
		FlavorText = "ToolFishingRod_FlavorText",
		PreRevealGlobalVoiceLines = "ToolFishingRodUpgradedVoiceLines",
	},
}

ScreenData.WeaponShop =
{
	BlockPause = true,

	CategoryStartX = 104,
	CategoryStartY = 126,
	CategorySpacingX = 94,

	CategoryIconScale = 0.40,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 495,
	ItemStartY = 230,
	ItemSpacingY = 110,
	IconOffsetX = -390,
	IconOffsetY = 0,
	IconScale = 0.5,
	ItemsPerPage = 5,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -450,

	KitCameraOffsetX = -300,

	NewIconOffsetX = 0,
	NewIconOffsetY = -5,

	ItemAvailableAffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostAffordableShop,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemAvailableUnaffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostUnaffordable,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemPurchasedNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {0.5, 0.5, 0.5, 1.0},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinOffsetX = 315,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ItemCategories =
	{
		{
			Name = "WeaponShop_Weapons",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Weapons",
			GameStateRequirements =
			{
				-- None
			},
			"WeaponStaffSwing",
			"StaffClearCastAspect",
			"StaffSelfHitAspect",

			"WeaponDagger",
			"DaggerBlockAspect",
			"DaggerHomingThrowAspect",

			"WeaponTorch",
			"TorchDetonateAspect",
			"TorchSprintRecallAspect",

			"WeaponAxe",
			"AxeArmCastAspect",
			"AxePerfectCriticalAspect",

			"WeaponLob",
			"LobCloseAttackAspect",
			"LobImpulseAspect",
		},
		{
			Name = "WeaponShop_WeaponUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Bonds",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
			},
			-- Staff
			"BaseStaffAspect2",
			"BaseStaffAspect3",
			"BaseStaffAspect4",
			"BaseStaffAspect5",

			"StaffClearCastAspect2",
			"StaffClearCastAspect3",
			"StaffClearCastAspect4",
			"StaffClearCastAspect5",

			"StaffSelfHitAspect2",
			"StaffSelfHitAspect3",
			"StaffSelfHitAspect4",
			"StaffSelfHitAspect5",

			-- Dagger
			"DaggerBackstabAspect2",
			"DaggerBackstabAspect3",
			"DaggerBackstabAspect4",
			"DaggerBackstabAspect5",

			"DaggerBlockAspect2",
			"DaggerBlockAspect3",
			"DaggerBlockAspect4",
			"DaggerBlockAspect5",

			"DaggerHomingThrowAspect2",
			"DaggerHomingThrowAspect3",
			"DaggerHomingThrowAspect4",
			"DaggerHomingThrowAspect5",

			-- Torch
			"TorchSpecialDurationAspect2",
			"TorchSpecialDurationAspect3",
			"TorchSpecialDurationAspect4",
			"TorchSpecialDurationAspect5",

			"TorchDetonateAspect2",
			"TorchDetonateAspect3",
			"TorchDetonateAspect4",
			"TorchDetonateAspect5",

			"TorchSprintRecallAspect2",
			"TorchSprintRecallAspect3",
			"TorchSprintRecallAspect4",
			"TorchSprintRecallAspect5",

			-- Axe
			"AxeRecoveryAspect2",
			"AxeRecoveryAspect3",
			"AxeRecoveryAspect4",
			"AxeRecoveryAspect5",

			"AxeArmCastAspect2",
			"AxeArmCastAspect3",
			"AxeArmCastAspect4",
			"AxeArmCastAspect5",

			"AxePerfectCriticalAspect2",
			"AxePerfectCriticalAspect3",
			"AxePerfectCriticalAspect4",
			"AxePerfectCriticalAspect5",

			--  Lob
			"LobAmmoBoostAspect2",
			"LobAmmoBoostAspect3",
			"LobAmmoBoostAspect4",
			"LobAmmoBoostAspect5",

			"LobCloseAttackAspect2",
			"LobCloseAttackAspect3",
			"LobCloseAttackAspect4",
			"LobCloseAttackAspect5",

			"LobImpulseAspect2",
			"LobImpulseAspect3",
			"LobImpulseAspect4",
			"LobImpulseAspect5",
		},
		{
			Name = "WeaponShop_Tools",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Tools",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolsShop" },
				},
			},
			"ToolPickaxe",
			"ToolExorcismBook",
			"ToolShovel",
			"ToolFishingRod",
		},
		{
			Name = "WeaponShop_ToolUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Favors",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolUpgradeSystem" },
				},
			},
			"ToolPickaxe2",
			"ToolExorcismBook2",
			"ToolShovel2",
			"ToolFishingRod2",
		},
	},

	Components = {},

	SaleData = {},
	NumSales = 0,
	NumItemsOffered = 0,

	TooltipX = 1680,
	TooltipY = 1280,

	CostDisplay =
	{
		StartX = 232,
		StartY = 848,
		SpacerX = 160,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,
	},

	ItemAvailableAnimation = "GUI\\Screens\\WeaponUpgrade\\Button",
	ItemAvailableHighlightAnimation = "GUI\\Screens\\WeaponUpgrade\\Button_Highlight",
	ItemPurchasedAnimation = "GUI\\Screens\\WeaponUpgrade\\Button",
	ItemPurchasedHighlightAnimation = "GUI\\Screens\\WeaponUpgrade\\Button_Highlight",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",

		Order =
		{
			"BackgroundDim",
			"ResourceCostBacking",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 300,
			Y = ScreenCenterY,
			UseNativeScreenCenter = true,
			Color = { 1.0, 1.0, 1.0, 0.8 },
		},

		CategoryBacking = 
		{
			AnimationName = "GUI\\Screens\\WeaponShop\\Backing_Header",
			X = 820,
			Y = 100,
		},

		CategoryTitleText = 
		{
			X = 80,
			Y = 70,
			TextArgs =
			{
				FontSize = 26,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		ResourceCostBacking =
		{
			AnimationName = "GUI\\Screens\\WeaponShop\\Backing_Left",
			X = 232,
			Y = 865,
			Scale = 0.538,
			Alpha = 0.0,
		},

		InfoBoxBacking =
		{
			Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
			X = 970,
			Y = 862,
			UseNativeScreenX = true,
			Alpha = 0.0,
			UseableOff = true,
			InteractProperties =
			{
				FreeFormSelectable = false,
			},

			ChildrenOrder =
			{
				"InfoBoxIcon",
				"InfoBoxFrame",
			},

			Children =
			{
				InfoBoxIcon = 
				{
					Graphic = "BlankObstacle",
					Scale = ScreenData.UpgradeChoice.Icon.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				InfoBoxFrame = 
				{
					Graphic = "BlankObstacle",
					Animation = "Frame_Boon_Menu_Common",
					Scale = ScreenData.UpgradeChoice.Frame.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				InfoBoxName =
				{
					TextArgs = ScreenData.UpgradeChoice.TitleText,
				},
				InfoBoxRarity =
				{
					TextArgs = ScreenData.UpgradeChoice.RarityText,
				},

				InfoBoxDescription =
				{ 
					TextArgs = ScreenData.UpgradeChoice.DescriptionText,
				},
				InfoBoxStatLineLeft =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
				},
				InfoBoxStatLineRight =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineRight,
				},
				InfoBoxFlavor =
				{
					TextArgs = ScreenData.UpgradeChoice.FlavorText,
				},
			}
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 30,
			Y = 210,
			Alpha = 0.0,
			Scale = 0.85,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			X = 30,
			Y = 692,
			Alpha = 0.0,
			Scale = 0.85,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
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
				"ScrollRight",
				"ScrollLeft",
				"PinButton",
				"SelectButton",
			},

			Children =
			{
				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "WeaponShopPinItem",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "Menu_Pin",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollLeft = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "WeaponShopScreenPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "WeaponShopScreenNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_Unlock",
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
						OnPressedFunctionName = "CloseWeaponShopScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}