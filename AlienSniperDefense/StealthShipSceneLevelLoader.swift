//
//  StealthShipSceneLevelLoader.swift
//  AlienSniperDefense
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
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 5, highestValue: 15)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 6, highestValue: 10)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 6, highestValue: 9)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 30, highestValue: 50)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 20, highestValue: 40)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 30)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return  makeLevel5(numberOfBackgroundObjects: 4, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 4, enemiesSpawnedPerInterval: 6, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 20, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return  makeLevel5(numberOfBackgroundObjects: 4, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 4, enemiesSpawnedPerInterval: 6, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel5(numberOfBackgroundObjects: 4, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 4, enemiesSpawnedPerInterval: 6, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
    }

    static func loadLevel4(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 5, highestValue: 15)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 6, highestValue: 10)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 6, highestValue: 9)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 30, highestValue: 50)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 20, highestValue: 40)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 30)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return  makeLevel4(numberOfBackgroundObjects: 4, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 7, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return  makeLevel4(numberOfBackgroundObjects: 4, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 6, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel4(numberOfBackgroundObjects: 4, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }
    
    static func loadLevel3(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 5, highestValue: 15)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 6, highestValue: 10)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 6, highestValue: 9)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 30, highestValue: 50)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 20, highestValue: 40)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 30)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel3(numberOfBackgroundObjects: 4, spawnInterval: 7.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel3(numberOfBackgroundObjects: 4, spawnInterval: 7.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel3(numberOfBackgroundObjects: 4, spawnInterval: 7.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
        }
        
        
    }
    
    static func loadLevel2(difficultyLevel: DifficultyLevel) -> StealthShipScene{
        
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistMediumTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        let randomDistHardTI = GKRandomDistribution(lowestValue: 4, highestValue: 6)
        
        //Random Number Generators for SpaceShip Transition Interval
        let randomDistEasyTS = GKRandomDistribution(lowestValue: 30, highestValue: 50)
        let randomDistMediumTS = GKRandomDistribution(lowestValue: 20, highestValue: 40)
        let randomDistHardTS = GKRandomDistribution(lowestValue: 10, highestValue: 30)
        
        //Random Number Generators for SpaceShip Travel Speed
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistHardTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistHardTI.nextUniform()))
        case .Medium:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistMediumTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistMediumTI.nextUniform()))
        case .Easy:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, spaceShipTravelSpeed: Double(randomDistEasyTS.nextUniform()), spaceShipTransitionInterval: Double(randomDistEasyTI.nextUniform()))
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
    
    
    static private func makeLevel5(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval) -> StealthShipScene{
        
        
        return StealthShipScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 5, levelDescription: "Stealth ships make their last stand!", enemyName: "Stealth Ship", playerType: .RedLarge, backgroundMusic: BackgroundMusic.FarmFrolics, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, spaceShipTravelSpeed: spaceShipTravelSpeed, spaceShipTransitionInterval: spaceShipTransitionInterval, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    static private func makeLevel4(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval) -> StealthShipScene{
        
        
        return StealthShipScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 4, levelDescription: "The stealth ships are spawning like crazy now!", enemyName: "Stealth Ship", playerType: .RedLarge, backgroundMusic: BackgroundMusic.FarmFrolics, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, spaceShipTravelSpeed: spaceShipTravelSpeed, spaceShipTransitionInterval: spaceShipTransitionInterval, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    static private func makeLevel3(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval) -> StealthShipScene{
        
        
        return StealthShipScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 3, levelDescription: "The stealth ships are getting stealthier!", enemyName: "Stealth Ship", playerType: .RedLarge, backgroundMusic: BackgroundMusic.FarmFrolics, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, spaceShipTravelSpeed: spaceShipTravelSpeed, spaceShipTransitionInterval: spaceShipTransitionInterval, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    
    static private func makeLevel2(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval) -> StealthShipScene{
        
        
        return StealthShipScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 2, levelDescription: "The stealth ships are getting faster!", enemyName: "Stealth Ship", playerType: .RedLarge, backgroundMusic: BackgroundMusic.FarmFrolics, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, spaceShipTravelSpeed: spaceShipTravelSpeed, spaceShipTransitionInterval: spaceShipTransitionInterval, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval) -> StealthShipScene{
        
        
        return StealthShipScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the Stealth Ships!", enemyName: "Stealth Ship", playerType: .RedLarge, backgroundMusic: BackgroundMusic.FarmFrolics, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, spaceShipTravelSpeed: spaceShipTravelSpeed, spaceShipTransitionInterval: spaceShipTransitionInterval, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
 
    
 }
