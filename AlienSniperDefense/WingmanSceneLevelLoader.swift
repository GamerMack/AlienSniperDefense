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
    
    /** Level 5 Challenge:  The Wingman spawn more frequently and in greater numbers
     
     **/
    static func loadLevel5(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 20, maximumVectorYComponent: 50, minimumVectorXComponent: 20, maximumVectorXComponent: 50)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 40, maximumVectorYComponent: 80, minimumVectorXComponent: 40, maximumVectorXComponent: 80)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 80, maximumVectorYComponent: 100, minimumVectorXComponent: 80, maximumVectorXComponent: 100)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel5(numberOfBackgroundObjects: 6, hideInterval: 5.0, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel5(numberOfBackgroundObjects: 6, hideInterval: 5.0, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel5(numberOfBackgroundObjects: 6, hideInterval: 5.0, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 3, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
   
    /** Level 4 Challenge:  The Wingman spawn more frequently and in greater numbers
     
     **/
    
    static func loadLevel4(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 40, maximumVectorYComponent: 80, minimumVectorXComponent: 40, maximumVectorXComponent: 80)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 40, maximumVectorYComponent: 90, minimumVectorXComponent: 40, maximumVectorXComponent: 90)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel4(numberOfBackgroundObjects: 5, hideInterval: 5.0, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel4(numberOfBackgroundObjects: 5, hideInterval: 5.0, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel4(numberOfBackgroundObjects: 5, hideInterval: 5.0, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    /** Level 3 Challenge:  The Wingman move more quickly; minimum and maximum values for Vector Components are configured through the RandomVectorConfiguration object
     
     **/
    static func loadLevel3(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 50, minimumVectorXComponent: 0, maximumVectorXComponent: 50)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 60, minimumVectorXComponent: 0, maximumVectorXComponent: 60)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 60, minimumVectorXComponent: 0, maximumVectorXComponent: 60)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel3(numberOfBackgroundObjects: 4, hideInterval: 5.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 10, minimumKillsForLevelCompletion: 20, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel3(numberOfBackgroundObjects: 4, hideInterval: 5.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 15, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel3(numberOfBackgroundObjects: 4, hideInterval: 5.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
   
    /** Level 2 Challenge:  The hide frequency of the Wingman increases, and the number of background objects increases as well, providing more hiding locations
     
     **/
    static func loadLevel2(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel2(numberOfBackgroundObjects: 4, hideInterval: 5.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 10, minimumKillsForLevelCompletion: 20, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel2(numberOfBackgroundObjects: 4, hideInterval: 5.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 15, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel2(numberOfBackgroundObjects: 4, hideInterval: 5.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }

    static func loadLevel1(difficultyLevel: DifficultyLevel) -> WingmanScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
         let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
         let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
            case .Hard:
                return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 10, minimumKillsForLevelCompletion: 20, randomVectorConfiguration: randomVectorConfigurationHard)
            case .Medium:
                return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 15, randomVectorConfiguration: randomVectorConfigurationMedium)
            case .Easy:
                return makeLevel1(numberOfBackgroundObjects: 4, hideInterval: 10.0, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
    
    /** Level 5 Challenge:  The Wingman spawn more frequently and in greater numbers
     
     **/
    static private func makeLevel5(numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) -> WingmanScene{
        
        
        
        return WingmanScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 5, levelDescription: "Wingman make their last stand!", enemyName: "Wingman", playerType: .RedLarge, backgroundMusic: BackgroundMusic.AlphaDance, numberOfBackgroundObjects: numberOfBackgroundObjects, hideInterval: hideInterval, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    
    
    
    /** Level 4 Challenge:  The Wingman spawn more frequently and in greater numbers
     
     **/
    static private func makeLevel4(numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) -> WingmanScene{
        
        
        
        return WingmanScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 4, levelDescription: "Wingman are spawning like crazy!", enemyName: "Wingman", playerType: .RedLarge, backgroundMusic: BackgroundMusic.AlphaDance, numberOfBackgroundObjects: numberOfBackgroundObjects, hideInterval: hideInterval, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    
    
    /** Level 3 Challenge:  The Wingman move more quickly; minimum and maximum values for Vector Components are configured through the RandomVectorConfiguration object
     
     **/
    static private func makeLevel3(numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) -> WingmanScene{
        
        
        
        return WingmanScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 3, levelDescription: "The wingman are moving faster now!", enemyName: "Wingman", playerType: .RedLarge, backgroundMusic: BackgroundMusic.AlphaDance, numberOfBackgroundObjects: numberOfBackgroundObjects, hideInterval: hideInterval, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    /** Level 2 Challenge:  The hide frequency of the Wingman increases, and the number of background objects increases as well, providing more hiding locations
 
     **/
    static private func makeLevel2(numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) -> WingmanScene{
        
        
        
        return WingmanScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 2, levelDescription: "The wingman want to hide more!", enemyName: "Wingman", playerType: .RedLarge, backgroundMusic: BackgroundMusic.AlphaDance, numberOfBackgroundObjects: numberOfBackgroundObjects, hideInterval: hideInterval, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) -> WingmanScene{
        
    
        
        return WingmanScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the wingman!", enemyName: "Wingman", playerType: .RedLarge, backgroundMusic: BackgroundMusic.AlphaDance, numberOfBackgroundObjects: numberOfBackgroundObjects, hideInterval: hideInterval, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion)
            
       
    }
    
    
    
}

