//
//  SpaceShipLevelLoader.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class StealthShipSceneLevelLoader{
    
    enum DifficultyLevel{
        case Hard
        case Medium
        case Easy
    }
    
    
    
    static func loadLevel5(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }

    
    
    static func loadLevel4(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }

    
    
    static func loadLevel3(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }

    
    static func loadLevel2(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 5, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 5, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 5, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }
    
    static func loadLevel1(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 20)

        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }
    
    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval) -> StealthShipScene{
        
        
        return StealthShipScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the Stealth Ships!", enemyName: "Stealth Ship", playerType: .RedLarge, backgroundMusic: BackgroundMusic.FarmFrolics, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, spaceShipTravelSpeed: spaceShipTravelSpeed, spaceShipTransitionInterval: spaceShipTransitionInterval, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
 
    
 }
