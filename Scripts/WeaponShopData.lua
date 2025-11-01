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
			{ GlobalVoiceLines = "SkellyWeaponUnlockReactionVoiceLines" },
		},
		FlavorText = "WeaponDagger_FlavorText",
		Priority = true,
		-- PostActivationHoldDuration = 3.0,
	},
	WeaponTorch =
	{
		Icon = "Hammer_Torch_39",
		Cost =
		{
			OreFSilver = 2,
			MixerFBoss = 2,
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
			{ GlobalVoiceLines = "SkellyWeaponUnlockReactionVoiceLines" },
		},
		FlavorText = "WeaponTorch_FlavorText",
		Priority = true,
	},
	WeaponAxe =
	{
		Icon = "Hammer_Axe_40",
		Cost =
		{
			OreFSilver = 10,
		},
		OnActivateFunctionName = "ActivateWeaponKit",
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_0118", Text = "All right.", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_3031", Text = "Zorephet, the Moonstone Axe. You can split anything apart.", PreLineWait = 0.8 },
			},
			{ GlobalVoiceLines = "SkellyWeaponUnlockReactionVoiceLines" },
		},
		FlavorText = "WeaponAxe_FlavorText",
		Priority = true,
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
			},
			{
				Path = { "CurrentRun", "WeaponsUnlocked" },
				HasNone = { "WeaponDagger", "WeaponTorch", "WeaponAxe" },
			},
		},
		OnActivateFunctionName = "ActivateWeaponKit",

		OfferedVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll = { "WeaponDagger", "WeaponTorch", "WeaponAxe" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasNone = { "WeaponLob" },
				},
			},
			{ Cue = "/VO/Melinoe_3394", Text = "Another artifact of Night within the Pool..." },
		},

		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_0238", Text = "Sure.", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_3033", Text = "Revaal, the Argent Skull. I know the fury in your hollowed eyes.", PreLineWait = 0.8 },
				-- { Cue = "/VO/Melinoe_0733", Text = "Revaal, the Skull of the Adjudicator. No mercy to my foes.", PreLineWait = 0.8 },
			},
			{ GlobalVoiceLines = "SkellyWeaponUnlockReactionVoiceLines" },
		},
		FlavorText = "WeaponLob_FlavorText",
		Priority = true,
	},
	WeaponSuit =
	{
		Icon = "Hammer_Suit_01",
		Cost =
		{
			MixerFBoss = 2,
			OrePAdamant = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
			},
			{
				Path = { "CurrentRun", "WeaponsUnlocked" },
				HasNone = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
			},
		},
		OnActivateFunctionName = "ActivateWeaponKit",

		OfferedVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll = { "WeaponLob" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasNone = { "WeaponSuit" },
				},
			},
			{ Cue = "/VO/Melinoe_3615", Text = "The last of the Nocturnal Arms..." },
		},

		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_3749", Text = "At last...", PreLineWait = 0.3 },
				{ Cue = "/VO/Melinoe_3616", Text = "Xinth, the Black Coat. Envelop me in darkness that our foes cannot escape.", PreLineWait = 0.7 },
			},
			{ GlobalVoiceLines = "SkellyWeaponUnlockReactionVoiceLines" },
		},
		FlavorText = "WeaponSuit_FlavorText",
		Priority = true,
		-- PostActivationHoldDuration = 3.0,
	},
	
	-- Base Aspects
	-- Staff
	StaffClearCastAspect =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = true,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			PlantGLotus = 5,
			OreIMarble = 5,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				Path = { "GameState", "FamiliarsUnlocked" },
				HasAny = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" }
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0350", Text = "A witch most-powerful!" },
			},
		},
	},
	StaffSelfHitAspect =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerGBoss = 1,
			OreGLime = 3,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0194", Text = "I bet it's pretty good!" },
			},
		},
	},
	StaffRaiseDeadAspect =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			PlantQFang = 2,
			MixerHBoss = 5,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceGrantsHiddenAspect01" },
			},
		},

		PreOpenRevealVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			Queue = "Interrupt",
			PostLineWait = 1.0,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			PreLineThreadedFunctionName = "LegendaryAspectPresentation",
			PreLineThreadedFunctionArgs = { WaitTime = 2.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedAnubis" },
			{ Cue = "/VO/Melinoe_2463", Text = "Descura: {#Emph}I see you guarding graves of mortals passed into the black beyond." },
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2450", Text = "Grant me the aspect of Anubis!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0545", Text = "Been hearing lots of good things about him!" },
			},
		},
	},

	-- Dagger
	DaggerBlockAspect =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = true,
		IconScale = 0.8,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0196", Text = "She knows her blades!" },
			},
		},
	},
	DaggerHomingThrowAspect =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			PlantIShaderot = 2,
			MixerNBoss = 2,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0197", Text = "Never met him but I heard good things!" },
			},
		},
	},
	DaggerTripleAspect =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreOIron = 8,
			MixerPBoss = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGrantsHiddenAspect01" },
			},
		},

		PreOpenRevealVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			Queue = "Interrupt",
			PostLineWait = 1.0,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			PreLineThreadedFunctionName = "LegendaryAspectPresentation",
			PreLineThreadedFunctionArgs = { WaitTime = 2.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedMorrigan" },
			{ Cue = "/VO/Melinoe_3993", Text = "Lim and Oros: {#Emph}I see your threefold shadow with the Phantom Queen." },
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3995", Text = "Grant me the Aspect of the Morrigan!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0505", Text = "Wait who the what now?!" },
			},
		},
	},

	-- Torch
	TorchDetonateAspect =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerHBoss = 4,
			OreNBronze = 6,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0348", Text = "I shoulda known!" },
			},
		},
	},
	TorchSprintRecallAspect =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = true,
		IconScale = 0.8,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0349", Text = "{#Emph}Ah{#Prev}, rosy-fingered Dawn!" },
			},
		},
	},
	TorchAutofireAspect =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreIMarble = 16,
			MixerShadow = 6,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsHiddenAspect01" },
			},
		},
		PreOpenRevealVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			Queue = "Interrupt",
			PostLineWait = 1.0,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			PreLineThreadedFunctionName = "LegendaryAspectPresentation",
			PreLineThreadedFunctionArgs = { WaitTime = 2.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedSupay" },
			{ Cue = "/VO/Melinoe_4373", Text = "Ygnium: {#Emph}I see your spirits glimmer as the metals underneath the Earth." },
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4375", Text = "Grant me the Aspect of Supay!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0547", Text = "Does everybody get an Aspect now?" },
			},
		},
	},

	-- Axe
	AxeArmCastAspect =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			MixerGBoss = 3,
			CharonPoints = 3,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0346", Text = "Wait, {#Emph}who?!" },
			},
		},
	},
	AxePerfectCriticalAspect =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreHGlassrock = 4,
			PlantFNightshade = 4,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0347", Text = "Oh {#Emph}that {#Prev}guy huh?" },
			},
		},
	},
	AxeRallyAspect =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreQScales = 5,
			OreOIron = 12,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGrantsHiddenAspect01" },
			},
		},
		PreOpenRevealVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			Queue = "Interrupt",
			PostLineWait = 1.0,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			PreLineThreadedFunctionName = "LegendaryAspectPresentation",
			PreLineThreadedFunctionArgs = { WaitTime = 2.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedNergal" },
			{ Cue = "/VO/Melinoe_4379", Text = "Zorephet: {#Emph}I see you hoard the shattered corpses of your foes." },
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4381", Text = "Grant me the Aspect of Nergal!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0549", Text = "{#Emph}Ohh{#Prev}, that guy's been around a while." },
			},
		},
	},

	-- Lob
	LobCloseAttackAspect =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreOIron = 4,
			PlantOMandrake = 1,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0193", Text = "Oh she's a scary one!" },
			},
		},
	},
	LobImpulseAspect =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = true,
		IconScale = 0.8,
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
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0351", Text = "Save the Queen!" },
			},
		},
	},
	LobGunAspect =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OrePAdamant = 12,
			PlantQSnakereed = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHiddenAspect01" },
			},
		},
		PreOpenRevealVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			Queue = "Interrupt",
			PostLineWait = 1.0,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			PreLineThreadedFunctionName = "LegendaryAspectPresentation",
			PreLineThreadedFunctionArgs = { WaitTime = 2.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedHel" },
			{ Cue = "/VO/Melinoe_4385", Text = "Revaal: {#Emph}I see you gather countless dead in cold and dark domains." },
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4387", Text = "Grant me the Aspect of Hel!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0551", Text = "What the... Hel, did you say?" },
			},
		},
	},

	-- Suit
	SuitMarkCritAspect =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			OreChaosProtoplasm = 4,
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

				{ Cue = "/VO/Melinoe_3733", Text = "Grant me the Aspect of Nyx!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0414", Text = "Glory be to Mother Night, and stuff!" },
			},
		},
	},
	SuitHexAspect =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			CardUpgradePoints = 4,
			OreFSilver = 4,
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

				{ Cue = "/VO/Melinoe_3732", Text = "Grant me the Aspect of Selene!" },
			},
			{
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "~=",
						Value = 5,
					},
				},
				Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },

				-- { Cue = "/VO/Selene_0388", Text = "You have it..." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0413", Text = "Shine like the Moon, kiddo!" },
			},
		},
	},
	SuitComboAspect =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = true,
		IconScale = 0.8,
		UnlockTextId = "WeaponShopAspectUnlock",
		Cost =
		{
			WeaponPointsRare = 4,
			OreHGlassrock = 12,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGrantsHiddenAspect01" },
			},
		},
		PreOpenRevealVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			Queue = "Interrupt",
			PostLineWait = 1.0,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			PreLineThreadedFunctionName = "LegendaryAspectPresentation",
			PreLineThreadedFunctionArgs = { WaitTime = 2.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedShiva" },
			{ Cue = "/VO/Melinoe_4391", Text = "Xinth: {#Emph}I see you bring bliss and destruction in your outstretched arms." },
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4393", Text = "Grant me the Aspect of Shiva!" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				ObjectType = "NPC_Skelly_01",
				TriggerCooldowns = { "SkellyAnyQuipSpeech" },

				{ Cue = "/VO/Skelly_0553", Text = "Think that's the guy with all the extra arms..." },
			},
		},
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
		IconScale = 0.8,
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 10,
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
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 20,
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
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 30,
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
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "BaseStaffAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MemPointsCommon = 50,
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
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2613", Text = "Descura, we are as one." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},	

	-- Staff, Clear Cast
	StaffClearCastAspect2 =
	{
		WeaponName = "WeaponStaffSwing",
		IconScale = 0.8,
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
			},
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffClearCastAspect3 =
	{
		WeaponName = "WeaponStaffSwing",
		IconScale = 0.8,
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
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffClearCastAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffClearCastAspect5 =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffClearCastAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2614", Text = "The true power of the great enchantress..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Staff, Self Hit
	StaffSelfHitAspect2 =
	{
		WeaponName = "WeaponStaffSwing",
		IconScale = 0.8,
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
		IconScale = 0.8,
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
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffSelfHitAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffSelfHitAspect5 =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffSelfHitAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3580", Text = "I'll make a mockery of all my foes with this." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Staff, Raise Dead
	StaffRaiseDeadAspect2 =
	{
		WeaponName = "WeaponStaffSwing",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffRaiseDeadAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffRaiseDeadAspect3 =
	{
		WeaponName = "WeaponStaffSwing",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffRaiseDeadAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffRaiseDeadAspect4 =
	{
		WeaponName = "WeaponStaffSwing",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffRaiseDeadAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "StaffAspectUpgradedVoiceLines",
	},
	StaffRaiseDeadAspect5 =
	{
		WeaponName = "WeaponStaffSwing",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "StaffRaiseDeadAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2615", Text = "Staff of Dusk; Staff of the Dead..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Dagger, Base
	DaggerBackstabAspect2 =
	{
		WeaponName = "WeaponDagger",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 1,
			OreFSilver = 2,
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
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 1,
			OreFSilver = 4,
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
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 1,
			OreFSilver = 6,
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
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerBackstabAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaFabric = 5,
			OreFSilver = 10,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBackstabAspect4" }
			}
		},		
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2616", Text = "Lim and Oros, we are one." },
				{ Cue = "/VO/Melinoe_3581", Text = "Lim and Oros, forever we are bound." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Dagger, Block
	DaggerBlockAspect2 =
	{
		WeaponName = "WeaponDagger",
		IconScale = 0.8,
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
		IconScale = 0.8,
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
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBlockAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerBlockAspect5 =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerBlockAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2617", Text = "The Huntress unleashed..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Dagger, Homing Throw
	DaggerHomingThrowAspect2 =
	{
		WeaponName = "WeaponDagger",
		IconScale = 0.8,
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
		IconScale = 0.8,
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
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerHomingThrowAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerHomingThrowAspect5 =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerHomingThrowAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_2618", Text = "The full might of nature's wrath..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Dagger, Legendary Throw
	DaggerTripleAspect2 =
	{
		WeaponName = "WeaponDagger",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerTripleAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerTripleAspect3 =
	{
		WeaponName = "WeaponDagger",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerTripleAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerTripleAspect4 =
	{
		WeaponName = "WeaponDagger",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerTripleAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "DaggerAspectUpgradedVoiceLines",
	},
	DaggerTripleAspect5 =
	{
		WeaponName = "WeaponDagger",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "DaggerTripleAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4000", Text = "One with the three-fold goddess of a distant land..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Torch, Base
	TorchSpecialDurationAspect2 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 1,
			OreFSilver = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", },
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchSpecialDurationAspect3 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 1,
			OreFSilver = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSpecialDurationAspect2" },
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchSpecialDurationAspect4 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 2,
			OreFSilver = 4,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSpecialDurationAspect3" },
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchSpecialDurationAspect5 =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchSpecialDurationAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 3,
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
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3585", Text = "Ygnium, we're forged together in flame." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Torch, Detonate
	TorchDetonateAspect2 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchDetonateAspect3 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchDetonateAspect4 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchDetonateAspect5 =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3586", Text = "Much to look forward to, Lord Moros.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2620", Text = "Our bond is now complete.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "UseRecord", "NPC_Moros_01" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Torch recall aspect
	TorchSprintRecallAspect2 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchSprintRecallAspect3 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchSprintRecallAspect4 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSprintRecallAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchSprintRecallAspect5 =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchSprintRecallAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3587", Text = "Such power in the break of Dawn..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Torch autofire aspect
	TorchAutofireAspect2 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchAutofireAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchAutofireAspect3 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchAutofireAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchAutofireAspect4 =
	{
		WeaponName = "WeaponTorch",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchAutofireAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "TorchAspectUpgradedVoiceLines",
	},
	TorchAutofireAspect5 =
	{
		WeaponName = "WeaponTorch",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "TorchAutofireAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4378", Text = "The daemonic light of Supay..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Axe, Base
	AxeRecoveryAspect2 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 2,
			OreFSilver = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", },
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeRecoveryAspect3 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 3,
			OreFSilver = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRecoveryAspect2" },
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeRecoveryAspect4 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 4,
			OreFSilver = 4,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRecoveryAspect3" },
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeRecoveryAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRecoveryAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			OreNBronze = 12,
			OreFSilver = 12,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRecoveryAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3582", Text = "Zorephet, our connection is complete." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Axe, Arm Cast
	AxeArmCastAspect2 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeArmCastAspect3 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeArmCastAspect4 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeArmCastAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeArmCastAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeArmCastAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3583", Text = "The sheer might of Lord Charon..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Axe, Perfect Critical
	AxePerfectCriticalAspect2 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxePerfectCriticalAspect3 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxePerfectCriticalAspect4 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "AxePerfectCriticalAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxePerfectCriticalAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "AxePerfectCriticalAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3584", Text = "I am not Death, but know his way..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},	
	
	-- Axe, Rally
	AxeRallyAspect2 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRallyAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeRallyAspect3 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRallyAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeRallyAspect4 =
	{
		WeaponName = "WeaponAxe",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRallyAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "AxeAspectUpgradedVoiceLines",
	},
	AxeRallyAspect5 =
	{
		WeaponName = "WeaponAxe",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "AxeRallyAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4384", Text = "The sheer brute strength of Nergal..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Lob, Base
	LobAmmoBoostAspect2 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobAmmoBoostAspect3 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobAmmoBoostAspect4 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobAmmoBoostAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobAmmoBoostAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MetaCardPointsCommon = 25,
			OreGLime = 10,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobAmmoBoostAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3588", Text = "Revaal, I see what you see now." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Lob close attack
	LobCloseAttackAspect2 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobCloseAttackAspect3 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobCloseAttackAspect4 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "LobCloseAttackAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobCloseAttackAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "LobCloseAttackAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3589", Text = "A curse on all who oppose us..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Lob skull car
	LobImpulseAspect2 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobImpulseAspect3 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobImpulseAspect4 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "LobImpulseAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobImpulseAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		IconScale = 0.8,
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
				PathTrue = { "GameState", "WeaponsUnlocked", "LobImpulseAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3590", Text = "What would Mother have done...?" },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Lob, Gun
	LobGunAspect2 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobGunAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobGunAspect3 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobGunAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobGunAspect4 =
	{
		WeaponName = "WeaponLob",
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobGunAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "LobAspectUpgradedVoiceLines",
	},
	LobGunAspect5 =
	{
		WeaponName = "WeaponLob",
		HideAfterPurchased = false,
		IconScale = 0.8,
		Graphic = "WeaponArt05",
		TraitUpgrade = "LobGunAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4390", Text = "The cold eternal stare of Hel..." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Suit, Base
	BaseSuitAspect2 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "BaseSuitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 1,
			OrePAdamant = 4,
		},
		GameStateRequirements =
		{
			{
				-- None, PathTrue = { "GameState", "WeaponsUnlocked", "BaseStaffAspect" },
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	BaseSuitAspect3 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "BaseSuitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 1,
			OrePAdamant = 6,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "BaseSuitAspect2" },
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	BaseSuitAspect4 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "BaseSuitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 1,
			OrePAdamant = 8,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "BaseSuitAspect3" },
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	BaseSuitAspect5 =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = false,
		IconScale = 0.8,
		TraitUpgrade = "BaseSuitAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			MixerFBoss = 1,
			OrePAdamant = 15,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "BaseSuitAspect4" },
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3740", Text = "Xinth, our bond is finally true." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Suit, Mark
	SuitMarkCritAspect2 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitMarkCritAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitMarkCritAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitMarkCritAspect3 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitMarkCritAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitMarkCritAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitMarkCritAspect4 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitMarkCritAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitMarkCritAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitMarkCritAspect5 =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = false,
		IconScale = 0.8,
		TraitUpgrade = "SuitMarkCritAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitMarkCritAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3748", Text = "The dark power of Nyx, now in my hands." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Suit, Hex
	SuitHexAspect2 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitHexAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitHexAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitHexAspect3 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitHexAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitHexAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitHexAspect4 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitHexAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitHexAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitHexAspect5 =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = false,
		IconScale = 0.8,
		TraitUpgrade = "SuitHexAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitHexAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3747", Text = "Sister Selene's brilliance at my command." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
		},
	},

	-- Suit, Combo
	SuitComboAspect2 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitComboAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitComboAspect3 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitComboAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect2" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitComboAspect4 =
	{
		WeaponName = "WeaponSuit",
		IconScale = 0.8,
		TraitUpgrade = "SuitComboAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect3" }
			}
		},
		PreRevealGlobalVoiceLines = "SuitAspectUpgradedVoiceLines",
	},
	SuitComboAspect5 =
	{
		WeaponName = "WeaponSuit",
		HideAfterPurchased = false,
		IconScale = 0.8,
		TraitUpgrade = "SuitComboAspect",
		InheritFrom = { "BaseWeaponUpgrade", },
		Cost =
		{
			WeaponPointsRare = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect4" }
			}
		},
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4396", Text = "The raw destructive power of Shiva." },
			},
			{ GlobalVoiceLines = "SkellyWeaponMaxUpgradeReactionVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
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
		HideIfItemAvailable = "ToolPickaxe2",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1616", Text = "The Crescent Pick...", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_1911", Text = "Reveal to me the bounties of the Earth.", PreLineWait = 1.0 },
			},
			{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
		},
		PostActivateFunctionName = "ToolPickaxeUnlockedPresentation",
		FlavorText = "ToolPickaxe_FlavorText",
		Priority = true,
	},
	
	ToolExorcismBook =
	{
		Icon = "GUI\\Icons\\ExorcismBook",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		Cost =
		{
			OreFSilver = 4,
		},
		HideIfItemAvailable = "ToolExorcismBook2",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1615", Text = "The Tablet of Peace...", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_0240", Text = "You are mine now.", PreLineWait = 1.0 },
			},
			{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
		},
		PostActivateFunctionName = "ToolExorcismBookUnlockedPresentation",
		FlavorText = "ToolExorcismBook_FlavorText",
		Priority = true,
	},

	ToolShovel =
	{
		Icon = "GUI\\Icons\\Shovel",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUnlock",
		Cost =
		{
			OreFSilver = 8,
			--MetaFabric = 1,
		},
		HideIfItemAvailable = "ToolShovel2",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1910", Text = "The Silver Spade.", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_0237", Text = "You're mine.", PreLineWait = 1.0 },
			},
			{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
		},
		PostActivateFunctionName = "ToolShovelUnlockedPresentation",
		FlavorText = "ToolShovel_FlavorText",
		Priority = true,
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
		HideIfItemAvailable = "ToolFishingRod2",
		SkipSpawnSkelly = true,
		PreRevealVoiceLines =
		{
			TriggerCooldowns = { "MelinoeMiscToolEquipSpeech" },
			{
				{ Cue = "/VO/Melinoe_1908", Text = "The Rod of Fishing.", PreLineWait = 0.35 },
				{ Cue = "/VO/Melinoe_1909", Text = "What shall the rivers yield to us?", PreLineWait = 1.0 },
			},
			{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
		},
		PostActivateFunctionName = "ToolFishingRodUnlockedPresentation",
		FlavorText = "ToolFishingRod_FlavorText",
		Priority = true,
	},

	-- Tool Upgrades
	ToolPickaxe2 =
	{
		Icon = "GUI\\Icons\\PickaxeG",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUpgrade",
		HelpTextId = "ToolPickaxe2_Shop",
		Level = 2,
		ElementChance = 0.5,
		ElementName = "FireEssence",
		ElementPopupDelay = 0.6,
		SimpleExtractValues =
		{
			{
				Property = "ElementChance",
				Multiply = 100,
				NewProperty = "ElementChancePercent",
			},
		},
		Cost =
		{
			OreHGlassrock = 4,
			OreOIron = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolUpgradeSystem" }
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolPickaxe" },
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
		Icon = "GUI\\Icons\\ExorcismBookG",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUpgrade",
		HelpTextId = "ToolExorcismBook2_Shop",
		Level = 2,
		ElementChance = 0.5,
		ElementName = "AirEssence",
		ElementPopupDelay = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ElementChance",
				Multiply = 100,
				NewProperty = "ElementChancePercent",
			},
		},
		Cost =
		{
			MetaCardPointsCommon = 30,
			OreIMarble = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolUpgradeSystem" }
			},
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
		Icon = "GUI\\Icons\\ShovelG",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUpgrade",
		HelpTextId = "ToolShovel2_Shop",
		Level = 2,
		ElementChance = 0.5,
		ElementName = "EarthEssence",
		ElementPopupDelay = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ElementChance",
				Multiply = 100,
				NewProperty = "ElementChancePercent",
			},
		},
		Cost =
		{
			PlantPOlive = 2,
			OreNBronze = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolUpgradeSystem" }
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolShovel" },
			}
		},
		TextureData =
		{
			Model = "ToolShovel_Mesh",
			Texture = "Models/Tools/ToolShovelLvl2_Color",
			Animation = "Melinoe_Shovel_Start",
		},
		SkipSpawnSkelly = true,
		FlavorText = "ToolShovel_FlavorText",
		PreRevealGlobalVoiceLines = "ToolShovelUpgradedVoiceLines",
	},

	ToolFishingRod2 =
	{
		Icon = "GUI\\Icons\\FishingRodG",
		IconScale = 1.0,
		UnlockTextId = "ToolShopUpgrade",
		HelpTextId = "ToolFishingRod2_Shop",
		Level = 2,
		ElementChance = 0.5,
		ElementName = "WaterEssence",
		ElementPopupDelay = 1.8,
		SimpleExtractValues =
		{
			{
				Property = "ElementChance",
				Multiply = 100,
				NewProperty = "ElementChancePercent",
			},
		},
		Cost =
		{
			PlantODriftwood = 2,
			OreQScales = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolUpgradeSystem" }
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" }
			}
		},
		TextureData =
		{
			Model = "ToolFishRod_AnimationMesh",
			Texture = "Models/Tools/ToolFishRodLvl2_Color",
			Animation = "Melinoe_Fishing_Start",
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

	CategoryIconScale = 0.45,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 450,
	ItemStartY = 220,
	ItemSpacingY = 96,
	IconOffsetX = -349,
	IconOffsetY = 0,
	IconScale = 0.5,
	ItemsPerPage = 6,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -400,

	KitCameraOffsetX = -300,

	NewIconOffsetX = 0,
	NewIconOffsetY = -5,

	ItemAvailableAffordableNameFormat =
	{
		OffsetX = -280,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {85, 202, 152, 255},
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
		OffsetX = -280,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostUnffordableShop,
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
		OffsetX = -280,
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
	PinOffsetY = -8,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
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
			"WeaponDagger",
			"WeaponTorch",
			"WeaponAxe",
			"WeaponLob",
			"WeaponSuit",
		},
		{
			Name = "WeaponShop_StaffUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Staff",
			WeaponName = "WeaponStaffSwing",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "WeaponStaffSwing" },
				},
				{
					PathFalse = { "CurrentRun", "WeaponsUnlocked", "WeaponStaffSwing" }
				},
			},

			"BaseStaffAspect2",
			"BaseStaffAspect3",
			"BaseStaffAspect4",
			"BaseStaffAspect5",

			"StaffClearCastAspect",
			"StaffClearCastAspect2",
			"StaffClearCastAspect3",
			"StaffClearCastAspect4",
			"StaffClearCastAspect5",

			"StaffSelfHitAspect",
			"StaffSelfHitAspect2",
			"StaffSelfHitAspect3",
			"StaffSelfHitAspect4",
			"StaffSelfHitAspect5",

			"StaffRaiseDeadAspect",
			"StaffRaiseDeadAspect2",
			"StaffRaiseDeadAspect3",
			"StaffRaiseDeadAspect4",
			"StaffRaiseDeadAspect5",
		},
		{
			Name = "WeaponShop_DaggerUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Dagger",
			WeaponName = "WeaponDagger",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
				},
				{
					PathFalse = { "CurrentRun", "WeaponsUnlocked", "WeaponDagger" }
				},
			},

			"DaggerBackstabAspect2",
			"DaggerBackstabAspect3",
			"DaggerBackstabAspect4",
			"DaggerBackstabAspect5",

			"DaggerBlockAspect",
			"DaggerBlockAspect2",
			"DaggerBlockAspect3",
			"DaggerBlockAspect4",
			"DaggerBlockAspect5",

			"DaggerHomingThrowAspect",
			"DaggerHomingThrowAspect2",
			"DaggerHomingThrowAspect3",
			"DaggerHomingThrowAspect4",
			"DaggerHomingThrowAspect5",

			"DaggerTripleAspect",
			"DaggerTripleAspect2",
			"DaggerTripleAspect3",
			"DaggerTripleAspect4",
			"DaggerTripleAspect5",
		},
		{
			Name = "WeaponShop_TorchUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Torch",
			WeaponName = "WeaponTorch",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch" },
				},
				{
					PathFalse = { "CurrentRun", "WeaponsUnlocked", "WeaponTorch" }
				},
			},

			"TorchSpecialDurationAspect2",
			"TorchSpecialDurationAspect3",
			"TorchSpecialDurationAspect4",
			"TorchSpecialDurationAspect5",

			"TorchDetonateAspect",
			"TorchDetonateAspect2",
			"TorchDetonateAspect3",
			"TorchDetonateAspect4",
			"TorchDetonateAspect5",

			"TorchSprintRecallAspect",
			"TorchSprintRecallAspect2",
			"TorchSprintRecallAspect3",
			"TorchSprintRecallAspect4",
			"TorchSprintRecallAspect5",

			"TorchAutofireAspect",
			"TorchAutofireAspect2",
			"TorchAutofireAspect3",
			"TorchAutofireAspect4",
			"TorchAutofireAspect5",
		},
		{
			Name = "WeaponShop_AxeUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Axe",
			WeaponName = "WeaponAxe",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe" },
				},
				{
					PathFalse = { "CurrentRun", "WeaponsUnlocked", "WeaponAxe" }
				},
			},

			"AxeRecoveryAspect2",
			"AxeRecoveryAspect3",
			"AxeRecoveryAspect4",
			"AxeRecoveryAspect5",

			"AxeArmCastAspect",
			"AxeArmCastAspect2",
			"AxeArmCastAspect3",
			"AxeArmCastAspect4",
			"AxeArmCastAspect5",

			"AxePerfectCriticalAspect",
			"AxePerfectCriticalAspect2",
			"AxePerfectCriticalAspect3",
			"AxePerfectCriticalAspect4",
			"AxePerfectCriticalAspect5",

			"AxeRallyAspect",
			"AxeRallyAspect2",
			"AxeRallyAspect3",
			"AxeRallyAspect4",
			"AxeRallyAspect5",
		},
		{
			Name = "WeaponShop_LobUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Lob",
			WeaponName = "WeaponLob",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob" },
				},
				{
					PathFalse = { "CurrentRun", "WeaponsUnlocked", "WeaponLob" }
				},
			},

			"LobAmmoBoostAspect2",
			"LobAmmoBoostAspect3",
			"LobAmmoBoostAspect4",
			"LobAmmoBoostAspect5",

			"LobCloseAttackAspect",
			"LobCloseAttackAspect2",
			"LobCloseAttackAspect3",
			"LobCloseAttackAspect4",
			"LobCloseAttackAspect5",

			"LobImpulseAspect",
			"LobImpulseAspect2",
			"LobImpulseAspect3",
			"LobImpulseAspect4",
			"LobImpulseAspect5",

			"LobGunAspect",
			"LobGunAspect2",
			"LobGunAspect3",
			"LobGunAspect4",
			"LobGunAspect5",
		},
		{
			Name = "WeaponShop_SuitUpgrades",
			Icon = "GUI\\Screens\\WeaponShop\\Icon-Suit",
			WeaponName = "WeaponSuit",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
				},
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit" },
				},
				{
					PathFalse = { "CurrentRun", "WeaponsUnlocked", "WeaponSuit" }
				},
			},

			"BaseSuitAspect2",
			"BaseSuitAspect3",
			"BaseSuitAspect4",
			"BaseSuitAspect5",

			"SuitHexAspect",
			"SuitHexAspect2",
			"SuitHexAspect3",
			"SuitHexAspect4",
			"SuitHexAspect5",

			"SuitMarkCritAspect",
			"SuitMarkCritAspect2",
			"SuitMarkCritAspect3",
			"SuitMarkCritAspect4",
			"SuitMarkCritAspect5",
			
			"SuitComboAspect",
			"SuitComboAspect2",
			"SuitComboAspect3",
			"SuitComboAspect4",
			"SuitComboAspect5",
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

			"ToolPickaxe2",
			"ToolExorcismBook2",
			"ToolShovel2",
			"ToolFishingRod2",
		},
	},

	Components = {},

	TooltipX = 1680,
	TooltipY = 1280,

	FadeOutTime = 0.3,

	CostDisplay =
	{
		StartX = 228,
		StartY = 858,
		SpacerX = 160,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,
	},

	ItemAvailableAnimation = "GUI\\Screens\\WeaponShop\\Button",
	ItemAvailableHighlightAnimation = "GUI\\Screens\\WeaponShop\\Button_Highlight",
	ItemPurchasedAnimation = "GUI\\Screens\\WeaponShop\\Button",
	ItemPurchasedHighlightAnimation = "GUI\\Screens\\WeaponShop\\Button_Highlight",
	CloseAnimation = "WeaponShopOut",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"CategoryBacking",
			"WeaponShopBackground",
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
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		WeaponShopBackground = 
		{
			AnimationName = "WeaponShopIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
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
			X = 228,
			Y = 876,
			ScaleX = 0.525,
			ScaleY = 0.51,
			Alpha = 0.0,
		},

		InfoBoxBacking =
		{
			Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
			X = 970,
			Y = 872,
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
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
			UseScreenScaleX = true,
		},

		ActionBarLeft =
		{
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Left",

			ChildrenOrder =
			{
				"ScrollLeft",
				"ScrollRight",
			},

			Children =
			{
				ScrollLeft = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "WeaponShopScreenPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "WeaponShopScreenNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},
			},
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
				"SelectButton",
				"PinButton",
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

-- Weapon Shop / Weapons
-- Silver Pool
GlobalVoiceLines.WeaponShopOpenedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelWeaponShopInteractSpeech", Time = 30 },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_1611", Text = "The Arms of Night are now at my disposal..." },
		{ Cue = "/VO/Melinoe_1898", Text = "...or shall be, soon enough.",
			PreLineWait = 0.8, BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1611" },
				},
			},
		},
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceGrantsHiddenAspect01" },
			},
		},
		{ Cue = "/VO/Melinoe_2464", Text = "A hidden Aspect... what sort of being is this Anubis?", BreakIfPlayed = true },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGrantsHiddenAspect01" },
			},
		},

		{ Cue = "/VO/Melinoe_3994", Text = "The hidden Aspect of the Morrigan...", BreakIfPlayed = true },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsHiddenAspect01" },
			},
		},

		{ Cue = "/VO/Melinoe_4374", Text = "The hidden Aspect of Supay...", BreakIfPlayed = true },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGrantsHiddenAspect01" },
			},
		},
		{ Cue = "/VO/Melinoe_4380", Text = "The hidden Aspect of Nergal...", BreakIfPlayed = true },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHiddenAspect01" },
			},
		},
		{ Cue = "/VO/Melinoe_4386", Text = "The hidden Aspect of Hel...", BreakIfPlayed = true },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGrantsHiddenAspect01" },
			},
		},
		{ Cue = "/VO/Melinoe_4392", Text = "The hidden Aspect of Shiva...", BreakIfPlayed = true },
	},
	{
		PlayOnce = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},

		{ Cue = "/VO/Melinoe_3392", Text = "So much to choose from now..." },
		{ Cue = "/VO/Melinoe_3393", Text = "Where to even begin...?",
			PreLineWait = 0.8, BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_3392" },
				},
			},
		},
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.1,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0570", Text = "The Silver Pool...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3395", Text = "The Arms of Night..." },
		{ Cue = "/VO/Melinoe_3396", Text = "What secrets lie within?" },
		{ Cue = "/VO/Melinoe_3397", Text = "Much deeper than it looks..." },
		{ Cue = "/VO/Melinoe_3829", Text = "The depths of the Silver Pool...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" }
				},
			},
		},
		{ Cue = "/VO/Melinoe_1899", Text = "Much more than just this staff bathing in there.", PlayFirst = true, PlayOnce = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" }
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_0570" },
				},
			},
		},
	},
}
GlobalVoiceLines.WeaponShopExpandedVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentHubRoom", "Name" },
			IsAny = { "Hub_PreRun"},
		},
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "ToolsShopIntro",
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeToolsShop" },
			},
		},
		{ Cue = "/VO/Melinoe_0571", Text = "There's something new here..." },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "AspectsShopIntro",
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		{ Cue = "/VO/Melinoe_2541", Text = "The Aspects of the Nocturnal Arms..." },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "ShopExpandedSpeech", Time = 10 },
		},

		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm!" },
	},
}
GlobalVoiceLines.WeaponUnlockGlobalVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0572", Text = "Awaken, Arms of Night, and join with me!", PlayFirst = true },
		-- { Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0214", Text = "This one." },
		{ Cue = "/VO/Melinoe_0215", Text = "How about..." },
		-- { Cue = "/VO/Melinoe_0216", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0217", Text = "You." },
		{ Cue = "/VO/Melinoe_0218", Text = "Why not." },
		{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
		{ Cue = "/VO/Melinoe_0220", Text = "{#Emph}Heh." },
		-- { Cue = "/VO/Melinoe_0234", Text = "Open." },
		{ Cue = "/VO/Melinoe_0236", Text = "This one." },
		-- { Cue = "/VO/Melinoe_0237", Text = "You're mine." },
		{ Cue = "/VO/Melinoe_0238", Text = "Sure." },
		{ Cue = "/VO/Melinoe_0239", Text = "Join with me." },
		-- { Cue = "/VO/Melinoe_0240", Text = "You are mine now." },
	},
	{ GlobalVoiceLines = "SkellyWeaponUnlockReactionVoiceLines" },
}

GlobalVoiceLines.AnyAspectUpgradedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.2,
	-- SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
	},
	TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

	{ Cue = "/VO/Melinoe_2549", Text = "Awaken, hidden power." },
	{ Cue = "/VO/Melinoe_2550", Text = "There's more to this Aspect." },
	{ Cue = "/VO/Melinoe_2551", Text = "Let our bond grow strong." },
	{ Cue = "/VO/Melinoe_2552", Text = "Become even stronger." },
	{ Cue = "/VO/Melinoe_2553", Text = "Such power hides within." },
	{ Cue = "/VO/Melinoe_2554", Text = "Show me your true strength." },
	{ Cue = "/VO/Melinoe_2555", Text = "You are bound to me, and I am your bearer." },
	{ Cue = "/VO/Melinoe_2556", Text = "Draw greater power from the Silver Pool." },
}

GlobalVoiceLines.StaffAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2545", Text = "Descura: Awaken!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2546", Text = "Descura, reveal your secrets!" },
	},
	{ GlobalVoiceLines = "AnyAspectUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
}
GlobalVoiceLines.DaggerAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2547", Text = "Lim and Oros: Awaken!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2548", Text = "Lim and Oros, reveal your secrets!" },
	},
	{ GlobalVoiceLines = "AnyAspectUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
}

GlobalVoiceLines.AxeAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_3743", Text = "Zorephet: Awaken!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3744", Text = "Zorephet, reveal your secrets!" },
	},
	{ GlobalVoiceLines = "AnyAspectUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
}

GlobalVoiceLines.TorchAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_3741", Text = "Ygnium: Awaken!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3742", Text = "Ygnium, reveal your secrets!" },
	},
	{ GlobalVoiceLines = "AnyAspectUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
}

GlobalVoiceLines.LobAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_3745", Text = "Revaal: Awaken!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3746", Text = "Revaal, reveal your secrets!" },
	},
	{ GlobalVoiceLines = "AnyAspectUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
}

GlobalVoiceLines.SuitAspectUpgradedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAspectUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_3738", Text = "Xinth: Awaken!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3739", Text = "Xinth, reveal your secrets!" },
	},
	{ GlobalVoiceLines = "AnyAspectUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyWeaponUpgradeReactionVoiceLines" },
}

GlobalVoiceLines.ToolUnlockGlobalVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
		},

		{ Cue = "/VO/Melinoe_0235", Text = "Open up." },
		{ Cue = "/VO/Melinoe_0216", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0237", Text = "You're mine." },
		{ Cue = "/VO/Melinoe_0240", Text = "You are mine now." },
	},
	{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
}
GlobalVoiceLines.AnyToolUpgradedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.2,
	-- SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
	},
	TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

	{ Cue = "/VO/Melinoe_2561", Text = "May you shine like the Moon." },
	{ Cue = "/VO/Melinoe_2562", Text = "Bathe now in the light of the Moon." },
}
GlobalVoiceLines.ToolPickaxeUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2557", Text = "The Crescent Pick achieves a greater form..." },
	},
	{ GlobalVoiceLines = "AnyToolUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
}
GlobalVoiceLines.ToolExorcismBookUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2559", Text = "New life for the Tablet of Peace." },
	},
	{ GlobalVoiceLines = "AnyToolUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
}
GlobalVoiceLines.ToolShovelUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2558", Text = "The Silver Spade shines even brighter now." },
	},
	{ GlobalVoiceLines = "AnyToolUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
}
GlobalVoiceLines.ToolFishingRodUpgradedVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.2,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeMiscToolEquipSpeech", Time = 10 },
		},
		TriggerCooldowns = { "MelWeaponShopInteractSpeech" },

		{ Cue = "/VO/Melinoe_2560", Text = "The Rod of Fishing should be stronger now." },
	},
	{ GlobalVoiceLines = "AnyToolUpgradedVoiceLines" },
	{ GlobalVoiceLines = "SkellyToolUnlockReactionVoiceLines" },
}