UnitSetData.NPC_Selene =
{
	-- Selene (Hub version), SeleneHome
	NPC_Selene_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable", },
		GenusName = "SpellDrop",

		Portrait = "Portrait_Selene_Default_01",
		Groups = { "NPCs" },
		AnimOffsetZ = 250,
		InvincibubbleScale = 1,
		SpeakerName = "Selene",

		InteractTextLineSets =
		{
			SeleneHome01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ItemInteractions", "SpellDrop", },
						Comparison = ">=",
						Value = 7,
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0108",
					Text = "Ah, little star! During such phases, I remain unseen in the night sky, and can enjoy a moment's rest. So let us speak a little more, although I fear that speaking starts to drain me of my light. How fares the task?" },
				-- { Cue = "/VO/Melinoe_0005", UsePlayerSource = true,
				{ Cue = "/VO/Melinoe_0488", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Great Selene, I am honored by your presence here. The task proceeds at pace I think, although as you well know, we have much left to do. I'm grateful you've been watching over me." },
				{ Cue = "/VO/Selene_0109",
					PostLineThreadedFunctionName = "HecateExit", PostLineFunctionArgs = { SkipAnim = true, AnimationState = "NPCSeleneExited", WaitTime = 3.2 },
					Text = "And I am grateful for the opportunity. I am the Eye of Night, but you, I think, have come to be her sword. Until we see each other once again under her veil." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0489", Text = "Farewell till then." },
				},
			},

			-- Partner Conversations
			SeleneWithHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				Partner = "NPC_Hecate_01",
				UseText = "UseListenNPC",
				-- BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				TeleportToId = 566613,
				-- TeleportOffsetX = -100,
				-- TeleportOffsetY = 100,
				-- AngleTowardTargetId = 556921,
				InteractDistance = 400,

				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateAboutSurfaceSurvival02", "SeleneHome01" },
					},
					{
						Path = { "GameState", "ItemInteractions", "SpellDrop", },
						Comparison = ">=",
						Value = 8,
					},
					MinRunsSinceAnyTextLines = { TextLines = { "SeleneHome01" }, Count = 3 },
				},

				{ Cue = "/VO/Selene_0106",
					Text = "It gladdens me to see you, Hecate. I have observed the stalemate upon Olympus holds, although the Titan Chronos musters forces in Ephyra still. Shall I continue monitoring them?" },
				{ Cue = "/VO/Hecate_0199", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "Yes, Selene, do. Blasted Ephyra is the closest exit out of here. Do you suppose they are prepared for a single assailant to weave through their ranks?" },
				{ Cue = "/VO/Selene_0107",
					PostLineThreadedFunctionName = "HecateExit", PostLineFunctionArgs = { SkipAnim = true, AnimationState = "NPCSeleneExited", WaitTime = 3.2 },
					Text = "The Titan's forces are somewhat in disarray. Thus no, I do not think they are sufficiently prepared for one of us. But I shall watch and make certain of it. For now I must be off. Together we shine." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Hecate_01",
					{ Cue = "/VO/Hecate_0200", Text = "Farewell. Together we shine." },
				},

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,
			},

		},

		RepulseOnMeleeInvulnerableHit = 250,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			PlayFromTarget = true,
			CooldownTime = 7,

			-- Harrhh...!
			-- -- { Cue = "/VO/Charon_0028", Text = "TODO(BuildText) Charon_0028" },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Selene )