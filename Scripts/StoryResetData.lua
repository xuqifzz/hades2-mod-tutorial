ScreenData.StoryResetPromptLayout =
{
	Components = {},

	InfoMessageId = "StoryResetIntro",

	OpenSound = "/SFX/Menu Sounds/HadesLocationTextAppear",
	CloseSound = "/SFX/Menu Sounds/IrisMenuBack",

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_TraitTray_Backing",
		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "MythmakerBoxDefault",
			GroupName = "Combat_Menu_TraitTray",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Scale = 1.15,
			Children = 
			{
				TitleText = 
				{
					Text = "StoryReset_Title",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -300,
					TextArgs =
					{
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "P22UndergroundSCMedium",
						FontSize = 40,
						Color = { 221, 211, 211, 255 },
						OutlineColor = { 27, 26, 23, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				DescriptionText = 
				{
					Text = "StoryReset_Details",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -100,
					TextArgs =
					{
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "LatoMedium",
						FontSize = 26,
						Width = 750,
						TextSymbolScale = 0.8,
						Color = { 207, 225, 217, 255 },
						OutlineColor = { 52, 51, 49, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				
				ConfirmButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.2,
					OffsetX = -220,
					OffsetY = 100,
					Alpha = 0.0,
					Text = "StoryReset_Confirm",
					TextArgs =
					{
						FontSize = 26,
						Width = 600,
						OffsetY = 0,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "ConfirmStoryResetPromptScreen",
						PressSound = "/SFX/Menu Sounds/IrisMenuBack",
					}
				},
				CloseButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.2,
					OffsetX = 220,
					OffsetY = 100,
					Text = "StoryReset_Cancel",
					TextArgs =
					{
						FontSize = 26,
						Width = 600,
						OffsetY = 0,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CancelStoryResetPromptScreen",
						PressSound = "/SFX/Menu Sounds/IrisMenuBack",
					}
				},
			}
		},
	}
}

StoryResetData =
{
	WorldUpgrades =
	{
		"WorldUpgradeStormStop",
		"WorldUpgradeTimeStop",
		"WorldUpgradeWakeHypnosT3",
	},

	Quests =
	{
		"QuestRescueFatesTrue",
		"QuestWakeHypnos",
	},

	Resources =
	{
		"HadesSpearPoints",
		"MixerMythic",
		"DeathAreaPoints",
	},

	TextLines =
	{
		-- hecate
		"HecatePostTrueEnding01",
		"HecatePostTrueEnding02",
		"HecatePostTrueEnding03",
		"HecatePostTrueEnding04",

		"HecatePostEpilogue01",
		"HecatePostEpilogue02",

		-- "NyxWithHecate01",
		"NemesisWithHecate02",

		"HecateBathHouseEpilogue01",

		"HecateAboutTyphonDeath01",
		"HecateAboutChronosBossW01",
		"HecateAboutChronosBossW01Cont1",
		"HecateAboutChronosBossW02",
		"HecateAboutChronosBossW03",
		"HecateAboutTimeStop01",
		-- "HecateAboutStormStop01",
		-- "HecateAboutStormStop01_B",
		-- "HecateAboutChronosBossW04",
		-- "HecateAboutStormStop01_B",
		"HecateAboutChronosBossW04_A",
		"HecateAboutChronosBossW04_B",
		-- "HecateUnderworldRunCleared01",
		-- "HecateAboutTyphonFight01",
		-- "HecateAboutTyphonFight01_B",
		-- "HecateAboutTyphonFight02",
		-- "HecateAboutTyphonFight02_B",
		"HecateAboutTyphonFight03",
		"HecateAboutUltimateProgress02",
		"HecateAboutUltimateProgress03_A",
		"HecateAboutUltimateProgress03",
		"HecateAboutUltimateProgress04",
		"HecateAboutStormStopNotCast01",
		"HecateAboutTyphonW02",
		-- "HecateAboutPalace01",

		-- "HecateAboutHades01",
		-- "HecateAboutHades01_B",
		-- "HecateAboutHades02",

		"HecateBossPostTrueEnding01",
		"HecateBossPostTrueEnding02",
		"HecateBossPostEpilogue01",
		"HecateBossPostEpilogue02",

		"HecateBossKidnapped01",
		"HecateBossAboutEndingPath00",
		"HecateBossAboutEndingPath01",
		"HecateBossAboutEndingPath02",
		"HecateBossAboutEndingPath03",
		"HecateBossAboutEndingPath04",

		-- "HecateBossAboutChronosBossW00",

		-- "HecateBossAboutFates01",
		-- "HecateBossAboutChronosBossW01",
		"HecateBossAboutChronosBossW02",

		-- dora
		"DoraPostTrueEnding01",
		"DoraPostTrueEnding02",
		"DoraPostEpilogue01",
		"DoraAboutChronosBossW01",
		"DoraAboutChronosBossW02",

		-- odysseus
		"OdysseusAboutTyphonDeath01",
		"OdysseusAboutHecateKidnapped01",
		"OdysseusPostTrueEnding01",
		"OdysseusPostTrueEnding02",
		"OdysseusPostTrueEndingAboutHouse01",
		"OdysseusPostTrueEndingAboutTyphon01",
		"OdysseusPostEpilogue01",
		"OdysseusPostEpilogue02",
		"OdysseusAboutTyphonW01",
		"OdysseusAboutTyphonW02",
		"OdysseusAboutTyphonDeath01",
		"OdysseusAboutUltimateProgress01",
		"OdysseusAboutChronosBossW01",

		-- nemesis
		"NemesisPostTrueEnding01",
		"NemesisPostTrueEnding02",
		"NemesisPostTrueEnding03",
		"NemesisAboutHecateKidnapped01",
		"NemesisAboutTyphonDeath01",
		"NemesisWithHecate02",
		"NyxWithNemesis01",
		"NemesisPostEpilogue01",
		"NemesisAboutChronosBossW01",
		"NemesisAboutChronosBossFights01",
		"NemesisAboutUltimateProgress01",
		-- "NemesisAboutChronosNightmare01",
		-- "NemesisAboutChronosNightmare02",
		-- "NemesisAboutChronosNightmare02_B",
		"NemesisAboutTyphonW01",
		"NemesisAboutTyphonW02",
		"NemesisAboutNyx01",
		"NemesisAboutNyxRescue01",
		-- "NemesisPostTrueEndingTimeStopped01",

		-- moros
		"MorosPostEpilogue01",
		"MorosPostTrueEnding01",
		"MorosPostTrueEnding02",
		"MorosAboutHecateKidnapped01",
		"MorosAboutEpilogueProgress01",
		"MorosAboutPostEndingChronosBossW01",
		"MorosAboutPostEndingTyphonW01",
		"MorosPostEpilogue02",
		"MorosPostEpilogue03",
		"MorosAboutTyphonW01",
		"MorosAboutPostEndingTyphonW01",
		"MorosAboutTyphonDeath01",
		"MorosAboutChronosBossW01",
		"MorosAboutChronosBossW02",

		-- eris
		"ErisPostTrueEnding01",
		"ErisPostTrueEnding02",
		"ErisPostTrueEnding03",
		"ErisPostTrueEnding04",
		"ErisAboutRunCleared01",
		"ErisAboutSurfaceRunCleared01",
		"ErisAboutChronos01",
		"ErisAboutUltimateProgress01",
		"ErisPostEpilogue01",
		"ErisPostEpilogue02",

		"ErisBossAboutTyphon03",
		"ErisBossAboutTyphonDeath01",
		"ErisBossPostTrueEnding01",

		-- skelly
		"SkellyPostTrueEnding01",
		"SkellyPostTrueEnding02",
		"SkellyPostEpilogue01",
		"SkellyAboutZagreusFight01",
		"SkellyAboutUltimateProgress01",
		"SkellyAboutChronosBossW01",
		-- "SkellyAboutChronosBossW02",
		"SkellyAboutChronosBossW03",
		"SkellyAboutTyphonW01",
		"SkellyAboutTyphonW02",

		-- charon
		"CharonPostEpilogue01",
		"CharonPostTrueEnding01",
		"CharonPostTrueEnding02",
		"CharonAboutTyphon02",
		"CharonAboutChronosBossW01",

		-- arachne
		"ArachnePostTrueEnding01",
		"ArachnePostTrueEnding02",
		"ArachneAboutUltimateProgress01",
		"ArachnePostEpilogue01",
		"ArachnePostEpilogue02",

		-- narcissus

		-- echo
		"EchoPostTrueEnding01",

		-- hades & persephone
		"HadesAboutChronosBossW01",
		"HadesAboutChronosBossW01_B",
		"HadesAboutTyphon02",
		"HadesAboutUltimateProgress03",
		"HadesAboutUltimateProgress02",
		"HadesAboutUltimateProgress01",

		-- "HadesWithPersephone01", (re-added below)
		"HadesWithPersephonePostEpilogue01",
		"HadesWithPersephonePostEpilogue02",
		"HadesWithPersephonePostEpilogue03",

		-- medea
		"MedeaPostTrueEnding01",

		-- heracles
		"HeraclesPreEncounterAboutTrueEnding01",
		"HeraclesFieldAboutTrueEnding01",
		"HeraclesFieldAboutTrueEnding02",
		"HeraclesFieldAboutEpilogue01",
		"HeraclesFieldAboutTyphon02",

		-- icarus
		"IcarusPostTrueEnding01",
		"IcarusPostTrueEnding01_B",
		"IcarusPostTrueEnding02",
		"IcarusPostTrueEnding03",

		"IcarusHomeAboutTyphonDeath01",
		"IcarusHomePostTrueEnding01",
		"IcarusHomePostTrueEnding02",
		"IcarusHomePostEpilogue01",
		"IcarusHomePostEpilogue02",

		-- circe
		"CircePostTrueEnding01",
		"CircePostTrueEnding02",
		"CircePostTrueEnding03",
		"CircePostEpilogue01",
		"CirceAboutTyphonW01",

		-- selene
		"SelenePostTrueEnding01",
		"SelenePostTrueEnding02",
		"SelenePostEpilogue01",
		"SeleneAboutTyphonW01",
		"SeleneAboutTyphonW02",
		"SeleneRunCleared02",
		"SeleneRunCleared03",
		-- "SeleneSurfaceRunCleared01",
		"SelenePostTrueEndingRunCleared01",
		"SelenePostTrueEndingRunCleared02",

		-- zeus
		"ZeusPostEpilogue01",
		"ZeusPostEpilogue02",

		"ZeusPostTrueEnding01",
		"ZeusPostTrueEnding02",
		"ZeusPostTrueEnding03",
		"ZeusAboutTyphonW04",
		"ZeusAboutTyphonW01",
		"ZeusAboutTyphonW02",
		"ZeusAboutTyphonW03",
		"ZeusAboutTyphonW04",
		"ZeusUnderworldRunCleared02",
		"ZeusUnderworldRunCleared03",
		"ZeusUnderworldRunCleared04",

		-- hera
		"HeraPostEpilogue01",
		"HeraPostTrueEnding01",
		"HeraAboutPalace01",
		"HeraAboutPalace02",
		"HeraAboutTyphonDeath01",
		"HeraAboutTyphonDeath02",
		"HeraAboutTyphonW01",
		"HeraPostTrueEndingAboutSurface01",
		"HeraPostEpilogue02",

		-- poseidon
		"PoseidonPostTrueEnding01",
		"PoseidonPostTrueEnding02",
		"PoseidonPostEpilogue01",
		"PoseidonPostEpilogue02",
		"PoseidonAboutTyphonDeath01",
		"PoseidonAboutPalace01",
		"PoseidonSurfaceRunCleared01",
		"PoseidonSurfaceRunCleared02",
		-- "PoseidonSurfaceRunStartPostUnderworldW01",
		"PoseidonUnderworldRunCleared02",
		"PoseidonUnderworldRunCleared03",

		-- demeter
		"DemeterPostTrueEnding01",
		-- "DemeterPostTrueEnding02",
		"DemeterPostTrueEnding03",

		"DemeterPostEpilogue01",
		"DemeterPostEpilogue02",
		"DemeterAboutTyphonW01",
		"DemeterAboutTyphonW02",
		"DemeterAboutTyphonDeath01",
		"DemeterAboutTyphonDeath02",
		"DemeterAboutChronosBossW01",
		"DemeterAboutChronosBossW02",

		-- apollo
		"ApolloPostEpilogue01",
		"ApolloPostTrueEnding01",
		"ApolloAboutTyphonDeath01",
		"ApolloAboutTyphonDeath02",
		"ApolloAboutChronosBossW01",
		"ApolloAboutChronosBossW02",
		"ApolloAboutPalace01",
		"ApolloAboutTyphonW01",
		"ApolloAboutTyphonW02",
		"ApolloAboutTyphonW03",
		"ApolloUnderworldRunCleared03",

		-- aphrodite
		"AphroditeAboutTyphonDeath01",
		"AphroditePostTrueEnding01",
		"AphroditePostTrueEnding02",
		"AphroditeAboutTyphonW01",
		"AphroditeAboutChronosBossW01",
		"AphroditePostEpilogue01",
		"AphroditeUnderworldRunCleared02",

		-- hephaestus
		"HephaestusAboutTyphonDeath01",
		"HephaestusAboutTyphonDeath02",
		"HephaestusPostTrueEnding01",
		"HephaestusPostTrueEnding02",
		"HephaestusPostTrueEnding03",
		"HephaestusPostEpilogue01",
		"HephaestusPostEpilogue02",
		"HephaestusUnderworldRunCleared02",
		"HephaestusAboutChronosBossW01",

		-- hestia
		"HestiaAboutTyphonDeath01",
		"HestiaPostTrueEnding01",
		"HestiaPostTrueEnding02",
		"HestiaPostEpilogue01",
		"HestiaSurfaceRunCleared01",
		"HestiaSurfaceRunCleared03",
		"HestiaAboutWinStreak01",
		"HestiaUnderworldRunCleared01",
		"HestiaUnderworldRunCleared02",
		"HestiaUnderworldRunCleared03",
		"HestiaAboutChronosBossW01",
		"HestiaAboutChronosBossW02",

		-- ares
		"AresPostTrueEnding01",
		"AresPostEpilogue01",
		"AresPostTrueEndingAboutChronos01",
		"AresPostTrueEndingAboutChronos02",
		"AresPostTrueEndingAboutTyphon01",
		"AresAboutTyphonDeath01",
		"AresUnderworldRunCleared01",
		"AresUnderworldRunCleared02",
		"AresUnderworldRunCleared03",
		"AresPostTrueEnding02",

		-- hermes
		"HermesPostEpilogue01",
		"HermesPostEpilogue02",
		"HermesPostEpilogue03",
		"HermesAboutTyphonDeath01",
		"HermesPostTrueEnding01",
		"HermesPostTrueEnding02",
		"HermesPostTrueEnding03",
		"HermesAboutUltimateProgress01",
		"HermesAboutFatesQuest01",
		"HermesUnderworldRunCleared01",
		"HermesSurfaceRunCleared02",

		"HermesFieldAboutTyphon03",
		"HermesFieldAboutTyphonDeath01",

		-- artemis
		"ArtemisPostTrueEnding01",
		"ArtemisPostEpilogue01",
		"ArtemisAboutChronosBossW01",
		"ArtemisAboutChronosBossW02",
		"ArtemisAboutTyphon02",

		-- athena
		"AthenaPostTrueEnding01",
		"AthenaPostTrueEnding02",
		"AthenaPostEpilogue01",
		"AthenaAboutTyphonDeath01",
		"AthenaAboutTyphonW01",
		-- "AthenaAboutTyphonW02",
		-- "AthenaAboutUltimateProgress01",
		"AthenaPostEpilogue02",
		"AthenaAboutChronosBossW01",

		-- dionysus
		"DionysusPostTrueEnding01",
		"DionysusPostTrueEnding02",
		"DionysusPostTrueEnding03",
		"DionysusPostEpilogue01",

		-- scylla
		"ScyllaAboutGrandeur01",
		"ScyllaPostTrueEnding01",
		"ScyllaPostTrueEnding02",

		-- prometheus
		"PrometheusAboutUltimateProgress01",
		"PrometheusAboutUltimateProgress02",
		"PrometheusAboutTyphon03",
		"PrometheusPostTrueEnding01",
		"PrometheusPostTrueEnding02",
		"PrometheusPostTrueEnding03",
		"PrometheusAboutEpilogue01",
		"PrometheusAboutEpilogue02",
		"PrometheusAboutEpilogue03",
		"PrometheusAboutEpilogue04",
		-- "PrometheusAboutPostTyphon02",

		-- polyphemus
		"PolyphemusPostTrueEnding01",
		"PolyphemusPostTrueEnding02",
		"PolyphemusPostTrueEnding03",

		-- chaos / trialupgrade
		"ChaosPostTrueEnding01",
		"ChaosAboutTyphonDeath01",
		"ChaosPostTrueEnding02",
		"ChaosPostEpilogue01",
		"ChaosWithNyx01",
		"ChaosUnderworldSurfaceCleared01",
		"ChaosUnderworldSurfaceCleared02",
		"ChaosPostTrueEndingRunCleared01",
		"ChaosPostTrueEndingAboutNyx01",

		-- nyx
		"NyxInChaos01",
		"NyxInChaosPostEpilogue01",

		-- hypnos
		"HypnosAboutUltimateProgress01",
		"HypnosAboutUltimateProgress02",
		"HypnosPostTrueEnding01",
		"HypnosPostTrueEnding02",

		-- chronos
		"ChronosPostBattleMeeting01",
		"ChronosMeetingAboutTyphon02",
		"ChronosMeetingAboutTyphonW01",

		-- chronos boss
		-- "ChronosBossFirstMeeting",
		-- "ChronosBossFirstMeeting_B",
		-- "ChronosBossFirstMeeting_C",
		-- "ChronosBossWonAgainstHim01",
		-- "ChronosBossLostAgainstHim01",
		"ChronosBossAboutTyphon02",
		-- "ChronosBossAboutTyphon03",
		"ChronosBossAboutTyphonDeath01",

		"ChronosBossAboutFamily01",
		"ChronosBossAboutFamily02",
		"ChronosBossAboutFamily03",
		"ChronosBossAboutFamily04",
		"ChronosBossAboutFamily05",

		"ChronosBossPostTrueEnding01",
		"ChronosBossPostTrueEnding02",
		"ChronosBossAboutHecateKidnapped01",
		"ChronosBossAboutHecateKidnapped02",

		"ChronosBossOutro01",
		"ChronosBossOutroAfterHecateKidnapped01",
		"ChronosBossOutroPostTrueEnding01",
		"ChronosBossOutroUltimateProgress01",
		"ChronosBossOutroUltimateProgress02",
		"ChronosBossOutroPreTrueEnding01",
		"ChronosBossOutroPreTrueEnding01_B",
		"ChronosBossOutroUltimateProgress03",
		"ChronosBossOutroUltimateProgress04",
		"ChronosBossOutroUltimateProgress05",

		-- neochronos
		"NeoChronosAboutTartarus01",
		"NeoChronosAboutTartarus01_B",
		"NeoChronosAboutTartarus02",
		"NeoChronosAboutOlympus01",
		"NeoChronosAboutOlympus01_B",
		"NeoChronosAboutOlympus02",
		"NeoChronosAboutErebus01",
		"NeoChronosPostEpilogue01",
		-- "NeoChronosAboutFates01",

		-- zagreus
		"ZagreusPastFirstMeeting",
		"ZagreusPastMeeting02",
		"ZagreusPastMeeting02_2",
		"ZagreusPastMeeting03",
		"ZagreusPastMeeting04",
		"ZagreusPastMeeting04_2",
		"ZagreusPastMeeting04_3",
		"ZagreusPastMeeting05",
		"ZagreusPastMeeting06",
		"ZagreusPastMeeting06_B",
		"ZagreusPastMeeting07",
		"ZagreusPastMeeting08",

		"ZagreusBossFirstMeeting",
		"ZagreusBossOutro01",

		-- zeus + hera palace
		"ZeusPalaceFirstMeeting",
		"ZeusPalaceMeeting02",
		"ZeusPalaceMeeting03",
		"ZeusPalaceMeeting03_A",
		"ZeusPalaceMeeting03_B",
		"ZeusPalaceAboutTyphonDeath01",
		"ZeusPalaceMeeting04",
		"ZeusPalaceMeeting04_B",
		"ZeusPalacePostTrueEnding01",

		-- apollo palace
		"ApolloPalaceFirstMeeting",
		"ApolloPalaceMeeting02",
		"ApolloPalaceMeeting03",
		"ApolloPalaceAboutTyphonDeath01",
		"ApolloPalaceMeeting04",
		"ApolloPalaceMeeting04_B",
		"ApolloPalacePostTrueEnding01",

		-- demeter palace
		"DemeterPalaceFirstMeeting",
		"DemeterPalaceAboutTyphonDeath01",
		"DemeterPalacePostTrueEnding01_B",

		-- palace exit boon
		"PalaceBoonExitPostTrueEnding01",
		"PalaceBoonExit02",
		"PalaceBoonExit01",
		"PalaceBoonExitTyphonDestroyed01",

		-- chronos flashback
		"MelinoeHideAndSeek01",
		"HadesHideAndSeek01",

		-- true ending
		"PreTrueEnding01",
		"TrueEnding01",
		"TrueEnding02",
		"ZagreusTrueEnding01",
		"AchillesTrueEnding01",
		"HadesTrueEnding01",
		"PersephoneTrueEnding01",
		"CerberusTrueEnding01",
		"SeleneTrueEnding01",
		"TrueEndingFinale01",
		"TrueEndingFinaleResponse01",

		-- post true ending
		-- hypnos quest
		"HadesWithPersephone01", -- needed to provide DeathAreaPoints
		"HypnosWakeUp03",
		"HypnosDreamMeeting03",
		"HypnosWakeUp03_B",
		"HypnosDreamMeeting03_B",
		"HypnosWakeUp03_C",
		"HypnosFinalDreamMeeting01",
		"HypnosAboutStoryReset01",

		-- inspect points
		-- "Inspect_I_PostBoss01_01",
		-- "Inspect_I_PostBoss01_02",
		-- "Inspect_Q_PostBoss_01",
		-- "Inspect_Q_PostBoss_02",
		-- "Inspect_Q_Story_01",
		-- "Inspect_Q_Story_02",
		"Inspect_I_Boss01TrueEnding_01",

		-- epilogue
		"FatesEpilogue01",
	},

	VoiceLines =
	{
		"FirstInfernalContractVO",
		"/VO/MelinoeField_4282",
		"/VO/MelinoeField_4283",

		-- ZagreusPastGreetingLines
		"/VO/Zagreus_0007",
		"/VO/Zagreus_0018",
		"/VO/Zagreus_0027",
		"/VO/Zagreus_0035",
		"/VO/Zagreus_0044",
		"/VO/Zagreus_0058",
		"/VO/Zagreus_0063",
		"/VO/Zagreus_0443",
		"/VO/Zagreus_0453",
		"/VO/Zagreus_0051",

		"ZagreusBossFirstMeetingVO",
		"/VO/MelinoeField_4236",

		"FirstIPreBoss02VisitSpeech",
		"/VO/MelinoeField_4190",

		"ChronosEarlyIntroVO",
		"/VO/Chronos_0203",

		"ChronosEarlyIntroVOB",
		"/VO/Chronos_0206",

		"ChronosPostEndingIntroVO",
		"/VO/Chronos_1048",

		"ChronosPreFightTyphonDeathVO",
		"/VO/Chronos_0983",

		"ChronosFinalFightLastStandVO",
		"/VO/Chronos_1507",
		"/VO/Chronos_1508",
		"/VO/Chronos_1509",
		"/VO/Chronos_1521",
		"/VO/Chronos_1522",
		"/VO/Chronos_1524",
		"/VO/Chronos_1523",
		"/VO/Chronos_1525",
		"/VO/Chronos_1505",
		"/VO/Chronos_1506",

		"FinalChronosKillVO",
		"/VO/MelinoeField_5097",

		"ChronosRemainsVO",
		"/VO/MelinoeField_5096",
		"/VO/MelinoeField_3882",

		"ChronosHecKidnappedIntroVO",
		"/VO/Chronos_0984",

		"ReachedTartarusHecateMissingSpeech",
		"/VO/Melinoe_5197",

		"ZagBedroomExitAttemptVO",
		"/VO/MelinoeField_1263",
		"/VO/MelinoeField_1264",
		"/VO/MelinoeField_1267",

		"ZagBedroomObservationVO",
		"/VO/MelinoeField_3407",

		"/VO/MelinoeField_3410", -- "Not yet... In dream I shall remain Unseen."
		"/VO/MelinoeField_3411", -- "So many dreams upon this very spot..."

		"ZagChamberFinalEntranceVO",
		"/VO/MelinoeField_5040",

		"ZagChamberEntranceVO",
		"/VO/MelinoeField_3404",
		"/VO/MelinoeField_3405",
		"/VO/MelinoeField_3406",
		"/VO/MelinoeField_1259",
		"/VO/MelinoeField_3408",

		"ZagChamberMagickVO",
		"/VO/MelinoeField_3414",
		"/VO/MelinoeField_3415",
		"/VO/MelinoeField_3416",
		"/VO/MelinoeField_3409",
		"/VO/MelinoeField_3417",
		"/VO/MelinoeField_5041",
		"/VO/MelinoeField_5042",

		"SurfaceClearCriticalPathVO",
		-- underworld
		"/VO/Melinoe_4831",
		"/VO/Melinoe_5707",
		"/VO/Melinoe_5769",
		"/VO/Melinoe_5766",
		"/VO/Melinoe_5765",
		"/VO/Melinoe_5768",
		"/VO/Melinoe_4832",
		"/VO/Melinoe_4835",
		"/VO/Melinoe_4833",
		"/VO/Melinoe_5725",
		"/VO/Melinoe_5727",
		"/VO/Melinoe_5767",
		"/VO/Melinoe_4839",
		"/VO/Melinoe_4836",
		-- surface
		"/VO/Melinoe_4837",
		"/VO/Melinoe_4838",
		"/VO/Melinoe_4834",
		"/VO/Melinoe_5708",
		"/VO/Melinoe_5770",

		"/VO/MelinoeField_5227",
		"/VO/MelinoeField_5228",
		"/VO/MelinoeField_5229",
		"/VO/MelinoeField_5230",

		"UniqueRunClearedVO",
		"/VO/MelinoeField_5009",

		"HecateMissingRunStartVO",
		"/VO/Melinoe_5158",

		"FinalUnderworldRunStartVO",
		"/VO/Melinoe_5694",
		"/VO/Melinoe_0115",

		-- next stop typhon/chronos
		"/VO/Melinoe_5159",
		"/VO/Melinoe_5160",
		"/VO/Melinoe_5740",

		-- BossFinisherVoiceLines
		"/VO/Chronos_1108",
		"/VO/Chronos_1109",
		"/VO/Chronos_1110",
		"/VO/Chronos_1111",
		"/VO/Chronos_1058", -- death to chronos from chronos

		-- family portrait
		"/VO/Melinoe_5190",
		"/VO/Melinoe_2943",
		"/VO/Melinoe_5779",
		"/VO/Melinoe_5780",

		-- frinos
		"FrinosUniqueVO",
		"/VO/Melinoe_5198",
		"/VO/Melinoe_5199",
		"/VO/Melinoe_5776",
		"/VO/Melinoe_5771",
		"/VO/Melinoe_5194",
		"/VO/Melinoe_5772",
		"/VO/Melinoe_5774",

		"TyphonBossFirstExitVO",
		"/VO/MelinoeField_5010",
		"/VO/MelinoeField_3453",

		"MelVsTyphonIntroVO04",
		"/VO/MelinoeField_3187",
		"/VO/MelinoeField_3189",
		"/VO/MelinoeField_4173",
		"/VO/MelinoeField_3336",

		-- keepsakes
		"/VO/Melinoe_5781",

		-- PlayFirst victory lines
		"/VO/MelinoeField_1407",
		"/VO/MelinoeField_4812",
		"/VO/MelinoeField_4813",
		"/VO/MelinoeField_4815",
		"/VO/MelinoeField_3225",
		"/VO/MelinoeField_3227",

		"/VO/MelinoeField_3456", -- "an aether gate...?"

		"Q_PostBossPostTyphonDeathIntroVO",
		"/VO/MelinoeField_5011",

		"Q_PostBossIntroVO",
		"/VO/MelinoeField_3454",
		"/VO/MelinoeField_3455",

		-- PalaceEntranceUsedVoiceLines
		"/VO/MelinoeField_3457",
		"/VO/MelinoeField_3458",
		"/VO/MelinoeField_3459",
		"/VO/MelinoeField_3460",
		"/VO/MelinoeField_3461",
		"/VO/MelinoeField_3462",

		-- Q_PostBoss01 Overlook VO
		"/VO/MelinoeField_3463",
		"/VO/MelinoeField_3464",
		"/VO/MelinoeField_3465",
		"/VO/MelinoeField_3466",
		"/VO/MelinoeField_3467",

		-- Q_Story01 EnterVoiceLines
		"/VO/MelinoeField_3468",
		"/VO/MelinoeField_3469",
		"/VO/MelinoeField_3470",
		"/VO/MelinoeField_3471",

		-- PalaceObservationVoiceLines
		"/VO/MelinoeField_4246",
		"/VO/MelinoeField_4247",
		"/VO/MelinoeField_4248",
		"/VO/MelinoeField_4249",
		"/VO/MelinoeField_4250",
		"/VO/MelinoeField_4251",

		-- olympian statue greetings
		"/VO/MelinoeField_4253",
		"/VO/MelinoeField_4254",
		"/VO/MelinoeField_4255",
		"/VO/MelinoeField_4256",
		"/VO/MelinoeField_4257",
		"/VO/MelinoeField_4258",
		"/VO/MelinoeField_4259",
		"/VO/MelinoeField_4260",
		"/VO/MelinoeField_4261",
		"/VO/MelinoeField_4262",
		"/VO/MelinoeField_4263",
		"/VO/MelinoeField_4264",
		"/VO/MelinoeField_4265",

		"HeraIntialGreetingVO",
		"/VO/Hera_0216",
		"/VO/Hera_0217",
		"/VO/Hera_0218",
		"/VO/Hera_0219",

		"DemeterPalaceGreetingVO",
		"/VO/MelinoeField_4252",
		"/VO/Demeter_0195",
		"/VO/Demeter_0199",
		"/VO/Demeter_0202",

		-- misc palace VO
		"/VO/MelinoeField_4326",
		"/VO/MelinoeField_4327",
		"/VO/MelinoeField_4328",
		"/VO/MelinoeField_5021",
		"/VO/Apollo_0199",
		"/VO/Apollo_0199",
		"/VO/Apollo_0200",
		"/VO/Apollo_0201",
		"/VO/Apollo_0202",
		"/VO/Zeus_0298",
		"/VO/Zeus_0299",
		"/VO/Zeus_0300",
		"/VO/Zeus_0305",
		"/VO/Hera_0220",
		"/VO/Hera_0221",
		"/VO/Hera_0222",
		"/VO/Hera_0223",

		"SummitPostTrueEndingIntroVO",
		"/VO/MelinoeField_4198",
		"/VO/Melinoe_5724",

		"LeavingErebusHecateMissingVO",
		"/VO/MelinoeField_4269",

		"ChronosFlashbackVO",
		"/VO/Chronos_1410",
		"/VO/Chronos_1412",
		"/VO/Chronos_1416",

		"/VO/Melinoe_5062", -- "Prince Zagreus."

		"AchillesTrueEndGreetingVO",
		"/VO/Achilles_0011",
		"/VO/Achilles_0012",

		-- zodiac sand
		"/VO/Melinoe_2832",
		"/VO/Melinoe_2833",
		"/VO/Melinoe_2834",
		"/VO/Melinoe_2835",

		-- void lens
		"/VO/Melinoe_3939",
		"/VO/Melinoe_3940",
		"/VO/Melinoe_3941",

		"VoidLensPickupVO",
		"/VO/MelinoeField_5199",
		"/VO/MelinoeField_5200",
		"/VO/MelinoeField_5201",

		-- gigaros (inventory)
		"/VO/Melinoe_5711",

		-- typhon eradication
		"/VO/MelinoeField_4174",
		"/VO/MelinoeField_4176",

		-- entropy
		"/VO/Melinoe_5712",
		"/VO/MelinoeField_4182",
		"/VO/MelinoeField_4180",
		"/VO/MelinoeField_4181",

		"LeavingErebusPostEndingIntroVO",
		"/VO/MelinoeField_4584",

		"/VO/Hades_0231", -- "Our daughter..."

		-- hypnos quest
		"/VO/Hypnos_0031",
		"/VO/Melinoe_4708",
		"/VO/Hypnos_0037",

		-- epilogue intro
		"/VO/MelinoeField_4072",
		"/VO/Moros_1001",
	},
}