//
//  LevelLoader.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/14/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit

class WingmanSceneLevelLoader{
    
    enum DifficultyLevel{
        case Hard
        case Medium
        case Easy
    }
    
    
    static func loadLevel5(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
    static func loadLevel4(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
    static func loadLevel3(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
   
    static func loadLevel2(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }

    static func loadLevel1(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
         let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
         let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
            case .Hard:
                return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationHard)
            case .Medium:
                return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
            case .Easy:
                return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) -> WingmanScene{
        
    
        
        return WingmanScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shhot all the wingman!", enemyName: "Wingman", playerType: .RedLarge, backgroundMusic: BackgroundMusic.AlphaDance, numberOfBackgroundObjects: numberOfBackgroundObjects, hideInterval: hideInterval, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
            
       
    }
    
    
    
}

