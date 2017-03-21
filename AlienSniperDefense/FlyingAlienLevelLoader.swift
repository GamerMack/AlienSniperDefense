//
//  FlyingAlienLevelLoader.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class FlyingAlienLevelLoader{
    
    enum DifficultyLevel{
        case Hard, Medium, Easy
    }
    
    
    static func loadLevel5(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 200, minimumVectorXComponent: 100, maximumVectorXComponent: 200)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 200, minimumVectorXComponent: 100, maximumVectorXComponent: 200)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 200, minimumVectorXComponent: 100, maximumVectorXComponent: 200)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel5(numberOfBackgroundObjects: 9, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel5(numberOfBackgroundObjects: 9, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel5(numberOfBackgroundObjects: 9, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationEasy)
        
        }
    }
    
    static func loadLevel4(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 150, minimumVectorXComponent: 100, maximumVectorXComponent: 150)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 150, minimumVectorXComponent: 100, maximumVectorXComponent: 150)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 150, minimumVectorXComponent: 100, maximumVectorXComponent: 150)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel4(numberOfBackgroundObjects: 7, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel4(numberOfBackgroundObjects: 7, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel4(numberOfBackgroundObjects: 7, spawnInterval: 4.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationEasy)
        }

        
    }
    
    static func loadLevel3(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 150, minimumVectorXComponent: 100, maximumVectorXComponent: 150)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 150, minimumVectorXComponent: 100, maximumVectorXComponent: 150)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 100, maximumVectorYComponent: 150, minimumVectorXComponent: 100, maximumVectorXComponent: 150)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel3(numberOfBackgroundObjects: 5, spawnInterval: 6.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 30, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel3(numberOfBackgroundObjects: 5, spawnInterval: 6.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel3(numberOfBackgroundObjects: 5, spawnInterval: 6.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
    }
    
    static func loadLevel2(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 3, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, fieldActionInterval: 7, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    static func loadLevel1(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 50, maximumVectorYComponent: 100, minimumVectorXComponent: 50, maximumVectorXComponent: 100)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 5, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    static private func makeLevel5(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, fieldActionInterval: TimeInterval, randomVectorConfiguration: RandomVectorConfiguration) -> FlyingAlienScene{
        
        
        return FlyingAlienScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 5, levelDescription: "The Hover Borg make their last stand!!", enemyName: "Hover Borg", crosshairType: .OutlineLarge, backgroundMusic: BackgroundMusic.FarmFrolics, fieldActionInterval: fieldActionInterval, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion, randomVectorConfiguration: randomVectorConfiguration)
        
        
    }
    
    
    static private func makeLevel4(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, fieldActionInterval: TimeInterval, randomVectorConfiguration: RandomVectorConfiguration) -> FlyingAlienScene{
        
        
        return FlyingAlienScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 4, levelDescription: "The Hover Borg are spawning like mad!!", enemyName: "Hover Borg", crosshairType: .OutlineLarge, backgroundMusic: BackgroundMusic.FarmFrolics, fieldActionInterval: fieldActionInterval, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion, randomVectorConfiguration: randomVectorConfiguration)
        
        
    }

    
    static private func makeLevel3(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, fieldActionInterval: TimeInterval, randomVectorConfiguration: RandomVectorConfiguration) -> FlyingAlienScene{
        
        
        return FlyingAlienScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 3, levelDescription: "The Hover Borg are really upset now!!", enemyName: "Hover Borg", crosshairType: .OutlineLarge, backgroundMusic: BackgroundMusic.FarmFrolics, fieldActionInterval: fieldActionInterval, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion, randomVectorConfiguration: randomVectorConfiguration)
        
        
    }
    
    static private func makeLevel2(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, fieldActionInterval: TimeInterval, randomVectorConfiguration: RandomVectorConfiguration) -> FlyingAlienScene{
        
        
        return FlyingAlienScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 2, levelDescription: "The Hover Borg are upset with you!", enemyName: "Hover Borg", crosshairType: .OutlineLarge, backgroundMusic: BackgroundMusic.FarmFrolics, fieldActionInterval: fieldActionInterval, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion, randomVectorConfiguration: randomVectorConfiguration)
        
        
    }
    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, fieldActionInterval: TimeInterval, randomVectorConfiguration: RandomVectorConfiguration) -> FlyingAlienScene{
        
        
        return FlyingAlienScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the aliens", enemyName: "Hover Borg", crosshairType: .OutlineLarge, backgroundMusic: BackgroundMusic.FarmFrolics, fieldActionInterval: fieldActionInterval, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion, randomVectorConfiguration: randomVectorConfiguration)
        
        
    }
    
}
