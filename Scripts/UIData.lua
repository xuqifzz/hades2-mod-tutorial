ConstantsData = { Two = 2 }

PercentFormatNamesLookup = 
{
	Percent = true, 
	PercentDelta = true, 
	NegativePercentDelta = true, 
	PercentOfBase = true, 
	TimesOneHundredPercent = true,
	Divisor = true, 
	PercentReciprocalDelta = true,
}

AutomaticExtractProperties = 
{
	EchoDuration = 
	{
		AddHeroValue = "EchoDurationIncrease",
	},
	DamageShareDuration = 
	{
		AddHeroValue = "DamageShareDurationIncrease",
	},
	DamageShareAmount = 
	{
		AddHeroValue = "DamageShareAmountIncrease",
	},
	BurnRate = 
	{
		MultiplyHeroValue = "BurnDamageMultiplier",
	},
}

TextFormats =
{
	-- note: 1080p livingroom recommendation font size is 28 - 32px

	-- for Boon Strings
	BaseFormat =
	{
		Font = "LatoMedium",
		FontSize = 19.5,
		Color = { 160, 160, 160, 255 },
		VerticalJustification = "Top",
		TextSymbolScale = 0.85,
	},

	BoldFormat =
	{
		Font = "LatoBold",
		FontSize = 19.5,
		Color = { 230, 230, 230, 255 },
		VerticalJustification = "Top",
		TextSymbolScale = 0.85,
		Graft = true,
	},

	BoldFormatGraft =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = { 230, 230, 230, 255 },
		TextSymbolScale = 0.7,
	},

	BoldFormatGraftDark =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = { 102, 90, 11, 255 },
		TextSymbolScale = 0.7,
	},

	BoldFormatGraftNoColor =
	{
		Graft = true,
		UseEmphasizedFont = true,
		TextSymbolScale = 0.7,
	},

	ItalicFormat =
	{
		Font = "LatoSemiboldItalic",
		Graft = true,
	},
	ItalicLightFormat =
	{
		Font = "LatoItalic",
		Graft = true,
	},

	ItalicFormatDark =
	{
		Font = "LatoSemiboldItalic",
		Color = {132,83,50,255},
		Graft = true,
	},

	InstructionFormat =
	{
		Graft = true,
		Font = "LatoItalic",
		FontSize = 20,
		Color = { 140, 140, 140, 255 },
		TextSymbolScale = 0.85,
	},

	StatFormat =
	{
		Graft = true,
		Color = { 160, 190, 160, 255 },
		TextSymbolScale = 0.7,
	},

	WhiteFormat =
	{
		Graft = true,
		Color = Color.White,
	},

	AltUpgradeFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.UpgradeGreen,
	},

	AltPenaltyFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.PenaltyRed,
	},

	TempFormat =
	{
		Graft = true,
		Color = Color.PenaltyRed,
	},

	MoneyFormat =
	{
		Graft = true,
		Color = Color.LightGold,
	},
	MoneyFormatBold =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.LightGold,
	},

	CommonFormat =
	{
		Graft = true,
		Color = Color.BoonPatchCommon,
	},

	RareFormat =
	{
		Graft = true,
		Color = Color.BoonPatchRare,
		UseEmphasizedFont = true,
	},

	EpicFormat =
	{
		Graft = true,
		Color = Color.BoonPatchEpic,
		UseEmphasizedFont = true,
	},

	DuoFormat =
	{
		Graft = true,
		Color = Color.BoonPatchDuo,
		UseEmphasizedFont = true,
	},

	HeroicFormat = 
	{
		Graft = true,
		Color = Color.BoonPatchHeroic,
		UseEmphasizedFont = true,
	},

	ElementalFormat =
	{
		Graft = true,
		Color = Color.BoonPatchElemental,
		UseEmphasizedFont = true,
	},

	LegendaryFormat =
	{
		Graft = true,
		Color = Color.BoonPatchLegendary,
		UseEmphasizedFont = true,
	},

	DialogLegendaryFormat =
	{
		Graft = true,
		Color = Color.BoonPatchLegendary,
	},

	MemFormat =
	{
		Graft = true,
		Color = Color.MEMBlue,
	},
	MemFormatBold =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.MEMBlue,
	},
	GraspFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.LightGreen,
	},

	ShopCostFormat =
	{
		Graft = true,
		Color = Color.CostAffordable,
	},

	HighlightFormatGraft =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.Gold,
	},

	ShrineHighlightFormat =
	{
		Graft = true,
		Font = "LatoBold",
		Color = Color.Yellow,
	},

	PropertyFormat =
	{
		Font = "LatoMedium",
		FontSize = 20,
		Color = Color.LightGray,
		VerticalJustification = "Top",
		Graft = true,
	},

	LockedFormat =
	{
		Graft = true,
		Color = { 155, 155, 155, 180 },
	},

	OldFormat =
	{
		Font = "LatoBold",
		BlockEmphasizedFont = true,
		Color = Color.SlateGray,
		VerticalJustification = "Top",
		Graft = true,
	},

	LevelFormat =
	{
		FontSize = 25,
		Color = Color.UpgradeGreen,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	},

	TeamFormat =
	{
		Graft = true,
		Color = {240,240,240,255},
		Font = "LatoBold",
	},
	TeamMelFormat =
	{ 
		Graft = true,
		Color = {0,225,35,255},
		Font = "LatoSemibold",
	},
	TeamNemFormat =
	{
		Graft = true,
		Color = {75,138,255,255},
		Font = "LatoSemibold",
	},
	TeamHercFormat =
	{
		Graft = true,
		Color = {255,125,25,255},
		Font = "LatoSemibold",
	},

	UpgradeFormat =
	{
		Font = "LatoBold",
		BlockEmphasizedFont = true,
		Color = Color.UpgradeGreen,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},
	UpgradeFormatDark =
	{
		Font = "LatoBold",
		BlockEmphasizedFont = true,
		Color = Color.UpgradeGreenDark,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	ManaFormat =
	{
		Font = "LatoBold",
		BlockEmphasizedFont = true,
		Color = Color.RoyalBlue,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	ArmorFormat =
	{
		Font = "LatoBold",
		BlockEmphasizedFont = true,
		Color = Color.LimeGreen,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	PenaltyFormat =
	{
		Font = "LatoBold",
		FontSize = 20,
		Color = Color.PenaltyRed,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	ShrineUpgradeDisplayPenaltyFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 26,
		Color = Color.PenaltyRed,
		ShadowBlur = 0,
		ShadowColor = { 95, 44, 44, 255 },
		ShadowOffset = { 0, 6 },
	},

	-- AutoToolTip
	TooltipUpgradeFormat =
	{
		Font = "LatoBold",
		FontSize = 17,
		Color = Color.UpgradeGreen,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Graft = true,
	},
	TooltipPenaltyFormat =
	{
		Font = "LatoBold",
		FontSize = 17,
		Color = Color.PenaltyRed,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Graft = true,
	},

	ShrinePenaltyFormat =
	{
		Font = "LatoBold",
		FontSize = 17,
		Color = Color.PenaltyRed,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Graft = true,
	},

	-- Misc
	CauseOfDeathFormat =
	{
		Graft = true,
		Color = Color.Tomato,
		ShadowBlur = 3, ShadowColor = {0.0, 0.0, 0.0, 1.0}, ShadowOffset = {0, 2},
		VerticalJustification = "Top",
	},
	OverlookFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 28,
		Color = { 0.398, 0.802, 0.314, 0.6 },
	},

	-- for Dialogue
	DialogueItalicFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		LineSpacingBottom = 4,
	},
	Emph =
	{
		Graft = true,
		UseEmphasizedFont = true,
		LineSpacingBottom = 4,
	},
	EmphLegendary =
	{
		Graft = true,
		UseEmphasizedFont = true,
		LineSpacingBottom = 4,
		Color = Color.BoonPatchLegendary,
	},
	Echo1 =
	{
		Graft = true,
		Color = Color.EchoText1,
	},
	Echo2 =
	{
		Graft = true,
		Color = Color.EchoText2,
	},
	Echo3 =
	{
		Graft = true,
		Color = Color.EchoText3,
	},

	-- for Codex
	-- @Gavin: adding this because {#Prev} did not work for strings such as Codex_Complete. [GK 6/14/18]
	CodexStandardFormat =
	{
		Font = "LatoSemiboldItalic",
		FontSize = 24,
		Color = Color.CodexTitleUnselected,
		LangFrScaleModifier = 1.0,
		LangRuScaleModifier = 1.0,
		LangPtBrScaleModifier = 1.0,
		LangKoScaleModifier = 1.0,
		LangJaScaleModifier = 1.0,
		Graft = true,
	},

	CodexBoldFormat =
	{
		Font = "LatoBold",
		Color = Color.CodexText,
		Graft = true,
	},

	CodexItalicFormat =
	{
		Font = "LatoSemiboldItalic",
		Graft = true,
	},

	CodexItalicBoldFormat =
	{
		Font = "LatoBoldItalic",
		Graft = true,
	},

	CodexPreReqFormat =
	{
		Font = "LatoSemiboldItalic",
		Color = {0.965, 0.702, 0.031, 1.0},
		LangFrScaleModifier = 1.0,
		LangRuScaleModifier = 1.0,
		LangPtBrScaleModifier = 1.0,
		LangKoScaleModifier = 1.0,
		LangJaScaleModifier = 1.0,
		Graft = true,
	},

	CodexPreReqNumberFormat =
	{
		Font = "LatoSemiboldItalic",
		Color = {1.000, 0.984, 0.729, 1.0},
		LangFrScaleModifier = 1.0,
		LangRuScaleModifier = 1.0,
		LangPtBrScaleModifier = 1.0,
		LangKoScaleModifier = 1.0,
		LangJaScaleModifier = 1.0,
		Graft = true,
	},

	CodexChapterClearFormat =
	{
		Font = "LatoSemiboldItalic",
		Color = {0.718, 0.596, 0.180, 1.0},
		LangDeScaleModifier = 1.0,
		LangRuScaleModifier = 1.0,
		LangKoScaleModifier = 1.0,
		LangJaScaleModifier = 1.0,
		Graft = true,
	},

	LootFormat =
	{
		FontSize = 24,
		Font = "P22UndergroundSCMedium",
		ShadowColor = Color.Green,
		ShadowOffset = {0, 2},
		ShadowBlur = 0,
		TextSymbolScale = 0.1,
	},

	UseTextFormat =
	{
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.White,
		Font = "LatoBold",
		FontSize = 26,
		TextSymbolScale = 0.75,
	},

	UseTextDamageFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.Red,
	},

	UseTextHealingFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.LimeGreen,
	},

	UseTextManaFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.RoyalBlue,
	},

	UseTextArmorFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.LimeGreen,
	},

	UseTextPreReqFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.Gold,
	},

	UseTextDisabledFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 155, 155, 155, 180 },
	},

	UseMetaPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 168, 0, 168, 255 },
	},

	UseMoneyFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.LightGold,
	},

	UseShrinePointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.ShrinePoint,
	},

	UseGiftPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = {1, 0.97, 0.7, 1},
	},

	UseLockKeyFormat =
	{
		Graft = true,
		ShadowBlur = 0,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.MetaUpgradePointsDisplay,
	},

	UseTextChallengeFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.DarkViolet,
	},

	MetaPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 168, 0, 168, 255 },
	},

	CombatTextHighlightFormat =
	{
		Graft = true,
		Color = Color.Orange,
	},

	-- DebugEnemySpawn
	DebugEnemySpawnBiomeFormat =
	{
		Font = "LatoMedium",
		Color = Color.Yellow,
		FontSize = 20,
	},

	DebugEnemySpawnEnemyFormat =
	{
		Graft = true,
		Font = "LatoMedium",
		Color = Color.Yellow,
	},

	-- Used for translator comments, e.g. {#TODO:harmonize spelling of keyword} or simply {#TODO}
	TODO =
	{
		Graft = true,
	}

}

IconData =
{
	BlankIcon =
	{
		TexturePath = "Dev\\blank_invisible",
	},

	SaveSymbol =
	{
		TexturePath = "GUI\\Icons\\Hades_Symbol_01",
		
		TextSymbolScale = 0.5,
	},

	Currency =
	{
		TexturePath = "GUI\\Icons\\Currency",
	},
	Currency_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\Currency",
	},
	MoneyDrop =
	{
		TexturePath = "Items\\Resources\\Common\\MoneyDrop_Text",
	},

	MaxManaDrop =
	{
		TexturePath = "Items\\Loot\\MaxManaDrop_Text",
	},

	PlantMoney =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantMoney_Text",
	},
	PlantMoneyIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantMoney_Text",
	},
	PlantMoney_NoTooltip =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantMoney_Text",
	},

	RandomLoot = 
	{
		TexturePath = "GUI\\Icons\\RandomLoot"
	},
	RandomLootGiftItem = 
	{
		TexturePath = "GUI\\Icons\\RandomLoot"
	},

	HealDrop = 
	{
		TexturePath = "Items\\Loot\\HealthItem01",
	},

	LastStandGiftItem = 
	{
		TexturePath = "Items\\Loot\\LastStand"
	},
	LastStand_NoTooltip = 
	{
		TexturePath = "Items\\Loot\\LastStand"
	},

	-- Old From Minos
	TraitExchange =
	{
		TexturePath = "GUI\\Icons\\TraitExchange",
	},

	Quest =
	{
		TexturePath = "GUI\\Icons\\Map\\Sub_Icon_Quest",
	},

	TallyDotPlus =
	{
		TexturePath = "GUI\\Screens\\XP_Tally_Dot_Plus",
	},

	TallyDotX =
	{
		TexturePath = "GUI\\Screens\\XP_Tally_Dot_X",
	},

	RightArrow =
	{
		TexturePath = "GUI\\HUD\\tooltip_arrow",
	},

	Bullet =
	{
		TexturePath = "GUI\\Icons\\Bullet",
	},

	Div =
	{
		TexturePath = "GUI\\HorizontalDivider",
	},

	DivLong =
	{
		TexturePath = "GUI\\HorizontalDividerLong",
	},

	StandingsRankInfinite =
	{
		TexturePath = "GUI\\Screens\\StandingsRankInfinite",
	},

	Health =
	{
		TexturePath = "GUI\\Icons\\Life",
	},
	HealthHome =
	{
		TexturePath = "GUI\\Icons\\Life",
	},

	HealthUp =
	{
		TexturePath = "GUI\\Icons\\LifeUp",
	},
	HealthUpAlt =
	{
		TexturePath = "GUI\\Icons\\LifeUp_Empty",
	},

	HealthDown =
	{
		TexturePath = "GUI\\Icons\\LifeUp",
	},

	HealthRestore =
	{
		TexturePath = "GUI\\Icons\\LifeRestore",
	},
	HealthRestoreHome =
	{
		TexturePath = "GUI\\Icons\\LifeRestore",
	},
	HealthAlly =
	{
		TexturePath = "GUI\\Icons\\Life",
	},
	EnemyHealth =
	{
		TexturePath = "GUI\\Icons\\Life",
	},

	Mana =
	{
		TexturePath = "GUI\\Icons\\Mana",
	},
	Mana_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\Mana",
	},

	ManaUp =
	{
		TexturePath = "GUI\\Icons\\ManaUp",
	},
	ManaUp_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\ManaUp",
	},

	ManaDown =
	{
		TexturePath = "GUI\\Icons\\ManaUp",
	},

	ShieldHealth =
	{
		TexturePath = "GUI\\Icons\\UnLife",
	},

	ArmorTotal =
	{
		TexturePath = "GUI\\Icons\\Armor",
	},
	ArmorTotal_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\Armor",
	},

	Omega =
	{
		TexturePath = "GUI\\Icons\\Omega",
	},
	Omega_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\Omega",
	},

	Elite =
	{
		TexturePath = "GUI\\Icons\\Elite_Badge_01",
	},

	MiniBoss =
	{
		TexturePath = "GUI\\Icons\\Elite_Badge_02",
	},

	ElitePerk =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Brawny",
	},

	LobAmmo =
	{
		TexturePath = "GUI\\HUD\\WitchGrenadeIconHUD"
	},
	LobAmmoInfo =
	{
		TexturePath = "GUI\\Icons\\LobAmmo"
	},
	LobAmmo_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\LobAmmo"
	},
	Fuel =
	{
		TexturePath = "GUI\\Icons\\Status\\Enraged",
	},
	Fuel_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\Status\\Enraged",
	},

	ReRoll =
	{
		TexturePath = "GUI\\Icons\\ReRoll",
	},	
	ReRollAlt =
	{
		TexturePath = "GUI\\Icons\\ReRoll",
	},
	
	ReRollPanelAlt =
	{
		TexturePath = "GUI\\Icons\\ReRoll",
	},

	Dash =
	{
		TexturePath = "GUI\\Icons\\Dash",
	},

	UpArrow =
	{
		TexturePath = "GUI\\Icons\\UpArrow",
	},
	DownArrow =
	{
		TexturePath = "GUI\\Icons\\DownArrow",
	},

	ExtraChance =
	{
		TexturePath = "GUI\\HUD\\HealthBar_1up",
	},
	ExtraChanceAlt =
	{
		TexturePath = "GUI\\HUD\\HealthBar_1up",
	},
	ExtraChanceRegen =
	{
		TexturePath = "GUI\\Icons\\ExtraChanceRegen",
	},
	ExtraChanceCat =
	{
		TexturePath = "GUI\\HUD\\HealthBar_1upEcho",
	},

	Alert =
	{
		TexturePath = "GUI\\Icons\\Status\\WantsToFight",
	},

	Aware =
	{
		TexturePath = "GUI\\Icons\\Status\\Aware",
	},

	Startled  =
	{
		TexturePath = "GUI\\Icons\\Status\\Startled",
	},

	AttackWarning =
	{
		TexturePath = "GUI\\Icons\\Status\\WantsToTalk",
	},

	Currency =
	{
		TexturePath = "GUI\\Icons\\Currency",
	},
	
	MetaPoint =
	{
		TexturePath = "GUI\\Icons\\Darkness",
	},

	Gems =
	{
		TexturePath = "GUI\\Icons\\Gems",
	},

	SuperGems =
	{
		TexturePath = "GUI\\Icons\\SuperGems",
	},

	SuperLockKeys =
	{
		TexturePath = "GUI\\Icons\\Blood",
	},

	RandomPom =
	{
		TexturePath = "GUI\\Icons\\RandomPom",
	},

	RandomHammer =
	{
		TexturePath = "GUI\\Icons\\RandomHammer",
	},

	RandomPom =
	{
		TexturePath = "GUI\\Icons\\RandomPom",
	},

	Pom =
	{
		TexturePath = "GUI\\Icons\\Pom",
	},

	Onion =
	{
		TexturePath = "GUI\\Icons\\Onion",
	},

	MaxMana =
	{
		TexturePath = "Items\\Loot\\MaxManaDrop_Preview",
	},

	MetaCardPoints =
	{
		TexturePath = "Items\\Loot\\MaxManaDrop_Preview",
	},

	Hammer = 
	{
		TexturePath = "GUI\\Icons\\Hammer",
	},

	FatedChoice =
	{
		TexturePath = "GUI\\Screens\\QuestLog\\QuestAdded_Small",
	},

	StoreItemPin =
	{
		TexturePath = "GUI\\Icons\\Reminder",
	},

	StoreItemPinNoTooltip =
	{
		TexturePath = "GUI\\Icons\\Reminder",
	},

	ShrinePoint =
	{
		TexturePath = "GUI\\Icons\\ShrinePoint",
	},
	ShrinePointNoTooltip =
	{
		TexturePath = "GUI\\Icons\\ShrinePoint",
	},

	PoisonIcon =
	{
		TexturePath = "GUI\\Icons\\PoisonIcon",
	},
	MythPoint =
	{
		TexturePath = "GUI\\Icons\\Contract",
	},

	GiftPoints =
	{
		TexturePath = "GUI\\Icons\\Gift",
	},
	GiftPointsIcon =
	{
		TexturePath = "GUI\\Icons\\Gift",
	},
	GiftPointsRareIcon =
	{
		TexturePath = "Items\\Resources\\Other\\GiftPointsRare_Text",
	},
	GiftPointsEpicIcon =
	{
		TexturePath = "Items\\Resources\\Other\\GiftPointsEpic_Text",
	},
	SuperGiftPoints =
	{
		TexturePath = "GUI\\Icons\\SuperGift",
	},
	SuperGiftPointsIcon =
	{
		TexturePath = "GUI\\Icons\\SuperGift",
	},

	LockKeys =
	{
		TexturePath = "GUI\\Icons\\LockKey",
	},

	ManaLock =
	{
		TexturePath = "GUI\\Icons\\ManaLock",
	},

	RunReward =
	{
		TexturePath = "GUI\\Icons\\RunReward",
	},
	MetaReward =
	{
		TexturePath = "GUI\\Icons\\MetaReward",
	},

	FavorPoint =
	{
		TexturePath = "GUI\\Icons\\Favor",
	},

	LimitedTimeOffer =
	{
		TexturePath = "GUI\\Screens\\LimitedTimeOffer",
	},
	SpecialOffer =
	{
		TexturePath = "GUI\\Screens\\LimitedTimeOffer",
	},

	Locked =
	{
		TexturePath = "GUI\\Icons\\Locked",
	},

	PurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\ContractorPurchasedCheckmark",
	},

	MirrorInactive =
	{
		TexturePath = "GUI\\Screens\\MirrorLockedB",
	},

	DefaultPurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\MirrorUnlockedA",
	},

	MirrorPurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\MirrorUnlockedB",
	},

	PactPurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\MirrorUnlockedC",
	},

	CheckboxEmpty =
	{
		TexturePath = "GUI\\Shell\\settings_toggle_off",
	},
	CheckboxFilled =
	{
		TexturePath = "GUI\\Shell\\settings_toggle_on",
	},

	RewardLoot =
	{
		TexturePath = "GUI\\Icons\\RewardLoot",
	},

	RewardBoon =
	{
		TexturePath = "GUI\\Icons\\Boon",
	},

	RewardStackUpgrade =
	{
		TexturePath = "GUI\\Icons\\Contract_01",
	},

	RewardMetaModifier =
	{
		TexturePath = "GUI\\Icons\\RewardMetaModifier",
	},

	RewardShop =
	{
		TexturePath = "GUI\\Icons\\RewardShop",
	},

	RewardStory =
	{
		TexturePath = "GUI\\Icons\\RewardStory",
	},

	RewardRandom =
	{
		TexturePath = "GUI\\Icons\\RewardRandom",
	},

	RewardUnknown =
	{
		TexturePath = "GUI\\Icons\\RewardUnknown",
	},

	BuffHealing =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\hydralite_05_small",
		

	},
	BuffWeapon =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\cyclops_jerky_01_small",
	},
	BuffExtraChance =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\kiss_of_styx_13_small",
	},
	BuffExtraChanceAlt =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\kiss_of_styx_13_small",
	},

	BuffMegaPom =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\pom_porridge_small",
	},
	BuffSlottedBoonRarity =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\ambrosia_delight_small",
	},
	BuffFutureBoonRarity =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\refreshing_nectar_small",
	},

	StarFull =
	{
		TexturePath = "GUI\\Icons\\StarFull",
	},

	StarEmpty =
	{
		TexturePath = "GUI\\Icons\\StarEmpty",
	},

	Infinite =
	{
		TexturePath = "GUI\\HUD\\InfiniteIcon",
	},

	Slash =
	{
		TexturePath = "GUI\\HUD\\Slash",
	},
	
	SlashDark =
	{
		TexturePath = "GUI\\HUD\\SlashDark",
	},

	Clock =
	{
		TexturePath = "GUI\\HUD\\TimeIcon",
	},

	Refresh =
	{
		TexturePath = "GUI\\HUD\\RefreshIcon",
	},

	Shielded =
	{
		TexturePath = "GUI\\Icons\\Status\\MyrmidonBracer"
	},

	Champion =
	{
		TexturePath = "GUI\\Icons\\Hades_Symbol_01"
	},

	Elite =
	{
		TexturePath = "GUI\\Icons\\Elite_Badge_01"
	},
	NoCanDo =
	{
		TexturePath = "GUI\\Icons\\NoCanDo",
	},

	MetaRank1_Icon = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Common",
	},
	MetaRank1_NoTooltip = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Common",
	},

	MetaRank2_Icon = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Rare",
	},
	MetaRank2_NoTooltip = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Rare",
	},

	MetaRank3_Icon = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Epic",
	},
	MetaRank3_NoTooltip = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Epic",
	},

	MetaRank4_Icon = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Heroic",
	},
	MetaRank4_NoTooltip = 
	{
		TexturePath = "GUI\\Icons\\CardRarityIcon_Heroic",
	},

	PomLevel =
	{
		TexturePath = "GUI\\Icons\\UpArrow",
	},
	PomLevel_NoTooltip =
	{
		TexturePath = "GUI\\Icons\\UpArrow",
	},

	Moon_Crescent =
	{
		TexturePath = "GUI\\Icons\\Moon_Crescent",
	},
	Moon_Half =
	{
		TexturePath = "GUI\\Icons\\Moon_Half",
	},
	Moon_Full =
	{
		TexturePath = "GUI\\Icons\\Moon_Full",
	},


	AwardRank1 =
	{
		--TexturePath = "GUI\\Screens\\AwardMenu\\altRank_1",
		TexturePath = "GUI\\Screens\\AwardMenu\\rank_1",
	},

	AwardRank2 =
	{
		--TexturePath = "GUI\\Screens\\AwardMenu\\altRank_2",
		TexturePath = "GUI\\Screens\\AwardMenu\\rank_2",
	},

	AwardRank3 =
	{
		--TexturePath = "GUI\\Screens\\AwardMenu\\altRank_3",
		TexturePath = "GUI\\Screens\\AwardMenu\\rank_3",
	},

	AwardRank4 =
	{
		--TexturePath = "GUI\\Screens\\AwardMenu\\altRank_3",
		TexturePath = "GUI\\Screens\\AwardMenu\\rank_4",
	},

	LegendaryAwardRank1 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_1",
	},

	LegendaryAwardRank2 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_2",
	},

	LegendaryAwardRank3 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_3",
	},

	LegendaryAwardRank4 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_4",
	},

	LegendaryAwardRank5 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\rank_5",
	},

	EasyModeIcon =
	{
		TexturePath = "GUI\\Shell\\EasyMode"
	},

	RelationshipHeartIcon =
	{
		TexturePath = "GUI\\Icons\\RelationshipHeart",
	},

	QuestProgressIncomplete =
	{
		TexturePath = "GUI\\Graybox\\RadioButton_Unselected",
	},

	QuestProgressComplete =
	{
		TexturePath = "GUI\\Graybox\\RadioButton_Selected",
	},

	Music =
	{
		TexturePath = "GUI\\Icons\\Music",
	},

	RunClearStar =
	{
		TexturePath = "GUI\\Icons\\RunClearStar",
	},	

	RunClearDotsLeft =
	{
		TexturePath = "GUI\\Icons\\DotsLeft",
	},	

	RunClearDotsRight =
	{
		TexturePath = "GUI\\Icons\\DotsRight",
	},

	BountySkull =
	{
		TexturePath = "GUI\\Icons\\BountySkull",
	},
	BountySkullEmpty =
	{
		TexturePath = "GUI\\Icons\\BountySkullEmpty",
	},	
	BountyUnknown =
	{
		TexturePath = "GUI\\Icons\\BountyUnknown",
	},

	PerfectDashIcon =
	{
		TexturePath = "GUI\\Screens\\MirrorBIcons\\Greater_Celerity",
		TextSymbolScale = 0.5,
	},

	FrogIcon =
	{
		TexturePath = "GUI\\Icons\\Tool_Book_Frog"
	},
	CatIcon =
	{
		TexturePath = "GUI\\Icons\\Tool_FishingRod_Cat"
	},
	RavenIcon =
	{
		TexturePath = "GUI\\Icons\\Tool_Pickaxe_Raven"
	},

	Pause =
	{
		TexturePath = "GUI\\Icons\\Pause",
	},

	ExorcismLeft =
	{
		TexturePath = "GUI\\Icons\\MelArmLeft",
	},
	ExorcismRight =
	{
		TexturePath = "GUI\\Icons\\MelArmRight",
	},

	InventoryCategoryFish =
	{
		TexturePath = "GUI\\Screens\\Inventory\\Icon-Fish",
	},

	InventoryCategoryForgetMeNots =
	{
		TexturePath = "GUI\\Screens\\Inventory\\Icon-ForgetMeNots",
	},

	InventoryCategoryGifts =
	{
		TexturePath = "GUI\\Screens\\Inventory\\Icon-Gifts",
	},

	InventoryCategoryReagents =
	{
		TexturePath = "GUI\\Screens\\Inventory\\Icon-Reagents",
	},

	InventoryCategoryResources =
	{
		TexturePath = "GUI\\Screens\\Inventory\\Icon-Resources",
	},

	InventoryIcon =
	{
		TexturePath = "GUI\\Screens\\Inventory\\Icon-Inventory",
	},

	ToolPickIcon =
	{
		TexturePath = "GUI\\Icons\\Pickaxe",
	},
	ToolBookIcon =
	{
		TexturePath = "GUI\\Icons\\ExorcismBook",
	},
	ToolShovelIcon =
	{
		TexturePath = "GUI\\Icons\\Shovel",
	},
	ToolRodIcon =
	{
		TexturePath = "GUI\\Icons\\FishingRod",
	},

	CurseEarth = 
	{
		TexturePath = "GUI\\Icons\\Element_Earth_Text",
	},
	CurseFire = 
	{
		TexturePath = "GUI\\Icons\\Element_Fire_Text",
	},
	CurseAir = 
	{
		TexturePath = "GUI\\Icons\\Element_Air_Text",
	},
	CurseWater = 
	{
		TexturePath = "GUI\\Icons\\Element_Water_Text",
	},
	CurseAether = 
	{
		TexturePath = "GUI\\Icons\\Element_Aether_Text",
	},
	ManaCrystal = 
	{
		TexturePath = "GUI\\Icons\\ManaCrystal",
	},

	MetaCardPointsCommonIcon =
	{
		TexturePath = "Items\\Resources\\Common\\MetaCardPointsCommon_Text",
	},
	MetaCurrencyIcon =
	{
		TexturePath = "Items\\Resources\\Common\\MetaCurrency_Text",
	},
	MemPointsCommonIcon =
	{
		TexturePath = "Items\\Resources\\Common\\MemPointsCommon_Text",
	},
	MemPointsCommon_NoTooltip =
	{
		TexturePath = "Items\\Resources\\Common\\MemPointsCommon_Text",
	},
	PlantFMolyIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantFMoly_Text",
	},
	PlantFMoly_NoTooltip =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantFMoly_Text",
	},
	OreFSilverIcon =
	{
		TexturePath = "Items\\Resources\\Ore\\OreFSilver_Text",
	},
	OreFSilver_NoTooltip =
	{
		TexturePath = "Items\\Resources\\Ore\\OreFSilver_Text",
	},
	MetaFabricIcon =
	{
		TexturePath = "Items\\Resources\\Common\\MetaFabric_Text",
	},
	MetaFabric_NoTooltip =
	{
		TexturePath = "Items\\Resources\\Common\\MetaFabric_Text",
	},
	Mixer5CommonIcon =
	{
		TexturePath = "Items\\Resources\\Other\\Mixer5Common_Text",
	},
	CardUpgradePointsIcon =
	{
		TexturePath = "Items\\Resources\\Other\\CardUpgradePoints_Text",
	},
	FamiliarPointsIcon =
	{
		TexturePath = "Items\\Resources\\Alchemy\\FamiliarPoints_Text",
	},
	FamiliarPointsIcon_NoTooltip =
	{
		TexturePath = "Items\\Resources\\Alchemy\\FamiliarPoints_Text",
	},	
	PlantFNightshadeIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantFNightshade_Text",
	},
	PlantFNightshadeSeedIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantFNightshadeSeed_Text",
	},
	SeedMysteryIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantMysterySeed_Text",
	},
	PlantIPoppyIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantIPoppy_Text",
	},
	PlantGCattailIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantGCattail_Text",
	},
	PlantNGarlicSeedIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantNGarlicSeed_Text",
	},
	PlantNGarlicIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantNGarlic_Text",
	},
	PlantOMandrakeSeedIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantOMandrakeSeed_Text",
	},
	PlantOMandrakeIcon =
	{
		TexturePath = "Items\\Resources\\Plant\\PlantOMandrake_Text",
	},
	BountyEyeIcon =
	{
		TexturePath = "GUI\\Icons\\BountyBoardEye"
	},
}

-- Remembrances
RunIntroData =
{
	-- game intro
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "==",
				Value = 0,
			},
		},
		Header = "Intro_Hades",
		FadeOutWait = 15.1,
		PauseMusic = true,
		SubtitleColor = Color.NarratorVoice,
		SpeakerName = "Storyteller",
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0042", Text = "{#Emph}Few tales are told of Hades, whose reign as grim lord of the dead came to a sudden end when, all at once, his past caught up with him.", PreLineWait = 0.72, NoTarget = true },
			{ Cue = "/VO/Storyteller_0043", Text = "{#Emph}But gods do not go quietly, and history repeats. So this tale was only a matter of Time...", PreLineWait = 0.8, NoTarget = true },
		},
		BackgroundAnimation = "Blank",
		SkipBackgrounds = true,
		Animations = 
		{
			{
				AnimationName = "RemBGIntro",
				Delay = 0,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
		},
	},
}

ConstantsData.DefaultUseText = "InGameUI_Use"
ConstantsData.ReportedCriticalMultiplier = "200"

CombatUI =
{
	AutoHideEnabled = true,
	HideDelay = 16,
	HealthBarFalloffDelay = 0.25,
	SmallHealthBarScale = 0.6,
	MediumHealthBarScale = 1.0,
	MediumLargeHealthBarScale = 1.5,
	LargeHealthBarScale = 2.0,
	ExtraLargeHealthBarScale = 2.5,
	SmallHeathBarThreshold = 80,
	MediumHealthBarThreshold = 250,
	MediumLargeHealthBarThreshold = 320,
	DeathHoldDuration = 0.0,
	PoisonPipSpacing= 20,
	PoisonPipMaxWidth= 75,
	AmmoPipSpacing= 22,
	AmmoPipMaxWidth= 66,
	PoisonPipBossSpacing= 30,
	FadeDistance =
	{
		-- left ui
		Shadow = 20,
		Trait = 0,
		Health = 30,
		Super = 20,
		Mana = 20,
		Ammo = 20,
		-- right ui
		ShrinePoint = 50,
		MetaPoint = 40,
		Money = 30,
		GiftPoint = 20,
		LockKey = 10,
	},
	TraitUIStart = 50,
	FadeDuration = 0.5,
	TraitFadeDuration = 0.15,
	FadeInDuration = 0.5,
	HideThreadName = "CombatUIHide",
	DamageTextHoldTime = 0.25,
	DamageTweenSpeed = 0.5,				-- Min amount to increment towards the final number
	DamageTextCoalesceAll = false,
	MaxDamageDistance = 300,			-- Maximum distance damage numbers can drift from an enemy
}

ScreenCenterX = 1920/2
ScreenCenterY = 1080/2

ScreenWidth = 1920
ScreenHeight = 1080

UIData =
{
	Binks =
	{
		"RoomTransition",
		"RoomTransitionOut",
		"DeathSequenceMelBG",
		"DialogueBackgroundWoodsIn",
		"DialogueBackgroundWoods",
		"DialogueBackgroundWoodsOut",
		"DialogueBackgroundOlympusIn",
		"DialogueBackgroundOlympus",
		"DialogueBackgroundOlympusOut",
		"DialogueSpeechBubbleFx",
	},

	ActionBarY = 984,
	ActionBarBottomOffset = 96,

	ContextualButtonSpacing = 120,

	AutoAlignContextualButtonSpacing = 25,
	AutoAlignContextualButtonGlyphWidth = 35,

	ContextualButtonXLeft = 40,
	ContextualButtonXMiddleLeft = 960 + 528,
	ContextualButtonXMiddleRight = 960 + 585,
	ContextualButtonXRight = 1875,

	ContextualButtonY = 1030,
	ContextualButtonBottomOffset = 50,

	DoorTextCumulativeDelay = 0.4,

	PinIconListOffsetY = -15,

	ContextualButtonFormatLeft =
	{ 
		FontSize = 20,
		Width = 415,
		LineSpacingBottom = 0,
		Color = { 0.58, 0.34, 0.78, 1.0 },
		Font = "LatoBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "LEFT",
		VerticalJustification = "CENTER",
	},

	ContextualButtonFormatRight =
	{ 
		FontSize = 20,
		Width = 415,
		LineSpacingBottom = 0,
		Color = { 0.58, 0.34, 0.78, 1.0 },
		Font = "LatoBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "RIGHT",
		VerticalJustification = "CENTER",
	},

	BoonMenuId = "BoonMenu",
	Constants =
	{
		PENDING_REVEAL = "pending",
		VISIBLE = "visible",
	},
	ZeroMouseFlags =
	{

	},
	BlockTimerFlags =
	{

	},

	UsePrompt =
	{
		CenterOffsetX = 0,
		BottomOffset = -10,
		AttractAnim = "InteractBacking",
		AttractAnimOff = "InteractBackingFade",
		TextFormat =
		{
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 5},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = Color.White,
			Font = "P22UndergroundSCHeavy",
			FontSize = 22,
			LineSpacingTop = 0,
			LineSpacingBottom = 0,
			TextSymbolScale = 1.0,
		}
	},

	CurrentRunDepth =
	{
		RightOffset = 180,
		Y = 30,
		TextFormat =
		{
			Justification = "Right",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 5},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {220, 220, 220, 255},
			Font = "P22UndergroundSCMedium",
			FontSize = 22,
			TextSymbolScale = 0.8,
		}
	},

	DisplayInfoBanner =
	{
		TitleTextArgs =
		{
			Justification = "CENTER",
			Font = "SpectralSCLightTitling",
			NonEnglishFont = "SpectralSCLight",
			FontSize = 42,
			Width = 1600,
			ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			CharacterFadeTime = 0, 
			CharacterFadeInterval = 0,
		},
		SubtitleTextArgs =
		{
			Justification = "CENTER",
			Width = 1600,
			Font = "SpectralSCMedium",
			FontSize = 30,
			Color = Color.Gold,
			ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			TextSymbolScale = 0.5,
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
		},
		SupertitleTextArgs =
		{
			Justification = "CENTER",
			Width = 1600,
			Font = "SpectralSCMedium",
			FontSize = 22,
			ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
		},
	}
}

ShopUI =
{
	ShopItemStartX = ScreenCenterX,
	ShopItemSpacerX = 820,
	ShopItemStartY = 340,
	ShopItemSpacerY = 220,
}

HealthUI =
{
	LowHealthThreshold = 0.35,
	LowHealthMaximum = 50, -- if you have a lot of max health, its only considered low heatlh below this absolute value
	LowHealthMinimum = 10, -- if you have a very low max health, any health below this absolute value is considered low health
	MajorHitThreshold = 0.15,
}

CombatControlsDefaults = 
{
	"Rush", "Shout", "Assist", "Attack2", "Attack1", "Attack3", "AutoLock"
}

GamepadNavigationDefaults =
{
	"FreeFormSelectWrapY",
	"FreeFormSelectGridLock",
	"FreeFormSelectStepDistance",
	"FreeFormSelectSuccessDistanceStep",
	"FreeFormSelectRepeatDelay",
	"FreeFormSelectRepeatInterval",
	"FreeFormSelecSearchFromId",
	"ExclusiveInteractGroup",
}