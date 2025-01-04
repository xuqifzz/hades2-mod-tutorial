NarrativeData = NarrativeData or {}
OverwriteTableKeys( NarrativeData, {
	-- Hecate
	NPC_Hecate_01 =
	{
		InteractTextLinePriorities =
		{
			"HecateGrantsWeaponUpgradeSystem01",

			"HecateAboutChronosBossW01",
			"HecateAboutChronosBossW01Cont1",
			"HecateAboutChronosBossEarlyL01",
			"HecateAboutChronosBossL01",
			"HecateAboutChronosBossL02",
			"HecateAboutPrometheus01",
			"HecateAboutPrometheusL01",
			"HecateAboutPrometheusW01",
			"HecateAboutChronosAnomaly01",
			"HecateAboutChronos01",
			{
				"HecateAboutHades01",
				"HecateAboutHermes01",
			},
			{
				"HecateAboutFates01",
				"HecateAboutChronos02",
			},
			"HecateFirstMeeting_B",
			"HecateFirstMeeting",
			"HecateFirstMeetingCont1",
			"HecateFirstMeetingCont2",
			-- immediate-contextual
			{
				"HecateAboutQuestLog02",
				"HecateAboutQuestLog01",
				"HecateAboutSurface03",
				"HecateAboutSurfaceSurvival01",
				"HecateAboutSurfaceSurvival02",
			},
			{
				"HecateUnderworldRunCleared01",
				"HecateAboutCerberus01",
				"HecateAboutCerberus02",
				"HecateAboutTimeStop01",
				"HecateAboutErisFight01",
			},
			{
				"HecateGrantsFamiliars01",
			},
			{
				"HecateAboutChronosAnomaly02",
			},
			{
				"HecateAboutMoros01",
				"HecateAboutArtemis01",
				"HecateAboutHades02",
				"HecateAboutAthena01",
				"HecateAboutEris01",
			},
			{
				"HecateAboutChaos01",
			},
			{
				"HecateLostAgainstHer01",
				"HecateWonAgainstHer01",
				"HecateAboutOlympus01",
			},
			{
				"HecateAboutFamilyPortrait01",
				"HecateAboutBountyBoard01",
				"HecateAboutArachne01",
				"HecateAboutArachne02",
				"HecateAboutArachne03",
			},
			-- priority story
			{
				"HecateAboutBackstory01",
			},
			{
				"HecateAboutTask01",
				"HecateAboutSurface02",
				"HecateAboutSurface01",
				"NemesisWithHecate01",
				"HecateAboutPressure01",
			},
			{
				"HecateAboutFamily02",
			},
			{
				"CharonWithHecate01",
				"ArachneWithHecateInHub01",
				"ArachneWithHecateInHub02",
				"SeleneWithHecate01",
				"OdysseusWithHecate01",
			},
			-- lower-priority contextual
			{
				"HecateAboutCardUpgradeSystem01",
			},
			{
				"HecateAboutCirce01",
			},
			{
				"HecateAboutNemesis01",
				"HecateAboutMedea01",
				"HecateAboutIcarus01",
				"HecateAboutAltCauldron01",
				"HecateAboutAltCauldron02",
			},
			{
				"HecateAboutOceanus01",
				"HecateAboutThessaly01",
			},
			{
				"HecateLostAgainstHer02",
				"HecateAboutFamiliars01",
				"HecateAboutFamiliars02",
				"HecateAboutZeus01",
				"HecateAboutResources03",
				"HecateAboutAspects01",
				"HecateAboutRelationships01",
			},
			{
				"HecateAboutSelene01",
				"HecateAboutWeapons01",
				"HecateAboutArcana01",
				"HecateAboutResources01",
				"HecateAboutResources02",
				"HecateAboutShades01",
				"HecateAboutArcana02",
				"HecateAboutWitchcraft01",
				"HecateAboutCauldronWitchcraft01",
				"HecateAboutTorch01",
				"HecateAboutMedea02",
				"HecateAboutCirce02",
				"HecateAboutFamiliars03",
				"HecateAboutCosmetics01",
				"HecateAboutGarden01",
			},
			{
				"HecateAboutCodex01",
				"HecateAboutNightmares01",
			},
			-- lower-priority story
			{
				"HecateAboutFamily01",
				"HecateAboutTask02",
				"OdysseusWithHecate02",
			},
			-- evergreen
			{
				"HecateAboutWellness01",
				"HecateAboutBeasts01",
				"HecateAboutCauldron01",
				"HecateAboutCrossroads01",
			},
		},

		-- additions need to be duplicated below
		GiftTextLinePriorities =
		{
			"HecateGift01",
			"HecateGift02",
			"HecateBathHouse01",
			"HecateGift03",
			"HecateFishing01",
			"HecateGift04",
			"HecateGift05",
			"HecateBathHouse02",
			"HecateGift06",
			"HecateTaverna01",
			"HecateGiftTemp", -- placeholder
			"HecateFishingDecline01",
			"HecateBathHouseDecline01",
			"HecateTavernaDecline01",
		},
	},

	-- Hecate_Story
	NPC_Hecate_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"HecateHideAndSeek01",
			"HecateHideAndSeek02",
			"HecateHideAndSeek03",
		},

		GiftTextLinePriorities =
		{
			"HecateGift01",
			"HecateGift02",
			"HecateBathHouse01",
			"HecateGift03",
			"HecateFishing01",
			"HecateGift04",
			"HecateGift05",
			"HecateBathHouse02",
			"HecateGift06",
			"HecateTaverna01",
			"HecateGiftTemp", -- placeholder
			"HecateFishingDecline01",
			"HecateBathHouseDecline01",
			"HecateTavernaDecline01",
		},

	},

	-- Dora
	NPC_Dora_01 =
	{
		InteractTextLinePriorities =
		{
			"DoraFirstMeeting",
			"DoraAboutPrometheus02",
			"DoraAboutPrometheus03",
			"DoraAboutPrometheus04",
			"DoraAboutChronosBossW01",
			"DoraGrantsCosmeticsShop01",
			"DoraAboutTask01",
			"DoraAboutChronos01",
			-- cosmetics-related
			{
				"DoraAboutShades01",
				"DoraListless01",
				"DoraListless02",
				"DoraListless03",
			},
			-- immediate-contextual
			{
				"DoraAboutSurface01",
				"DoraAboutOceanus01",
				"DoraAboutFields01",
				"DoraAboutThessaly01",
				"DoraAboutOlympus01",
				"DoraAboutNightmares01",
				"DoraAboutPackagedBounties01",
				"DoraAboutPainting01",
				"DoraAboutKeepsake01",
				"DoraAboutChronosBossW02",
				"DoraAboutPrometheus01",
			},
			-- priority story
			{
				"DoraAboutTask02",
				"DoraAboutTent02",
				"DoraAboutTent03",
			},
			{
				"DoraAboutTent01",
				"DoraRunProgress01",
				"DoraAboutReturning01",
				"DoraAboutExisting01",
			},
			-- lower-priority contextual
			{
				"DoraAboutSkelly01",
				"DoraAboutMemorySpell01",
			},
			{
				"DoraAboutCosmetics01",
				"DoraAboutCosmetics02",
				"DoraAboutCosmetics03",
				"DoraAboutShades02",
				"DoraAboutShades03",
				"DoraAboutMoros01",
				"DoraAboutHaunting03",
			},
			{
				"DoraWithMoros01",
				"DoraAboutHecate01",
				"DoraAboutMoros02",
				"DoraAboutMoros03",
				"DoraAboutHeracles01",
				"DoraAboutNightmares02",
				"DoraAboutOutside01",
				"DoraAboutSurface02",
			},
			-- lower priority story
			{
				"DoraWithMoros02",
				"DoraWithSkelly01",
				"DoraAboutShades04",
				"DoraAboutShades04_B",
				"DoraAboutFrinos01",
			},
			{
				"DoraAboutReturning02",
				"DoraAboutReturning03",
				"DoraAboutHaunting02",
				"DoraAboutHaunting04",
				"DoraAboutHaunting05",
			},
			-- evergreen
			{
				"DoraAboutHaunting01",
				"DoraAboutNemesis01",
				"DoraAboutHypnos01",
				"DoraAboutCompanions01",
			},
		},

		GiftTextLinePriorities =
		{
			"DoraGift01",
			"DoraBathHouse01",
			"DoraGift02",
			"DoraGift03",
			"DoraFishing01",
			"DoraGift04",
			"DoraGift05",
			"DoraBathHouse02",
			"DoraGift06",
			"DoraTaverna01",
			"DoraGiftTemp", -- placeholder
			"DoraBathHouseDecline01",
			"DoraFishingDecline01",
			"DoraTavernaDecline01",
		},
	},

	-- Odysseus
	NPC_Odysseus_01 =
	{
		InteractTextLinePriorities =
		{
			"OdysseusHideAndSeek01",
			"OdysseusFirstMeeting",

			-- immediate-contextual
			"OdysseusAboutChronosBossW01",
			"OdysseusAboutChronosBossL01",
			"OdysseusAboutErisCurse01",
			"OdysseusAboutChronos02",
			"OdysseusAboutChronosAnomaly01",
			"OdysseusAboutMailbox01",
			"OdysseusAboutLosingToHecate01",
			{
				"OdysseusAboutHermes01",
				"OdysseusAboutFields01",
				"OdysseusAboutTartarus01",
				"OdysseusAboutOlympus01",
			},
			{
				"OdysseusAboutScylla01",
				"OdysseusAboutScylla02",
				"OdysseusAboutTreant01",
				"OdysseusAboutFogEmitter01",
				"OdysseusAboutWaterUnitMiniboss01",
				"OdysseusAboutCharybdis01",
				"OdysseusAboutCerberus01",
				"OdysseusAboutCerberus01_B",
				"OdysseusAboutVampire01",
				"OdysseusAboutLamia01",
				"OdysseusAboutRatCatcher01",
				"OdysseusAboutGoldElemental01",
				"OdysseusAboutSatyrCrossbow01",
				"OdysseusAboutPolyphemus02",
				"OdysseusAboutErisBoss01",
				"OdysseusAboutPrometheus01",
			},
			{
				"OdysseusAboutTalos01",
				"OdysseusAboutVerminMiniboss01",
			},
			{
				"OdysseusAboutSurface01",
				"OdysseusAboutSurface02",
				"OdysseusAboutScylla04",
				"OdysseusAboutCirce01",
				"OdysseusAboutCirce02",
			},
			{
				"OdysseusAboutFamiliars01",
				"OdysseusAboutRain01",
				"OdysseusAboutPolyphemus01",
				"OdysseusAboutHeracles01",
				"OdysseusAboutOceanus01",
				"OdysseusAboutThessaly01",
				"OdysseusAboutMoros01",
			},
			{
				"OdysseusAboutNemesis01",
				"OdysseusAboutNemesis02",
			},
			{
				"OdysseusAboutCosmetics01",
				"OdysseusAboutCosmetics02",
			},
			-- priority story
			{
				"OdysseusAboutChronos01",
				"OdysseusAboutPoseidon01",
				"OdysseusAboutHecate01",
				"OdysseusAboutMountains01",
			},
			-- lower-priority contextual
			{
				"OdysseusAboutPressure02",
				"OdysseusAboutPolyphemus03",
			},
			{
				"OdysseusBackstory02",
				"OdysseusAboutMood01",
				"OdysseusAboutScylla03",
				"OdysseusAboutHypnos01",
				"OdysseusAboutEris01",
				"OdysseusAboutPressure01",
				"OdysseusAboutGarden01",
				"OdysseusAboutVampire01_B",
			},
			{
				"OdysseusAboutAxe01",
				"OdysseusAboutBows01",
			},
			-- lower-priority story
			{
				"MorosWithOdysseus01",
				"MorosWithOdysseus02",
				"MorosWithOdysseus03",
				"OdysseusWithHecate01",
				"OdysseusWithHecate02",
				"OdysseusWithNemesis01",
				"OdysseusAboutErebus01",
				"OdysseusBackstory01",
				"OdysseusAboutTravel01",
			},
			-- evergreen
			{
				"OdysseusAboutSkelly01",
				"OdysseusAboutAdvice01",
				"OdysseusMeeting05",
			},
		},

		GiftTextLinePriorities =
		{
			"OdysseusGift01",
			"OdysseusGift02",
			"OdysseusFishing01",
			"OdysseusGift03",
			"OdysseusGift04",
			"OdysseusBathHouse01",
			"OdysseusGift05",
			"OdysseusBathHouse02",
			"OdysseusGift06",
			"OdysseusTaverna01",
			"OdysseusGiftTemp", -- placeholder
			"OdysseusBathHouseDecline01",
		},
	},

	-- Hermes
	NPC_Hermes_01 =
	{
		InteractTextLinePriorities =
		{
			"HermesFirstPickUp",
		},
	},

	-- Nemesis
	NPC_Nemesis_01 =
	{
		InteractTextLinePriorities =
		{
			"NemesisFirstMeeting",
			-- high-priority story
			-- high-priority contextual
			{
				"NemesisAboutFamily02",
			},
			{
				"NemesisAboutChronosBossW01",
				"NemesisAboutChronosBossL02",
				"NemesisAboutErisFight01",
				"NemesisAboutPrometheus01",
			},
			{
				"NemesisAboutErisFightW01",
				"NemesisAboutChronosBossL01",
				"NemesisAboutCombatFailure01",
			},
			{
				"NemesisAboutFieldMeeting01",
			},
			{
				"NemesisAboutFieldMeeting02",
			},
			{
				"NemesisAboutMoros02",
			},
			{
				"NemesisAboutChronosNightmare01",
				"NemesisAboutChronosNightmare02",
				"NemesisAboutMoros01",
			},
			{
				"NemesisAboutCharon01",
				"NemesisAboutNarcissus01",
			},
			"NemesisAboutSurface03",
			{
				"NemesisAboutSurface01",
				"NemesisAboutSurface01_B",
			},
			{
				"NemesisAboutSurface02",
				"NemesisAboutFates01",
				"NemesisAboutDefeatingHecate01",
				"NemesisAboutLosingToHecate01",
				"NemesisAboutChronosBossL01_B",
			},
			{
				"NemesisAboutEris01",
			},
			-- priority story
			{
				"NemesisAboutTask01",
			},
			{
				"NemesisAboutFamily01",
			},
			{
				"NemesisWithMoros01",
				"NemesisAboutQuestLog01",
				"NemesisAboutTask03",
				"NemesisAboutTraining01",
				"NemesisAboutGoldenAge01",
			},
			-- lower-priority contextual
			{
				"NemesisWithMorosAboutRelationships01",
			},
			{
				"NemesisAboutChronosBossFights01",
				"NemesisAboutErisFight02",
				"NemesisAboutHecate01",
				"NemesisAboutHecate02",
				"NemesisAboutOdysseus01",
				"NemesisAboutArtemis02",
				"NemesisAboutFieldMeeting03"
			},
			{
				"NemesisAboutNectar02",
				"NemesisAboutCauldron01",
				"NemesisAboutHypnos01",
				"NemesisAboutNectar01",
				"NemesisAboutArtemis01",
				"NemesisAboutChaos01",
				"NemesisAboutNarcissus02",
				"NemesisAboutTrainingGrounds01",
			},
			-- lower priority story
			{
				"NemesisWithEris01",
				"NemesisWithEris02",
			},
			{
				"OdysseusWithNemesis01",
				"NemesisWithHecate01",
				"NemesisWithMoros02",
				"NemesisAboutEvil01",
			},
			{
				"NemesisAboutTask02",
				"NemesisAboutEvil02",
				"NemesisAboutWeapons01",
				"NemesisWithHypnos01",
				"NemesisAboutTask04",
			},
			-- evergreen
			{
				"NemesisAboutWaiting01",
			},
		},

		GiftTextLinePriorities =
		{
			"NemesisGift01",
			"NemesisGift02",
			"NemesisGift03",
			"NemesisFishing01",
			"NemesisBathHouse01",
			"NemesisGift04",
			"NemesisBathHouse02",
			"NemesisGift05",
			"NemesisTaverna01",
			"NemesisGiftTemp",
			"NemesisGiftDecline01",
			"NemesisFishingDecline01",
			"NemesisBathHouseDecline01",
		},

		PostCombatEventsPriorities =
		{
			"NemesisPostCombatFirstMeeting",
			"NemesisPostCombatAboutProgress01",
			{
				"NemesisPostCombatAboutCerberus01",
				"NemesisPostCombatAboutChronos01",
			},
			{
				"NemesisPostCombatAboutTartarus01",
				"NemesisPostCombatAboutKeepsake01",
				"NemesisPostCombatAboutHecate01",
				"NemesisPostCombatAboutScylla01",
				"NemesisPostCombatAboutSurface01",
			},
			{
				"NemesisPostCombatAboutLosing01",
				"NemesisPostCombatAboutOceanus01",
			},
			"NemesisPostCombatAboutArmor01",
			"NemesisPostCombatAboutFailure01",
		},

		RandomEventsPriorities =
		{
			"NemesisGetFreeItemIntro01",
			"NemesisTakeDamageForItemRepeatSightings01",
			"NemesisGetFreeItemIntroBridge01",
			"NemesisBuyItemFields01",
			{
				"NemesisBuyItemIntro01",
				"NemesisTakeDamageForItemIntro01",
				"NemesisGiveTraitForItemIntro01",
				"NemesisDamageContestIntro01",
			},
			{
				"NemesisGetFreeItemIntro02",
			},
		},

		ShoppingPriorities =
		{
			
		}
	},

	-- Moros
	NPC_Moros_01 =
	{
		InteractTextLinePriorities =
		{
			"MorosFirstMeeting",
			"MorosAboutQuestLog01",
			"MorosAboutSearch01",
			"MorosAboutTask01",
			"MorosAboutFates02",
			"MorosAboutFates03",
			"MorosAboutSurfacePenaltyCure01",

			-- immediate-contextual
			{
				"MorosAboutSurfacePenaltyCure02",
				"MorosAboutChronosBossW01",
				"MorosAboutEris02",
				"MorosAboutPrometheus01",
				"MorosAboutPrometheus02",
			},
			{
				"MorosAboutEris01",
				"MorosAboutChaos02",
			},
			{
				"MorosAboutChaos01",
			},

			-- priority story
			{
				"MorosAboutCrossroads01",
			},
			"NemesisWithMoros01",
			"MorosWithCharon01",
			"MorosWithCharon02",

			-- lower-priority contextual
			{
				"NemesisWithMorosAboutRelationships01",
			},
			{
				"DoraWithMoros01",
				"MorosAboutForesight03",
				"MorosAboutDoom03",
				"MorosAboutNemesis01",
				"MorosAboutQuestLog02",
				"MorosAboutQuestLog03",
				"MorosAboutQuestLog04",
				"MorosAboutDora01",
				"MorosAboutRelationship01",
				"MorosAboutRelationship02",
				"MorosAboutKeepsake01",
				"MorosAboutBountyBoard01",
				"MorosAboutShrine01",
				"MorosAboutFates05",
				"MorosAboutNemesis02",
				"MorosAboutArachne01",
				"MorosAboutMorosAspect01",
			},
			-- lower-priority story
			{
				"DoraWithMoros02",
				"NemesisWithMoros02",
				"MorosWithHypnos01",
				"MorosWithOdysseus01",
				"MorosWithOdysseus02",
				"MorosWithOdysseus03",
				"MorosWithEris01",
				"MorosWithEris02",
				"MorosAboutForesight01",
				"MorosAboutDoom01",
				"MorosAboutNyx01",
				"MorosAboutSearch02",
				"MorosAboutFates04",
				"MorosAboutQuestLog05",
				"MorosAboutSkelly01",
			},
			-- evergreen
			{
				"MorosAboutWitchcraft01",
				"MorosAboutReturning01",
				"MorosAboutOdysseus01",
				"MorosAboutDeath01",
			},
			{
				"MorosAboutWeapons01",
				"MorosAboutDoom02",
				"MorosAboutForesight02",
				"MorosAboutFates01",
			},

		},

		GiftTextLinePriorities =
		{
			"MorosGift01",
			"MorosGift02",
			"MorosBathHouse01",
			"MorosGift03",
			"MorosFishing01",
			"MorosGift04",
			"MorosBathHouse02",
			"MorosGift05",
			"MorosTaverna01",
			"MorosGiftTemp", -- placeholder
			"MorosFishingDecline01",
			"MorosBathHouseDecline01",
		},
	},

	-- Hypnos (alts below)
	NPC_Hypnos_01 =
	{
		InteractTextLinePriorities =
		{
			"HypnosHideAndSeek01",
			"HypnosFirstMeeting",
			"HypnosAboutPoppies01",
			"NemesisWithHypnos01",
			"MorosWithHypnos01",
		},

		GiftTextLinePriorities =
		{
			"HypnosWakeUp01",
			"HypnosGift01",
			"HypnosGift02",
		},
	},

	NPC_Hypnos_02 =
	{
		InteractTextLinePriorities =
		{
			"HypnosDreamMeeting01",
		},
	},

	-- Skelly
	NPC_Skelly_01 =
	{
		InteractTextLinePriorities =
		{
			"TrophyQuestComplete01",
			"TrophyQuestComplete02",
			"TrophyQuestComplete03",
			"SkellyAboutTrophyQuest01",
			{
				"SkellyAboutTrophyQuestProgress01_A",
				"SkellyAboutTrophyQuestProgress01_B",
				"SkellyAboutTrophyQuestProgress02_A",
				"SkellyAboutTrophyQuestProgress02_B",
				"SkellyAboutTrophyQuestProgress03_A",
				"SkellyAboutTrophyQuestProgress03_B",
			},
			"SkellyAboutTrophyQuest02",
			"SkellyAboutTrophyQuest03",

			"SkellyAboutShrine01",
			"SkellyAboutChronosBossW02",
			"SkellyAboutChronosBossW01",
			"SkellyFirstMeeting",
			-- immediate-contextual
			{
				"SkellyAboutSurface02",
			},
			{
				"SkellyAboutAspects01",
			},
			{
				"SkellyAboutCerberus01",
				"SkellyAboutCerberus01B",
				"SkellyAboutPrometheus01",
			},
			{
				"SkellyAboutRouteChoice01",
				"SkellyAboutSurface01",
				"SkellyAboutOceanus01",
				"SkellyAboutThessaly01",
				"SkellyAboutOlympus01",
			},
			{
				"SkellyAboutCardUpgradeSystem01",
				"SkellyAboutUnusedWeaponBonus01",
				"SkellyAboutFamiliars01",
				"SkellyAboutBountyBoard01",
				"SkellyAboutBounties01",
				"SkellyAboutGodMode01",
			},
			{
				"SkellyAboutCharon01",
			},
			{
				"SkellyAboutKeepsake01",
				"SkellyAboutGiftRack01",
				"SkellyAboutGiftRack02",
				"SkellyAboutCosmetics01",
			},
			-- priority story
			{
				"SkellyAboutZagreus01",
			},
			-- lower-priority contextual
			{
				"SkellyAboutExorcismBook01",
				"SkellyAboutOceanus02",
				"SkellyAboutAltar01",
				"SkellyAboutShrine02",
				"SkellyAboutShrine03",
			},
			"SkellyHintDash01",
			"SkellyHintGrasp01",
			"SkellyHintResources02",
			"SkellyHintMana01",
			"SkellyHintCast01",
			{
				"SkellyHintChoices01",
				"SkellyHintBones01",
			},
			"SkellyHintSpellDrop01",
			"SkellyHintShadeMercs01",
			{
				"SkellyAboutDagger01",
				"SkellyAboutAxe01",
				"SkellyAboutTorch01",
				"SkellyAboutLob01",
				"SkellyAboutSuit01",
			},
			"SkellyAboutChatting01",
			-- lower-priority story
			{
				"SkellyAboutCharon02",
				"DoraWithSkelly01",
			},
			-- evergreen
			{
				"SkellyHintSprint01",
				"SkellyHintResources01",
				"SkellyHintDying01",
				"SkellyAboutStaff01",
			},
			{
				"SkellyAboutTraining01",
				"SkellyAboutTask01",
				"SkellyAboutEmotions01",
				"SkellyAboutTraining02",
			},
		},

		GiftTextLinePriorities =
		{
			"SkellyGift01",
			"SkellyGift02",
			"SkellyGift03",
			"SkellyGift04",
			"SkellyGift05",
			"SkellyGift06",
			"SkellyGiftTemp", -- placeholder
			"SkellyBathHouseDecline01",
			"SkellyFishingDecline01",
		},
	},

	-- Arachne
	NPC_Arachne_01 =
	{
		InteractTextLinePriorities =
		{
			"ArachneFirstMeeting",
			"ArachneAboutOutfits01",

			"HecateWithArachne01_FollowUp",

			-- immediate-contextual
			{
				"ArachneAboutRelationship02",
			},
			{
				"ArachneAboutFrogFamiliar01",
			},
			{
				"ArachneLowHealth01",
			},
			{
				"ArachneAboutGods02",
				"ArachneAboutGods03",
				"ArachneAboutGods04",
				"ArachneAboutGods05",
			},
			{
				"ArachneAboutCurse01",
				"ArachneAboutCurse02",
				"ArachneAboutCurse03",
				"ArachneAboutCurse04",
				"ArachneAboutCurse05",
				"ArachneAboutCurse06",
			},
			{
				"ArachneAboutHecate01",
			},
			{
				"ArachneAboutKeepsake01",
				"ArachneAboutCatFamiliar01",
			},
			-- priority story
			{
				"ArachneAboutSilk01",
				"ArachneAboutCocoons01",
				"ArachneAboutCocoons02",
				"ArachneAboutSelf01",
				"ArachneAboutSelf02",
				"ArachneAboutGods01",
				"ArachneAboutPride01",
			},
			-- lower priority contextual
			{
				"ArachneAboutArtemis01",
				"ArachneAboutHecate02",
				"ArachneAboutCharon01",
				"ArachneAboutSurface01",
				"ArachneAboutOceanus01",
				"ArachneAboutRelationship01",
				"ArachneAboutGods06",
				"ArachneAboutGods06_B",
			},
			-- lower priority story
			{
				"ArachneAboutLair01",
				"ArachneAboutWeaving01",
				"ArachneAboutWeaving02",
				"ArachneAboutFood01",
				"ArachneAboutSilk02",
				"ArachneAboutPay01",
			},
			{
				"ArachneAboutSpiders01",
				"ArachneAboutSpiders02",
				"ArachneAboutSpiders03",
			},
			-- evergreen
			{
				"ArachneAboutMines01",
				"ArachneAboutGuards01",
				"ArachneAboutRadiators01",
				"ArachneAboutBrawlers01",
				"ArachneAboutMages01",
				"ArachneAboutSiegeVines01",
				"ArachneAboutFogEmitters01",
				"ArachneAboutTreants01",
				"ArachneAboutTrees01",
			}
		},

		GiftTextLinePriorities =
		{
			"ArachneGift01",
			"ArachneGift02",
			"ArachneGift03",
			"ArachneGift04",
			"ArachneGift05",
			"ArachneGift06",
			"ArachneGiftTemp", -- placeholder
		},
	},

	NPC_Arachne_Home_01 =
	{
		InteractTextLinePriorities =
		{
			-- home events
			"ArachneHubFirstMeeting01",
			"ArachneWithHecateInHub01",
			"ArachneWithHecateInHub02",
		},

		GiftTextLinePriorities =
		{
			"ArachneGift01",
			"ArachneGift02",
			"ArachneGift03",
			"ArachneGift04",
			"ArachneGift05",
			"ArachneGift06",
			"ArachneGiftTemp", -- placeholder
		},
	},

	-- Artemis; _Field version below
	NPC_Artemis_01 =
	{
		InteractTextLinePriorities =
		{
			-- home events
			"ArtemisHubFirstMeeting01",
			"ArtemisHubAboutChronosBoss01",
		},

		GiftTextLinePriorities =
		{
			"ArtemisGift01",
			"ArtemisGift02",
			"ArtemisGift03",
			"ArtemisGift04",
			"ArtemisGift05",
			"ArtemisGift06",
			"ArtemisGiftTemp",
		},
	},

	-- Artemis
	NPC_Artemis_Field_01 =
	{
		InheritFrom = { "NPC_Artemis_01" },

		InteractTextLinePriorities =
		{
			-- field events
			"ArtemisFirstMeeting",

			-- mission critical
			"ArtemisAboutApollo01",
			"ArtemisAboutMission01",

			-- immediate-contextual
			"ArtemisAboutEphyra01",
			"ArtemisAboutEphyra01_B",

			"ArtemisAboutChronosBossW01",
			"ArtemisAboutChronosBossL01",
			"ArtemisAboutFates01",
			"ArtemisAboutHermes01",

			"ArtemisAboutSurfacePenalty01",
			"ArtemisAboutPrometheus01",

			"ArtemisAboutHecate01",
			"ArtemisAboutOceanus01",

			"ArtemisAboutPolyphemus01",
			"ArtemisAboutEris01",

			"ArtemisAboutSurface01",

			"ArtemisAboutArtemisAspect01",

			-- priority story
			"ArtemisAboutSelene01",
			"ArtemisAboutSelene01_B",
			"ArtemisAboutChronos01",
			"ArtemisAboutMoros01",
			"ArtemisAboutSilverSisters01",

			-- lower priority contextual
			"ArtemisAboutKeepsake01",
			"ArtemisAboutNemesis01",
			"ArtemisAboutRetrying01",
			"ArtemisAboutErebus01",
			"ArtemisAboutDagger01",
			"ArtemisLowHealth01",
			"ArtemisAboutFamily02",
			"ArtemisAboutMoon01",
			"ArtemisAboutTimePassing01",

			-- lower priority story
			"ArtemisAboutFamily01",

			-- evergreen
			"ArtemisSendOff01",
			"ArtemisAboutProgress01",
		},
	},

	-- Hades
	NPC_Hades_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"HadesFirstMeeting_C",
			"HadesFirstMeeting_B",
			"HadesFirstMeeting",

			-- immediate-contextual
			{
				"HadesAboutChronosBossW01",
				"HadesAboutChronosBossW01_B",
			},
			{
				"HadesAboutChronosNightmare01",
			},
			-- priority story
			"HadesMeeting02",
			"HadesMeeting03",
			{
				"HadesAboutCerberus01",
			},
			-- health
			{
			},
			-- priority contextual
			{
				"HadesAboutPersephoneAspect01",
			},
			{
				"HadesAboutZagreus01",
				"HadesAboutBrothers01",
			},
			-- about other gods
			{
			},
			-- lower-priority contextual
			{
				"HadesAboutFamily01",
			},
			{
				"HadesAboutCharon01",
			},
			{
				"HadesAboutSurface01",
				"HadesAboutPrometheus01",
				"HadesAboutAutomatons01",
				"HadesAboutChronosAllies01",
			},
			{
				"HadesAboutShrine01",
			},
			-- lower-priority story
			{
				"HadesAboutPain01",
				"HadesAboutHecate01",
				"HadesAboutPersephone01",
				"HadesAboutMelinoe01",
				"HadesAboutNyx01",
			},
			{
				"HadesAboutSisyphus01",
				"HadesAboutBouldy01",
			},
			-- evergreen
			{
				"HadesAboutHouse01",
			},
		},

		GiftTextLinePriorities =
		{
			"HadesGiftDecline01",
			"HadesGift01",
			"HadesGiftTemp",
		},
	},

	-- Selene
	SpellDrop =
	{
		InteractTextLinePriorities =
		{
			"SeleneFirstPickUp",
			-- immediate-contextual
			{
				"SeleneLootBought01",
				"SeleneLootBought02",
			},
			-- mission critical
			{
				"SeleneAboutPackageBounty02",
			},
			{
				"SelenePackageBountyIntro01",
			},
			{
				"SeleneAboutObscurity01",
				"SeleneAboutSurfaceCurse01",
				"SeleneAboutSurfaceCurse02",
				"SeleneAboutChronosBossL01",
			},
			{
				"SeleneAboutHermesMission01",
				"SeleneAboutHermesMission02",
			},
			{
				"SeleneAboutSurfaceWar01",
				"SeleneAboutSurfaceWards01",
			},
			{
				"SeleneAboutSurface01",
				"SeleneAboutSurface01_B",
				"SeleneAboutOceanus01",
				"SeleneAboutFields01",
				"SeleneAboutThessaly01",
			},
			{
				"SeleneRunCleared02",
				"SeleneRunCleared03",
			},
			{
				"SeleneRunCleared01",
			},
			{
				"SeleneAboutFates01",
			},

			-- priority story
			{
				"SeleneAboutMission01",
				"SeleneAboutChronos01",
				"SeleneAboutTask01",
				"SeleneAboutOlympus01",
				"SeleneBackstory01",
				-- "SeleneAboutSilverSisters01",
			},
			{
				"SeleneAboutErebus01",
				"SeleneAboutPersephone01",
			},
			-- health
			{
				"SeleneLowHealth01",
				"SeleneLowHealth02",
				"SeleneLowHealth03",
			},
			-- priority contextual
			{
				"SeleneAboutSuit01",
				"SeleneAboutLob01",
			},
			{
				"SeleneAboutAxe01",
				"SeleneAboutHecate02",
				"SeleneAboutKeepsake01",
				"SeleneAboutTalentDrop01",
			},
			{
				"SeleneAboutSwitchToSurface01",
			},
			{
				"SeleneRunStartIntro01",
			},
			{
				"SeleneRunStart01",
				"SeleneRunStart02",
				"SeleneRunStart03",
				"SeleneRunStart04",
			},
			{
				"SeleneAboutPolyphemus01",
				"SeleneAboutEris01",
				"SeleneAboutPrometheus01",
				"SeleneAboutHeracles01",
				"SeleneAboutDemeter01",
			},
			{
				"SeleneAboutHestia01",
				"SeleneAboutShrine01",
			},
			-- about other gods
			{
				"SeleneAboutZeus01",
				"SeleneAboutHera01",
				"SeleneAboutPoseidon01",
				"SeleneAboutApollo01",
				"SeleneAboutAphrodite01",
				"SeleneAboutHephaestus01",
				"SeleneAboutHermes01",
				"SeleneAboutChaos01",
			},
			-- lower-priority contextual
			{
				"SeleneAboutNyx01",
				"SeleneAboutNemesis01",
				"SeleneAboutSurface02",
				"SeleneAboutSurface03",
				"SeleneAboutSteeds02",
				"SeleneAboutSteeds03",
				"SeleneAboutEosAspect01",
				"SeleneAboutBountyBoard01",
			},
			{
				"SeleneAboutEos01",
				"SeleneAboutDagger01",
				"SeleneAboutTorch01",
			},
			{
				"SeleneAboutMedea01",
				"SeleneAboutHexes02",
				"SeleneAboutNewMoon01",
			},
			-- lower-priority story
			{
				"SeleneAboutNyx02",
				"SeleneAboutLunarCycle02",
				"SelenePostGift01",
				"SeleneAboutOlympus02",
				"SeleneAboutHecate01",
				"SeleneAboutMagick01",
				"SeleneAboutHexes01",
			},
			-- evergreen
			{
				"SeleneAboutLunarCycle01",
				"SeleneAboutSteeds01",
				"SeleneAboutHecate03",
				"SeleneAboutMagick02",
				"SeleneAboutOdysseus01",
				"SeleneAboutNyx03",
				"SeleneAboutPhases01",
				"SeleneAboutDarkness01",
				"SeleneAboutSpeech01",
			},
			{
				"SeleneAboutHypnos01",
				"SeleneAboutHelios01",
			}
		},

		GiftTextLinePriorities =
		{
			"SeleneGift01",
			"SeleneGift02",
			"SeleneGift03",
			"SeleneGift04",
			"SeleneGift05", -- placeholder
		},
	},

	NPC_Selene_01 =
	{
		InteractTextLinePriorities =
		{
			"SeleneWithHecate01",
			"SeleneHome01",
		},
	},

	-- Zeus
	ZeusUpgrade =
	{
		InteractTextLinePriorities =
		{
			"ZeusFirstPickUp",
			-- immediate-contextual
			{
				"ZeusAboutSurfaceNoCure01",
				"ZeusAboutSurfaceNoCure02",
				"ZeusAboutSurface01",
				"ZeusPackageBountyIntro01",
				"ZeusPackageBountyIntro02",
			},
			{
				"ZeusAboutOlympus02",
				"ZeusAboutOlympus03",
				"ZeusAboutOceanus01",
				"ZeusAboutOceanus02",
				"ZeusAboutThessaly01",
			},
			{
				"ZeusAboutSurface02",
			},
			{
				"ZeusUnderworldRunCleared01",
				"ZeusUnderworldRunCleared02",
				"ZeusSurfaceRunCleared01",
			},
			-- priority story
			{
				"ZeusAboutChronos05",
				"ZeusAboutFates01",
				"ZeusAboutSurface03",
			},
			{
				"ZeusAboutDevotionTests01",
			},
			-- legendary
			{
				"ZeusLegendaryPickUp01",
				"ZeusLegendaryPickUp02",
			},
			-- health
			{
				"ZeusLowHealth01",
				"ZeusLowHealth02",
				"ZeusLowHealth03",
				"ZeusLowHealth04",
			},
			-- high-priority contextual
			{
				"ZeusAboutKeepsake01",
				"ZeusAboutPolyphemus01",
			},
			-- priority contextual
			{
				"ZeusSurfaceRunStart01",
				"ZeusSurfaceRunStart02",
				"ZeusAboutPackageBounty01",
			},
			{
				"ZeusRunStart01",
				"ZeusRunStart02",
				"ZeusRunStart03",
				"ZeusRunStart04",
				"ZeusPostGift01",
				"ZeusAboutMortals02",
				"ZeusAboutShrine01",
			},
			{
				"ZeusAboutRouteChoice01",
			},
			{
				"ZeusAboutPrometheus01",
			},
			{
				"ZeusAboutEris01",
			},
			-- about other gods
			{
				"ZeusAboutHera01",
			},
			{
				"ZeusAboutApollo01",
				"ZeusAboutApollo02",
				"ZeusAboutPoseidon01",
			},
			{
				"ZeusAboutAphrodite01",
				"ZeusAboutHestia01",
				"ZeusAboutDemeter01",
				"ZeusAboutHephaestus01",
				"ZeusAboutHera02",
				"ZeusAboutHera03",
			},
			{
				"ZeusAboutSelene01",
				"ZeusAboutHermes01",
			},
			{
				"ZeusAboutSurfaceThreat01",
			},
			-- lower-priority story
			{
				"ZeusAboutChronos01",
				"ZeusAboutChronos02",
				"ZeusAboutChronos03",
				"ZeusAboutChronos04",
				"ZeusAboutHades01",
				"ZeusAboutHecate01",
				"ZeusAboutHecate02",
				"ZeusAboutPolyphemus02",
				"ZeusAboutSurface04",
				"ZeusAboutSurface05",
			},
			-- lower-priority contextual
			{
				"ZeusAboutErebus01",
				"ZeusAboutMortals01",
				"ZeusPostGift02",
				"ZeusAboutWeapons01",
				"ZeusAboutChronosClockwork01",
				"ZeusAboutStorms01",
				"ZeusAboutArtemis01",
				"ZeusAboutMelinoe01",
				"ZeusAboutOlympians01",
				"ZeusAboutTartarus01",
				"ZeusAboutPrometheus02",
			},
			-- evergreen
			{
				"ZeusAboutOlympus01",
				"ZeusAboutAthena01",
				"ZeusAboutZagreus01",
				"ZeusAboutAres01",
				"ZeusAboutDionysus01",
			},
		},

		BoughtTextLinePriorities =
		{
			"ZeusBlindBox01",
			"ZeusBlindBox02",
		},

		GiftTextLinePriorities =
		{
			"ZeusGift01",
			"ZeusGift02",
			"ZeusGift03",
			"ZeusGift04",
			"ZeusGiftTemp", -- placeholder
		},
	},

	-- Poseidon
	PoseidonUpgrade =
	{
		InteractTextLinePriorities =
		{
			"PoseidonFirstPickUp",
			-- immediate-contextual
			{
				"PoseidonAboutPackageBounty01",
				"PoseidonAboutPackageBounty02",
				"PoseidonAboutOlympus01",
			},
			{
				"PoseidonLegacyBoonIntro01",
				"PoseidonDevotionIntro01",
			},
			{
				"PoseidonAboutSurface01",
				"PoseidonAboutOceanus01",
				"PoseidonAboutFields01",
				"PoseidonAboutThessaly01",
				"PoseidonAboutThessaly02",
			},
			{
				"PoseidonAboutFindingHades01_B",
			},
			{
				"PoseidonUnderworldRunCleared01",
				"PoseidonUnderworldRunCleared02",
			},
			{
				"PoseidonAboutKeepsake02",
			},
			{
				"PoseidonAboutSurface04",
			},
			-- priority story
			{
				"PoseidonAboutChronos01",
				"PoseidonAboutFates01",
			},
			{
				"PoseidonAboutHades01",
				"PoseidonAboutHades03",
			},
			{
				"PoseidonAboutFamily01",
			},
			{
				"PoseidonAboutFishing04",
			},
			-- legendary
			{
				"PoseidonLegendaryPickUp01",
				"PoseidonLegendaryPickUp02",
			},
			-- health
			{
				"PoseidonLowHealth01",
				"PoseidonLowHealth02",
				"PoseidonLowHealth03",
				"PoseidonLowHealth04",
			},
			-- priority contextual
			{
				"PoseidonAboutFishing01",
				"PoseidonAboutInFighting01",
				"PoseidonAboutFindingHades01",
			},
			{
				"PoseidonRunStart01",
				"PoseidonRunStart02",
				"PoseidonRunStart03",
				"PoseidonRunStart04",
				"PoseidonAboutPolyphemus03",
			},
			-- lower-priority contextual
			{
				"PoseidonSurfaceRunStartPostUnderworldL01",
				"PoseidonSurfaceRunStartPostUnderworldW01",
				"PoseidonUnderworldRunStartPostSurfaceL01",
				"PoseidonAboutThessaly03",
				"PoseidonAboutOlympus02",
			},
			{
				"PoseidonAboutArtemis01",
				"PoseidonAboutAthena01",
			},
			{
				"PoseidonAboutPolyphemus01",
				"PoseidonAboutScylla01",
				"PoseidonAboutScylla02",
				"PoseidonAboutEris01",
				"PoseidonAboutPrometheus01",
				"PoseidonAboutNemesis01",
				"PoseidonAboutHeracles01",
				"PoseidonAboutIcarus01",

				"PoseidonAboutOceanus02",
				"PoseidonAboutOceanus03",
				"PoseidonAboutSurface02",
				"PoseidonAboutSurface03",
				"PoseidonAboutOlympus03",
				"PoseidonAboutThessaly04",

				"PoseidonAboutAxe01",
				"PoseidonAboutSuit01",

				"PoseidonAboutAutomatons01",
				"PoseidonAboutAutomatons02",
				"PoseidonAboutAutomatons03",

				"PoseidonAboutLittleHades01",

				"PoseidonAboutFrogFamiliar01",
				"PoseidonAboutCatFamiliar01",
				"PoseidonAboutCatFamiliar02",

				"PoseidonAboutFishing02",
				"PoseidonAboutFishing03",

				"PoseidonAboutKeepsake01",

				"PoseidonAboutRain01",
			},
			-- about other gods
			{
				"PoseidonAboutZeus01",
				"PoseidonAboutHera01",
				"PoseidonAboutApollo01",
				"PoseidonAboutAphrodite01",
				"PoseidonAboutHestia01",
				"PoseidonAboutDemeter01",
				"PoseidonAboutHermes01",
				"PoseidonAboutHephaestus01",
				"PoseidonAboutHephaestus02",
				"PoseidonAboutArtemis02",
				"PoseidonAboutDionysus01",
			},
			"PoseidonAboutSelene01",
			-- lower-priority story
			{
				"PoseidonAboutChronos02",
				"PoseidonAboutHades02",
				"PoseidonAboutChronos04",
				"PoseidonAboutChronos05",
				"PoseidonAboutChronos06",
				"PoseidonAboutChronos03",
			},
			-- evergreen
			{
				"PoseidonAboutZagreus01",
				"PoseidonAboutMelinoe01",
				"PoseidonAboutMelinoe02",
				"PoseidonAboutPolyphemus02",
				"PoseidonAboutDams01",
				"PoseidonAboutLuxuries01",
				"PoseidonAboutWater01",
				"PoseidonAboutFamily02",

				"PoseidonAboutSwimming01",
				"PoseidonAboutStalemate01",
				"PoseidonAboutStalemate02",
				"PoseidonAboutStalemate03",
				"PoseidonAboutVengeance01",
				"PoseidonAboutTrading01",
				"PoseidonAboutStorms01",
				"PoseidonAboutPressure01",

				"PoseidonAboutChoices01",
				"PoseidonAboutDisasters01",
			},
		},

		GiftTextLinePriorities =
		{
			"PoseidonGift01",
			"PoseidonGift02",
			"PoseidonGift03",
			"PoseidonGift04",
			"PoseidonGiftTemp", -- placeholder
		},

		BoughtTextLinePriorities =
		{
			"PoseidonBlindBox01",
			"PoseidonBlindBox02",
		},

		RejectionTextLinePriorities =
		{
			-- "ApolloLootBought01",
		},
	},

	-- Apollo
	ApolloUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"ApolloFirstPickUp",
			-- health & immediate-contextual
			{
				"ApolloAboutSurface01",
			},

			-- priority story
			{
				"ApolloAboutTitanWar01",
				"ApolloAboutChronos01",
				"ApolloAboutMelinoe01",
			},
			-- health & immediate-contextual
			{
				"ApolloLowHealth01",
				"ApolloLowHealth02",
			},
			-- legendary
			{
				"ApolloLegendaryPickUp01",
				"ApolloLegendaryPickUp02",
			},
			-- priority contextual
			{
				"ApolloAboutKeepsake01",
			},
			{
				"ApolloRunStart01",
				"ApolloRunStart02",
			},
			-- lower-priority contextual
			{
				"ApolloAboutArtemis02",
				"ApolloAboutOceanus01",
				"ApolloAboutEphyra01",
				"ApolloAboutThessaly01",
				"ApolloAboutRouteChoice01",
				"ApolloUnderworldRunCleared02",
				"ApolloAboutPolyphemus01",
				"ApolloAboutPrometheus01",
			},
			{
				"ApolloUnderworldRunCleared01",
				"ApolloAboutSurface02",
				"ApolloAboutSilverSisters01",
				"ApolloPostGift02",
				"ApolloAboutTorch01",
				"ApolloAboutEris01",
			},
			{
				"ApolloPostGift03",
			},
			-- about other gods
			{
				"ApolloAboutDemeter01",
			},
			{
				"ApolloAboutZeus01",
				"ApolloAboutPoseidon01",
				"ApolloAboutHera01",
				"ApolloAboutHestia01",
				"ApolloAboutAphrodite01",
				"ApolloAboutHermes01",
			},
			-- lower-priority story
			{
				"ApolloAboutMortals01",
				"ApolloAboutChronos02",
				"ApolloAboutProphecy01",
				"ApolloAboutHades01",
				"ApolloAboutHardTimes01",
				"ApolloAboutFamily01",
				"ApolloAboutFamily02",
				"ApolloAboutHecate01",
			},
			-- evergreen
			{
				"ApolloAboutPassions01",
				"ApolloPostGift01",
				"ApolloAboutChronos03",
				"ApolloAboutWitchcraft01",
				"ApolloAboutProphecy02",
				"ApolloAboutOlympus01",
				"ApolloAboutTitanWar02",
				"ApolloAboutErebus01",
				"ApolloAboutCrossroads01",
				"ApolloAboutAthena01",
				"ApolloAboutLight01",
				"ApolloAboutLight02",
				"ApolloAboutBows01",
			},
			{
				"ApolloAboutTalent01",
				"ApolloAboutFoes01",
				"ApolloAboutLight03",
				"ApolloAboutLight04",
			},
		},

		GiftTextLinePriorities =
		{
			"ApolloGift01",
			"ApolloGift02",
			"ApolloGift03",
			"ApolloGift04",
			"ApolloGiftTemp", -- placeholder
		},
	},

	-- Demeter
	DemeterUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"DemeterFirstPickUp",
			{
				"DemeterAboutMelinoe01",
				"DemeterAboutSurface01",
			},
			{
				"DemeterAboutSurface02",
			},
			-- health & immediate-contextual
			{
				"DemeterAboutPackageBounty01",
			},
			{
				"DemeterLowHealth01",
				"DemeterLowHealth02",
				"DemeterLowHealth03",
				"DemeterLowHealth04",
			},
			-- priority story
			{
				"DemeterAboutMelinoe02",
			},
			{
				"DemeterAboutMelinoe03",
				"DemeterAboutChronos02",
			},
			{
				"DemeterAboutHades02"
			},
			-- higher priority contextual
			{
				"DemeterUnderworldRunCleared01",
				"DemeterAboutShrine01",
			},
			{
				"DemeterAboutOceanus01",
				"DemeterAboutThessaly01",
				"DemeterAboutThessaly02",
				"DemeterAboutEphyra01",
				"DemeterAboutEphyra02",
				"DemeterAboutPrometheus01",
			},
			{
				"DemeterAboutFields01",
			},
			-- legendary
			{
				"DemeterLegendaryPickUp01",
				"DemeterLegendaryPickUp02",
			},
			-- priority contextual
			{
				"DemeterAboutKeepsake01",
			},
			{
				"DemeterAboutRain01",
				"DemeterRunStart01",
				"DemeterRunStart02",
				"DemeterRunStart03",
				"DemeterRunStart04",
			},
			-- about other gods
			{
				"DemeterAboutZeus01",
				"DemeterAboutHera01",
			},
			{
				"DemeterAboutPoseidon01",
				"DemeterAboutPoseidon02",
				"DemeterAboutApollo01",
				"DemeterAboutHestia01",
			},
			{
				"DemeterAboutHephaestus01",
				"DemeterAboutAphrodite01",
			},
			{
				"DemeterAboutSelene01",
				"DemeterAboutHermes01",	
			},
			-- lower-priority story
			{
				"DemeterAboutPersephone01",
			},
			{
				"DemeterAboutBlessings01",
				"DemeterAboutZagreus01",
				"DemeterAboutHecate01",
				"DemeterAboutChronos01",
				"DemeterAboutHades01",
			},
			-- lower-priority contextual
			{
				"DemeterAboutFarmBoy01",
				"DemeterAboutCirce01",
				"DemeterAboutEarth01",
				"DemeterAboutChronos03",
				"DemeterAboutPom01",
				"DemeterAboutMoon01",
				"DemeterAboutArtemis01",
				"DemeterAboutResources01",
				"DemeterAboutResources02",
				"DemeterAboutResources03",
			},
			-- evergreen
			{
				"DemeterAboutHecate02",
				"DemeterAboutSisters01",
			},
		},

		BoughtTextLinePriorities =
		{
			"DemeterBlindBox01",
			"DemeterBlindBox02",
		},

		GiftTextLinePriorities =
		{
			"DemeterGift01",
			"DemeterGift02",
			"DemeterGift03",
			"DemeterGift04",
			"DemeterGiftTemp", -- placeholder
		},
	},

	-- Hephaestus
	HephaestusUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"HephaestusFirstPickUp",
			"HephaestusAboutMelinoe01",
			-- health & immediate-contextual
			{
				"HephaestusAboutAutomatons02",
			},
			{
				"HephaestusAboutSurfaceIntro01",
			},
			{
				"HephaestusAboutSurface01",
				"HephaestusUnderworldRunCleared02",
			},
			{
				"HephaestusAboutOceanus01",
				"HephaestusAboutFields01",
				"HephaestusAboutThessaly01",
				"HephaestusUnderworldRunCleared01",
				"HephaestusAboutSurfaceIntro02",
			},
			{
				"HephaestusAboutAspects01",
			},
			{
				"HephaestusAboutStaff01",
				"HephaestusAboutDagger01",
				"HephaestusAboutTorch01",
				"HephaestusAboutAxe01",
				"HephaestusAboutLob01",
				"HephaestusAboutSuit01",
			},
			-- health
			{
				"HephaestusLowHealth01",
				"HephaestusLowHealth02",
				"HephaestusLowHealth03",
				"HephaestusLowHealth04",
			},
			-- priority story
			{
				"HephaestusAboutChronos01",
			},
			{
				"HephaestusAboutWeapons01",
				"HephaestusAboutWeapons02",
			},
			{
				"HephaestusAboutHecate01",
				"HephaestusAboutAthena01",
				"HephaestusAboutParents01",
			},
			-- legendary
			{
				"HephaestusLegendaryPickUp01",
				"HephaestusLegendaryPickUp02",
			},
			-- priority contextual
			{
				"HephaestusAboutKeepsake01",
			},
			{
				"HephaestusRunStartSurface01",
			},
			{
				"HephaestusRunStart01",
				"HephaestusRunStart02",
				"HephaestusRunStart03",
				"HephaestusRunStart04",
			},
			{
				"HephaestusAboutMortals02",
				"HephaestusAboutOlympus01",
				"HephaestusAboutSurfaceThreat01",
				"HephaestusAboutPolyphemus01",
				"HephaestusAboutErisBossW01",
				"HephaestusAboutPrometheus01",
				"HephaestusAboutTalos01",
			},
			-- about other gods
			{
				"HephaestusAboutAphrodite01",
				"HephaestusAboutHera01",
			},
			{
				"HephaestusAboutDaedalus01",
				"HephaestusAboutDaedalus02",
			},
			{
				"HephaestusAboutZeus01",
				"HephaestusAboutPoseidon01",
				"HephaestusAboutApollo01",
				"HephaestusAboutHestia01",
				"HephaestusAboutDemeter01",
			},
			{
				"HephaestusAboutSelene01",
				"HephaestusAboutHermes01",
			},
			-- lower-priority story
			{
				"HephaestusAboutForge01",
				"HephaestusAboutFates01",
				"HephaestusAboutHeraRelationship01",
				"HephaestusAboutChronos02",
				"HephaestusAboutMortals01",
				"HephaestusAboutPractice01",
				"HephaestusAboutAres01",
				"HephaestusAboutDionysus01",
			},
			-- lower-priority contextual
			{
				"HephaestusAboutAphroditeRelationship01",
				"HephaestusAboutAphroditeRelationship02",
				"HephaestusAboutAphroditeRelationship03",
				"HephaestusAboutSurface02",
				"HephaestusAboutHouse01",
				"HephaestusAboutBackstory01",
				"HephaestusAboutVolcanoes01",
				"HephaestusAboutTartarus01",
				"HephaestusAboutIcarus01",
				"HephaestusAboutAxe02",
			},
			-- evergreen
			{
				"HephaestusAboutLegs01",
				"HephaestusAboutHades01",
				"HephaestusAboutFamily01",
				"HephaestusAboutFamily02",
				"HephaestusAboutOlympians01",
				"HephaestusAboutZagreus01",
				"HephaestusAboutAutomatons01",
				"HephaestusAboutSilver01",
				"HephaestusAboutPandora01",
			},
		},

		BoughtTextLinePriorities =
		{
			"HephaestusBlindBox01",
			"HephaestusBlindBox02",
		},

		GiftTextLinePriorities =
		{
			"HephaestusGift01",
			"HephaestusGift02",
			"HephaestusGift03",
			"HephaestusGift04",
			"HephaestusGiftTemp", -- placeholder
		},
	},

	-- Aphrodite
	AphroditeUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"AphroditeFirstPickUp",
			-- health & immediate-contextual
			{
				"AphroditeAboutSurface01",
				"AphroditeAboutOceanus01",
				"AphroditeAboutThessaly01",
			},
			{
				"AphroditeAboutSurface03",
				"AphroditeAboutSurface02",
				"AphroditeAboutApples01",
				"AphroditeAboutNectar01",
			},
			{
				"AphroditeUnderworldRunCleared01",
				"AphroditeUnderworldRunCleared02",
				"AphroditeSurfaceRunCleared01",
			},
			{
				"AphroditeAboutFamiliars01",
				"AphroditeAboutBathHouse01",
				"AphroditeAboutBathHouse02",
			},
			{
				"AphroditeLowHealth01",
				"AphroditeLowHealth02",
				"AphroditeLowHealth03",
				"AphroditeLowHealth04",
			},
			-- priority story
			{
				"AphroditeAboutFamily01",
				"AphroditeAboutHecate01",
				"AphroditeAboutFates01",
				"AphroditeAboutSurfaceThreat01",
				"AphroditeAboutOlympus01",
			},
			-- legendary
			{
				"AphroditeLegendaryPickUp01",
				"AphroditeLegendaryPickUp02",
			},
			-- priority contextual
			{
				"AphroditeAboutMoros01",
				"AphroditeAboutSurface04",
				"AphroditeAboutSirens01",
			},
			{
				"AphroditeAboutKeepsake01",
			},
			{
				"AphroditeAboutNarcissus01",
				"AphroditeAboutEris01",
				"AphroditeAboutHeracles01",
			},
			{
				"AphroditeRunStart01",
				"AphroditeRunStart02",
				"AphroditeRunStart03",
				"AphroditeRunStart04",
			},
			-- about other gods
			{
				"AphroditeAboutSelene01",
			},
			{
				"AphroditeAboutZeus01",
				"AphroditeAboutHera01",
				"AphroditeAboutPoseidon01",
				"AphroditeAboutApollo01",
				"AphroditeAboutDemeter01",
				"AphroditeAboutHestia01",
				"AphroditeAboutHephaestus01",
				"AphroditeAboutHephaestus02",
				"AphroditeAboutHermes01",
			},
			-- lower-priority story
			{
				"AphroditeAboutChronos01",
				"AphroditeAboutChronos02",
				"AphroditeAboutOlympus02",
			},
			{
				"AphroditeAboutZagreus01",
				"AphroditeAboutWar01",
			},
			-- lower-priority contextual
			{
				"AphroditeAboutEosAspect01",
				"AphroditeAboutHephaestusRelationship01",
				"AphroditeAboutMelinoe01",
				"AphroditeAboutArtemis01",
				"AphroditeAboutZagreus02",
				"AphroditeAboutLove02",
				"AphroditeAboutArachne01",
				"AphroditeAboutNectar02",
				"AphroditeAboutUnderworld01",
				"AphroditeAboutNarcissus02",
				"AphroditeAboutBirdies01",
				"AphroditeAboutOutfits01",
			},
			-- evergreen
			{
				"AphroditeAboutPersephone01",
				"AphroditeAboutPassions01",
				"AphroditeAboutLove01",
				"AphroditeAboutLove03",
				"AphroditeAboutHades01",
				"AphroditeAboutOlympus03",
				"AphroditeAboutAthena01",
				"AphroditeAboutAres01",
				"AphroditeAboutDionysus01",
				"AphroditeAboutBoons01",
			},
		},

		GiftTextLinePriorities =
		{
			"AphroditeGift01",
			"AphroditeGift02",
			"AphroditeGift03",
			"AphroditeGift04",
			"AphroditeGiftTemp", -- placeholder
		},
	},

	-- Hestia
	HestiaUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"HestiaFirstPickUp",
			-- immediate-contextual
			{
				"HestiaAboutPackageBounty01",
				"HestiaAboutPackageBounty02", -- not properly integrated yet
			},
			{
				"HestiaAboutSurface01",
				"HestiaAboutOceanus01",
			},
			{
				"HestiaAboutSurfacePenalty01",
			},
			{
				"HestiaUnderworldRunCleared01",
				"HestiaUnderworldRunCleared02",
				"HestiaAboutEris02",
			},
			-- priority story
			{
				"HestiaAboutChronosPlan01",
				"HestiaAboutHades01",
				"HestiaAboutHecate01",
				"HestiaAboutChronos01",
				"HestiaAboutArtemis01",
				"HestiaAboutRouteChoice01",
			},
			-- health
			{
				"HestiaLowHealth01",
				"HestiaLowHealth02",
				"HestiaLowHealth03",
				"HestiaLowHealth04",
			},
			-- legendary
			{
				"HestiaLegendaryPickUp01",
				"HestiaLegendaryPickUp02",
			},
			-- priority contextual
			{
				"HestiaAboutKeepsake01",
			},
			{
				"HestiaAboutEris01",
				"HestiaAboutTorch01",
				"HestiaAboutPrometheus01",
				"HestiaAboutPrometheus02",
			},
			{
				"HestiaRunStart01",
				"HestiaRunStart02",
				"HestiaRunStart03",
				"HestiaRunStartUnderworld01",
				"HestiaAboutEphyra01",
				"HestiaRunStartSurface01",
			},
			{
				"HestiaAboutSurface02",
				"HestiaAboutSurface03",
			},
			{
				"HestiaAboutPolyphemus01",
				"HestiaAboutHeracles01",
				"HestiaAboutFields01",
			},
			{
				"HestiaAboutChronosPlan02",
				"HestiaAboutShrine01",
			},
			-- about other gods
			{
				"HestiaAboutDemeter02",
			},
			{
				"HestiaAboutHera01",
				"HestiaAboutHera02",
				"HestiaAboutZeus01",
				"HestiaAboutPoseidon01",
				"HestiaAboutApollo01",
				"HestiaAboutAphrodite01",
				"HestiaAboutDemeter01",
				"HestiaAboutHephaestus01",
			},
			{
				"HestiaAboutSelene01",
				"HestiaAboutHermes01",
			},
			{
				"HestiaAboutChaos01",
				"HestiaAboutEosAspect01",
			},
			-- additional contextual
			{
				"HestiaAboutCinder01",
				"HestiaAboutCinder02",
			},
			-- lower-priority story
			{
				"HestiaAboutWitchcraft01",
				"HestiaAboutParents01",
				"HestiaAboutOlympians01",
				"HestiaAboutSisters01",
				"HestiaAboutMortals01",
				"HestiaAboutMortals02",
				"HestiaBackstory01",
				"HestiaBackstory02",
				"HestiaAboutDarkness01",
				"HestiaAboutOlympians02",
				"HestiaAboutSoot01",
				"HestiaAboutHades02",
				"HestiaAboutAthena01",
			},
			-- lower-priority contextual
			{
				"HestiaPostGift01",
				"HestiaPostGift02",
				"HestiaPostGift03",
			},
			-- evergreen
			{
				"HestiaAboutTitans01",
				"HestiaAboutMyths01",
				"HestiaAboutFlame01",
				"HestiaAboutFlame02",
				"HestiaAboutPhlegethon01",
			},
		},

		BoughtTextLinePriorities =
		{
			"HestiaBlindBox01",
		},

		GiftTextLinePriorities =
		{
			"HestiaGift01",
			"HestiaGift02",
			"HestiaGift03",
			"HestiaGift04",
			"HestiaGiftTemp", -- placeholder
		},
	},

	-- Bosses / EnemyData
	-- Hecate Boss
	Hecate =
	{
		BossIntroTextLinePriorities =
		{
			"HecateBossFirstAppearanceAlt",
			"HecateBossFirstAppearance",
			-- health & immediate contextual
			{
				"HecateBossAboutPackagedBounties01",
				"HecateBossAboutPackagedBounties01_B",
				"HecateBossAboutPackagedBounties02",
			},
			{
				"HecateBossAboutHermes01",
				"HecateBossAboutHermes02",
			},
			{
				"HecateBossAboutChronos03",
			},
			{
				"HecateBossAboutFamiliarSystem01",
			},
			{
				"HecateBossAboutDagger01",
				"HecateBossAboutCharonAspect01",
				"HecateBossAboutWeaponAspects01",
			},
			{
				"HecateBossLowHealth02",
				"HecateBossAboutSurface01",
			},
			{
				"HecateBossRepeatedWins02",
				"HecateBossAboutChronos01",
			},
			-- priority story
			{
			},
			-- priority contextual
			{
				"HecateBossAboutFrogFamiliar01",
				"HecateBossAboutCatFamiliar01",
				"HecateBossAboutHoundFamiliar01",
			},
			{
				"HecateBossAboutArcana02",
				"HecateBossAboutShrine01"
			},
			{
				"HecateBossAboutCirceAspect01",
				"HecateBossAboutMorosAspect01",
			},
			{
				"HecateBossAboutTorch01",
				"HecateBossAboutAxe01",
				"HecateBossAboutLob01",
				"HecateBossAboutSuit01",
			},
			{
				"HecateBossAboutChronosBossW01",
			},
			{
				"HecateBossAboutSelene01",
				"HecateBossAboutArcana01",
				"HecateBossAboutHecateKeepsake01",
				"HecateBossAboutHecateKeepsake02",
				"HecateBossAboutNemesisKeepsake01",
				"HecateBossAboutOdysseusKeepsake01",
				"HecateBossAboutMorosKeepsake01",
				"HecateBossAboutMedeaKeepsake01",
				"HecateBossAboutErisKeepsake01",
				"HecateBossAboutTorch02",
				"HecateBossAboutFlattery01",
				"HecateBossAboutDemeter01",
				"HecateBossAboutDemeter02",
				"HecateBossAboutChronosBossW02",
			},
			{
				"HecateBossLowHealth01",
				"HecateBossLowHealth03",
			},
			-- lower priority story
			{
				"HecateBossAboutOlympians01",
				"HecateBossAboutChronos02",
			},
			-- lower priority contextual
			{
				"HecateBossAboutShrine02",
				"HecateBossAboutShrine03",
				"HecateBossRepeatedWins01",
			},
			{
				"HecateBossCloseMatch01",
				"HecateBossAboutArtemis01",
				"HecateBossAboutNemesis01",
				"HecateBossMissedFight01",
				"HecateBossAboutSilence01",
				"HecateBossAboutFailure01",
				"HecateBossAboutArachneOutfit01",
			},
			-- evergreen
			{
				"HecateBossAboutTesting01",
				"HecateBossAboutRespect01",
				"HecateBossAboutErebus02",
				"HecateBossAboutSolitude01",
				"HecateBossAboutSolitude02",
				"HecateBossAboutLearning01",
				"HecateBossAboutErebus01",
				"HecateBossAboutHermes03",
			},
			{
				"HecateBossAboutExpectations01",
				"HecateBossAboutTask01",
				"HecateBossAboutTask02",
				"HecateBossAboutWitchcraft01",
				"HecateBossAboutConfidence01",
				"HecateBossAboutAnger01",
			},
			{
				"HecateBossStrictlyBusiness01",
			}
		},

		BossOutroTextLinePriorities =
		{
			"HecateBossOutro01",
			"HecateBossOutroNoArcana01",
			"HecateBossGrantsCodex01",
			"HecateBossGrantsFamiliarSystem01",
			"HecateBossGrantsCardUpgradeSystem01",
			"HecateBossGrantsWeaponUpgradeSystem01",
			{
				"HecateBossMiscOutro03",
				"HecateBossMiscOutro05",
				"HecateBossMiscOutro11",
				"HecateBossMiscOutro13",
				"HecateBossMiscOutro14",
				"HecateBossMiscOutro17",
			},
			{
				"HecateBossMiscOutro01",
				"HecateBossMiscOutro02",
				"HecateBossMiscOutro04",
				"HecateBossMiscOutro06",
				"HecateBossMiscOutro07",
				"HecateBossMiscOutro08",
				"HecateBossMiscOutro09",
				"HecateBossMiscOutro10",
				"HecateBossMiscOutro12",
				"HecateBossMiscOutro15",
				"HecateBossMiscOutro16",
				"HecateBossMiscOutro18",
				"HecateBossMiscOutro19",
				"HecateBossMiscOutro20",
			}
		},
	},

	-- Charon
	NPC_Charon_01 =
	{
		InteractTextLinePriorities =
		{
			-- hub
			"CharonWithHecate01",
			"CharonGrantsMailbox01",
			"MorosWithCharon01",
			"MorosWithCharon02",

			-- immediate-contextual
			"CharonAboutTartarus01",
			"CharonAboutSurface01",
			"CharonAboutThessaly01",
			"CharonAboutChronosBossW01",
			"CharonAboutFates01",
			"CharonFirstMeeting",
			"CharonAboutHermes02",
			{
				"CharonAboutOlympus01",
			},
			{
				"CharonAboutChaos01",
				"CharonAboutEris01",
				"CharonAboutMoros01",
				"CharonAboutMoros02",
				"CharonAboutNyx01",
				"CharonAboutHermes03",
				"CharonAboutKeepsake01",
				"CharonAboutKeepsake02",
				"CharonAboutCharonAspect01",
				"CharonAboutShrine01",
			},
			{
				"CharonAboutOlympians01",
			},
			-- priority story
			{
				"CharonAboutGold01",
				"CharonAboutHermesMission01",
			},
			-- lower-priority contextual
			{
				"CharonAboutNemesis01",
				"CharonAboutHermes01",
				"CharonAboutArtemis01",
				"CharonAboutSelene01",
				"CharonAboutArachne01",
				"CharonAboutWellShops01",
				"CharonAboutSurfaceShops01",
			},
			{
				"CharonAboutTravel01",
				"CharonAboutNemesis02",
			},
			-- lower priority story
			"CharonAboutErebus01",
			-- evergreen
			{
				"CharonAboutGold02",
				"CharonAboutSmuggling01",
				"CharonAboutSpeaking01",
				"CharonAboutDanger01",
			},
		},

		GiftTextLinePriorities =
		{
			"CharonGift01",
			"CharonGift02",
			"CharonGift03",
			"CharonGift04",
			"CharonGift05", -- placeholder
		},
	},

	-- Athena
	NPC_Athena_01 =
	{
		InteractTextLinePriorities =
		{
			"AthenaAboutKeepsake01",
			"AthenaFirstMeeting",

			-- immediate-contextual
			{
				"AthenaAboutCirce01",
				"AthenaAboutCirce01_B",
				"AthenaAboutCirce02",
				"AthenaAboutCirce02_B",
			},
			{
				"AthenaAboutPrometheus01",
				"AthenaAboutPrometheusL01",
				"AthenaLowHealth01",
				"AthenaAboutTimePassing01",
			},

			-- priority story
			{
				"AthenaAboutAutomatons01",
				"AthenaAboutOlympians01",
				"AthenaAboutZeus01",
			},
			{
				"AthenaAboutZagreus01",
			},
			{
				"AthenaAboutAres01",
			},
			-- high-priority contextual
			{
				"AthenaAboutChronosBossW01",
			},
			{
				"AthenaAboutTalos01",
			},

			-- lower-priority contextual
			{
				"AthenaAboutFates01",
			},
			{
				"AthenaAboutHera01",
				"AthenaAboutHeracles01",
				"AthenaAboutDionysus01",
			},
			{
				"AthenaAboutShrine01",
			},

			-- lower priority story
			{
				"AthenaAboutSurfaceThreat01",
				"AthenaAboutPrometheus02",
			},
			{
				"AthenaAboutArachne01",
				"AthenaAboutArachne02",
				"AthenaAboutMortals01",
			},
			{
				"AthenaAboutCurse01",
				"AthenaAboutPersephone01",
			},
			{
				"AthenaAboutHecate01",
				"AthenaAboutSelene01",
			},

			-- evergreen
			{
				"AthenaAboutWeapons01",
				"AthenaAboutHobbies01",
			},
		},

		GiftTextLinePriorities =
		{
			"AthenaGift01",
			"AthenaGift02",
			"AthenaGift03",
			"AthenaGift04",
			"AthenaGiftTemp",
		},
	},

	-- Bouldy
	NPC_Bouldy_01 =
	{
		InteractTextLinePriorities =
		{
			"BouldyFirstMeeting",
		},

		GiftTextLinePriorities =
		{
			-- "BouldyGiftRepeatable01",
		},
	},

	-- Cerberus
	NPC_Cerberus_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"CerberusFirstMeeting",
		},

		GiftTextLinePriorities =
		{
			"CerberusGift01",
		},
	},

	InfestedCerberus =
	{
		BossOutroTextLinePriorities =
		{
			"CerberusBossOutro01",
			"CerberusBossOutro02",
			-- repeatable lines in EnemyData_InfestedCerberus
		},
	},

	-- Chaos
	TrialUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"ChaosFirstPickUp",

			-- immediate-contextual
			"ChaosAboutBountyChaosIntro01",
			"ChaosAboutSurfaceAppearance01",
			{
				"ChaosAboutBounties01",
				"ChaosAboutBounties02",
				"ChaosAboutBounties03",
				"ChaosAboutBounties04",
			},
			"ChaosAboutSurface01",
			"ChaosGrantsBountyBoard01",
			"ChaosAboutBountyBoardUnlock01",
			"ChaosAboutBountyBoard01",
			"ChaosAboutSurface02",
			"ChaosGrantsDarkness01",
			{
				"ChaosUnderworldRunCleared01",
				"ChaosAboutChronosFight01",
			},
			"ChaosAboutChronosNightmare01",

			-- priority story
			"ChaosAboutLife01",
			"ChaosAboutZagreus01",

			-- high-priority contextual
			{
				"ChaosAboutChaosGateItem01",
			},
			{
				"ChaosAboutKeepsake01",
				"ChaosAboutNemesis01",
				"ChaosAboutHades01",
			},
			{
				"ChaosAboutPostSurface01",
				"ChaosAboutShrine01",
			},

			-- run start
			{
				"ChaosRunStart01",
				"ChaosRunStart02",
			},

			-- health
			{
				"ChaosLowHealth01",
				"ChaosLowHealth02",
				"ChaosLowHealth03",
				"ChaosLowHealth04",
			},

			-- priority contextual
			{
				"ChaosAboutChronosNightmare02",
				"ChaosAboutChronos03",
			},
			{
				"ChaosAboutNemesis02",
			},
			{
				"ChaosUnderworldRunCleared02",
			},
			{
				"ChaosAboutStarDust01",
				"ChaosAboutWeapons01",			
			},

			-- about other gods
			{
				"ChaosAboutSelene01",
			},
			{
				"ChaosAboutZeus01",
				"ChaosAboutHera01",
				"ChaosAboutPoseidon01",
				"ChaosAboutApollo01",
				"ChaosAboutHestia01",
				"ChaosAboutHephaestus01",
				"ChaosAboutAphrodite01",
				"ChaosAboutDemeter01",
				"ChaosAboutArtemis01",
				"ChaosAboutHermes01",
			},
			-- lower-priority story
			{
				"ChaosAboutNyx01",
				"ChaosAboutNyx02",
				"ChaosAboutChronos02",
				"ChaosAboutFamily01",
			},
			{
				"ChaosAboutCreation01",
				"ChaosAboutChronos01",
			},
			{
				"ChaosAboutOlympians01",
				"ChaosAboutTrust01",
				"ChaosAboutSurfaceAppearance02",
			},

			-- lower-priority contextual
			{
				"ChaosAboutEris01",
				"ChaosAboutChaosGates01",
				"ChaosAboutHecate01",
			},

			-- evergreen
			{
				"ChaosAboutTitans01",
			},

		},
		
		GiftTextLinePriorities =
		{
			"ChaosGift01",
			"ChaosGift02",
			"ChaosGift03",
			"ChaosGift04",
			"ChaosGift05",
			"ChaosGift06",
			"ChaosGiftTemp",
		},
	},

	-- Chronos
	NPC_Chronos_01 =
	{
		InteractTextLinePriorities =
		{
			"ChronosFirstMeeting",
			"ChronosMeeting02",
			"ChronosReveal01",
			"ChronosPostBattleMeeting01",
			"ChronosPostWinStreakMeeting01",
			"ChronosMeeting03",
			"ChronosMeeting04",
			"ChronosMeeting05",
			"ChronosPostSurfaceMeeting01",
			"ChronosPostSurfaceMeeting03",
			"ChronosPostSurfaceMeeting02",
			"ChronosPostSurfaceMeeting04",
			"ChronosMeetingAboutZeus01",
			"ChronosMeetingAboutPoseidon01",
			"ChronosMeetingAboutHestia01",
			"ChronosMeetingAboutDemeter01",
			"ChronosMeetingAboutHera01",
			"ChronosPostBattleMeeting02",
			"ChronosPostBattleMeeting03",
			"ChronosPostBattleMeeting04",
			"ChronosMeetingAboutOlympians01",
		},
	},
	NPC_Chronos_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"ChronosNightmare01",
		},
	},

	-- Chronos Boss
	Chronos =
	{
		BossIntroTextLinePriorities =
		{
			"ChronosBossFirstMeeting_C",
			"ChronosBossFirstMeeting_B",
			"ChronosBossFirstMeeting",
			"ChronosBossLostAgainstHim01",
			"ChronosBossWonAgainstHim01",

			-- immediate-contextual
			{
				"ChronosBossAboutHades02",
				"ChronosBossAboutGameplayTimer02",
				"ChronosBossAboutPausing01",
			},
			-- priority story
			{
				"ChronosBossAboutHades01",
			},
			-- health
			{
			},
			-- priority contextual
			{
				"ChronosBossAboutThanatosAspect01",
			},
			-- about other gods
			{
			},
			-- lower-priority contextual
			{
				"ChronosBossAboutPrometheus02",
			},
			{
				"ChronosBossAboutChaos01",
				"ChronosBossAboutHistory01",
				"ChronosBossAboutGoldenAge02",
				"ChronosBossAboutEris01",
				"ChronosBossAboutPrometheus01",
				"ChronosBossAboutGameplayTimer01",
				"ChronosBossAboutThessaly01",
			},
			-- lower-priority story
			{
				"ChronosBossAboutCerberus01",
				"ChronosBossAboutGoldenAge01",
				"ChronosBossAboutMelinoe01",
			},
			{
				"ChronosBossAboutScylla01",
				"ChronosBossAboutScylla02",
				"ChronosBossAboutPolyphemus01",
				"ChronosBossAboutPolyphemus02",
				"ChronosBossAboutTime01",
				"ChronosBossAboutFates01",
				"ChronosBossAboutCharon01",
				"ChronosBossAboutClockwork01",
				"ChronosBossAboutStyx01",
			},

			-- evergreen
			{
				"ChronosBossAboutWeapons01",
				"ChronosBossAboutHouse01",
				"ChronosBossAboutSatyrs01",
				"ChronosBossAboutFuture01",
				"ChronosBossAboutWretches01",
				"ChronosBossAboutTitans01",
				"ChronosBossAboutOrigin01",
			},
		},

		BossPhaseChangeTextLinePriorities =
		{
			"ChronosR1FirstWin",
			{
				"ChronosR1Win01",
				"ChronosR1Win02",
				"ChronosR1Win03",
				"ChronosR1Win04",
			},
			{
				"ChronosR1Win05",
				"ChronosR1Win06",
			},
		},

		BossOutroTextLinePriorities =
		{
			"ChronosBossOutro01",
		},
	},

	-- Circe
	NPC_Circe_01 =
	{
		InteractTextLinePriorities =
		{
			"CirceFirstMeeting",
			-- immediate-contextual
			-- priority story
			{
				"CirceAboutHut01",
			},
			-- priority contextual
			{
				"CirceAboutCirceAspect01",
			},
			-- lower-priority contextual
			{
				"CirceAboutMoly01",
				"CirceAboutArcana01",
				"CirceAboutSelene01",
			},
			{
				"CirceAboutMedea01",
			},
			{
				"CirceAboutScylla01",
			},
			-- lower priority story
			{
				"CirceAboutThessaly01",
				"CirceAboutCrystals01",
				"CirceAboutHecate01",
				"CirceAboutChronos01",
			},
			{
				"CirceAboutBackstory01",
				"CirceAboutOdysseus01",
			},
			-- evergreen
			{
				"CirceAboutFamily01",
				"CirceAboutMiracles01",
				"CirceAboutStudies01",
			},
		},

		GiftTextLinePriorities =
		{
			"CirceGift01",
			"CirceGift02",
			"CirceGiftTemp",
		},
	},

	-- Dionysus
	NPC_Dionysus_01 =
	{
		InteractTextLinePriorities =
		{
			"DionysusFirstMeeting",
			"DionysusAboutFeast01",
			"DionysusAboutOlympians01",

			-- health & immediate contextual
			{
				"DionysusLowHealth01",
			},
			{
				"DionysusAboutKeepsake01",
			},

			-- priority story
			{
				"DionysusAboutFeast02",
				"DionysusAboutFeast03",
			},
			{
				"DionysusAboutFeast04",
				"DionysusAboutFeast05",
			},

			"DionysusAboutAutomatons01",

			"DionysusAboutPrometheus01",
			"DionysusAboutPrometheus02",
			"DionysusAboutPrometheus03",

			-- lower-priority contextual
			{
				"DionysusAboutSprings01",
				"DionysusAboutFrogFamiliar01",
			},

			-- lower priority story
			"DionysusAboutZagreus01",

			-- evergreen
			{
				"DionysusAboutZagreus02",
				"DionysusAboutTravels01",
				"DionysusAboutSatyrs01",
				"DionysusAboutMortals01",
			},
		},

		GiftTextLinePriorities =
		{
			"DionysusGift01",
			"DionysusGift02",
			"DionysusGift03",
			"DionysusGift04",
			"DionysusGiftTemp",
		},
	},

	-- Echo
	NPC_Echo_01 =
	{
		InteractTextLinePriorities =
		{
			"NarcissusWithEcho01",
			"NarcissusWithEcho02",

			"EchoFirstMeeting",
			"EchoAboutEcho01",
			"EchoAboutHelp01",

			-- immediate contextual
			{
				"EchoAboutNarcissus02",
				"EchoAboutNarcissus03",
				"EchoAboutNarcissus04",
				"EchoAboutNarcissus07",
			},
			-- priority story
			{
				"EchoAboutChronos01",
				"EchoAboutNymphs01",
				"EchoAboutFields01",
			},
			"EchoAboutNarcissus01",
			"EchoAboutNarcissus05",
			"EchoAboutNarcissus06",
			"EchoAboutNarcissus08",
			-- lower-priority contextual
			{
				"EchoAboutKeepsake01",
			},
			{
				"EchoLowHealth01",
				"EchoLowHealth02",
				"EchoAboutNemesis01",
			},
			-- lower priority story
			"EchoAboutHeart01",
			"EchoAboutCerberus01",

			-- evergreen
			{
				"EchoAboutBridge01",
				"EchoAboutCurse01",
				"EchoAboutCharon01",
			},
		},

		GiftTextLinePriorities =
		{
			"EchoGift01",
			"EchoGift02",
			"EchoGift03",
			"EchoGiftTemp",
		},		
	},

	-- Eris
	NPC_Eris_01 =
	{
		InteractTextLinePriorities =
		{
			"ErisFoughtAgainstHer01",
			"ErisFirstMeeting_B",
			"ErisFirstMeeting",

			-- immediate-contextual
			{
				"ErisFoughtAgainstHer02",
				"ErisFoughtAgainstHer03",
			},

			"ErisAboutCloseMatch01",
			"ErisAboutHeart01",
			"ErisAboutPast01",
			"ErisAboutSurface01",
			"ErisAboutSurface02",
			"ErisAboutRematches01",

			-- priority story
			"ErisAboutTask01",
			"ErisAboutPurpose01",
			"ErisAboutPast02",
			"ErisAboutLoyalty01",
			{
				"ErisAboutNyx01",
				"ErisAboutDisorder01",
				"ErisAboutWar01",
			},

			-- lower-priority contextual
			{
				"ErisAboutMoros01",
				"ErisAboutNemesis01",
				"ErisAboutHeracles01",
				"ErisAboutStrife02",
			},
			{
				"ErisAboutHecate01",
				"ErisPostGift01",
			},
			-- lower priority story
			{
				"NemesisWithEris01",
				"NemesisWithEris02",
				"MorosWithEris01",
				"MorosWithEris02",
			},
			{
				"ErisAboutWar02",
			},
			{
				"ErisAboutRumors01",
				"ErisAboutWeaponGun01",
				"ErisAboutTrash01",
				"ErisAboutTrash02",
				"ErisAboutStrife01",
			},

			-- evergreen
			{
				"ErisAboutAlley01",
				"ErisAboutSolitude01",
				"ErisAboutTruth01",
			},
		},

		GiftTextLinePriorities =
		{
			"ErisGift01",
			"ErisGift01_B",
			"ErisGift02",
			"ErisGift03",
			"ErisBathHouse01",
			"ErisGift04",
			"ErisGiftTemp",
			"ErisGiftDecline01",
			"ErisFishingDecline01",
			"ErisBathHouseDecline01",
		},

		CurseGiverPriorities =
		{
			"ErisGrantsCurse01",
			"ErisGrantsCurse06",
			"ErisGrantsCurse03",
			"ErisGrantsCurse04",
			"ErisGrantsCurse02",
			"ErisGrantsCurse05",
		},
	},

	-- Eris Boss
	Eris =
	{
		BossIntroTextLinePriorities =
		{
			"ErisBossFirstMeeting",

			-- health & immediate contextual
			"ErisBossAboutGoldenApples01",
			"ErisBossAboutConsequences01",

			-- priority story
			"ErisBossAboutObstacles01",
			"ErisBossAboutMistakes01",
			"ErisBossAboutRelaxation01",

			-- priority contextual

			-- lower priority story

			-- lower priority contextual

			-- evergreen

		},
	},

	-- Hera 
	HeraUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"HeraFirstPickUpAlt",
			"HeraFirstPickUp",
			-- immediate-contextual
			{
				"HeraAboutPackageBounty01",
			},
			{
				"HeraAboutDevotionTest01",
			},
			{
				"HeraUnderworldRunCleared01",
				"HeraSurfaceRunCleared01",
			},
			{
				"HeraAboutEris01",
				"HeraAboutPrometheus01",
			},
			-- priority story
			{
				"HeraAboutMeeting01",
				"HeraAboutMission01",
			},
			{
				"HeraAboutChronos01",
				"HeraAboutChronos05",
				"HeraAboutSurface01",
				"HeraAboutSurfaceSurvival01",
				"HeraAboutOceanus01",
			},
			{
				"HeraAboutFates01",
			},
			-- health
			{
				"HeraLowHealth01",
				"HeraLowHealth02",
				"HeraLowHealth03",
				"HeraLowHealth04",
			},
			{
				"HeraAboutFields01",
			},
			-- legendary
			{
				"HeraLegendaryPickUp01",
				"HeraLegendaryPickUp02",
			},
			-- priority contextual
			{
				"HeraAboutRouteChoice01",
			},
			{
				"HeraAboutPolyphemus01",
				"HeraAboutSelene01",
				-- "HeraAboutPolymorph01",
				"HeraAboutHeracles01",
				"HeraAboutHeracles02",
				"HeraAboutSurface02",
				"HeraRunStartSurface01",
			},
			{
				"HeraRunStart01",
				"HeraRunStartSurface02",
				"HeraRunStartUnderworld01",
			},
			-- about other gods
			{
				"HeraAboutZeus01",
				"HeraAboutZeus02",
			},
			{
				"HeraAboutHermes01",
			},
			{
				"HeraAboutPoseidon01",
				"HeraAboutDemeter01",
				"HeraAboutApollo01",
				"HeraAboutAphrodite01",
				"HeraAboutHephaestus01",
				"HeraAboutHestia01",
			},
			{
				"HeraAboutHades01",
				"HeraAboutFamily01",
			},
			{
				"HeraAboutChronos02",
				"HeraAboutChronos03",
				"HeraAboutChronos04",
			},
			-- lower-priority contextual
			{
				"HeraAboutRelationships01",
				"HeraAboutSurface03",
				"HeraPostGift01",
				"HeraPostGift02",
				"HeraAboutHecate01",
				"HeraAboutHyperion01",
				"HeraAboutReputation01",
				"HeraAboutPolymorph01",
			},
			-- lower priority story
			{
				"HeraAboutMortals01",
				"HeraAboutMortals03",
			},
			-- evergreen
			{
				"HeraAboutWitchcraft01",
				"HeraAboutMortals02",
				"HeraAboutEternity01",
				"HeraAboutChildren01",
				"HeraAboutChildren02",
				"HeraAboutChildren03",
				"HeraAboutZeusMarriage01",
				"HeraAboutZeusMarriage02",
				"HeraAboutMarriage01",
				"HeraAboutBows01",
			},
		},

		BoughtTextLinePriorities =
		{
			"HeraBlindBox01",
		},

		GiftTextLinePriorities =
		{
			"HeraGift01",
			"HeraGift02",
			"HeraGift03",
			"HeraGift04",
			"HeraGiftTemp", -- placeholder
		},
	},

	-- Heracles
	NPC_Heracles_01 =
	{
		BossIntroTextLinePriorities =
		{
			"HeraclesFirstMeeting",
			"HeraclesCombat01",
		},

		InteractTextLinePriorities =
		{
			"HeraclesFieldAboutEphyra01",
			{
				"HeraclesFieldAboutHera01",
				"HeraclesFieldAboutPolyphemus01"
			},
			"HeraclesFieldAboutWitches01",
			"HeraclesFieldAboutOlympus01",
			"HeraclesFieldAboutFathers01",
			"HeraclesFieldAboutBlood01",
			"HeraclesFieldAboutCharon01",
		},

		GiftTextLinePriorities =
		{
			"HeraclesGift01",
			"HeraclesGift02",
			"HeraclesGiftTemp",
		},
	},

	-- Hermes
	HermesUpgrade = 
	{
		InteractTextLinePriorities =
		{
			-- health & immediate-contextual
			{
				"HermesAboutSurface01",
				"HermesAboutSurface02",
				"HermesAboutSurface02B",
			},
			{
				"HermesAboutOlympus01",
				"HermesUnderworldRunCleared01",
			},
			-- priority story
			{
				"HermesAboutFates01",
				"HermesAboutReachingSurface01",
				"HermesAboutRouteChoice01",
			},
			{
				"HermesAboutMission01",
				"HermesAboutMission02",
			},
			{
				"HermesAboutOlympusSiege01",
				"HermesAboutChronosPlan01",
				"HermesAboutPrometheus01",
			},
			{
				"HermesAboutHecate01",
				"HermesAboutFamily01",
				"HermesAboutSurface03",
			},
			-- high priority contextual
			{
				"HermesAboutPackageBounty01",
			},
			{
				"HermesAboutMomusAspect01",
				"HermesAboutHades01",
			},
			{
				"HermesAboutDemeter01",
				"HermesAboutSelene01",
			},
			-- low health
			{
				"HermesLowHealth01",
				"HermesLowHealth02",
				"HermesLowHealth03",
				"HermesLowHealth04",
			},
			-- legendary
			{
				"HermesLegendaryPickUp01",
				"HermesLegendaryPickUp02",
				"HermesLegendaryPickUp03",
			},
			-- about other gods
			{
				"HermesAboutZeus01",
				"HermesAboutApollo01",
				"HermesAboutHephaestus01",
			},
			-- priority contextual
			{
				"HermesAboutThessaly01",
				"HermesAboutKeepsake01",
			},
			{
				"HermesRunStartSurface01",
				"HermesRunStartSurface02",
				"HermesUnderworldStart01",
			},
			{
				"HermesAboutOceanus01",
				"HermesAboutCharon01",
				"HermesAboutArtemis02",
			},
			{
				"HermesAboutMoros01",
			},
			{
				"HermesAboutSurfaceThreat01",
				"HermesAboutChronos01",
				"HermesAboutCharon02",
			},
			{
				"HermesRunStart01",
				"HermesRunStart02",
				"HermesRunStart03",
				"HermesRunStart04",
			},
			{
				"HermesAboutPersephone01",
			},
			-- lower-priority story
			{
				"HermesAboutZagreus01",
			},
			{
				"HermesAboutMelinoe01",
				"HermesAboutPast01",
				"HermesAboutChronos02",
			},
			-- lower-priority contextual
			{
				"HermesAboutHeracles01",
				"HermesAboutHephaestus02",
				"HermesAboutGameplayTimer01",
				"HermesAboutArtemis01",
				"HermesAboutSurfaceShop01",
				"HermesAboutFamiliars01",
				"HermesAboutCirce01",
			},
			-- evergreen
			{
			},
		},

		GiftTextLinePriorities =
		{
			"HermesGift01",
			"HermesGift02",
			"HermesGift03",
			"HermesGift04",
			"HermesGiftTemp",
		},
	},

	-- Icarus
	NPC_Icarus_01 =
	{
		InteractTextLinePriorities =
		{
			"IcarusFirstMeeting",
			-- immediate-contextual
			"IcarusAboutChronosBossW01",
			"IcarusAboutDaedalus02",
			"IcarusAboutEris01",
			{
				"IcarusAboutKeepsake01",
			},
			-- priority story
			{
				"IcarusAboutMelinoe01",
				"IcarusAboutFlying01",
				"IcarusAboutFlying02",
				"IcarusAboutReturning02",
				"IcarusAboutSurfaceCurse01",
			},
			{
				"IcarusAboutDaedalus01",
				"IcarusAboutReturning01",
				"IcarusAboutFlying03",
				"IcarusAboutOdysseus01",
			},
			-- lower-priority contextual
			{
			},
			-- lower priority story
			{
				"IcarusAboutDaedalus03",
			},
			-- evergreen
			{
			},
		},

		GiftTextLinePriorities =
		{
			"IcarusGift01",
			"IcarusGift02",
			"IcarusGift03",
			"IcarusGiftTemp",
		},
	},

	-- Medea
	NPC_Medea_01 =
	{
		InteractTextLinePriorities =
		{
			"MedeaFirstMeeting",
			"MedeaHubFirstMeeting01",

			-- immediate-contextual
			-- priority story
			{
				"MedeaAboutFoes01",
				"MedeaAboutVengeance01",
			},
			{
				"MedeaAboutEphyra01"
			},
			-- lower-priority contextual
			{
				"MedeaAboutApollo01",
				"MedeaAboutHera01",
			},
			{
				"MedeaAboutHeracles01",
				"MedeaAboutWitchcraft01",
				"MedeaAboutHecate01",
			},
			{
				"MedeaAboutKeepsake01",
			},
			-- lower priority story
			{
				"MedeaAboutCirce01",
				"MedeaAboutCurses01",
				"MedeaAboutBlood01",
				"MedeaAboutUndead01",
				"MedeaAboutReputation01",
				"MedeaAboutSuffering01",
			},
			-- evergreen
			{
				"MedeaAboutOptimism01",
				"MedeaAboutPoisons01",
				"MedeaAboutSolitude01",
			},
		},

		GiftTextLinePriorities =
		{
			"MedeaGift01",
			"MedeaGift02",
			"MedeaGift03",
			"MedeaGift04",
			"MedeaGiftTemp",
		},
	},

	-- Narcissus
	NPC_Narcissus_01 =
	{
		InteractTextLinePriorities =
		{
			"NemesisWithNarcissus02_FollowUp",
			"NarcissusFirstMeeting",
			"NarcissusAboutLooks01",
			"NemesisWithNarcissus01_FollowUp",
			-- immediate-contextual
			{
				"NarcissusAboutWaters01",
				"NarcissusAboutWaters01_2",
				"NarcissusAboutWaters01_3",
				"NarcissusAboutWaters02",
				"NarcissusAboutWaters03",
				"NarcissusAboutWaters04",
				"NarcissusAboutWaters04_2",
				"NarcissusAboutWaters05",
				"NarcissusGrantsReward01",
			},
			{
				"NarcissusAboutStillDirtyWaters01",
				"NarcissusAboutEcho02",
				"NarcissusAboutEcho03",
				"NarcissusAboutEcho04",
			},
			-- priority story
			{
				"NarcissusAboutLooks02",
			},
			{
				"NarcissusAboutDanger01",
				"NarcissusAboutSolitude01",
				"NarcissusAboutOceanus01",
				"NarcissusAboutOceanus02",
				"NarcissusAboutReflection01",
			},
			-- priority contextual
			{
				"NarcissusAboutEcho01",
				"NarcissusAboutEcho01B",
			},
			"NarcissusAboutNemesis01",
			{
				"NarcissusAboutKeepsake01",
			},
			{
				"NarcissusAboutEcho05",
				"NarcissusAboutEcho06",
			},
			-- lower-priority contextual
			{
				"NarcissusLowHealth01",
			},
			{
				"NarcissusLowHealth02",
			},
			-- lower priority story
			{
				"NarcissusAboutCurse01",
				"NarcissusAboutLove02",
				"NarcissusAboutLove03",
				"NarcissusAboutFriendship01",
			},
			{
				"NarcissusAboutBeauty01",
				"NarcissusAboutChronos01",
				"NarcissusAboutSirens01",
				"NarcissusAboutLove01",
			},
			{
				"NarcissusAboutReflection02",
				"NarcissusAboutReflection03",
			},
			-- evergreen
			{
				"NarcissusAboutReflection04",
			}
		},

		GiftTextLinePriorities =
		{
			"NarcissusGift01",
			"NarcissusGift02",
			"NarcissusGift03",
			"NarcissusGift04",
			"NarcissusGiftTemp",
		},
	},

	NPC_Narcissus_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"NarcissusWithEcho01",
			"NarcissusWithEcho02",
		},

		GiftTextLinePriorities =
		{
			"NarcissusGift01",
			"NarcissusGift02",
			"NarcissusGift03",
			"NarcissusGift04",
			"NarcissusGiftTemp",
		},
	},

	-- Other Characters
	-- Nyx
	NPC_Nyx_01 =
	{
		InteractTextLinePriorities =
		{
			"NyxNightmare01",
		},
	},

	-- Polyphemus
	Polyphemus =
	{
		BossIntroTextLinePriorities =
		{
			"PolyphemusAboutBarn01",
			"PolyphemusFirstMeeting",

			-- health & immediate contextual
			{
				"PolyphemusAboutNobodyKeepsake01",
			},
			{
				"PolyphemusAboutNobody02",
				"PolyphemusAboutNobody03",
			},
			{
				"PolyphemusBarelyLostAgainstHim01",
			},
			{
				"PolyphemusAboutPoseidon02",
				"PolyphemusLowHealth01",
				"PolyphemusLowHealth02",
			},
			{
				"PolyphemusLostAgainstHim01",
				"PolyphemusLostAgainstHim02",
			},
			{
				"PolyphemusWonAgainstHim01",
				"PolyphemusWonAgainstHim02",
				"PolyphemusAboutChronos02",
			},
			{
				"PolyphemusAboutName01",
			},
			-- priority story
			{
				"PolyphemusAboutFriendship01",
			},
			{
				"PolyphemusAboutChronos01",
				"PolyphemusAboutEphyra01",
				"PolyphemusAboutThessaly01",
				"PolyphemusAboutDocks01",
				"PolyphemusAboutNobody01",
				"PolyphemusAboutPast01",
				"PolyphemusAboutOlympus01",
			},
			-- priority contextual
			{
				"PolyphemusAboutUnderworld01",
				"PolyphemusAboutPoseidon01",
				"PolyphemusAboutInsomnia02",
			},
			-- lower priority story
			{
				"PolyphemusAboutBlindness01",
				"PolyphemusAboutWar01",
				"PolyphemusAboutUnderworld01B",
			},
			-- lower priority contextual
			{
				"PolyphemusAboutMedea01",
				"PolyphemusAboutHeracles01",
				"PolyphemusAboutInsomnia01",
			},
			-- evergreen		
			{
				"PolyphemusAboutSheep01",
				"PolyphemusAboutCyclopes01",
				"PolyphemusAboutBoulders01",
				"PolyphemusAboutFlock01",
				"PolyphemusAboutDiet01",
			},
		},
	},

	-- Prometheus
	Prometheus =
	{
		BossIntroTextLinePriorities =
		{
			"PrometheusFirstMeeting",
			"PrometheusLostAgainstHim01",
			"PrometheusLostAgainstHim02",
			"PrometheusWonAgainstHim01",
			"PrometheusWonAgainstHim02",

			-- health & immediate contextual
			{
				"PrometheusPackagedBounties01",
			},
			{
				"PrometheusAboutDionysus02",
			},
			{
				"PrometheusLowHealth01",
				"PrometheusLowHealth02",
				"PrometheusLowHealth03",
			},
			{
				"PrometheusAboutDionysus01",
			},

			-- priority story
			{
				"PrometheusAboutMortals01",
				"PrometheusAboutMortals02",
				"PrometheusAboutFire01",
			},
			{
				"PrometheusAboutGoldenAge01",
			},
			{
				"PrometheusAboutChronos01",
			},
			{
				"PrometheusAboutMortals03",
			},

			-- priority contextual
			{
				"PrometheusAboutDora01",
				"PrometheusAboutDora02",
			},
			{
				"PrometheusAboutFates01",
				"PrometheusAboutForesight04",
				"PrometheusAboutForesight05",
				"PrometheusAboutTorch01",
			},

			-- lower priority contextual
			{
				"PrometheusAboutCirce01",
			},
			{
				"PrometheusAboutZeus01",
				"PrometheusAboutChaos01",
				"PrometheusAboutBrothers01",
			},

			-- lower priority story
			{
				"PrometheusAboutForesight01",
				"PrometheusAboutForesight02",
				"PrometheusAboutForesight03",
			},
			{
				"PrometheusAboutPlans01",
				"PrometheusAboutFuture01",
			},

			-- evergreen
		},

		BossOutroTextLinePriorities =
		{
			"PrometheusBossOutro01",
		},
	},

	-- Scylla
	Scylla =
	{
		BossIntroTextLinePriorities =
		{
			"ScyllaFirstMeeting",
			"ScyllaAboutSongs02",

			-- health & immediate contextual
			-- @temp to get song 2 in the mix
			"ScyllaAboutSongs01",
			"ScyllaAboutAmbitions01",
			"ScyllaAboutChlams02",
			"ScyllaAboutComeback01",
			"ScyllaAboutPackagedBounties01",
			"ScyllaAboutSongVolume01",
			"ScyllaAboutSirens02",
			{
				"ScyllaLowHealth01",
				"ScyllaLowHealth02",
				"ScyllaLowHealth03",
				"ScyllaLowHealth04",
			},
			-- priority story

			-- priority contextual
			{
				"ScyllaAboutAgents02",
				"ScyllaAboutOdysseus01",
			},
			-- lower priority contextual
			{
				"ScyllaAboutDying01",
				"ScyllaAboutThessaly01",
				"ScyllaAboutCharybdis01",
			},
			-- lower priority story
			{
				"ScyllaAboutAgents01",
				"ScyllaAboutChronos01",
				"ScyllaAboutChronos02",
			},
			{
				"ScyllaAboutAmbitions02",
				"ScyllaAboutSirens01",
				"ScyllaAboutReputation01",
				"ScyllaAboutStage01",
				"ScyllaAboutSlump01",
				"ScyllaAboutSongs03",
				"ScyllaAboutSongs04",
			},
			-- evergreen
			{
				"ScyllaAboutChlams01",
				"ScyllaAboutSurvey01",
				"ScyllaAboutGreenRoom01",
			},
		},
	},
})

NarrativeData.ConversationOrder =
{
	"NPC_Hecate_01",
	"NPC_Odysseus_01",
	"NPC_Dora_01",
	"NPC_Nemesis_01",
	"NPC_Eris_01",
	"NPC_Moros_01",
	"NPC_Hypnos_01",
	"NPC_Hypnos_02",
	"NPC_Charon_01",
	"NPC_Selene_01",
	"NPC_Skelly_01",

	"NPC_Chronos_01",
	"NPC_Chronos_Story_01",
	"NPC_Arachne_01",
	"NPC_Arachne_Home_01",
	"NPC_Heracles_01",

	"NPC_Artemis_Field_01",
	"NPC_Artemis_01",
	"NPC_Hermes_01",
	"NPC_Athena_01",
	"NPC_Dionysus_01",

	"NPC_Narcissus_01",
	"NPC_Narcissus_Field_01",
	"NPC_Echo_01",
	"NPC_Icarus_01",
	"NPC_Medea_01",
	"NPC_Circe_01",

	"NPC_Hecate_Story_01",
	"NPC_Nyx_01",

	"NPC_Hades_Field_01",
	"NPC_Cerberus_Field_01",
	"NPC_Bouldy_01",
}

-- Event Tables
GameData.GodAboutGodVoiceLines =
{
	"ZeusAboutHera01",
	"ZeusAboutPoseidon01",
	"ZeusAboutApollo01",
	"ZeusAboutApollo02",
	"ZeusAboutHephaestus01",
	"ZeusAboutAphrodite01",
	"ZeusAboutDemeter01",
	"ZeusAboutHestia01",
	"ZeusAboutHermes01",
	"ZeusAboutSelene01",

	"HeraAboutZeus01",
	"HeraAboutZeus02",
	"HeraAboutPoseidon01",
	"HeraAboutDemeter01",
	"HeraAboutApollo01",
	"HeraAboutAphrodite01",
	"HeraAboutHephaestus01",
	"HeraAboutHestia01",
	"HeraAboutHermes01",
	"HeraAboutSelene01",

	"PoseidonAboutZeus01",
	"PoseidonAboutHera01",
	"PoseidonAboutApollo01",
	"PoseidonAboutAphrodite01",
	"PoseidonAboutHestia01",
	"PoseidonAboutSelene01",
	"PoseidonAboutDemeter01",
	"PoseidonAboutHermes01",
	"PoseidonAboutHephaestus01",
	"PoseidonAboutHephaestus02",
	"PoseidonAboutArtemis02",

	"ApolloAboutZeus01",
	"ApolloAboutHera01",
	"ApolloAboutPoseidon01",
	"ApolloAboutHera01",
	"ApolloAboutHestia01",
	"ApolloAboutAphrodite01",
	-- "ApolloAboutHephaestus01",
	"ApolloAboutDemeter01",
	"ApolloAboutHermes01",

	"DemeterAboutZeus01",
	"DemeterAboutHera01",
	"DemeterAboutPoseidon01",
	"DemeterAboutPoseidon02",
	"DemeterAboutApollo01",
	"DemeterAboutHestia01",
	"DemeterAboutHephaestus01",
	"DemeterAboutAphrodite01",
	"DemeterAboutSelene01",
	"DemeterAboutHermes01",	

	"AphroditeAboutZeus01",
	"AphroditeAboutHera01",
	"AphroditeAboutPoseidon01",
	"AphroditeAboutApollo01",
	"AphroditeAboutDemeter01",
	"AphroditeAboutHestia01",
	"AphroditeAboutHephaestus01",
	"AphroditeAboutHephaestus02",
	"AphroditeAboutHermes01",
	"AphroditeAboutSelene01",

	"HestiaAboutHera01",
	"HestiaAboutHera02",
	"HestiaAboutZeus01",
	"HestiaAboutPoseidon01",
	"HestiaAboutApollo01",
	"HestiaAboutAphrodite01",
	"HestiaAboutDemeter01",
	"HestiaAboutDemeter02",
	"HestiaAboutHephaestus01",
	"HestiaAboutHermes01",
	"HestiaAboutSelene01",

	"HephaestusAboutAphrodite01",
	"HephaestusAboutHera01",
	"HephaestusAboutZeus01",
	"HephaestusAboutPoseidon01",
	"HephaestusAboutApollo01",
	"HephaestusAboutHestia01",
	"HephaestusAboutDemeter01",
	"HephaestusAboutHermes01",
	"HephaestusAboutSelene01",

	"SeleneAboutZeus01",
	"SeleneAboutHera01",
	"SeleneAboutApollo01",
	"SeleneAboutPoseidon01",
	"SeleneAboutDemeter01",
	"SeleneAboutAphrodite01",
	"SeleneAboutHephaestus01",
	"SeleneAboutHestia01",
	"SeleneAboutHermes01",

	-- Hermes TKTK
}
GameData.OdysseusTavernaEvents =
{
	"OdysseusBackstory02",
	"OdysseusAboutMood01",
	"OdysseusAboutScylla03",
}
GameData.NarcissusTalkToSelfEvents =
{
	"NarcissusAboutReflection01",
	"NarcissusAboutReflection02",
	"NarcissusAboutReflection03",
	"NarcissusAboutReflection04",
	"NarcissusAboutStillDirtyWaters01",
	"NarcissusChat07",
	"NarcissusChat08",
	"NarcissusChat14",
	"NarcissusChat15",
	"NarcissusChat29",
	"NarcissusChat30",
}
GameData.ArachneUpsetEvents =
{
	"ArachneAboutGods01",
	"ArachneAboutGods02",
	"ArachneAboutGods03",
	"ArachneAboutGods04",
	-- "ArachneAboutGods05"
}

-- other data
GameData.AllPurchaseableCosmetics =
{
	-- current total purchaseable cosmetics = 71
	-- Tent (note: also check DoraAboutTent03)
	-- "Cosmetic_TentBlanket01",
	"Cosmetic_TentBlanket01a",
	"Cosmetic_TentBlanket01b",
	"Cosmetic_ApolloLyre",
	"Cosmetic_TentHangingOrnaments01",
	"Cosmetic_EmployeeOfTheMonth",
	"Cosmetic_WitchTrinkets01",
	"Cosmetic_WitchTrinkets02",
	-- "Cosmetic_TentCandle01",
	"Cosmetic_TentCandle01a",
	"Cosmetic_TentCandle01b",
	"Cosmetic_TentQuilt",
	-- "Cosmetic_TentShelf01",
	"Cosmetic_TentShelf01a",
	"Cosmetic_TentShelf01b",
	"Cosmetic_FanPoster01",
	"Cosmetic_FanPoster01a",
	"Cosmetic_FanPoster01b",
	"Cosmetic_ThanPoster",
	"Cosmetic_TentRug",

	-- Respawn Area
	-- "Cosmetic_FrinosRock01",
	"Cosmetic_FrinosRock01a",
	"Cosmetic_FrinosRock01b",
	"Cosmetic_RespawnCircleFlowers",
	"Cosmetic_FamiliarEffigy01",
	"Cosmetic_FamiliarEffigy01a",
	"Cosmetic_FamiliarEffigy01b",

	-- Moros Corner
	"Cosmetic_MorosChaise",
	"Cosmetic_MorosTentCanopy",
	"Cosmetic_MorosScrolls",
	"Cosmetic_MorosRug",
	"Cosmetic_MorosSpools",

	-- Nemesis Corner
	"Cosmetic_NemesisChair",
	"Cosmetic_NemesisRug",
	"Cosmetic_NemesisGrindstone",
	"Cosmetic_NemesisBraziers",

	-- Odysseus Corner
	"Cosmetic_OdysseusRug",
	-- "Cosmetic_OdysseusTable01",
	"Cosmetic_OdysseusTable01a",
	"Cosmetic_OdysseusVase",

	-- Eris Corner
	"Cosmetic_ErisTrashcan",

	-- General
	-- "Cosmetic_MainHangingTassles01",
	"Cosmetic_MainHangingTassles01a",
	"Cosmetic_MainHangingTassles01b",
	-- "Cosmetic_MainHangingRope01",
	"Cosmetic_MainHangingRope01a",
	"Cosmetic_RiverLanterns",
	"Cosmetic_MainTeaLights",
	-- "Cosmetic_MainLanterns01",
	"Cosmetic_MainLanterns01a",
	"Cosmetic_MainLanterns01b",
	"Cosmetic_BrokerRug",

	-- Cauldron
	-- "Cosmetic_Cauldron01",
	"Cosmetic_Cauldron01a",
	"Cosmetic_Cauldron01b",
	-- "Cosmetic_CauldronRing01",
	"Cosmetic_CauldronRing01a",
	"Cosmetic_CauldronRing01b",
	-- "Cosmetic_CauldronPillars01",
	"Cosmetic_CauldronPillars01a",
	"Cosmetic_CauldronPillars01b",
	"Cosmetic_CauldronPillars01c",

	-- Hot Springs
	"Cosmetic_BathChangingScreens",
	"Cosmetic_BathTowelRacks",
	"Cosmetic_BathSoaps",

	-- Hypnos Corner
	-- "Cosmetic_HypnosLanterns01",
	"Cosmetic_HypnosLanterns01a",
	"Cosmetic_HypnosLanterns01b",
	-- "Cosmetic_HypnosPillars01",
	"Cosmetic_HypnosPillars01a",
	"Cosmetic_HypnosRug",

	-- Fishing Area
	"Cosmetic_Aquarium",

	-- Taverna
	-- "Cosmetic_TavernaTables01",
	"Cosmetic_TavernaTables01a",
	"Cosmetic_TavernaTables01b",
	-- "Cosmetic_TavernaChairs01",
	"Cosmetic_TavernaChairs01a",
	"Cosmetic_TavernaChairs01b",
	"Cosmetic_TavernaStarMosaic",

	-- PreRun (note: also check SkellyAboutCosmetics01)
	-- "Cosmetic_SkellyFloor01",
	"Cosmetic_SkellyFloor01a",
	"Cosmetic_SkellyFloor01b",
	-- "Cosmetic_TrainingDummy01",
	"Cosmetic_TrainingDummy01a",
	"Cosmetic_TrainingDummy01b",
	"Cosmetic_CatScratcher",
	"Cosmetic_BirdHouse",
	"Cosmetic_ExitCharm",
}

GameData.BannedEnemySightedEncounters =
{
	"ArachneCombatF",
	"ArachneCombatG",
	"ArachneCombatN",

	"NemesisCombatIntro",
	"NemesisCombatF",
	"NemesisCombatG",
	"NemesisCombatH",

	"HeraclesCombatN",
	"HeraclesCombatN2",
	"HeraclesCombatO",
	"HeraclesCombatO2",
	"HeraclesCombatP",
	"HeraclesCombatP2",

	"IcarusCombatO",
	"IcarusCombatO2",
	"IcarusCombatP",
	"IcarusCombatP2",

	"MiniBossWaterUnit",
	"MiniBossLamia",
	"MiniBossVampire",
	"MiniBossRatCatcher",
	"MiniBossGoldElemental",
	"MiniBossSatyrCrossbow",
	"MiniBossDragon",

	"BossHecate01",
	"BossScylla01",
	"BossInfestedCerberus01",
	"BossChronos01",
	"BossPolyphemus01",
	"BossEris01",
	"BossPrometheus01",
}

GameData.CombatUniqueEncounters =
{
	"BossHecate01",
	"BossPolyphemus01",
	"BossScylla01",
	"BossInfestedCerberus01",
	"BossChronos01",
	"BossPolyphemus01",
	"BossEris01",
	"BossPrometheus01",

	"SiegeVineIntro",
	"RadiatorIntro",
	"ScreamerIntro",

	"FishmanIntro",
	"FishSwarmerIntro",
	"TurtleIntro",

	"LamiaIntro",
	"LovesickIntro",
	"VampireIntro",
	"LycanthropeIntro",
	"MournerIntro",

	"MudmanIntro",
	"ZombieAssassinIntro",
	"ZombieHeavyRangedIntro",
	"ZombieSpawnerIntro",

	"ScimiterrorIntro",
	"HarpyCutterIntro",
	"WaterElementalIntro",
	"DrunkIntro",
	"Mage2Intro",

	"DragonIntro",
	"SapperIntro",
	"AutomatonBeamerIntro",
	"AutomatonEnforcerIntro",

	"OlympusIntro",
}

GameData.CombatNPCEncounters =
{
	"ArachneCombatF",
	"ArachneCombatG",
	"ArachneCombatN",

	"ArtemisCombatIntro",
	"ArtemisCombatF",
	"ArtemisCombatF2",
	"ArtemisCombatG",
	"ArtemisCombatG2",
	"ArtemisCombatN",
	"ArtemisCombatN2",

	"NemesisCombatIntro",
	"NemesisCombatF",
	"NemesisCombatG",
	"NemesisCombatH",

	"HeraclesCombatN",
	"HeraclesCombatN2",
	"HeraclesCombatO",
	"HeraclesCombatO2",
	"HeraclesCombatP",
	"HeraclesCombatP2",

	"IcarusCombatIntro",
	"IcarusCombatO",
	"IcarusCombatO2",
	"IcarusCombatP",
	"IcarusCombatP2",

	"AthenaCombatIntro",
	"AthenaCombatP",
	"AthenaCombatP02" 
}

GameData.AllDuoBoons =
{
	"SuperSacrificeBoonZeus",
	"SuperSacrificeBoonHera",
	"LightningVulnerabilityBoon",
	"ApolloSecondStageCastBoon",
	"RootStrikeBoon",
	"SprintEchoBoon",
	"ReboundingSparkBoon",
	"EchoBurnBoon",
	"MoneyDamageBoon",
	"RaiseDeadBoon",
	"KeepsakeLevelBoon",
	"CharmCrowdBoon",
	"ManaShieldBoon",
	"ManaRestoreDamageBoon",
	"PoseidonSplashSprintBoon",
	"GoodStuffBoon",
	"AllCloseBoon",
	"MassiveCastBoon",
	"SteamBoon",
	"ManaBurstCountBoon",
	"StormSpawnBoon",
	"BlindClearBoon",
	"CoverRegenerationBoon",
	"MaxHealthDamageBoon",
	"ClearRootBoon",
	"BurnConsumeBoon",
	"SlamManaBurstBoon",
	"BurnRefreshBoon",
	"DoubleMassiveAttackBoon",
}
GameData.AllRareTalents =
{
	"RolloverUsesTalent",
	"ClearCastTalent",
	"HealRetaliateTalent",
	"HealLastTalent",
	"TimeSlowSpeedTalent",
	"TimeSlowCritTalent",
	"TimeSlowDestroyProjectilesTalent",
	"TimeSlowFreezeTimeTalent",
	"SpellChargeBonusTalent",
	"TimeSlowCumulativeBuffTalent",
	"TimeSlowLastStandRechargeTalent",
	"LaserTripleTalent",
	"LaserAoETalent",
	"LaserDurationTalent",
	"LaserPrimaryTalent",
	"LaserPenetrationTalent",
	"PolymorphBossDamageTalent",
	"PolymorphTeleportCastTalent",
	"PolymorphHealthCrushTalent",
	"PolymorphSandwichTalent",
	"PolymorphCurseTalent",
	"SummonSpeedTalent",
	"SummonTeleportTalent",
	"SummonRetaliateTalent",
	"SummonDamageSplitTalent",
	"SummonPermanenceTalent",
	"SummonSpecialTalent",
	"SummonExplodeTalent",
	"MeteorInvulnerableChargeTalent",
	"MeteorVulnerabilityDecalTalent",
	"MeteorSlowDecalTalent",
	"MeteorShowerTalent",
	"MeteorDoubleTalent",
	"LeapTwiceTalent",
	"LeapSprintTalent",
	"TransformLastStandRechargeTalent",
	"TransformPrimaryTalent",
	"TransformSpecialTalent",
	"TransformExCastTalent",
}

-- @ update with additional Aspects
GameData.AllWeaponAspects =
{
	"StaffClearCastAspect",
	"StaffSelfHitAspect",

	"DaggerBlockAspect",
	"DaggerHomingThrowAspect",

	"TorchDetonateAspect",
	"TorchSprintRecallAspect",

	"AxeArmCastAspect",
	"AxePerfectCriticalAspect",

	"LobCloseAttackAspect",
	"LobImpulseAspect",

	"SuitHexAspect",
	"SuitMarkCritAspect",
}

GameData.AllExpiringKeepsakes =
{
	"BossPreDamageKeepsake",
	"ReincarnationKeepsake",
	"SpellTalentKeepsake",
	"BonusMoneyKeepsake",
	"ArmorConversionKeepsake",
	"FountainRarityKeepsake",
	"DecayingBoostKeepsake",
	"ForceZeusBoonKeepsake",
	"ForceHeraBoonKeepsake",
	"ForcePoseidonBoonKeepsake",
	"ForceApolloBoonKeepsake",
	"ForceDemeterBoonKeepsake",
	"ForceAphroditeBoonKeepsake",
	"ForceHestiaBoonKeepsake",
	"ForceHephaestusBoonKeepsake",
	"UnpickedBoonKeepsake",
	"TimedBuffKeepsake",
	"ManaOverTimeRefundKeepsake",
	"BossMetaUpgradeKeepsake",
	"LowHealthCritKeepsake",
}

-- these groupings are to aid with localization
GameData.FormalRelationships =
{
	"NPC_Charon_01",
	"NPC_Chronos_01",
	"NPC_Hecate_01",
	"NPC_Heracles_01",
	"NPC_Hypnos_01",
	"NPC_Medea_01",
	"NPC_Circe_01",
	"NPC_Athena_01",
	"NPC_Moros_01",
	"NPC_Selene_01",
	"NPC_Skelly_01",
	"NPC_Hades_01",
	"NPC_Hades_Field_01",
	"AphroditeUpgrade",
	"ApolloUpgrade",
	"DemeterUpgrade",
	"HephaestusUpgrade",
	"HeraUpgrade",
	"HestiaUpgrade",
	"PoseidonUpgrade",
	"Market", -- Wretched Broker
	"SpellDrop",
	"TrialUpgrade",
	"ZeusUpgrade",
	"NPC_Athena_01",
	"NPC_Dionysus_01",
}
GameData.InformalRelationshipsF =
{
	"NPC_Artemis_01",
	"NPC_Artemis_Field_01",
	"NPC_Arachne_01",
	"NPC_Dora_01",
	"NPC_Eris_01",
	"NPC_Nemesis_01",
	-- "NPC_Narcissus_01",
	-- "NPC_Odysseus_01",
	-- "HermesUpgrade",
}
GameData.InformalRelationshipsM =
{
	"NPC_Narcissus_01",
	"NPC_Odysseus_01",
	"NPC_Icarus_01",
	"NPC_Hermes_01",
	"HermesUpgrade",
}

GameData.DreamSequenceData =
{
	SwapSounds =
	{
		["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
		["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
	},
}

GameData.PostBathHouseArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 12 },
}
GameData.PostFishingArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 16 },
}
GameData.PostTavernaArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 20 },
}
GameData.PostDreamArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 8 },
}

PartnerConversationDataShare =
{
	"OnQueuedFunctionName",
	"OnQueuedFunctionArgs",
	"UseText",
}

ScreenData.Dialog =
{
	Name = "Dialog",
	FreezePlayerArgs =
	{
		StopRotation = false,
	},
	PlayedPortraitEnterSounds = {},
	DefaultGroup = "Combat_Menu",

	ComponentData =
	{
		DialogueText =
		{
			TextArgs = 
			{
				Font = "LatoSemibold",
				Justification = "LEFT",
				ShadowBlur = 0,
				ShadowOffsetX = 0,
				ShadowOffsetY = 4,
				LineSpacingBottom = 4,
				LangLineSpacingBottom = 
				{
					{ Code = "zh-TW", Value = 0 },
				},
			}
		}
	}
}