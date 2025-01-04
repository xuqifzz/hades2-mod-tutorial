FamiliarOrderData =
{
	"CatFamiliar",
	"FrogFamiliar",
	"RavenFamiliar",
	"HoundFamiliar",
}

FamiliarData = 
{
	BaseFamiliar = 
	{
		InheritFrom = { "BaseAlly", "BaseVulnerableEnemy" },

		BlocksLootInteraction = false,
		SkipDefaultSetup = true,
		DebugOnly = true,
		UseText = "FamiliarUseText",
		OnUsedFunctionName = "UseFamiliar",
		Icon = "Tilesets\\Graybox\\TestButton",
		MovementType = "Direct",
		AnimOffsetZ = 150,
		BaseResourceSpawnChance = 0.03,
		TickForRested = 30,
		RestBonusResourceSpawnChance = 0.25,

		EquipVoiceLines =
		{
			[1] = { GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
		GameStateRequirements = 
		{
			Force = true,
		},

		CanReceiveGift = true,
		UnlimitedGifts =
		{
			FamiliarPoints = true,
		},

		IgnoreTypeAutoActivate = true,
		MaxHealth = 400,
		IgnoreDamage = true,
		HealthBarOffsetY = -145,
		HealthBarType = "MediumLarge",
		AnimOffsetZ = 120,
		Groups = "nil",
		Material = "Bone",

		DefaultAIData = 
		{
			DeepInheritance = true,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",

			AttackDistance = 350,
			RetreatAfterAttack = false,

			RequireProjectileLoS = true,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
			AngleTowardsTargetWhileFiring = false,
			TrackTargetDuringCharge = false,

			TargetClosest = true,
		},

		AIOptions =
		{
			"FollowAI",
		},
		DefaultAIData = 
		{
			FollowDistance = 100,
			FollowSuccessDistance = 50,
		},
		WakeUpDelay = 0.2,

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		SimpleExtractValues =
		{
			{
				Property = "RestBonusResourceSpawnChance",
				Multiply = 100,
				NewProperty = "RestBonusResourceSpawnChancePercent",
			},
		},
	},

	-- Frinos
	FrogFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		Icon = "GUI\\Icons\\Tool_Book_Frog",
		LinkedTool = "ToolExorcismBook",
		TraitName = "HealthFamiliar",
		KitAngle = 235,
		AnimOffsetZ = 140,

		MarkerModel = "FrogMarker_Mesh",
		MarkerIdleAnimation = "FrogMarkerIdle",
		MarkerMoveAnimation = "FrogMarkerMove",
		MarkerJumpAnimation = "FrogMarkerJump",

		BaseResourceSpawnChance = 0.12,
		RestBonusResourceSpawnChance = 0.03,

		ActivatePresentationFunctionName = "FrogFamiliarSpawnPresentation",
		MoveFunctionName = "FrogFamiliarMoveToLocation",
		
		StartNewRunAnimation = "Familiar_Frog_GoUp",
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Frog_GoUp",
					VfxOffsetY = -160,
					VfxDelay = 0.4,
					VfxScale = 1.25,
				},
			},
		},

		EncounterEndEvents =
		{
			{
				FunctionName = "FamiliarVictoryPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					SetAnimation = "Familiar_Frog_Victory",
					Sound = "/SFX/Familiars/FrogCroak2",
				},
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "CatFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
						{
							Path = { "CurrentHubRoom", "Name" },
							Comparison = "==",
							Value = "Hub_PreRun",
						},
						{
							Path = { "GameState", "WorldUpgrades", },
							NotHasAll =
							{
								"FrogHealthBonus",
								"FrogHealthBonus2",
								"FrogHealthBonus3",
								"FrogUses",
								"FrogUses2",
								"FrogUses3",
								"FrogDamage",
								"FrogDamage2",
								"FrogDamage3",
								--"FrogDeflect",
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
					},
				},
			},
		},

		GiftFunctionName = "FrogFamiliarRecruit",
		GiftFunctionArgs =
		{
			Delay = 0.1,
			Title = "FamiliarRecruited",
			Text = "FrogFamiliar",
			TextOffsetY = -30,
			TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3",
			AnimationName = "LocationTextBGRelationship",
			AnimationOutName = "LocationTextBGRelationshipOut",
			Icon = "FamiliarIcon_Frog",
			PlayRecruitVoiceLines = true,

			UnlockSequenceDuration = 6.6,
			UnlockStartAnimation = "Familiar_Frog_RecruitStart",
			--UnlockEndAnimation = "Familiar_Cat_Sleep_Awaken",
			UnlockExitAnimation = "Familiar_Frog_HopStart",
		},

		-- SpecialInteractCooldown = 6,
		SpecialInteractFunctionName = "PetFamiliarFrog",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				IsAny = { "Hub_Main" },
			},
		},

		UseTextGift = "FamiliarUseTextGift_First",
		UseTextTalkGiftAndSpecial = "FamiliarUseTextTalkGiftAndSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "FamiliarUseTextTalkAndSpecial",
		UseTextGiftAndSpecial = "FamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "FamiliarUseTextSpecial",

		AlwaysShowDefaultUseText = true,

		EquipSound = "/SFX/Familiars/FrogCroak2",
		HappySound = "/SFX/Familiars/FrogCroak2",
		ConfirmSound = "/SFX/Familiars/FrogCroak1",
		FearSound = "/SFX/Familiars/FrogCroakMiffed",

		IdleAnimation = "Familiar_Frog_Idle",
		HappyAnimation = "Familiar_Frog_Greet",
		TurnInPlaceAnimation = "Familiar_Frog_HopStart_AutoLand",

		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar", },
			},
		},
		
		EffortSound = "/SFX/Familiars/FrogCroak1",
		HarvestSound = "/SFX/Familiars/FrogCroakAngry1",
		VictorySound = "/SFX/Familiars/FrogCroakAngry2",
		VictoryEmoteAnim = "StatusIconSmile",
		ConfirmEmoteAnim = "StatusIconSmile",

		AIOptions =
		{
			"FrogFollowAI",
		},
		DefaultAIData = 
		{
			PlayerMinOffset = 150,
			PlayerOffset = 250,
			ForceHopChance = 0,		-- chance to hop no matter what
			HopRestDistance = 750,		-- distance within which to not hop
			HopNonCombatRestDistance = 660,
			HopRestDistanceScaleY = 0.6,
			MaxLeapDistance = 850,
			MaxLeapDistanceScaleY = 0.6,
			LeapPrepareTime = 0.1, 
			LeapRecoveryTime = 4.5,
			LeapNonCombatRecoveryTime = 0.15,
			LeapFastRecoveryTime = 0.5,
			LeapFastRecoveryDistance = 1100,
			LeapFastRecoveryDistanceScaleY = 0.6,
			LeapSpeed = 1200,
			LeapLandingProjectile = "FrogFamiliarLand",
			LeapChargeSound = "/SFX/Familiars/FrogCroak2",
			LeapSound = "/SFX/Familiars/FrogLeap",
			LeapChargeAnimation = "Familiar_Frog_HopStart",
			LeapLandingAnimation = "Familiar_Frog_HopTouchdown",
		},
		OnHitFunctionName = "FrogHitResponse",
		OnHitForce = 400,
		OnHitHangTime = 0.1,

		OnHitVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.25,
				ObjectType = "Hecate",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "HecatePolymorph" },
					},
				},
				Cooldowns =
				{
					{ Name = "HecateRecentHexDodgeVO", Time = 240 },
				},
				TriggerCooldowns = { "HecateSpokeRecently" },
				{ Cue = "/VO/HecateField_0137", Text = "That blasted little toad..." },
				{ Cue = "/VO/HecateField_0138", Text = "That hex was meant for {#Emph}you!", PlayFirst = true },
			},
		},

		InteractVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "MelinoeFrinosInteractSpeech", Time = 120 },
				},
				-- first run
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosSpeechFirstRun",
					PreLineWait = 0.4,
					BreakIfPlayed = true,
					--PreLineAnim = "MelTalkBrooding01",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Cleared" }
						},
						{
							PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
						},
					},

					{ Cue = "/VO/Melinoe_2948", Text = "See what I get for staying out all night, Frinos?" },
				},
				-- post-moros meeting 1
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
						},
					},

					{ Cue = "/VO/Melinoe_3438", Text = "I just met Doom Incarnate, Frinos...! Not sure I should be excited about that." },
				},
				-- post-moros meeting 2
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "MorosSecondAppearance" },
						},
					},

					{ Cue = "/VO/Melinoe_3439", Text = "Happen to see a tall, horned fellow passing through...?" },
				},
				-- post-moros surface meeting
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
						},
					},

					{ Cue = "/VO/Melinoe_3440", Text = "The way you can breathe out of water... so too could I breathe the surface air." },
				},
				-- post-flashback01
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
						},
					},

					{ Cue = "/VO/Melinoe_2132", Text = "All my life I've prepared, and I'm nowhere near ready, am I..." },
				},
				-- post-flashback02
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosNightmare01" },
						},
					},

					{ Cue = "/VO/Melinoe_2836", Text = "Chronos has my family... and the Fates themselves...? Oh, Frinos..." },
				},
				-- successful clears
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							-- PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
						},
						{
							PathTrue = { "CurrentRun", "Cleared" },
						},
					},

					{ Cue = "/VO/Melinoe_2845", Text = "Can you believe it, little one? I did it... I got him...! What now...?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "I_Boss01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2846", Text = "You knew I could do it, didn't you, Frinos?" },
					{ Cue = "/VO/Melinoe_2847", Text = "We really showed him, didn't we, Frinos?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "I_Boss01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2848", Text = "A satisfactory result that time, wouldn't you say?" },
					{ Cue = "/VO/Melinoe_2849", Text = "Got him again. But we're not finished yet, are we?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "I_Boss01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2850", Text = "Glad to be back here with you... but, it's a new night now..." },
					{ Cue = "/VO/Melinoe_2931", Text = "I suppose you'd not have liked it, living in that House instead of here...",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
							},
						},
					},
				},
				-- cleared Chaos Trial
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun" },
							HasAny = { "BountyCleared" }
						},
					},
					{ Cue = "/VO/Melinoe_3062", Text = "These Chaos Trials... we're not changing reality {#Emph}too {#Prev}much, are we, Frinos?" },
					{ Cue = "/VO/Melinoe_3063", Text = "Either Chaos has an interest in my victory, or perhaps I'm just a bit of entertainment." },
				},
				-- considering recruiting Frinos
				{
					PlayOnce = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "WorldUpgradesRevealed" },
							HasAny = { "WorldUpgradeFamiliarPoints" },
						},
						{
							PathFalse = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" }
						},
					},

					{ Cue = "/VO/Melinoe_3145", Text = "One of these evenings you ought to join me out there, little one. Long as I can protect you." },
				},
				-- returned with Frinos as a familiar
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosJoinedAndReturnedSpeech",
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "FrogFamiliar" },
						},
					},
					{ Cue = "/VO/Melinoe_1091", Text = "We made it back here safe and sound, didn't we, Frinos?" },
				},
				-- lost in Nemesis encounter
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
							IsAny = { "NemesisCombatF", "NemesisCombatG", "NemesisCombatH" },
						},
					},
					{ Cue = "/VO/Melinoe_2316", Text = "Do you think Nemesis is trying to help, or just trying to win?" },
				},
				-- lost to Erebus minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "F_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_1675", Text = "I've faced Root-Stalkers before... it's like I drew a blank out there..." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "F_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_1676", Text = "How could I lose to some Shadow-Spiller like that? {#Emph}Ungh{#Prev}, unacceptable..." },
				},
				-- lost to Hecate
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "F_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Hecate" },
						},
					},
					{ Cue = "/VO/Melinoe_1887", Text = "She was on her last legs, but I just couldn't finish the job.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
								Comparison = "<=",
								Value = 0.15,
							},
						},
					},
					{ Cue = "/VO/Melinoe_0091", Text = "Frinos, how can I ever beat the Headmistress...?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "HecateBossOutro01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_0092", Text = "The Headmistress got me again, Frinos... but I won't back down." },
					{ Cue = "/VO/Melinoe_2310", Text = "Feels like three against one when I face Headmistress out there..." },
					{ Cue = "/VO/Melinoe_2311", Text = "She's taught me to be stronger than this. I'll prove it to her yet..." },
				},
				-- lost to Oceanus minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "G_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_2315", Text = "Some amphibians eat rodents, don't they, Frinos...?" },
				},
				-- lost to Scylla
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "G_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Scylla" },
						},
					},
					{ Cue = "/VO/Melinoe_2312", Text = "Frinos, I can't get that blasted Siren song out of my head..." },
					{ Cue = "/VO/Melinoe_2313", Text = "Sirens are amphibious... you know their weaknesses, Frinos?", PlayFirst = true },
				},
				-- lost in Oceanus
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "G" },
						},
					},
					{ Cue = "/VO/Melinoe_2314", Text = "You might like it down in Oceanus better than I do right now..." },
				},
				-- lost to Fields minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "H_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_2765", Text = "Phantoms must be thrilled to find fresh blood, I suppose..." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "H_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_2764", Text = "I don't think you and Lamia would get along too well, Frinos..." },
				},
				-- lost to Cerberus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "H_Boss01", },
						},
						--[[
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						]]--
					},

					{ Cue = "/VO/Melinoe_2762", Text = "That was my family's dog... it has to be. I have to help him...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2763", Text = "Cerberus can't see through his rage... he needs our help, Frinos." },
					-- { Cue = "/VO/Melinoe_2713", Text = "That monster had three heads, Frinos... you don't suppose...?" },
				},
				-- lost in Fields
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "H" },
						},
					},
					{ Cue = "/VO/Melinoe_2712", Text = "Well {#Emph}that {#Prev}was a decidedly unhappy place, wasn't it...?", PlayFirst = true },
					{ Cue = "/VO/Melinoe_2714", Text = "My spirit nearly broke back there... I couldn't hold on." },
					{ Cue = "/VO/Melinoe_2715", Text = "Such misery and sorrow in those Fields... but I have to get through." },
				},
				-- lost to Chronos
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "I_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Chronos" },
						},
					},

					{ Cue = "/VO/Melinoe_2809", Text = "I got all the way to Chronos... the one place I can beat him. But I couldn't do it. Not yet...", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "EnemyKills", "Chronos" },
							},
						}
					},
					{ Cue = "/VO/Melinoe_2810", Text = "Chronos underestimates me still... which means I have a real chance to vanquish him..." },
				},
				-- lost in Tartarus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "I" },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
					},
					{ Cue = "/VO/Melinoe_2840", Text = "Where does Chronos find those blasted Satyrs, anyway...?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name", },
								IsNone = { "I_MiniBoss02" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2837", Text = "Almost got there, but then, almost isn't good enough, is it?" },
					{ Cue = "/VO/Melinoe_2838", Text = "What have they done to Tartarus, Frinos? It's not like how I heard..." },
					{ Cue = "/VO/Melinoe_2839", Text = "I expected the worst down in Tartarus, and I got it all right..." },
				},

				-- lost to Polyphemus
				{
					-- RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "N_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Polyphemus" },
						},
					},

					{ Cue = "/VO/Melinoe_0359", Text = "You ever faced a Cyclops, Frinos? No?" },
					{ Cue = "/VO/Melinoe_3831", Text = "I figured Cyclopes were very strong, but didn't need to learn firsthand like that..." },
				},
				-- lost in Ephyra
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "N" },
						},
						{
							PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
						},
					},
					{ Cue = "/VO/Melinoe_2841", Text = "The air up there did not sit well with me at all...", PlayFirst = true },
					{ Cue = "/VO/Melinoe_2842", Text = "Not my finest night back there, but I had to try..." },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "N" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsNone = { "N_Opening01", "N_PreHub01", "N_Boss01" },
						},
					},
					{ Cue = "/VO/Melinoe_2843", Text = "It's possible I'm not cut out for city life, Frinos..." },
					{ Cue = "/VO/Melinoe_2844", Text = "Not much in the way of hospitality in that big city up there..." },
				},

				-- lost to Eris
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "O_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Eris" },
						},
					},
					{ Cue = "/VO/Melinoe_3170", Text = "How can a daughter of Nyx turn against us? And give me such a drubbing, too...", PlayFirst = true },
					{ Cue = "/VO/Melinoe_3171", Text = "No making peace with one such as Eris, is there? Just isn't in her nature." },
				},
				-- lost to Charybdis
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "O_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_3819", Text = "Few sailors live to speak of their encounters with Charybdis, so there's that, Frinos..." },
				},
				-- lost in Ships
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsNone = { "O_Boss01" },
						},
					},
					{ Cue = "/VO/Melinoe_3172", Text = "I'm getting the impression that the sailor's life is not for me." },
					{ Cue = "/VO/Melinoe_3173", Text = "I used to dream of sailing on the surface seas, but not like that..." },
				},

				-- lost to Prometheus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "P_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Prometheus" },
						},
					},
				{ Cue = "/VO/Melinoe_3817", Text = "If Prometheus knows everything that's going to happen, then he must know I'm not giving up..." },
				{ Cue = "/VO/Melinoe_3818", Text = "That Titan's hatred for the gods... it's clouded his senses. He can be beaten." },
				},
				-- lost to Olympus minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "P_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_3820", Text = "So many problems on Olympus to contend with, and Talos is against me, too...?" },
				},
				--[[
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "P_MiniBoss02" },
						},
					},
					-- { Cue = "/VO/Melinoe_3821", Text = "You know things are bad on Olympus when Dragons not just Harpies are beginning to roost there." },
				},
				]]--

				-- lost on Olympus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					},
					{ Cue = "/VO/Melinoe_3822", Text = "The mountain of the gods unfortunately wasn't as welcoming as I would have preferred..." },
					{ Cue = "/VO/Melinoe_3823", Text = "Turns out that climbing Mount Olympus can be rather treacherous, Frinos.", PlayFirst = true },
				},

				-- lost due to Oath / Shrine
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpentShrinePointsCache", },
							Comparison = ">=",
							Value = 8,
						},
					},
					{ Cue = "/VO/Melinoe_3060", Text = "{#Emph}Ungh{#Prev}, Frinos... perhaps I ought know better than to tamper with the Oath of the Unseen." },
					{ Cue = "/VO/Melinoe_3061", Text = "I spoke the Oath, it's only fair I face the consequence, Frinos..." },
				},

				-- raining
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "NextBiomeStateName" },
							IsAny = { "Rain" },
						},
					},

					{ Cue = "/VO/Melinoe_1886", Text = "You're liking all this rain, right, little one?" },
				},

				-- other general cases
				{
					PreLineWait = 0.4,
					BreakIfPlayed = true,
					RandomRemaining = true,
					--PreLineAnim = "MelTalkBrooding01",

					{ Cue = "/VO/Melinoe_1091", Text = "We made it back here safe and sound, didn't we, Frinos?",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_1091" },
							},
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "FrogFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_1162", Text = "See, Frinos? I wasn't gone for very long at all.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RunDepthCache" },
								Comparison = "<=",
								Value = 15,
							},
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 10,
							},
						},
					},
					{ Cue = "/VO/Melinoe_0831", Text = "Damn it, Frinos. I can't do this. What if I can't do this?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 8,
							},
							{
								PathTrue = { "GameState", "RoomCountCache", "N_Opening01" },
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsNone = { "H", "I", "O", "P", "Q" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_0832", Text = "What happened there, Frinos? I should be better than this.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0833", Text = "I know I could have done better than that.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0090", Text = "Blasted wretch got me, Frinos. I'll keep a healthier distance next time." ,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name", },
								IsNone = { "F_Boss01", },
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsAny = { "F", "H", "I", "N" },
							},
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_0012_V3", Text = "That positively didn't go as planned, Frinos. Will you ever forgive me?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0354", Text = "I blundered into that back there, didn't I, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0355", Text = "I think I made a few mistakes back there, Frinos.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0356", Text = "I'll have to be more careful, won't I, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0360", Text = "You don't want to know what happened there, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_1677", Text = "You know what they say, Frinos: Failure is the greatest instructor of all.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_2811", Text = "You can probably imagine how that went, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_2812", Text = "Just don't go telling anybody how I blundered back there, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_2948", Text = "See what I get for staying out all night, Frinos?",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Cleared" }
							},
							{
								Path = { "CurrentRun", "BiomesReached" },
								HasAny = { "G", "O" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3824", Text = "What do you suppose I could have done differently last night, {#Emph}hm?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_3441", Text = "Always here for me, aren't you..." },
					{ Cue = "/VO/Melinoe_3442", Text = "Another night, another lesson learned..." },
					{ Cue = "/VO/Melinoe_3443", Text = "You're always watching over me... you and these little Shades..." },
					{ Cue = "/VO/Melinoe_0357", Text = "Thank you for helping me return, Frinos." },
					{ Cue = "/VO/Melinoe_0358", Text = "Hey Frinos. I had better go. So you take care." },
					{ Cue = "/VO/Melinoe_3825", Text = "I'm rested enough to press on, but you relax some more, all right?" },
					{ Cue = "/VO/Melinoe_3826", Text = "Thanks for looking after things around here while I was out, Frinos.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "FrogFamiliar" },
							},
						}
					},
					{ Cue = "/VO/Melinoe_3827", Text = "I'd best get back to it, Frinos. But I wanted to say hi before I headed off again." },
				},
			},
			-- multi-pet lines
			{
				PreLineWait = 0.4,
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1888", Text = "{#Emph}Mmm-mwah.", PreLineWait = 1.0, PlayFirst = true },
				{ Cue = "/VO/Melinoe_1889", Text = "{#Emph}Mmm-hmhmhm.", PreLineWait = 0.8 },
				{ Cue = "/VO/Melinoe_1890", Text = "You're always here for me." },
				{ Cue = "/VO/Melinoe_1891", Text = "Don't let me get you down." },
				{ Cue = "/VO/Melinoe_1892", Text = "You stay right there, OK?" },
				{ Cue = "/VO/Melinoe_1893", Text = "Come here you little bug.", PreLineWait = 0.6 },
			},
			{
				PreLineWait = 0.65,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1888", Text = "{#Emph}Mmm-mwah.", PreLineWait = 1.0, PlayFirst = true },
				{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>",	PreLineWait = 0.4 },
				{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
				{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh." },
				{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Melinoe_0220", Text = "{#Emph}Heh." },
				{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
			},
		},

		RecruitVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_Main" },
				},
			},

			{ Cue = "/VO/Melinoe_2766", Text = "This is a very special treat, Frinos." },
			{ Cue = "/VO/Melinoe_2767", Text = "It means you'll be protected when you're with me; and you can protect me, in turn.", PreLineWait = 0.8 },
		},

		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidFrinosRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2500", Text = "Come, Frinos." },
				{ Cue = "/VO/Melinoe_2501", Text = "Join me, Frinos?" },
				{ Cue = "/VO/Melinoe_3880", Text = "Let's go, Frinos." },
			},
			[2] = { GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
	},

	-- Toula
	CatFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		Icon = "GUI\\Icons\\Tool_FishingRod_Cat",
		LinkedTool = "ToolFishingRod",
		TraitName = "LastStandFamiliar",
		EquipObjective = "ActivateCatFamiliar",
		OnFieldsEncounterActivatedFunctionName = "CatFamiliarFieldsTeleportPresentation",

		MarkerModel = "CatMarker_Mesh",
		MarkerIdleAnimation = "CatMarkerIdle",
		MarkerMoveAnimation = "CatMarkerMove",
		MarkerJumpAnimation = "CatMarkerJump",

		BaseResourceSpawnChance = 0.10,
		RestBonusResourceSpawnChance = 0.025,

		NumAttacks = 1,
		MinDistanceToTeleportForFishing = 550,
		MinDistanceToTeleportInFields = 550,

		NonHeroKillCombatText = "PartnerKill",

		ActivatePresentationFunctionName = "CatFamiliarSpawnPresentation",
		MoveFunctionName = "CatFamiliarMoveToLocation",

		UpgradedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					OverwriteSourceKeys =
					{
						ReadyToAttack = false,
					},
					SetAnimation = "Familiar_Cat_Victory",
					Sound = "/SFX/Familiars/CatMeow1",
					EndFunctionName = "GenericPresentation",
					EndFunctionArgs =
					{
						PreWait = 6.0,
						OverwriteSourceKeys =
						{
							ReadyToAttack = true,
						}
					},
				},
			},
		},

		EncounterEndEvents =
		{
			{
				FunctionName = "FamiliarVictoryPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					OverwriteSourceKeys =
					{
						ReadyToAttack = false,
					},
					SetAnimation = "Familiar_Cat_Victory",
					Sound = "/SFX/Familiars/CatMeow1",
					EndFunctionName = "GenericPresentation",
					EndFunctionArgs =
					{
						PreWait = 6.0,
						OverwriteSourceKeys =
						{
							ReadyToAttack = true,
						}
					},
				},
			},
		},

		StartNewRunAnimation = "Familiar_Cat_DropIn_Exit",
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Cat_DropIn_Exit",
					VfxDelay = 0.2,
					VfxOffsetY = -80,
					VfxScale = 1.1,
					StopAnimations = { "CatFamiliarRecruitHighlight" },
				},
			},
		},

		LastStandEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 0.05,
					OverwriteSourceKeys =
					{
						ReadyToAttack = false,
					},
					AngleTowardHero = true,
					SetAnimation = "Familiar_Cat_DeathDefiance",
					Sound = "/SFX/Familiars/CatMeow1",
					EndFunctionName = "GenericPresentation",
					EndFunctionArgs =
					{
						PreWait = 5.0,
						OverwriteSourceKeys =
						{
							ReadyToAttack = true,
						}
					},
				},
			},
		},

		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar", },
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "CatFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
						{
							Path = { "GameState", "WorldUpgrades", },
							NotHasAll =
							{
								"CatLastStandHeal",
								"CatLastStandHeal2",
								"CatLastStandHeal3",
								"CatUses",
								"CatUses2",
								"CatUses3",
								"CatAttack",
								"CatAttack2",
								"CatAttack3",
								--"CatCrit",
							},
						}
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
				},
			},
		},

		GiftFunctionName = "CatFamiliarRecruit",
		GiftFunctionArgs =
		{
			Delay = 0.1,
			Title = "FamiliarRecruited",
			Text = "CatFamiliar",
			TextOffsetY = -30,
			TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3",
			AnimationName = "LocationTextBGRelationship",
			AnimationOutName = "LocationTextBGRelationshipOut",
			Icon = "FamiliarIcon_Cat",
			PlayRecruitVoiceLines = true,

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Cat_Recruit",
			UnlockEndAnimation = "Familiar_Cat_Sleep_Awaken",
			UnlockExitAnimation = "Familiar_Cat_DropIn_Exit",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "CatFamiliar" },
			},
		},

		SpecialInteractFunctionName = "CatFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "CatFamiliarReadyToRecruit" },
		},

		UseTextGift = "CatFamiliarUseTextGift_First",
		UseTextTalkGiftAndSpecial = "CatFamiliarUseTextTalkGiftAndSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "CatFamiliarUseTextTalkAndSpecial",
		UseTextGiftAndSpecial = "CatFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "CatFamiliarUseTextSpecial",

		AlwaysShowDefaultUseText = true,

		IdleAnimation = "Familiar_Cat_Idle",
		HappyAnimation = "Familiar_Cat_Greet",
		FleeAnimation = "Familiar_Cat_DropIn_Exit",
		TurnInPlaceAnimation = "Familiar_Cat_Meow",

		AlertedSound = "/Leftovers/SFX/PositiveTalismanProc_1",
		EquipSound = "/SFX/Familiars/CatMeow1",
		HappySound = "/SFX/Familiars/CatPurr",
		ConfirmSound = "/SFX/Familiars/CatMeow1",
		FearSound = "/SFX/Familiars/CatMeow2",
		FleeEmote = "StatusIconFear",

		DefaultAIData =
		{
			DeepInheritance = true,

			RecruitDistance = 200,
			RecruitAnimation = "CatFamiliarRecruitHighlight",
			RecruitAnimationScale = 1.0,

			TargetSearchDistance = 1500,
			AttackDistance = 500,
			AttackVelocity = 2000,

			WanderDistance = 2000,
			WanderDistanceScaleY = 0.6,
		},

		PreAttackVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				ChanceToPlay = 0.2,
				PreLineWait = 0.15,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "UsedCatFamiliarRecently", Time = 400 },
				},

				{ Cue = "/VO/Melinoe_0132", Text = "Go!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0335", Text = "Smite them!",
					GameStateRequirements =
					{
						{
							Path = { "RequiredKillEnemies" },
							UseLength = true,
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				
			},
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 1.0,
			},
		},

		AIOptions =
		{
			"CatFamiliarAI",
		},

		SpecialInteractCooldown = 30,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},


				{ Cue = "/VO/Melinoe_0983", Text = "Are you lost, little one?", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_0985", Text = "Don't be afraid...", },
				{ Cue = "/VO/Melinoe_2509", Text = "Here, girl." },
				{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
				{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoePettedCatSpeech", Time = 12 },
				},

				{ Cue = "/VO/Melinoe_3398", Text = "Good girl." },
				{ Cue = "/VO/Melinoe_3399", Text = "There's a good girl.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3400", Text = "Hey..." },
				{ Cue = "/VO/Melinoe_3401", Text = "What's the good word...?" },
				{ Cue = "/VO/Melinoe_3402", Text = "{#Emph}<Chuckle>" },
				{ Cue = "/VO/Melinoe_3403", Text = "{#Emph}Tk-tk-tk." },
				{ Cue = "/VO/Melinoe_3404", Text = "{#Emph}Tk-tk-tk-tk!" },
				{ Cue = "/VO/Melinoe_2509", Text = "Here, girl." },
			},
		},

		RecruitVoiceLines =
		{
			PreLineWait = 0.35,
			GameStateRequirements = 
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_1915", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_1916", Text = "We do! Your name is Toula, isn't it?", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_1918", Text = "Let us protect each other from now on.", PreLineWait = 0.8  },
		},

		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidToulaRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2502", Text = "Come, Toula." },
				{ Cue = "/VO/Melinoe_2503", Text = "With me, Toula." },
				{ Cue = "/VO/Melinoe_3882", Text = "Come on, Toula." },
			},
			[2] = { GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},

		Using = { Projectile = "CatFamiliarPounce" },
	},

	-- Raki
	RavenFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		Icon = "GUI\\Icons\\Tool_Pickaxe_Raven",
		LinkedTool = "ToolPickaxe",
		TraitName = "CritFamiliar",
		KitAngle = 230,

		MarkerModel = "RavenMarker_Mesh",
		MarkerIdleAnimation = "RavenMarkerIdle",
		MarkerMoveAnimation = "RavenMarkerMove",
		MarkerJumpAnimation = "RavenMarkerJump",

		BaseResourceSpawnChance = 0.10,
		RestBonusResourceSpawnChance = 0.025,

		NumAttacks = 1,
		MinTimeBetweenAttacks = 9.0,
		MaxTimeBetweenAttacks = 10.0,

		MinDistanceToTeleportWhenMining = 550,

		InitialWaitRange = 200,

		IgnoreGravity = true,
		GroundHeight = 0,
		FlightHeight = 150,
		SkyHeight = 800,

		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar", },
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "RavenFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
						{
							Path = { "GameState", "WorldUpgrades", },
							NotHasAll =
							{
								"RavenCritChanceBonus",
								"RavenCritChanceBonus2",
								"RavenCritChanceBonus3",
								"RavenUses",
								"RavenUses2",
								"RavenUses3",
								"RavenAttack",
								"RavenAttack2",
								"RavenAttack3",
							},
						}
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
					},
				},
			},
		},

		GiftFunctionName = "CatFamiliarRecruit",
		GiftFunctionArgs =
		{
			Delay = 0.1,
			Title = "FamiliarRecruited",
			Text = "RavenFamiliar",
			TextOffsetY = -30,
			TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3",
			AnimationName = "LocationTextBGRelationship",
			AnimationOutName = "LocationTextBGRelationshipOut",
			Icon = "FamiliarIcon_Raven",
			PlayRecruitVoiceLines = true,

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Raven_Victory",
			UnlockEndAnimation = "Familiar_Raven_Victory",
			UnlockExitAnimation = "Familiar_Raven_DropIn_Exit",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "RavenFamiliar" },
			},
		},
		
		SpecialInteractFunctionName = "RavenFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "RavenFamiliarReadyToRecruit" },
		},

		UseTextGift = "RavenFamiliarUseTextGift_First",
		UseTextTalkGiftAndSpecial = "RavenFamiliarUseTextTalkGiftAndSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "RavenFamiliarUseTextTalkAndSpecial",
		UseTextGiftAndSpecial = "RavenFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "RavenFamiliarUseTextSpecial",

		ActivatePresentationFunctionName = "RavenFamiliarSpawnPresentation",
		MoveFunctionName = "RavenFamiliarMoveToLocation",

		StartNewRunFunctionName = "FamiliarRavenStartNewRunPresentation",
		LeaveEvents =
		{
			{
				FunctionName = "RavenFamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Raven_DropIn_Exit",
					VfxDelay = 0.2,
					VfxOffsetY = -80,
					VfxScale = 1.1,
				},
			},
		},

		EncounterEndEvents =
		{
			{
				FunctionName = "RavenFamiliarVictoryPresentation",
				Threaded = true,
			},
		},
		-- Victory animation is handled in RavenFamiliarAI

		AlwaysShowDefaultUseText = true,

		IdleAnimation = "Familiar_Raven_Perched_Idle",
		HappyAnimation = "Familiar_Raven_Victory_Perch",
		FleeAnimation = "Familiar_Raven_DropIn_Exit",
		TurnInPlaceAnimation = "Familiar_Raven_Victory_Perch",

		EquipSound = "/SFX/Familiars/RavenSquawk3",
		HappySound = "/SFX/Familiars/RavenGentleSquawk",
		FearSound = "/SFX/Familiars/RavenSquawkAngry",
		VictorySound = "/SFX/Familiars/RavenSquawk3",
		HarvestSound = "/SFX/Familiars/RavenSquawkAngry",

		FleeEmote = "StatusIconFear",

		VictoryEmoteAnim = "StatusIconOhBoy",
		ConfirmEmoteAnim = "StatusIconEmbarrassed",

		DefaultAIData =
		{
			DeepInheritance = true,

			TargetSearchDistance = 900,
			AttackDistance = 100,
		},
		
		AIOptions = { "RavenFamiliarAI" },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			}
		},

		Using = { ProjectileNames = { "RavenFamiliarMelee", "RavenFamiliarMelee_Crit", }, },

		SpecialInteractCooldown = 30,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Melinoe_0984", Text = "Greetings, little raven.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0986", Text = "I won't hurt you...", },
				{ Cue = "/VO/Melinoe_3864", Text = "Little raven..." },
				{ Cue = "/VO/Melinoe_3865", Text = "You're an unusual fellow." },
				{ Cue = "/VO/Melinoe_3866", Text = "You're always here..." },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoePettedBirdSpeech", Time = 12 },
				},

				{ Cue = "/VO/Melinoe_3782", Text = "You're a fine bird." },
				{ Cue = "/VO/Melinoe_3783", Text = "Hello, Raki." },
				{ Cue = "/VO/Melinoe_3784", Text = "You're all right, Raki." },
				{ Cue = "/VO/Melinoe_3785", Text = "Easy now, Raki." },
				{ Cue = "/VO/Melinoe_3786", Text = "Good bird.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3787", Text = "It's going to be all right." },
				{ Cue = "/VO/Melinoe_3867", Text = "Good evening, little raven." },
				{ Cue = "/VO/Melinoe_0984", Text = "Greetings, little raven.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3864", Text = "Little raven..." },
			},
		},

		RecruitVoiceLines =
		{
			PreLineWait = 0.35,

			{ Cue = "/VO/MelinoeField_1915", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_1917", Text = "We do! Raki, pleased to meet you.", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_1918", Text = "Let us protect each other from now on.", PreLineWait = 0.8  },
		},

		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidRakiRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2504", Text = "Come, Raki." },
				{ Cue = "/VO/Melinoe_2505", Text = "Come along, Raki." },
				{ Cue = "/VO/Melinoe_3881", Text = "Onward, Raki." },
				{ Cue = "/VO/Melinoe_0847", Text = "Come, little one, let's go.", },
			},
			[2] = { GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
	},

	-- Hound
	HoundFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		Icon = "GUI\\Icons\\Tool_Shovel_Hound",
		EquipSound = "/SFX/Familiars/DogBarkMisc1",
		HappySound = "/SFX/Familiars/DogBarkMisc2",
		SensedLootSound = "/SFX/Familiars/DogGrowlPlayful",
		FoundLootSound = "/SFX/Familiars/DogBarkDiscovery",
		LinkedTool = "ToolShovel",
		TraitName = "DigFamiliar",
		KitAngle = 300,
		AnimOffsetZ = 190,

		MarkerModel = "HoundMarker_Mesh",
		MarkerIdleAnimation = "HoundMarkerIdle",
		MarkerMoveAnimation = "HoundMarkerMove",
		MarkerJumpAnimation = "HoundMarkerJump",

		BaseResourceSpawnChance = 0.10,
		RestBonusResourceSpawnChance = 0.025,

		HeroHealthPercentForDig = 0.51, -- if you're below this % health, the hound can dig up health
		HeroManaPercentForDig = 0.7, -- if you're below this % mana, the hound can dig up mana
		HealthDigReward = "HealDropMinor",
		ManaDigReward = "ManaDropMinorHound",
		MaxManaDigsPerEncounter = 1,
		MinTimeBetweenDigs = 12.0,
		MaxTimeBetweenDigs = 16.0,

		BarkRange = 250,
		MinTimeBetweenBarks = 8.0,
		MaxTimeBetweenBarks = 9.0,

		MinDistanceToTeleportForShovelPoints = 650,

		ActivatePresentationFunctionName = "HoundFamiliarSpawnPresentation",
		MoveFunctionName = "HoundFamiliarMoveToLocation",

		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar", },
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "HoundFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
						{
							Path = { "GameState", "WorldUpgrades", },
							NotHasAll =
							{
								"HoundManaBonus",
								"HoundManaBonus2",
								"HoundManaBonus3",
								"HoundUses",
								"HoundUses2",
								"HoundUses3",
								"HoundAttack",
								"HoundAttack2",
								"HoundAttack3",
							},
						}
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
					},
				},
			},
		},

		GiftFunctionName = "CatFamiliarRecruit",
		GiftFunctionArgs =
		{
			Delay = 0.1,
			Title = "FamiliarRecruited",
			Text = "HoundFamiliar",
			TextOffsetY = -30,
			TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3",
			AnimationName = "LocationTextBGRelationship",
			AnimationOutName = "LocationTextBGRelationshipOut",
			Icon = "FamiliarIcon_Hound",
			PlayRecruitVoiceLines = true,

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Hound_Greet",
			UnlockEndAnimation = "Familiar_Hound_Dig",
			UnlockExitAnimation = "Familiar_Hound_DropIn_Exit",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "HoundFamiliar" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateGrantsFamiliars01" },
			},
		},

		UpgradedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					SetAnimation = "Familiar_Hound_Greet",
					Sound = "/SFX/Familiars/DogBarkMisc2",
				},
			},
		},

		EncounterStartEvents =
		{
			{
				FunctionName = "HoundFamiliarStartEncounter"
			},
		},

		EncounterEndEvents =
		{
			{
				FunctionName = "FamiliarVictoryPresentation",
				Threaded = true,
				Args =
				{
					SetAnimation = "Familiar_Hound_Greet",
					Sound = "/VO/CerberusBarks",
				},
			},
		},

		StartNewRunAnimation = "Familiar_Hound_DropIn_Exit",
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Hound_DropIn_Exit",
				},
			},
		},

		SpecialInteractFunctionName = "HoundFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "HoundFamiliarReadyToRecruit" },
		},

		UseTextGift = "HoundFamiliarUseTextGift_First",
		UseTextTalkGiftAndSpecial = "HoundFamiliarUseTextTalkGiftAndSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "HoundFamiliarUseTextTalkAndSpecial",
		UseTextGiftAndSpecial = "HoundFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "HoundFamiliarUseTextSpecial",

		AlwaysShowDefaultUseText = true,

		IdleAnimation = "Familiar_Hound_Sit_Idle",
		HappyAnimation = "Familiar_Hound_Greet",
		FleeAnimation = "Familiar_Hound_DropIn_Exit",
		TurnInPlaceAnimation = "Familiar_Hound_Attack",

		DefaultAIData =
		{
			DeepInheritance = true,

			FollowRestDistance = 500,		-- distance within which to not follow the player
			FollowNonCombatRestDistance = 400,
			FollowRestDistanceScaleY = 0.6,
		},

		AIOptions =
		{
			"HoundFamiliarAI",
		},

		SpecialInteractCooldown = 30,
		InteractVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoePettedHoundSpeech", Time = 12 },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/MelinoeField_2816", Text = "Here on a scouting mission for Headmistress, girl?", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2817", Text = "I've not seen Gale anywhere, have you?" },
				{ Cue = "/VO/MelinoeField_2819", Text = "We've come so far from the Crossroads, haven't we?" },
				{ Cue = "/VO/MelinoeField_2818", Text = "You keep an eye on Echo there, all right?",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Echo_01" }, Alive = true },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
						},
					},
				},
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Melinoe_3776", Text = "Who's a good girl?" },
				{ Cue = "/VO/Melinoe_3777", Text = "You're a good girl." },
				{ Cue = "/VO/Melinoe_3778", Text = "Headmistress raised you well." },
				{ Cue = "/VO/Melinoe_3779", Text = "You're all right." },
				{ Cue = "/VO/Melinoe_3780", Text = "Good girl, Hecuba.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3781", Text = "Hail Hecuba." },
			},
		},

		RecruitVoiceLines =
		{
			PreLineWait = 0.35,
			GameStateRequirements = 
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_2545", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_2546", Text = "Of course we do! Hecuba, the honor is mine.", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_2547", Text = "We shall protect each other from now on.", PreLineWait = 0.8 },
		},

		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.05,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidHecubaRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2497", Text = "Hecuba, would you accompany me on my task?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "HecubaFirstEquipVO" },
				{ Cue = "/VO/Melinoe_2508", Text = "Come, Hecuba." },
				{ Cue = "/VO/Melinoe_2509", Text = "Here, girl." },
				{ Cue = "/VO/Melinoe_3883", Text = "Onward, Hecuba." },
			},
			[2] = { GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},

		Using =
		{
			Projectile = { "HoundFamiliarBark" },
			Animation =
			{
				"Familiar_Hound_Attack",
				"Familiar_Hound_Dig",
				"ShovelDirtInSprayHound",
				"ShovelDirtInSprayHound",
				"ShovelDirtOutSprayHound",
			},
		}, 
	},

}

TraitSetData.Familiar =
{
	FamiliarTrait = 
	{
		Icon = "Keepsake_Skelly_Tooth",
		Slot = "Familiar",
		HideInHUD = true,
		HideInRunHistory = true,
		FamiliarTrait = true,
	},

	FamiliarUpgradeTrait =
	{
		Frame = "Shop",
		Icon = "FamiliarIcon_Frog",
		FamiliarTrait = true,
		Hidden = true,
	},

	HealthFamiliar =
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Frog",
		StacksAddBeforeRemove = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 10,
				ChangeType = "Add",
				MaintainDelta = true,
				ReportValues = { ReportedHealthBonus = "ChangeValue"}
			},
		},
		StatLines =
		{
			"BonusLifeStatDisplay1",
			"LinkedExorcismBookUsesStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedHealthBonus",
				ExtractAs = "HealthBonus"
			},
		},
		FlavorText = "FrogFamiliar_FlavorText",
	},

	FamiliarFrogDamage =
	{
		InheritFrom = { "FamiliarUpgradeTrait" },
		FamiliarDataModifiers =
		{
			AddOutgoingDamageModifiers =
			{
				{
					ValidBaseDamageAddition = { BaseValue = 10 },
				},
			},
		},
		ExtractValues = 
		{
		}
	},

	--[[
	FamiliarFrogDeflect =
	{
		InheritFrom = { "FamiliarUpgradeTrait" },
		FamiliarDataModifiers =
		{			
			--Reflection = 1.0,
			SpawnEffects =
			{
				{
					EffectName = "BuffDeflect",
					DataProperties = 
					{
						Type = "PROJECTILE_DEFENSE",
						Duration = 99999,
						Range = 150,
						Deflect = true,
					}
				},
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		}
	},
	]]
	
	LastStandFamiliar = 
	{
		InheritFrom = { "FamiliarTrait" },
		EquipSound = "/SFX/Menu Sounds/KeepsakeSkellyTooth",
		Icon = "FamiliarIcon_Cat",
		FamiliarLastStandHealAmount = { BaseValue = 10, AsInt = true },
		StatLines =
		{
			"LastStandStatDisplay1",
			"LinkedFishingRodUsesStatDisplay1",
		},
		ExtractValues =
		{
			{
				ExtractAs = "FamiliarDamage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "CatFamiliarPounce",
				BaseProperty = "Damage",
			},
			{
				Key = "FamiliarLastStandHealAmount",
				ExtractAs = "TooltipLastStandHealth",
			},
		},
		FlavorText = "CatFamiliar_FlavorText",
	},

	--[[
	FamiliarCatCrit =
	{
		InheritFrom = { "FamiliarUpgradeTrait" },
		FamiliarDataModifiers =
		{			
			AddOutgoingCritModifiers =
			{
				{
					Chance = { BaseValue = 0.10 },
					ReportValues = { ReportedCritBonus = "Chance" },
				},
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "Percent",
			},
		},
	},
	]]

	CritFamiliar = 
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Raven",
		AddOutgoingCritModifiers =
		{
			Chance =
			{
				BaseValue = 0.01,
				AbsoluteStackValues =
				{
					[1] = 0.01,
					[2] = 0.01,
					[3] = 0.01,
					-- Below is for Circe's doubling trait.
					-- [4] should match the BaseValue, [5/6/7] should match the stack values.
					[4] = 0.01,
					[5] = 0.01,
					[6] = 0.01,
					[7] = 0.01,
				},
			},
			ReportValues = { ReportedCritBonus = "Chance" },
		},
		OnEnemyCrittedFunction =
		{
			Name = "ClearRavenMark",
		},
		StatLines =
		{
			"BonusCritStatDisplay1",
			"LinkedPickaxeUsesStatDisplay1",
		},
		ExtractValues = 
		{
			{
				ExtractAs = "FamiliarDamage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "RavenFamiliarMelee",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "Percent",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "RavenFamiliarMark",
				BaseProperty = "Duration",
				ExtractAs = "TooltipMarkDuration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "RavenFamiliarMark",
				BaseProperty = "CritVulnerability",
				ExtractAs = "CritRate",
				Format = "Percent",
				SkipAutoExtract = true,
			}
		},
		FlavorText = "RavenFamiliar_FlavorText",
	},

	DigFamiliar =
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Hound",
		StacksAddBeforeRemove = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 15,
				ChangeType = "Add",
				MaintainDelta = true,
				ReportValues = { ReportedManaBonus = "ChangeValue"}
			},
		},
		StatLines =
		{
			"BonusMaxManaStatDisplay1",
			"LinkedShovelUsesStatDisplay1",
		},
		ExtractValues = 
		{
			{
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "HoundStun",
				BaseProperty = "Duration",
				DecimalPlaces = 3,
			},
			{
				Key = "ReportedManaBonus",
				ExtractAs = "ManaBonus"
			},
		},
		FlavorText = "HoundFamiliar_FlavorText",
	},
}

OverwriteTableKeys( EnemyData, FamiliarData )
OverwriteTableKeys( TraitData, TraitSetData.Familiar )
