//
//  BatSceneLevelLoader.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit



class BatSceneLevelLoader{
    
    enum DifficultyLevel{
        case Hard
        case Medium
        case Easy
    }
    
    static func getLevel5Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel5(numberOfBackgroundObjects: 6, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Medium:
            return makeLevel5(numberOfBackgroundObjects: 6, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 12, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Easy:
            return makeLevel5(numberOfBackgroundObjects: 6, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        }
        
        
    }
    
    static func getLevel4Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel4(numberOfBackgroundObjects: 6, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Medium:
            return makeLevel4(numberOfBackgroundObjects: 6, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 12, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Easy:
            return makeLevel4(numberOfBackgroundObjects: 6, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        }
        
        
    }
    
    static func getLevel3Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel3(numberOfBackgroundObjects: 6, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Medium:
            return makeLevel3(numberOfBackgroundObjects: 6, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 12, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Easy:
            return makeLevel3(numberOfBackgroundObjects: 6, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        }
        
        
    }
    
    static func getLevel2Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel2(numberOfBackgroundObjects: 6, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Medium:
            return makeLevel2(numberOfBackgroundObjects: 6, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 12, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Easy:
            return makeLevel2(numberOfBackgroundObjects: 6, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        }
        
        
    }
    
    static func getLevel1Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 6, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 6, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 12, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 6, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 3.0)
            
        }
 
        
    }
    
    
    static private func makeLevel5(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 5, levelDescription: "The Bats make their last stand!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    static private func makeLevel4(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 4, levelDescription: "The bats are spawning more frequently!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    static private func makeLevel3(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 3, levelDescription: "The bats just got harder to see!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    static private func makeLevel2(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 2, levelDescription: "The bats just got a little faster!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    static private func makeLevel1(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the bats!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }

    
    
    
}


