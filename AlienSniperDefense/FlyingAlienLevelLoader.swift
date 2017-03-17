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
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    static func loadLevel4(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    static func loadLevel3(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
    static func loadLevel2(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }
    
    
    static func loadLevel1(difficultyLevel: DifficultyLevel) -> FlyingAlienScene{
        
        let randomVectorConfigurationEasy = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 20, minimumVectorXComponent: 0, maximumVectorXComponent: 20)
        
        let randomVectorConfigurationMedium = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 30, minimumVectorXComponent: 0, maximumVectorXComponent: 30)
        
        let randomVectorConfigurationHard = RandomVectorConfiguration(minimumVectorYComponent: 0, maximumVectorYComponent: 40, minimumVectorXComponent: 0, maximumVectorXComponent: 40)
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationHard)
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationMedium)
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 1, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, fieldActionInterval: 10, randomVectorConfiguration: randomVectorConfigurationEasy)
        }
        
        
    }

    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, fieldActionInterval: TimeInterval, randomVectorConfiguration: RandomVectorConfiguration) -> FlyingAlienScene{
        
        
        return FlyingAlienScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the aliens", enemyName: "Hover Aliens", crosshairType: .OutlineLarge, backgroundMusic: BackgroundMusic.FarmFrolics, fieldActionInterval: fieldActionInterval, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, enemiesSpawnedPerInterval: enemiesSpawnedPerInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, maximumNumberOfEnemiesAllowed: maximumEnemiesAllowed, minimumKillsForLevelCompletion: minimumKillsForLevelCompletion, randomVectorConfiguration: randomVectorConfiguration)
        
        
    }
    
}
