CreditsData =
{
	-- workaround for overzealous hardcoded number assert
	NumericTokens =
	{
		Three = "3",
		Four = "4",
		Eight = "8",
		NineteenNinetyFour = "1994",
		NineteenNinetySeven = "1997",
		TwentyTwentyFive = "2025",
	},

	Formats =
	{
		ColumnCenter =
		{
			X = 1400,
			Width = 970,
			Justification = "Center",
			SpacingY = 32,
		},
		ColumnLeft =
		{
			InheritFrom = { "ColumnCenter" },
			X = 1200,
			SpacingY = 0,
		},
		ColumnRight =
		{
			InheritFrom = { "ColumnCenter" },
			X = 1600,
		},

		ColumnCenterExtra =
		{
			InheritFrom = { "ColumnCenter" },
			SpacingY = 78,
		},

		CreditH1 =
		{
			InheritFrom = { "ColumnCenter" },
			Font = "P22UndergroundSCHeavy",
			FontSize = 36,
			Color = { 0.27, 0.65, 0.79 },
			OutlineColor = { 0.1, 0.1, 0.1 },
			OutlineThickness = 1,
			ShadowColor = { 0, 0, 0, 1 },
			ShadowOffset = { 0, 3 },
			ShadowBlur = 0,
		},

		CreditH2 =
		{
			InheritFrom = { "ColumnCenter" },
			Font = "P22UndergroundSCMedium",
			FontSize = 28,
			Color = { 0.27, 0.65, 0.79 },
			OutlineColor = { 0.1, 0.1, 0.1 },
			OutlineThickness = 1,
			ShadowColor = { 0, 0, 0, 1 },
			ShadowOffset = { 0, 2 },
			ShadowBlur = 2,
		},

		CreditAcknowledgement =
		{
			InheritFrom = { "ColumnCenter" },
			Font = "P22UndergroundSCMedium",
			FontSize = 22,
			Color = { 0.55, 0.79, 0.92 },
			ShadowColor = { 0, 0, 0, 1 },
			ShadowOffset = { 0, 2 },
		},

		CreditH4 =
		{
			InheritFrom = { "ColumnCenter" },
			Font = "P22UndergroundSCMedium",
			FontSize = 22,
			Color = { 0.27, 0.65, 0.79 },
		},

		CreditTitle =
		{
			InheritFrom = { "ColumnCenter" },
			Font = "P22UndergroundSCMedium",
			FontSize = 22,
			Color = { 0.27, 0.65, 0.79 }, --BLUE
			ShadowColor = { 0, 0, 0, 1 },
			ShadowOffset = { 0, 1 },
		},
		CreditTitle_Left =
		{
			InheritFrom = { "ColumnLeft", "CreditTitle" },
		},
		CreditTitle_Right =
		{
			InheritFrom = { "ColumnRight", "CreditTitle" },
		},

		CreditName =
		{
			InheritFrom = { "ColumnCenter" },
			Font = "CreditsP22UndergroundSCMedium",
			FontSize = 22,
			Color = { 0.85, 0.97, 0.97 }, --LIGHT BLUE
			ShadowColor = { 0, 0, 0, 1 },
			ShadowOffset = { 0, 2 },
			ShadowBlur = 0,
		},
		CreditName_Left =
		{
			InheritFrom = { "ColumnLeft", "CreditName" },
		},
		CreditName_Right =
		{
			InheritFrom = { "ColumnRight", "CreditName" },
		},
		CreditNameTurkish =
		{
			InheritFrom = { "CreditName" },
			Font = "CreditsP22UndergroundSCMediumTR",
		},
		CreditNameCJK = 
		{
			InheritFrom = { "CreditName" },
			Font = "CreditsP22UndergroundSCMediumCJK",
		}
	},

	SongDuration = 306, -- 5:06 runtime
	PreSongDelay = 0.1,
	CreditsGroup = "Cloud_02",

	ScrollingCredits =
	{
		-- Song starts...

		-- show supergiant logo and team credits
		{
			Delay = 4,
			Graphic = "GUI/Screens/EndCredits/Supergiant_White",
			Group = "Cloud_02_Logo",
			ThreadedFunctionName = "EndCreditsSetupBirds",
			X = 1440,
			SpacingY = 150,
			SetScrollSpeed = 50,
		},

		{ Format = "ColumnCenterExtra" },
		{ Format = "CreditTitle_Left", Text = "Credits_Title_Design" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_EngineeringDesign" },
		{ Format = "CreditName_Left", Text = "Credits_Name_001" },
		{ Format = "CreditName_Right", Text = "Credits_Name_002" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_WritingDesign" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Engineering" },
		{ Format = "CreditName_Left", Text = "Credits_Name_003" },
		{ Format = "CreditName_Right", Text = "Credits_Name_004" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_MusicSound" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Art" },
		{ Format = "CreditName_Left", Text = "Credits_Name_005" },
		{ Format = "CreditName_Right", Text = "Credits_Name_006" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_VO" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_UIVFX" },
		{ Format = "CreditName_Left", Text = "Credits_Name_007" },
		{ Format = "CreditName_Right", Text = "Credits_Name_008" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_Ops" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Engineering" },
		{ Format = "CreditName_Left", Text = "Credits_Name_009" },
		{ Format = "CreditName_Right", Text = "Credits_Name_010" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_Design" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_EngineeringDesign" },
		{ Format = "CreditName_Left", Text = "Credits_Name_011" },
		{ Format = "CreditName_Right", Text = "Credits_Name_012" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle_Left", Text = "Credits_Title_EnvironmentArt" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Publishing" },
		{ Format = "CreditName_Left", Text = "Credits_Name_013" },
		{ Format = "CreditName_Right", Text = "Credits_Name_015" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle_Left", Text = "Credits_Title_Engineering" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Engineering" },
		{ Format = "CreditName_Left", Text = "Credits_Name_016" },
		{ Format = "CreditName_Right", Text = "Credits_Name_017" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_Design" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_QA" },
		{ Format = "CreditName_Left", Text = "Credits_Name_018" },
		{ Format = "CreditName_Right", Text = "Credits_Name_019" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_ProductionQA" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_3DModeling" },
		{ Format = "CreditName_Left", Text = "Credits_Name_020" },
		{ Format = "CreditName_Right", Text = "Credits_Name_021" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle_Left", Text = "Credits_Title_Animation" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Finance" },
		{ Format = "CreditName_Left", Text = "Credits_Name_021b" },
		{ Format = "CreditName_Right", Text = "Credits_Name_022" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_TechArt" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_PlatformsQA" },
		{ Format = "CreditName_Left", Text = "Credits_Name_023" },
		{ Format = "CreditName_Right", Text = "Credits_Name_024" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle_Left", Text = "Credits_Title_Engineering" },
		{ Format = "CreditTitle_Right", Text = "Credits_Title_Illustration" },
		{ Format = "CreditName_Left", Text = "Credits_Name_025" },
		{ Format = "CreditName_Right", Text = "Credits_Name_235" },
		{ Format = "ColumnCenterExtra" },

		-- Wait for credits to go off-screen, then show the first constellation
		{
			Delay = 16.3,
			ThreadedFunctionName = "ShowEndCreditsConstellation",
		
			-- poseidon, hera, zeus
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_04", FadeInDuration = 1.0, HoldDuration = 6.0, FadeOutDuration = 1.0 },
		},

		{
			Delay = 2.5,
		},

		{ Format = "CreditH2", Text = "Credits_Heading_Contributors", SetScrollSpeed = 105 },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlMusicVocals" },
		{ Format = "CreditName", Text = "Credits_Name_026" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlOfficeSupport" },
		{ Format = "CreditName", Text = "Credits_Name_014" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlSetDressing" },
		{ Format = "CreditName", Text = "Credits_Name_027" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlAnimation" },
		{ Format = "CreditName", Text = "Credits_Name_028" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle", Text = "Credits_Title_AdtlUIArt" },
		{ Format = "CreditName", Text = "Credits_Name_030" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle", Text = "Credits_Title_AdtlQA" },
		{ Format = "CreditName", Text = "Credits_Name_031" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle", Text = "Credits_Title_AdtlSoundEditing" },
		{ Format = "CreditName", Text = "Credits_Name_035" },
		{ Format = "CreditName", Text = "Credits_Name_042" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle", Text = "Credits_Title_AdtlUIAnimation" },
		{ Format = "CreditName", Text = "Credits_Name_234" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlModeling" },
		{ Format = "CreditName", Text = "Credits_Name_029" },
		{ Format = "CreditName", Text = "Credits_Name_115" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlRigging" },
		{ Format = "CreditName", Text = "Credits_Name_032" },
		{ Format = "CreditName", Text = "Credits_Name_033" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlConceptArt" },
		{ Format = "CreditName", Text = "Credits_Name_034" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlAnimation" },
		{ Format = "CreditName", Text = "Credits_Name_036" },
		{ Format = "CreditName", Text = "Credits_Name_037" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlVFXConcepts" },
		{ Format = "CreditName", Text = "Credits_Name_038" },
		{ Format = "CreditName", Text = "Credits_Name_039" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlVideoProduction" },
		{ Format = "CreditName", Text = "Credits_Name_040" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdtlMarketingArt" },
		{ Format = "CreditName", Text = "Credits_Name_041" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle", Text = "Credits_Title_AnimatedTrailers" },
		{ Format = "CreditName", Text = "Credits_TeamName_StudioGrackle" },
		{ Format = "CreditName", Text = "Credits_TeamName_TheLine" },
		{ Format = "ColumnCenter" },

		{
			Delay = 6.5,
			ThreadedFunctionName = "ShowEndCreditsConstellation",
	
			-- dora & odysseus
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_06", FadeInDuration = 1.0, HoldDuration = 6.5, FadeOutDuration = 1.0 },
		},

		{
			Delay = 3.0,
		},
 
		{ Format = "CreditH2", Text = "Credits_Heading_VoiceCast", SetScrollSpeed = 105 },
		{ Format = "ColumnCenter", SpacingY = 50 },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_JudyChars" },
		{ Format = "CreditName", Text = "Credits_Name_042" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Hecate" },
		{ Format = "CreditName", Text = "Credits_Name_043" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_LoganChars01" },
		{ Format = "CreditTitle", Text = "Credits_CastTitle_LoganChars02" },
		{ Format = "CreditName", Text = "Credits_Name_007" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_ErinChars" },
		{ Format = "CreditName", Text = "Credits_Name_044" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Nemesis" },
		{ Format = "CreditName", Text = "Credits_Name_045" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Odysseus" },
		{ Format = "CreditName", Text = "Credits_Name_046" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Moros" },
		{ Format = "CreditName", Text = "Credits_Name_047" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Eris" },
		{ Format = "CreditName", Text = "Credits_Name_048" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_DarrenChars1" },
		{ Format = "CreditTitle", Text = "Credits_CastTitle_DarrenChars2" },
		{ Format = "CreditName", Text = "Credits_Name_005" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Selene" },
		{ Format = "CreditName", Text = "Credits_Name_049" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Artemis" },
		{ Format = "CreditName", Text = "Credits_Name_050" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Hermes" },
		{ Format = "CreditName", Text = "Credits_Name_051" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Arachne" },
		{ Format = "CreditName", Text = "Credits_Name_052" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Apollo" },
		{ Format = "CreditName", Text = "Credits_Name_059" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Demeter" },
		{ Format = "CreditName", Text = "Credits_Name_060" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Hestia" },
		{ Format = "CreditName", Text = "Credits_Name_063" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_PeterChars" },
		{ Format = "CreditName", Text = "Credits_Name_057" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Aphrodite" },
		{ Format = "CreditName", Text = "Credits_Name_061" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Hephaestus" },
		{ Format = "CreditName", Text = "Credits_Name_062" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Hera" },
		{ Format = "CreditName", Text = "Credits_Name_058" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Heracles" },
		{ Format = "CreditName", Text = "Credits_Name_053" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Medea" },
		{ Format = "CreditName", Text = "Credits_Name_054" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Circe" },
		{ Format = "CreditName", Text = "Credits_Name_055" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Prometheus" },
		{ Format = "CreditName", Text = "Credits_Name_119" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_Athena" },
		{ Format = "CreditName", Text = "Credits_Name_238" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_CyrusChars" },
		{ Format = "CreditName", Text = "Credits_Name_118" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_CastTitle_GregChars" },
		{ Format = "CreditName", Text = "Credits_Name_003" },
		{ Format = "ColumnCenterExtra" },

		{ Format = "CreditTitle", Text = "Credits_CastTitle_AdtlVoices" },
		{ Format = "CreditName", Text = "Credits_Name_117" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditTitle", Text = "Credits_With" },
		{ Format = "CreditName", Text = "Credits_Name_056" },
		{ Format = "CreditTitle", Text = "Credits_AsIcarus" },
		{ Format = "ColumnCenter", SpacingY = 120 },
 
		{ Format = "CreditH2", Text = "Credits_Title_CastingServices" },
		{ Format = "ColumnCenter", SpacingY = 50 },
 
		{ Format = "CreditName", Text = "Credits_TeamName_HalpNetwork" },
		{ Format = "CreditName", Text = "Credits_Name_066" },
		{ Format = "CreditName", Text = "Credits_Name_067" },
		{ Format = "CreditName", Text = "Credits_Name_068" },
		{ Format = "ColumnCenter" },

		{
			Delay = 5.75,
			ThreadedFunctionName = "ShowEndCreditsConstellation",
			
			-- poseidon, hera, zeus
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_07", FadeInDuration = 1.0, HoldDuration = 6.5, FadeOutDuration = 1.0 },
		},

		{
			Delay = 3.5,
		},
 
		{ Format = "CreditH2", Text = "Credits_Heading_Translators", SetScrollSpeed = 105 },
		{ Format = "ColumnCenter", SpacingY = 50 },
 
		{ Format = "CreditH4", Text = "Credits_Lang_FR" },
		{ Format = "CreditName", Text = "Credits_Name_069" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_IT" },
		{ Format = "CreditName", Text = "Credits_Name_070" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_DE" },
		{ Format = "CreditName", Text = "Credits_Name_078" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_ES" },
		{ Format = "CreditName", Text = "Credits_Name_077" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_EL" },
		{ Format = "CreditName", Text = "Credits_Name_072" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_KO" },
		{ Format = "CreditName", Text = "Credits_Name_079" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_PL" },
		{ Format = "CreditName", Text = "Credits_Name_080" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_PTBR" },
		{ Format = "CreditName", Text = "Credits_Name_071" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_RU" },
		{ Format = "CreditName", Text = "Credits_Name_081" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_ZHCN" },
		{ Format = "CreditName", Text = "Credits_Name_073" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_ZHTW" },
		{ Format = "CreditName", Text = "Credits_Name_075" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_TR" },
		{ Format = "CreditNameTurkish", Text = "Credits_Name_076" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_UK" },
		{ Format = "CreditName", Text = "Credits_Name_074" },
		{ Format = "ColumnCenterExtra" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_JP" },
		{ Format = "CreditName", Text = "Credits_TeamName_8-4" },
		{ Format = "CreditName", Text = "EndCredits_Name_109" },
		{ Format = "CreditName", Text = "EndCredits_Name_065" },
		{ Format = "ColumnCenter" },
		{ Format = "CreditName", Text = "Credits_Name_242" },
		{ Format = "CreditName", Text = "Credits_Name_241" },
		{ Format = "CreditName", Text = "Credits_Name_110" },
		{ Format = "CreditName", Text = "Credits_Name_114" },
		{ Format = "CreditName", Text = "Credits_Name_112" },
		{ Format = "CreditName", Text = "Credits_Name_064" },
		{ Format = "CreditName", Text = "Credits_Name_111" },
		{ Format = "CreditName", Text = "Credits_Name_113" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH2", Text = "Credits_Heading_LanguageQA" },
		{ Format = "ColumnCenter", SpacingY = 50 },
 
		{ Format = "CreditH4", Text = "Credits_Lang_FR" },
		{ Format = "CreditName", Text = "EndCredits_Name_092" },
		{ Format = "CreditName", Text = "EndCredits_Name_095" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_IT" },
		{ Format = "CreditName", Text = "Credits_Name_091c" },
		{ Format = "CreditName", Text = "Credits_Name_107" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_DE" },
		{ Format = "CreditName", Text = "Credits_Name_093" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_ES" },
		{ Format = "CreditName", Text = "EndCredits_Name_083_B" },
		{ Format = "CreditName", Text = "Credits_Name_091b" },
		{ Format = "CreditName", Text = "Credits_Name_102" },
		{ Format = "CreditName", Text = "Credits_Name_108" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_EL" },
		{ Format = "CreditName", Text = "Credits_Name_089" },
		{ Format = "CreditName", Text = "Credits_Name_103" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_KO" },
		{ Format = "CreditName", Text = "Credits_Name_094b" },
		{ Format = "CreditName", Text = "Credits_Name_104" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_PL" },
		{ Format = "CreditName", Text = "Credits_Name_091" },
		{ Format = "CreditName", Text = "Credits_Name_100" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_PTBR" },
		{ Format = "CreditName", Text = "Credits_Name_088" },
		{ Format = "CreditName", Text = "Credits_Name_105" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_RU" },
		{ Format = "CreditName", Text = "Credits_Name_087" },
		{ Format = "CreditName", Text = "Credits_Name_096" },
		{ Format = "CreditName", Text = "Credits_Name_328" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_ZHCN" },
		{ Format = "CreditName", Text = "Credits_Name_084" },
		{ Format = "CreditName", Text = "Credits_Name_085" },
		{ Format = "CreditName", Text = "Credits_Name_097" },
		{ Format = "CreditName", Text = "Credits_Name_098" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_ZHTW" },
		{ Format = "CreditName", Text = "Credits_Name_086" },
		{ Format = "CreditName", Text = "Credits_Name_099" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_TR" },
		{ Format = "CreditNameTurkish", Text = "Credits_Name_090" },
		{ Format = "CreditName", Text = "Credits_Name_101" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH4", Text = "Credits_Lang_UK" },
		{ Format = "CreditName", Text = "Credits_Name_094" },
		{ Format = "CreditName", Text = "Credits_Name_106" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },

		{
			Delay = 4.5,
			ThreadedFunctionName = "ShowEndCreditsConstellation",
		
			-- nyx & hecate
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_02", FadeInDuration = 1.0, HoldDuration = 7.0, FadeOutDuration = 1.0 },
		},

		{
			Delay = 2.0,
		},
 
		{ Format = "CreditH2", Text = "Credits_Heading_MusicProduction", SetScrollSpeed = 105 },
		{ Format = "ColumnCenter", SpacingY = 50 },
 
		{ Format = "CreditTitle", Text = "EndCredits_SubHeading_ScyllaBand" },
		{ Format = "CreditName", Text = "EndCredits_Name_044_B" },
		{ Format = "CreditName", Text = "EndCredits_Name_026_B" },
		{ Format = "CreditName", Text = "EndCredits_Name_042_B" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "EndCredits_Title_Vocalist_ArtemisSong" },
		{ Format = "CreditName", Text = "Credits_Name_026" },
		{ Format = "CreditName", Text = "Credits_Name_042" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "EndCredits_Title_Vocalist_ApolloSong" },
		{ Format = "CreditName", Text = "Credits_Name_059" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "EndCredits_Title_Vocalist_EndTheme" },
		{ Format = "CreditName", Text = "Credits_Name_059" },
		{ Format = "CreditName", Text = "Credits_Name_026" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "EndCredits_Title_DrumSoloist" },
		{ Format = "CreditName", Text = "Credits_Name_237" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "EndCredits_Title_SaxophoneSoloist" },
		{ Format = "CreditName", Text = "Credits_Name_116" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "EndCredits_Title_SaxophoneSoloist_B" },
		{ Format = "CreditName", Text = "Credits_Name_223" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "EndCredits_Title_FluteSoloist" },
		{ Format = "CreditName", Text = "Credits_Name_082" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "EndCredits_Title_FluteSoloist_B" },
		{ Format = "CreditName", Text = "Credits_Name_223" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "EndCredits_Title_GuitarSoloist" },
		{ Format = "CreditName", Text = "Credits_Name_236" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditH2", Text = "Credits_AbbeyRoad" },
		{ Format = "CreditH2", Text = "Credits_AbbeyRoad_B" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_Conductor" },
		{ Format = "CreditName", Text = "Credits_Name_120" },
		{ Format = "ColumnCenter" },
 		
 
		{ Format = "CreditTitle", Text = "Credits_Title_WindSoloist" },
		{ Format = "CreditName", Text = "Credits_Name_223" },
		{ Format = "ColumnCenter" },
 	
		{ Format = "CreditTitle", Text = "Credits_Title_OrchestraContractor" },
		{ Format = "CreditName", Text = "Credits_Name_121" },
		{ Format = "CreditName", Text = "Credits_TeamName_IsobelGriffiths" },
		{ Format = "ColumnCenter" },
		-- { Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Role_Choir" },
		{ Format = "CreditNameCJK", Text = "Credits_SubHead_Choir" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_ScoringEngineer" },
		{ Format = "CreditName", Text = "Credits_Name_228" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AssistantRecordingEngineer" },
		{ Format = "CreditName", Text = "Credits_Name_229" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_MixEngineer" },
		{ Format = "CreditName", Text = "Credits_Name_224" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_MixAssistant" },
		{ Format = "CreditName", Text = "Credits_Name_225" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_MusicEditor" },
		{ Format = "CreditName", Text = "Credits_Name_226" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_AdditionalMusicEditing" },
		{ Format = "CreditName", Text = "Credits_Name_227" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_Orchestration" },
		{ Format = "CreditName", Text = "Credits_Name_233" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_MidiTranscription" },
		{ Format = "CreditName", Text = "Credits_Name_230" },
		{ Format = "CreditName", Text = "Credits_Name_231" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_Copyist" },
		{ Format = "CreditName", Text = "Credits_TeamName_StevenJuliani" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditTitle", Text = "Credits_Title_Librarian" },
		{ Format = "CreditName", Text = "Credits_Name_122" },
		{ Format = "CreditName", Text = "Credits_Name_123" },
		--{ Format = "ColumnCenter" },
 	
		--{ Format = "CreditTitle", Text = "Credits_Title_OrchestralSessionAssistant" },
		--{ Format = "CreditName", Text = "Credits_Name_232" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },

		{
			Delay = 5.0,
			ThreadedFunctionName = "ShowEndCreditsConstellation",

			-- ares, hephaestus, aphrodite
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_05", FadeInDuration = 1.0, HoldDuration = 5.0, FadeOutDuration = 1.0 },
		},

		{
			Delay = 2.0,
		},

		{ Format = "CreditH2", Text = "Credits_Heading_Acknowledgements", SetScrollSpeed = 90 },
		{ Format = "ColumnCenter", SpacingY = 50 },
		{ Format = "CreditAcknowledgement", Text = "Credits_Description_Acknowledgements" },
		{ Format = "CreditAcknowledgement", Text = "Credits_Description_Acknowledgements_B", SpacingY = 45 },
		{ Format = "ColumnCenter", SpacingY = 50 },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_001" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_002" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_003" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_004" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_005" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_006" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_007" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_008" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_009" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_010" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_011" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_012" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_013" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_014" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_015" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_016" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_017" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_018" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_019" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_020" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_021" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_022" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_023" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_024" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_025" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_026" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_027" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_028" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_029" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_030" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_031" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_032" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_033" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_034" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_035" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_036" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_037" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_038" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_039" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_040" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_041" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_042" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_043" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_044" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_045" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_046" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_047" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_048" },
		{ Format = "CreditName", Text = "Credits_Acknowledgements_049" },
		{ Format = "ColumnCenter", SpacingY = 50 },
		{ Format = "CreditAcknowledgement", Text = "Credits_Description_Acknowledgements_Close" },
		{ Format = "CreditAcknowledgement", Text = "Credits_Description_Acknowledgements_Close_B", SpacingY = 45 },
		{ Format = "CreditAcknowledgement", Text = "Credits_Description_Acknowledgements_Close_C", SpacingY = 45 },
		{ Format = "ColumnCenter" },

 		{
			Delay = 8.0,
			ThreadedFunctionName = "ShowEndCreditsConstellation",

			-- charon & hermes
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_09", FadeInDuration = 1.0, HoldDuration = 6.5, FadeOutDuration = 1.0 },
		},

		{
			Delay = 2.5,
		},
 
 		{ Format = "CreditH2", Text = "Credits_Heading_SpecialThanks", SetScrollSpeed = 115 },
		{ Format = "ColumnCenter", SpacingY = 50 },
		{ Format = "CreditName", Text = "Credits_Name_243" },
		{ Format = "CreditName", Text = "Credits_Name_244" },
		{ Format = "CreditName", Text = "Credits_Name_245" },
		{ Format = "CreditName", Text = "Credits_Name_263" },
		{ Format = "CreditName", Text = "Credits_Name_261" },
		{ Format = "CreditName", Text = "Credits_Name_246" },
		{ Format = "CreditName", Text = "Credits_Name_259" },
		{ Format = "CreditName", Text = "Credits_Name_247" },
		{ Format = "CreditName", Text = "Credits_Name_248" },
		{ Format = "CreditName", Text = "Credits_Name_262" },
		{ Format = "CreditName", Text = "Credits_Name_249" },
		{ Format = "CreditName", Text = "Credits_Name_266" },
		{ Format = "CreditName", Text = "Credits_Name_250" },
		{ Format = "CreditName", Text = "Credits_Name_260" },
		{ Format = "CreditName", Text = "Credits_Name_258" },
		{ Format = "CreditName", Text = "Credits_Name_251" },
		{ Format = "CreditName", Text = "Credits_Name_252" },
		{ Format = "CreditName", Text = "Credits_Name_253" },
		{ Format = "CreditName", Text = "Credits_Name_254" },
		{ Format = "CreditName", Text = "Credits_Name_255" },
		{ Format = "CreditName", Text = "Credits_Name_265" },
		{ Format = "CreditName", Text = "Credits_Name_256" },
		{ Format = "CreditName", Text = "Credits_Name_257" },
		{ Format = "CreditName", Text = "Credits_Name_267" },
		{ Format = "CreditName", Text = "Credits_Name_264" },
		--{ Format = "CreditTitle", Text = "Credits_Div_B" },
 		{ Format = "ColumnCenter" },

		{
			Delay = 5.5,
			ThreadedFunctionName = "ShowEndCreditsConstellation",

			-- charon & hermes
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_08", FadeInDuration = 1.0, HoldDuration = 6.0, FadeOutDuration = 1.0 },
		},

		{
			Delay = 2.0,
		},

		
		{ Format = "CreditH2", Text = "Credits_Heading_Community", SetScrollSpeed = 110 },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "Credits_SubHeading_Discord" },
		{ Format = "ColumnCenter" },
		{ Format = "CreditName_Left", Text = "Credits_Name_272" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_372" },
      	{ Format = "CreditName_Left", Text = "Credits_Name_273" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_373" },
      	{ Format = "CreditName_Left", Text = "Credits_Name_374" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_311" },
      	{ Format = "CreditName_Left", Text = "Credits_Name_375" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_268" },
      	{ Format = "CreditName_Left", Text = "Credits_Name_315" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_317" },
      	{ Format = "CreditName_Left", Text = "Credits_Name_314" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_276" },
      	{ Format = "CreditName_Left", Text = "Credits_Name_308" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_369" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "Credits_SubHeading_ModLiaisons" },
		{ Format = "ColumnCenter" },
		{ Format = "CreditName_Left", Text = "Credits_Name_370" },
      	{ Format = "CreditName_Right", Text = "Credits_Name_371" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },

		{ Format = "CreditTitle", Text = "Credits_SubHeading_BetaTesters" },
		{ Format = "ColumnCenter" },
		{ Format = "CreditName_Left", Text = "Credits_Name_268" },
		{ Format = "CreditName_Right", Text = "Credits_Name_269" },
		{ Format = "CreditName_Left", Text = "Credits_Name_270" },
		{ Format = "CreditName_Right", Text = "Credits_Name_273" },
		{ Format = "CreditName_Left", Text = "Credits_Name_272" },
		{ Format = "CreditName_Right", Text = "Credits_Name_271" },
		{ Format = "CreditName_Left", Text = "Credits_Name_274" },
		{ Format = "CreditName_Right", Text = "Credits_Name_275" },
		{ Format = "CreditName_Left", Text = "Credits_Name_276" },
		{ Format = "CreditName_Right", Text = "Credits_Name_277" },
		{ Format = "CreditName_Left", Text = "Credits_Name_278" },
		{ Format = "CreditName_Right", Text = "Credits_Name_279" },
		{ Format = "CreditName_Left", Text = "Credits_Name_280" },
		{ Format = "CreditName_Right", Text = "Credits_Name_281" },
		{ Format = "CreditName_Left", Text = "Credits_Name_282" },
		{ Format = "CreditName_Right", Text = "Credits_Name_283" },
		{ Format = "CreditName_Left", Text = "Credits_Name_284" },
		{ Format = "CreditName_Right", Text = "Credits_Name_285" },
		{ Format = "CreditName_Left", Text = "Credits_Name_286" },
		{ Format = "CreditName_Right", Text = "Credits_Name_287" },
		{ Format = "CreditName_Left", Text = "Credits_Name_288" },
		{ Format = "CreditName_Right", Text = "Credits_Name_289" },
		{ Format = "CreditName_Left", Text = "Credits_Name_290" },
		{ Format = "CreditName_Right", Text = "Credits_Name_291" },
		{ Format = "CreditName_Left", Text = "Credits_Name_292" },
		{ Format = "CreditName_Right", Text = "Credits_Name_293" },
		{ Format = "CreditName_Left", Text = "Credits_Name_294" },
		{ Format = "CreditName_Right", Text = "Credits_Name_295" },
		{ Format = "CreditName_Left", Text = "Credits_Name_296" },
		{ Format = "CreditName_Right", Text = "Credits_Name_297" },
		{ Format = "CreditName_Left", Text = "Credits_Name_298" },
		{ Format = "CreditName_Right", Text = "Credits_Name_299" },
		{ Format = "CreditName_Left", Text = "Credits_Name_300" },
		{ Format = "CreditName_Right", Text = "Credits_Name_301" },
		{ Format = "CreditName_Left", Text = "Credits_Name_304" },
		{ Format = "CreditName_Right", Text = "Credits_Name_303" },
		{ Format = "CreditName_Left", Text = "Credits_Name_302" },
		{ Format = "CreditName_Right", Text = "Credits_Name_305" },
		{ Format = "CreditName_Left", Text = "Credits_Name_306" },
		{ Format = "CreditName_Right", Text = "Credits_Name_307" },
		{ Format = "CreditName_Left", Text = "Credits_Name_308" },
		{ Format = "CreditName_Right", Text = "Credits_Name_309" },
		{ Format = "CreditName_Left", Text = "Credits_Name_310" },
		{ Format = "CreditName_Right", Text = "Credits_Name_311" },
		{ Format = "CreditName_Left", Text = "Credits_Name_312" },
		{ Format = "CreditName_Right", Text = "Credits_Name_313" },
		{ Format = "CreditName_Left", Text = "Credits_Name_314" },
		{ Format = "CreditName_Right", Text = "Credits_Name_315" },
		{ Format = "CreditName_Left", Text = "Credits_Name_316" },
		{ Format = "CreditName_Right", Text = "Credits_Name_317" },
		{ Format = "CreditName_Left", Text = "Credits_Name_318" },
		{ Format = "CreditName_Right", Text = "Credits_Name_319" },
		{ Format = "CreditName_Left", Text = "Credits_Name_320" },
		{ Format = "CreditName_Right", Text = "Credits_Name_323" },
		{ Format = "CreditName_Left", Text = "Credits_Name_322" },
		{ Format = "CreditName_Right", Text = "Credits_Name_321" },
		{ Format = "CreditName_Left", Text = "Credits_Name_324" },
		{ Format = "CreditName_Right", Text = "Credits_Name_325" },
		{ Format = "CreditName_Left", Text = "Credits_Name_326" },
		{ Format = "CreditName_Right", Text = "Credits_Name_327" },
		{ Format = "CreditName_Left", Text = "Credits_Name_329" },
		{ Format = "CreditName_Right", Text = "Credits_Name_330" },
		{ Format = "CreditName_Left", Text = "Credits_Name_331" },
		{ Format = "CreditName_Right", Text = "Credits_Name_332" },
		{ Format = "CreditName_Left", Text = "Credits_Name_333" },
		{ Format = "CreditName_Right", Text = "Credits_Name_334" },
		{ Format = "CreditName_Left", Text = "Credits_Name_335" },
		{ Format = "CreditName_Right", Text = "Credits_Name_336" },
		{ Format = "CreditName_Left", Text = "Credits_Name_337" },
		{ Format = "CreditName_Right", Text = "Credits_Name_338" },
		{ Format = "CreditName_Left", Text = "Credits_Name_339" },
		{ Format = "CreditName_Right", Text = "Credits_Name_340" },
		{ Format = "CreditName_Left", Text = "Credits_Name_341" },
		{ Format = "CreditName_Right", Text = "Credits_Name_342" },
		{ Format = "CreditName_Left", Text = "Credits_Name_343" },
		{ Format = "CreditName_Right", Text = "Credits_Name_344" },
		{ Format = "CreditName_Left", Text = "Credits_Name_345" },
		{ Format = "CreditName_Right", Text = "Credits_Name_348" },
		{ Format = "CreditName_Left", Text = "Credits_Name_347" },
		{ Format = "CreditName_Right", Text = "Credits_Name_346" },
		{ Format = "CreditName_Left", Text = "Credits_Name_349" },
		{ Format = "CreditName_Right", Text = "Credits_Name_350" },
		{ Format = "CreditName_Left", Text = "Credits_Name_351" },
		{ Format = "CreditName_Right", Text = "Credits_Name_352" },
		{ Format = "CreditName_Left", Text = "Credits_Name_353" },
		{ Format = "CreditName_Right", Text = "Credits_Name_354" },
		{ Format = "CreditName_Left", Text = "Credits_Name_355" },
		{ Format = "CreditName_Right", Text = "Credits_Name_356" },
		{ Format = "CreditName_Left", Text = "Credits_Name_357" },
		{ Format = "CreditName_Right", Text = "Credits_Name_358" },
		{ Format = "CreditName_Left", Text = "Credits_Name_359" },
		{ Format = "CreditName_Right", Text = "Credits_Name_360" },
		{ Format = "CreditName_Left", Text = "Credits_Name_361" },
		{ Format = "CreditName_Right", Text = "Credits_Name_362" },
		{ Format = "CreditName_Left", Text = "Credits_Name_363" },
		{ Format = "CreditName_Right", Text = "Credits_Name_364" },
		{ Format = "CreditName_Left", Text = "Credits_Name_365" },
		{ Format = "CreditName_Right", Text = "Credits_Name_366" },
		{ Format = "CreditName_Left", Text = "Credits_Name_367" },
		{ Format = "CreditName_Right", Text = "Credits_Name_368" },
		{ Format = "ColumnCenter" },

 		{
			Delay = 6.0,
			ThreadedFunctionName = "ShowEndCreditsConstellation",
			
			-- prometheus
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_10", FadeInDuration = 1.0, HoldDuration = 6.0, FadeOutDuration = 1.0 },
		},

		{
			Delay = 3.0,
		},

		{ Format = "CreditH2", Text = "Credits_Heading_SupergiantSalutes", SetScrollSpeed = 100 },
		{ Format = "ColumnCenter", SpacingY = 50 },
 
		{ Format = "CreditNameCJK", Text = "Credits_Message_Thanks_EarlyAccessPlayers" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditNameCJK", Text = "Credits_Message_Thanks_BetaPlayers" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditNameCJK", Text = "Credits_Message_Thanks_DiscordMods" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditNameCJK", Text = "EndCredits_Message_Thanks_HadesDevTeam" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditNameCJK", Text = "Credits_Message_Thanks_FriendsFamily" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditNameCJK", Text = "Credits_Message_Thanks_Gods" },
		{ Format = "ColumnCenter" },
 
		{ Format = "CreditNameCJK", Text = "Credits_Message_Thanks_Time" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
 
 		
		{ Format = "CreditTitle", Text = "Credits_Legal_02B" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
		{ Format = "ColumnCenter" },
 
		{
			Delay = 5.0,
			ThreadedFunctionName = "ShowEndCreditsConstellation",

			-- zag & mel
			ThreadedFunctionArgs = { Name = "EndCreditsConstellation_03", FadeInDuration = 1.0, HoldDuration = 16.5, FadeOutDuration = 1.0 },
		},

		{
			Delay = 5.7,
		},
	},
}