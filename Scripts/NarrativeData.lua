NarrativeConstantData =
{
	ListenSkipThreshold = 2.0
}

NarrativeData = NarrativeData or {}

OverwriteTableKeys( NarrativeData, {
	-- Hecate
	NPC_Hecate_01 =
	{
		InteractTextLinePriorities =
		{
			"HecateBathHouseEpilogue01",
			"HecatePostTrueEnding01",
			"HecatePostTrueEnding02",
			"HecatePostTrueEnding04",
			"HecatePostTrueEnding03",

			"NyxWithHecate01",
			"NemesisWithHecate02",

			"HecateAboutChronosBossEarlyL01",
			"HecateAboutChronosBossL01",
			"HecateAboutChronosBossL02",

			"HecateAboutStormStopNotCast01",

			-- true ending path

			-- Typhon Clear Final
			"HecateAboutTyphonDeath01",

			-- Chronos Clear 1
			"HecateAboutChronosBossW01",
			"HecateAboutChronosBossW01Cont1",
			-- Chronos Clear 2
			"HecateAboutChronosBossW02",

			-- Chronos Clear 3 (i.e. 4)
			"HecateAboutChronosBossW03",
			-- Chronos Clear 4 (i.e. 5)
			"HecateAboutTimeStop01",

			-- Chronos Clear 4_2 (i.e. 5)

			-- Chronos Clear 4_3 (i.e. 5)


			-- Chronos Clear 5 (i.e. 6)
			"HecateAboutChronosBossW04",
			"HecateAboutChronosBossW04_A",
			"HecateAboutChronosBossW04_B",
			"HecateAboutUltimateProgress04",

			-- Chronos Clear 2_5
			"HecateUnderworldRunCleared01",

			-- Typhon Clear 1
			"HecateAboutTyphonFight01_B",
			"HecateAboutTyphonFight01",
			"HecateAboutTyphonFight03_B",
			"HecateAboutTyphonFight02_B",
			-- Typhon Clear 2
			"HecateAboutTyphonFight03",
			"HecateAboutStormStop01",
			-- Typhon Clear 3
			"HecateAboutUltimateProgress01",
			"HecateAboutUltimateProgress03_A", -- requires HadesSpearPoints, higher-prio version of previous
			"HecateAboutUltimateProgress03", -- requires HadesSpearPoints
			"HecateAboutUltimateProgress02",
			"HecateAboutStormStop01_B",

			-- Other High-Priority Story
			"HecateAboutArachne04",

			-- Typhon Optional
			"HecateAboutTyphonFight02",
			"HecateAboutTyphonW02",
			"HecateAboutPalace01",

			"HecateGrantsWeaponUpgradeSystem01",
			"HecateGrantsShrineUpgrade01",
			"HecateGrantsBadgeSeller01",

			"HecateAboutPrometheus01",
			"HecateAboutPrometheusL01",
			"HecateAboutChronosAnomaly01",
			"HecateAboutChronos01",
			{
				"HecateAboutHades01",
				"HecateAboutHermes01",
				"HecateAboutHypnosWakeUp01",
				"HecateAboutTyphonAltFightW01",
			},
			{
				"HecateAboutFates01",
				"HecateAboutChronos02",
			},
			"HecateAboutArtemisSinging01",
			"HecateFirstMeeting_B",
			"HecateFirstMeeting",
			"HecateFirstMeetingCont1",
			"HecateFirstMeetingCont2",

			"MorosWithHecate01",

			"HecatePostEpilogue01",
			"HecatePostEpilogue02",

			-- immediate-contextual
			{
				"HecateAboutHades02",
			},
			{
				"HecateAboutBadgeProgress01",
				"HecateAboutQuestLog02",
				"HecateAboutQuestLog01",
				"HecateAboutSurface03",
				"HecateAboutSurface03_B",
				"HecateAboutSurfaceSurvival01",
				"HecateAboutSurfaceSurvival02",
			},
			{
				"HecateAboutCerberus01",
				"HecateAboutCerberus02",
				"HecateAboutErisFight01",
				"HecateAboutPrometheus02",
			},
			{
				"HecateGrantsFamiliars01",
			},
			{
				"HecateAboutArachne01",
			},
			{
				"HecateAboutChronosAnomaly02",
				"HecateAboutIcarus01",
			},
			{
				"HecateAboutZeus01",
			},
			{
				"HecateAboutMoros01",
				"HecateAboutArtemis01",
				"HecateAboutAthena01",
				"HecateAboutEris01",
			},
			{
				"HecateAboutChaos01",
			},
			{
				"HecateLostAgainstHer01",
				"HecateLostAgainstHer02",
				"HecateWonAgainstHer01",
				"HecateAboutOlympus01",
			},
			{
				"HecateAboutFamilyPortrait01",
				"HecateAboutArachne02",
				"HecateAboutArachne03",
				"HecateAboutArachne05",
				"ArachneWithHecateInHub02",
			},
			-- priority story
			{
				"HecateAboutSurface01",
				"HecateAboutSurfaceSurvival03",
			},
			{
				"HecateAboutTask01",
				"HecateAboutSurface02",
				"NemesisWithHecate01",
				"ErisWithHecate01",
				"HecateAboutPressure01",
				"HecateAboutHades01_B",
			},
			{
				"HecateAboutFamily02",
				"HecateAboutNemesis01",
			},
			{
				"ArachneWithHecateInHub01",
				"CharonWithHecate01",
				"SeleneWithHecate01",
				"OdysseusWithHecate01",
			},
			-- lower-priority contextual
			{
				"HecateAboutNightmares01",
			},
			{
				"HecateAboutCardUpgradeSystem01",
			},
			{
				"HecateAboutCirce01",
			},
			{
				"HecateAboutMedea01",
				"HecateAboutAltCauldron01",
				"HecateAboutAltCauldron02",
				"HecateAboutFamily01",
			},
			{
				"HecateAboutOceanus01",
				"HecateAboutThessaly01",
				"HecateAboutCodex02",
				"HecateAboutArcana01",
			},
			{
				"HecateAboutFamiliars03",
			},
			{
				"HecateAboutFamiliars01",
				"HecateAboutFamiliars02",
				"HecateAboutResources03",
				"HecateAboutResources03_B",
				"HecateAboutAspects01",
				"HecateAboutRelationships01",
				"HecateAboutBountyBoard01",
			},
			{
				"HecateAboutMedea02",
				"HecateAboutCirce02",
				"HecateAboutCodex01",
			},
			{
				"HecateAboutSelene01",
				"HecateAboutWeapons01",
				"HecateAboutResources01",
				"HecateAboutResources02",
				"HecateAboutShades01",
				"HecateAboutArcana02",
				"HecateAboutWitchcraft01",
				"HecateAboutCauldronWitchcraft01",
				"HecateAboutTorch01",
				"HecateAboutCosmetics01",
				"HecateAboutGarden01",
			},
			-- lower-priority story
			{
				"HecateAboutTask02",
				"OdysseusWithHecate02",
				"OdysseusWithHecate03",
				"IcarusWithHecate01",
				"HecateAboutCrossroads01",
			},
			-- evergreen
			{
				"HecateAboutWellness01",
				"HecateAboutBeasts01",
				"HecateAboutCauldron01",
			},
			"HecateAboutSayingLittle01",
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
			"HecateTaverna02",
			"HecateGift07",
			"HecateGift08",
			"HecateFishing02",
			"HecateFishingDecline01",
			"HecateBathHouseDecline01",
			"HecateTavernaDecline01",
		},

		SpecialGiftTrackHintId = "Codex_BondForgedHecate",
		SpecialGiftTrackHintRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" },
			},
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

			-- @ ending
			"PersephoneTrueEnding01",
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
			"HecateTaverna02",
			"HecateGift07",
			"HecateGift08",
			"HecateFishing02",
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
			"DoraAboutMemories01",
			"DoraAboutMemories02",
			"DoraAboutMemories03",
			"DoraAboutMemories04",
			"DoraAboutMemories05",

			"DoraAboutPrometheus02",

			"DoraPostTrueEnding01",
			"DoraPostTrueEnding02",
			"DoraPostEpilogue01",

			"DoraAboutChronosBossW01",
			"DoraAboutChronosBossW02",

			"DoraAboutNightmares01",

			"DoraFirstMeeting",
			"DoraAboutIcarusRelationship01",
			"DoraAboutPrometheus03",
			"DoraAboutPrometheus04",
			"DoraGrantsCosmeticsShop01",
			-- cosmetics-related
			{
				"DoraAboutShades01",
				"DoraListless01",
				"DoraListless02",
				"DoraListless03",
			},
			-- immediate-contextual
			{
				"DoraAboutPainting01",
			},
			{
				"DoraAboutOlympus01",
			},
			{
				"DoraAboutKeepsake01",
				"DoraAboutSurface01",
				"DoraAboutThessaly01",
				"DoraAboutOceanus01",
				"DoraAboutPackagedBounties01",
				"DoraAboutPrometheus01",
				"DoraAboutPrometheus01_B",
				"DoraAboutTyphon01",
				"DoraAboutTyphon01_B",
			},
			{
				"DoraAboutFields01",
				"DoraAboutHaunting03",
			},
			-- priority story
			{
				"DoraAboutChronos01",
				"DoraAboutMemoryQuest01",
			},
			{
				"DoraAboutHaunting04",
				"DoraRunProgress01",
			},
			{
				"DoraAboutTask01",
			},
			{
				"DoraAboutMoros01",
			},
			{
				"DoraAboutTask02",
				"DoraAboutTent02",
				"DoraAboutTent03",
			},
			{
				"DoraAboutTent01",
				"DoraAboutReturning01",
				"DoraAboutExisting01",
				"DoraAboutCosmetics04",
				"DoraAboutShades02",
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
				"DoraAboutCosmetics05",
				"DoraAboutShades03",
				"DoraAboutStatues01",
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
				"DoraWithMoros03",
				"DoraWithSkelly01",
				"DoraAboutShades04",
				"DoraAboutShades04_B",
				"DoraAboutFrinos01",
			},
			{
				"DoraAboutNemesis01",
				"DoraAboutHypnos01",
			},
			{
				"DoraAboutReturning02",
				"DoraAboutReturning03",
				"DoraAboutHaunting05",
			},
			{
				"DoraAboutHaunting02",
			},
			-- evergreen
			{
				"DoraAboutHaunting01",
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
			"DoraGift07",
			"DoraGift08",
			"DoraBathHouse03",
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
			"OdysseusAboutReturn01",
			"OdysseusLooseEndsQuestComplete01",
			"OdysseusPostTrueEnding01",

			"OdysseusHideAndSeek01",
			"OdysseusFirstMeeting",

			-- mission critical

			-- immediate-contextual
			"OdysseusAboutTyphonDeath01",
			"OdysseusAboutHecateKidnapped01",
			"OdysseusAboutPrometheusAltFight01",
			"OdysseusAboutChronosBossTactics01",
			"OdysseusAboutErisBossTactics01",
			"OdysseusAboutScyllaTactics01",

			"OdysseusPostTrueEnding02",
			"OdysseusLooseEndsQuest02",

			"OdysseusPostEpilogue01",

			"OdysseusAboutSurfaceThreat01",
			"OdysseusAboutTyphonL01",
			"OdysseusAboutTyphonW01",
			"OdysseusAboutTyphonW02",
			"OdysseusAboutTyphon01",
			"OdysseusAboutTyphon01_B",
			"OdysseusAboutChronosBossW01",
			"OdysseusAboutChronosBossL01",

			"OdysseusAboutUltimateProgress01",

			"OdysseusLooseEndsQuest01",

			"OdysseusAboutErisCurse01",
			"OdysseusAboutChronosAnomaly01",
			"OdysseusAboutChronos02",

			"OdysseusAboutPrometheus01",
			"OdysseusAboutTyphonMiniboss01",
			"OdysseusAboutTartarus01",
			"OdysseusAboutOlympus01",
			"OdysseusAboutScyllaAltFight01",
			"OdysseusAboutScylla04",

			"OdysseusGrantsPlantFMoly01_B",
			"OdysseusAboutHermes01",
			"OdysseusAboutPolyphemus02",
			"OdysseusAboutScyllaSong01",
			"OdysseusAboutSurface02",
			{
				"OdysseusAboutScylla01",
				"OdysseusAboutScylla02",
				"OdysseusAboutLosingToHecate01",
				"OdysseusAboutPolyphemus01",
				"OdysseusAboutTreant01",
				"OdysseusAboutFogEmitter01",
				"OdysseusAboutWaterUnitMiniboss01",
				"OdysseusAboutVerminMiniboss01",
				"OdysseusAboutOctofish01",
				"OdysseusAboutCharybdis01",
				"OdysseusAboutCerberus01",
				"OdysseusAboutCerberus01_B",
				"OdysseusAboutVampire01",
				"OdysseusAboutLamia01",
				"OdysseusAboutRatCatcher01",
				"OdysseusAboutGoldElemental01",
				"OdysseusAboutSatyrCrossbow01",
				"OdysseusAboutCharybdis02",
				"OdysseusAboutZombieCaptain01_B",
				"OdysseusAboutErisBoss01",
				"OdysseusAboutDragonMiniBoss01",
				"OdysseusAboutTalos01",
				"OdysseusAboutAthena01",
			},
			"OdysseusAboutAssistance01",
			"OdysseusAboutTable01",
			{
				"OdysseusAboutOceanus01",
				"OdysseusAboutFields01",
				"OdysseusAboutThessaly01",
			},
			{
				"OdysseusGrantsMetaCardPoints01",
				"OdysseusGrantsMemPointsCommon01_B",
				"OdysseusGrantsOreFSilver01",
				"OdysseusGrantsMetaFabric01_B",
			},
			{
				"OdysseusGrantsMetaCurrency01",
				"OdysseusGrantsGiftPoints01",
			},
			{
				"OdysseusGrantsPlantFMoly01",
				"OdysseusGrantsMemPointsCommon01",
				"OdysseusGrantsMetaFabric01",
				"OdysseusGrantsCardUpgradePoints01",
				"OdysseusGrantsFamiliarPoints01",
			},
			"OdysseusAboutMoros01",
			"OdysseusAboutMailbox01",
			"IcarusWithOdysseus01",
			"OdysseusAboutIcarus01",
			-- priority contextual
			{
				"OdysseusAboutPrometheus02",
				"OdysseusAboutPrometheus03",
			},
			{
				"OdysseusAboutCirce01",
				"OdysseusAboutCirce02",
			},
			{
				"OdysseusAboutScylla03",
				"OdysseusAboutPolyphemus03",
			},
			{
				"OdysseusAboutRunProgress01",
				"OdysseusAboutRunProgress02",
				"OdysseusAboutRunProgress03",
				"OdysseusAboutRunProgress04",
				"OdysseusPostEpilogue02",
				"OdysseusAboutHypnosWakeUp01",
			},
			{
				"OdysseusAboutNemesis01",
				"OdysseusAboutNemesis02",
				"OdysseusAboutBiomeMap01",
				"OdysseusAboutBiomeMap02",
				"OdysseusAboutTask01",
				"OdysseusAboutChronos01",
			},
			{
				"OdysseusAboutSurface01",
				"OdysseusAboutArtemis01",
			},
			{
				"OdysseusBackstory01",
				"OdysseusAboutPoseidon01",
			},
			{
				"OdysseusPostTrueEndingAboutHouse01",
				"OdysseusPostTrueEndingAboutTyphon01",
			},
			{
				"OdysseusAboutFamiliars01",
				"OdysseusAboutEris01",
			},


			{
				"OdysseusAboutCrossroads01",
				"OdysseusAboutMusicPlayer01",
				"OdysseusAboutGameStats01",
			},
			{
				"OdysseusAboutCosmetics01",
			},
			{
				"OdysseusAboutRain01",
				"OdysseusAboutHeracles01",
			},
			{
				"OdysseusAboutPrometheus01_B",
			},
			{
				"OdysseusAboutErebus01",
				"OdysseusAboutMountains01",
			},
			{
				"OdysseusAboutCosmetics02",
			},
			-- priority story
			{
				"OdysseusAboutHecate01",
				"OdysseusAboutMood01",
			},
			-- lower-priority contextual
			"IcarusWithOdysseus02",
			{
				"OdysseusAboutPressure02",
				"OdysseusAboutZombieCaptain01",
			},
			{
				"OdysseusGrantsSeedMystery01",
			},
			{
				"OdysseusAboutKeepsake01",
			},
			{
				"OdysseusBackstory02",
				"OdysseusBackstory02_B",
				"OdysseusAboutHypnos01",
				"OdysseusAboutPressure01",
				"OdysseusAboutGarden01",
				"OdysseusAboutVerminMiniboss01_B",
				"OdysseusAboutVampire01_B",
				"OdysseusAboutOctofish01_B",
				"OdysseusAboutCharybdis01_B",
				"OdysseusAboutTalos01_B",
				"OdysseusAboutDragonMiniBoss01_B",
				"OdysseusAboutTyphonMiniboss01_B",
			},
			{
				"OdysseusAboutScyllaSponsor01",
			},
			-- lower-priority story
			{
				"OdysseusAboutMailbox02",
			},
			{
				"MorosWithOdysseus01",
				"MorosWithOdysseus02",
				"MorosWithOdysseus03",
				"OdysseusWithHecate01",
				"OdysseusWithHecate02",
				"OdysseusWithHecate03",
				"OdysseusWithNemesis01",
				"OdysseusAboutTravel01",
			},
			{
				"OdysseusAboutAxe01",
				"OdysseusAboutBows01",
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
			"OdysseusGift07",
			"OdysseusTaverna02",
			"OdysseusGift08",
			"OdysseusFishing02",
			"OdysseusBathHouseDecline01",
		},
	},

	-- Hermes (In Person)
	NPC_Hermes_01 =
	{
		InteractTextLinePriorities =
		{
			"HermesFirstPickUp",

			-- @ remember to update 'special conversations' in NPCData_Hermes w/ any extras
			"HermesFieldAboutPalace03",
			"HermesFieldAboutTyphonDeath01",
			"HermesFieldAboutTyphon03",
			"HermesFieldAboutPalace02",

			"HermesFieldAboutTyphon01",
			"HermesFieldAboutTyphon02",
			"HermesFieldAboutPalace01",

			"HermesFieldAboutBusiness01",
			"HermesFieldAboutSurfaceShop01",
			"HermesFieldAboutCharon01",
			"HermesFieldAboutSupport01",
		},
		GiftTextLinePriorities =
		{
			"HermesFieldGiftDecline01",
		},
	},

	-- Nemesis
	NPC_Nemesis_01 =
	{
		InteractTextLinePriorities =
		{
			"NeoChronosWithNemesis01",
			"NemesisPostTrueEnding01",

			"NemesisPostEpilogue01",

			"NemesisPostTrueEndingTimeStopped01",
			"NemesisPostTrueEndingTimeStopped02",

			"NemesisWithHecate02",
			"NyxWithNemesis01",

			"NemesisPostTrueEnding02",

			"NemesisPostTrueEnding03",

			"NemesisAboutHecateKidnapped01",
			"NemesisAboutTyphonDeath01",

			"NemesisFirstMeeting",
			-- high-priority story
			"NemesisAboutRelationship01",
			"NemesisAboutRelationship01_B",
			-- high-priority contextual
			{
				"NemesisAboutHypnosWakeUp01",
				"NemesisAboutFamily02",
			},
			{
				"NemesisAboutTyphon01",
			},
			{
				"NemesisAboutChronosBossW01",
				"NemesisAboutChronosBossL02",
				"NemesisAboutPrometheus01",
				"NemesisAboutTyphonW01",
			},
			{
				"NemesisAboutErisFight01",
				"NemesisAboutChronosBossFights01",
			},
			{
				"NemesisAboutErisFightW01",
				"NemesisAboutChronosBossL01",
				"NemesisAboutCombatFailure01",
				"NemesisAboutTyphonW02",
			},
			{
				"NemesisAboutUltimateProgress01",
				"NemesisAboutSurface04",
			},
			{
				"NemesisAboutFieldMeeting01",
			},
			{
				"NemesisAboutFieldMeeting02",
			},
			{
				"NemesisAboutChronosNightmare01",
				"NemesisAboutChronosNightmare02",
				"NemesisAboutChronosNightmare02_B",
			},
			{
				"NemesisAboutMoros02",
			},
			{
				"NemesisAboutMoros01",
				"NemesisAboutEris01",
			},
			{
				"NemesisAboutFamily01",
				"NemesisAboutNectar02",
			},
			{
				"NemesisAboutNarcissus01",
				"NemesisAboutChaos01",
			},
			"NemesisAboutSurface03",
			{
				"NemesisAboutSurface01",
				"NemesisAboutSurface01_B",
			},
			{
				"NemesisAboutFates01",
			},
			{
				"NemesisAboutSurface02",
				"NemesisAboutDefeatingHecate01",
				"NemesisAboutLosingToHecate01",
				"NemesisAboutChronosBossL01_B",
			},
			{
				"NemesisAboutTask01",
			},
			{
				"NemesisAboutNyx02",
			},
			-- priority story
			{
				"NemesisWithMoros01",
				"NemesisAboutQuestLog01",
				"NemesisAboutTraining01",
				"NemesisAboutNyxRescue01",
				"NemesisAboutFamily03",
				"NemesisAboutErisFight02",
			},
			-- lower-priority contextual
			{
				"NemesisAboutHypnos01",
			},
			{
				"NemesisWithMorosAboutRelationships01",
			},
			{
				"NemesisAboutHecate01",
				"NemesisAboutHecate02",
				"NemesisAboutOdysseus01",
				"NemesisAboutArtemis02",
				"NemesisAboutFieldMeeting03"
			},
			{
				"NemesisAboutGoldenAge01",
				"NemesisAboutEvil01",
			},
			{
				"NemesisWithHypnos01",
			},
			{
				"NemesisAboutArtemisSinging01",
				"NemesisAboutThrone01",
			},
			{
				"NemesisAboutCauldron01",
				"NemesisAboutNectar01",
				"NemesisAboutArtemis01",
				"NemesisAboutNarcissus02",
				"NemesisAboutTrainingGrounds01",
				"NemesisAboutKeepsake01",
				"NemesisAboutTrophyQuest01",
			},
			-- lower priority story
			{
				"NemesisAboutTask04",
			},
			{
				"NemesisAboutNyx01",
				"NemesisAboutRelationship03",
				"NemesisWithEris01",
				"NemesisWithEris02",
				"NemesisWithHecate01",
			},
			{
				"OdysseusWithNemesis01",
				"NemesisWithMoros02",
				"NemesisWithIcarus01",
				"NemesisAboutMorosRelationship01",
				"NemesisAboutErisRelationship01",
				"NemesisAboutRelationship02",
			},
			{
				"NemesisAboutCharon01",
			},
			{
				"NemesisAboutTask03",
				"NemesisAboutTask02",
				"NemesisAboutEvil02",
				"NemesisAboutWeapons01",
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
			"NemesisGift06",
			"NemesisGift07",
			"NemesisGift08",
			"NemesisGift09",
			"NemesisBathHouse03",
			"NemesisGiftDecline01",
			"NemesisFishingDecline01",
			"NemesisBathHouseDecline01",
		},

		CombatIntroTextLinePriorities =
		{
			"NemesisCombatFirstIntro",
			"NemesisPreCombatBecomingCloser01",
		},

		PostCombatEventsPriorities =
		{
			"NemesisPostCombatFirstMeeting",
			"NemesisPostCombatPostTrueEnding01",
			"NemesisPostCombatAboutProgress01",
			"NemesisPostCombatAboutTartarus03",
			"NemesisPostCombatAboutTartarus02",
			{
				"NemesisPostCombatAboutCerberus01",
			},
			{
				"NemesisPostCombatAboutChronos01",
			},
			{
				"NemesisPostCombatAboutRelationship01",
				"NemesisPostCombatAboutRelationship02",
				"NemesisPostCombatBecomingCloser01",
			},
			{
				"NemesisPostCombatAboutTartarus01",
				"NemesisPostCombatAboutKeepsake01",
				"NemesisPostCombatAboutHecate01",
				"NemesisPostCombatAboutArtemis01",
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
			"MorosAboutRelationship03",
			"MorosAboutRelationship03_B",

			-- ending-sensitive
			"MorosPostEpilogue01",
			"MorosPostTrueEnding01",
			"MorosAboutHecateKidnapped01",
			"MorosAboutTyphonDeath01",
			"MorosPostTrueEnding02", -- epilogue

			"MorosAboutEpilogueProgress01", -- epilogue
			"MorosAboutPostEndingChronosBossW01",
			"MorosAboutPostEndingTyphonW01",
			"MorosPostEpilogue02",
			"MorosPostEpilogue03",

			"MorosFirstMeeting",
			"MorosAboutSurfacePenaltyCure01",
			"MorosAboutQuestLog01",
			"MorosAboutSearch01",
			"MorosAboutTask01",
			"MorosAboutFates02",
			"MorosAboutFates03",

			"MorosWithHecate01",

			-- immediate-contextual
			{
				"MorosAboutTyphon01",
			},
			{
				"MorosAboutTyphonW01",
			},
			{
				"MorosAboutTyphon02",
			},
			{
				"MorosAboutRelationship00",
			},
			{
				"MorosAboutSurfacePenaltyCure02",
				"MorosAboutChronosBossW01",
				"MorosAboutChronosBossW02",
				"MorosAboutEris02",
				"MorosAboutPrometheus01",
				"MorosAboutPrometheus02",
				"MorosAboutTyphon03",
			},
			{
				"MorosGrantsMixer6Common",
				"MorosAboutDoom03",
				"MorosAboutChaos02",
				"MorosAboutHypnos01",
			},
			{
				"MorosAboutEris01",
			},
			{
				"MorosGrantsHiddenAspect01",
				"MorosAboutHiddenAspect01",
			},
			-- priority story
			"MorosAboutQuestLog04",
			{
				"MorosAboutDoom01",
				"MorosAboutArrangement01",
				"MorosAboutArrangement02",
				"MorosAboutArrangement03",
				"MorosAboutRelationship04",
			},

			"NemesisWithMoros01",
			"MorosAboutOdysseus01",
			{
				"MorosAboutQuestLog02",
				"MorosAboutQuestLog03",
				"MorosAboutQuestLog06",
				"MorosAboutQuestLog07",
				"MorosAboutQuestLog08",
			},
			"MorosAboutForesight01",
			"MorosWithCharon01",

			-- lower-priority contextual
			{
				"NemesisWithMorosAboutRelationships01",
				"MorosAboutRelationships01",
			},
			{
				"MorosAboutChaos01",
				"MorosAboutKeepsake01",
				"MorosAboutReturning01",
			},
			{
				"MorosAboutBountyBoard01",
				"MorosAboutWeapons01",
				"MorosAboutMorosAspect01",
			},
			{
				"MorosAboutNemesis01",
				"MorosAboutArachne01",
				"MorosAboutRelationship01",
				"MorosAboutNyx01",
			},
			{
				"DoraWithMoros01",
				"MorosAboutForesight03",
				"MorosAboutDora01",
				"MorosAboutDoraMemories01",
				"MorosAboutRelationship02",
				"MorosAboutShrine01",
				"MorosAboutFates05",
				"MorosAboutNemesis02",
			},
			{
				"MorosAboutArtemisSinging01"
			},
			{
				"MorosWithCharon02",
			},
			-- lower-priority story
			{
				"MorosAboutFates01",
				"MorosAboutFates04",
			},
			{
				"MorosAboutCrossroads01",
				"MorosAboutDoom02",
			},
			{
				"MorosWithHypnos01",
			},
			{
				"DoraWithMoros02",
				"DoraWithMoros03",
				"NemesisWithMoros02",
				"MorosWithOdysseus01",
				"MorosWithOdysseus02",
				"MorosWithOdysseus03",
				"MorosWithEris01",
				"MorosWithEris02",
				"MorosWithIcarus01",
				"MorosAboutSearch02",
				"MorosAboutQuestLog05",
				"MorosAboutSkelly01",
				"MorosAboutDeath01",
			},
			-- evergreen
			{
				"MorosAboutRelatives01",
				"MorosAboutWitchcraft01",
			},
			{
				"MorosAboutForesight02",
				"MorosAboutDoom04",
				"MorosAboutWeaving01",
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
			"MorosGift06",
			"MorosGift07",
			"MorosGift08",
			"MorosGift09",
			"MorosTaverna02",
			"MorosBathHouse03",
			"MorosFishingDecline01",
			"MorosBathHouseDecline01",
		},
	},

	-- Hypnos (alts below)
	NPC_Hypnos_01 =
	{
		HideRelationshipBar = true,

		InteractTextLinePriorities =
		{
			"HypnosHideAndSeek01",

			"HypnosPostTrueEnding02",
			"HypnosPostTrueEnding01",
			"HypnosFirstMeeting",
			"HypnosAboutStoryReset01",
			"HypnosAboutUltimateProgress01",
			"HypnosAboutPoppies01",
			"HypnosAboutUltimateProgress02",

			"NemesisWithHypnos01",
			"MorosWithHypnos01",
		},

		GiftTextLinePriorities =
		{
			"HypnosWakeUp03", -- @ ending
			"HypnosWakeUp02",
			"HypnosWakeUp01",
			"HypnosGift01",
			"HypnosGift02",
		},
	},

	NPC_Hypnos_02 =
	{
		InteractTextLinePriorities =
		{
			"HypnosDreamMeeting01", -- from HypnosWakeUp01
			"HypnosDreamMeeting02", -- from HypnosWakeUp02
			"HypnosDreamMeeting03",
		},
		GiftTextLinePriorities =
		{
			"HypnosWakeUp02_B", -- from HypnosWakeUp02
			"HypnosWakeUp03_B", -- from HypnosWakeUp03
		},
	},
	NPC_Hypnos_03 =
	{
		InteractTextLinePriorities =
		{
			"HypnosDreamMeeting02_B",-- from HypnosWakeUp02
			"HypnosDreamMeeting03_B", -- from HypnosWakeUp03
		},
		GiftTextLinePriorities =
		{
			-- @ ending
			"HypnosWakeUp03_C", -- from HypnosWakeUp03
		},
	},
	-- @ ending
	NPC_Hypnos_04 =
	{
		InteractTextLinePriorities =
		{
			"HypnosFinalDreamMeeting01", -- HypnosWakeUp03
		},
		GiftTextLinePriorities =
		{
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

			"SkellyAboutHealthQuest03",
			"SkellyAboutHealthQuest04",

			"SkellyPostTrueEnding01",
			"SkellyPostTrueEnding02",

			"SkellyAboutZagreusFight01",

			"SkellyPostEpilogue01",

			"SkellyAboutChronosBossL01",

			"SkellyAboutUltimateProgress01",
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
			"SkellyAboutPast03",
			"SkellyAboutPast04",
			"SkellyAboutNotUsingShrine01",
			"SkellyAboutEarlyRunClear01",
			"SkellyAboutShrine01",
			"SkellyAboutChronosBossW03",
			"SkellyAboutChronosBossW02",
			"SkellyAboutChronosBossW01",
			"SkellyAboutTyphon01",
			"SkellyAboutTyphonW01",
			"SkellyAboutTyphon03",
			"SkellyAboutTyphon02",
			"SkellyAboutTyphonW02",
			"SkellyAboutZagreus01",
			"SkellyFirstMeeting",
			"SkellyAboutGodMode01",
			"SkellyAboutCatastrophe01",
			-- immediate-contextual
			{
				"SkellyAboutHealthQuest02",
			},
			{
				"SkellyAboutAspects01",
			},
			{
				"SkellyAboutSurface03",
			},
			{
				"SkellyAboutCerberus01",
				"SkellyAboutCerberus01B",
				"SkellyAboutPrometheus01",
				"SkellyAboutHades01",
			},
			{
				"SkellyAboutSurface01",
			},
			{
				"SkellyAboutRouteChoice01",
			},
			{
				"SkellyAboutSurface02",
				"SkellyAboutOceanus01",
				"SkellyAboutThessaly01",
				"SkellyAboutOlympus01",
				"SkellyAboutCerberus02",
			},
			-- high priority contextual
			{
				"SkellyAboutCardUpgradeSystem01",
				"SkellyAboutUnusedWeaponBonus01",
				"SkellyAboutFamiliars01",
				"SkellyAboutBountyBoard01",
				"SkellyAboutBounties01",
				"SkellyAboutBountyBoard02",
				"SkellyAboutHiddenDaggerAspect01",
			},
			{
				"SkellyAboutHealthQuest01",
			},
			{
				"SkellyHintProgress01",
			},
			{
				"SkellyAboutCharon01",
			},
			{
				"SkellyAboutKeepsake01",
				"SkellyAboutGiftRack01",
				"SkellyAboutGiftRack02",
			},
			-- priority story
			{
				"SkellyAboutHouse01",
				"SkellyAboutZagreus02",
				"SkellyAboutHealthQuest05",
			},
			-- lower-priority contextual
			{
				"SkellyAboutExorcismBook01",
				"SkellyAboutAltar01",
				"SkellyAboutShrine02",
				"SkellyAboutShrine03",
				"SkellyAboutShrine04",
			},
			"SkellyHintChoices01",
			"SkellyHintDash01",
			"SkellyHintDamage01",
			"SkellyHintGrasp01",
			"SkellyHintResources02",
			"SkellyHintMana01",
			"SkellyHintMetaCardPoints01",
			"SkellyHintCast01",
			"SkellyHintArmor01",
			"SkellyHintCast02",
			"SkellyHintRoomRewards01",
			"SkellyAboutStaff01",
			"SkellyHintBones01",
			"SkellyHintSpellDrop01",
			"SkellyHintShadeMercs01",
			"SkellyAboutChatting01",
			{
				"SkellyAboutDagger01",
				"SkellyAboutAxe01",
				"SkellyAboutTorch01",
				"SkellyAboutLob01",
				"SkellyAboutSuit01",
			},
			{
				"SkellyHintWeapons01",
			},
			{
				"SkellyHintDying01",
				"SkellyHintSprint01",
			},
			"SkellyHintResources01",
			"SkellyAboutOceanus02",
			-- ending-sensitive
			{
				"SkellyAboutEmotions01",
			},
			{
				"SkellyAboutTraining02",
			},
			{
				"SkellyAboutDying01",
			},

			-- lower-priority story
			{
				"SkellyAboutPast02",
				"SkellyAboutPast01",
			},
			{
				"SkellyAboutCharon02",
				"DoraWithSkelly01",
			},
			-- evergreen
			{
				"SkellyAboutBeatings01",
				"SkellyAboutCosmetics01",
			},
			{
				"SkellyAboutTraining01",
				"SkellyAboutTask01",
			},
			"SkellyAboutSayingLittle01",
		},

		GiftTextLinePriorities =
		{
			"SkellyGift01",
			"SkellyGift02",
			"SkellyGift03",
			"SkellyGift04",
			"SkellyGift05",
			"SkellyGift06",
			"SkellyGift07",
			"SkellyGift08",
			"SkellyGift09",
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

			"ArachneCurseQuestComplete01",
			"ArachneAboutCurseQuest01",

			"ArachneAboutOutfits01",

			"HecateWithArachne01_FollowUp",
			"ArachneAboutCurse05",

			"ArachneCurseQuest01",

			"ArachneAboutCurse06",

			"ArachnePostTrueEnding01",

			-- immediate-contextual
			"ArachneAboutCurse03",
			{
				"ArachneAboutRelationship02",
			},
			{
				"ArachneAboutFrogFamiliar01",
			},
			{
				"ArachneAboutUltimateProgress01",
				"ArachnePostEpilogue01",
				"ArachnePostEpilogue02",
			},
			{
				"ArachneGrantsReward01"
			},
			{
				"ArachneAboutGods01",
			},
			{
				"ArachneAboutGods02",
				"ArachneAboutGods03",
				"ArachneAboutGods04",
				"ArachneAboutGods05",
			},
			{
				"ArachneAboutPride01",
				"ArachneAboutRelationship01",
			},
			{
				"ArachneAboutCurse01",
				"ArachneAboutCurse02",
				"ArachneAboutCurse04",
			},
			{
				"ArachneLowHealth01",
			},
			{
				"ArachnePostTrueEnding02",
			},
			{
				"ArachneAboutRelationship03",
				"ArachneAboutRelationship04",
			},
			{
				"ArachneAboutHecate01",
			},
			{
				"ArachneAboutArtemis01",
			},
			{
				"ArachneAboutKeepsake01",
			},
			{
				"ArachneAboutSelf01",
			},
			{
				"ArachneAboutGods06",
				"ArachneAboutGods06_B",
			},
			-- priority story
			{
				"ArachneAboutHecate02",
			},
			{
				"ArachneAboutSilk01",
				"ArachneAboutCocoons01",
				"ArachneAboutCocoons02",
				"ArachneAboutSelf02",
			},
			-- lower priority contextual
			{
				"ArachneAboutCharon01",
				"ArachneAboutSurface01",
				"ArachneAboutOceanus01",
				"ArachneAboutCatFamiliar01",
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
				"ArachneAboutQuiet01",
			},
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
			},
			"ArachneAboutSayingLittle01",
		},

		GiftTextLinePriorities =
		{
			"ArachneGift01",
			"ArachneGift02",
			"ArachneGift03",
			"ArachneGift04",
			"ArachneGift05",
			"ArachneGift06",
			"ArachneGift07",
			"ArachneGift08",
			"ArachneGift09",
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
			"ArachneGift07",
			"ArachneGift08",
			"ArachneGift09",
		},
	},

	-- Artemis; _Field version below
	NPC_Artemis_01 =
	{
		InteractTextLinePriorities =
		{
			-- home events
			"ArtemisHubFirstMeeting01",
			"ArtemisHubSingingEndTheme01",
			"ArtemisHubAboutChronosBoss01",
			"ArtemisHubSingingAboutRecordKeeper01",
			"ArtemisHubSinging01",
			"ArtemisHubSinging02",
			"ArtemisHubSinging03",
			"ArtemisHubSinging04",
		},

		GiftTextLinePriorities =
		{
			"ArtemisGift01",
			"ArtemisGift02",
			"ArtemisGift03",
			"ArtemisGift04",
			"ArtemisGift05",
			"ArtemisGift06",
			"ArtemisGift07",
			"ArtemisGift08",
			"ArtemisGift09",
			"ArtemisGift10",
		},
	},

	-- Artemis Field
	NPC_Artemis_Field_01 =
	{
		InheritFrom = { "NPC_Artemis_01" },

		InteractTextLinePriorities =
		{
			-- field events
			"ArtemisFirstMeeting",

			-- mission critical
			"ArtemisPostTrueEnding01",
			"ArtemisPostEpilogue01",
			"ArtemisAboutApollo01",

			-- immediate-contextual
			"ArtemisAboutEphyra01",
			"ArtemisAboutEphyra01_B",

			"ArtemisAboutChronosBossW01",
			"ArtemisAboutChronosBossW02",
			"ArtemisAboutTyphon01",
			"ArtemisAboutTyphon02",
			"ArtemisAboutTyphon03",

			"ArtemisGrantsHiddenAspect01",
			"ArtemisAboutChronosBossL01",
			"ArtemisAboutZagreus01",
			"ArtemisAboutPrometheus01",


			"ArtemisAboutFates01",
			"ArtemisAboutHermes01",

			"ArtemisAboutSurfacePenalty01",

			"ArtemisAboutHecate01",

			-- priority contextual
			"ArtemisAboutHiddenAspect01",

			"ArtemisGrantsReward01",
			"ArtemisAboutTeamwork01",
			"ArtemisPostTrueEnding02",
			"ArtemisAboutAmbrosia01",

			"ArtemisAboutSurface01",
			"ArtemisAboutOceanus01",

			"ArtemisAboutPolyphemus01",
			"ArtemisAboutEris01",
			"ArtemisAboutPrometheus02",
			"ArtemisAboutPrometheus03",

			-- priority story
			"ArtemisAboutMoros01",
			"ArtemisAboutMission01",
			"ArtemisAboutChronos01",
			"ArtemisAboutSelene01",
			"ArtemisAboutSelene01_B",
			"ArtemisAboutErebus01",

			-- lower priority contextual
			{
				"ArtemisAboutArtemisAspect01",
				"ArtemisAboutKeepsake01",
				"ArtemisAboutKeepsake02",
				"ArtemisAboutFamiliars01",
			},
			"ArtemisAboutAthena01",
			"ArtemisAboutSinging01",
			"ArtemisAboutNemesis01",

			"ArtemisAboutShrine01",
			"ArtemisAboutShrine02",

			"ArtemisAboutRetrying01",
			"ArtemisAboutHiddenAspect02",
			{
				"ArtemisLowHealth01",
				"ArtemisLowHealth02",
				"ArtemisLowHealth03",
				"ArtemisLowHealth04",
			},
			"ArtemisAboutHeracles01",
			"ArtemisAboutDagger01",

			"ArtemisAboutMission02",
			"ArtemisAboutChronosBossL01_B",

			"ArtemisAboutNemesis02",
			"ArtemisAboutNemesis03",
			"ArtemisAboutBoons01",
			"ArtemisAboutTimePassing01",
			"ArtemisAboutProgress01",

			-- evergreen
			"ArtemisAboutFamily02",
			"ArtemisAboutSilverSisters01",
			"ArtemisAboutFamily01",
			"ArtemisAboutCharon01",
			"ArtemisAboutMoon01",
			"ArtemisSendOff01",
			"ArtemisAboutSayingLittle01",
		},
	},

	-- Hades
	NPC_Hades_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"HadesWithPersephone01",

			"HadesWithPersephonePostEpilogue01",

			"HadesWithPersephoneAboutChamber01",

			"HadesWithPersephonePostEpilogue03",
			
			"HadesWithPersephone02",
			"HadesWithPersephone03",

			"HadesFirstMeeting_C",
			"HadesFirstMeeting_B",
			"HadesFirstMeeting",

			-- immediate-contextual
			{
				"HadesAboutBouldy01",
				"HadesAboutBouldy01_B",
			},
			{
				"HadesAboutPersephoneAway01",
			},
			"HadesAboutChronosBossW01_B",
			"HadesAboutChronosBossW01",
			{
				"HadesAboutChronosNightmare01",
				"HadesAboutStoryReset01",
			},
			-- priority story
			"HadesMeeting02",
			{
				"HadesAboutTyphon01",
				"HadesAboutTyphon01_B",
			},
			"HadesAboutUltimateProgress03",
			"HadesAboutUltimateProgress02",
			"HadesAboutUltimateProgress01",

			"HadesAboutNemesis01",
			"HadesMeeting03",
			{
				"HadesAboutCerberus01",
				"HadesAboutSurface01",
			},
			-- priority contextual
			{
				"HadesAboutPersephoneAspect01",
				"HadesAboutCharon01",
				"HadesWithPersephoneAboutHypnosWakeUp01",
			},
			"HadesWithPersephoneAboutPersephoneAspect02",
			"HadesWithPersephoneAboutPersephoneAspect01",
			"HadesWithPersephoneAboutNyxAspect01",
			"HadesWithPersephoneAboutZagreusFight01",
			"HadesWithPersephoneAboutZagreusFight02",
			"HadesAboutNeoChronos01",
			"HadesAboutNeoChronos02",
			"HadesWithPersephoneAboutLegions01",
			"HadesWithPersephoneAboutAchilles01",
			"HadesWithPersephoneAboutAltChildhood01",
			"HadesWithPersephoneAboutBlessings01",
			"HadesWithPersephoneAboutUnseen01",
			"HadesWithPersephoneAboutCerberus01",
			"HadesWithPersephoneAboutBackstory01",
			"HadesWithPersephonePostEpilogue02",
			"HadesWithPersephoneAboutDemeter01",
			"HadesWithPersephoneAboutRenovations01",
			{
				"HadesAboutTyphon03",
				"HadesAboutTyphon04",
				"HadesAboutFamily01",
				"HadesAboutPrometheus01",
			},
			{
				"HadesAboutHecate01",
			},
			{
				"HadesAboutZagreus01",
				"HadesAboutBrothers01",
				"HadesAboutCerberus02",
				"HadesAboutPain01",
				"HadesAboutPersephone01",
			},
			{
				"HadesAboutChronosAllies01",
				"HadesAboutNyx01",
				"HadesAboutHouse01",
			},
			-- lower-priority contextual
			{
				"HadesAboutTyphon02",
				"HadesAboutBouldy02",
			},
			-- not true-ending dependent
			{
				"HadesAboutAutomatons01",
				"HadesAboutHoundFamiliar01",
			},
			{
				"HadesAboutShrine01",
				"HadesAboutAres01",
				"HadesAboutAres01_B",
			},
			-- lower-priority story
			{
				"HadesAboutMelinoe01",
			},
			{
				"HadesAboutSisyphus01",
				"HadesAboutSisyphus01_B",
			},
			-- evergreen
			{
				"HadesWithPersephoneAboutGreeting01",
				"HadesWithPersephoneAboutKeepsake01",
			},
		},

		GiftTextLinePriorities =
		{
			"HadesGiftDecline01",
			"HadesWithPersephoneGift01",
			"HadesWithPersephoneGift02",
			"HadesWithPersephoneGift03",
			"HadesWithPersephoneGift04",
			"HadesWithPersephoneGift05",
			"HadesWithPersephoneGift06",
		},
	},

	-- @ ending
	NPC_Hades_02 =
	{
		InteractTextLinePriorities =
		{
			"HadesHideAndSeek01",
			"HadesTrueEnding01",
		},
	},

	-- Persephone
	NPC_Persephone_01 =
	{
		InteractTextLinePriorities =
		{
			"PersephoneTrueEnding01",

			"HadesWithPersephonePostEpilogue01",
			"HadesWithPersephonePostEpilogue03",

			"HadesWithPersephone01",
			"HadesWithPersephone02",
			"HadesWithPersephone03",

			"HadesWithPersephoneAboutHypnosWakeUp01",
			"HadesWithPersephoneAboutZagreusFight01",
			"HadesWithPersephoneAboutZagreusFight02",
			"HadesWithPersephoneAboutLegions01",
			"HadesWithPersephoneAboutAchilles01",
			"HadesWithPersephoneAboutAltChildhood01",
			"HadesWithPersephoneAboutBlessings01",
			"HadesWithPersephoneAboutUnseen01",
			"HadesWithPersephoneAboutPersephoneAspect02",
			"HadesWithPersephoneAboutPersephoneAspect01",
			"HadesWithPersephoneAboutNyxAspect01",
			"HadesWithPersephoneAboutCerberus01",
			"HadesWithPersephoneAboutBackstory01",
			"HadesWithPersephonePostEpilogue02",
			"HadesWithPersephoneAboutDemeter01",
			"HadesWithPersephoneAboutRenovations01",
			"HadesWithPersephoneAboutGreeting01",
			"HadesWithPersephoneAboutKeepsake01",
			"HadesWithPersephoneAboutChamber01",
		},

		GiftTextLinePriorities = {},
		GiftTrackEntryName = "NPC_Hades_Field_01",
		SpecialGiftTrackHintRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift06" }
			},
		},
		SpecialGiftTrackHintId = "Codex_BondForgedPersephoneAlt",
	},

	-- Selene
	SpellDrop =
	{
		InteractTextLinePriorities =
		{
			"SeleneFirstPickUp",
			-- mission critical
			{
				"SeleneAboutBountyBoard01_B",
			},
			{
				"SeleneAboutPackageBounty02",
			},
			{
				"SelenePostTrueEnding01",
				"SelenePostEpilogue01",
			},
			{
				"SeleneAboutSurfaceCurse01",
			},
			{
				"SeleneAboutHiddenAspectProgress01",
			},
			{
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
				"SeleneAboutTyphon01",
			},
			{
				"SeleneGrantsOlympianDuos01"
			},
			{
				"SeleneGrantsHiddenAspect01",
			},
			{
				"SeleneAboutSeleneAspect03",
			},
			-- immediate-contextual
			{
				"SeleneAboutTyphonW01",
				"SeleneRunCleared02",
				"SeleneRunCleared03",
			},
			"SeleneAboutAltFightQuest06",
			"SeleneAboutAltFightQuest05",
			"SeleneAboutAltFightQuest04",
			"SeleneAboutAltFightQuest03",
			"SeleneAboutAltFightQuestL01",
			"SeleneAboutAltFightQuest01",
			"SeleneAboutAltFightQuest02",
			{
				"SeleneAboutSurface01",
				"SeleneAboutSurface01_B",
				"SeleneAboutTyphonW02",
			},
			{
				"SelenePackageBountyIntro01",
			},
			{
				"SeleneAboutSeleneAspect01",
				"SeleneAboutHiddenAspect01",
			},
			{
				"SeleneLootBought05",
			},
			{
				"SeleneLootBought01",
				"SeleneLootBought02",
				"SeleneLootBought03",
				"SeleneLootBought04",
			},
			{
				"SeleneAboutObscurity01",
			},
			{
				"SeleneAboutAllSelene01",
			},
			{
				"SelenePostTrueEnding02",
			},
			{
				"SeleneAboutTyphon02",
			},
			{
				"SeleneSurfaceRunCleared01"
			},
			{
				"SelenePostTrueEndingRunCleared01",
				"SelenePostTrueEndingRunCleared02"
			},
			{
				"SeleneAboutFates01",
				"SeleneAboutShrineComplete01",
			},
			{
				"SeleneAboutOceanus01",
				"SeleneAboutFields01",
				"SeleneAboutThessaly01",
			},
			{
				"SeleneAboutMagick01",
			},

			-- priority story
			{
				"SeleneAboutNyxReturn01",
				"SelenePostTrueEnding03",
				"SeleneAboutMission01",
				"SeleneAboutChronos01",
				"SeleneAboutTask01",
				"SeleneAboutOlympus01",
				"SeleneBackstory01",
			},
			-- health
			{
				"SeleneLowHealth01",
				"SeleneLowHealth02",
				"SeleneLowHealth03",
				"SeleneLowHealth04",
			},
			{
				"SeleneAboutGoodChronos01",
				"SeleneAboutErebus01",
				"SeleneAboutPersephone01",
			},
			-- priority contextual
			{
				"SeleneAboutSuit01",
				"SeleneAboutLob01",
				"SeleneAboutNyxAspect01",
				"SeleneAboutHiddenAspects01",
				"SeleneAboutPrometheus03",
			},
			{
				"SeleneAboutSwitchToSurface01",
				"SeleneAboutRandomBounties01",
				"SeleneRunSwitchPostClear01",
				"SeleneRunSwitchPostClear02",
				"SeleneRunSwitchPostLoss01",
			},
			{
				"SeleneAboutHecate02",
				"SeleneAboutKeepsake01",
				"SeleneAboutKeepsake04",
				"SeleneAboutTalentDrop01",
				"SeleneAboutSeleneAspect02",
			},
			{
				"SeleneRunCleared01",
			},
			{
				"SeleneAboutNyx01",
			},
			{
				"SeleneAboutNyx03",
				"SeleneAboutNyx03_B",
			},
			{
				"SeleneAboutPrometheus01",
			},
			{
				"SeleneAboutEris01",
				"SeleneAboutPrometheus02",
				"SeleneAboutHeracles01",
				"SeleneAboutDemeter01",
				"SeleneAboutHypnosWakeUp01",
			},
			{
				"SeleneAboutPolyphemus01",
				"SeleneAboutPolyphemus02",
			},
			{
				"SeleneAboutHestia01",
				"SeleneAboutShrine01",
				"SeleneAboutShrine02",
				"SeleneAboutShrine03",
				"SeleneAboutKeepsake02",
				"SeleneAboutKeepsake03",
				"SeleneAboutEosAspect01",
				"SeleneAboutCardUpgradePoints01",
			},
			{
				"SeleneAboutSilverSisters01",
			},
			-- about other gods
			{
				"SeleneAboutZeus01",
				"SeleneAboutHera01",
				"SeleneAboutPoseidon01",
				"SeleneAboutApollo01",
				"SeleneAboutAphrodite01",
				"SeleneAboutHephaestus01",
				"SeleneAboutAres01",
				"SeleneAboutHermes01",
				"SeleneAboutEris02",
			},
			-- lower-priority contextual
			{
				"SeleneAboutSurface02",
				"SeleneAboutSurface03",
				"SeleneAboutSteeds03",
				"SeleneAboutBountyBoard01",
			},
			{
				"SeleneAboutEos01",
			},
			{
				"SeleneAboutHeracles02",
				"SeleneAboutMedea01",
				"SeleneAboutCirce01",
				"SeleneAboutIcarus01",
				"SeleneAboutHexes02",
				"SeleneAboutChaos01",
			},
			{
				"SeleneAboutDagger01",
				"SeleneAboutTorch01",
				"SeleneAboutAxe01",
			},
			{
				"SeleneAboutArcana01",
			},
			-- lower-priority story
			{
				"SeleneAboutNyx02",
			},
			{
				"SelenePostGift01",
				"SeleneAboutNemesis01",
				"SeleneAboutNemesis02",
				"SeleneAboutMoros01",
				"SeleneAboutHypnos01",
				"SeleneAboutOdysseus01",
			},
			{
				"SeleneAboutLunarCycle02",
				"SeleneAboutOlympus02",
				"SeleneAboutHecate01",
			},
			{
				"SeleneAboutSwitchToSurface02",
				"SeleneAboutSwitchToUnderworld01",
			},
			{
				"SeleneRunStartIntro01",
				"SeleneAboutWinStreak01",
			},
			{
				"SeleneRunStart01",
				"SeleneRunStart02",
				"SeleneRunStart03",
				"SeleneRunStart04",
			},

			-- evergreen
			{
				"SeleneAboutPhases01",
			},
			{
				"SeleneAboutSteeds02",
			},
			{
				"SeleneAboutLunarCycle01",
				"SeleneAboutSteeds01",
				"SeleneAboutHecate03",
				"SeleneAboutMagick02",
				"SeleneAboutHexes01",
				"SeleneAboutPhases02",
				"SeleneAboutDarkness01",
				"SeleneAboutSpeech01",
				"SeleneAboutNewMoon01",
				"SeleneAboutMortals01",
			},
			{
				"SeleneAboutHelios01",
			},
			"SeleneAboutSayingLittle01",
		},

		GiftTextLinePriorities =
		{
			"SeleneGift01",
			"SeleneGift02",
			"SeleneGift03",
			"SeleneGift04",
			"SeleneGift05",
			"SeleneGift06",
			"SeleneGift07",
			"SeleneGift08",
			"SeleneGift09",
		},
	},

	NPC_Selene_01 =
	{
		InteractTextLinePriorities =
		{
			"SeleneWithHecate01",
			"SeleneHome01",

			-- @ ending
			"SeleneTrueEnding01",
		},
	},

	-- Zeus
	ZeusUpgrade =
	{
		InteractTextLinePriorities =
		{
			"ZeusPostEpilogue01",
			"ZeusPostEpilogue02",

			"ZeusPostTrueEnding01",
			"ZeusPostTrueEnding02",
			"ZeusPostTrueEnding03",
			"ZeusAboutFuture01",
			"ZeusAboutTyphonW04",
			"ZeusAboutSurfaceThreat02",

			"ZeusFirstPickUp",
			-- immediate-contextual
			{
				"ZeusAboutSurfaceNoCure01",
				"ZeusAboutSurfaceNoCure02",
				"ZeusAboutSurface01",
				"ZeusPackageBountyIntro01",
				"ZeusPackageBountyIntro02",
			},
			-- high-priority contextual
			{
				"ZeusAboutKeepsake01",
			},
			{
				"ZeusAboutHades02",
			},
			{
				"ZeusAboutTyphon01",
			},
			{
				"ZeusAboutTyphonW01",
				"ZeusAboutTyphonL01",
			},
			{
				"ZeusAboutTyphonW02",
				"ZeusAboutTyphonW03",
			},
			{
				"ZeusAboutOlympus02",
				"ZeusAboutOceanus01",
				"ZeusAboutTyphon02",
				"ZeusAboutTyphon03",
			},
			{
				"ZeusAboutSurface02",
			},
			{
				"ZeusUnderworldRunCleared02",
			},
			{
				"ZeusUnderworldRunCleared03",
				"ZeusUnderworldRunCleared04",
			},
			{
				"ZeusAboutPrometheus01",
				"ZeusAboutPrometheus03",
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

			-- priority contextual
			{
				"ZeusAboutRouteChoice01",
			},
			{
				"ZeusAboutPolyphemus01",
				"ZeusAboutEris01",
				"ZeusAboutPrometheus02",
				"ZeusAboutDevotionTests02",
			},
			{
				"ZeusSurfaceRunStart01",
				"ZeusUnderworldRunStart01",
			},
			{
				"ZeusSurfaceRunStart02",
			},
			{
				"ZeusRunStartPostSurfaceW01",
				"ZeusRunStartPostUnderworldW01",

				"ZeusRunStart01",
				"ZeusRunStart02",
				"ZeusRunStart03",
				"ZeusRunStart04",
				"ZeusPostGift01",
			},
			{
				"ZeusAboutSurface04",
				"ZeusAboutSurfaceThreat01",
			},
			-- health
			{
				"ZeusLowHealth01",
				"ZeusLowHealth02",
				"ZeusLowHealth03",
				"ZeusLowHealth04",
			},
			{
				"ZeusAboutSurface05",
			},
			-- legendary
			{
				"ZeusLegendaryPickUp02",
			},
			{
				"ZeusAboutHecate01",
				"ZeusAboutHecate02",
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
			-- lower-priority story
			{
				"ZeusAboutAres01",
			},
			{
				"ZeusAboutAthena01",
			},
			{
				"ZeusAboutMelinoe01",
				"ZeusAboutZagreus01",
			},
			{
				"ZeusAboutHades01",
				"ZeusAboutChronos01",
				"ZeusAboutChronos03",
				"ZeusAboutChronosClockwork01",
			},
			{
				"ZeusAboutChaos01",
			},
			{
				"ZeusAboutHeracles01",
				"ZeusAboutHeracles02",
			},
			{
				"ZeusAboutMelinoe02",
				"ZeusPostEpilogue03",
				"ZeusAboutHades03",
				"ZeusAboutHades04",
				"ZeusAboutChronos02",
				"ZeusAboutChronos04",
				"ZeusAboutMortals01",
			},
			-- lower-priority contextual
			{
				"ZeusUnderworldRunCleared01",
				"ZeusSurfaceRunCleared01",
			},
			{
				"ZeusAboutRandomBounties01",
			},
			{
				"ZeusAboutOlympians01",
				"ZeusAboutArtemis01",
				"ZeusAboutMortals02",
				"ZeusAboutWeapons01",
				"ZeusAboutStorms01",
				"ZeusAboutPolyphemus02",
			},
			{
				"ZeusAboutMortals03",
			},
			{
				"ZeusAboutKeepsake02",
				"ZeusLegendaryPickUp01",
				"ZeusAboutOceanus02",
				"ZeusAboutTartarus01",
				"ZeusAboutThessaly01",
				"ZeusAboutOlympus03",
			},
			{
				"ZeusAboutPackageBounty01",
				"ZeusAboutShrine01",
				"ZeusAboutShrine02",
			},
			{
				"ZeusAboutNemesis01",
			},
			-- evergreen
			{
				"ZeusPostGift02",
				"ZeusAboutErebus01",
				"ZeusAboutOlympus01",
				"ZeusAboutDionysus01",
				"ZeusAboutDionysus02",
			},
		},

		BoughtTextLinePriorities =
		{
			"ZeusLootBought05",
			{
				"ZeusBlindBox01",
				"ZeusBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"ZeusGift01",
			"ZeusGift02",
			"ZeusGift03",
			"ZeusGift04",
			"ZeusGift05",
			"ZeusGift06",
			"ZeusGift07",
		},
	},

	-- Poseidon
	PoseidonUpgrade =
	{
		InteractTextLinePriorities =
		{
			"PoseidonFirstPickUp",
			-- immediate-contextual
			"PoseidonPostTrueEnding01",
			"PoseidonPostEpilogue01",
			"PoseidonPostEpilogue02",
			"PoseidonAboutTyphonDeath01",
			"PoseidonAboutPalace01",
			{
				"PoseidonAboutPackageBounty01",
				"PoseidonAboutPackageBounty02",
				"PoseidonAboutOlympus01",
			},
			{
				"PoseidonDevotionIntro01",
				"PoseidonAboutSurfaceThreat01",
				"PoseidonAboutSurfaceThreat02",
				"PoseidonAboutSurfaceHelp01",
			},
			{
				"PoseidonPostTrueEnding02",
				"PoseidonAboutTyphon01",
			},
			{
				"PoseidonAboutFindingHades01_B",
				"PoseidonAboutFates01",
			},
			{
				"PoseidonUnderworldRunCleared01",
				"PoseidonUnderworldRunCleared02",
				"PoseidonUnderworldRunCleared03",
				"PoseidonSurfaceRunCleared01",
				"PoseidonSurfaceRunCleared02",
				"PoseidonAboutTyphonL01",
				"PoseidonAboutTyphonL02",
				"PoseidonAboutTyphonL03",
				"PoseidonWinStreak01",
			},
			{
				"PoseidonAboutChronosPlan01",
			},
			{
				"PoseidonAboutInFighting01",
			},
			{
				"PoseidonSurfaceRunStartPostUnderworldL01",
				"PoseidonSurfaceRunStartPostUnderworldW01",
				"PoseidonUnderworldRunStartPostSurfaceL01",
			},
			{
				"PoseidonAboutKeepsake02",
				"PoseidonAboutKeepsake03",
				"PoseidonAboutZeusKeepsake01",
			},
			{
				"PoseidonAboutTyphon03",
				"PoseidonAboutTyphon02",
			},
			{
				"PoseidonAboutSurface01",
				"PoseidonAboutSurface03",
				"PoseidonAboutAutomatons01",
			},
			{
				"PoseidonAboutSurface04",
				"PoseidonAboutOceanus01",
				"PoseidonAboutFields01",
				"PoseidonAboutThessaly01",
				"PoseidonAboutThessaly02",
				"PoseidonAboutThessaly03",
			},
			{
				"PoseidonAboutOlympus02",
			},
			-- priority story
			{
				"PoseidonAboutChronos01",
			},
			{
				"PoseidonAboutHades01",
				"PoseidonAboutHades03",
			},
			{
				"PoseidonAboutMelinoe02",
			},
			{
				"PoseidonAboutApollo01",
			},
			{
				"PoseidonAboutFamily01",
				"PoseidonAboutPalace02",
			},
			{
				"PoseidonLegacyBoonIntro01",
				"PoseidonAboutZagreus02",
			},
			{
				"PoseidonAboutAres01",
				"PoseidonAboutAthena01",
			},
			{
				"PoseidonAboutLittleHades01",
			},
			-- priority contextual
			{
				"PoseidonLegendaryPickUp01",
			},
			{
				"PoseidonAboutFishing01",
				"PoseidonAboutFindingHades01",
				"PoseidonAboutFishingQuest01",
				"PoseidonAboutFishingQuest02",
			},
			{
				"PoseidonAboutHadesReturn01",
				"PoseidonAboutThessaly05",
				"PoseidonAboutOlympus05",
				"PoseidonAboutTyphon04",
			},
			{
				"PoseidonAboutNeoChronos01",
				"PoseidonAboutPolyphemus01",
				"PoseidonAboutPolyphemus03",
				"PoseidonAboutPrometheus02",
				"PoseidonAboutArtemis01",
				"PoseidonAboutScylla01",
			},
			-- health
			{
				"PoseidonLowHealth02",
			},
			-- lower-priority contextual
			{
				"PoseidonAboutChronos02",
			},
			{
				"PoseidonAboutChronos03",
				"PoseidonAboutChronos04",
				"PoseidonAboutChronos05",
				"PoseidonAboutChronos06",
			},
			{
				"PoseidonAboutFishing04",
			},
			{
				"PoseidonAboutCharybdis01",
				"PoseidonAboutFortress01",
				"PoseidonAboutZagreus01",
			},
			{
				"PoseidonAboutStalemate01",
				"PoseidonAboutVengeance01",
			},
			{
				"PoseidonAboutStorms01",
			},
			{
				"PoseidonAboutShrine01",
				"PoseidonAboutShrine02",
			},
			{
				"PoseidonAboutScylla02",
				"PoseidonAboutEris01",
				"PoseidonAboutPrometheus01",
				"PoseidonAboutNemesis01",
				"PoseidonAboutHeracles01",
				"PoseidonAboutIcarus01",

				"PoseidonAboutOceanus02",
				"PoseidonAboutOceanus03",
				"PoseidonAboutSurface02",
				"PoseidonAboutOlympus03",
				"PoseidonAboutThessaly04",

				"PoseidonAboutAxe01",
				"PoseidonAboutSuit01",

				"PoseidonAboutAutomatons02",
				"PoseidonAboutAutomatons03",

				"PoseidonAboutFrogFamiliar01",
				"PoseidonAboutCatFamiliar01",
				"PoseidonAboutCatFamiliar02",

				"PoseidonAboutFishing02",
				"PoseidonAboutFishing03",

				"PoseidonAboutKeepsake01",

				"PoseidonAboutRain01",
				"PoseidonAboutBoons01",

				"PoseidonAboutOceanus04",
				"PoseidonAboutOlympus04",

				"PoseidonAboutFishingUpgrade01",
			},
			-- about other gods
			{
				"PoseidonAboutZeus01",
				"PoseidonAboutHera01",
				"PoseidonAboutAphrodite01",
				"PoseidonAboutHestia01",
				"PoseidonAboutDemeter01",
				"PoseidonAboutHermes01",
				"PoseidonAboutHephaestus01",
				"PoseidonAboutHephaestus02",
				"PoseidonAboutArtemis02",
				"PoseidonAboutDionysus01",
				"PoseidonAboutAres02",
			},
			"PoseidonAboutSelene01",
			-- lower-priority story
			-- ending-sensitive
			{
				"PoseidonAboutHades02",
			},
			{
				"PoseidonAboutPolyphemus05",
			},

			{
				"PoseidonLegendaryPickUp02",
			},
			{
				"PoseidonLowHealth01",
				"PoseidonLowHealth03",
				"PoseidonLowHealth04",
			},
			{
				"PoseidonAboutLegendaryFish01",
				"PoseidonAboutLegendaryFish02",
				"PoseidonAboutRareFish01",
				"PoseidonAboutManyFish01",
			},
			{
				"PoseidonUnderworldStartStreak01",
				"PoseidonSurfaceStartStreak01",
			},
			{
				"PoseidonRunStart01",
				"PoseidonRunStart02",
				"PoseidonRunStart03",
				"PoseidonRunStart04",
			},
			-- evergreen
			{
				"PoseidonAboutMelinoe01",
				"PoseidonAboutPolyphemus02",
				"PoseidonAboutDams01",
				"PoseidonAboutLuxuries01",
				"PoseidonAboutWater01",
				"PoseidonAboutFamily02",

				"PoseidonAboutSwimming01",
				"PoseidonAboutStalemate02",
				"PoseidonAboutStalemate03",
				"PoseidonAboutTrading01",
				"PoseidonAboutPressure01",

				"PoseidonAboutChoices01",
				"PoseidonAboutDisasters01",

				"PoseidonAboutPolyphemus04",
			},
			"PoseidonAboutSayingLittle01",
		},

		GiftTextLinePriorities =
		{
			"PoseidonGift01",
			"PoseidonGift02",
			"PoseidonGift03",
			"PoseidonGift04",
			"PoseidonGift05",
			"PoseidonGift06",
			"PoseidonGift07",
		},

		BoughtTextLinePriorities =
		{
			"PoseidonLootBought01",
			"PoseidonLootBought03",
			{
				"PoseidonBlindBox01",
				"PoseidonBlindBox02",
			},
		},
	},

	-- Apollo
	ApolloUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"ApolloFirstPickUp",
			-- mission critical
			"ApolloPostEpilogue01",
			"ApolloPostTrueEnding01",
			"ApolloAboutTyphonDeath01",
			"ApolloAboutTyphonDeath02",
			"ApolloAboutTyphon01",
			{
				"ApolloAboutPackageBounty01",
			},
			-- health & immediate-contextual
			{
				"ApolloAboutSurface01",
			},
			-- priority story
			{
				"ApolloAboutFates02",
				"ApolloAboutTitanWar01",
				"ApolloAboutChronos01",
				"ApolloAboutMelinoe01",
			},
			-- priority contextual
			{
				"ApolloAboutChronosBossW01",
				"ApolloAboutPalace01",
				"ApolloAboutTyphonW03",
			},
			"ApolloAboutTyphonW01",
			{
				"ApolloAboutTyphonW02"
			},
			{
				"ApolloAboutChronosBossW02",
				"ApolloAboutTyphon02",
			},
			{
				"ApolloAboutPackageBounty02",
			},
			-- priority contextual
			{
				"ApolloUnderworldRunCleared03",
			},
			{
				"ApolloAboutPrometheus01",
				"ApolloAboutPrometheus02",
				"ApolloAboutPrometheus03",
				"ApolloAboutUnderworld01",
			},
			{
				"ApolloAboutZagreus01",
			},
			{
				"ApolloAboutOceanus01",
				"ApolloAboutFields01",
				"ApolloAboutEphyra01",
				"ApolloAboutThessaly01",
				"ApolloAboutRouteChoice01",
				"ApolloUnderworldRunCleared02",
				"ApolloAboutPolyphemus01",
				"ApolloAboutSurfaceThreat01",
				"ApolloAboutOlympus02",
			},
			{
				"ApolloAboutArtemis02",
			},
			{
				"ApolloAboutFates01",
			},
			{
				"ApolloAboutKeepsake01",
			},
			{
				"ApolloAboutRelationship01",
			},
			-- health & immediate-contextual
			{
				"ApolloLowHealth01",
				"ApolloLowHealth02",
				"ApolloLowHealth03",
			},
			-- legendary
			{
				"ApolloLegendaryPickUp01",
				"ApolloLegendaryPickUp02",
			},
			-- lower-priority contextual
			{
				"ApolloUnderworldRunCleared01",
				"ApolloAboutSurface02",
				"ApolloAboutSurface03",
				"ApolloAboutSilverSisters01",
				"ApolloPostGift02",
				"ApolloAboutEris01",
				"ApolloAboutMomusAspect01",
				"ApolloAboutHiddenAspects01",
			},
			{
				"ApolloPostGift03",
				"ApolloAboutShrine01",
				"ApolloAboutPackageBounty03",
			},
			{
				"ApolloAboutMusic01",
			},
			{
				"ApolloRunStart01",
				"ApolloRunStart02",
				"ApolloRunStart03",
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
				"ApolloAboutHephaestus01",
				"ApolloAboutAres01",
				"ApolloAboutHermes01",
				"ApolloAboutDionysus01",
			},
			-- lower-priority story
			-- ending-sensitive
			{
				"ApolloAboutTitanWar02",
				"ApolloAboutFamily01",
				"ApolloAboutHades01",
				"ApolloAboutProphecy01",
				"ApolloAboutProphecy02",
			},
			{
				"ApolloAboutMortals01",
				"ApolloAboutChronos02",
				"ApolloAboutHardTimes01",
				"ApolloAboutFamily02",
				"ApolloAboutHecate01",
				"ApolloPostGift05",
				"ApolloAboutOlympus03",
			},
			{
				"ApolloAboutHouse01",
			},
			-- evergreen
			{
				"ApolloAboutKeepsake02",
			},
			{
				"ApolloAboutPassions01",
				"ApolloPostGift01",
				"ApolloAboutChronos03",
				"ApolloAboutWitchcraft01",
				"ApolloAboutOlympus01",
				"ApolloAboutCrossroads01",
				"ApolloAboutAthena01",
				"ApolloAboutLight01",
				"ApolloAboutLight02",
				"ApolloAboutBows01",
				"ApolloAboutMortals02",
				"ApolloAboutErebus01",
				"ApolloAboutTorch01",
			},
			{
				"ApolloAboutHelios01",
				"ApolloAboutTalent01",
				"ApolloAboutFoes01",
				"ApolloAboutLight03",
				"ApolloAboutLight04",
			},
		},

		BoughtTextLinePriorities =
		{
			"ApolloLootBought03",
			{
				"ApolloBlindBox01",
				"ApolloBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"ApolloGift01",
			"ApolloGift02",
			"ApolloGift03",
			"ApolloGift04",
			"ApolloGift05",
			"ApolloGift06",
			"ApolloGift07",
		},
	},

	-- Demeter
	DemeterUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"DemeterFirstPickUp",
			"DemeterPostTrueEnding01",
			"DemeterPostTrueEnding02",
			"DemeterPostTrueEnding03",

			"DemeterPostEpilogue01",
			"DemeterPostEpilogue02",
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
				"DemeterAboutTyphonW01",
				"DemeterAboutTyphonDeath01",
			},
			{
				"DemeterAboutTyphon01",
				"DemeterAboutTyphon02",
				"DemeterAboutTyphonDeath02",
			},
			{
				"DemeterAboutTyphonW02",
				"DemeterAboutTyphon03",
			},
			{
				"DemeterAboutChronosBossW01",
				"DemeterAboutChronosBossW02",
				"DemeterAboutZagreus02",
			},
			{
				"DemeterAboutTartarus01",
			},
			{
				"DemeterAboutPersephoneAspect01",
				"DemeterAboutHelAspect01",
			},
			{
				"DemeterLowHealth01",
			},
			-- priority story
			{
				"DemeterAboutMelinoe02",
			},
			{
				"DemeterAboutMelinoe03",
				"DemeterAboutChronos02",
				"DemeterAboutSurfaceThreat01",
			},
			{
				"DemeterAboutHades02",
				"DemeterAboutPersephone02",
				"DemeterAboutPalace01",
			},
			-- higher priority contextual
			{
				"DemeterUnderworldRunCleared01",
				"DemeterSurfaceRunCleared01",
			},
			{
				"DemeterAboutShrine01",
			},
			{
				"DemeterAboutEphyra02",
			},
			{
				"DemeterAboutOceanus01",
				"DemeterAboutFields01",
				"DemeterAboutThessaly01",
				"DemeterAboutThessaly02",
				"DemeterAboutEphyra01",
				"DemeterAboutPrometheus01",
				"DemeterAboutUnderworld01",
			},
			"DemeterAboutPrometheus03",
			"DemeterAboutPrometheus02",
			-- legendary
			{
				"DemeterLegendaryPickUp01",
				"DemeterLegendaryPickUp02",
			},
			-- priority contextual
			{
				"DemeterAboutKeepsake01",
			},
			-- ending-sensitive
			{
				"DemeterAboutFates01",
				"DemeterAboutFates02",
			},

			-- about other gods
			-- ending-sensitive
			{
				"DemeterAboutZeus01",
				"DemeterAboutHades03",
				"DemeterAboutAphrodite01",
				"DemeterAboutPersephone01",
			},
			{
				"DemeterAboutBlessings01",
				"DemeterAboutZagreus01",
			},

			{
				"DemeterAboutAthena01",
				"DemeterAboutHera01",
				"DemeterAboutAres01",
				"DemeterAboutHephaestus01",
			},
			{
				"DemeterAboutPoseidon01",
				"DemeterAboutPoseidon02",
				"DemeterAboutApollo01",
				"DemeterAboutHestia01",
			},
			{
				"DemeterAboutSelene01",
				"DemeterAboutHermes01",
				"DemeterAboutArtemis01",
			},
			-- lower-priority story
			{
				"DemeterAboutHecate01",
				"DemeterAboutChronos01",
				"DemeterAboutHades01",
			},
			{
				"DemeterAboutHecate03"
			},
			-- lower-priority contextual
			{
				"DemeterRunStart01",
				"DemeterRunStart02",
				"DemeterRunStart03",
				"DemeterRunStart04",
			},
			{
				"DemeterLowHealth02",
				"DemeterLowHealth03",
				"DemeterLowHealth04",
			},
			{
				"DemeterAboutFarmBoy01",
				"DemeterAboutCirce01",
				"DemeterAboutEarth01",
				"DemeterAboutChronos03",
				"DemeterAboutPom01",
				"DemeterAboutMoon01",
				"DemeterAboutResources01",
				"DemeterAboutResources02",
				"DemeterAboutResources03",
				"DemeterAboutSnow01",
				"DemeterAboutRain01",
			},
			-- evergreen
			{
				"DemeterAboutSisters01",
			},
			{
				"DemeterAboutFamilyTree01",
				"DemeterAboutHecate02",
				"DemeterPostGift01",
			},
			"DemeterAboutSayingLittle01",
		},

		BoughtTextLinePriorities =
		{
			{
				"DemeterBlindBox01",
				"DemeterBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"DemeterGift01",
			"DemeterGift02",
			"DemeterGift03",
			"DemeterGift04",
			"DemeterGift05",
			"DemeterGift06",
			"DemeterGift07",
			"DemeterGift08",
		},
	},

	-- Hephaestus
	HephaestusUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"HephaestusFirstPickUp",

			"HephaestusPackageBountyIntro01",

			"HephaestusAboutTyphonDeath01",
			"HephaestusPostTrueEnding01",
			"HephaestusPostEpilogue01",

			-- health & immediate-contextual
			{
				"HephaestusAboutPalace01",
			},
			{
				"HephaestusAboutSurfaceIntro01",
			},
			{
				"HephaestusAboutSurface01",
			},
			{
				"HephaestusAboutSurfaceIntro02",
				"HephaestusUnderworldRunCleared02",
			},
			-- ending-sensitive
			{
				"HephaestusAboutTyphon01",
				"HephaestusAboutChronosBossW01",
			},
			{
				"HephaestusAboutOceanus01",
				"HephaestusAboutFields01",
				"HephaestusAboutThessaly01",
				"HephaestusAboutTyphonW01",
				"HephaestusPostTrueEnding02",
			},
			{
				"HephaestusAboutMelinoe01",
				"HephaestusAboutWeapons03",
				"HephaestusAboutHiddenAspects01",
			},
			{
				"HephaestusAboutAutomatons02",
			},
			{
				"HephaestusUnderworldRunCleared01",
			},
			{
				"HephaestusLegendaryPickUp02",
			},
			-- priority story
			{
				"HephaestusAboutChronos01",
				"HephaestusPostTrueEnding03",
				"HephaestusPostEpilogue02",
				"HephaestusAboutSurfaceThreat01",
				"HephaestusAboutPrometheus01",
			},
			{
				"HephaestusAboutWeapons01",
				"HephaestusAboutWeapons02",
				"HephaestusAboutAspects01",
				"HephaestusAboutStaff01",
				"HephaestusAboutDagger01",
				"HephaestusAboutTorch01",
				"HephaestusAboutAxe01",
				"HephaestusAboutLob01",
				"HephaestusAboutSuit01",
			},
			{
				"HephaestusAboutPolyphemus01",
				"HephaestusAboutHecate01",
				"HephaestusAboutAthena01",
				"HephaestusAboutParents01",
				"HephaestusAboutTyphonDeath02",
			},
			{
				"HephaestusRunStart04",
			},
			{
				"HephaestusAboutErisBossW01",
				"HephaestusAboutTalos01",
				"HephaestusAboutChronos02",
				"HephaestusAboutFates01",
			},
			-- health
			{
				"HephaestusLowHealth03",
			},
			-- priority contextual
			{
				"HephaestusAboutKeepsake01",
			},
			{
				"HephaestusAboutPrometheus02",
			},
			{
				"HephaestusAboutOlympus01",
			},
			-- legendary
			{
				"HephaestusLegendaryPickUp01",
			},
			-- about other gods
			{
				"HephaestusAboutAphrodite01",
				"HephaestusAboutZeus01",
				"HephaestusAboutHera01",
			},
			{
				"HephaestusAboutDaedalus01",
				"HephaestusAboutAres01",
			},
			-- lower-priority story
			{
			},
			-- ending-sensitive
			{
				"HephaestusAboutForge01",
			},
			{
				"HephaestusAboutFamily01",
				"HephaestusAboutFamily02",
				"HephaestusAboutZagreus01",
			},
			{
				"HephaestusAboutPractice01",
			},
			{
				"HephaestusAboutOlympians01",
				"HephaestusAboutMortals01",
				"HephaestusAboutMortals02",
				"HephaestusAboutDionysus01",
				"HephaestusAboutAphroditeRelationship01",
			},
			-- lower-priority contextual
			{
				"HephaestusAboutKeepsake02",
				"HephaestusAboutAspects02",
				"HephaestusLowHealth01",
				"HephaestusLowHealth02",
				"HephaestusLowHealth04",
			},
			{
				"HephaestusAboutPoseidon01",
				"HephaestusAboutDemeter01",
				"HephaestusAboutApollo01",
				"HephaestusAboutHestia01",
				"HephaestusAboutAres02",
				"HephaestusAboutArtemis01",
				"HephaestusAboutHermes01",
			},
			{
				"HephaestusAboutSelene01",
				"HephaestusAboutDaedalus02",
			},
			{
				"HephaestusAboutSurfaceFoes01",
				"HephaestusAboutAutomatons03",
				"HephaestusAboutHeraRelationship01",
				"HephaestusAboutAphroditeRelationship02",
				"HephaestusAboutAphroditeRelationship03",
				"HephaestusAboutAphroditeRelationship04",
				"HephaestusAboutSurface02",
				"HephaestusAboutHouse01",
				"HephaestusAboutBackstory01",
				"HephaestusAboutVolcanoes01",
				"HephaestusAboutTartarus01",
				"HephaestusAboutIcarus01",
				"HephaestusAboutAxe02",
				"HephaestusAboutPandora01",
				"HephaestusAboutHades01",
			},
			{
				"HephaestusRunStartSurface01",
			},
			{
				"HephaestusRunStart01",
				"HephaestusRunStart02",
				"HephaestusRunStart03",
			},
			-- evergreen
			{
				"HephaestusAboutForge02",
				"HephaestusAboutLegs01",
				"HephaestusAboutAutomatons01",
				"HephaestusAboutSilver01",
				"HephaestusAboutCreation01",
			},
			"HephaestusAboutSayingLittle01",
		},

		BoughtTextLinePriorities =
		{
			{
				"HephaestusBlindBox01",
				"HephaestusBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"HephaestusGift01",
			"HephaestusGift02",
			"HephaestusGift03",
			"HephaestusGift04",
			"HephaestusGift05",
			"HephaestusGift06",
			"HephaestusGift07",
		},
	},

	-- Aphrodite
	AphroditeUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"AphroditeFirstPickUp",
			-- health & immediate-contextual
			"AphroditePackageBountyIntro01",
			"AphroditeAboutPackageBounty01",

			"AphroditeAboutTyphon01",
			"AphroditeAboutTyphonDeath01",
			"AphroditePostTrueEnding01",
			"AphroditePostTrueEnding02",

			"AphroditeAboutTyphonW01",
			"AphroditeAboutChronosBossW01",
			"AphroditeAboutTyphon02",
			"AphroditePostEpilogue01",
			{
				"AphroditeAboutKeepsake01",
				"AphroditeAboutEros01",
			},
			{
				"AphroditeAboutSurface01",
				"AphroditeAboutOceanus01",
				"AphroditeAboutThessaly01",
				"AphroditeAboutPrometheus01",
			},
			{
				"AphroditeAboutSurface03",
				"AphroditeAboutSurface02",
				"AphroditeAboutApples01",
			},
			{
				"AphroditeUnderworldRunCleared01",
				"AphroditeUnderworldRunCleared02",
				"AphroditeSurfaceRunCleared01",
			},
			{
				"AphroditeAboutAres02",
			},
			{
				"AphroditeAboutFates01",
			},
			{
				"AphroditeAboutLove04",
			},
			{
				"AphroditeAboutNectar01",
			},
			{
				"AphroditeAboutPrometheus02",
				"AphroditeAboutPrometheus03",
			},
			{
				"AphroditeAboutBathHouse01",
				"AphroditeAboutBathHouse02",
			},
			-- priority story
			{
				"AphroditeAboutFamily01",
				"AphroditeAboutHecate01",
				"AphroditeAboutSurfaceThreat01",
				"AphroditeAboutOlympus01",
				"AphroditePostEpilogue02",
			},
			-- priority contextual
			{
				"AphroditeAboutMoros01",
				"AphroditeAboutSurface04",
				"AphroditeAboutZagreus03",
				"AphroditeAboutArtemis01",
				"AphroditeAboutAthena01",
			},
			{
				"AphroditeAboutChronos01",
				"AphroditeAboutChronos02",
			},
			-- low health
			{
				"AphroditeLowHealth01",
				"AphroditeLowHealth02",
				"AphroditeLowHealth03",
				"AphroditeLowHealth04",
			},
			-- legendary
			{
				"AphroditeLegendaryPickUp01",
				"AphroditeLegendaryPickUp02",
			},
			{
				"AphroditeAboutRelationship01",
				"AphroditeAboutMoros02",
				"AphroditeAboutNemesis02",
				"AphroditeAboutIcarus02",
				"AphroditeAboutEris02",
				"AphroditeAboutZagreus02",
			},
			{
				"AphroditeAboutSirens01",
				"AphroditeAboutAres01",
				"AphroditeAboutEris01",
				"AphroditeAboutHeracles01",
				"AphroditeAboutIcarus01",
				"AphroditeAboutArachne02",
				"AphroditeAboutBirdies01",
			},
			{
				"AphroditeAboutNemesis01",
			},
			{
				"AphroditeRunStart03",
			},
			-- ending-sensitive 
			{
				"AphroditeRunStart01",
				"AphroditeRunStart02",
				"AphroditeRunStart04",
			},
			-- lower-priority story
			{
				"AphroditeAboutOlympus02",
			},
			{
				"AphroditeAboutZagreus01",
			},
			-- lower-priority contextual
			{
				"AphroditeAboutEosAspect01",
				"AphroditeAboutHephaestusRelationship01",
				"AphroditeAboutLove02",
				"AphroditeAboutArachne01",
				"AphroditeAboutNectar02",
				"AphroditeAboutNarcissus01",
				"AphroditeAboutNarcissus02",
				"AphroditeAboutOutfits01",
				"AphroditeAboutSirens02",

				-- about other gods
				"AphroditeAboutZeus01",
				"AphroditeAboutHera01",
				"AphroditeAboutPoseidon01",
				"AphroditeAboutApollo01",
				"AphroditeAboutDemeter01",
				"AphroditeAboutHestia01",
				"AphroditeAboutHephaestus01",
				"AphroditeAboutHephaestus02",
				"AphroditeAboutHermes01",
				"AphroditeAboutAthena02",
				"AphroditeAboutSelene01",
			},
			{
				"AphroditeAboutFamiliars01",
			},
			-- evergreen
			{
				"AphroditeAboutUnderworld01",
				"AphroditeAboutPersephone01",
				"AphroditeAboutPassions01",
				"AphroditeAboutLove01",
				"AphroditeAboutLove03",
				"AphroditeAboutHades01",
				"AphroditeAboutOlympus03",
				"AphroditeAboutDionysus01",
				"AphroditeAboutBoons01",
				"AphroditeAboutMelinoe01",
				"AphroditeAboutWar01",
			},
			"AphroditeAboutSayingLittle01",
		},

		BoughtTextLinePriorities =
		{
			{
				"AphroditeBlindBox01",
				"AphroditeBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"AphroditeGift01",
			"AphroditeGift02",
			"AphroditeGift03",
			"AphroditeGift04",
			"AphroditeGift05",
			"AphroditeGift06",
			"AphroditeGift07",
		},
	},

	-- Hestia
	HestiaUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"HestiaFirstPickUp",

			"HestiaAboutTyphonDeath01",

			"HestiaPostTrueEnding01",
			"HestiaPostTrueEnding02",

			"HestiaPostEpilogue01",
			-- immediate-contextual
			{
				"HestiaAboutPackageBounty01",
				"HestiaAboutPackageBounty02",
			},
			{
				"HestiaAboutSurface01",
			},
			{
				"HestiaAboutSurfacePenalty01",
			},
			{
				"HestiaUnderworldRunCleared02",
				"HestiaUnderworldRunCleared03",
			},
			{
				"HestiaAboutTyphon01",
			},
			{
				"HestiaSurfaceRunCleared01",
				"HestiaSurfaceRunCleared02",
				"HestiaSurfaceRunCleared03",
			},
			{
				"HestiaAboutChronosBossW02",
			},
			{
				"HestiaUnderworldRunCleared01",
			},
			{
				"HestiaAboutPalace01",
			},
			{
				"HestiaAboutTyphon02",
			},
			{
				"HestiaAboutRouteChoice01",
			},
			{
				"HestiaAboutChronosPlan01",
				"HestiaAboutChronos01",
			},

			{
				"HestiaAboutChronosBossW01",
			},
			{
				"HestiaAboutWinStreak01",
			},
			{
				"HestiaAboutKeepsake01",
			},

			"HestiaAboutPrometheus01",
			"HestiaAboutPrometheus02",
			"HestiaAboutEris01",
			{
				"HestiaAboutEris02",
			},
			{
				"HestiaAboutEris03",
			},
			-- priority story
			{
				"HestiaAboutArtemis01",
			},
			{
				"HestiaAboutHades01",
				"HestiaAboutHecate01",
				"HestiaAboutMortals03",
				"HestiaPostEpilogue02",
			},
			{
				"HestiaAboutOceanus01",
				"HestiaAboutFields01",
			},
			-- health
			{
				"HestiaLowHealth01",
			},
			-- legendary
			{
				"HestiaLegendaryPickUp01",
				"HestiaLegendaryPickUp02",
			},
			-- priority contextual
			{
				"HestiaAboutCosmetics02",
			},
			-- early introductions
			{
				"HestiaAboutWitchcraft01",
				"HestiaAboutParents01",
				"HestiaAboutOlympians01",
				"HestiaAboutOlympians02",
			},
			{
				"HestiaAboutPrometheusL01",
				"HestiaAboutPrometheus03",
				"HestiaAboutPrometheus04",
			},
			{
				"HestiaAboutTorch01",
				"HestiaAboutSuit01",
			},
			{
				"HestiaLowHealth02",
				"HestiaLowHealth03",
				"HestiaLowHealth04",
			},
			{
				"HestiaRunStartUnderworld01",
			},
			{
				"HestiaRunStart01",
				"HestiaRunStart02",
				"HestiaRunStart03",
				"HestiaAboutEphyra01",
				"HestiaRunStartSurface01",
				"HestiaAboutHeracles01",
				"HestiaAboutHeracles02",
			},
			{
				"HestiaAboutSurface02",
				"HestiaAboutSurface03",
			},
			{
				"HestiaAboutPolyphemus01",
			},
			{
				"HestiaAboutChronosPlan02",
				"HestiaAboutShrine01",
				"HestiaAboutFates01",
			},
			-- ending-sensitive 
			{
				"HestiaAboutMortals01",
			},
			{
				"HestiaAboutCosmetics01",
			},
			-- about other gods
			-- ending-sensitive
			{
				"HestiaAboutDemeter02",
				"HestiaAboutAthena01",
				"HestiaAboutDionysus01",
				"HestiaAboutHades03",
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
				"HestiaAboutAres01",
			},
			{
				"HestiaAboutSelene01",
				"HestiaAboutHermes01",
			},
			{
				"HestiaAboutChaos01",
				"HestiaAboutEosAspect01",
				"HestiaAboutSupayAspect01",
			},
			-- additional contextual
			{
				"HestiaAboutCinder01",
				"HestiaAboutCinder02",
				"HestiaAboutOlympians03",
			},
			-- lower-priority story
			{
				"HestiaAboutHearth01",
				"HestiaAboutHouse01",
				"HestiaAboutSisters01",
				"HestiaAboutMortals02",
				"HestiaBackstory01",
				"HestiaBackstory02",
				"HestiaAboutDarkness01",
				"HestiaAboutHades02",
			},
			-- lower-priority contextual
			{
				"HestiaAboutHestiaStatue01",
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
				"HestiaAboutFighting01",
				"HestiaAboutSoot01",
			},
			"HestiaAboutSayingLittle01",
		},

		BoughtTextLinePriorities =
		{
			{
				"HestiaBlindBox01",
				"HestiaBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"HestiaGift01",
			"HestiaGift02",
			"HestiaGift03",
			"HestiaGift04",
			"HestiaGift05",
			"HestiaGift06",
			"HestiaGift07",
		},
	},

	-- Ares
	AresUpgrade = 
	{
		InteractTextLinePriorities =
		{
			"AresFirstPickUp",
			"AresPostTrueEnding01",
			"AresPostEpilogue01",

			-- immediate-contextual

			"AresPostTrueEndingAboutChronos01",
			"AresPostTrueEndingAboutChronos02",
			"AresPostTrueEndingAboutTyphon01",
			{
				"AresAboutPackageBounty01",
			},
			{
				"AresAboutTyphon01",
				"AresAboutTyphonDeath01",
			},
			{
				"AresAboutTyphonL01",
				"AresSurfaceRunCleared01",
				"AresSurfaceRunCleared02",
				"AresUnderworldRunCleared01",
				"AresUnderworldRunCleared02",
				"AresUnderworldRunCleared03",
				"AresAboutPalace01",
			},
			{
				"AresAboutZagreus01_B",
				"AresAboutZagreus02",
			},
			{
				"AresRunStart03",
				"AresAboutRandomBounties01",
			},
			-- health
			{
				"AresLowHealth01",
			},
			-- priority story
			{
				"AresPostTrueEnding02",
				"AresAboutTravels01",
			},
			{
				"AresAboutNyx02",
				"AresAboutChronos01",
			},
			-- priority contextual
			{
				"AresAboutKeepsake01",
				"AresAboutMorosKeepsake01",
				"AresAboutKeepsake02",
			},
			{
				"AresAboutPrometheus01",
			},
			{
				"AresRunStart01",
				"AresRunStart02",
				"AresRunStartSurface02",
			},
			-- legendary
			{
				"AresLegendaryPickUp01",
				"AresLegendaryPickUp02",
			},
			{
				"AresAboutShrine01",
				"AresAboutShrine02",
			},
			{
				"AresAboutSacrifice01",
			},
			{
				"AresAboutNergalAspect01",
				"AresAboutNyxAspect01",
				"AresAboutThanatosAspect01",
			},
			{
				"AresAboutPackageBounty02",
			},
			-- lower-priority story
			{
				"AresAboutWar01",
				"AresAboutHades01",
			},
			-- about other gods
			{
				"AresAboutZeus01",
				"AresAboutHera01",
			},
			{
				"AresAboutAphrodite01",
				"AresAboutAthena01",
			},
			{
				"AresAboutWar02",
			},
			{
				"AresAboutWar03",
			},
			{
				"AresAboutZagreus01",
				"AresAboutNyx01",
			},
			{
				"AresAboutNemesis01",
			},
			{
				"AresAboutFates01",
			},

			{
				"AresLowHealth03",
			},
			{
				"AresLowHealth02",
				"AresLowHealth04",
			},
			-- about other gods
			{
				"AresAboutZeus02",
				"AresAboutPoseidon01",
				"AresAboutApollo01",
				"AresAboutDemeter01",
				"AresAboutHestia01",
				"AresAboutHephaestus01",
				"AresAboutArtemis01",
				"AresAboutHermes01",
				"AresAboutSelene01",
			},
			-- lower-priority contextual
			{
				"AresAboutEris01",
				"AresAboutPrometheus02",
				"AresAboutPrometheus03",
			},
			{
				"AresAboutEris02",
				"AresAboutEris03",
			},
			{
				"AresAboutSatyrs01",
				"AresAboutDevotionTest01",
			},
			{
				"AresAboutHeracles01",
				"AresAboutMedea01",
			},
			{
				"AresAboutEphyra01",
				"AresAboutThessaly01",
				"AresAboutUnderworld01",
			},
			{
				"AresRunStartSurface01",
			},
			-- evergreen
			{
				"AresAboutUnderworld02",
				"AresAboutFamily01",
			},
			{
				"AresAboutOlympus01",
			},
			{
				"AresAboutWeapons01",
				"AresAboutWeapons02",
			},
		},

		BoughtTextLinePriorities =
		{
			{
				"AresBlindBox01",
				"AresBlindBox02",
				"AresBlindBox03",
				"AresBlindBox04",
			},
		},

		GiftTextLinePriorities =
		{
			"AresGift01",
			"AresGift02",
			"AresGift03",
			"AresGift04",
			"AresGift05",
			"AresGift06",
			"AresGift07",
		},
	},

	-- Bosses / EnemyData
	-- Hecate Boss
	Hecate =
	{
		BossIntroTextLinePriorities =
		{
			-- @ ending
			"HecateBossPostEpilogue01",
			"HecateBossPostTrueEnding01",

			"HecateBossKidnapped01",

			"HecateBossAboutAltFight01",
			"HecateBossAboutArachne02",
			"HecateBossAboutFates01",
			"HecateBossFirstAppearanceAlt",
			"HecateBossFirstAppearance",
			"HecateBossAboutRage01",
			-- health & immediate contextual
			{
				"HecateBossAboutTyphonFight01",
				"HecateBossAboutTyphonFight01_B",
			},
			{
				"HecateBossAboutChronosBossW00",
			},
			{
				"HecateBossAboutPackagedBounties01_B",
			},
			{
				"HecateBossAboutPackagedBounties01",
				"HecateBossAboutPackagedBounties02",
			},
			{
				"HecateBossAboutHermes01",
				"HecateBossAboutHermes02",
			},
			{
				"HecateBossAboutTyphonFight02",
			},
			{
				"HecateBossAboutFamiliarSystem01",
			},
			"HecateBossAboutEndingPath01",
			"HecateBossAboutEndingPath02",
			"HecateBossAboutEndingPath03",
			"HecateBossAboutEndingPath04",
			"HecateBossAboutEndingPath00",
			{
				"HecateBossAboutArachne01",
			},
			{
				"HecateBossAboutDagger01",
				"HecateBossAboutCharonAspect01",
				"HecateBossAboutWeaponAspects01",
			},
			{
				"HecateBossAboutChronos03",
			},
			{
				"HecateBossLowHealth02",
				"HecateBossAboutFlattery01",
			},
			{
				"HecateBossRepeatedWins02",
				"HecateBossAboutChronos01",
				"HecateBossAboutShrineUpgrade01",
			},
			-- priority story
			{
				"HecateBossPostTrueEnding02",
				"HecateBossPostEpilogue02",
			},
			-- priority contextual
			{
				"HecateBossAboutChronosBossW02",
			},
			{
				"HecateBossAboutAltFight03",
			},
			{
				"HecateBossAboutFrogFamiliar01",
				"HecateBossAboutRavenFamiliar01",
				"HecateBossAboutHoundFamiliar01",
				"HecateBossAboutPolecatFamiliar01",
				"HecateBossAboutHiddenAspects01",
			},
			{
				"HecateBossAboutArcana02",
				"HecateBossAboutShrine01",
				"HecateBossAboutShrine04",
			},
			{
				"HecateBossAboutChronosBossW01",
			},
			{
				"HecateBossAboutCirceAspect01",
				"HecateBossAboutMorosAspect01",
				"HecateBossAboutEosAspect01",
			},
			{
				"HecateBossAboutTorch01",
				"HecateBossAboutAxe01",
				"HecateBossAboutLob01",
				"HecateBossAboutSuit01",
			},

			{
				"HecateBossAboutFailure01",
				"HecateBossQuickMatch01",
			},
			{
				"HecateBossAboutDemeter01",
				"HecateBossAboutDemeter02",
			},
			{
				"HecateBossAboutSelene01",
				"HecateBossAboutArcana01",
				"HecateBossAboutHecateKeepsake01",
				"HecateBossAboutNemesisKeepsake01",
				"HecateBossAboutOdysseusKeepsake01",
				"HecateBossAboutMorosKeepsake01",
				"HecateBossAboutMedeaKeepsake01",
				"HecateBossAboutErisKeepsake01",
				"HecateBossAboutAthena01",
				"HecateBossAboutTorch02",
				"HecateBossAboutSurface01",
				"HecateBossAboutCatFamiliar01",
			},
			{
				"HecateBossAboutRepetition01",
			},
			-- lower priority story
			{
				"HecateBossAboutChronos02",
			},
			{
				"HecateBossAboutAltFight02",
			},
			{
				"HecateBossAboutOlympians01",
			},
			-- lower priority contextual
			{
				"HecateBossAboutShrine02",
				"HecateBossAboutShrine03",
				"HecateBossRepeatedWins01",
			},
			{
				"HecateBossLowHealth01",
				"HecateBossLowHealth03",
			},
			{
				"HecateBossCloseMatch01",
				"HecateBossAboutArtemis01",
				"HecateBossAboutNemesis01",
				"HecateBossAboutSilence01",
				"HecateBossAboutArachneOutfit01",
				"HecateBossAboutWeaponAspects02",
			},
			{
				"HecateBossAboutErebus01",
				"HecateBossAboutHecateKeepsake02",
			},
			-- evergreen
			{
				"HecateBossAboutTesting01",
				"HecateBossAboutRespect01",
				"HecateBossAboutErebus02",
				"HecateBossAboutSolitude01",
				"HecateBossAboutSolitude02",
				"HecateBossAboutLearning01",
				"HecateBossAboutHermes03",
			},
			{
				"HecateBossStrictlyBusiness01",
			},
			{
				"HecateBossAboutExpectations01",
				"HecateBossMissedFight01",
				"HecateBossAboutTask01",
				"HecateBossAboutTask02",
				"HecateBossAboutWitchcraft01",
				"HecateBossAboutConfidence01",
				"HecateBossAboutAnger01",
			},
			"HecateBossAboutSayingLittle01",
		},

		BossOutroTextLinePriorities =
		{
			"HecateBossOutro01",
			"HecateBossOutroNoArcana01",
			"HecateBossOutroAltFight01",
			"HecateBossGrantsCodex01",
			"HecateBossGrantsFamiliarSystem01",
			"HecateBossGrantsCardUpgradeSystem01",
			"HecateBossGrantsWeaponUpgradeSystem01",
			"HecateBossGrantsShrineUpgrade01",
			{
				"HecateBossMiscOutro27",
			},
			{
				"HecateBossMiscOutro24",
				"HecateBossMiscOutro25",
				"HecateBossMiscOutro26",
				"HecateBossMiscOutro28",
				"HecateBossMiscOutro29",
				"HecateBossMiscOutro30",
				"HecateBossMiscOutro31",
				"HecateBossMiscOutro32",
			},
			{
				"HecateBossMiscOutro03",
				"HecateBossMiscOutro05",
				"HecateBossMiscOutro11",
				"HecateBossMiscOutro13",
				"HecateBossMiscOutro14",
				"HecateBossMiscOutro17",
				"HecateBossMiscOutro21",
				"HecateBossMiscOutro22",
				"HecateBossMiscOutro23",
				"HecateBossMiscOutro33",
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
			"CharonAboutArtemisSinging01",

			-- ending
			"CharonPostEpilogue01",
			"CharonPostTrueEnding01",

			"CharonAboutZagreusFight01",

			"CharonPostTrueEnding02",

			-- immediate-contextual
			"CharonGrantsHiddenAspect01",
			"CharonAboutTyphon01",
			"CharonAboutTyphon02",
			"CharonAboutTartarus01",
			"CharonAboutSurface01",
			"CharonAboutThessaly01",
			"CharonAboutChronosBossW01",
			"CharonAboutFates01",

			"CharonAboutCharonPoints01",

			"CharonFirstMeeting",
			"CharonAboutNemesisShopping01",
			"CharonAboutHeraclesShopping01",
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
				"CharonAboutHermes04",
				"CharonAboutHermesKeepsake01",
				"CharonAboutCharonAspect01",
				"CharonAboutThanatosAspect01",
				"CharonAboutHiddenAspect01",
				"CharonAboutShrine01",
				"CharonAboutPackagedBounties01",
				"CharonAboutHermes01",
			},
			{
				"CharonAboutOlympians01",
				"CharonAboutShrine02",
			},
			-- priority story
			{
				"CharonAboutHermesMission01",
			},
			{
				"CharonAboutGold01",
				"CharonAboutSmuggling01",
			},
			-- lower-priority contextual
			{
				"CharonAboutKeepsake01",
				"CharonAboutKeepsake02",
			},
			{
				"CharonAboutNemesis01",
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
			"CharonGift05",
			"CharonGift06",
			"CharonGift07",
			"CharonGift08",
		},
	},

	-- Athena
	NPC_Athena_01 =
	{
		InteractTextLinePriorities =
		{
			"AthenaAboutArachneQuestComplete01",
			"AthenaFirstMeeting",
			"AthenaPostTrueEnding01",

			-- gorgon amulet events
			{
				"AthenaAboutErebus01",
				"AthenaAboutOceanus01",
				"AthenaAboutFields01",
				"AthenaAboutTartarus01",
				"AthenaAboutEphyra01",
				"AthenaAboutThessaly01",
				"AthenaAboutSummit01",
				"AthenaAboutSummit02",
			},
			"AthenaAboutKeepsake01",

			-- mission critical
			"AthenaAboutPalace01",
			"AthenaPostEpilogue01",
			"AthenaPostTrueEnding02",
			"AthenaAboutTyphonPlan01",
			"AthenaAboutTyphonDeath01",

			-- immediate-contextual
			{
				"AthenaAboutTyphon01",
			},
			{
				"AthenaAboutTyphonL01",
				"AthenaAboutTyphonW01",
			},
			{
				"AthenaGrantsReward01",
			},
			{
				"AthenaAboutUltimateProgress01",
			},
			{
				"AthenaAboutPrometheus01",
			},
			{
				"AthenaAboutArachne01",
				"AthenaAboutArachne02",
				"AthenaAboutArachne03",
			},
			{
				"AthenaAboutPrometheusL01",
				"AthenaAboutTyphonW02",
			},

			-- priority story
			{
				"AthenaAboutSurfaceThreat01",
				"AthenaAboutPrometheus02",
			},
			{
				"AthenaPostEpilogue02",
			},
			{
				"AthenaAboutOlympians01",
				"AthenaAboutZeus01",
			},
			{
				"AthenaAboutZagreus01",
			},

			-- high-priority contextual
			{
				"AthenaAboutChronosBossW01",
			},
			{
				"AthenaAboutAres01",
				"AthenaAboutAres02",
			},
			{
				"AthenaAboutTimePassing01",
			},
			{
				"AthenaAboutCirce01",
				"AthenaAboutCirce01_B",
				"AthenaAboutCirce02",
				"AthenaAboutCirce02_B",
			},

			-- non-ending-sensitive
			{
				"AthenaAboutFates01",
			},
			{
				"AthenaAboutTalos01",
				"AthenaAboutAutomatons01",
			},

			-- lower-priority contextual
			{
				"AthenaAboutHera01",
				"AthenaAboutHeracles01",
				"AthenaAboutDionysus01",
				"AthenaLowHealth01",
			},
			{
				"AthenaAboutShrine01",
			},

			-- lower priority story
			{
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
			"AthenaGift05",
			"AthenaGift06",
			"AthenaGift07",
		},
	},

	-- Bouldy
	NPC_Bouldy_01 =
	{
		InteractTextLinePriorities =
		{
			"BouldyFirstMeeting",
		},
	},

	-- Cerberus
	NPC_Cerberus_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"CerberusFirstMeeting",
			"CerberusMeeting02",
		},
	},

	-- @ ending
	NPC_Cerberus_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"CerberusTrueEnding01",
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
			"ChaosAboutLife01",
			"ChaosPostTrueEnding01",
			"ChaosAboutTyphonDeath01",
			"ChaosPostTrueEnding02",
			"ChaosPostEpilogue01",
			"ChaosWithNyx01",

			-- immediate-contextual
			"ChaosAboutBountyChaosIntro01",
			"ChaosAboutRandomBounties01",
			"ChaosAboutKeepsakeQuest02",
			"ChaosAboutSurfaceAppearance01",
			{
				"ChaosAboutBounties01",
			},

			"ChaosAboutSurface01",
			"ChaosGrantsBountyBoard01",
			"ChaosGrantsDarkness01_B",
			{
				"ChaosAboutBounties02",
				"ChaosAboutBounties03",
				"ChaosAboutBounties04",
				"ChaosAboutBountyProgress01",
			},

			"ChaosAboutSurface02",
			"ChaosGrantsDarkness01",

			"ChaosAboutChronosNightmare01",
			"ChaosAboutChronosNightmare01_B",
			{
				"ChaosUnderworldRunCleared01",
				"ChaosAboutChronosFight01",
				"ChaosAboutTyphon01",
			},

			"ChaosUnderworldSurfaceCleared01",
			"ChaosUnderworldSurfaceCleared02",

			"ChaosPostTrueEndingSurface01",

			"ChaosAboutBountyBoardUnlock01",
			"ChaosAboutBountyBoard01",

			"ChaosPostTrueEndingRunCleared01",

			-- priority story
			"ChaosAboutZagreus01",

			"ChaosAboutKeepsakeQuest01",

			"ChaosAboutTyphon02",
			"ChaosAboutTyphon03",
			"ChaosPostTrueEndingAboutNyx01",
			"ChaosPostTrueEndingAboutZagreus01",

			-- high-priority contextual
			{
				"ChaosAboutKeepsakeQuest01_B",
			},
			{
				"ChaosAboutChaosGateItem01",
			},
			{
				"ChaosAboutKeepsake01",
				"ChaosAboutKeepsake02",
				"ChaosAboutNemesis01",
				"ChaosAboutHades01",
			},
			{
				"ChaosPostTrueEndingAboutUnderworld01",
			},
			{
				"ChaosPostTrueEndingAboutUnderworld02",
			},
			{
				"ChaosAboutShrine01",
				"ChaosAboutRandomBounties02",
			},
			{
				"ChaosAboutFates01",
			},
			{
				"ChaosAboutPostSurface01",
			},

			-- run start
			{
				"ChaosRunStart01",
				"ChaosRunStart02",
			},

			-- health
			{
				"ChaosLowHealth03",
			},

			-- priority contextual
			{
				"ChaosAboutChronosNightmare02",
				"ChaosWithNyx02",
			},
			{
				"ChaosAboutNemesis02",
			},
			{
				"ChaosUnderworldRunCleared02",
			},
			{
				"ChaosAboutNyx01",
				"ChaosAboutNyx02",
				"ChaosAboutChronos02",
			},
			{
				"ChaosLowHealth01",
				"ChaosLowHealth02",
				"ChaosLowHealth04",
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
				"ChaosAboutAres01",
				"ChaosAboutArtemis01",
				"ChaosAboutHermes01",
			},
			"ChaosAboutNyxAspect01",
			"ChaosAboutWeapons01",
			"ChaosAboutStarDust01",

			-- lower-priority story
			{
				"ChaosPostEpilogue02",
			},
			{
				"ChaosAboutChronos03",
			},
			{
				"ChaosAboutTitans01",
			},
			{
				"ChaosAboutOlympians01",
			},
			{
				"ChaosAboutPrometheus01",
			},
			{
				"ChaosAboutFamily01",
				"ChaosAboutChronos01",
			},

			-- lower-priority contextual
			{
				"ChaosAboutEris01",
				"ChaosAboutChaosGates01",
				"ChaosAboutHecate01",
				"ChaosAboutTyphon04",
				"ChaosAboutFishing01",
			},

			-- evergreen
			{
				"ChaosAboutSurfaceAppearance02",
				"ChaosAboutTrust01",
			},
			{
				"ChaosAboutForm01",
				"ChaosAboutCreation01",
			},
			"ChaosAboutSayingLittle01",
		},
		
		GiftTextLinePriorities =
		{
			"ChaosGift01",
			"ChaosGift02",
			"ChaosGift03",
			"ChaosGift04",
			"ChaosGift05",
			"ChaosGift06",
			"ChaosGift07",
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
			{
				"ChronosMeetingAboutTyphon01",
				"ChronosMeetingAboutTyphonW01",
				"ChronosMeetingAboutTyphon02",
			},
			{
				"ChronosMeetingAboutPrometheus01",
				"ChronosMeetingAboutPrometheus02",
			},
			{
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
			{
				"ChronosMeetingAboutShrine01",
			},
		},
	},
	NPC_Chronos_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"ChronosNightmare01",
		},
	},
	-- @ ending
	-- NeoChronos
	NPC_Chronos_02 =
	{
		InteractTextLinePriorities =
		{
			"HadesTrueEnding01",
			"ZeusPalacePostTrueEnding01",

			-- erebus events
			"NeoChronosPostEpilogue01",
			"NeoChronosWithNemesis01",
			"NeoChronosAboutNemesis01",
			"NeoChronosAboutErebus01",
			"NeoChronosAboutFates01", -- epilogue
			"NeoChronosAboutFailure01",
			"NeoChronosAboutChronos01",
			"NeoChronosAboutAnomaly01",
			"NeoChronosAboutKeepsake01",
			"NeoChronosAboutPast01",
			"NeoChronosAboutPrometheus01",
			"NeoChronosAboutGoldenAge01",
			"NeoChronosAboutTyphon01",
			"NeoChronosPostEpilogue02",
			"NeoChronosAboutBoons01",
			"NeoChronosAboutNewJob01",
			"NeoChronosAboutBeard01",

			-- pre-warp events
			"NeoChronosAboutTartarus01",
			"NeoChronosAboutTartarus01_B",
			"NeoChronosAboutTartarus02",
			"NeoChronosAboutOlympus01",
			"NeoChronosAboutOlympus01_B",
			"NeoChronosAboutOlympus02",
		},

		GiftTextLinePriorities =
		{
			"NeoChronosGift01",
			"NeoChronosGift02",
			"NeoChronosGift03",
			"NeoChronosGift04",
		},
	},

	-- Chronos Boss
	Chronos =
	{
		BossIntroTextLinePriorities =
		{
			-- @ ending
			"ChronosBossPostTrueEnding01",
			"ChronosBossPostTrueEnding02",

			"ChronosBossAboutHecateKidnapped01",
			"ChronosBossAboutTyphonDeath01",
			"ChronosBossAboutHecateKidnapped02",

			"ChronosBossAboutAltFight01",
			"ChronosBossAboutAltFight02",
			"ChronosBossAboutAltFight03",
			"ChronosBossAboutRandomBounties1",

			"ChronosBossFirstMeeting_C",
			"ChronosBossFirstMeeting_B",
			"ChronosBossFirstMeeting",
			"ChronosBossLostAgainstHim01",

			-- after 1st win
			"ChronosBossWonAgainstHim01",

			-- immediate-contextual
			{
				"ChronosBossAboutShrine01",
			},
			{
				"ChronosBossAboutTyphon01_B",
			},
			{
				"ChronosBossAboutTyphon01",
			},
			{
				"ChronosBossAboutHades02",
				"ChronosBossAboutGameplayTimer02",
			},

			-- priority story
			"ChronosBossAboutHades01",
			-- after 2nd win
			"ChronosBossAboutFamily01",
			-- after 3rd win
			"ChronosBossAboutFamily02",
			-- after 4th win
			"ChronosBossAboutFamily03",
			-- after 5th win
			"ChronosBossAboutFamily04",
			-- after 6th win
			"ChronosBossAboutFamily05",
			{
				"ChronosBossAboutPausing01",
			},
			{
				"ChronosBossAboutTyphon02",
				"ChronosBossAboutTyphon03",
			},
			{
				"ChronosBossAboutTyphon04",
			},
			-- health
			{
			},
			-- priority contextual
			{
				"ChronosBossAboutThanatosAspect01",
			},
			{
				"ChronosBossAboutNoBoons01",
			},
			-- about other gods
			{
			},
			-- additional story
			{
				"ChronosBossAboutGoldenAge01",
				"ChronosBossAboutGoldenAge02",
			},
			-- lower-priority contextual
			{
				"ChronosBossAboutPrometheus02",
				"ChronosBossAboutSuit01",
				"ChronosBossAboutKeepsake01",
			},
			{
				"ChronosBossAboutChaos01",
				"ChronosBossAboutHistory01",
				"ChronosBossAboutEris01",
				"ChronosBossAboutPrometheus01",
				"ChronosBossAboutGameplayTimer01",
				"ChronosBossAboutThessaly01",
			},
			-- lower-priority story
			{
				"ChronosBossAboutCerberus01",
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
				"ChronosBossAboutNyx01",
			},
			{
				"ChronosBossAboutTitans01",
			},

			-- evergreen
			{
				"ChronosBossAboutWeapons01",
				"ChronosBossAboutHouse01",
				"ChronosBossAboutSatyrs01",
				"ChronosBossAboutFuture01",
				"ChronosBossAboutWretches01",
				"ChronosBossAboutOrigin01",
			},
		},

		BossPhaseChangeTextLinePriorities =
		{
			"ChronosBossPreTrueEndingFinalPhase01",
			"ChronosBossR2Outro01",
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
			-- before pastfirstmeeting
			"ChronosBossOutro01",
			-- pastmeeting06
			"ChronosBossOutroAfterHecateKidnapped01",
			-- after true ending
			"ChronosBossOutroPostTrueEnding01",
			-- pastmeeting02
			"ChronosBossOutroUltimateProgress01",
			-- pastmeeting02_2
			"ChronosBossOutroUltimateProgress02",
			"ChronosBossOutroPreTrueEnding01",
			"ChronosBossOutroPreTrueEnding01_B",
			-- pastmeeting03
			"ChronosBossOutroUltimateProgress03",
			-- pastmeeting04
			"ChronosBossOutroUltimateProgress04",
			-- pastmeeting04_2
			"ChronosBossOutroUltimateProgress05",
		},
	},

	-- Typhon
	TyphonHead =
	{
		BossIntroTextLinePriorities =
		{
			-- @ ending
			"TyphonBossAltFight01",
			"TyphonBossAltFight02",
			"TyphonBossAltFight03",
			"TyphonBossAltFight04",
		},

		BossPhaseChangeTextLinePriorities =
		{
			"TyphonAltFightFinalRound01",
			"TyphonAltFightFinalRound02",
			"TyphonAltFightFinalRound03",
			"TyphonAltFightFinalRound04",
			{
				"TyphonAltFightFinalRound11",
				"TyphonAltFightFinalRound12",
			},
			"TyphonAltFightFinalRound06",
			"TyphonAltFightFinalRound08",
			"TyphonAltFightFinalRound09",
			{
				"TyphonAltFightFinalRound10",
				"TyphonAltFightFinalRound05",
				"TyphonAltFightFinalRound07",
			},
		},
	},

	-- Circe
	NPC_Circe_01 =
	{
		InteractTextLinePriorities =
		{
			"CirceAboutOdysseusQuest00",
			"CirceAboutOdysseusQuest01",
			"CirceAboutOdysseusQuest02",
			"CirceAboutScyllaQuestComplete01",
			"CirceFirstMeeting",
			"CirceAboutOdysseusKeepsake01",

			-- ending
			"CircePostTrueEnding01",
			"CircePostTrueEnding02",

			-- immediate-contextual
			"CirceAboutOlympus01",

			"CirceGrantsHiddenAspect01",
			"CirceAboutHiddenAspectProgress01",

			"CirceGrantsFamiliarCostumes01",

			"CircePostEpilogue01",

			"CirceAboutTyphon01",
			"CirceAboutTyphonW01",
			"CirceAboutPrometheus01",
			"CirceAboutHope01",

			-- priority contextual
			{
				"CirceAboutKeepsake01",
				"CirceAboutHiddenAspect01",
			},
			-- priority story
			{
				"CirceAboutChronos01",
			},
			{
				"CirceAboutHut01",
			},
			{
				"CirceLowHealth01",
			},
			{
				"CirceAboutScyllaQuest01", -- Quest
				"CirceAboutOdysseus01", -- Quest
				"CirceAboutLearning01", -- Heart Unlock
			},
			{
				"CirceAboutArcana01",
				"CirceAboutFamiliarCostumes01",
			},
			{
				"CirceAboutScylla01",
				"CirceAboutScylla02",
			},
			{
				"CirceAboutFrogFamiliar01",
				"CirceAboutCharybdis01",
				"CirceAboutMoly01",
			},
			-- lower-priority contextual
			{
				"CircePostTrueEnding03",
			},
			{
				"CirceAboutArcana02",
				"CirceAboutArcana03",
				"CirceAboutSurfacePenalty01",
			},
			{
				"CirceAboutPrometheus02",
				"CirceAboutSelene01",
				"CirceAboutEris01",
				"CirceAboutCirceAspect01",
			},
			-- lower priority story
			{
				"CirceAboutThessaly01",
				"CirceAboutHecate01",
				"CirceAboutHermes01",
			},
			{
				"CirceAboutMedea01",
				"CirceAboutBackstory01",
				"CirceAboutIcarus01"
			},
			{
				"CirceAboutCrystals01",
			},
			-- evergreen
			{
				"CirceAboutFamily01",
				"CirceAboutMiracles01",
				"CirceAboutStudies01",
				"CirceAboutMagick01",
				"CirceAboutTransformation01",
				"CirceAboutTraining01",
			},
		},

		GiftTextLinePriorities =
		{
			"CirceGift01",
			"CirceGift02",
			"CirceGift03",
			"CirceGift04",
			"CirceGift05",
			"CirceGift06",
			"CirceGift07",
			"CirceGift08",
		},
	},

	-- Dionysus
	NPC_Dionysus_01 =
	{
		InteractTextLinePriorities =
		{
			"DionysusFirstMeeting",
			"DionysusFirstMeeting_B",

			"DionysusPostTrueEnding01",
			"DionysusPostEpilogue01",

			"DionysusAboutFeast01",
			"DionysusAboutOlympians01",

			-- health & immediate contextual
			{
				"DionysusAboutPrometheus03",
			},
			{
				"DionysusAboutTyphon01",
			},
			{
				"DionysusAboutCirce01",
				"DionysusAboutCirce01_B",
			},
			{
				"DionysusLowHealth01",
			},
			{
				"DionysusAboutKeepsake01",
			},
			{
				"DionysusAboutAmbrosia01",
				"DionysusAboutAmbrosia02",
			},
			"DionysusPostTrueEnding02",

			-- priority story
			{
				"DionysusPostTrueEnding03",
			},
			"DionysusAboutFeast02",
			"DionysusAboutFeast04",

			"DionysusAboutPrometheus01",

			"DionysusAboutZagreus01",
			"DionysusAboutZagreus02",

			"DionysusAboutFeast03",
			"DionysusAboutFeast05",

			"DionysusAboutAutomatons01",
			"DionysusAboutMortals01",

			"DionysusAboutPrometheus02",

			-- lower-priority contextual
			{
				"DionysusAboutSprings01",
				"DionysusAboutFrogFamiliar01",
				"DionysusAboutCatFamiliar01",
				"DionysusAboutRavenFamiliar01",
				"DionysusAboutHoundFamiliar01",
			},

			-- lower priority story
			"DionysusAboutZagreus03",

			-- evergreen
			{
				"DionysusAboutTravels01",
				"DionysusAboutSatyrs01",
				"DionysusAboutFeast06",
			},
		},

		GiftTextLinePriorities =
		{
			"DionysusGift01",
			"DionysusGift02",
			"DionysusGift03",
			"DionysusGift04",
			"DionysusGift05",
			"DionysusGift06",
			"DionysusGift07",
		},
	},

	-- Echo
	NPC_Echo_01 =
	{
		InteractTextLinePriorities =
		{
			"NarcissusWithEcho01",
			"NarcissusWithEcho02",

			"EchoAboutCurse02",
			"EchoAboutCurse03",

			"EchoFirstMeeting",
			"EchoAboutEcho01",

			"EchoPostTrueEnding01",
			"EchoAboutHelp02",

			"EchoAboutHelp01",
			"NarcissusWithEcho03",

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
				"EchoAboutFields01",
			},
			{
				"EchoAboutNymphs01",
				"EchoAboutOlympus01"
			},
			"EchoAboutNarcissus01",
			"EchoAboutNarcissus05",
			"EchoAboutNarcissus06",
			"EchoAboutNarcissus08",

			"EchoAboutHeart01",
			"EchoAboutCurse01",
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
			"EchoAboutCerberus01",

			-- evergreen
			{
				"EchoAboutBridge01",
				"EchoAboutCharon01",
			},
		},

		GiftTextLinePriorities =
		{
			"EchoGift01",
			"EchoGift02",
			"EchoGift03",
			"EchoGift04",
			"EchoGift05",
			"EchoGift06",
			"EchoGift07",
			"EchoGift08",
		},		
	},

	-- Eris
	NPC_Eris_01 =
	{
		InteractTextLinePriorities =
		{
			"ErisPostTrueEnding01",

			"ErisAboutRelationship03",
			"ErisAboutRelationship03_B",
			"ErisAboutRelationship02",
			"ErisFoughtAgainstHer01",
			"ErisFirstMeeting_B",
			"ErisFirstMeeting",

			-- immediate-contextual
			{
				"ErisFoughtAgainstHer02",
				"ErisAboutAltFight01",
				"ErisBecomingCloser01",
			},
			{
				"ErisFoughtAgainstHer03",
			},
			{
				"ErisAboutChronos01",
				"ErisAboutTyphon01",
			},
			"ErisAboutUltimateProgress01",

			"ErisAboutSurfaceRunCleared01",

			"ErisAboutSurface01",
			"ErisAboutSurface02",

			"ErisAboutPast01",
			"ErisAboutTask01",

			"ErisAboutCloseMatch01",
			"ErisAboutHeart01",
			"ErisAboutPurpose01",
			"ErisAboutLoyalty01",
			"ErisAboutPast02",
			"ErisAboutRematches01",

			"ErisAboutRunCleared01",
			"ErisAboutNyx02",
			{
				"ErisAboutNyx01",
				"ErisAboutWar02",
				"ErisAboutRumors01",
			},

			-- priority story
			"ErisPostEpilogue01",
			"ErisPostEpilogue02",
			"ErisPostTrueEnding02",
			"ErisPostTrueEnding03",

			"ErisAboutHypnosWakeUp01",
			{
				"ErisAboutDisorder01",
				"ErisAboutWar01",
			},
			"ErisAboutRelationship01",
			"ErisAboutStrife02",

			-- lower-priority contextual
			{
				"ErisAboutNotFighting01",
				"ErisAboutNotFighting02",
			},
			{
				"ErisAboutHecate01",
				"ErisAboutMoros01",
				"ErisAboutNemesis01",
			},
			{
				"ErisPostGift01",
			},
			-- lower priority story
			{
				"NemesisWithEris01",
				"NemesisWithEris02",
				"MorosWithEris01",
				"MorosWithEris02",
				"IcarusWithEris01",
				"ErisWithHecate01",
			},
			{
				"ErisAboutTrash03",
				"ErisPostTrueEnding04",
			},
			{
				"ErisAboutWeaponGun01",
				"ErisAboutTrash01",
				"ErisAboutTrash02",
				"ErisAboutStrife01",
				"ErisAboutHeracles01",
				"ErisAboutMoros02",
				"ErisAboutRelationship04",
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
			"ErisGift02",
			"ErisBathHouse01",
			"ErisGift03",
			"ErisTaverna01",
			"ErisGift04",
			"ErisFishing01",
			"ErisGift05",
			"ErisBathHouse02",
			"ErisGift06",
			"ErisGift07",
			"ErisGift08",
			"ErisGift09",
			"ErisTaverna02",
			"ErisGiftDecline01",
			"ErisFishingDecline01",
			"ErisBathHouseDecline01",
			"ErisTavernaDecline01",
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
			"ErisBossAboutAltFight01",
			"ErisBossAboutAltFight03",
			"ErisBossAboutBecomingCloser01",
			"ErisBossAboutTyphonDeath01",

			"ErisBossAboutAltFight04",
			"ErisBossAboutAltFight02",
			"ErisBossAboutAltFight05",
			"ErisBossAboutRelationship02",
			"ErisBossFirstMeeting",

			-- health & immediate contextual
			{
				"ErisBossAboutSuit01",
			},
			{
				"ErisBossAboutCirce01",
				"ErisBossAboutCirce02",
			},
			"ErisAboutPackagedBounties01",
			"ErisAboutPackagedBounties02",
			{
				"ErisBossAboutKeepsake01",
				"ErisBossAboutNemesisKeepsake01",
				"ErisBossAboutMorosKeepsake01",
			},
			"ErisBossAboutTyphon03",
			"ErisBossAboutGoldenApples01",
			"ErisBossAboutConsequences01",
			"ErisBossAboutShrine01",
			"ErisBossAboutShrine02",
			"ErisBossCloseMatch01",
			"ErisBossLowHealth01",
			"ErisBossAboutNyxAspect01",

			-- priority story
			"ErisBossPostTrueEnding01",

			-- ending sensitive
			"ErisBossAboutObstacles01",
			"ErisBossAboutAres02",
			"ErisBossAboutTyphon01",
			"ErisBossAboutAres01",
			"ErisBossAboutTyphon02",
			"ErisBossAboutAres03",

			"ErisBossAboutMistakes01",
			"ErisBossAboutRelaxation01",
			"ErisBossAboutProblems02",
			"ErisBossAboutProblems03",

			-- priority contextual
			"ErisBossAboutUnderworld01",
			"ErisBossAboutShrine03",

			-- lower priority story
			"ErisBossAboutPrometheus01",
			"ErisBossAboutRandomness01",
			"ErisBossAboutPurpose01",
			"ErisBossAboutProblems01",
			"ErisBossAboutPolyphemus01",

			-- lower priority contextual
			{
				"ErisBossAboutRavenFamiliar01",
				"ErisBossAboutFishing01",
			},
			{
				"ErisBossAboutIcarus01",
				"ErisBossAboutCharon01",
				"ErisBossAboutSelene01",
			},
			"ErisBossAboutDeath01",
			"ErisBossAboutRelationship01",
			"ErisBossLowHealth02",

			-- evergreen
			"ErisBossAboutHarpies01",
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
			"HeraPostEpilogue01",

			"HeraPostTrueEnding01",
			"HeraAboutPalace01",
			"HeraAboutTyphonDeath01",
			"HeraAboutLastResort01",
			{
				"HeraAboutPackageBounty01",
			},
			"HeraAboutTyphonW01",
			{
				"HeraAboutTyphon01",
			},
			{
				"HeraAboutDevotionTest01",
			},
			{
				"HeraUnderworldRunCleared01",
			},
			{
				"HeraAboutEris01",
				"HeraAboutPrometheus01",
			},
			-- high-priority contextual
			{
				"HeraAboutKeepsake01",
			},
			{
				"HeraPostTrueEndingAboutSurface01",
			},
			-- priority story
			{
				"HeraAboutHope01",
				"HeraAboutMeeting01",
				"HeraAboutMission01",
				"HeraAboutTyphonDeath02",
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
				"HeraPostEpilogue02",
			},
			{
				"HeraSurfaceRunCleared01",
			},
			-- health
			{
				"HeraLowHealth02",
			},
			-- priority contextual
			{
				"HeraAboutPalace02",
			},
			{
				"HeraAboutUnderworld01",
				"HeraAboutOlympus01",
			},
			{
				"HeraAboutFates02",
			},
			{
				"HeraAboutPrometheus02",
				"HeraAboutHeracles03",
			},
			{
				"HeraAboutRouteChoice01",
				"HeraAboutSurfaceThreat01",
			},
			{
				"HeraAboutChronos03",
				"HeraAboutChronos04",
				"HeraAboutHades01",
			},
			{
				"HeraAboutPolyphemus01",
			},
			{
				"HeraRunStartSurface01",
				"HeraRunStartSurface02",
			},
			{
				"HeraAboutHeracles01",
				"HeraAboutSurface02",
				"HeraAboutFields01",
			},
			{
				"HeraRunStart01",
				"HeraRunStartUnderworld01",
				"HeraAboutSwitchToUnderworld01",
			},
			{
				"HeraAboutShrine01",
			},
			{
				"HeraAboutShrine02",
			},
			-- about other gods
			{
				"HeraAboutZeus01",
				"HeraAboutZeus02",
			},
			{
				"HeraAboutHermes01",
				"HeraAboutDemeter01",
				"HeraAboutHeracles02",
				"HeraAboutArtemis01",
			},
			{
				"HeraAboutPoseidon01",
				"HeraAboutApollo01",
				"HeraAboutAphrodite01",
				"HeraAboutHephaestus01",
				"HeraAboutHephaestus02",
				"HeraAboutHestia01",
				"HeraAboutAres01",
				"HeraAboutAthena01",
				"HeraAboutSelene01",
			},
			{
				"HeraAboutFamily01",
			},
			{
				"HeraAboutChronos02",
			},
			{
				"HeraLowHealth01",
				"HeraLowHealth03",
				"HeraLowHealth04",
			},
			-- legendary
			{
				"HeraLegendaryPickUp01",
				"HeraLegendaryPickUp02",
			},
			-- lower-priority contextual
			{
				"HeraAboutMortals04",
				"HeraAboutRelationships01",
				"HeraAboutRelationships02",
				"HeraAboutSurface03",
				"HeraPostGift01",
				"HeraPostGift02",
				"HeraAboutHecate01",
				"HeraAboutHyperion01",
				"HeraAboutPolymorph01",
				"HeraAboutOlympus02",
				"HeraAboutThessaly01",
			},
			-- lower priority story
			{
				"HeraAboutMortals01",
				"HeraAboutMortals03",
			},
			-- evergreen
			{
				"HeraAboutFamily02",
				"HeraAboutChildren04",
				"HeraAboutCompliments01",
				"HeraAboutReputation01",
				"HeraAboutMarriage01",
			},
			{
				"HeraAboutWitchcraft01",
				"HeraAboutMortals02",
				"HeraAboutEternity01",
				"HeraAboutChildren01",
				"HeraAboutChildren02",
				"HeraAboutChildren03",
				"HeraAboutZeusMarriage01",
				"HeraAboutZeusMarriage02",
				"HeraAboutBows01",
			},
			"HeraAboutSayingLittle01",
		},

		BoughtTextLinePriorities =
		{
			"HeraLootBought01",
			"HeraLootBought02",
			{
				"HeraBlindBox01",
				"HeraBlindBox02",
			},
		},

		GiftTextLinePriorities =
		{
			"HeraGift01",
			"HeraGift02",
			"HeraGift03",
			"HeraGift04",
			"HeraGift05",
			"HeraGift06",
			"HeraGift07",
		},
	},

	-- Heracles
	NPC_Heracles_01 =
	{
		BossIntroTextLinePriorities =
		{
			"HeraclesFirstMeeting",
			"HeraclesCombat01",
			"HeraclesPreEncounterAboutAltFight01",
			"HeraclesPreEncounterAboutTrueEnding01",
			"HeraclesPreEncounterAboutTimePassing01",
		},

		InteractTextLinePriorities =
		{
			-- immediate contextual
			"HeraclesFieldAboutAltFight01",
			"HeraclesFieldAboutTrueEnding01",
			"HeraclesFieldAboutEpilogue01",

			"HeraclesFieldAboutEphyra01",
			"HeraclesFieldAboutThessaly01",
			"HeraclesFieldAboutOlympus02",
			"HeraclesFieldAboutReturning01",

			"HeraclesFieldAboutAltFightWin01",
			"HeraclesFieldAboutEpilogue02",

			"HeraclesFieldAboutTyphon01",
			"HeraclesFieldAboutTyphon02",
			"HeraclesFieldAboutPrometheus01",
			"HeraclesFieldAboutIcarus02",

			-- priority story
			"HeraclesFieldAboutFates01", -- epilogue
			"HeraclesFieldAboutPolyphemus01",
			"HeraclesFieldAboutFathers01",
			"HeraclesFieldAboutTrueEnding02",

			-- priority contextual
			"HeraclesFieldAboutHera01",
			"HeraclesFieldAboutKeepsake01",
			"HeraclesFieldAboutBlood01",

			-- lower priority story
			"HeraclesFieldAboutOlympus01",
			"HeraclesFieldAboutWitches01",

			-- lower priority contextual
			{
				"HeraclesFieldAboutTimePassing01",
			},
			{
				"HeraclesFieldAboutBoar01",
				"HeraclesFieldAboutMedea01",
				"HeraclesFieldAboutWeapons01",
				"HeraclesFieldAboutMagick01",
				"HeraclesFieldAboutIcarus01",
			},

			-- evergreen
			"HeraclesFieldAboutFamily01",
			"HeraclesFieldAboutFame01",
			"HeraclesFieldAboutCharon01",
			"HeraclesFieldAboutSayingLittle01",
		},

		GiftTextLinePriorities =
		{
			"HeraclesGift01",
			"HeraclesGift02",
			"HeraclesGift03",
			"HeraclesGift04",
			"HeraclesGift05",
			"HeraclesGift06",
			"HeraclesGift07",
		},
	},

	-- Hermes
	HermesUpgrade = 
	{
		InteractTextLinePriorities =
		{
			-- victory
			"HermesPostEpilogue01",
			"HermesAboutTyphonDeath01",
			"HermesPostTrueEnding01",

			-- mission critical
			"HermesAboutFatesQuest01",
			"HermesAboutUltimateProgress01",
			"HermesAboutTyphonReveal01",

			-- health & immediate-contextual
			{
				"HermesAboutApolloKeepsake01",
			},
			{
				"HermesAboutSurface01",
				"HermesAboutSurface02",
				"HermesAboutSurface02B",
				"HermesAboutTyphon01",
			},
			{
				"HermesAboutSurfaceCurse01",
			},
			{
				"HermesAboutOlympus01",
				"HermesUnderworldRunCleared01",
				"HermesSurfaceRunCleared02",
			},
			{
				"HermesSurfaceRunCleared01",
			},
			{
				"HermesAboutPrometheusAltFight01",
			},
			-- priority story
			{
				"HermesAboutFates01",
				"HermesAboutReachingSurface01",
				"HermesAboutRouteChoice01",
				"HermesPostEpilogue03",
				"HermesPostTrueEnding02",
			},
			{
				"HermesAboutMission01",
				"HermesAboutMission02",
				"HermesPostTrueEnding03",
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
				"HermesAboutEris01",
			},
			-- high priority contextual
			{
				"HermesAboutPackageBounty01",
				"HermesAboutTyphon02",
			},
			{
				"HermesAboutHades01",
			},
			{
				"HermesAboutDemeter01",
			},
			{
				"HermesAboutMoros01",
			},
			-- low health
			{
				"HermesLowHealth03",
			},
			-- priority contextual
			{
				"HermesAboutThessaly01",
				"HermesAboutKeepsake01",
				"HermesAboutSurfaceThreat01",
			},
			{
				"HermesAboutOceanus01",
				"HermesAboutCharon01",
				"HermesAboutArtemis02",
				"HermesAboutShrine01",
			},
			{
				"HermesAboutGameplayTimer01",
				"HermesAboutGameplayTimer02",
			},
			-- about other gods
			{
				"HermesAboutAres01",
			},
			{
				"HermesAboutZeus01",
				"HermesAboutHera01",
				"HermesAboutPoseidon01",
				"HermesAboutApollo01",
				"HermesAboutHephaestus01",
				"HermesAboutAphrodite01",
				"HermesAboutHestia01",
				"HermesAboutSelene01",
			},
			{
				"HermesRunStart06",
				"HermesAboutKeepsake02",
				"HermesRunStartSurface02",
			},
			{
				"HermesRunStartSurface01",
				"HermesRunStartSurface03",
				"HermesRunStartSurface04",
				"HermesUnderworldStart01",
			},
			{
				"HermesAboutCharon02",
			},
			{
				"HermesRunStart01",
				"HermesRunStart02",
				"HermesRunStart03",
				"HermesRunStart04",
				"HermesRunStart05",
			},
			{
				"HermesAboutZagreus01",
				"HermesAboutOlympusSiege02",
				"HermesAboutSurfaceShop01",
				"HermesAboutChronos01",
			},
			-- lower-priority story
			-- ending-sensitive
			{
				"HermesPostEpilogue02",
				"HermesAboutChronos02",
			},
			{
				"HermesAboutAthena01",
				"HermesAboutDionysus01",
			},
			{
				"HermesLowHealth01",
				"HermesLowHealth02",
				"HermesLowHealth04",
			},
			-- legendary
			{
				"HermesLegendaryPickUp01",
				"HermesLegendaryPickUp02",
				"HermesLegendaryPickUp03",
				"HermesLegendaryPickUp04",
			},
			-- not ending-sensitive
			{
				"HermesAboutMelinoe01",
				"HermesAboutPast01",
			},
			-- lower-priority contextual
			{
				"HermesAboutHeracles01",
				"HermesAboutHephaestus02",
				"HermesAboutArtemis01",
				"HermesAboutCirce01",
				"HermesAboutMomusAspect01",
			},
			{
				"HermesAboutFamiliars01",
			},
			-- evergreen
			{
				"HermesAboutPersephone01",
			},
			{
				"HermesAboutTime01",
				"HermesAboutClients01",
			},
			"HermesAboutLittleToSay01",
		},

		BoughtTextLinePriorities =
		{
			"HermesLootBought04",
			"HermesLootBought01",
		},

		GiftTextLinePriorities =
		{
			"HermesGift01",
			"HermesGift02",
			"HermesGift03",
			"HermesGift04",
			"HermesGift05",
			"HermesGift06",
			"HermesGift07",
			"HermesGift08",
		},
	},

	-- Icarus (HomePriorities below)
	NPC_Icarus_01 =
	{
		InteractTextLinePriorities =
		{
			"IcarusFirstMeeting",
			"IcarusPostTrueEnding01",
			"IcarusPostTrueEnding01_B",
			"IcarusPostTrueEnding02",
			"IcarusAboutBecomingCloser01",
			"IcarusAboutBecomingCloser01_B",
			"IcarusAboutOlympus02",
			"IcarusAboutEris02",
			"IcarusAboutFlying04",

			"IcarusAboutCrossroads02",
			-- immediate-contextual
			{
				"IcarusAboutCirce01",
				"IcarusAboutCirce02",
			},
			"IcarusAboutCrossroads01",
			"IcarusAboutOlympus01",
			"IcarusAboutChronosBossW01",
			"IcarusAboutDaedalus02",
			"IcarusGrantsReward01",
			"IcarusAboutPrometheus02",
			"IcarusAboutHeracles02",
			{
				"IcarusAboutPrometheus01",
				"IcarusAboutTyphon01",
				"IcarusAboutTyphon02",
			},
			"IcarusAboutOdysseus01",
			"IcarusAboutTyphon03",
			-- priority story
			{
				"IcarusAboutFlying02",
				"IcarusAboutFlying02_B",
			},
			"IcarusPostTrueEnding03",
			"IcarusAboutUnderworld01",
			"IcarusAboutSurfaceCurse01",
			"IcarusAboutMelinoe01",
			{
				"IcarusAboutFlying01",
				"IcarusAboutFlying01_B",
				"IcarusAboutReturning02",
			},
			"IcarusAboutFlying03",
			"IcarusAboutReturning01",
			"IcarusAboutDaedalus01",

			-- lower-priority contextual
			{
				"IcarusAboutKeepsake01",
				"IcarusAboutHiddenAspects01",
				"IcarusLowHealth01",
			},
			"IcarusAboutEris01",
			"IcarusAboutTimePassing01",
			{
				"IcarusAboutKeepsake02",
				"IcarusAboutHammers01",
			},
			{
				"IcarusAboutHeracles01",
				"IcarusAboutHeracles03",
			},
			-- lower priority story
			{
				"IcarusAboutDaedalus03",
				"IcarusAboutDaedalus04",
				"IcarusAboutDaedalus05",
			},
			{
				"IcarusAboutPrometheus03",
			},
			{
				"IcarusAboutCharybdis01",
				"IcarusAboutFrogFamiliar01",
				"IcarusAboutRavenFamiliar01",
			},
			-- evergreen
			"IcarusAboutSayingLittle01",
		},

		GiftTextLinePriorities =
		{
			"IcarusGift01",
			"IcarusGift02",
			"IcarusGift03",
			"IcarusBathHouse01",
			"IcarusGift04",
			"IcarusFishing01",
			"IcarusGift05",
			"IcarusTaverna01",
			"IcarusGift06",
			"IcarusBathHouse02",
			"IcarusGift07",
			"IcarusGift08",
			"IcarusGift09",
			"IcarusGift10",
			"IcarusBathHouseDecline01",
			"IcarusFishingDecline01",
			"IcarusTavernaDecline01",
			"IcarusFieldGiftDecline01",
		},

		HomePriorities =
		{
			"IcarusHomeFirstMeeting",
			"IcarusHomeAboutTyphonDeath01",
			"IcarusHomePostTrueEnding01",
			"IcarusHomePostTrueEnding02",
			"IcarusBecomingCloser01",
			"IcarusHomePostEpilogue01",
			"IcarusHomePostEpilogue02",
			"IcarusHomeAboutOdysseusWandering01",
			"IcarusHomeAboutArtemisSinging01",
			"IcarusHomeAboutTools01",
			"IcarusHomeAboutCrossroads01",
			"IcarusWithOdysseus01",
			"IcarusHomeAboutMoros01",
			"IcarusHomeAboutMoros01_B",
			"IcarusHomeAboutGrace01",
			"IcarusHomeAboutRain01",
			"IcarusHomeAboutCrossroads02",
			"IcarusHomeAboutCrossroads02_B",
			"IcarusHomeAboutCrossroads03",
			"IcarusWithEris01",
			"IcarusWithOdysseus02",
			"IcarusWithHecate01",
			"MorosWithIcarus01",
			"NemesisWithIcarus01",
			"IcarusHomeAboutRelationships01",
			"IcarusHomeAboutMortality01",
		},
	},

	-- Medea
	NPC_Medea_01 =
	{
		InteractTextLinePriorities =
		{
			"MedeaAboutAltFight01",

			"MedeaAboutConcoctionQuestComplete01",

			"MedeaPostTrueEnding01",

			"MedeaFirstMeeting",
			"MedeaHubFirstMeeting01",

			-- immediate-contextual
			"MedeaAboutHypnos01",
			"MedeaGrantsHiddenAspect01",
			"MedeaAboutHiddenAspectProgress01",
			"MedeaGrantsHypnosSpell01",
			"MedeaGrantsHypnosSpell02",

			"MedeaAboutConcoctionQuest01",

			"MedeaAboutTrust01",

			"MedeaLowHealth01",
			"MedeaAboutExperiments01",

			-- priority story
			{
				"MedeaAboutFoes01",
			},
			{
				"MedeaAboutPylons01",
				"MedeaAboutEmptiness01",
				"MedeaPostTrueEnding02",
			},
			{
				"MedeaAboutTyphon01",
			},
			{
				"MedeaAboutMedeaAspect01",
				"MedeaAboutHiddenAspect01",
				"MedeaAboutKeepsake01",
			},
			"MedeaAboutAltFight04",
			"MedeaAboutAltFight02",
			"MedeaAboutAltFight03",
			"MedeaAboutOlympus01",
			{
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
			"MedeaGiftTears01",
			"MedeaGift01",
			"MedeaGift02",
			"MedeaGift03",
			"MedeaGift04",
			"MedeaGift05",
			"MedeaGift06",
			"MedeaGift07",
			"MedeaGift08",
		},
	},

	-- Narcissus
	NPC_Narcissus_01 =
	{
		InteractTextLinePriorities =
		{
			"NemesisWithNarcissus02_FollowUp",
			"NarcissusFirstMeeting",
			"NemesisWithNarcissus01_FollowUp",

			"NarcissusAboutWaters05",
			"NarcissusGrantsReward01",

			"NarcissusAboutFriendship04",
			"NarcissusAboutFriendship05",
			"NarcissusAboutFriendship06",
			"NarcissusAboutFriendship07",
			"NarcissusAboutFriendship08",
			"NarcissusAboutFriendship09",
			{
				"NarcissusLowHealth01",
			},
			"NarcissusAboutSuitors01",
			"NarcissusAboutLooks01",

			-- immediate-contextual
			{
				"NarcissusAboutWaters01",
				"NarcissusAboutWaters01_2",
				"NarcissusAboutWaters01_3",
				"NarcissusAboutWaters02",
				"NarcissusAboutWaters03",
				"NarcissusAboutWaters04",
				"NarcissusAboutWaters04_2",
			},
			{
				"NarcissusAboutStillDirtyWaters01",
				"NarcissusAboutEcho01",
				"NarcissusAboutEcho01B",
				"NarcissusAboutEcho02",
				"NarcissusAboutEcho03",
				"NarcissusAboutEcho04",
			},
			{
				"NarcissusAboutKeepsake01",
				"NarcissusAboutNemesis01",
			},

			-- priority story
			{
				"NarcissusAboutChronos01",
			},
			{
				"NarcissusAboutLooks02",
				"NarcissusAboutReflection01",
			},
			{
				"NarcissusAboutOceanus02",
			},
			{
				"NarcissusAboutDanger01",
			},
			{
				"NarcissusAboutSolitude01",
			},
			-- priority contextual
			{
				"NarcissusAboutEcho05",
				"NarcissusAboutEcho06",
			},
			-- lower-priority contextual
			{
				"NarcissusAboutSurface01",
				"NarcissusLowHealth02",
			},
			-- lower priority story
			{
				"NarcissusAboutBeauty01",
			},
			{
				"NarcissusAboutOceanus01",
				"NarcissusAboutLove01",
				"NarcissusAboutCurse01",
			},
			{
				"NarcissusAboutLove02",
				"NarcissusAboutLove03",
				"NarcissusAboutFriendship01",
				"NarcissusAboutFriendship02",
				"NarcissusAboutFriendship03",
			},
			{
				"NarcissusAboutSirens01",
			},
			{
				"NarcissusAboutReflection02",
				"NarcissusAboutReflection03",
			},
			-- evergreen
			{
				"NarcissusAboutReflection04",
				"NarcissusAboutChamber01",
			},
		},

		GiftTextLinePriorities =
		{
			"NarcissusGift01",
			"NarcissusGift02",
			"NarcissusGift03",
			"NarcissusGift04",
			"NarcissusGift05",
			"NarcissusGift06",
			"NarcissusGift07",
		},
	},

	NPC_Narcissus_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"NarcissusWithEcho01",
			"NarcissusWithEcho02",
			"NarcissusWithEcho03",
		},

		GiftTextLinePriorities =
		{
			"NarcissusGift01",
			"NarcissusGift02",
			"NarcissusGift03",
			"NarcissusGift04",
			"NarcissusGift05",
			"NarcissusGift06",
			"NarcissusGift07",
		},
	},

	-- Polyphemus
	Polyphemus =
	{
		BossIntroTextLinePriorities =
		{
			"PolyphemusAboutAltFight01",
			"PolyphemusAboutAltFight01_B",

			"PolyphemusAboutOdysseusQuest01",

			"PolyphemusAboutAltFight02",
			"PolyphemusAltFightMetMedeaEarlier01",

			"PolyphemusAboutNobodyKeepsake01",

			"PolyphemusAboutAltFight03",
			"PolyphemusAboutAltFight04",

			"PolyphemusPostTrueEnding01",
			"PolyphemusPostTrueEnding02",
			"PolyphemusAboutNobody04",

			"PolyphemusAboutBarn01",
			"PolyphemusFirstMeeting",

			-- health & immediate contextual
			{
				"PolyphemusAboutPackagedBounties01",
				"PolyphemusAboutShrine01",
			},
			{
				"PolyphemusAboutShrine02",
			},
			{
				"PolyphemusAboutPackagedBounties02",
				"PolyphemusAboutShrine02_B",
			},
			{
				"PolyphemusAboutNobody02",
				"PolyphemusAboutNobody03",
			},

			"PolyphemusWonAgainstHim01",
			"PolyphemusAboutTyphon01",
			"PolyphemusPostTrueEnding03",

			-- lower priority vow of rivals
			"PolyphemusAboutAltFightBackOn01",
			"PolyphemusAboutAltFightBackOn02",
			"PolyphemusAboutAltFight14",
			"PolyphemusAboutAltFight13",

			-- high priority contextual
			"PolyphemusLostAgainstHim01",
			"PolyphemusBarelyLostAgainstHim01",
			"PolyphemusLostAgainstHim02",
			{
				"PolyphemusAboutNobody01",
				"PolyphemusAboutPoseidon02",
				"PolyphemusLowHealth01",
				"PolyphemusLowHealth02",
			},
			{
				"PolyphemusWonAgainstHim02",
			},
			{
				"PolyphemusAboutName01",
			},
			-- priority story
			-- ending-sensitive
			{
				"PolyphemusAboutFriendship01",
				"PolyphemusAboutDocks01",
			},
			{
				"PolyphemusPostEpilogue01",
				"PolyphemusAboutEphyra01",
				"PolyphemusAboutChronos01",
				"PolyphemusAboutChronos02",
			},
			{
				"PolyphemusAboutPrometheus01",
				"PolyphemusAboutOlympus01",
				"PolyphemusAboutWar01",
			},

			"PolyphemusAboutAltFight05",
			"PolyphemusAltFightAboutMedea01",
			"PolyphemusAboutAltFight15",
			"PolyphemusAboutAltFight11",
			"PolyphemusAboutAltFight06",
			"PolyphemusAboutAltFight07",
			"PolyphemusAboutAltFight08",
			"PolyphemusAboutAltFight09",
			"PolyphemusAboutAltFight10",
			"PolyphemusAboutAltFight12",

			{
				"PolyphemusAboutMedea01",
			},
			{
				"PolyphemusAboutThessaly01",
				"PolyphemusAboutPast01",
				"PolyphemusAboutMelinoe01",
			},
			-- priority contextual
			{
				"PolyphemusAboutSleep01",
				"PolyphemusAboutUnderworld01",
				"PolyphemusAboutPoseidon01",
				"PolyphemusAboutInsomnia02",
			},
			-- lower priority story
			{
				"PolyphemusAboutBlindness01",
				"PolyphemusAboutUnderworld01B",
				"PolyphemusAboutMoving01",
			},
			{
				"PolyphemusAboutInsomnia01",
			},
			-- lower priority contextual
			{
				"PolyphemusAboutHeracles01",
			},
			-- evergreen
			{
				"PolyphemusAboutDiet01",
			},
			{
				"PolyphemusAboutSheep01",
				"PolyphemusAboutCyclopes01",
				"PolyphemusAboutBoulders01",
				"PolyphemusAboutFlock01",
				"PolyphemusAboutMeat01",
			},
			"PolyphemusAboutSayingLittle01",
		},
	},

	-- Prometheus
	Prometheus =
	{
		BossIntroTextLinePriorities =
		{
			"PrometheusFirstMeeting",

			-- mission critical & vow of rivals
			"PrometheusAboutAltFight01",
			"PrometheusAboutAltFight01_B",

			"PrometheusAboutUltimateProgress01",
			"PrometheusAboutEpilogue01",

			"PrometheusPackagedBounties01",

			"PrometheusPostTrueEnding01",

			"PrometheusAboutDora03",
			"PrometheusAboutDora01",

			"PrometheusAboutEpilogue02",
			"PrometheusAboutEpilogue03",

			"PrometheusAboutAltFight03",

			"PrometheusPostTrueEnding03",

			"PrometheusAboutFates02", -- epilogue

			"PrometheusLostAgainstHim01",
			"PrometheusAboutTyphon01",
			"PrometheusAboutTyphonL01",
			"PrometheusAboutTyphon03",
			"PrometheusWonAgainstHim01",
			"PrometheusAboutChronos01",
			"PrometheusAboutGoldenAge01",
			"PrometheusAboutUltimateProgress02",

			"PrometheusAboutDora02",

			"PrometheusAboutAltFight09",

			-- health & immediate contextual
			{
				"PrometheusAboutDionysus02",
				"PrometheusAboutDora04",
			},
			{
				"PrometheusLowHealth03",
			},
			{
				"PrometheusAboutDionysus01",
			},

			-- priority story
			"PrometheusAboutPlans01",
			"PrometheusAboutMortals01",
			"PrometheusAboutFire01",
			"PrometheusAboutMortals02",
			"PrometheusAboutFates01", -- epilogue
			"PrometheusAboutMortals03",

			"PrometheusPostTrueEnding02",
			"PrometheusAboutPostTyphon02",

			-- priority contextual
			"PrometheusAboutAltFight05",
			"PrometheusAboutAltFight07",
			"PrometheusAboutTyphon02",

			"PrometheusAboutShrineBounty02",
			{
				"PrometheusAboutShrineBounty01",
				"PrometheusAboutRandomBounty01",
			},
			"PrometheusWonAgainstHim02",

			"PrometheusAboutPostTyphon01",
			"PrometheusAboutAltFight06",
			"PrometheusAboutAltFight05_2",

			"PrometheusAboutAltFight02",
			"PrometheusAboutAltFight04",
			"PrometheusAboutAltFightHeracles01",
			"PrometheusAboutAltFightHeracles02",

			"PrometheusAboutDora05",
			"PrometheusLostAgainstHim02",
			"PrometheusAboutForesight04",
			"PrometheusAboutForesight05",

			-- lower priority contextual
			{
				"PrometheusAboutCirce01",
			},
			{
				"PrometheusAboutHeraclesKeepsake01_B",
				"PrometheusAboutHeraclesKeepsake01",
			},

			{
				"PrometheusLowHealth02",
			},
			{
				"PrometheusLowHealth01",
				"PrometheusLowHealth02_B",
			},			
			{
				"PrometheusAboutChaos01",
			},
			{
				"PrometheusAboutZeus01",
				"PrometheusAboutAthena01",
				"PrometheusAboutRavenFamiliar01",
				"PrometheusAboutTorch01",
			},
			{
				"PrometheusAboutBrothers01",
				"PrometheusAboutUnderworld01",
			},
			{
				"PrometheusAboutShrine01",
			},

			-- lower priority vow of rivals
			"PrometheusAboutAltFightHeracles05",
			"PrometheusAboutAltFightHeracles04",
			"PrometheusAboutAltFightHeracles03",
			"PrometheusAboutAltFightHeracles06",
			"PrometheusAboutAltFight08",

			-- lower priority story
			{
				"PrometheusAboutEpilogue04",
			},
			{
				"PrometheusAboutForesight02",
			},
			{
				"PrometheusAboutForesight03",
			},
			{
				"PrometheusAboutFuture01",
			},
			-- evergreen
			{
				"PrometheusAboutWorship01",
			},
			"PrometheusAboutForesight01",
			"PrometheusAboutSayingLittle01",
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
			"ScyllaAboutAltFight01",
			"ScyllaAboutOdysseusQuest01",

			"ScyllaAboutChlams02",
			"ScyllaAboutBallad01",

			"ScyllaAboutGrandeur01",

			"ScyllaAboutOdysseusQuest02",

			"ScyllaFirstMeeting",
			"ScyllaAboutAmbitions01",

			"ScyllaAboutDiving02",
			"ScyllaAboutDiving02_B",

			"ScyllaAboutBallad02",

			"ScyllaAboutAltFight03",

			"ScyllaAboutSongs02",
			"ScyllaPostTrueEnding01",

			-- health & immediate contextual
			"ScyllaAboutOdysseus02",
			"ScyllaAboutSongs01",
			"ScyllaAboutComeback01",
			"ScyllaAboutShrineBounty01",
			"ScyllaAboutPackagedBounties01",
			"ScyllaAboutSongVolume01",
			"ScyllaAboutSirens02",
			{
				"ScyllaLowHealth01",
				"ScyllaLowHealth02",
			},
			-- priority story
			{
				"ScyllaPostTrueEnding02",
			},

			-- priority contextual
			{
				"ScyllaAboutAgents01_2",
			},
			{
				"ScyllaAboutAgents02",
				"ScyllaAboutOdysseus01",
				"ScyllaAboutNoShow01",
			},
			{
				"ScyllaAboutBallad03",
			},
			{
				"ScyllaAboutAgents01",
			},
			{
				"ScyllaAboutChronos01",
				"ScyllaAboutChronos02",
				"ScyllaAboutSongs03",
				"ScyllaAboutSongs04",
			},
			-- lower priority contextual
			{
				"ScyllaAboutAltFight04",
				"ScyllaAboutAltFight08",
			},
			{
				"ScyllaAboutCharybdis01",
				"ScyllaAboutDying01",
				"ScyllaAboutThessaly01",
				"ScyllaAboutMerch01",
				"ScyllaAboutShrineBounty02",
				"ScyllaAboutGreenRoom01",
			},
			{
				"ScyllaAboutAltFight02",
				"ScyllaAboutAltFight05",
			},
			{
				"ScyllaAboutAltFight06",
				"ScyllaAboutAltFight07",
			},
			{
				"ScyllaQuickMatch01",
				"ScyllaNoHitMatch01",
			},
			{
				"ScyllaAboutCurse01",
				"ScyllaAboutCirce01",
				"ScyllaAboutCharybdis02",
			},
			{
				"ScyllaAboutShrine01",
				"ScyllaAboutShrine02",
			},
			{
				"ScyllaLowHealth03",
				"ScyllaLowHealth04",
			},
			-- lower priority story
			{
				"ScyllaAboutRumors01",
				"ScyllaAboutDiving01",
			},
			{
				"ScyllaAboutAmbitions02",
				"ScyllaAboutSirens01",
				"ScyllaAboutReputation01",
				"ScyllaAboutStage01",
				"ScyllaAboutSlump01",
				"ScyllaAboutNarcissus01",
				"ScyllaAboutPoseidon01",
			},
			{
				"ScyllaQuickMatch02",
			},
			-- evergreen
			{
				"ScyllaAboutChlams01",
				"ScyllaAboutSurvey01",
				"ScyllaAboutSongs05",
			},
			"ScyllaAboutSayingLittle01",
		},
	},

	-- Nyx (flashback)
	NPC_Nyx_01 =
	{
		InteractTextLinePriorities =
		{
			"NyxNightmare01",
		},
	},

	-- Nyx (true ending)
	NPC_Nyx_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"NyxWithNemesis01",
			"NyxWithHecate01",

			"NyxInChaos01",

			"NyxInChaosPostEpilogue01",

			"NyxInChaosAboutBadgeProgress01",
			"NyxInChaosAboutShrine02",
			"NyxInChaosAboutHypnosWakeUp01",

			"NyxInChaosAboutNyxAspect01",
			"NyxInChaosAboutThanatosAspect01",

			"NyxInChaosAboutFates01",

			"NyxInChaosAboutShrine01",
			"NyxInChaosAboutTrophyQuestComplete01",

			"NyxInChaosAboutChaos01",

			"NyxInChaosAboutHades01",
			"NyxInChaosAboutPersephone01",

			"NyxInChaosAboutChildren01",
			"NyxInChaosAboutEris01",
			{
				"NyxInChaosAboutSelene01",
				"NyxInChaosAboutAres01"
			},

			-- @ ending
			"SeleneTrueEnding01",
		},

		GiftTextLinePriorities =
		{
			"NyxGift01",
			"NyxGift02",
		},

		SpecialGiftTrackHintId = "Codex_NyxHint01",
		SpecialGiftTrackHintRequirements =
		{
			-- always show the hint
		},

	},

	-- @ ending
	-- Zagreus (Past)
	NPC_Zagreus_Past_01 =
	{
		-- also update CheckPriorityConversations in RoomDataI
		InteractTextLinePriorities =
		{
			"ZagreusPastFirstMeeting",
			"ZagreusPastMeeting02",
			"ZagreusPastMeeting02_2",
			"ZagreusPastMeeting03",
			"ZagreusPastMeeting04",
			"ZagreusPastMeeting06_B",
			"ZagreusPastMeeting04_2",
			"ZagreusPastMeeting04_3",
			"ZagreusPastMeeting05",
			"ZagreusPastMeeting06",

			-- optional
			"ZagreusPastMeeting07",
			"ZagreusPastMeeting08",
		},
	},
	NPC_Zagreus_01 =
	{
		InteractTextLinePriorities =
		{
			"ZagreusTrueEnding01",
		},

		GiftTextLinePriorities = {},
		SpecialGiftTrackHintRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossGrantsBondForged01" }
			},
		},
		SpecialGiftTrackHintId = "Codex_BondForgedZagreus",
		SpecialGiftTrackLockedHintId = "Codex_ZagreusGiftHint",
		SpecialGiftTrackFullHearts = true,
		SpecialKeepsakeEventRequirements =
		{
			{
				PathTrue = { "GameState", "GiftPresentation", "RarifyKeepsake" },
			},
		},
	},
	Zagreus =
	{
		BossIntroTextLinePriorities =
		{
			"ZagreusBossFirstMeeting",

			"ZagreusBossAboutCirce01",
			"ZagreusBossAboutCirce02",

			"ZagreusBossWonAgainstHim01",
			"ZagreusBossLostAgainstHim01",

			"ZagreusBossAboutSecurity01",
			"ZagreusBossGrantsBondForged01",
			"ZagreusBossAboutHypnosWakeUp01",
			"ZagreusBossAboutThanatosAspect01",
			"ZagreusBossAboutKeepsake01",
			"ZagreusBossAboutShrine01",
			"ZagreusBossAboutCrossroads01",
			"ZagreusBossAboutGigaros01",
			"ZagreusBossAboutGigaros02",
			"ZagreusBossAboutSurfacePenalty01",

			"ZagreusBossAboutHomer01",

			"ZagreusBossAboutParents01",
			"ZagreusBossAboutHouse01",

			"ZagreusBossAboutSkelly01",

			"ZagreusBossAboutRelationships01",

			"ZagreusBossAboutSayingLittle01",
		},

		BossOutroTextLinePriorities =
		{
			"ZagreusBossOutro01",
			"ZagreusBossGrantsKeepsakeOutro01",
			"ZagreusBossOutro03",
		},
	},

	-- Zeus
	NPC_Zeus_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"ZeusPalaceFirstMeeting",
			"ZeusPalaceMeeting02",
			"ZeusPalaceMeeting03",
			"ZeusPalaceMeeting03_A",
			"ZeusPalaceMeeting03_B",
			"ZeusPalaceAboutTyphonDeath01",
			"ZeusPalaceMeeting04",
			"ZeusPalaceMeeting04_B",
			"ZeusPalacePostTrueEnding01",
		},
	},

	-- Apollo
	NPC_Apollo_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"ApolloPalaceFirstMeeting",
			"ApolloPalaceMeeting02",
			"ApolloPalaceMeeting03",
			"ApolloPalaceAboutTyphonDeath01",
			"ApolloPalaceMeeting04",
			"ApolloPalaceMeeting04_B",
			"ApolloPalacePostTrueEnding01",
		},
	},

	-- Demeter
	NPC_Demeter_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"DemeterPalaceFirstMeeting",
			"DemeterPalacePostTrueEnding01",
			"DemeterPalacePostTrueEnding01_B",
			"DemeterPalaceAboutTyphonDeath01",
		},
	},

	-- Achilles
	NPC_Achilles_01 =
	{
		InteractTextLinePriorities =
		{
			"AchillesTrueEnding01",
		},
	},

	EndRunBoon =
	{
		InteractTextLinePriorities =
		{
			"PalaceBoonExitPostTrueEnding01",
			"PalaceBoonExit02",
			"PalaceBoonExit01",
			"PalaceBoonExitTyphonDestroyed01",
		},
	},

	NPC_Melinoe_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"MelinoeHideAndSeek01",
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
	"NPC_Hypnos_03",
	"NPC_Hypnos_04",
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
	"NPC_Medea_01",
	"NPC_Circe_01",
	"NPC_Icarus_01",

	"NPC_Hecate_Story_01",
	"NPC_Nyx_01",

	"NPC_Hades_Field_01",
	"NPC_Cerberus_Field_01",
	"NPC_Bouldy_01",

	-- @ ending
	"NPC_Chronos_02",
	"NPC_Zagreus_Past_01",
	"NPC_Zagreus_01",
	"NPC_Hades_02",
	"NPC_Persephone_01",
	"NPC_Nyx_Story_01",
	"NPC_Cerberus_Story_01",
	"NPC_Zeus_Story_01",
	"NPC_Apollo_Story_01",
	"NPC_Demeter_Story_01",
	"NPC_Melinoe_Story_01",

	"NPC_Achilles_01",
}

-- Event Tables
GameData.GodAboutGodEvents =
{
	"ZeusAboutHera01",
	"ZeusAboutHera02",
	"ZeusAboutHera03",
	"ZeusAboutPoseidon01",
	"ZeusAboutApollo01",
	"ZeusAboutApollo02",
	"ZeusAboutHephaestus01",
	"ZeusAboutAphrodite01",
	"ZeusAboutDemeter01",
	"ZeusAboutHestia01",
	"ZeusAboutHermes01",
	"ZeusAboutArtemis01",
	"ZeusAboutSelene01",

	"HeraAboutZeus01",
	"HeraAboutZeus02",
	"HeraAboutPoseidon01",
	"HeraAboutDemeter01",
	"HeraAboutApollo01",
	"HeraAboutAphrodite01",
	"HeraAboutHephaestus01",
	"HeraAboutHephaestus02",
	"HeraAboutHestia01",
	"HeraAboutAres01",
	"HeraAboutHermes01",
	"HeraAboutAthena01",
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
	-- "PoseidonAboutAres01",
	"PoseidonAboutAres02",

	"ApolloAboutZeus01",
	"ApolloAboutHera01",
	"ApolloAboutPoseidon01",
	"ApolloAboutHera01",
	"ApolloAboutHestia01",
	"ApolloAboutAphrodite01",
	"ApolloAboutHephaestus01",
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
	"DemeterAboutHestia01",
	"DemeterAboutAres01",
	"DemeterAboutSelene01",
	"DemeterAboutHermes01",	
	"DemeterAboutArtemis01",

	"AphroditeAboutZeus01",
	"AphroditeAboutHera01",
	"AphroditeAboutPoseidon01",
	"AphroditeAboutApollo01",
	"AphroditeAboutDemeter01",
	"AphroditeAboutHestia01",
	"AphroditeAboutHephaestus01",
	"AphroditeAboutHephaestus02",
	"AphroditeAboutHermes01",
	"AphroditeAboutArtemis01",
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
	"HestiaAboutAres01",
	"HestiaAboutHermes01",
	"HestiaAboutSelene01",

	"HephaestusAboutAphrodite01",
	"HephaestusAboutHera01",
	"HephaestusAboutZeus01",
	"HephaestusAboutDemeter01",
	"HephaestusAboutPoseidon01",
	"HephaestusAboutApollo01",
	"HephaestusAboutHestia01",
	"HephaestusAboutAres02",
	"HephaestusAboutArtemis01",
	"HephaestusAboutHermes01",
	"HephaestusAboutSelene01",

	"AresAboutZeus01",
	"AresAboutZeus02",
	"AresAboutHera01",
	"AresAboutPoseidon01",
	"AresAboutApollo01",
	"AresAboutDemeter01",
	"AresAboutAphrodite01",
	"AresAboutHestia01",
	"AresAboutHephaestus01",
	"AresAboutArtemis01",
	"AresAboutHermes01",
	"AresAboutSelene01",

	"SeleneAboutZeus01",
	"SeleneAboutHera01",
	"SeleneAboutApollo01",
	"SeleneAboutPoseidon01",
	"SeleneAboutDemeter01",
	"SeleneAboutAphrodite01",
	"SeleneAboutHephaestus01",
	"SeleneAboutHestia01",
	"SeleneAboutHermes01",

	"HermesAboutZeus01",
	"HermesAboutPoseidon01",
	"HermesAboutHera01",
	"HermesAboutApollo01",
	"HermesAboutDemeter01",
	"HermesAboutAphrodite01",
	"HermesAboutHephaestus01",
	"HermesAboutHephaestus02",
	"HermesAboutHestia01",
	"HermesAboutAres01",

	"ChaosAboutZeus01",
	"ChaosAboutHera01",
	"ChaosAboutPoseidon01",
	"ChaosAboutDemeter01",
	"ChaosAboutApollo01",
	"ChaosAboutHestia01",
	"ChaosAboutHephaestus01",
	"ChaosAboutAphrodite01",
	"ChaosAboutAres01",
	"ChaosAboutArtemis01",
	"ChaosAboutHermes01",
}
GameData.AboutShrineEvents =
{
	"HecateBossAboutShrine01",
	"HecateBossAboutShrine02",
	"HecateBossAboutShrine03",
	"HecateBossAboutShrine04",

	"ScyllaAboutShrine01",

	-- "PolyphemusAboutShrine01",
	-- "PolyphemusAboutShrine02",

	"CharonAboutShrine01",

	"ArtemisAboutShrine01",
	"ArtemisAboutShrine02",

	"SeleneAboutShrine01",
	"SeleneAboutShrine02",
	"SeleneAboutShrine03",
	"SeleneAboutPolyphemus02",

	"ZeusAboutShrine01",
	"ZeusAboutShrine02",

	"PoseidonAboutShrine01",
	"PoseidonAboutShrine02",

	-- Hera

	"DemeterAboutShrine01",

	"ApolloAboutShrine01",

	-- Aphrodite

	"HestiaAboutShrine01",

	"AresAboutShrine01",
	"AresAboutShrine02",

	"AthenaAboutShrine01",

	"ChaosAboutShrine01",

	"HermesAboutShrine01",

	"ChronosMeetingAboutShrine01",
	"ChronosBossAboutShrine01",

	"ScyllaAboutShrine01",
	-- "ScyllaAboutShrineBounty01",
	-- "ScyllaAboutShrineBounty02",

	"PolyphemusAboutShrine01",
	"PolyphemusAboutShrine02",
	"PolyphemusAboutShrine02_B",

	"ErisBossAboutShrine01",
	"ErisBossAboutShrine02",
	"ErisBossAboutShrine03",
}

GameData.AllBondForgedEvents =
{
	"ZeusGift07",
	"HeraGift07",
	"PoseidonGift07",
	"DemeterGift08",
	"ApolloGift07",
	"AphroditeGift07",
	"HephaestusGift07",
	"HestiaGift07",
	"AresGift07",
	"ArtemisGift10",
	"HermesGift08",
	"SeleneGift09",
	"ChaosGift07",

	"DoraBathHouse03",
	"MorosTaverna02",
	"NemesisBathHouse03",
	"ErisTaverna02",
	"OdysseusFishing02",
	"HecateBathHouseEpilogue01",
	"IcarusGift10",
	"SkellyGift09",
	"CharonGift08",

	"ArachneGift09",
	"NarcissusGift07",
	"EchoGift08",
	"HeraclesGift07",
	"MedeaGift08",
	"CirceGift08",
	"DionysusGift07",
	"AthenaGift07",

	"HadesWithPersephoneGift06",
	"NeoChronosGift04",
	"ZagreusBossGrantsBondForged01",
}

GameData.AllBathHouseEvents =
{
	"HecateBathHouseEpilogue01",
	"HecateBathHouse01",
	"HecateBathHouse02",
	"DoraBathHouse01",
	"DoraBathHouse02",
	"DoraBathHouse03",
	"OdysseusBathHouse01",
	"OdysseusBathHouse02",
	"NemesisBathHouse01",
	"NemesisBathHouse02",
	"NemesisBathHouse03",
	"MorosBathHouse01",
	"MorosBathHouse02",
	"MorosBathHouse03",
	"ErisBathHouse01",
	"ErisBathHouse02",
	"IcarusBathHouse01",
	"IcarusBathHouse02",
}

GameData.OdysseusTavernaEvents =
{
	"OdysseusBackstory02",
	"OdysseusBackstory02_B",
	"OdysseusAboutMood01",
	"OdysseusAboutScylla03",
	"OdysseusAboutMusicPlayer01",
	"OdysseusAboutGameStats01",
	"OdysseusLooseEndsQuest01",
	"OdysseusTavernaChat01",
	"OdysseusTavernaChat02",
	"OdysseusTavernaChat03",
	"OdysseusTavernaChat04",
	"OdysseusTavernaChat05",
	"OdysseusTavernaChat06",
}
GameData.OdysseusResourceEvents =
{
	"OdysseusGrantsMetaCardPoints01",
	"OdysseusGrantsOreFSilver01",
	"OdysseusGrantsMetaCurrency01",
	"OdysseusGrantsPlantFMoly01",
	"OdysseusGrantsPlantFMoly01_B",
	"OdysseusGrantsMemPointsCommon01",
	"OdysseusGrantsMemPointsCommon01_B",
	"OdysseusGrantsMetaFabric01",
	"OdysseusGrantsMetaFabric01_B",
	"OdysseusGrantsCardUpgradePoints01",
	"OdysseusGrantsSeedMystery01",
	"OdysseusGrantsFamiliarPoints01",
	"OdysseusGrantsGiftPoints01",
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
	"ArachneCurseQuestComplete01",
}
GameData.AthenaKeepsakeEvents =
{
	"AthenaAboutErebus01",
	"AthenaAboutOceanus01",
	"AthenaAboutFields01",
	"AthenaAboutTartarus01",
	"AthenaAboutEphyra01",
	"AthenaAboutThessaly01",
	"AthenaAboutSummit01",
	"AthenaAboutSummit02",
	"AthenaAboutKeepsake01",
}
GameData.ChronosFinalPhaseTauntEvents =
{
	"TyphonAltFightFinalRound01",
	"TyphonAltFightFinalRound02",
	"TyphonAltFightFinalRound03",
	"TyphonAltFightFinalRound04",
	"TyphonAltFightFinalRound05",
	"TyphonAltFightFinalRound06",
	"TyphonAltFightFinalRound07",
	"TyphonAltFightFinalRound08",
	"TyphonAltFightFinalRound09",
	"TyphonAltFightFinalRound10",
	"TyphonAltFightFinalRound11",
	"TyphonAltFightFinalRound12",
}
GameData.BlockPreRunExitDoorEvents =
{
	-- all events here need PostLineFunctionName = "UnblockHubExitForNarrative"
	"HecateAboutChronosBossW01",
	"HecateAboutStormStop01",
	"HecateAboutStormStop01_B",
	"HecateAboutTyphonFight03",
	"HecateAboutTyphonFight03_B",
	"HecateAboutChronosBossW04",
}
GameData.NeoChronosErebusEvents =
{
	"NeoChronosPostEpilogue01",
	"NeoChronosWithNemesis01",
	"NeoChronosAboutNemesis01",
	"NeoChronosAboutErebus01",
	"NeoChronosAboutFates01",
	"NeoChronosAboutFailure01",
	"NeoChronosAboutChronos01",
	"NeoChronosAboutAnomaly01",
	"NeoChronosAboutGoldenAge01",
	"NeoChronosAboutPrometheus01",
	"NeoChronosAboutTyphon01",
	"NeoChronosAboutKeepsake01",
	"NeoChronosAboutBoons01",
	"NeoChronosAboutNewJob01",
	"NeoChronosAboutBeard01",
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
	"NemesisCombatI",

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
	"MiniBossTalos",
	"MiniBossDragon",
	"MiniBossBrute",
	"MiniBossStalker",

	"BossHecate01",
	"BossHecate02",
	"BossScylla01",
	"BossScylla02",
	"BossInfestedCerberus01",
	"BossInfestedCerberus02",
	"BossChronos01",
	"BossChronos02",
	"BossPolyphemus01",
	"BossPolyphemus02",
	"BossEris01",
	"BossEris02",
	"BossPrometheus01",
	"BossPrometheus02",
	"BossTyphonTail01",
	"BossTyphonHead01",
	"BossTyphonHead02",
}

GameData.CombatUniqueEncounters =
{
	"BossHecate01",
	"BossHecate02",
	"BossScylla01",
	"BossScylla02",
	"BossInfestedCerberus01",
	"BossInfestedCerberus02",
	"BossChronos01",
	"BossChronos02",
	"BossPolyphemus01",
	"BossPolyphemus02",
	"BossEris01",
	"BossEris02",
	"BossPrometheus01",
	"BossPrometheus02",
	"BossTyphonTail01",
	"BossTyphonHead01",
	"BossTyphonHead02",

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
	"EarthElementalIntro",

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
	"NemesisCombatI",

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

GameData.AllRunNPCs =
{
	"NPC_Arachne_01",
	"NPC_Artemis_Field_01",
	"NPC_Nemesis_01",
	"NPC_Narcissus_01",
	"NPC_Echo_01",
	"NPC_Hades_01",
	"NPC_Hades_Field_01",
	"NPC_Hades_02",
	"NPC_Heracles_01",
	"NPC_Medea_01",
	"NPC_Circe_01",
	"NPC_Icarus_01",
	"NPC_Dionysus_01",
	"NPC_Athena_01",
	"NPC_Hermes_01",
}

GameData.AllDuoBoons =
{
	"SuperSacrificeBoonZeus",
	"SuperSacrificeBoonHera",
	"LightningVulnerabilityBoon",
	"RootStrikeBoon",
	"ApolloSecondStageCastBoon",
	"SprintEchoBoon",
	"ReboundingSparkBoon",
	"EchoBurnBoon",
	"AutoRevengeBoon",

	"MoneyDamageBoon",
	"KeepsakeLevelBoon",
	"RaiseDeadBoon",
	"CharmCrowdBoon",
	"ManaShieldBoon",
	"ManaRestoreDamageBoon",
	"BloodRetentionBoon",

	"GoodStuffBoon",
	"PoseidonSplashSprintBoon",
	"AllCloseBoon",
	"MassiveCastBoon",
	"SteamBoon",
	"DoubleSplashBoon",

	"StormSpawnBoon",
	"MaxHealthDamageBoon",
	"ClearRootBoon",
	"BurnConsumeBoon",
	"SelfCastBoon",

	"ManaBurstCountBoon",
	"BlindClearBoon",
	"CoverRegenerationBoon",
	"DoubleSwordBoon",

	"SlamManaBurstBoon",
	"BurnRefreshBoon",
	"BloodManaBurstBoon",

	"DoubleMassiveAttackBoon",
	"RapidSwordBoon",
	
	"FireballRendBoon",
}
GameData.AllElementalBoons =
{
	"ElementalDamageFloorBoon", -- Zeus
	"ElementalRarityUpgradeBoon", -- Hera
	"ElementalDamageCapBoon", -- Demeter
	"ElementalHealthBoon", -- Poseidon
	"ElementalRallyBoon", -- Apollo
	"ElementalDodgeBoon", -- Aphrodite
	"ElementalDamageBoon", -- Hephaestus
	"ElementalBaseDamageBoon", -- Hestia
	"ElementalOlympianDamageBoon", -- Ares
	"ElementalUnifiedBoon", -- Hermes
}
GameData.AllLegendaryBoons =
{
	"SpawnKillBoon", -- Zeus
	"AllElementalBoon", -- Hera
	"InstantRootKill", -- Demeter
	"AmplifyConeBoon", -- Poseidon
	"DoubleExManaBoon", -- Apollo
	"RandomStatusBoon", -- Aphrodite
	"WeaponUpgradeBoon", -- Hephaestus
	"BurnSprintBoon", -- Hestia
	"DoubleBloodDropBoon", -- Ares
	"TimeStopLastStandBoon", -- Hermes
}
GameData.AllRewardTraits =
{
	"EscalatingCostume", -- Arachne
	"NarcissusG", -- Narcissus
	"EchoRepeatKeepsakeBoon", -- Echo
	"HadesInvisibilityRetaliateBoon", -- Hades
	"NewStatusDamage", -- Medea
	"ExPolymorphBoon", -- Circe
	"RandomBaseDamageBoon", -- Dionysus
	"SorceryCritBoon", -- Artemis
	"OlympianSpellCountBoon", -- Athena
	"UpgradeHammerBoon", -- Icarus
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

GameData.AllMetaUpgradeTraits =
{
	"ChannelSlowMetaUpgrade",
	"DoorHealMetaUpgrade",
	"LowManaDamageMetaupgrade",
	"CastDamageMetaUpgrade",
	"SorceryRegenMetaUpgrade",
	"InsideCastBuffMetaUpgrade",
	"HealthManaBonusMetaUpgrade",
	"DodgeBonusMetaUpgrade",
	"ManaOverTimeMetaUpgrade",
	"MagicCritMetaUpgrade",
	"SprintShieldMetaUpgrade",
	"LastStandSlowTimeMetaUpgrade",
	"ChamberHealthMetaUpgrade",
	"EffectVulnerabilityMetaUpgrade",
	"BossShieldMetaUpgrade",
	"DoorRerollMetaUpgrade",
	"StartingGoldMetaUpgrade",
	"MetaToRunMetaUpgrade",
	"RarityBoostMetaUpgrade",
	"DuoRarityBoostMetaUpgrade",
	"RerollTradeOffMetaUpgrade",
	"PanelRerollMetaUpgrade",
	"LowHealthBuffMetaUpgrade",
	"EpicRarityBoostMetaUpgrade",
	"BossProgressionMetaUpgrade",
}

GameData.AllHexDuos =
{
	"PolymorphZeusTalent",
	"SummonHeraTalent",
	"PotionPoseidonTalent",
	"TimeSlowDemeterTalent",
	"LaserApolloTalent",
	"TransformAphroditeTalent",
	"LeapHephaestusTalent",
	"MeteorHestiaTalent",
	"MoonBeamAresTalent",
}

-- count: 18
GameData.AllWeaponAspects =
{
	"StaffClearCastAspect",
	"StaffSelfHitAspect",
	"StaffRaiseDeadAspect",

	"DaggerBlockAspect",
	"DaggerHomingThrowAspect",
	"DaggerTripleAspect",

	"TorchDetonateAspect",
	"TorchSprintRecallAspect",
	"TorchAutofireAspect",

	"AxeArmCastAspect",
	"AxePerfectCriticalAspect",
	"AxeRallyAspect",

	"LobCloseAttackAspect",
	"LobImpulseAspect",
	"LobGunAspect",

	"SuitHexAspect",
	"SuitMarkCritAspect",
	"SuitComboAspect",
}
GameData.AllMaxedWeaponAspects =
{
	"BaseStaffAspect5",
	"StaffClearCastAspect5",
	"StaffSelfHitAspect5",
	"StaffRaiseDeadAspect5",

	"DaggerBackstabAspect5",
	"DaggerBlockAspect5",
	"DaggerHomingThrowAspect5",
	"DaggerTripleAspect5",

	"TorchSpecialDurationAspect5",
	"TorchDetonateAspect5",
	"TorchSprintRecallAspect5",
	"TorchAutofireAspect5",

	"AxeRecoveryAspect5",
	"AxeArmCastAspect5",
	"AxePerfectCriticalAspect5",
	"AxeRallyAspect5",

	"LobAmmoBoostAspect5",
	"LobCloseAttackAspect5",
	"LobImpulseAspect5",
	"LobGunAspect5",

	"BaseSuitAspect5",
	"SuitHexAspect5",
	"SuitMarkCritAspect5",
	"SuitComboAspect5",
}
GameData.AllHiddenAspects =
{
	"StaffRaiseDeadAspect",
	"DaggerTripleAspect",
	"TorchAutofireAspect",
	"AxeRallyAspect",
	"LobGunAspect",
	"SuitComboAspect",
}

GameData.AllExpiringKeepsakes =
{
	"BossPreDamageKeepsake",
	"ReincarnationKeepsake",
	"SpellTalentKeepsake",
	"BonusMoneyKeepsake",
	"FountainRarityKeepsake",
	"DecayingBoostKeepsake",
	"ForceZeusBoonKeepsake",
	"ForceHeraBoonKeepsake",
	"ForceAresBoonKeepsake",
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
GameData.AllFrogFamiliarUpgrades =
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
}
GameData.AllRavenFamiliarUpgrades =
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
}
GameData.AllCatFamiliarUpgrades =
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
}
GameData.AllHoundFamiliarUpgrades =
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
}
GameData.AllPolecatFamiliarUpgrades =
{
	"PolecatDodgeBonus",
	"PolecatDodgeBonus2",
	"PolecatDodgeBonus3",
	"PolecatUses",
	"PolecatUses2",
	"PolecatUses3",
	"PolecatDamage",
	"PolecatDamage2",
	"PolecatDamage3",
}

GameData.AllArachneCostumes =
{
	"VitalityCostume",
	"ManaCostume",
	"AgilityCostume",
	"IncomeCostume",
	"CastDamageCostume",
	"HighArmorCostume",
	"SpellCostume",
	"EscalatingCostume",
}

GameData.AllRandomPackagedBounties =
{
	"PackageBountyRandomUnderworld_Difficulty1",
	"PackageBountyRandomUnderworld_Difficulty2",
	"PackageBountyRandomSurface_Difficulty1",
	"PackageBountyRandomSurface_Difficulty2"
}
GameData.LateStartPackagedBounties =
{
	"PackageBountyOceanus",
	"PackageBountyOneTouch",
	"PackageBountyHealer",
	"PackageBountyChaos",
	"PackageBountyHera",
	"PackageBountyDemeter",
	"PackageBountyAphrodite",
	"PackageBountyHestia",
	"PackageBountySpeed",
	"PackageBountyCriticalHealth",
	"PackageBountyLowMana",
	"PackageBountyScylla",
	"PackageBountyStrife",
	"PackageBountyDaggerLegendary",
	"PackageBountyAxeLegendary",
	"PackageBountyTorchLegendary",
	"PackageBountySuitLegendary",
}

GameData.StrangeSeeds =
{
	"PlantOMandrakeSeed",
	"PlantQSnakereedSeed",
	"PlantChaosThalamusSeed",
}
GameData.StrangePlants =
{
	"PlantOMandrake",
	"PlantQSnakereed",
	"PlantChaosThalamus",
}

GameData.AllMusicPlayerTracks =
{
	"Song_MainTheme",
	"Song_RunStart",
	"Song_ArtemisSong",
	"Song_CharonShopTheme",
	"Song_ArachneTheme",
	"Song_ArtemisTheme",
	"Song_NemesisTheme",
	"Song_NarcissusTheme",
	"Song_EchoTheme",
	"Song_MedeaTheme",
	"Song_HeraclesTheme",
	"Song_CirceTheme",
	"Song_IcarusTheme",
	"Song_DionysusMusic",
	"Song_HypnosMusic",
	"Song_Exploration1",
	"Song_Exploration2",
	"Song_Erebus2",
	"Song_Scylla1a",
	"Song_Scylla1b",
	"Song_Scylla2a",
	"Song_Scylla2b",
	"Song_Scylla3a",
	"Song_Scylla3b",
	"Song_Scylla4a",
	"Song_Scylla4b",
	"Song_MourningFields1",
	"Song_MourningFields2",
	"Song_ClockworkTartarusRegular",
	"Song_ClockworkTartarusMiniboss",
	"Song_FilthyArp",
	"Song_Ephyra2",
	"Song_Ephyra3",
	"Song_Ships1",
	"Song_Ships2",
	"Song_BiomeStartOlympus",
	"Song_Olympus1",
	"Song_Olympus2",
	"Song_MinibossTheme",
	"Song_TimedEncounter",
	"Song_FishingMusicLoop",
	"Song_EndThemeAcoustic",
	"Song_EndThemeOrchestral",
	"Song_ChronosBossFightMusic",
	"Song_ChronosBossFightMusicAlt",
	"Song_MusicTyphon1",
	"Song_MusicTyphon2",
	"Song_MusicTyphon2b",
	"Song_ApolloSong",
	"Song_IrisEndTheme",
	"Song_IrisEndThemeAcoustic",
	"Song_ZagreusTheme",
}

-- these groupings are to aid with localization
GameData.FormalRelationships =
{
	"NPC_Charon_01",
	"NPC_Chronos_01",
	"NPC_Chronos_02",
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
	"NPC_Hades_02",
	"NPC_Zeus_Story_01",
	"NPC_Hera_Story_01",
	"NPC_Hecate_Story_01",
	"NPC_Demeter_Story_01",
	"NPC_Persephone_01",
	"NPC_Nyx_01",
	"NPC_Nyx_Story_01",
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
	"AresUpgrade",
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
	"NPC_Zagreus_01",
}

GameData.DreamSequenceData =
{
	SwapSounds =
	{
		["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
		["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
	},
}
GameData.NightmareSequenceData =
{
	SwapSounds =
	{
		["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsSand",
		["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsSandTemp",
	},
}

GameData.PostBathHouseArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	SoundName = "/Leftovers/SFX/AuraOff",
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 12 },
}
GameData.PostFishingArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	SoundName = "/Leftovers/SFX/AuraOff",
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 16 },
}
GameData.PostTavernaArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	SoundName = "/Leftovers/SFX/AuraOff",
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 20 },
}
GameData.PostIntermissionArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	SoundName = "/Leftovers/SFX/AuraOff",
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 10 },
}
GameData.PostDreamArgs =
{
	TargetHero = true,
	PreDelay = 1.0,
	Duration = 1.0,
	SoundName = "/Leftovers/SFX/AuraOff",
	Text = "TimePassesClocks",
	LuaKey = "TempTextData",
	LuaValue = { TimerTicks = 8 },
}

PartnerConversationDataShare =
{
	"OnQueuedFunctionName",
	"OnQueuedFunctionArgs",
	"UseText",
	"UseableOffSource",
	"BlockDistanceTriggers",
}

ScreenData.Dialog =
{
	Name = "Dialog",
	FreezePlayerArgs =
	{
		StopRotation = false,
	},
	
	PlayedPortraitEnterSounds = {},
	DefaultGroup = "Combat_Menu_Overlay",
	LeakedIds = {},
	ChoiceIds = {},

	ComponentData =
	{
		UseNativeScreenCenter = true,

		SpeakerDisplayName =
		{
			LangOffsetY =
			{
				{ Code = "en", Value = 0 },
				{ Code = "ja", Value = -2 },
			},
		},

		SpeakerDescription =
		{
			LangOffsetY =
			{
				{ Code = "en", Value = 0 },
				{ Code = "ja", Value = 2 },
			},
		},

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
		},

		ChoiceButtons =
		{
			{
				Graphic = "ContextualActionButton",
				Animation = "NarrativeScreenButton_Cancel",
				MouseOverAnimation = "NarrativeScreenButtonMouseOver_Cancel",
				X = 1350,
				Y = 890,
				Data =
				{

					OnMouseOverFunctionName = "MouseOverNarrativeChoiceButton",
					OnMouseOffFunctionName = "MouseOffNarrativeChoiceButton",
					Sound = "/SFX/Menu Sounds/IrisMenuBack",
					ControlHotkeys = { "Cancel", },
				},
				TextArgs =
				{
					OffsetY = -3,
					OffsetX = -5,
					FontSize = 20,
					Width = 415,
					LineSpacingBottom = 0,
					Color = { 183, 135, 214, 255 },
					Font = "LatoBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "CENTER",
					VerticalJustification = "CENTER",
					TextSymbolScale = 0.8,
				},
			},
			{
				Graphic = "ContextualActionButton",
				Animation = "NarrativeScreenButton_Confirm",
				MouseOverAnimation = "NarrativeScreenButtonMouseOver_Confirm",
				X = 950,
				Y = 890,
				Data =
				{
					OnMouseOverFunctionName = "MouseOverNarrativeChoiceButton",
					OnMouseOffFunctionName = "MouseOffNarrativeChoiceButton",
					Sound = "/SFX/Menu Sounds/GodBoonInteract",
					ControlHotkeys = { "Confirm", },
				},
				TextArgs =
				{
					OffsetY = -3,
					OffsetX = -5,
					FontSize = 20,
					Width = 415,
					LineSpacingBottom = 0,
					Color = { 183, 135, 214, 255 },
					Font = "LatoBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "CENTER",
					VerticalJustification = "CENTER",
					TextSymbolScale = 0.8,
				},
			},
		},
	}
}