GameData = GameData or {}

RoomData = RoomData or {}
RoomSetData = RoomSetData or {}

TraitData = TraitData or {}
TraitSetData = TraitSetData or {}

EnemyData = EnemyData or {}
UnitSetData = UnitSetData or {}
VariantSetData = VariantSetData or {}
WeaponDataEnemies = WeaponDataEnemies or {}

LootData = LootData or {}
FieldLootData = FieldLootData or {}
LootSetData = LootSetData or {}
BountyData = BountyData or {}

ScreenData = ScreenData or {}
ScreenData.Shrine = ScreenData.Shrine or {}
ScreenData.Shrine.BountyOrder = ScreenData.Shrine.BountyOrder or {}
ScreenData.MailboxScreen = ScreenData.MailboxScreen or 
{
	CharonPointsRequirements =
	{
		{
			PathTrue = { "GameState", "UseRecord", "CharonPointsDrop" },
		},
		NamedRequirements = { "MailboxUnlocked" },
	},
}

Keywords = Keywords or {}

local fullGame = (GetConfigOptionValue({ Name = "DemoMode" }) == false)


Import "RoomSets.lua"
Import "WeaponSets.lua"
Import "EncounterSets.lua"
Import "EnemySets.lua"

Import "RewardData.lua"
Import "EnemyAILogic.lua"

Import "UIData.lua"
Import "TraitTrayData.lua"
Import "HUDData.lua"
Import "NarrativeData.lua"
Import "AudioData.lua"
Import "MusicData.lua"
Import "KeywordData.lua"
Import "EffectData.lua"
Import "WeaponData.lua"
Import "WeaponDataEnemies.lua"

Import "EnemyData.lua"
Import "EnemyData_Traps.lua"
Import "EnemyData_Mage.lua"
Import "EnemyData_Guard.lua"
Import "EnemyData_Brawler.lua"
Import "EnemyData_Radiator.lua"
Import "EnemyData_Screamer.lua"
Import "EnemyData_Treant.lua"
Import "EnemyData_SiegeVine.lua"
Import "EnemyData_FogEmitter.lua"
Import "EnemyData_Wisp.lua"
Import "EnemyData_Hecate.lua"
Import "EnemyData_LightRanged.lua"

if fullGame then
	Import "EnemyData_FishmanMelee.lua"
	Import "EnemyData_FishmanRanged.lua"
	Import "EnemyData_FishSwarmer.lua"
	Import "EnemyData_Turtle.lua"
	Import "EnemyData_WaterUnit.lua"
	Import "EnemyData_DespairElemental.lua"
	Import "EnemyData_Eyeball.lua"
	Import "EnemyData_Vampire.lua"
	Import "EnemyData_Lovesick.lua"
	Import "EnemyData_Lamia.lua"
	Import "EnemyData_Mourner.lua"
	Import "EnemyData_LycanSwarmer.lua"
	Import "EnemyData_Lycanthrope.lua"
	Import "EnemyData_Carrion.lua"
	Import "EnemyData_BrokenHearted.lua"
	Import "EnemyData_CorruptedShadeSmall.lua"
	Import "EnemyData_CorruptedShadeMedium.lua"
	Import "EnemyData_CorruptedShadeLarge.lua"
	Import "EnemyData_Crawler.lua"
	Import "EnemyData_ZombieSpawner.lua"
	Import "EnemyData_ZombieHeavyRanged.lua"
	Import "EnemyData_ZombieAssassin.lua"
	Import "EnemyData_Zombie.lua"
	Import "EnemyData_Mudman.lua"
	Import "EnemyData_Harpy.lua"
	Import "EnemyData_Eris.lua"
	Import "EnemyData_Medea.lua"
	Import "EnemyData_Heracles.lua"
	Import "EnemyData_Prometheus.lua"
	Import "EnemyData_TyphonHead.lua"
	Import "EnemyData_TyphonHeadAdd.lua"
	Import "EnemyData_TyphonArm.lua"
	Import "EnemyData_TyphonTail.lua"
	Import "EnemyData_TyphonEye.lua"
	Import "EnemyData_Eagle.lua"
	Import "EnemyData_Mati.lua"
	Import "EnemyData_EarthElemental.lua"
	Import "EnemyData_Stickler.lua"
	Import "EnemyData_Swab.lua"
	Import "EnemyData_Captain.lua"
	Import "EnemyData_Scimiterror.lua"
	Import "EnemyData_Drunk.lua"
	Import "EnemyData_WaterElemental.lua"
	Import "EnemyData_Talos.lua"
	Import "EnemyData_SentryBot.lua"
	Import "EnemyData_AutomatonBeamer.lua"
	Import "EnemyData_AutomatonEnforcer.lua"
	Import "EnemyData_Dragon.lua"
	Import "EnemyData_DragonBurrower.lua"
	Import "EnemyData_InfestedCerberus.lua"
	Import "EnemyData_Chronos.lua"
	Import "EnemyData_Zagreus.lua"
	Import "EnemyData_BloodlessNaked.lua"
	Import "EnemyData_BloodlessGrenadier.lua"
	Import "EnemyData_Scylla.lua"
	Import "EnemyData_SirenDrummer.lua"
	Import "EnemyData_SirenKeytarist.lua"
	Import "EnemyData_Polyphemus.lua"
	Import "EnemyData_Sheep.lua"
	Import "EnemyData_Charybdis.lua"
	Import "EnemyData_SatyrCrossbow.lua"
	Import "EnemyData_Boar.lua"
	Import "EnemyData_ClockworkHeavyMelee.lua"
	Import "EnemyData_Wringer.lua"
	Import "EnemyData_GoldElemental.lua"
	Import "EnemyData_TimeElemental.lua"
	Import "EnemyData_SatyrLancer.lua"
	Import "EnemyData_SatyrSapper.lua"
	Import "EnemyData_SatyrRatCatcher.lua"
	Import "EnemyData_SatyrCultist.lua"
	Import "EnemyData_Swarmer.lua"
	Import "EnemyData_Simple.lua"
	Import "EnemyData_Stalker.lua"
	Import "EnemyData_Brute.lua"
	Import "EnemyData_Jellyfish.lua"
	Import "EnemyData_Octofish.lua"
	Import "EnemyData_Pig.lua"
end

Import "NPCData.lua"
Import "AllyData.lua"
Import "FamiliarData.lua"

Import "EncounterData.lua"

if fullGame then
	Import "EncounterData_Arachne.lua"
	Import "EncounterData_Athena.lua"
	Import "EncounterData_Artemis.lua"
	Import "EncounterData_Boss.lua"
	Import "EncounterData_Challenge.lua"
	Import "EncounterData_Devotion.lua"
	Import "EncounterData_Generated.lua"
	Import "EncounterData_Heracles.lua"
	Import "EncounterData_Icarus.lua"
	Import "EncounterData_Intro.lua"
	Import "EncounterData_MiniBoss.lua"
	Import "EncounterData_Nemesis.lua"
	Import "EncounterData_Opening.lua"
	Import "EncounterData_Story.lua"
	Import "EncounterData_TimeChallenge.lua"
	if _isdebug() then
		Import "EncounterData_Test.lua"
	end
end

Import "EncounterData_Unique.lua"

Import "ManaData.lua"
Import "RoomData.lua"
Import "RoomDataF.lua"

if fullGame then
	Import "RoomDataAnomaly.lua"
	Import "RoomDataC.lua"
	Import "RoomDataChaos.lua"
	Import "RoomDataG.lua"
	Import "RoomDataH.lua"
	Import "RoomDataI.lua"
	Import "RoomDataN.lua"
	Import "RoomDataO.lua"
	Import "RoomDataP.lua"
	Import "RoomDataQ.lua"
	if _isdebug() then
		Import "RoomDataTest.lua"
	end
end

Import "HeroData.lua"
Import "LootData.lua"
Import "LootData_Chaos.lua"
Import "LootData_Zeus.lua"
Import "LootData_Poseidon.lua"
Import "LootData_Apollo.lua"
Import "LootData_Demeter.lua"
Import "LootData_Aphrodite.lua"
Import "LootData_Hestia.lua"
Import "LootData_Hephaestus.lua"
Import "LootData_Ares.lua"
Import "LootData_Selene.lua"
if fullGame then
	Import "LootData_Hera.lua"
	Import "LootData_Hermes.lua"
end

Import "MetaUpgradeData.lua"
Import "TraitData.lua"
Import "TraitData_Staff.lua"
Import "TraitData_Dagger.lua"
Import "TraitData_Axe.lua"
Import "TraitData_Suit.lua"
Import "TraitData_Torch.lua"
Import "TraitData_Lob.lua"
Import "TraitData_Arachne.lua"
Import "TraitData_Ares.lua"
Import "TraitData_Artemis.lua"
Import "TraitData_Aphrodite.lua"
Import "TraitData_Apollo.lua"
Import "TraitData_Demeter.lua"
Import "TraitData_Dionysus.lua"
Import "TraitData_Hephaestus.lua"
Import "TraitData_Hestia.lua"
Import "TraitData_Poseidon.lua"
Import "TraitData_Zeus.lua"
Import "TraitData_Spell.lua"
Import "TraitData_Keepsake.lua"
Import "TraitData_Store.lua"
Import "TraitData_MetaUpgrade.lua"
Import "TraitData_Duo.lua"
Import "TraitData_Elementals.lua"

if fullGame then
	Import "TraitData_Hades.lua"
	Import "TraitData_Narcissus.lua"
	Import "TraitData_Echo.lua"
	Import "TraitData_Circe.lua"
	Import "TraitData_Medea.lua"
	Import "TraitData_Icarus.lua"
	Import "TraitData_Hera.lua"
	Import "TraitData_Athena.lua"
	Import "TraitData_Hermes.lua"
	Import "TraitData_Aspect.lua"
	Import "TraitData_Essence.lua"
	Import "TraitData_Talent.lua"
	Import "TraitData_Chaos.lua"
end
Import "BoonInfoData.lua"
Import "UpgradeChoiceData.lua"
Import "KeepsakeData.lua"
Import "TradeData.lua"
Import "SpellScreenData.lua"
Import "TalentScreenData.lua"
Import "StoreData.lua"
Import "SurfaceShopData.lua"
Import "SellTraitData.lua"
Import "TraitLogic.lua"
Import "FamiliarLogic.lua"

Import "WeaponData_Dagger.lua"
Import "WeaponData_Staff.lua"
Import "WeaponData_Axe.lua"
Import "WeaponData_Lob.lua"
Import "WeaponData_Torch.lua"
Import "WeaponData_Suit.lua"

Import "WeaponData_Traps.lua"

Import "WeaponData_FogEmitter.lua"
Import "WeaponData_Guard.lua"
Import "WeaponData_Hecate.lua"
Import "WeaponData_LightRanged.lua"
Import "WeaponData_Mage.lua"	
Import "WeaponData_Radiator.lua"
Import "WeaponData_Screamer.lua"
Import "WeaponData_SiegeVines.lua"
Import "WeaponData_Treant.lua"

if fullGame then
	Import "WeaponData_Automaton.lua"
	Import "WeaponData_Talos.lua"
	Import "WeaponData_Dragon.lua"
	Import "WeaponData_Bloodless.lua"
	Import "WeaponData_BrokenHearted.lua"
	Import "WeaponData_Carrion.lua"
	Import "WeaponData_Charybdis.lua"
	Import "WeaponData_Chronos.lua"
	Import "WeaponData_Corrupted.lua"
	Import "WeaponData_Crawler.lua"
	Import "WeaponData_Zagreus.lua"
	Import "WeaponData_Devotion.lua"
	Import "WeaponData_Drunk.lua"
	Import "WeaponData_Elemental.lua"
	Import "WeaponData_Eris.lua"
	Import "WeaponData_Medea.lua"
	Import "WeaponData_Fishman.lua"
	Import "WeaponData_FishSwarmer.lua"
	Import "WeaponData_Harpy.lua"
	Import "WeaponData_InfestedCerberus.lua"
	Import "WeaponData_Lamia.lua"
	Import "WeaponData_Lovesick.lua"
	Import "WeaponData_Lycan.lua"
	Import "WeaponData_Mourner.lua"
	Import "WeaponData_Mudman.lua"
	Import "WeaponData_Polyphemus.lua"
	Import "WeaponData_Satyr.lua"
	Import "WeaponData_Scimiterror.lua"
	Import "WeaponData_Scylla.lua"
	Import "WeaponData_Sheep.lua"
	Import "WeaponData_Siren.lua"
	Import "WeaponData_Stickler.lua"
	Import "WeaponData_Swab.lua"
	Import "WeaponData_Swarmer.lua"
	Import "WeaponData_Thug.lua"
	Import "WeaponData_Turtle.lua"
	Import "WeaponData_Vampire.lua"
	Import "WeaponData_WaterElemental.lua"
	Import "WeaponData_WaterUnit.lua"
	Import "WeaponData_Zombie.lua"
	Import "WeaponData_Prometheus.lua"
	Import "WeaponData_Eagle.lua"
end

Import "WeaponDataAllies.lua"
Import "ProjectileData.lua"
if fullGame then
	Import "ProjectileData_EnemyF.lua"
	Import "ProjectileData_EnemyG.lua"
	Import "ProjectileData_EnemyH.lua"
	Import "ProjectileData_EnemyI.lua"
	Import "ProjectileData_EnemyN.lua"
	Import "ProjectileData_EnemyO.lua"
	Import "ProjectileData_EnemyP.lua"
	Import "ProjectileData_EnemyQ.lua"
	Import "ProjectileData_EnemyB.lua"
	Import "ProjectileData_Familiar.lua"
	Import "ProjectileData_Gods.lua"
	Import "ProjectileData_Melinoe.lua"
	Import "ProjectileData_NPC.lua"
	Import "ProjectileData_Traps.lua"
end
Import "ConsumableData.lua"
Import "WorldUpgradeData.lua"
Import "RunClearData.lua"
Import "BadgeData.lua"
Import "ResourceData.lua"
Import "MarketData.lua"
Import "MarketPromptScreenData.lua"
if fullGame then
	Import "MailboxData.lua"
end
Import "GhostAdminData.lua"
if fullGame then
	Import "GhostAdminData_Items.lua"
end
if fullGame then
	Import "AchievementData.lua"
end
Import "CosmeticsData.lua"
Import "CostumeData.lua"
Import "WeaponShopData.lua"
Import "FamiliarShopData.lua"
Import "FamiliarCostumeData.lua"
Import "WeaponUpgradeData.lua"
Import "SpellData.lua"
Import "ObstacleData.lua"
if fullGame then
	Import "ObstacleDataG.lua"
	Import "ObstacleDataH.lua"
	Import "ObstacleDataI.lua"
	Import "ObstacleDataN.lua"
	Import "ObstacleDataO.lua"
	Import "ObstacleDataP.lua"
	Import "ObstacleDataQ.lua"
end
Import "NPCData_Hecate.lua"
Import "NPCData_Odysseus.lua"
Import "NPCData_Dionysus.lua"
Import "NPCData_Athena.lua"
Import "NPCData_Dora.lua"
Import "NPCData_Nemesis.lua"
Import "NPCData_Moros.lua"
Import "NPCData_Hypnos.lua"
Import "NPCData_Charon.lua"
Import "NPCData_Arachne.lua"
Import "NPCData_Hades.lua"
Import "NPCData_Selene.lua"
Import "NPCData_Artemis.lua"
Import "NPCData_Skelly.lua"
		
if fullGame then
	Import "NPCData_Eris.lua";
	Import "NPCData_Chronos.lua"
	Import "NPCData_Icarus.lua"
	Import "NPCData_Narcissus.lua"
	Import "NPCData_Echo.lua"
	Import "NPCData_Medea.lua"
	Import "NPCData_Circe.lua"
	Import "NPCData_Heracles.lua"
	Import "NPCData_Hermes.lua"
end

Import "UpgradeChoiceLogic.lua"
Import "TradeLogic.lua"
Import "SpellScreenLogic.lua"
Import "TalentScreenLogic.lua"
Import "MetaUpgrades.lua"
Import "MetaUpgradeData.lua"
Import "MetaUpgradeLogic.lua"
Import "MetaUpgradeCardScreenLogic.lua"
Import "MetaUpgradeCardScreenData.lua"
Import "MetaUpgradeCardUpgradeScreenLogic.lua"
Import "MetaUpgradeCardUpgradeScreenData.lua"
Import "MetaUpgradeCardPromptScreenLogic.lua"
Import "MetaUpgradeCardPromptScreenData.lua"
if fullGame then
	Import "ElementalPromptScreenLogic.lua"
	Import "ElementalPromptScreenData.lua"
end
Import "ObjectiveData.lua"

Import "HarvestData.lua"
Import "GardenData.lua"
Import "DeathLoopData.lua"
Import "GamePhaseData.lua"
Import "BiomeStateData.lua"
Import "QuestData.lua"
if fullGame then
	Import "BountyData.lua"
	Import "ShrineData.lua"
end
Import "CodexData.lua"
Import "GameStatsData.lua"
Import "RunHistoryData.lua"
Import "MusicPlayerData.lua"
Import "CreditsData.lua"
Import "StoryResetData.lua"

Import "GiftLogic.lua"
Import "GiftPresentation.lua"
Import "EventLogic.lua"
Import "EncounterLogic.lua"
Import "InteractLogic.lua"
Import "InteractPresentation.lua"
Import "ObjectiveLogic.lua"
Import "AmmoLogic.lua"
Import "PowersLogic.lua"
Import "WeaponLogic.lua"
Import "EffectLogic.lua"
Import "ManaLogic.lua"
Import "HealthLogic.lua"
Import "UpgradeLogic.lua"
Import "RequirementsLogic.lua"
Import "StoryResetLogic.lua"

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalTextLines = GlobalTextLines or {}

function SetupRunData( args )

	args = args or {}	
	TextLinesCache = {}

	local enableConsoleMenus = GetConfigOptionValue({ Name = "EnableConsoleMenus" })

	for roomName, roomData in pairs( RoomData ) do
		roomData.Name = roomName
		ProcessDataInheritance( roomData, RoomData )
		roomData.UseText = roomData.UseText or "UseLeaveRoom"
		if roomData.LegalEncounters ~= nil then
			roomData.LegalEncountersDictionary = {}
			for k, encounterName in pairs( roomData.LegalEncounters ) do
				roomData.LegalEncountersDictionary[encounterName] = true
			end
		end
		if roomData.IllegalEncounters ~= nil then
			roomData.IllegalEncountersDictionary = {}
			for k, encounterName in pairs( room.IllegalEncounters ) do
				roomData.IllegalEncountersDictionary[encounterName] = true
			end
		end
		if enableConsoleMenus and roomData.ZoomFractionSwitch ~= nil then
			roomData.ZoomFraction = roomData.ZoomFractionSwitch
		end
	end
	for roomSetName, roomSetData in pairs( RoomSetData ) do
		for roomName, roomData in pairs( roomSetData ) do
			roomData.RoomSetName = roomSetName
		end
	end

	for hubRoomName, hubRoomData in pairs( HubRoomData ) do
		hubRoomData.Name = hubRoomName
		ProcessDataInheritance( hubRoomData, HubRoomData )
	end

	for encounterName, encounterData in pairs( EncounterData ) do
		encounterData.Name = encounterName
		ProcessDataInheritance( encounterData, EncounterData )
		if encounterData.EncounterType == nil then
			encounterData.EncounterType = "Default"
		end
	end

	ProcessDataStore( NarrativeData )

	for enemyName, enemyData in pairs( EnemyData ) do
		enemyData.Name = enemyName
		ProcessDataInheritance( enemyData, EnemyData )
		if enemyData.OutgoingDamageModifiers then
			for i, modifierData in ipairs( enemyData.OutgoingDamageModifiers ) do
				if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
					modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
				end
			end
		end
		if enemyData.OutgoingCritModifiers then
			for i, modifierData in ipairs( enemyData.OutgoingCritModifiers ) do
				if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
					modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
				end
			end
		end
		if enemyData.IncomingDamageModifiers then
			for i, modifierData in ipairs( enemyData.IncomingDamageModifiers ) do
				if modifierData.ValidWeapons then
					modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
				end
			end
		end

		ProcessTextLines( enemyData, enemyData.GiftTextLineSets, "GiftTextLinePriorities", args )
		ProcessTextLines( enemyData, enemyData.InteractTextLineSets, "InteractTextLinePriorities", { DefaultStatusAnimation = StatusAnimations.WantsToTalk, IgnoreValidation = args.IgnoreValidation } )
		ProcessTextLines( enemyData, enemyData.BossIntroTextLineSets, "BossIntroTextLinePriorities", args )
		ProcessTextLines( enemyData, enemyData.BossPhaseChangeTextLineSets , "BossPhaseChangeTextLinePriorities", args )
		ProcessTextLines( enemyData, enemyData.BossOutroTextLineSets, "BossOutroTextLinePriorities", args )
		ProcessTextLines( enemyData, enemyData.DeathPresentationTextLineSets, nil, args )

		if fullGame and not IsEmpty( enemyData.InteractTextLineSets ) then
			DebugAssert({ Condition = Contains( NarrativeData.ConversationOrder, enemyData.Name ), Text = enemyData.Name.." is not listed in NarrativeData.ConversationOrder" })
		end
		if enemyData.TreatAsGodLootByShops and not IsEmpty( enemyData.Traits ) then
			FieldLootData[enemyData.Name] = 
				{ 
					Name = enemyData.Name,
					TraitIndex = ToLookup(enemyData.Traits),
					TreatAsGodLootByShops = enemyData.TreatAsGodLootByShops,
					IgnoreRestrictBoonChoices = enemyData.IgnoreRestrictBoonChoices,
					ExcludeFromLastRunBoon = enemyData.ExcludeFromLastRunBoon,
					GodLoot = enemyData.GodLoot,
				}
		end

		if enemyData.Traits ~= nil then
			ScreenData.BoonInfo.TraitDictionary[enemyData.Name] = {}
			for i, traitName in pairs( enemyData.Traits ) do
				ScreenData.BoonInfo.TraitDictionary[enemyData.Name][traitName] = true
			end
			ScreenData.BoonInfo.TraitSortOrder[enemyData.Name] = {}
			ScreenData.BoonInfo.TraitSortOrder[enemyData.Name] = ConcatTableValuesIPairs( ScreenData.BoonInfo.TraitSortOrder[enemyData.Name], enemyData.Traits )
		end

	end

	for variantName, variantData in pairs( NPCVariantData ) do
		--variantData.Name = variantName
		--DebugPrint({ Text = "variantName = "..variantName })
		ProcessDataInheritance( variantData, NPCVariantData )
		ProcessTextLines( variantData, variantData.InteractTextLineSets, variantData.InteractTextLinePriorities, { DefaultStatusAnimation = StatusAnimations.WantsToTalk, IgnoreValidation = args.IgnoreValidation } )
	end
	
	PropertyOrderingValuesLookup = {}
	for i, value in pairs( PropertyOrderingValues ) do
		PropertyOrderingValuesLookup[value] = i
	end

	for traitName, traitData in pairs( TraitData ) do
		traitData.Name = traitName
		ProcessDataInheritance( traitData, TraitData )
		local autoExpandProperties = 
		{
			WeaponProperties = "WeaponProperty",
			ProjectileProperties = "ProjectileProperty",
			EffectProperties = "EffectProperty",
		}

		if traitData.PropertyChanges ~= nil and not traitData.ExpandedProperties then
			local addlPropertyChanges = {}
			for k, propertyChange in pairs( traitData.PropertyChanges ) do
				for expandFromName, expandToName in pairs(autoExpandProperties) do 					
					if propertyChange[expandFromName] then
						for property, changeValue in pairs( propertyChange[expandFromName]) do
							if property ~= "ReportValues" then
								local newPropertyChange = ShallowCopyTable(propertyChange)
								for autoExpandPropertyName in pairs( autoExpandProperties ) do
									newPropertyChange[autoExpandPropertyName] = nil
								end
								newPropertyChange[expandToName] = property
								newPropertyChange.ChangeValue = changeValue
								newPropertyChange.ChangeType = "Absolute"
								if propertyChange[expandFromName].ReportValues then
									for reportKey, reportSourceName in pairs(propertyChange[expandFromName].ReportValues) do 
										if reportSourceName == property then
											newPropertyChange.ReportValues = {}
											newPropertyChange.ReportValues[reportKey] = "ChangeValue"
										end
									end
								end
								table.insert(addlPropertyChanges, newPropertyChange )
							end
						end
					end
				end
				if propertyChange.SpeedPropertyChanges then
					local weaponNames = ShallowCopyTable( propertyChange.WeaponNames )
					if weaponNames == nil then
						weaponNames = { propertyChange.WeaponName }
					end
					for q, weaponName in pairs(weaponNames) do
					
						local newPropertyChanges = DeepCopyTable(WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
						if WeaponData[weaponName] and WeaponData[weaponName].SpeedPropertyChanges then
							newPropertyChanges = DeepCopyTable( WeaponData[weaponName].SpeedPropertyChanges)
						end
						for s, newPropertyChange in pairs(newPropertyChanges) do
							newPropertyChange = MergeTables( newPropertyChange, propertyChange )
							newPropertyChange.WeaponNames = nil
							newPropertyChange.WeaponName = weaponName
							newPropertyChange.ChangeType = "Multiply"
							if newPropertyChange.InvertSource then
								if newPropertyChange.ChangeValue then
									newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
								end
								if newPropertyChange.BaseValue then
									newPropertyChange.BaseValue = 1 / newPropertyChange.BaseValue
								end
							end
							newPropertyChange.SpeedPropertyChanges = nil
							table.insert(addlPropertyChanges, newPropertyChange )
						end
					end
				end
			end
			if not IsEmpty(addlPropertyChanges) then
				ConcatTableValues( traitData.PropertyChanges, addlPropertyChanges )
				traitData.ExpandedProperties = true
			end
		end
		if not traitData.ExcludeLinked then
			if traitData.DamageOnFireWeapons and not traitData.DamageOnFireWeapons.ExcludeLinked then
				traitData.DamageOnFireWeapons.WeaponNames = AddLinkedWeapons( traitData.DamageOnFireWeapons.WeaponNames )
			end
			if traitData.AddOutgoingLifestealModifiers then
				if traitData.AddOutgoingLifestealModifiers.ValidWeapons then
					if not traitData.AddOutgoingLifestealModifiers.ExcludeLinked then
						traitData.AddOutgoingLifestealModifiers.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingLifestealModifiers.ValidWeapons )
					end
					traitData.AddOutgoingLifestealModifiers.ValidWeaponsLookup = ToLookup( traitData.AddOutgoingLifestealModifiers.ValidWeapons )
				end
			end
			if traitData.DamageClamps and traitData.DamageClamps.ValidProjectiles then
				traitData.DamageClamps.ValidProjectilesLookup = ToLookup( traitData.DamageClamps.ValidProjectiles )
			end
			if traitData.AddOutgoingDamageModifiers then
				if traitData.AddOutgoingDamageModifiers.ValidWeapons then
					if not traitData.AddOutgoingDamageModifiers.ExcludeLinked then
						traitData.AddOutgoingDamageModifiers.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingDamageModifiers.ValidWeapons )
					end
					traitData.AddOutgoingDamageModifiers.ValidWeaponsLookup = ToLookup( traitData.AddOutgoingDamageModifiers.ValidWeapons )
				end
				if traitData.AddOutgoingDamageModifiers.ValidProjectiles then
					traitData.AddOutgoingDamageModifiers.ValidProjectilesLookup = ToLookup( traitData.AddOutgoingDamageModifiers.ValidProjectiles )
				end
				if traitData.AddOutgoingDamageModifiers.ValidEnchantments and not traitData.AddOutgoingDamageModifiers.ExcludeLinked then
					for key, weaponNames in pairs(traitData.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons ) do
						traitData.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons[key] = AddLinkedWeapons( weaponNames )
					end

					if traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons then
						traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons )
					end
				end
				if traitData.AddOutgoingDamageModifiers.EmptySlotValidData then
					for key, weaponNames in pairs(traitData.AddOutgoingDamageModifiers.EmptySlotValidData) do
						traitData.AddOutgoingDamageModifiers.EmptySlotValidData[key] = AddLinkedWeapons( weaponNames )
					end
				end
			end

			if traitData.AddOutgoingDamageModifiersArray then
				for i, data in pairs(traitData.AddOutgoingDamageModifiersArray) do
					if data.ValidWeapons then
						if not data.ExcludeLinked then
							data.ValidWeapons = AddLinkedWeapons( data.ValidWeapons )
						end
						data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
					end
					if data.ValidProjectiles then
						data.ValidProjectilesLookup = ToLookup( data.ValidProjectiles )
					end
					if data.ValidEnchantments and not data.ExcludeLinked then
						for key, weaponNames in pairs(data.ValidEnchantments.TraitDependentWeapons ) do
							data.ValidEnchantments.TraitDependentWeapons[key] = AddLinkedWeapons( weaponNames )
						end

						if data.ValidEnchantments.ValidWeapons then
							data.ValidEnchantments.ValidWeapons = AddLinkedWeapons( data.ValidEnchantments.ValidWeapons )
						end
					end
					if data.EmptySlotValidData then
						for key, weaponNames in pairs(data.EmptySlotValidData) do
							data.EmptySlotValidData[key] = AddLinkedWeapons( weaponNames )
						end
					end
				end
			end

			if traitData.AddOutgoingCritModifiers then
				if traitData.AddOutgoingCritModifiers.ValidWeapons then
					if not traitData.AddOutgoingCritModifiers.ExcludeLinked then
						traitData.AddOutgoingCritModifiers.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingCritModifiers.ValidWeapons )
					end
					traitData.AddOutgoingCritModifiers.ValidWeaponsLookup = ToLookup( traitData.AddOutgoingCritModifiers.ValidWeapons )
				end
				if traitData.AddOutgoingCritModifiers.ValidProjectiles then
					traitData.AddOutgoingCritModifiers.ValidProjectilesLookup = ToLookup( traitData.AddOutgoingCritModifiers.ValidProjectiles )
				end
			end
			if traitData.AddOutgoingDoubleDamageModifiers then
				if traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons then
					if not traitData.AddOutgoingDoubleDamageModifiers.ExcludeLinked then
						traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons )
					end
					traitData.AddOutgoingDoubleDamageModifiers.ValidWeaponsLookup = ToLookup( traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons )
				end
			end
			
			if traitData.ChargeStageModifiers then
				if traitData.ChargeStageModifiers.ValidWeapons then
					if not traitData.ChargeStageModifiers.ExcludeLinked then
						traitData.ChargeStageModifiers.ValidWeapons = AddLinkedWeapons( traitData.ChargeStageModifiers.ValidWeapons )
					end
					traitData.ChargeStageModifiers.ValidWeaponsLookup = ToLookup( traitData.ChargeStageModifiers.ValidWeapons )
				end
			end
			
			if traitData.ChargeStageModifiersArray then
				for i, data in pairs( traitData.ChargeStageModifiersArray ) do
					if data.ValidWeapons then
						if not data.ExcludeLinked then
							data.ValidWeapons = AddLinkedWeapons( data.ValidWeapons )
						end
						data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
					end
				end
			end
			
			if traitData.OnWeaponChargeFunctions then
				if traitData.OnWeaponChargeFunctions.ValidWeapons then
					if not traitData.OnWeaponChargeFunctions.ExcludeLinked then
						traitData.OnWeaponChargeFunctions.ValidWeapons = AddLinkedWeapons( traitData.OnWeaponChargeFunctions.ValidWeapons )
					end
				end
			end
			if traitData.OnWeaponFiredFunctions then
				if traitData.OnWeaponFiredFunctions.ValidWeapons then
					if not traitData.OnWeaponFiredFunctions.ExcludeLinked then
						traitData.OnWeaponFiredFunctions.ValidWeapons = AddLinkedWeapons( traitData.OnWeaponFiredFunctions.ValidWeapons )
					end
					traitData.OnWeaponFiredFunctions.ValidWeaponsLookup = ToLookup( traitData.OnWeaponFiredFunctions.ValidWeapons )
				end
			end
			if traitData.OnWeaponChargeCanceledFunctions then
				if traitData.OnWeaponChargeCanceledFunctions.ValidWeapons then
					if not traitData.OnWeaponChargeCanceledFunctions.ExcludeLinked then
						traitData.OnWeaponChargeCanceledFunctions.ValidWeapons = AddLinkedWeapons( traitData.OnWeaponChargeCanceledFunctions.ValidWeapons )
					end
				end
			end
			if traitData.OnProjectileDeathFunction then
				if traitData.OnProjectileDeathFunction.ValidWeapons then
					if not traitData.OnProjectileDeathFunction.ExcludeLinked then
						traitData.OnProjectileDeathFunction.ValidWeapons = AddLinkedWeapons( traitData.OnProjectileDeathFunction.ValidWeapons )
					end
					traitData.OnProjectileDeathFunction.ValidWeaponsLookup = ToLookup( traitData.OnProjectileDeathFunction.ValidWeapons )
				end
				if traitData.OnProjectileDeathFunction.ValidProjectiles then
					traitData.OnProjectileDeathFunction.ValidProjectilesLookup = ToLookup( traitData.OnProjectileDeathFunction.ValidProjectiles )
				end
			end
			if traitData.OnProjectileCreationFunction then
				if traitData.OnProjectileCreationFunction.ValidProjectiles then
					traitData.OnProjectileCreationFunction.ValidProjectilesLookup = ToLookup( traitData.OnProjectileCreationFunction.ValidProjectiles )
				end
			end
			if traitData.OnEnemyDamagedAction then
				if traitData.OnEnemyDamagedAction.ValidWeapons then
					if not traitData.OnEnemyDamagedAction.ExcludeLinked then
						traitData.OnEnemyDamagedAction.ValidWeapons = AddLinkedWeapons( traitData.OnEnemyDamagedAction.ValidWeapons )
					end
					traitData.OnEnemyDamagedAction.ValidWeaponsLookup = ToLookup( traitData.OnEnemyDamagedAction.ValidWeapons )
				end
				if traitData.OnEnemyDamagedAction.ValidProjectiles then
					traitData.OnEnemyDamagedAction.ValidProjectilesLookup = ToLookup( traitData.OnEnemyDamagedAction.ValidProjectiles )
				end
				if traitData.OnEnemyDamagedAction.ExcludeProjectiles then
					traitData.OnEnemyDamagedAction.ExcludeProjectilesLookup = ToLookup( traitData.OnEnemyDamagedAction.ExcludeProjectiles )
				end
				if traitData.OnEnemyDamagedAction.Args then
					if traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings then
						for traitName, weaponList in pairs ( traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings ) do
							traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings[traitName] = AddLinkedWeapons( weaponList )
						end
						traitData.OnEnemyDamagedAction.Args.TraitWeaponMappingsLookup = {}
						for traitName, weaponList in pairs ( traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings ) do
							for i, weaponName in pairs( weaponList ) do
								traitData.OnEnemyDamagedAction.Args.TraitWeaponMappingsLookup[weaponName] = traitName
							end
						end
					end
					if traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist then
						if not traitData.OnEnemyDamagedAction.Args.ExcludeLinked then
							traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist = AddLinkedWeapons( traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist )
						end
						traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelistLookup = ToLookup( traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist )
					end
					if traitData.OnEnemyDamagedAction.Args.MultihitProjectileWhitelist then
						traitData.OnEnemyDamagedAction.Args.MultihitProjectileWhitelistLookup = ToLookup( traitData.OnEnemyDamagedAction.Args.MultihitProjectileWhitelist )
					end
					if traitData.OnEnemyDamagedAction.Args.ValidProjectiles then
						traitData.OnEnemyDamagedAction.Args.ValidProjectilesLookup = ToLookup( traitData.OnEnemyDamagedAction.Args.ValidProjectiles )
					end
					if traitData.OnEnemyDamagedAction.Args.ValidEffectNames then
						traitData.OnEnemyDamagedAction.Args.ValidEffectNamesLookup = ToLookup( traitData.OnEnemyDamagedAction.Args.ValidEffectNames )
					end
				end
			end
		end
		if traitData.AddWeaponsToTraits and traitData.AddWeaponsToTraits.WeaponNames then
			if not traitData.AddWeaponsToTraits.ExcludeLinked then
				traitData.AddWeaponsToTraits.WeaponNames = AddLinkedWeapons( traitData.AddWeaponsToTraits.WeaponNames )
			end
			
			traitData.AddWeaponsToTraits.WeaponNamesLookup = ToLookup( traitData.AddWeaponsToTraits.WeaponNames )
		
		end
		if traitData.ManaCostModifiers and traitData.ManaCostModifiers.WeaponNames then	
			if not traitData.ManaCostModifiers.ExcludeLinked then
				traitData.ManaCostModifiers.WeaponNames = AddLinkedWeapons( traitData.ManaCostModifiers.WeaponNames )
			end
			
			traitData.ManaCostModifiers.WeaponNamesLookup = ToLookup( traitData.ManaCostModifiers.WeaponNames )
		end
		if traitData.WeaponSpeedMultiplier and traitData.WeaponSpeedMultiplier.WeaponNames then	
			if not traitData.WeaponSpeedMultiplier.ExcludeLinked then
				traitData.WeaponSpeedMultiplier.WeaponNames = AddLinkedWeapons( traitData.WeaponSpeedMultiplier.WeaponNames )
			end
			
			traitData.WeaponSpeedMultiplier.WeaponNamesLookup = ToLookup( traitData.WeaponSpeedMultiplier.WeaponNames )
		end
		if traitData.OnResourceMaxHealth then
			traitData.OnResourceMaxHealth.ResourceNamesLookup = ToLookup( traitData.OnResourceMaxHealth.ResourceNames )
		end
		if traitData.OnResourceMaxMana then
			traitData.OnResourceMaxMana.ResourceNamesLookup = ToLookup( traitData.OnResourceMaxMana.ResourceNames )
		end
		if traitData.WeaponDataOverride then
			for weaponName, weaponData in pairs(traitData.WeaponDataOverride) do

				if weaponData.Sounds ~= nil then
					for _, key in pairs ({"ChargeSounds", "ChargeStageSounds"}) do 
						if weaponData.Sounds[key] then
							for k, soundElement in pairs( weaponData.Sounds[key] ) do
								if soundElement.StoppedBy ~= nil then
									soundElement.StoppedByLookup = soundElement.StoppedByLookup or {}
									for k, eventName in pairs( soundElement.StoppedBy ) do
										soundElement.StoppedByLookup[eventName] = true
									end
								end
							end
						end
					end
				end
			end
		end
		local roomExitTraitKeys = 
		{
			DoorHeal = "CheckDoorHealTrait",
			DoorHealFixed = "CheckDoorHealTrait",
			DoorHealIgnorePenaltyFixed = "CheckDoorHealTrait",
			DoorFullHealThreshold = "CheckDoorHealTrait", 
			DoorHealThreshold = "CheckDoorHealTrait",
			DoorHealReserve = "CheckDoorHealTrait",
			DoorArmor = "CheckDoorArmorTrait",
			DoorCash = "CheckDoorGoldTrait",
		}

		for key, functionName in pairs(roomExitTraitKeys) do
			if traitData[key] then
				traitData.LeaveRoomFunctionName = functionName
			end
		end

		traitData.TraitOrderingValueCache = GetTraitOrderingValue( traitData )
	end

	for lootName, lootData in pairs( LootData ) do
		lootData.Name = lootName
		ProcessDataInheritance( lootData, LootData )
		if lootData.PropertyChanges ~= nil then
			for k, propertyChange in pairs( lootData.PropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end

		local traitDictionary = {}
		ScreenData.BoonInfo.TraitDictionary[lootName] = {}
		
		ScreenData.BoonInfo.TraitSortOrder[lootName] = {}
		if lootData.TraitSortOrder then 
			ScreenData.BoonInfo.TraitSortOrder[lootName] = ShallowCopyTable(lootData.TraitSortOrder)
		else
			if lootData.WeaponUpgrades then
				ScreenData.BoonInfo.TraitSortOrder[lootName] = ConcatTableValuesIPairs( ScreenData.BoonInfo.TraitSortOrder[lootName], lootData.WeaponUpgrades )
			end
			if lootData.Traits then
				ScreenData.BoonInfo.TraitSortOrder[lootName] = ConcatTableValuesIPairs( ScreenData.BoonInfo.TraitSortOrder[lootName], lootData.Traits )
			end
		end
		
		if lootData.WeaponUpgrades ~= nil then
			for i, traitName in pairs (lootData.WeaponUpgrades) do
				traitDictionary[traitName] = true
				ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.Traits ~= nil then
			for i, traitName in pairs (lootData.Traits) do
				traitDictionary[traitName] = true
				ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.PermanentTraits ~= nil then
			for i, traitName in pairs (lootData.PermanentTraits) do
				traitDictionary[traitName] = true
				ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.TemporaryTraits ~= nil then
			for i, traitName in pairs (lootData.TemporaryTraits) do
				traitDictionary[traitName] = true
				ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.Consumables ~= nil then
			for i, consumableName in pairs( lootData.Consumables ) do 
				ScreenData.BoonInfo.TraitDictionary[lootName][consumableName] = true
			end
		end
		lootData.TraitIndex = traitDictionary
		ProcessTextLines( lootData, lootData.InteractTextLineSets, "InteractTextLinePriorities", args )
		ProcessTextLines( lootData, lootData.RejectionTextLines, nil, args )
		ProcessTextLines( lootData, lootData.MakeUpTextLines, nil, args )
		ProcessTextLines( lootData, lootData.BoughtTextLines, nil, args )
		ProcessTextLines( lootData, lootData.DuoPickupTextLines, nil, args )
		ProcessTextLines( lootData, lootData.GiftTextLineSets, "GiftTextLinePriorities", args )
	end

	for traitName, linkedData in pairs( TraitRequirements ) do
		-- Process type of link
		ScreenData.BoonInfo.TraitRequirementsDictionary[traitName] = DeepCopyTable( linkedData )
		if linkedData.OneOf then
			ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "OneOf"
		elseif linkedData.TwoOf then
			ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "TwoOf"
		elseif linkedData.OneFromEachSet then
			ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "OneFromEachSet"
			if TableLength( linkedData.OneFromEachSet ) == 3 and #(linkedData.OneFromEachSet[1]) == #(linkedData.OneFromEachSet[2]) and #(linkedData.OneFromEachSet[2]) == #(linkedData.OneFromEachSet[3]) then
				ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "TwoOf"
			end
		end
	end

	for consumableName, consumableData in pairs( ConsumableData ) do
		consumableData.Name = consumableName
		ProcessDataInheritance( consumableData, ConsumableData )
		consumableData.UseText = consumableData.UseText or "UseConsumable"
		AddFormattedPercentageChangeValues(consumableData, "HealFraction")
		ProcessTextLines( consumableData, consumableData.InteractTextLineSets, "InteractTextLinePriorities", args )
		ProcessTextLines( consumableData, consumableData.GiftTextLineSets, "GiftTextLinePriorities", args )
	end

	for familiarName, familiarData in pairs( FamiliarData ) do
		ProcessSimpleExtractValues( familiarData )
	end

	ProcessDataStore( BiomeStateData.BiomeStates )
	ProcessDataStore( WorldUpgradeData )
	ProcessDataStore( WeaponShopItemData )
	ProcessDataStore( FamiliarShopItemData )
	ProcessDataStore( CostumeData )
	ProcessDataStore( AchievementData )

	ScreenData.BoonInfo.TraitSortOrder.NPC_Charon_01 = ShallowCopyTable( StoreData.RoomShop.BoonInfoSortOrder )
	ScreenData.BoonInfo.TraitDictionary.NPC_Charon_01 = {}
	for i, name in ipairs( ScreenData.BoonInfo.TraitSortOrder.NPC_Charon_01 ) do
		ScreenData.BoonInfo.TraitDictionary.NPC_Charon_01[name] = true
	end
	
	ProcessDataStore( ResourceData )
	Icons = {}
	for resourceName, resourceData in pairs( ResourceData ) do
		Icons[resourceName] = resourceData.TextIconPath or resourceData.IconPath
		Keywords[resourceName] = resourceData.TooltipId
		-- Back-compat
		--resourceData.Icon = resourceData.IconPath
		--resourceData.TextIcon = resourceData.Icon.."_Text"
	end

	for iconName, iconData in pairs( IconData ) do
		if Icons[iconName] ~= nil then
			DebugAssert({ Condition = false, Text = iconName.." already has a ResourceData entry" })
		end
		Icons[iconName] = iconData.TexturePath
	end

	ProcessDataStore( QuestData )
	ProcessDataStore( BountyData )
	ProcessDataStore( GameData.RunClearMessageData )
	ProcessDataStore( ScreenData )

	for obstacleName, obstacleData in pairs( ObstacleData ) do
		obstacleData.Name = obstacleName
		ProcessDataInheritance( obstacleData, ObstacleData )
		obstacleData.UseText = obstacleData.UseText or "InGameUI_Use"

		if obstacleData.Material == nil then
			for nameFragment, material in pairs( MaterialDefaults ) do
				if string.match( obstacleName, nameFragment ) then
					obstacleData.Material = material
					break
				end
			end
		end

	end

	for upgradeName, upgradeData in pairs( MetaUpgradeData ) do
		upgradeData.Name = upgradeName
		ProcessDataInheritance( upgradeData, MetaUpgradeData )
		upgradeData.ChangeValue = upgradeData.InactiveChangeValue
		ProcessSimpleExtractValues( upgradeData )
		if upgradeData.InactiveDisplayValue ~= nil then
			upgradeData.DisplayValue = upgradeData.InactiveDisplayValue
		end
		if upgradeData.PropertyChanges ~= nil then
			for k, propertyChange in pairs( upgradeData.PropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end

		if upgradeData.AddOutgoingDamageModifiers and upgradeData.AddOutgoingDamageModifiers.ValidWeapons and not upgradeData.AddOutgoingDamageModifiers.ExcludeLinked then
			upgradeData.AddOutgoingDamageModifiers.ValidWeapons = AddLinkedWeapons( upgradeData.AddOutgoingDamageModifiers.ValidWeapons )
		end
		AddFormattedPercentageChangeValues(upgradeData)
	end

	-- For use with Forget-Me-Not
	MetaUpgradeCostDataStore = {}
	for i, data in pairs( MetaUpgradeCostData.MetaUpgradeLevelData ) do
		data.Name = "MetaUpgradeLevelData"..i
		MetaUpgradeCostDataStore[data.Name] = MergeTables( data, ScreenData.MetaUpgradeCardLayout.PinnedMetaUpgradeLevelData )
	end

	for weaponName, weaponData in pairs( WeaponData ) do
		weaponData.Name = weaponName
		ProcessDataInheritance( weaponData, WeaponData )
		if weaponData.AIData ~= nil and ( weaponData.HitSimSlowParameters ~= nil or weaponData.HitScreenshake ~= nil ) then
			DebugAssert({ Condition = false, Text = "Weapon "..weaponData.Name.." is using ProjectileData parameters. Please migrate to the correct ProjectileData entry.", Owner = "James" })
		end
		if weaponData.Upgrades ~= nil then
			for upgradeName, upgradeData in pairs( weaponData.Upgrades ) do
				upgradeData.Name = upgradeName
				upgradeData.OwnerName = weaponName
			end
		end
		if weaponData.Sounds ~= nil then
			for key, soundData in pairs( weaponData.Sounds ) do
				for k, soundElement in pairs( soundData ) do
					if soundElement.StoppedBy ~= nil then
						soundElement.StoppedByLookup = soundElement.StoppedByLookup or {}
						for k, eventName in pairs( soundElement.StoppedBy ) do
							soundElement.StoppedByLookup[eventName] = true
						end
					end
				end
			end
		end
		if weaponData.ChargeWeaponStages then
			for i, stageData in pairs( weaponData.ChargeWeaponStages ) do
				stageData.Stage = i
			end
		end
		ObjectiveData[weaponName] = { } -- automatically generate an objective for each weapon
	end

	ProcessDataStore( ProjectileData )
	ProcessDataStore( EffectData )

	for key, effectData in pairs(EffectData) do
		if effectData.ProjectileNameBlacklist then
			effectData.ProjectileNameBlacklistLookup = ToLookup(effectData.ProjectileNameBlacklist)
		end
	end
	-- Pre-create links back as well
	for weaponName, weaponLinks in pairs( WeaponSets.LinkedWeaponUpgrades ) do
		for k, weaponLink in pairs( weaponLinks ) do
			WeaponData[weaponLink].LinkedUpgrades = weaponName
		end
	end

	WeaponSets.TimeSlowExpireProjectileExcludeProjectileNames = ConcatTableValues( WeaponSets.TimeSlowExpireProjectileExcludeProjectileNames, WeaponSets.ExpireProjectileExcludeProjectileNames )
	WeaponSets.SecondaryAndRangedWeapons = ConcatTableValues( ShallowCopyTable( WeaponSets.HeroSecondaryWeapons ), WeaponSets.HeroRangedWeapons )
	
	WeaponSetLookups = {}
	for key, weaponSet in pairs( WeaponSets ) do
		WeaponSetLookups[key] = ToLookup(weaponSet)
		WeaponSetLookups[key.."Linked"] = ShallowCopyTable( WeaponSetLookups[key] )
		WeaponSetLookups[key.."Linked"] = MergeTables( WeaponSetLookups[key.."Linked"], ToLookup( AddLinkedWeapons( weaponSet )) )
	end
	ScreenData.BoonInfo.TraitDictionary.SpellDrop = {}
	ScreenData.BoonInfo.TraitSortOrder.SpellDrop = ShallowCopyTable( SpellDisplayData.TraitSortOrder )

	for spellName, spellData in pairs( SpellData ) do
		spellData.Name = spellName
		local traitName = spellData.TraitName
		local referencedTrait = TraitData[traitName]
		if referencedTrait ~= nil then
			referencedTrait.LinkedSpellName = spellName
			ScreenData.BoonInfo.TraitDictionary.SpellDrop[traitName] = true
		end
		if spellData.Talents ~= nil then
			for talentCategoryName, talentCategory in pairs( spellData.Talents ) do
				for i, talentName in ipairs( talentCategory ) do
					ScreenData.BoonInfo.TraitDictionary.SpellDrop[talentName] = true
					if TraitData[talentName] and not TraitData[talentName].IsDuoBoon then
						TraitData[talentName].TalentCategory = talentCategoryName
					end
					TraitRequirements[talentName] = TraitRequirements[talentName] or { OneOf = {} }
					if not Contains(TraitRequirements[talentName].OneOf, spellData.TraitName) then
						table.insert(TraitRequirements[talentName].OneOf, spellData.TraitName )
					end
				end
			end
		end
		if referencedTrait and referencedTrait.PreEquipWeapons then
			for i, preEquipWeapon in pairs( referencedTrait.PreEquipWeapons ) do
				WeaponData[preEquipWeapon].LinkedTraitName = traitName
			end
		end
	end
	for talentTreeName, talentTreeData in pairs( SpellTalentData.TalentTreeStructures ) do
		talentTreeData.Name = talentTreeName 
	end

	for objectiveSetName, objectiveSetData in pairs( ObjectiveSetData ) do
		objectiveSetData.Name = objectiveSetName
		ProcessDataInheritance( objectiveSetData, ObjectiveSetData )
	end

	for objectiveName, objectiveData in pairs( ObjectiveData ) do
		objectiveData.Name = objectiveName
		ProcessDataInheritance( objectiveData, ObjectiveData )
		if objectiveData.Description == nil then
			objectiveData.Description = "Objective_"..objectiveName
		end
	end

	ProcessDataStore( GiftData )
	ProcessDataStore( GameOutroData )
	ProcessDataStore( RewardData )

	for k, textLineHolder in pairs( GlobalTextLines ) do
		if textLineHolder.InteractTextLineSets ~= nil then
			for textLinesName, textLines in pairs( textLineHolder.InteractTextLineSets ) do
				textLines.Name = textLinesName
			end
		end
	end

	for name, data in pairs( FishingData.FishValues ) do
		data.Name = name
		ProcessDataInheritance( data, FishingData.FishValues )
	end

	for name, data in pairs( BadgeData ) do
		data.Name = name
		ProcessDataInheritance( data, BadgeData )
	end

	for name, data in pairs( CreditsData.Formats ) do
		data.Name = name
		ProcessDataInheritance( data, CreditsData.Formats )
	end

	MetaUpgradeCardUpgradeData = {}

	MetaUpgradeUnequipPatchData = {}
	
	for name, data in pairs( MetaUpgradeCardData ) do
		data.Name = name
		ProcessDataInheritance( data, MetaUpgradeCardData )

		-- Generate cost tables for pinning
		if data.UpgradeResourceCost then
			for i, upgradeCost in pairs( data.UpgradeResourceCost ) do
				local upgradeName = name..i
				MetaUpgradeCardUpgradeData[upgradeName] =
				{
					Name = upgradeName,
					DisplayName = name,
					Cost = upgradeCost,
					Image = data.Image,
					IconScale = data.IconScale,
				}
			end
		end

		if data.Cost and data.Cost > 0 then
			MetaUpgradeUnequipPatchData[data.Cost] = MetaUpgradeUnequipPatchData[data.Cost] or {}
			table.insert( MetaUpgradeUnequipPatchData[data.Cost], data.Name )
		end
	end

	ResetKeywords()

	if verboseLogging then
		ValidateOrderData( QuestData, QuestOrderData )
		ValidatePriorityData( GameOutroData, GameOutroPriorities )
		ValidatePriorityData( GameData.RunClearMessageData, ScreenData.RunClear.MessagePriorities )
		ValidateGlobalFormats()
	end

end

function ValidateGlobalFormats()
	for name, lines in pairs( GlobalVoiceLines ) do
		ValidateLinesFormats( lines, name )
	end
	for name, lines in pairs( HeroVoiceLines ) do
		ValidateLinesFormats( lines, name )
	end
end

function ValidateLinesFormats( line, name )
	if line.Text ~= nil then
		local startIndex = 1
		while startIndex ~= nil do
			local formatStart = string.find( line.Text, "{#", startIndex )
			if formatStart ~= nil then
				local formatEnd = string.find( line.Text, "}", formatStart )
				local formatName = string.sub( line.Text, formatStart + 2, formatEnd - 1 )
				if TextFormats[formatName] == nil and formatName ~= "Prev" then
					DebugAssert({ Condition = false, Text = "Format {#"..formatName.."} does not exist in "..tostring(name) })
				end
				startIndex = string.find( line.Text, "{#", formatEnd )
			else
				startIndex = nil
			end
		end
	end
	for subLineIndex, subLine in ipairs( line ) do
		ValidateLinesFormats( subLine, name )
	end
end

function ResetKeywords()
	for k, keyword in pairs( KeywordList ) do
		Keywords[keyword] = keyword
	end
end

function AddLinkedWeapons( weaponList )
	if weaponList == nil then
		return
	end
	local output = {}
	for i, weaponName in pairs( weaponList ) do
		output[weaponName] = true
		if WeaponSets.LinkedWeaponUpgrades[weaponName] ~= nil then
			for s, linkedWeaponName in pairs( WeaponSets.LinkedWeaponUpgrades[weaponName] ) do
				output[linkedWeaponName] = true
			end
		end
	end
	return GetAllKeys( output )
end

function AddFormattedPercentageChangeValues(table, key)
	if key == nil then
		key = "ChangeValue"
	end
	if table == nil or table[key] == nil or type(table[key]) ~= "number" then
		return
	end
	table[key.."Percent"] = round( table[key] * 100 )
	table[key.."PercentDelta"] = round((table[key] - 1) * 100)
	table[key.."NegativePercentDelta"] = -1 * round((table[key] - 1) * 100)
end

local inheritanceIgnores =
{
	"DebugOnly",
}

function ProcessDataStore( dataStore )
	if dataStore == nil then
		return
	end
	for name, data in pairs( dataStore ) do
		data.Name = name
		ProcessDataInheritance( data, dataStore )
		ProcessSimpleExtractValues( data )		
	end
end

function ProcessSimpleExtractValues( data )
	if data.SimpleExtractValues ~= nil then
		--DebugPrint({ Text = "data.Name = "..data.Name })
		for i, extractData in ipairs( data.SimpleExtractValues ) do
			local originalValue = data[extractData.Property]
			local newValue = originalValue
			if extractData.Multiply ~= nil then
				newValue = newValue * extractData.Multiply
			end
			if extractData.Add ~= nil then
				newValue = newValue + extractData.Add
			end
			if extractData.NegativePercentDelta ~= nil then
				newValue = 100 - newValue * 100 
			end
			if extractData.UseTimeString then
				newValue = GetTimerString( newValue, 0 )
			end
			--DebugPrint({ Text = "newValue = "..newValue })
			data[extractData.NewProperty] = newValue
		end
	end
end

function ProcessDataInheritance( data, dataStore )

	if data.InheritFrom == nil then
		return
	end

	local originalValues = {}
	for k, ignoreKey in pairs( inheritanceIgnores ) do
		originalValues[ignoreKey] = data[ignoreKey]
	end

	for k, inheritFromName in ipairs( data.InheritFrom ) do
		local parentData = dataStore[inheritFromName]
		if parentData ~= nil then
			ProcessDataInheritance( parentData, dataStore )
			DeepInheritData( data, parentData )
		else
			DebugAssert({ Condition = false, Text = "InheritFrom "..inheritFromName.." does not exists on "..tostring(data.Name) })
		end
	end

	for k, ignoreKey in pairs( inheritanceIgnores ) do
		data[ignoreKey] = originalValues[ignoreKey]
	end

end

function DeepInheritData( data, parentData )

	for parentKey, parentValue in pairs( parentData ) do
		local value = data[parentKey]
		if data.NilValues ~= nil and data.NilValues[parentKey] then
			data[parentKey] = nil
		elseif value == "nil" then
			data[parentKey] = nil
			-- Need to preserver the record that "nil" was requested after it is erased for actual nil
			data.NilValues = data.NilValues or {}
			data.NilValues[parentKey] = true
		elseif value == nil then
			if type(parentValue) == "table" then
				data[parentKey] = DeepCopyTable( parentValue )
			else
				data[parentKey] = parentValue
			end
		elseif type(parentValue) == "table" and parentValue.DeepInheritance then
			DeepInheritData( data[parentKey], parentValue )
		elseif type(value) == "table" and ( value.Append or value.Prepend ) then
			local parentTable = DeepCopyTable( parentValue )
			if value.Append then
				ConcatTableValuesIPairs( parentTable, value )
				data[parentKey] = parentTable
			else
				ConcatTableValuesIPairs( value, parentTable )
			end
		end
	end

end

function ProcessTextLines( source, textLineSet, prioritiesName, args )

	if IsEmpty( textLineSet ) then
		return
	end

	args = args or {}
	
	for textLinesName, textLines in pairs( textLineSet ) do
		textLines.Name = textLinesName
		TextLinesCache[textLines.Name] = textLines
		if textLines.StatusAnimation == nil and textLines.PlayOnce then
			textLines.StatusAnimation = args.DefaultStatusAnimation
		end
		if verboseLogging then
			local requirements = textLines.GameStateRequirements
			if requirements ~= nil then
				for requirementIndex, requirement in ipairs( requirements ) do
					if requirement.Path ~= nil then
						for i, subTable in ipairs( requirement.Path ) do
							if subTable == textLinesName then
								DebugAssert({ Condition = false, Text = "Circular dependency detected on "..textLinesName, Owner = "Greg", })
							end
						end
					end
					if requirement.PathTrue ~= nil then
						for i, subTable in ipairs( requirement.PathTrue ) do
							if subTable == textLinesName then
								DebugAssert({ Condition = false, Text = "Circular dependency detected on "..textLinesName, Owner = "Greg", })
							end
						end
					end
					if requirement.PathFalse ~= nil then
						for i, subTable in ipairs( requirement.PathFalse ) do
							if subTable == textLinesName then
								DebugAssert({ Condition = false, Text = "Circular dependency detected on "..textLinesName, Owner = "Greg", })
							end
						end
					end
				end
			end
		end
	end

	if verboseLogging and prioritiesName ~= nil and not args.IgnoreValidation then
		
		-- Validation

		local name = source.NarrativeDataName or source.Name

		local narrativeData = NarrativeData[name]
		if narrativeData == nil then
			DebugAssert({ Condition = (not fullGame), Text = name.." has no NarrativeData entry", Owner = "Greg" })
			return
		end

		local priorities = narrativeData[prioritiesName]
		if priorities == nil then
			DebugAssert({ Condition = false, Text = name.." has no NarrativeData "..prioritiesName, Owner = "Greg" })
			return
		end

		local allPriorities = {}
		for i, priority in ipairs( priorities ) do
			if type(priority) == "table" then
				for j, subPriority in ipairs( priority ) do
					if not textLineSet[subPriority] then
						DebugAssert({ Condition = false, Text = "Priority found with no data: "..subPriority, Owner = "Greg" })
					end
					if allPriorities[subPriority] then
						DebugAssert({ Condition = false, Text = "Duplicate priority found: "..subPriority, Owner = "Greg" })
					end
					allPriorities[subPriority] = true
				end
			else
				if not textLineSet[priority] then
					DebugAssert({ Condition = false, Text = "Priority found with no data: "..priority, Owner = "Greg" })
				end
				if allPriorities[priority] then
					DebugAssert({ Condition = false, Text = "Duplicate priority found: "..priority, Owner = "Greg" })
				end
				allPriorities[priority] = true
			end
		end

		for textLinesName, textLines in pairs( textLineSet ) do
			if not textLines.Skip then
				if textLines.PlayOnce then
					if not allPriorities[textLinesName] then
						DebugAssert({ Condition = false, Text = textLinesName.." has no NarrativeData "..prioritiesName.." entry", Owner = "Greg" })
					end
				else
					if allPriorities[textLinesName] then
						DebugAssert({ Condition = false, Text = textLinesName.." has a NarrativeData "..prioritiesName.." entry but does not have PlayOnce = true", Owner = "Greg" })
					end
				end
			end
			ValidateLinesFormats( textLines, textLinesName )
		end

	end

end

SetupRunData()
FinishedDataRead = true