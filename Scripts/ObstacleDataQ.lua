-- Typhon
OverwriteTableKeys( ObstacleData, {

    TyphonExitDoor =
    {
        InheritFrom = { "ExitDoor", },
        UnlockedAnimation = "TyphonExitDoor",
        ExitDoorOpenAnimation = "TyphonExitDoorCrumble",
        RewardPreviewOffsetZ = 390,

        UsePromptOffsetY = -5,
        UsePromptOffsetX = 60,

        AllowReroll = false,
        InteractDistance = 285,

        --ExitThroughCenter = true,

        UseText = "UseExitDoorWhileLocked",
        UnlockedUseText = "UseLeaveRoom",
        UnlockedUseTextReroll = "UseLeaveRoom_Reroll",
        UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

        LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
        UnlockedSound = "/SFX/HeatCollectionPickup",
        UnlockedUseSound = "/Leftovers/World Sounds/MapZoomInShortHigh",
        ExitPortalSound = "/SFX/HeatCollectionPickup",

        -- EntranceVfx = "SecretDoorDiveFx_Shrine",
        EntranceColorGrade = "SmokeTrap",

        DefaultRewardPreviewOverride = "ExitUpPreview",

        OnUsedPresentationFunctionName = "GenericPresentation",
        OnUsedPresentationFunctionArgs =
        {
            ThreadedVoiceLines =
            {
                UsePlayerSource = true,
                PreLineWait = 0.45,
                RandomRemaining = true,
                BreakIfPlayed = true,
                -- ChanceToPlay = 0.5,
                ThreadName = "RoomThread",
                GameStateRequirements =
                {
                    {
                        FunctionName = "RequiredHealthFraction",
                        FunctionArgs = { Comparison = ">=", Value = 0.2, },
                    },
                    {
                        Path = { "CurrentRun", "BiomeDepthCache" },
                        Comparison = ">=",
                        Value = 3,
                    },
                    {
                        Path = { "CurrentRun", "RoomsEntered" },
                        HasNone = { "Q_Boss01", "Q_Boss02" },
                    },
                },
                Cooldowns =
                {
                    { Name = "MelinoeAnyQuipSpeech", Time = 6 },
                    { Name = "TyponExitVoiceLines", Time = 120 },
                },

                { Cue = "/VO/MelinoeField_2944", Text = "Next floor." },
                { Cue = "/VO/MelinoeField_2945", Text = "Higher up." },
                { Cue = "/VO/MelinoeField_2946", Text = "Closer to the top." },
                { Cue = "/VO/MelinoeField_2947", Text = "Almost to the top.",
                    GameStateRequirements =
                    {
                        {
                            PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
                        },
                        {
                            Path = { "CurrentRun", "BiomeDepthCache" },
                            Comparison = ">=",
                            Value = 6,
                        },
                    }
                },
                { Cue = "/VO/MelinoeField_2948", Text = "Nearly there now.",
                    GameStateRequirements =
                    {
                        {
                            PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
                        },
                        {
                            Path = { "CurrentRun", "BiomeDepthCache" },
                            Comparison = ">=",
                            Value = 6,
                        },
                    }
                },
                { Cue = "/VO/MelinoeField_2949", Text = "Few more floors...",
                    GameStateRequirements =
                    {
                        {
                            PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
                        },
                        {
                            Path = { "CurrentRun", "BiomeDepthCache" },
                            Comparison = ">=",
                            Value = 5,
                        },
                        {
                            Path = { "CurrentRun", "BiomeDepthCache" },
                            Comparison = "<=",
                            Value = 6,
                        },
                    }
                },
            },
        },

    },

    FortressMainDoor =
    {
        InheritFrom = { "ExitDoor", },

        ExitFunctionName = "FortressMainDoorOpenPresentation",

        UnlockedAnimation = "FortressMainDoorClosed",

        -- ExitDoorOpenAnimation = "FortressMainDoorOpen",
        InteractDistance = 500,
        InteractOffsetX = -30,
        InteractOffsetY = -300,

        AllowReroll = false,
        HideRewardPreview = true,
        UnlockedUseText = "UseLeaveRoom",

        ExitBlockedVoiceLines =
        {
            HeroVoiceLines.InteractionBlockedVoiceLines,
        },
        Using = { Animation = "FortressMainDoorOpen" },
    },

    Breakable_Q =
    {
        InheritFrom = { "BaseBreakable" },

        DeathSound = "/SFX/CeramicPotSmash",
        DeathFx = "Typhon_Vase01_Shatter",

        SetupEvents =
        {
            {
                FunctionName = "RandomizeObject",
                Args =
                {
                    RandomizeSets =
                    {
                        {
                            Animation = { "Breakable_Q01" },
                            OverwriteData =
                            {
                                DeathFx = "Typhon_Vase01_Shatter",
                            },
                        },
                        {
                            Animation = { "Breakable_Q02" },
                            OverwriteData =
                            {
                                DeathFx = "Typhon_Vase02_Shatter",
                            },
                        },
                        {
                            Animation = { "Breakable_Q03" },
                            OverwriteData =
                            {
                                DeathFx = "Typhon_Vase03_Shatter",
                            },
                        },
                    },
                },
            },
        },

        BreakableValueOptions =
        {
            {
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
                Animation = "Breakable_Q_HighValue",
                DataOverrides =
                {
                    OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
                    DeathFx = "Typhon_Vase04_Shatter",
                    DeathSound = "/SFX/GoldObjectSmash",
                },
                GameStateRequirements =
                {
                    
                },
            },
            {
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
                Animation = "Breakable_Q_HighValue",
                DataOverrides =
                {
                    OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
                    DeathFx = "EphyraBreakableVaseGoldShatter",
                    DeathSound = "/SFX/GoldObjectSmash",
                },
                GameStateRequirements =
                {
                    
                },
            },
            {
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
                Animation = "Breakable_Q_HighValue",
                DataOverrides =
                {
                    OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
                    DeathFx = "EphyraBreakableVaseGoldShatter",
                    DeathSound = "/SFX/GoldObjectSmash",
                },
                GameStateRequirements =
                {
                },
            },
        },
    },

    TyphonSpike =
    {
        InheritFrom = { "BaseDestructible" },

        CannotDieFromDamage = true,
        MaxHealth = 0,
        DeathSound = "/SFX/BoneRewardPickup",
        DeathFx = "RubbleFall",

        OnDamagedFunctionName = "DestructibleTreeHit",

        DefaultAIData =
        {
            HitsToSplinter = 4,
        },

        WeaponOptions =
        {
            "TyphonSpikeSplinter",
        },

        OutgoingDamageModifiers =
        {
            {
                NonPlayerMultiplier = 5,
            },
            {
                PlayerMultiplier = 0.0,
            }
        },

        OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
    },

    TyphonDestructiblePillar01 =
    {
        Material = "Stone",

        OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
        CollisionReactions =
        {
            {
                RequireCollidee = { "Brute_Miniboss" },
                Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
                SoundManagerCap = 38,
                DestroySelf = true,
                RecordDestroyed = true,
                SpawnObstacle = "TyphonDestructiblePillar01_Destroyed",
                RestoreOnLoad = true,
                MaintainHorizontalFlip = true,
                SpawnGroup = "Terrain_Gameplay",
                SpawnOffsetXMin = 0,
                SpawnOffsetXMax = 0,
                SpawnOffsetYMin = 0,
                SpawnOffsetYMax = 0,
            }
        },
        ImpactReaction =
        {
            --RequiredSourceProjectile = { "BruteChargeRadial_Miniboss", "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave" },
            RequiredSourceProjectile = { "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave", "BruteSlamShockwave2", "BruteSlamShockwave3", "BruteMelee_Miniboss" },
            Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
            SoundManagerCap = 38,
            DestroySelf = true,
            RecordDestroyed = true,
            SpawnObstacle = "TyphonDestructiblePillar01_Destroyed",
            RestoreOnLoad = true,
            MaintainHorizontalFlip = true,
            SpawnGroup = "Terrain_Gameplay",
            SpawnOffsetXMin = 0,
            SpawnOffsetXMax = 0,
            SpawnOffsetYMin = 0,
            SpawnOffsetYMax = 0,
        },
    },

    TyphonDestructiblePillar02 =
    {
        InheritFrom = { "TyphonDestructiblePillar01" },
        CollisionReactions =
        {
            {
                RequireCollidee = { "Brute_Miniboss" },
                Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
                SoundManagerCap = 38,
                DestroySelf = true,
                RecordDestroyed = true,
                SpawnObstacle = "TyphonDestructiblePillar02_Destroyed",
                RestoreOnLoad = true,
                MaintainHorizontalFlip = true,
                SpawnGroup = "Terrain_Gameplay",
                SpawnOffsetXMin = 0,
                SpawnOffsetXMax = 0,
                SpawnOffsetYMin = 0,
                SpawnOffsetYMax = 0,
            }
        },
        ImpactReaction =
        {
            --RequiredSourceProjectile = { "BruteChargeRadial_Miniboss", "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave" },
            RequiredSourceProjectile = { "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave", "BruteSlamShockwave2", "BruteSlamShockwave3", "BruteMelee_Miniboss" },
            Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
            SoundManagerCap = 38,
            DestroySelf = true,
            RecordDestroyed = true,
            SpawnObstacle = "TyphonDestructiblePillar02_Destroyed",
            RestoreOnLoad = true,
            MaintainHorizontalFlip = true,
            SpawnGroup = "Terrain_Gameplay",
            SpawnOffsetXMin = 0,
            SpawnOffsetXMax = 0,
            SpawnOffsetYMin = 0,
            SpawnOffsetYMax = 0,
        },
    },

    TyphonDestructiblePillar03 =
    {
        InheritFrom = { "TyphonDestructiblePillar01" },
        CollisionReactions =
        {
            {
                RequireCollidee = { "Brute_Miniboss" },
                Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
                SoundManagerCap = 38,
                DestroySelf = true,
                RecordDestroyed = true,
                SpawnObstacle = "TyphonDestructiblePillar03_Destroyed",
                RestoreOnLoad = true,
                MaintainHorizontalFlip = true,
                SpawnGroup = "Terrain_Gameplay",
                SpawnOffsetXMin = 0,
                SpawnOffsetXMax = 0,
                SpawnOffsetYMin = 0,
                SpawnOffsetYMax = 0,
            }
        },
        ImpactReaction =
        {
            --RequiredSourceProjectile = { "BruteChargeRadial_Miniboss", "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave" },
            RequiredSourceProjectile = { "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave", "BruteSlamShockwave2", "BruteSlamShockwave3", "BruteMelee_Miniboss" },
            Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
            SoundManagerCap = 38,
            DestroySelf = true,
            RecordDestroyed = true,
            SpawnObstacle = "TyphonDestructiblePillar03_Destroyed",
            RestoreOnLoad = true,
            MaintainHorizontalFlip = true,
            SpawnGroup = "Terrain_Gameplay",
            SpawnOffsetXMin = 0,
            SpawnOffsetXMax = 0,
            SpawnOffsetYMin = 0,
            SpawnOffsetYMax = 0,
        },
    },
    
    TyphonDestructiblePillar04 =
    {
        InheritFrom = { "TyphonDestructiblePillar01" },
        CollisionReactions =
        {
            {
                RequireCollidee = { "Brute_Miniboss" },
                Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
                SoundManagerCap = 38,
                DestroySelf = true,
                RecordDestroyed = true,
                SpawnObstacle = "TyphonDestructiblePillar04_Destroyed",
                RestoreOnLoad = true,
                MaintainHorizontalFlip = true,
                SpawnGroup = "Terrain_Gameplay",
                SpawnOffsetXMin = 0,
                SpawnOffsetXMax = 0,
                SpawnOffsetYMin = 0,
                SpawnOffsetYMax = 0,
            }
        },
        ImpactReaction =
        {
            --RequiredSourceProjectile = { "BruteChargeRadial_Miniboss", "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave" },
            RequiredSourceProjectile = { "BruteChargeHorn_Miniboss", "BruteChargeWave_Miniboss", "BruteSlamShockwave", "BruteSlamShockwave2", "BruteSlamShockwave3", "BruteMelee_Miniboss" },
            Sound = "/SFX/Enemy Sounds/CrusherAttackImpact",
            SoundManagerCap = 38,
            DestroySelf = true,
            RecordDestroyed = true,
            SpawnObstacle = "TyphonDestructiblePillar04_Destroyed",
            RestoreOnLoad = true,
            MaintainHorizontalFlip = true,
            SpawnGroup = "Terrain_Gameplay",
            SpawnOffsetXMin = 0,
            SpawnOffsetXMax = 0,
            SpawnOffsetYMin = 0,
            SpawnOffsetYMax = 0,
        },
    },

    TyphonDestructiblePillar01_Destroyed =
    {
        Material = "Stone",
    },
    TyphonDestructiblePillar02_Destroyed =
    {
        Material = "Stone",
    },
    TyphonDestructiblePillar03_Destroyed =
    {
        Material = "Stone",
    },
    TyphonDestructiblePillar04_Destroyed =
    {
        Material = "Stone",
    },

    ShadeTyphonIdle01=
    {
        InheritFrom = { "BaseGhost", "SmallEmotes" },
    },
})