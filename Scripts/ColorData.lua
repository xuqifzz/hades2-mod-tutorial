--[[
	* Global Color Defines *

To Use:
	Add "Import "Color.lua"" to script file
	Access defined colors: Color.Red
	Create your own color palette

	MyColors =
	{
		MyColor1 = { 0,0,0,0 },
		MyColor2 = { 1,1,1 },
	}

	AdjustFrame({ Color = MyColors.MyColor1 )}
]]

-- Don't forget to add the comma!!!
Color =
{
	TransparentBlack = { 0, 0, 0, 0 },
	Transparent = { 0, 0, 0, 0 },
	TransparentWhite = { 255, 255, 255, 0 },
	SemiTransparentAntiqueWhite = { 250, 235, 215, 80 },
	SemiTransparentLightCoral = { 240, 128, 128, 200 },
	SemiTransparentBlack = { 0, 0, 0, 80 },
	AliceBlue = { 240, 248, 255, 255 },
	AntiqueWhite = { 250, 235, 215, 255 },
	Aqua = { 0, 255, 255, 255 },
	Aquamarine = { 127, 255, 212, 255 },
	Azure = { 240, 255, 255, 255 },
	Beige = { 245, 245, 220, 255 },
	Bisque = { 255, 228, 196, 255 },
	Black = { 0, 0, 0, 255 },
	BlanchedAlmond = { 255, 235, 205, 255 },
	Blue = { 0, 0, 255, 255 },
	BlueViolet = { 138, 43, 226, 255 },
	Brown = { 165, 42, 42, 255 },
	BurlyWood = { 222, 184, 135, 255 },
	CadetBlue = { 95, 158, 160, 255 },
	Chartreuse = { 127, 255, 0, 255 },
	Chocolate = { 210, 105, 30, 255 },
	Coral = { 255, 127, 80, 255 },
	CornflowerBlue = { 100, 149, 237, 255 },
	Cornsilk = { 255, 248, 220, 255 },
	Crimson = { 207, 83, 45, 255 },
	Cyan = { 0, 255, 255, 255 },
	DarkBlue = { 0, 0, 139, 255 },
	DarkCyan = { 0, 139, 139, 255 },
	DarkGoldenrod = { 184, 134, 11, 255 },
	DarkGray = { 169, 169, 169, 255 },
	DarkGreen = { 0, 100, 0, 255 },
	DarkKhaki = { 189, 183, 107, 255 },
	DarkMagenta = { 139, 0, 139, 255 },
	DarkOliveGreen = { 85, 107, 47, 255 },
	DarkOrange = { 255, 140, 0, 255 },
	DarkOrchid = { 153, 50, 204, 255 },
	DarkRed = { 139, 0, 0, 255 },
	DarkSalmon = { 233, 150, 122, 255 },
	DarkSeaGreen = { 143, 188, 139, 255 },
	DarkSlateBlue = { 72, 61, 139, 255 },
	DarkSlateGray = { 47, 79, 79, 255 },
	DarkTurquoise = { 0, 206, 209, 255 },
	DarkViolet = { 148, 0, 211, 255 },
	DeepPink = { 255, 20, 147, 255 },
	DeepSkyBlue = { 0, 191, 255, 255 },
	DimGray = { 105, 105, 105, 255 },
	DodgerBlue = { 30, 144, 255, 255 },
	Firebrick = { 178, 34, 34, 255 },
	FloralWhite = { 255, 250, 240, 255 },
	ForestGreen = { 34, 139, 34, 255 },
	Fuchsia = { 255, 0, 255, 255 },
	Gainsboro = { 220, 220, 220, 255 },
	GhostWhite = { 248, 248, 255, 255 },
	Gold = { 255, 214, 49, 255 },
	LightGold = { 255, 240, 100, 255 },
	Goldenrod = { 218, 165, 32, 255 },
	Gray = { 128, 128, 128, 255 },
	Green = { 0, 128, 0, 255 },
	GreenYellow = { 173, 255, 47, 255 },
	Honeydew = { 240, 255, 240, 255 },
	HotPink = { 255, 105, 180, 255 },
	IndianRed = { 205, 92, 92, 255 },
	Indigo = { 75, 0, 130, 255 },
	Ivory = { 255, 255, 240, 255 },
	Khaki = { 240, 230, 140, 255 },
	Lavender = { 230, 230, 250, 255 },
	LavenderBlush = { 255, 240, 245, 255 },
	LawnGreen = { 124, 252, 0, 255 },
	LemonChiffon = { 255, 250, 205, 255 },
	LightBlue = { 173, 216, 230, 255 },
	LightPurple = { 255, 204, 255, 255 },
	LightCoral = { 240, 128, 128, 255 },
	LightCyan = { 224, 255, 255, 255 },
	LightGoldenrodYellow = { 250, 250, 210, 255 },
	LightGreen = { 144, 238, 144, 255 },
	SemiTransparentLightGreen= { 144, 238, 144, 80 },
	LightGray = { 211, 211, 211, 255 },
	LightPink = { 255, 182, 193, 255 },
	LightSalmon = { 255, 160, 122, 255 },
	LightSeaGreen = { 32, 178, 170, 255 },
	LightSkyBlue = { 135, 206, 250, 255 },
	LightSlateGray = { 119, 136, 153, 255 },
	LightSteelBlue = { 176, 196, 222, 255 },
	LightYellow = { 255, 255, 224, 255 },
	Lime = { 0, 255, 0, 255 },
	LimeGreen = { 50, 205, 50, 255 },
	Linen = { 250, 240, 230, 255 },
	Magenta = { 255, 0, 255, 255 },
	Maroon = { 128, 0, 0, 255 },
	MediumAquamarine = { 102, 205, 170, 255 },
	MediumBlue = { 0, 0, 205, 255 },
	MediumOrchid = { 186, 85, 211, 255 },
	MediumPurple = { 147, 112, 219, 255 },
	MediumSeaGreen = { 60, 179, 113, 255 },
	MediumSlateBlue = { 123, 104, 238, 255 },
	MediumSpringGreen = { 0, 250, 154, 255 },
	MediumTurquoise = { 72, 209, 204, 255 },
	MediumVioletRed = { 199, 21, 133, 255 },
	MidnightBlue = { 25, 25, 112, 255 },
	MintCream = { 245, 255, 250, 255 },
	MistyRose = { 255, 228, 225, 255 },
	Moccasin = { 255, 228, 181, 255 },
	NavajoWhite = { 255, 222, 173, 255 },
	Navy = { 0, 0, 128, 255 },
	OldLace = { 253, 245, 230, 255 },
	Olive = { 128, 128, 0, 255 },
	OliveDrab = { 107, 142, 35, 255 },
	Orange = { 255, 165, 0, 255 },
	OrangeRed = { 255, 69, 0, 255 },
	Orchid = { 218, 112, 214, 255 },
	PaleGoldenrod = { 238, 232, 170, 255 },
	PaleGreen = { 152, 251, 152, 255 },
	PaleTurquoise = { 175, 238, 238, 255 },
	PaleVioletRed = { 219, 112, 147, 255 },
	PapayaWhip = { 255, 239, 213, 255 },
	PeachPuff = { 255, 218, 185, 255 },
	Peru = { 205, 133, 63, 255 },
	Pink = { 255, 192, 203, 255 },
	Plum = { 221, 160, 221, 255 },
	PowderBlue = { 176, 224, 230, 255 },
	Purple = { 128, 0, 128, 255 },
	TransparentRed = { 255, 0, 0, 0 },
	Red = { 220, 20, 20, 255 },
	RosyBrown = { 188, 143, 143, 255 },
	RoyalBlue = { 65, 105, 225, 255 },
	SaddleBrown = { 139, 69, 19, 255 },
	Salmon = { 250, 128, 114, 255 },
	SandyBrown = { 244, 164, 96, 255 },
	SeaGreen = { 46, 139, 87, 255 },
	SeaShell = { 255, 245, 238, 255 },
	Sienna = { 160, 82, 45, 255 },
	Silver = { 192, 192, 192, 255 },
	SkyBlue = { 135, 206, 235, 255 },
	SlateBlue = { 106, 90, 205, 255 },
	SlateGray = { 112, 128, 144, 255 },
	Snow = { 255, 250, 250, 255 },
	SpringGreen = { 0, 255, 127, 255 },
	SteelBlue = { 70, 130, 180, 255 },
	Tan = { 210, 180, 140, 255 },
	Teal = { 0, 128, 128, 255 },
	Thistle = { 216, 191, 216, 255 },
	Tomato = { 255, 99, 71, 255 },
	Turquoise = { 64, 224, 208, 255 },
	Violet = { 238, 130, 238, 255 },
	Wheat = { 245, 222, 179, 255 },
	White = { 254, 255, 255, 255 },
	WhiteSmoke = { 245, 245, 245, 255 },
	Yellow = { 255, 255, 0, 255 },
	LightYellowGreen = { 241, 255, 204, 255 },
	YellowGreen = { 154, 205, 50, 255 },
	Title = { 255, 202, 110, 255 },
	Title2 = { 255, 198, 24, 255 },
	FlavorText = { 132, 83, 50, 255},
	MaxFlavorText = { 144, 105, 174, 255 },
	FlavorTextPurple = { 92, 71, 102, 255 },
	SubTitle = { 148, 132, 169, 255 },
	DefaultText = {229, 229, 229, 255 },
	DialogueText = {194, 192, 190, 255},
	DialogueTextLight = {32, 32, 30, 255},
	EchoText1 = {134, 132, 130, 255},
	EchoText2 = {84, 82, 80, 255},
	EchoText3 = {54, 52, 50, 255},
	NarrationText = {255, 255, 255, 255},
	ChoiceText = {102, 37, 22, 255},
	DialogueSpeakerName = {225, 225, 225, 255},
	DialogueSpeakerNameOlympian = {24, 24, 24, 255},
	MetaUpgradeAttribute = {240, 39, 58, 255},
	MetaUpgradeAttributeLocked = {80, 80, 80, 255},
	DarknessPoint = { 145, 56, 255, 255 },
	ShrinePoint = { 255, 190, 64, 255 },
	MirrorBAttribute = { 199, 255, 27, 255 },
	CodexTitleUnselected = { 140, 140, 140, 255 },
	CodexUnread = { 255, 218, 71, 255 },
	CodexText = { 219, 219, 219, 255 },
	CodexLocked = { 78, 82, 80, 255 },
	UpgradeGreen = { 115, 199, 69, 255 },
	UpgradeGreenDark = { 61, 97, 43, 255 },
	PenaltyRed = { 199, 15, 15, 255 },
	PactOrange = { 255, 125, 15, 255 },
	MetaUpgradePointsDisplay = { 219, 199, 255, 255 },
	MetaUpgradePointsInvalid = { 110, 100, 120, 255 },
	MetaUpgradePointsCappedColor = { 247, 98, 87, 255 },
	MetaUpgradePointsInvalidPulseColor = { 247, 98, 87, 255 },
	BoonGift = { 255, 140, 0, 255 },
	BoonTitle = { 210, 210, 210, 255 },
	BoonBlessing = { 115, 93, 133, 255 },
	BoonPact = { 127, 45, 45, 255 },
	BoonMelee = { 129, 90, 40, 255 },
	BoonRush = { 70, 92, 94, 255 },
	BoonRanged = { 116, 54, 38, 255 },
	BoonPatchCommon = { 255, 255, 255, 255 },
	BoonPatchRare = { 0, 138, 255, 255 },
	BoonPatchEpic = { 157, 18, 255, 255 },
	BoonPatchDuo = {210, 255, 97, 255},
	BoonPatchHeroic = { 248, 96, 89, 255 },
	BoonPatchLegendary = { 255, 144, 0, 255 },
	BoonPatchPerfect = {210, 255, 97, 255},
	BoonPatchElemental = {255, 75, 255, 255},
	BoonPatchLegacy = {81, 219, 219, 255},
	RallyHealth = { 255, 0, 0, 255 },
	ContextActionLabel = { 191, 191, 191, 255 },
	CostAffordable = { 240, 240, 240, 255 },
	CostUnffordableShop = { 165, 55, 57, 255 },
	CostAffordableShop = { 224, 188, 66, 255 },
	CostCantPurchase = { 255, 153, 0, 255 },
	CostUnaffordable = { 200, 20, 20, 255 },
	CostUnaffordableLight = { 200, 120, 120, 255 },
	CostUnaffordableDark = { 185, 84, 148, 255 },
	TradeAffordable = { 255, 255, 255, 255 },
	TradeUnaffordable = { 200, 20, 20, 255 },
	ArmorFlashGold = { 255, 255, 255, 255 },
	LocationTextGold = { 255, 153, 0, 255 },
	HealthBuffer = { 255, 255, 0, 255 },
	HealthFalloff = { 255, 255, 255, 255 },
	HealthScorch = { 255, 188, 69, 255 },
	HitShield = { 96, 230, 255, 255 },
	CurseHealth = { 134, 64, 255, 255 },
	CurseHealthBuffer = { 245, 86, 255, 255 },
	CurseHitShield = { 183, 107, 255, 255 },
	HealthBufferFalloff = { 255, 0, 0, 255 },
	CurseFalloff = { 255, 255, 255, 255 },
	CharmHealth = { 255, 193, 232, 255 },
	ShrineAttribute = { 255, 80, 60, 255 },
	ShrineAttributeLocked = { 160, 160, 160, 255 },
	ZeusDamageLight = { 255, 250, 165, 255 },
	ZeusDamage = { 255, 243, 45, 255 },
	AthenaDamageLight = { 246, 197, 25, 255 },
	AthenaDamage = { 111, 118, 255, 255 },
	ApolloDamageLight = { 246, 197, 25, 255 },
	ApolloDamage = { 111, 118, 255, 255 },
	AphroditeDamageLight = { 254, 179, 255, 255 },
	AphroditeDamage = { 255, 126, 241, 255 },
	AresDamageLight = { 180, 30, 0, 255 },
	AresDamage = { 0,0,0, 255 },
	DionysusDamageLight = { 203, 135, 255, 255 },
	DionysusDamage = { 129, 82, 200, 255 },
	PoseidonDamageLight = { 0, 216, 255, 255 },
	PoseidonDamage = { 0, 138, 255, 255 },
	DemeterDamageLight = { 215, 213, 246, 255 },
	DemeterDamage = { 111, 120, 189, 255 },
	ArtemisDamageLight = { 199, 255, 27, 255 },
	ArtemisDamage = { 111, 209, 45, 255 },
	HeraDamageLight = { 46, 223, 104, 255 },
	HeraDamage = { 70, 177, 240, 255 },
	HestiaDamageLight = { 250, 182, 97, 255 },
	HestiaDamage = { 245, 167, 66, 255 },
	HephaestusDamageLight = { 255, 229, 158, 255 },
	HephaestusDamage = { 255, 200, 40, 255 },	
	WallSlamDamageLight = { 200, 200, 200, 255 },
	WallSlamDamage = { 30, 30, 30, 255 },
	VitalStats = { 255, 207, 76, 255 },
	UpgradePreview = { 0, 216, 255, 255 },
	ChronosVoice = { 242, 179, 66, 255 },
	HecateVoice = { 153, 90, 200, 255 },
	DoraVoice = { 56, 255, 56, 255 },
	OdysseusVoice = { 130, 178, 180, 255 },
	NemesisVoice = { 45, 108, 255, 255 },
	MorosVoice = { 148, 108, 32, 255 },
	ErisVoice = { 230, 150, 182, 255 },
	SeleneVoice = { 100, 149, 237, 255 },
	PolyphemusVoice = { 128, 158, 107, 255 },
	HadesVoice = { 242, 79, 66, 255 },
	NarratorVoice = { 178, 178, 178, 255 },
	ZeusVoice = { 255, 248, 187, 255 },
	PoseidonVoice = { 50, 255, 190, 255 },
	AthenaVoice = { 255, 216, 60, 255 },
	AresVoice = { 207, 0, 0, 255 },
	AphroditeVoice = { 255, 90, 172, 255 },
	ArtemisVoice = { 15, 255, 9, 255 },
	HermesVoice = { 255, 221, 43, 255 },
	ArachneVoice = { 238, 130, 238, 255 },
	NarcissusVoice = { 165, 255, 101, 255 },
	EchoVoice = { 212, 212, 212, 255 },
	MedeaVoice = { 65, 200, 22, 255 },
	CirceVoice = { 255, 245, 155, 255 },
	IcarusVoice = { 233, 243, 116, 255 },
	HeraclesVoice = { 255, 125, 25, 255 },
	ScyllaVoice = { 56, 255, 108, 255 },
	DemeterVoice = { 188, 240, 255, 255 },
	ApolloVoice = { 255, 255, 222, 255 },
	HeraVoice = { 255, 248, 187, 255 },
	HestiaVoice = { 255, 255, 187, 255 },
	HephaestusVoice = { 255, 200, 40, 255 },
	HypnosVoice = { 112, 128, 212, 255 },
	SkellyVoice = { 222, 211, 137, 255 },
	ChaosVoice = { 188, 184, 255, 255 },
	CharonVoice = { 117, 120, 133, 255 },
	-- do you believe in Bouldy?
	BouldyVoice = { 109, 185, 116, 255 },
	BoonInfoUnacquired = {159, 159, 159, 255},
	BoonInfoAcquired = { 138, 238, 83, 255 },
	MEMBlue = { 51, 222, 160, 255 },
	MEMDark = { 47, 79, 79, 255 },
	MEMGreen = { 207, 255, 37, 255 },
	TalentInactive = { 30, 30, 30, 255 },
	TalentPriorSelected = { 47, 79, 79, 255 },
	ChronosSand = { 134, 115, 64, 255 },
}

function Color.Lerp( color1, color2, amount )
	local outColor = {
		color1[1] * (1 - amount) + color2[1] * amount,
		color1[2] * (1 - amount) + color2[2] * amount,
		color1[3] * (1 - amount) + color2[3] * amount,
		color1[4] * (1 - amount) + color2[4] * amount,
	}
	return outColor
end

function Color.ToString( color )
	return "{"..color[1]..","..color[2]..","..color[3]..","..color[4].."}"
	end