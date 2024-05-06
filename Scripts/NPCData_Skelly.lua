 UnitSetData.NPC_Skelly =
{
	-- Schelemeus, -- Skelly, Id = 420928
	NPC_Skelly_01 =
	{
		InheritFrom = { "BaseVulnerableEnemy", "NPC_Neutral", "NPC_Giftable" },
		SubtitleColor = Color.SkellyVoice,
		DisableCharacterFadeColorLag = true,

		EmoteOffsetX = -80,
		EmoteOffsetY = -150,
		RequiredKill = false,
		UseShrineUpgrades = false,
		SkipDamagePresentation = false,
		SpeakerName = "Skelly",
		ActivateAnimation = "Skelly_Spawn",
		ActivateFx = "EnemySummonRune",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateDuration = 2.0,
		DeathAnimation = "Skelly_Death",
		DestroyDelay = 5.67,
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		StunAnimations = 
		{
			Default = "Skelly_OnHit",
		},
		MaxHealth = 920,
		HealthBarOffsetY = -235,
		HealthBarType = "MediumLarge",
		SkipDamageText = false,
		AnimOffsetZ = 0,
		UnuseableWhenDead = true,
		SpeechCooldownTime = 9,
		IgnoreAutoLock = false,
		BondAlwaysApplies = true,
		FamiliarTarget = true,

		Groups = { "GroundEnemies", "TrainingEnemies" },

		Material = "Bone",

		--AITurnDelayMin = 0.5,
		--AITurnDelayMax = 0.5,

		MeterMultiplier = 0,
		RespawnDelay = 5.85,

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
			},
		},
		SpecialInteractCooldown = 10,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				PlayOnceThisRun = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 8 },
				},
				-- PreLineAnim = "MelTalkBrooding01",

				{ Cue = "/VO/Melinoe_1708", Text = "Death to Chronos, Commander." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				PreLineAnim = "Skelly_Salute",
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Skelly_01",

				{ Cue = "/VO/Skelly_0155", Text = "Heya.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0156", Text = "Good evening, young one.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0157", Text = "Yeah!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0158", Text = "Same to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0160", Text = "It better!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0161", Text = "Seriously.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0162", Text = "Moonlight, yeah.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0163", Text = "Knock 'im dead, kiddo.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700", "/VO/Melinoe_1708" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0164", Text = "Yeah, kill 'im!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700", "/VO/Melinoe_1708" },
						},
					},
				},
			},
		},

		--[[ this is generic across NPCs
		UseTextTalkGiftAndSpecial = "SkellyUseTextTalkGiftAndSpecial",
		UseTextTalkAndSpecial = "SkellyUseTextTalkAndSpecial",
		UseTextGiftAndSpecial = "SkellyUseTextGiftAndSpecial",
		UseTextSpecial = "SkellyUseTextSpecial",
		]]--

		ActivateRequirements =
		{
		},

		AIOptions =
		{
			"EmptyAI",
		},
		AITetherToSpawnLocation = true,
		AITetherDistance = 0,

		Portrait = "Portrait_Skelly_Default_01",
		Groups = { "NPCs" },

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		TrophyUnlockedVoiceLines =
		{
			Queue = "Interrupt",
			PlayOnce = true,
			PlayOnceContext = "SkellyStatueUnveilVO",
			AllowTalkOverTextLines = true,
			{
				-- statue 1
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
					},
				},
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,

					{ Cue = "/VO/Melinoe_3273", Text = "The deed is done...!" },
				},
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",

					{ Cue = "/VO/Skelly_0309", Text = "And now... unto the Champion of Night, {#Emph}the spoils..." },
				},
				{
					UsePlayerSource = true,
					PreLineWait = 1.2,

					{ Cue = "/VO/Melinoe_3274", Text = "Oh..." },
				},
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				-- statue 2
				{
					PreLineWait = 0.5,
					ObjectType = "NPC_Skelly_01",

					{ Cue = "/VO/Skelly_0314", Text = "Now, young one: Avert your eyes, lest you be smitten by the {#Emph}glory {#Prev}over here!" },
				},
				{
					UsePlayerSource = true,
					PreLineWait = 1.8,

					{ Cue = "/VO/Melinoe_3279", Text = "Wow..." },
				},
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				-- statue 3
				{
					PreLineWait = 0.73,
					ObjectType = "NPC_Skelly_01",

					{ Cue = "/VO/Skelly_0319", Text = "For your {#Emph}extraordinary {#Prev}feat, the most {#Emph}extraordinary Gift of all!" },

				},
				{
					UsePlayerSource = true,
					PreLineWait = 2.53,

					{ Cue = "/VO/Melinoe_3284", Text = "{#Emph}Huh..." },
				},
			},

		},

		InteractTextLineSets =
		{
			SkellyFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				{ Cue = "/VO/Skelly_0229",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 9.65 },
					Text = "A battle lost. But this is {#Emph}war{#Prev}, young one, and you have many battles yet to come! The only question is, are you prepared to {#Emph}win? {#Prev}I'm not so sure here, so let's see you {#DialogLegendaryFormat}give me {#Prev}{#EmphLegendary}twenty!",
					PostLineThreadedFunctionName = "StartSkellyHitQuest" },
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2919", Text = "Commander Schelemeus, {#Emph}sir!" },
				},
			},
			SkellyAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0072",
					Text = "Your path is fraught, young one. Know that I'm {#Emph}always {#Prev}here to let you vent {#Emph}all {#Prev}your anger and frustrations upon, as well as to train with." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0072", Text = "The greatest teacher is out there..." },
				},
			},

			SkellyAboutEmotions01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0073",
					Text = "One must at times hold fast to one's emotions, and at others, know to let 'em loose. And when you want to let 'em loose, or try out one of them {#DialogLegendaryFormat}Nocturnal Arms{#Prev}, know that I'm here." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0075", Text = "This anger is for Chronos, sir." },
				},
			},

			SkellyAboutTraining01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						--
					}
				},
				{ Cue = "/VO/Skelly_0153",
					Text = "Observe how patient my disciples are, studying your every move! If ever you're inclined to give them a demonstration of your prowess, or just want to blow off some steam, do not hesitate to {#DialogLegendaryFormat}whale upon me{#Prev}.",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2256", Text = "{#Emph}Whale upon{#Prev}, sir...?" },
				},
			},
			SkellyAboutTraining02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},				
				{ Cue = "/VO/Skelly_0044",
					Text = "Remember you are training with an unarmed opponent here, young one. Out there, the skeletons can {#Emph}move{#Prev}... and they'd cut you to ribbons, given half a chance! You won't learn to handle that kind of pressure sparring with me." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_0053", Text = "I understand." },
				},
			},

			SkellyAboutStaff01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasNone = { "WeaponLob" },
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Skelly_0154",
					Text = "You getting a handle on that walking stick of yours? There's other stuff you might like better in the {#DialogLegendaryFormat}Puddle {#Prev}back there, if you've got the {#DialogLegendaryFormat}Silver {#Prev}for it. Just be sure to try it all out on me!",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2257", Text = "You musn't speak ill of Descura, sir." },
				},
			},

			SkellyAboutCardUpgradeSystem01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "Resources", "CardUpgradePoints" },
						Comparison = "<=",
						Value = 6,
					},
					{
						Path = { "GameState", "Resources", "MetaCurrency" },
						Comparison = ">=",
						Value = 150,
					},
				},
				{ Cue = "/VO/Skelly_0361",
					Text = "Something's changed about that {#DialogLegendaryFormat}Altar {#Prev}of yours recently, and you have been at it more and {#Emph}more{#Prev}, young one! Mayhaps awakened newfound power there, or what?" },
				{ Cue = "/VO/Melinoe_3364", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've consecrated the Ashes and gained insight into the potential of the Arcana, Commander. Requires a little Moon Dust, and a lot of focus... perhaps the other way around." },
				{ Cue = "/VO/Skelly_0362",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#DialogLegendaryFormat}Moon Dust! {#Prev}Think the old {#DialogLegendaryFormat}Broker {#Prev}started pawning off that stuff, though I have {#Emph}heard {#Prev}it's possible a witch like you could brew it up herself. Sounds like you better stock up!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3365", Text = "I probably should..." },
				},
			},

			SkellyAboutAspects01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
				},
				{ Cue = "/VO/Skelly_0185",
					Text = "Something transpired with the {#DialogLegendaryFormat}Silver Puddle {#Prev}back there, I could tell, young one! Your doing, or perchance that of the Fates themselves?" },
				{ Cue = "/VO/Melinoe_2529", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've revealed in the Pool the Aspects of the Nocturnal Arms. Not their true forms, exactly... but different ones, with their own great power." },
				{ Cue = "/VO/Skelly_0186",
					Text = "Ah, the {#DialogLegendaryFormat}Nocturnal Arms{#Prev}! Your brother, he once used their counterparts, and those ones too turned into other stuff. Well if you need test your newfound strength, I'm here." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2530", Text = "I know it, Commander." },
				},
			},

			SkellyAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- distinct from CurrentRun.Hero.TraitDictionary
					{
						PathTrue = { "CurrentRun", "TraitCache", "ReincarnationKeepsake" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				{ Cue = "/VO/Skelly_0189",
					Text = "I trust that the enchanted {#DialogLegendaryFormat}Tooth {#Prev}I proffered you has proved invaluable? Although, since you're already back, perhaps it wasn't quite invaluable enough..." },
				{ Cue = "/VO/Melinoe_2586", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'd surely not have gone as far without your Keepsake, Commander. Though, why is it known as the {#Emph}Luckier {#Prev}Tooth? Was there another of its kind?" },
				{ Cue = "/VO/Skelly_0190",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, no! It is a truly unique artifact procured in my travails. An artifact with which you'll cling to life as might a sailor on a sinking ship." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2587", Text = "That's very vivid..." },
				},
			},

			SkellyAboutZagreus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift02" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonFirstPickUp" },
					},
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Melinoe_0073", UsePlayerSource = true,
					Text = "Commander... there must be something you could tell me of my brother. The stronger my connection, the better our chances. You knew him, didn't you?" },
				{ Cue = "/VO/Skelly_0007",
					Text = "I knew your brother, yeah. Good kid, most of the time. He wouldn't want you to be so hung up about him. What he'd want... more than anything, I think... is for you... to {#DialogLegendaryFormat}hit me{#Prev}. As hard as you can, repeatedly and often, and {#Emph}that's {#Prev}what I would want for you as well!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0074", Text = "{#Emph}Ungh{#Prev}, very well." },
				},
			},

			SkellyAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with additional requirements
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasAny = { "CharonWithHecate01", },
					},
				},
				{ Cue = "/VO/Melinoe_2924", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you seen, Commander? Lord Charon's come to visit us! At last our supply lines are secure, and our counter-assault begins." },
				{ Cue = "/VO/Skelly_0244",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "Uh, {#Emph}yeah! {#Prev}It's been quite some time since good Lord Charon visited us last. We'd better all be on our best behavior around him! But, {#Emph}uh... {#Prev}where'd you get all that supply-lines stuff?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2925", Text = "Why, he told me himself, sir! In his way." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0245", Text = "Oh..." },
					},
				},
			},
			SkellyAboutCharon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutCharon01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SkellyGift02", "CharonGift02" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "SkellyAboutCharon01" }, Count = 3 },
				},
				{ Cue = "/VO/Skelly_0246",
					PreLineAnim = "Skelly_Explaining",
					Text = "Say, young one? I'd ask of you a question that pertains to good Lord Charon, if you please. Seems like you understand him pretty good! Has he, {#Emph}uh{#Prev}, said anything of late regarding {#Emph}me...?" },
				{ Cue = "/VO/Melinoe_2926", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, I... I'm sorry, no. But I'll be certain to put in a good word! You've been indispensable, and Lord Charon ought to be aware." },
				{ Cue = "/VO/Skelly_0247",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}No! {#Prev}I mean, {#Emph}um, no{#Prev}, just... don't go doing anything like that! You need not burden more the Boatman with such trivialities, amid such turbulent times...! Don't bother him, OK?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2927", Text = "{#Emph}Erm{#Prev}, OK!" },
					},
				},
			},

			-- if you didn't vanquish Cerberus
			SkellyAboutCerberus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutCerberus01B" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" },
					},
				},
				{ Cue = "/VO/Melinoe_2996", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander. You once held a place of honor in my father's House, so you must know Cerberus? I think I found him in the Mourning Fields, coated in Miasma, heads to paws. Was he always prone to uncontrolled fits of rage?" },
				{ Cue = "/VO/Skelly_0240",
					PreLineAnim = "Skelly_Explaining",
					Text = "Oh, no, he mostly sat around. We go way back, it's just... I kept strategically afar, seeing as he's kind of like a {#Emph}dog{#Prev}, and I'm kind of like a {#Emph}bone. {#Prev}So now he's giving you some trouble, huh?" },
				{ Cue = "/VO/Melinoe_2795", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's not his fault. Chronos must have cast him from the House and put him out to pasture. But if I can just break through all that grime, I'm certain I can calm him down." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0241", Text = "He never did like baths, just so you know..." },
				},
			},
			-- if you vanquished Cerberus
			SkellyAboutCerberus01B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutCerberus01" },
					},
					{
						Path = { "GameState", "EnemyKills", "InfestedCerberus" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Melinoe_2995", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, you once held a place of honor in my father's House. So, you must know Cerberus, right? I found him in the Mourning Fields, coated in Miasma, heads to paws. Was he always prone to uncontrolled fits of rage?" },
				{ Cue = "/VO/Skelly_0240",
					PreLineAnim = "Skelly_Explaining",
					Text = "Oh, no, he mostly sat around. We go way back, it's just... I kept strategically afar, seeing as he's kind of like a {#Emph}dog{#Prev}, and I'm kind of like a {#Emph}bone. {#Prev}So now he's giving you some trouble, huh?" },
				{ Cue = "/VO/Melinoe_2997", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's not his fault. Chronos must have cast him from the House, put him out to pasture. I broke through all the grime, and calmed him down. But he may need another cleansing soon." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0241", Text = "He never did like baths, just so you know..." },
				},
			},

			SkellyAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with additional requirements
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},

				{ Cue = "/VO/Skelly_0238",
					PreLineAnim = "Skelly_Explaining",
					Text = "Hey, by the way, I meant to say {#Emph}nice going{#Prev}, on occasion of achieving your objective and all that! You did achieve it, right...? Showed Chronos the what-for?" },
				{ Cue = "/VO/Melinoe_2920", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was able to defeat him, yes, Commander. But, my ultimate objective is far from complete." },
				{ Cue = "/VO/Skelly_0239",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Ah, well{#Prev}, that's objectives for ya! Soon as one's complete, along comes another. But you are gonna {#Emph}keep {#Prev}knocking 'em dead!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2921", Text = "By your leave." },
				},
			},

			SkellyAboutChronosBossW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},

				{ Cue = "/VO/Skelly_0369",
					PreLineAnim = "Skelly_Explaining",
					Text = "Word reached me that this past night, you achieved what you set out to do, young one! Major congrats on that, all my disciples and myself salute you on a job well done." },
				{ Cue = "/VO/Melinoe_3371", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you, Commander! Though, this was a step toward victory I never could have achieved if not for all the training and counsel from Headmistress, Odysseus, and yourself." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Explaining",
					{ Cue = "/VO/Skelly_0370", Text = "And she even gives credit where credit is due!" },
				},
			},

			SkellyAboutRouteChoice01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomCountCache", "N_Opening01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "RoomCountCache", "F_Opening01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				{ Cue = "/VO/Skelly_0144",
					Text = "I sense a great weight bearing down on you, young one. Not quite as bad as what old Atlas got, but still!" },
				{ Cue = "/VO/Melinoe_1580", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What do you advise as my next move, Commander: to pursue our enemy in the Underworld, or come to the aid of Olympus?" },
				{ Cue = "/VO/Skelly_0145",
					Text = "Well not to be all greedy here, {#Emph}but{#Prev}... I say go wherever you can get the stuff you need the most, right {#Emph}now! {#Prev}We got some stuff down here they don't got up there, and so on, right?" },
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_1581", Text = "...I suppose..." },
				},

			},

			SkellyAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				{ Cue = "/VO/Skelly_0045",
					Text = "Patience, young one! You are most brave to venture to the surface. And most foolhardy as well, debatably! Is there no {#DialogLegendaryFormat}Incantation {#Prev}that could help...?" },
				{ Cue = "/VO/Melinoe_3366", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think there is, Commander, except... it calls for reagents that can only be found up {#Emph}there... {#Prev}but, how am I supposed to gather them before the incantation is complete?" },
				{ Cue = "/VO/Skelly_0363",
					PreLineAnim = "Skelly_Explaining",
					Text = "Mayhaps just make a run for it, I don't know. So what if you can't stay long just grab what you need and get out of there!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3367", Text = "It's not ideal, but..." },
				},
			},
			SkellyAboutSurface02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomCountCache", "N_Opening01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAll = { "WorldUpgradeShadeMercs", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				{ Cue = "/VO/Skelly_0142",
					Text = "You remained upon the surface for considerably longer than before. How was it, any good?" },
				{ Cue = "/VO/Melinoe_1578", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "War rages above. The Olympians sent Heracles himself to contain the damage. Shades of the Dead linger everywhere. So... {#Emph}not {#Prev}good, all in all." },
				{ Cue = "/VO/Skelly_0143",
					Text = "Shades of the Dead! Sure sounds like more disciples we can use. {#Emph}Eh{#Prev}, {#DialogLegendaryFormat}sprint into 'em{#Prev}, will ya?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_1579", Text = "Yes, sir." },
				},
			},

			SkellyAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomCountCache", "G_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "PrevRun", "RoomCountCache", "H_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0077",
					Text = "I understand you ventured to the bottom of the sea. I, too, have been there in those depths, young one! But once, awhile back, and briefly, I might add!" },
				{ Cue = "/VO/Melinoe_1044", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course...! You were a famous mariner in your mortal days. But, then you finally met your end beneath the waters upon which you sailed?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0078", Text = "Nah! 'Twas way more glorious than that." },
				},
			},
			SkellyAboutOceanus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomCountCache", "G_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "PrevRun", "RoomCountCache", "H_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0187",
					Text = "How have you lately fared against the Lurkers and the Serpents all that way down in the watery depths? Knowing of 'em and squaring off against 'em are two very different things." },
				{ Cue = "/VO/Melinoe_2531", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They're significantly stronger than the Lost Souls lingering around here. And they have no sense of fear at all, attacking without any hesitation." },
				{ Cue = "/VO/Skelly_0188",
					Text = "They're basically just walking fish, young one. Not much for conversating, but they'll stick you with a trident just fine! Don't you let 'em." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2532", Text = "I won't." },
				},
			},

			SkellyAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0079",
					Text = "How fared your recent surface sea-journey, young one? I still remember well the boundless waters there. How blue and tranquil they were!" },
				{ Cue = "/VO/Melinoe_1045", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "{#Emph}Tranquil? {#Prev}My experience was not exactly that." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0080", Text = "They were tranquil, damn it..." },
				},
			},

			SkellyAboutGiftRack01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "KeepsakeRack" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutGiftRack02" },
					},
				},
				{ Cue = "/VO/Melinoe_1046", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The old storage case... so, it's an heirloom from my family." },
				{ Cue = "/VO/Skelly_0083",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 8.6 },
					PreLineAnim = "Skelly_Explaining",
					Text = "That it is, and for as long as I can recollect. Look upon it knowing that the burden which you bear, you need not bear alone. Plus it'll keep your {#DialogLegendaryFormat}Keepsakes {#Prev}all in one handy spot!" },
				{ Cue = "/VO/Melinoe_1047", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A symbol of the gift-giving custom of Olympus, then. A tradition that now falls to us." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0084", Text = "Yep." },
				},
			},
			SkellyAboutGiftRack02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Skelly_0085",
					Text = "You're beginning to fill out that {#DialogLegendaryFormat}Keepsake {#Prev}storage case, young one. Fine work, yet I must caution you not to collect just for collecting's sake..." },
				{ Cue = "/VO/Melinoe_1048", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The act of giving is its own intangible reward. Nectar sours when it's offered with impure intent." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0086", Text = "Won't have impure intent on my damn training grounds." },
				},
			},

			SkellyAboutUnusedWeaponBonus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonus" },
					},
				},
				{ Cue = "/VO/Skelly_0174",
					Text = "There's something up with those Nocturnal Arms of yours... a certain {#Emph}aura {#Prev}that's surrounding one of them. The {#DialogLegendaryFormat}Grave Thirst{#Prev}..." },
				{ Cue = "/VO/Melinoe_2490", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A relatively simple incantation. I expected there was more to the connection between Night's weapons and the dead. No wonder you can see it, too." },
				{ Cue = "/VO/Skelly_0343",
					PreLineAnim = "Skelly_Explaining",
					Text = "Come, now... not like I need eyes on the back of my cranium! But I can feel it in my bones! Want more {#DialogLegendaryFormat}Bones {#Prev}yourself, just {#DialogLegendaryFormat}use the weapon with the Thirst{#Prev}!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2491", Text = "Whenever possible." },
				},
			},

			SkellyAboutExorcismBook01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ExorcismSuccessesManual" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "CurrentRun", "ExorcismSuccessesManual" },
					},
				},
				{ Cue = "/VO/Skelly_0226",
					Emote = "PortraitEmoteSparkly",
					Text = "Way to go with that {#DialogLegendaryFormat}Tablet of Peace{#Prev}, young one! Our ranks are beginning to swell with Shades who may yet find great purpose in their immortal coil!",
				},
				{ Cue = "/VO/Melinoe_2495", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Their lives, such as they are, will only improve once my father is restored to his rightful throne." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0184", Text = "Oh there's no doubt of that! But first, we fight!", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconDetermined" }, ReactionChance = 0.2 }, },
				},
			},

			SkellyAboutBountyBoard01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
				},
				{ Cue = "/VO/Skelly_0089",
					Text = "My disciples, they were given quite a fright when that {#DialogLegendaryFormat}Pitch-Black Stone {#Prev}there suddenly lit up. You know what it is, do you not?" },
				{ Cue = "/VO/Melinoe_2818", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A shard of purest darkness from the depths of Chaos... in its countless facets, countless outcomes. Perhaps none of which the Fates have preordained." },


				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0090", Text = "{#Emph}Uhh{#Prev}, yep." },
				},
			},
			SkellyAboutBounties01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutBountyBoard01" },
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				{ Cue = "/VO/Skelly_0248",
					PreLineAnim = "Skelly_Explaining",
					Text = "We all saw you disappear into that {#DialogLegendaryFormat}Pitch-Black Stone{#Prev}. Another means by which you may spring into action, retaining the element of surprise! {#Emph}Pretty nice!" },
				{ Cue = "/VO/Melinoe_2928", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That Stone has been here all this time. It's so much more than a monument to Night, and its origins, even more ancient. But I never considered it a weapon in our arsenal..." },
				{ Cue = "/VO/Skelly_0249",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well, not like you can crack me over the head with it, but {#Emph}yeah!" },
			},

			SkellyAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "BountiesCompleted" },
						UseLength = true,
						Comparison = "<=",
						Value = 2,
					},
					NamedRequirements =  { "ShrineUnlocked" },
				},
				{ Cue = "/VO/Skelly_0231",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 4.8 },
					Text = "Your eyes do not deceive! Near the gateways outta here you'll find none other than the {#DialogLegendaryFormat}Oath of the Unseen{#Prev}, I think it's called. Ask me not whence it came... instead ask just how {#Emph}tough {#Prev}you really are!" },
				{ Cue = "/VO/Melinoe_2813", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I earned the right to look upon the Oath... the Testaments of Night. Do I dare speak the vows? And thereby spread the Fear that darkness brings...?" },
				{ Cue = "/VO/Skelly_0232",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "Come on, what are you, {#Emph}scared? {#Prev}Those Nocturnal Arms you got, they probably are gonna love that {#DialogLegendaryFormat}Fear {#Prev}and {#DialogLegendaryFormat}Testament {#Prev}type stuff. I say give it a shot! What's the worst that could happen?" },
				{ Cue = "/VO/Melinoe_2814", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All mortalkind condemned to neverending torment and despair...?" },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					PreLineAnim = "Skelly_Salute",
					{ Cue = "/VO/Skelly_0233", Text = "It's gonna be {#Emph}fine!" },
				},
			},

			SkellyAboutShrine02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutShrine01" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "BountiesCompleted" },
						UseLength = true,
						Comparison = ">",
						Value = 2,
					},					
				},
				{ Cue = "/VO/Skelly_0234",
					PreLineAnim = "Skelly_Explaining",
					Text = "How goes it with the neverending torment stuff, now that you've got that {#DialogLegendaryFormat}Oath {#Prev}thing over there? Those Nocturnal Arms of yours, they must be having a great time!" },
				{ Cue = "/VO/Melinoe_2815", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Arms of Night, they're reacting to the Oath, I think. Growing stronger as her Testaments are carried out. Drinking the very Nightmares born of mortals' fear of the dark." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0235", Text = "Now {#Emph}that {#Prev}is what I like to hear!" },
				},
			},

			SkellyAboutShrine03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutShrine02" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "BountiesCompleted" },
						UseLength = true,
						Comparison = ">",
						Value = 3,
					},
				},
				{ Cue = "/VO/Melinoe_2816", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Even in all your wisdom, Commander... how is it that you know so much about the Oath of the Unseen? As far as I know it pre-dates even my father's rule within the Underworld." },
				{ Cue = "/VO/Skelly_0236",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh yeah, your papa took a different tack. Was all about his Pacts of Punishment! He even served your brother with 'em once, when they were really on the outs. But boyo just went for it, and then things {#Emph}really {#Prev}heated up!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 2,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2817", Text = "You didn't answer my question." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Salute",
						{ Cue = "/VO/Skelly_0237", Text = "And I'm not gonna! For I made certain Vows myself." },
					},
				},
			},

			SkellyAboutAltar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MemPointsCommon", },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "<=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Skelly_0191",
					Emote = "PortraitEmoteSparkly",
					Text = "The incense and the smoke and stuff from that {#DialogLegendaryFormat}Altar of Ashes {#Prev}over there, it's energized the Shades about this place! And me, as well." },
				{ Cue = "/VO/Melinoe_2588", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm pleased to hear it, Commander. Even a brief visit to the Altar on a given night helps make me feel more prepared." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0192", Text = "Keep doing what you're doing over there!" },
				},
			},

			SkellyAboutGodMode01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "RoomsEntered", "F_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "F_PostBoss01" },
					},
					{
						PathFalse = { "ConfigOptionsCache", "EasyMode" },
					},
					{
						PathFalse = { "GameState", "TraitsTaken", "GodModeTrait" },
					},
				},
				{ Cue = "/VO/Skelly_0242",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 8.0 },
					Text = "Your struggles never are in vain, young one! You're no mere mortal; with each passing night, you grow in knowledge and in strength! 'Specially if you throw on that {#DialogLegendaryFormat}God Mode{#Prev}, then there won't be any stopping ya!" },
				{ Cue = "/VO/Melinoe_2922", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Would that godhood was enough, Commander. Though, the last thing you said... {#Emph}erm{#Prev}, what exactly did you mean?" },
				{ Cue = "/VO/Skelly_0243",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh, {#DialogLegendaryFormat}God Mode{#Prev}? Well, it's this {#Emph}mode{#Prev}, you see. One which you're able to {#Emph}throw on! {#Prev}Or to throw off, entirely at whim! It's just an option's all I'm trying to say, so use it if you please!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2923", Text = "Just an option..." },
				},
			},

			SkellyAboutFamiliars01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with real requirements
					{
						PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked" },
					},
					--[[
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", "CatFamiliar", "RavenFamiliar" },
					},
					]]--
				},
				{ Cue = "/VO/Skelly_0081",
					Text = "You have an {#DialogLegendaryFormat}Animal Familiar {#Prev}now! Well, your disciples are my disciples, young one. They shall be trained and cared for here while you're away, and they can fight me also if they like?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0765", Text = "Thank you." },
				},
			},

			SkellyAboutDagger01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponDagger" },
					},
				},
				{ Cue = "/VO/Skelly_0176",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah{#Prev}, to have felt the deadly sting of the {#DialogLegendaryFormat}Sister Blades{#Prev}! Mayhaps these are the {#Emph}sharpest {#Prev}blades with which I've ever been {#Emph}sliced!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2492", Text = "I'm honored to bear them." },
				},
			},
			SkellyAboutAxe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponAxe" },
					},
				},
				{ Cue = "/VO/Skelly_0177",
					Text = "The monstrous power of the {#DialogLegendaryFormat}Moonstone Axe {#Prev}is yours! There isn't much out there it couldn't chop clean through, including {#Emph}me!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2493", Text = "It's got some heft." },
				},
			},
			SkellyAboutTorch01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponTorch" },
					},
				},
				{ Cue = "/VO/Skelly_0180",
					Text = "The {#DialogLegendaryFormat}Umbral Flames{#Prev}, young one! You're the spitting image of the big lady herself with those in hand. May they ever light your way, and light up anybody you don't like." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2494", Text = "I'll fight like Headmistress herself." },
				},
			},

			-- trophy quest / skelly statues
			SkellyAboutTrophyQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestUnlocked" },
				},
				{ Cue = "/VO/Skelly_0303",
					PreLineAnim = "Skelly_Explaining",
					Text = "Your myriad accomplishments thus far are nothing in comparison to that which you now stand to gain, young one! {#DialogLegendaryFormat}Eternal glory {#Prev}can be yours, if you but prove your worth!" },
				{ Cue = "/VO/Melinoe_3269", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "The patterns on that drapery... the secret Gifts of the Veil, bestowed on Night's most dedicated servants...! Commander, what are they doing here? Shades are never to look upon them!" },
				{ Cue = "/VO/Skelly_0304",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "Well let's just say the rules have lately changed! Those {#Emph}Gifts{#Prev}, as you refer to them, are yours to earn... provided you can do the stuff the {#DialogLegendaryFormat}Oath of the Unseen {#Prev}would ask of you! Which, as you probably surmised, shall be no simple feat." },
				{ Cue = "/VO/Melinoe_3270", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps a test merely of greed and arrogance... to overextend with the Oath may put my task in jeopardy." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					PreLineAnim = "Skelly_Babbling",
					ObjectType = "NPC_Skelly_01",
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Skelly_0305", Text = "{#Emph}C'mon{#Prev}, don't be such a {#Emph}baby!" },
				},
			},

			SkellyAboutTrophyQuest02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					NamedRequirementsFalse = { "TrophyQuestStage3Complete" },
				},
				{ Cue = "/VO/Skelly_0306",
					PreLineAnim = "Skelly_Babbling",
					Text = "So are you gonna earn the Gifts of the Veil over there? Or squander your chance to get some of that {#DialogLegendaryFormat}eternal glory{#Prev}?" },
				{ Cue = "/VO/Melinoe_3271", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eternal glory... if such a thing may come to those who manage to achieve extraordinary feats, so be it. But to chase glory as a goal unto itself? That can't be right... at least, it's never been our way." },
				{ Cue = "/VO/Skelly_0307",
					PreLineAnim = "Skelly_Explaining",
					Text = "But our ways can {#Emph}change{#Prev}, wouldn't you say? We mustn't become mired in the olden ways of doing things! Though, I don't mean to {#Emph}pressure {#Prev}you, kiddo, it's just... I think you oughtta get what's yours, is all." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3272", Text = "...I'll think about it." },
					},
				},
			},

			SkellyAboutTrophyQuestProgress01_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress01_B", "TrophyQuestComplete01" },
					},
					NamedRequirements = { "TrophyQuestStage1CheckA" },
					NamedRequirementsFalse = { "TrophyQuestStage1CheckB" },
				},
				{ Cue = "/VO/Skelly_0358",
					PreLineAnim = "Skelly_Explaining",
					Text = "Halfway to victory, young one! But to earn the Gifts of the Veil, one must conquer the Underworld {#Emph}and {#Prev}the surface realms upon a {#DialogLegendaryFormat}Fear{#Prev}-ful night each in turn. You up for it?" },
				{ Cue = "/VO/Melinoe_3362", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For the glory of the Underworld and the everlasting rule of Night, I would do everything in my ability. Whether that makes me worthy of the Gifts of the Veil, I know not." },
				{ Cue = "/VO/Skelly_0359",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}C'mon{#Prev}, what kind of attitude is {#Emph}that? {#Prev}You did the Underworld already, now you just got to do the surface, and the Gifts are {#Emph}yours! {#Prev}First one of 'em at least. Come on, do it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3363", Text = "OK...!" },
					},
				},
			},
			SkellyAboutTrophyQuestProgress01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress01_A", "TrophyQuestComplete01" },
					},
					NamedRequirements = { "TrophyQuestStage1CheckB" },
					NamedRequirementsFalse = { "TrophyQuestStage1CheckA" },
				},
				{ Cue = "/VO/Skelly_0358",
					PreLineAnim = "Skelly_Explaining",
					Text = "Halfway to victory, young one! But to earn the Gifts of the Veil, one must conquer the Underworld {#Emph}and {#Prev}the surface realms upon a {#DialogLegendaryFormat}Fear{#Prev}-ful night each in turn. You up for it?" },
				{ Cue = "/VO/Melinoe_3362", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For the glory of the Underworld and the everlasting rule of Night, I would do everything in my ability. Whether that makes me worthy of the Gifts of the Veil, I know not." },
				{ Cue = "/VO/Skelly_0360",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}C'mon{#Prev}, what kind of attitude is {#Emph}that? {#Prev}You did the surface already, now you just got to do the Underworld, and the Gifts are {#Emph}yours! {#Prev}First one of 'em at least. Come on, do it!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3363", Text = "OK...!" },
					},
				},
			},

			-- identical copy below (different prereqs)
			SkellyAboutTrophyQuestProgress02_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress02_B", "TrophyQuestComplete02" },
					},
					NamedRequirements = { "TrophyQuestStage2CheckA" },
					NamedRequirementsFalse = { "TrophyQuestStage2CheckB" },
				},
				{ Cue = "/VO/Skelly_0372",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "The second {#DialogLegendaryFormat}Gift of the Veil {#Prev}is {#Emph}almost {#Prev}within reach! Could actually just go right up and touch it, b-but anyway a-are you prepared to use the {#DialogLegendaryFormat}Oath {#Prev}and go the other way?" },
				{ Cue = "/VO/Melinoe_3485", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't mean to leave you in suspense, Commander, but we'll just have to see." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0373", Text = "I shall be waiting here with the equivalent of bated breath!" },
					},
				},
			},
			SkellyAboutTrophyQuestProgress02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress02_A", "TrophyQuestComplete02" },
					},
					NamedRequirements = { "TrophyQuestStage2CheckB" },
					NamedRequirementsFalse = { "TrophyQuestStage2CheckA" },
				},
				{ Cue = "/VO/Skelly_0372",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "The second {#DialogLegendaryFormat}Gift of the Veil {#Prev}is {#Emph}almost {#Prev}within reach! Could actually just go right up and touch it, b-but anyway a-are you prepared to use the {#DialogLegendaryFormat}Oath {#Prev}and go the other way?" },
				{ Cue = "/VO/Melinoe_3485", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't mean to leave you in suspense, Commander, but we'll just have to see." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0373", Text = "I shall be waiting here with the equivalent of bated breath!" },
					},
				},
			},

			-- identical copy below (different prereqs)
			SkellyAboutTrophyQuestProgress03_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress03_B", "TrophyQuestComplete01" },
					},
					NamedRequirements = { "TrophyQuestStage3CheckA" },
					NamedRequirementsFalse = { "TrophyQuestStage3CheckB" },
				},
				{ Cue = "/VO/Skelly_0374",
					PreLineAnim = "Skelly_Explaining",
					Text = "The final and most monumental {#DialogLegendaryFormat}Gift of the Veil {#Prev}is so close at hand! If you can get through {#Emph}one {#Prev}of your two routes under the Oath, then surely the rest is but a walk in the park!" },
				{ Cue = "/VO/Melinoe_3486", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can only assume a walk in this {#Emph}park {#Prev}you cite must be an absolutely grueling experience." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0375", Text = "Some parts of town? {#Emph}Ohh {#Prev}yeah." },
					},
				},
			},
			SkellyAboutTrophyQuestProgress03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutTrophyQuestProgress03_A", "TrophyQuestComplete01" },
					},
					NamedRequirements = { "TrophyQuestStage3CheckB" },
					NamedRequirementsFalse = { "TrophyQuestStage3CheckA" },
				},
				{ Cue = "/VO/Skelly_0374",
					PreLineAnim = "Skelly_Explaining",
					Text = "The final and most monumental {#DialogLegendaryFormat}Gift of the Veil {#Prev}is so close at hand! If you can get through {#Emph}one {#Prev}of your two routes under the Oath, then surely the rest is but a walk in the park!" },
				{ Cue = "/VO/Melinoe_3486", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can only assume a walk in this {#Emph}park {#Prev}you cite must be an absolutely grueling experience." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0375", Text = "Some parts of town? {#Emph}Ohh {#Prev}yeah." },
					},
				},
			},

			SkellyAboutTrophyQuest03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
					},
				},
				{ Cue = "/VO/Melinoe_3288", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To think the Gifts of the Veil were those statues... I always thought it was the Veils themselves... the draperies, sewn with the finest fabric of the Fates. Where are they anyway?" },
				{ Cue = "/VO/Skelly_0322",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Skelly_Babbling",
					Text = "Oh, those? We, {#Emph}uh{#Prev}, we sent 'em back into the shadows whence they came. They were just packing materials, you know? You got the {#DialogLegendaryFormat}real deal{#Prev}, I swear!" },
				{ Cue = "/VO/Melinoe_3289", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I still cannot entirely believe that Night would honor me with such an ostentatious display. Although, perhaps these Gifts are less for {#Emph}me {#Prev}and more for those who serve our cause..." },
				{ Cue = "/VO/Skelly_0323",
					PreLineAnim = "Skelly_Explaining",
					Text = "Now that you mention it, the Shades {#Emph}do {#Prev}like to gawk at 'em when you're not here. You get to inspire them even if you're not around! If that's not {#DialogLegendaryFormat}eternal glory{#Prev}... what is?" },
				{ Cue = "/VO/Melinoe_3290", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "These Shades are inspired because I went out of my way to use the Oath of the Unseen purely for personal gain?" },
				{ Cue = "/VO/Skelly_0324",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Explaining",
					Text = "{#Emph}Yeah! {#Prev}They're easy to please. But not you, apparently! Geez, I didn't know {#DialogLegendaryFormat}Night's Champion {#Prev}was gonna have so many questions all the time! You want the statues or don't you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3291", Text = "...I... I do!" },
					},
					{
						PreLineWait = 0.38,
						PreLineAnim = "Skelly_Explaining",
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0325", Text = "{#Emph}Good! {#Prev}'Cause we can't send 'em back now that you opened 'em up." },
					},
					{
						PreLineWait = 0.43,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3292", Text = "...What?" },
					},
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0326", Text = "What!" },
					},
				},

			},

			TrophyQuestComplete01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestStage1Complete" },
				},

				{ Cue = "/VO/Melinoe_3275", 

					PreLineFunctionName = "SkellyStatueUnveil",
					PreLineFunctionArgs =
					{
						StatueId = 589801,
						DrapeId = 589805,
						Subtitle = "SkellyStatue_Unlocked_Subtitle_01",

						AnimationNames = { "StatusIconOhBoy", "StatusIconEmbarrassed" },
						ReactionChance = 0.25,
						Delay = 1.01
					},

					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...Commander, is that supposed to be... {#Emph}me?" },
				{ Cue = "/VO/Skelly_0310",
					PreLineAnim = "Skelly_Explaining",
					Emote = "PortraitEmoteSparkly",
					Text = "It is {#DialogLegendaryFormat}Night's Champion {#Prev}foretold by Fate! She who shall strike {#DialogLegendaryFormat}Fear {#Prev}into the hearts of those who stand against the realm and stuff like that! I can see you're at a loss for words, such is the splendor of her likeness! And this is just the first of 'em!" },
				{ Cue = "/VO/Melinoe_3276", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Indeed. And are the other Gifts just as, {#Emph}erm... {#Prev}detailed? Either way, I'm not so certain I can handle twice let alone three times the glory, when my task is difficult enough as it is..." },
				{ Cue = "/VO/Skelly_0311",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Ahh{#Prev}, so then the {#DialogLegendaryFormat}Fear {#Prev}is getting to you. Do not give in to it, young one! Instead, give in to {#DialogLegendaryFormat}Curiosity {#Prev}about those other glorious Gifts! Think of the {#Emph}prestige! {#Prev}Now you can be little scaredy quitter, or {#DialogLegendaryFormat}Night's Champion{#Prev}, which is it gonna be?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3277", Text = "...Do I have to decide this instant?" },
					},
					{
						PreLineWait = 0.44,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0312", Text = "{#Emph}Nah {#Prev}you take however long you need." },
					},
				},
			},

			TrophyQuestComplete02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestStage2Complete" },
				},
				{ Cue = "/VO/Melinoe_3280", 

					PreLineFunctionName = "SkellyStatueUnveil",
					PreLineFunctionArgs =
					{
						StatueId = 589803,
						DrapeId = 589806,
						Subtitle = "SkellyStatue_Unlocked_Subtitle_02",

						AnimationNames = { "StatusIconOhBoy", "StatusIconFiredUp" },
						ReactionChance = 0.30,
						Delay = 1.01
					},

					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...Commander, I... I'm rather at a loss for words, I think! Though I am honored, truly." },
				{ Cue = "/VO/Skelly_0315",
					PreLineAnim = "Skelly_Babbling",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh you {#Emph}better {#Prev}be! You got any idea what I — I mean the {#Emph}Fates {#Prev}must have gone through to put these things together? But {#DialogLegendaryFormat}Night's Champion {#Prev}deserves only the best... which is that {#Emph}last {#Prev}one you haven't seen just yet!" },
				{ Cue = "/VO/Melinoe_3281", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My mind reels at the thought of a sculpture in excess of those. It's covered in Night's drapery... what's to stop me from merely taking a look? Apparently {#Emph}you've {#Prev}already seen it." },
				{ Cue = "/VO/Skelly_0316",
					PreLineAnim = "Skelly_Explaining",
					Text = "Sounds like {#Emph}you {#Prev}might not be {#DialogLegendaryFormat}Night's Champion {#Prev}after all, suggesting underhanded tactics such as that! You want to win top honors, you gotta {#Emph}have {#Prev}honor. And that means no peeking! Now you gonna use the {#DialogLegendaryFormat}Oath {#Prev}again, or what?" },
				{ Cue = "/VO/Melinoe_3282", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...I don't know. All this still strikes me as a bit unwise. While I value your encouragement and am inspired by your words of validation, perhaps I shouldn't be so quick to pin my sense of self-worth on accumulating material possessions." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Babbling",
						{ Cue = "/VO/Skelly_0317", Text = "Come {#Emph}on{#Prev}, young one, you mustn't {#Emph}speak {#Prev}that way!" },
					},
				},
			},

			TrophyQuestComplete03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					NamedRequirements =  { "TrophyQuestStage3Complete" },
				},
				{ Cue = "/VO/Melinoe_3285", 

					PreLineFunctionName = "SkellyStatueUnveil",
					PreLineFunctionArgs =
					{
						StatueId = 589804,
						DrapeId = 589807,
						Subtitle = "SkellyStatue_Unlocked_Subtitle_03",

						AnimationNames = { "StatusIconFiredUp", "StatusIconFear", "StatusIconEmbarrassed" },
						ReactionChance = 0.35,
						Delay = 1.01
					},

					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "I... I'm deeply honored, Commander. To be in service to the realm, and to have earned such... provocative sculptures. I thought art was about the expression of beauty; I never realized that it could inspire so many... complicated emotions." },
				{ Cue = "/VO/Skelly_0320",
					PreLineAnim = "Skelly_Babbling",
					-- DisplayNameMaxLength = 291,
					Text = "I got a lot of complicated emotions just thinking about what it took to get those things in here without you noticing! But anyway, {#DialogLegendaryFormat}congrats{#Prev}. We'd have a feast in your honor or something, but... {#Emph}eh{#Prev}, nobody's supposed to know about this stuff. So it's gonna have to be our secret and all that." },
				{ Cue = "/VO/Melinoe_3286", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So, does this mean I truly am Night's Champion? And eternal glory is mine?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.43,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						{ Cue = "/VO/Skelly_0321", Text = "You better believe it." },
					},
					{
						PreLineWait = 0.51,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3287", Text = "...OK." },
					},
				},
			},

			-- hints
			SkellyHintCast01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0146",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 6.9 },					
					Text = "All your training's gonna be for naught if you don't use it in a fight. Say I'm chasing after you with a club and you want to get me to stay put. Let's see you cast a {#DialogLegendaryFormat}Circle of Binding {#Prev}over here!",
					PostLineThreadedFunctionName = "StartSkellyCastQuest", },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					-- { Cue = "/VO/Melinoe_1579", Text = "Yes, sir." },
				},
			},
			SkellyHintMana01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered", "G_Intro" },
						Comparison = "<=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0075",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 3.5 },
					Text = "The craft you seek to master takes its toll. But not for long, your magick power's gonna come right back by the time you get to the next place you're going. So {#Emph}use it{#Prev}, no point bottling it up!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
				},
			},
			SkellyHintSpellDrop01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 12,
					},
				},
				{ Cue = "/VO/Skelly_0341",
					PreLineAnim = "Skelly_Explaining",
					Text = "I understand that Great Selene graced you with one of them {#DialogLegendaryFormat}Hexes {#Prev}that she's got. A powerful effect, but you must use a bunch of magick first to charge it up! {#Emph}Eh{#Prev}, like charging a crystal!" },
				{ Cue = "/VO/Melinoe_3359", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, I thought most of your experience was in the martial ways? But you know the intricacies of magick as well?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0342", Text = "Oh yeah." },
				},
			},

			SkellyHintDash01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" },
					},
				},
				{ Cue = "/VO/Skelly_0339",
					PreLineAnim = "Skelly_Explaining",
					Text = "Being a shadowy denizen of the Underworld comes with certain perks, young one! Take, for instance, how {#DialogLegendaryFormat}when you Dash, nothing can touch you{#Prev}!" },
				{ Cue = "/VO/Melinoe_3357", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We are the Unseen... at one with the darkness and the dead. I can evade anything, yes. But only for a moment, and even then... I can't prevail by dodging all night long." },
				{ Cue = "/VO/Skelly_0340",
					PreLineAnim = "Skelly_Babbling",
					Text = "{#Emph}Eh{#Prev}, I'd do it all the time if I was you! See the {#DialogLegendaryFormat}little trail {#Prev}when you Dash? Once it snaps back, you're good to go {#Emph}again!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_3358", Text = "{#Emph}The shadow follows..." },
				},
			},
			SkellyHintSprint01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomCountCache", "G_Intro" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Skelly_0076",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 10.2 },
					Text = "You have grown quick, young one. Real quick! Would that I, too, could {#DialogLegendaryFormat}dash {#Prev}so fast as {#DialogLegendaryFormat}to become untouchable{#Prev}, or sprint as fleetly as a... she-wolf, or something? Give me a couple of laps!",
					PostLineThreadedFunctionName = "StartSkellySprintQuest", },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					-- { Cue = "/VO/Melinoe_1579", Text = "Yes, sir." },
				},
			},
			SkellyHintShadeMercs01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeShadeMercs" },
					},
				},
				{ Cue = "/VO/Skelly_0140",
					Text = "Could always use some new disciples here. See any Shades of the Dead out there just loitering around, remember your training and {#DialogLegendaryFormat}sprint right into them{#Prev}! They'll come around.",
				},
				{ Cue = "/VO/Melinoe_1577", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They'll more than come around, sir. They're prepared to join our fight. By now they know exactly who I am, and what we stand for here.",
					PostLineThreadedFunctionName = "StartSkellyShadeMercQuest", },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Skelly_01",
					{ Cue = "/VO/Skelly_0141", Text = "May you keep running into lots of them." },
				},
			},
			SkellyHintResources01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 10,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
						Comparison = "<=",
						Value = 45,
					},
				},
				{ Cue = "/VO/Skelly_0151",
					PreLineAnim = "Skelly_Explaining",
					Text = "My days of running around taking stuff may be over, but yours are only beginning, kiddo! Keep your eyes peeled for stuff you can use out there, and be sure to pack the best {#DialogLegendaryFormat}Tool {#Prev}for the job.",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2254", Text = "You used to run around and... take stuff?" },
				},
			},
			SkellyHintResources02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "ToolPickaxe" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "ToolExorcismBook", "ToolShovel" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				{ Cue = "/VO/Skelly_0364",
					PreLineAnim = "Skelly_Explaining",
					Text = "What ails you, young one? You have a look of consternation, which mayhaps my breadth of experience could alleviate. Go on, just spit it out!" },
				{ Cue = "/VO/Melinoe_3368", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, Commander... I was just thinking about all the reagents I still need. Some grow in different regions, or require different tools... it's a lot to keep in mind." },
				{ Cue = "/VO/Skelly_0365",
					PreLineAnim = "Skelly_Babbling",
					Text = "But you don't gotta keep it all in mind! That {#DialogLegendaryFormat}Purple Pack {#Prev}you carry all of your stuff in, somehow... don't you got all your notes in there too? So if you don't remember where to nab something, check {#Emph}there! {#Prev}In fact, why don't you do it now?",
					PostLineThreadedFunctionName = "StartSkellyInventoryQuest", },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3369", Text = "I do have notes on everything in there..." },
					},
				},
			},

			SkellyHintBones01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
					{
						Path = { "GameState", "Resources", "MetaCurrency" },
						Comparison = ">=",
						Value = 800,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaCurrency" },
						Comparison = "<=",
						Value = 600,
					},
				},
				{ Cue = "/VO/Skelly_0376",
					PreLineAnim = "Skelly_Explaining",
					Text = "With experience, one develops knacks for certain things, and one of {#Emph}my {#Prev}knacks is detecting {#DialogLegendaryFormat}Bones{#Prev}, all shapes and sizes and in varied quantities, and kiddo: {#Emph}You {#Prev}have got {#Emph}a lot." },
				{ Cue = "/VO/Melinoe_3480", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We're in the realm of the dead, Commander. Bones aren't difficult to come by, especially this close to the surface. Though... the Broker may have better use for them." },
				{ Cue = "/VO/Skelly_0377",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Skelly_Babbling",
					Text = "That's basically what {#Emph}I {#Prev}was gonna say! Sure maybe you could use a couple for an incantation here or there but the old {#DialogLegendaryFormat}Broker{#Prev}'s really gonna eat 'em up." },
				EndVoiceLines =
				{
					PreLineWait = 0.42,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3481", Text = "But I like hoarding them..." },
				},
			},


			SkellyHintChoices01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with additional requirements
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "ToolExorcismBook", "ToolShovel" },
					},
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Skelly_0367",
					PreLineAnim = "Skelly_Explaining",
					Text = "Choose wisely, young one, ere you set forth each night! There's your {#DialogLegendaryFormat}Arcana {#Prev}at the Altar, your choice of {#DialogLegendaryFormat}Nocturnal Arms{#Prev}, your {#DialogLegendaryFormat}Keepsake{#Prev}, your {#DialogLegendaryFormat}Gathering Tool{#Prev}, I mean, {#Emph}dang..." },
				{ Cue = "/VO/Melinoe_3370", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a lot to consider when you put it that way, Commander. But my objective is always clear: Find the Titan, slay the Titan. Free my family, free Olympus." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0368", Text = "Well that was like four different things right there..." },
					},
				},
			},

			SkellyHintDying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 10,
					},
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						PathFalse = { "CurrentRun", "RoomCountCache", "G_Boss01" },
					},
				},
				{ Cue = "/VO/Skelly_0152",
					Text = "Now don't lose heart just 'cause you're getting whacked, all right? Between your {#DialogLegendaryFormat}Altar {#Prev}and that {#DialogLegendaryFormat}Silver Puddle {#Prev}back there, you're going to get tougher and tougher, till {#Emph}you're {#Prev}the one doing all the whacking!",
				},
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_2255", Text = "You mean the Silver Pool, sir." },
				},
			},

			SkellyHintGrasp01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardPromptLayout" },
					},
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = "<=",
						Value = 16,
					}
				},
				{ Cue = "/VO/Skelly_0337",
					PreLineAnim = "Skelly_Explaining",
					Text = "So you have reached the limits of your {#DialogLegendaryFormat}Grasp of the Arcana{#Prev}. Happens to everyone! Just need some more of that {#DialogLegendaryFormat}Psyche {#Prev}and you'll soon be grasping for more of them Cards you got!" },
				{ Cue = "/VO/Melinoe_3355", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My connection to the dead, my connection to the past... and the Altar is the conduit! Commander, are you able to draw from the Arcana yourself?" },
				{ Cue = "/VO/Skelly_0338",
					PreLineWait = 0.35,
					Text = "Well used to be I could draw pretty good, but {#Emph}eh{#Prev}, maybe not as good as the pictures on those Cards." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3356", Text = "You draw {#Emph}pictures{#Prev}, sir...?" },
				},
			},


			-- Repeatable
			SkellyChat01 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0012",
					Text = "Mayhaps you could give my disciples a little demonstration, huh?" },
			},
			SkellyChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0013",
					Text = "Less discussion, more concussion here, kiddo!" },
			},
			SkellyChat03 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0048",
					Text = "Come, young one, let's see you deliver your best shot already." },
			},
			SkellyChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0049",
					Text = "Speak not, but concentrate, and strike repeatedly at me!" },
			},
			SkellyChat05 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0050",
					Text = "Patience, young one! You shall... probably get through this whole thing." },
			},
			SkellyChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0051",
					Text = "Have you come to train with me, perchance? Or merely passing through?" },
			},
			SkellyChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0052",
					Text = "Less greeting, more beating, if you would be so kind?" },
			},

			SkellyChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0092",
					Text = "I trust you have some damage to impart?" },
			},
			SkellyChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0093",
					Text = "Pray strike me down, young one, lest I be sad." },
			},
			SkellyChat10 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0094",
					Text = "Hold fast your questions and {#Emph}attack{#Prev}, young one!" },
			},
			SkellyChat11 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0095",
					Text = "Let us not conversate unnecessarily, though you can hit me if you want!" },
			},
			SkellyChat12 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0096",
					Text = "Have you not more important interactions to perform?" },
			},
			SkellyChat13 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0097",
					Text = "Each one of your attempts is but a step along your path. And so is hitting me." },
			},
			SkellyChat14 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0098",
					Text = "Pray focus on your path, or mayhaps beat me up a little first." },
			},
			SkellyChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0099",
					Text = "My disciples all believe in you and stuff." },
			},
			SkellyChat16 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0100",
					Text = "Go forth, young one, and we shall keep vigil here ere you return." },
			},
			SkellyChat17 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0101",
					Text = "Oh, these old bones are more resilient than they appear, see for yourself." },
			},
			SkellyChat18 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				{ Cue = "/VO/Skelly_0102",
					Emote = "PortraitEmoteFiredUp",
					Text = "There shall be time enough for idle chat when victory is ours!" },
			},
			SkellyChat19 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0103",
					Text = "Speak with your {#Emph}weapons{#Prev}, young one, not your words!" },
			},

		},

		GiftTextLineSets =
		{
			-- grants a gift
			SkellyGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_1050", UsePlayerSource = true,
					Text = "Commander, though it falls to us to keep the old traditions alive, may you partake of this Nectar unburdened by the weight of its significance." },
				{ Cue = "/VO/Skelly_0091",
					PreLineAnim = "Skelly_Explaining",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 6.9 },
					Text = "I'm most appreciative of both the offering and of the sentiment. And I summarily shall do my part: {#Emph}Behold! {#Prev}The luckiest of my possessions is in {#Emph}your {#Prev}possession now!" },
			},
			SkellyGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0046",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 10 },
					Text = "{#Emph}Ah{#Prev}, the memories, young one... your brother thusly used to favor me. And for his sake and yours, I shall accept this. Now, please accept {#Emph}my {#Prev}gratitude: {#Emph}Hey, thanks!" },
				{ Cue = "/VO/Melinoe_1051", UsePlayerSource = true,
					Text = "You are most welcome, Commander, and hey thanks to you in turn for your peerless insight and steadfast presence." },
			},
			SkellyGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0047",
					Text = "I'm most appreciative of your generosity. Would that I had more to give you in return besides the wisdom of my vast experience..." },
				{ Cue = "/VO/Melinoe_1052", UsePlayerSource = true,
					Text = "Please, sir, that is more than enough. Your disciples and I are fortunate to study under you." },
			},
			SkellyGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Skelly_0371",
					PreLineAnim = "Skelly_Explaining",
					Text = "I must not partake in such extravagances! For my disciples are counting on my cleared-eyed counsel and undivided attention. But tell you what I'm gonna save this one for later when I'm off, OK?" },
				{ Cue = "/VO/Melinoe_3484", UsePlayerSource = true,
					Text = "What you call an extravagance... it must be nothing compared to the luxuries of my father's House. Yet you never want for anything. Besides the occasional hit or two." },
				--[[
				-- { Cue = "/VO/Melinoe_3372", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "The Nectar's yours to do with as you please, sir! May it lighten the burden of responsibility you bear to all the Shades and others counting on your skill and knowledge." },
					]]--
			},

			-- placeholder
			SkellyGiftTemp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "UnavailableHeartIcon",
				HintId = "Codex_UnavailableHint",
				Cost =
				{
					MysteryResource = 1,
				},
			},

			SkellyBathHouseDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},

				},
				{ Cue = "/VO/Melinoe_3361", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, would you be willing to accompany me to the Springs sometime? We could rest our weary bones a bit." },
				{ Cue = "/VO/Skelly_0345",
					Emote = "PortraitEmoteSurprise",
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "What are you gonna do, carry me? I'm required {#Emph}here{#Prev}, young one, for these Shades still require discipline! Mayhaps some other age, when all we hold dear isn't at stake..." },
			},
			SkellyFishingDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_3360", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Commander, we've restored our fishing pier! Would you mind joining me there, given all your nautical experience?" },
				{ Cue = "/VO/Skelly_0344",
					PreLineAnim = "Skelly_Explaining",
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "My days amongst the fishes are long gone, young one. And besides, my place is here... right in this particular spot. Though, thanks!" },
			},

		},

		GiftGivenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1053", Text = "You honor me, Commander." },
			},
		},

		WeaponUnlockReactionVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.7,
				Cooldowns =
				{
					{ Name = "SkellyWeaponEquipSpeech", Time = 10 },
				},

				-- Heeey nice!
				-- -- { Cue = "/VO/Skelly_0085", Text = "TODO(BuildText) Skelly_0085", },
			},
		},

		OnDeathThreadedFunctionName = "SkellyDeath",
		OnDeathFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.25, Delay = 0.25 },
		RespawnAtIdOnDeath = 589735,
		OnDeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyIntro",
					SkipAnim = true,
					PreLineWait = 0.25,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "ActiveObjectives", "HitSkelly" },
						},
						{
							PathFalse = { "CurrentRun", "ObjectivesCompleted", "HitSkelly" },
						},
					},

					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					{ Cue = "/VO/Skelly_0172", Text = "Close enough..." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyIntro",
					SkipAnim = true,
					PreLineWait = 0.25,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0172" },
						},
					},

					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					{ Cue = "/VO/Skelly_0021", Text = "I shall return..." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "SkellyIntroResponse",
					BreakIfPlayed = true,
					UsePlayerSource = true,
					PreLineWait = 0.1,

					{ Cue = "/VO/Melinoe_0076", Text = "Forgive me, sir..." },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SkipAnim = true,
					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					
					{ Cue = "/VO/Skelly_0021", Text = "I shall return..." },
					{ Cue = "/VO/Skelly_0020", Text = "A fatal blow..." },
					{ Cue = "/VO/Skelly_0061", Text = "I... must... go...", PlayFirst = true },
					{ Cue = "/VO/Skelly_0062", Text = "Curse these old bones!" },
					{ Cue = "/VO/Skelly_0063", Text = "Excellent!" },
					{ Cue = "/VO/Skelly_0064", Text = "Well struck!" },
					{ Cue = "/VO/Skelly_0065", Text = "I fall..." },
					{ Cue = "/VO/Skelly_0280", Text = "That's... the... stuff..." },
					{ Cue = "/VO/Skelly_0281", Text = "Got... me... good..." },
					{ Cue = "/VO/Skelly_0282", Text = "Ah, the memories..." },
					{ Cue = "/VO/Skelly_0283", Text = "That did the trick..." },
					{ Cue = "/VO/Skelly_0284", Text = "I'm... outta here..." },
					{ Cue = "/VO/Skelly_0285", Text = "There goes my body parts..." },
				},
			},
		},
		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "SkellyOnHitSpeech", Time = 8 },
				},
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "RavenFamiliarMelee", "ShadeMercSpiritball" },
					},
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "SourceProjectile", },
							IsAny = { "CatFamiliarPounce" },
						},
					},
					{ Cue = "/VO/Skelly_0352", Text = "I look like a scratching post to you?", PlayFirst = true },
					{ Cue = "/VO/Skelly_0353", Text = "{#Emph}Achoo!" },
					{ Cue = "/VO/Skelly_0354", Text = "{#Emph}Achoo..." },
					{ Cue = "/VO/Skelly_0355", Text = "{#Emph}<Sniff> {#Prev}Damn sinuses..." },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					ChanceToPlay = 0.2,
					PlayOnceFromTableThisRun = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "CompletedRunsCache" },
							Comparison = ">=",
							Value = 1,
						},
					},
					{ Cue = "/VO/Skelly_0217", Text = "That stick has got some heft!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0218", Text = "Sure that's no walking stick?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0219", Text = "Like getting stung by bees.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "Weapons" },
								HasAny = { "WeaponDagger" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0170", Text = "That cuts straight to the bone!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "Weapons" },
								HasAny = { "WeaponDagger", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0178", Text = "What a chop!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0179", Text = "Such strength!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0220", Text = "Whoa {#Emph}Momma!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0181", Text = "{#Emph}Ah{#Prev}, it burns!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0182", Text = "Hot stuff right there!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0221", Text = "I almost budged!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "Weapons" },
								HasAny = { "WeaponAxe", "WeaponLob" },
							},
						},
					},
					{ Cue = "/VO/Skelly_0222", Text = "Not a bad Skull you got!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.15,
					RandomRemaining = true,

					{ Cue = "/VO/Skelly_0166", Text = "Disciples, watch and learn!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0167", Text = "Observe, my disciples!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0168", Text = "You all see that technique?",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0169", Text = "Yeah, teach those Shades back there!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01" },
							},
						},
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0018", Text = "Again!", PlayFirst = true,
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0019", Text = "Again, dammit!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0053", Text = "With all your might!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0054", Text = "Are you a witch, or aren't you?!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0055", Text = "A solid hit.",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0056", Text = "Right where the solar plexus used to be!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0057", Text = "Straight to the vertebrae!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0058", Text = "Right in the ribcage!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0059", Text = "Once more!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0060", Text = "Do not relent!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0117", Text = "Take the next step, young one.",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
					{ Cue = "/VO/Skelly_0118", Text = "The path to perfection!",
						PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.1 },
					},
				},
			},
		},

		KillsRequiredForVoiceLines = 1,

		OnSpawnVoiceLines =
		{
			ThreadName = "RoomThread",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				Cooldowns =
				{
					{ Name = "SkellyOnRespawnSpeech", Time = 20 },
				},

				{ Cue = "/VO/Skelly_0023", Text = "I have returned." },
				{ Cue = "/VO/Skelly_0068", Text = "I rise again." },
				{ Cue = "/VO/Skelly_0286", Text = "Never accept defeat!" },
				{ Cue = "/VO/Skelly_0288", Text = "What news?", PlayFirst = true },
				{ Cue = "/VO/Skelly_0291", Text = "The things that I have seen..." },
				{ Cue = "/VO/Skelly_0114", Text = "{#Emph}Behooold!" },
			},
		},

		OnRespawnVoiceLines =
		{
			ThreadName = "RoomThread",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.85,
				Cooldowns =
				{
					{ Name = "SkellyOnRespawnSpeech", Time = 20 },
				},
				TriggerCooldowns = { "SkellyQuipAnySpeech", "SkellyOnHitSpeech" },

				{ Cue = "/VO/Skelly_0022", Text = "You see?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "SkellyIntro",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0021" },
						},
					},
				},
				{ Cue = "/VO/Skelly_0023", Text = "I have returned." },
				{ Cue = "/VO/Skelly_0066", Text = "Let us continue." },
				{ Cue = "/VO/Skelly_0067", Text = "We always get back up." },
				{ Cue = "/VO/Skelly_0068", Text = "I rise again." },
				{ Cue = "/VO/Skelly_0069", Text = "But can you vanquish me again?" },
				{ Cue = "/VO/Skelly_0286", Text = "Never accept defeat!" },
				{ Cue = "/VO/Skelly_0287", Text = "My vigil thus resumes." },
				{ Cue = "/VO/Skelly_0288", Text = "What news?" },
				{ Cue = "/VO/Skelly_0289", Text = "You may continue." },
				{ Cue = "/VO/Skelly_0290", Text = "A different tactic now?" },
				{ Cue = "/VO/Skelly_0291", Text = "The things that I have seen..." },				
			},
		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.1,
				PlayOnceFromTableThisRun = true,
				GameStateRequirements =
				{
					AreIdsNotAlive = { 420928 },
				},

				{ Cue = "/VO/Melinoe_2956", Text = "Where's the Commander?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2957", Text = "Commander...?" },
			},
		},
		
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Skelly )