//
//  BatSceneLevelLoader.swift
//  AlienSniperDefense
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
    
    /**LEVEL 5 Challenge: bats spawn more rapidly and move more quickly
     
     Hard:      Maximum allowable on-screen bats: 10, Minimum kills for level completion: 20
     Medium:    Maximum allowable on-screen bats: 20, Minimum kills for level completion: 20
     Hard:      Maximum allowable on-screen bats: 30, Minimum kills for level completion: 20
     
     **/
    static func getLevel5Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel5(numberOfBackgroundObjects: 3, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 10, minimumKillsForLevelCompletion: 20, minBatsSpawned: 3, maxBatsSpawned: 5, minBatComponentVelocity: 50, maxBatComponentVelocity: 120, lightNodeFalloff: 1.0)
            
        case .Medium:
            return makeLevel5(numberOfBackgroundObjects: 3, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, minBatsSpawned: 3, maxBatsSpawned: 5, minBatComponentVelocity: 50, maxBatComponentVelocity: 120, lightNodeFalloff: 1.0)
            
        case .Easy:
            return makeLevel5(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 20, minBatsSpawned: 3, maxBatsSpawned: 5, minBatComponentVelocity: 50, maxBatComponentVelocity: 120, lightNodeFalloff: 1.0)
            
        }
        
        
    }
    
    
    /**LEVEL 4 Challenge: bats spawn more rapidly and move more quickly
     
     Hard:      Maximum allowable on-screen bats: 20, Minimum kills for level completion: 20
     Medium:    Maximum allowable on-screen bats: 30, Minimum kills for level completion: 15
     Hard:      Maximum allowable on-screen bats: 40, Minimum kills for level completion: 10
     
     **/
    static func getLevel4Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel4(numberOfBackgroundObjects: 3, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 20, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 1.0)
            
        case .Medium:
            return makeLevel4(numberOfBackgroundObjects: 3, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 2, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 1.0)
            
        case .Easy:
            return makeLevel4(numberOfBackgroundObjects: 3, spawnInterval: 5.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 1.0)
            
        }
        
        
    }
    
  
    
    /**LEVEL 3 Challenge: bats are harder to see, and fewer background objects are available to create silhouettes
     
     Hard:      Maximum allowable on-screen bats: 20, Minimum kills for level completion: 20
     Medium:    Maximum allowable on-screen bats: 30, Minimum kills for level completion: 15
     Hard:      Maximum allowable on-screen bats: 40, Minimum kills for level completion: 10
     
     **/
    static func getLevel3Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel3(numberOfBackgroundObjects: 3, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 1.0)
            
        case .Medium:
            return makeLevel3(numberOfBackgroundObjects: 3, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 1.0)
            
        case .Easy:
            return makeLevel3(numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 1.0)
            
        }
        
        
    }
    
    

    /**LEVEL 2 Challenge: the bats move faster and fewer background objects are present to create silhouettes that make them more visible
     
     Hard:      Maximum allowable on-screen bats: 20, Minimum kills for level completion: 20
     Medium:    Maximum allowable on-screen bats: 30, Minimum kills for level completion: 15
     Hard:      Maximum allowable on-screen bats: 40, Minimum kills for level completion: 10
     
     **/
    static func getLevel2Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 0.70)
            
        case .Medium:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 0.70)
            
        case .Easy:
            return makeLevel2(numberOfBackgroundObjects: 4, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 30, maxBatComponentVelocity: 100, lightNodeFalloff: 0.70)
            
        }
        
        
    }
    
    /**LEVEL 1 Challenge: relatively basic, allows user to acclimate to the gameplay for this track and gain confidence for greater challenges!
     
     Hard:      Maximum allowable on-screen bats: 20, Minimum kills for level completion: 20
     Medium:    Maximum allowable on-screen bats: 30, Minimum kills for level completion: 15
     Hard:      Maximum allowable on-screen bats: 40, Minimum kills for level completion: 10
     
    **/

    static func getLevel1Scene(size: CGSize, difficultyLevel: DifficultyLevel) -> BatScene{
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel1(numberOfBackgroundObjects: 6, spawnInterval: 8.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 5, maximumEnemiesAllowed: 20, minimumKillsForLevelCompletion: 20, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 0.60)
            
        case .Medium:
            return makeLevel1(numberOfBackgroundObjects: 6, spawnInterval: 9.0, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 4, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 15, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 0.60)
            
        case .Easy:
            return makeLevel1(numberOfBackgroundObjects: 6, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 2, enemiesSpawnedPerInterval: 3, maximumEnemiesAllowed: 40, minimumKillsForLevelCompletion: 10, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 0, maxBatComponentVelocity: 50, lightNodeFalloff: 0.60)
            
        }
 
        
    }
    
    
    static private func makeLevel5(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 5, levelDescription: "The Bats make their last stand!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
    }
    
    
    static private func makeLevel4(numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double, lightNodeFalloff: CGFloat) -> BatScene{
        
        
        
        return BatScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 4, levelDescription: "The bats are spawning like crazy!", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: numberOfBackgroundObjects, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfEnemiesSpawned, minBatsSpawned: minBatsSpawned, maxBatsSpawned: maxBatsSpawned, minBatComponentVelocity: minBatComponentVelocity, maxBatComponentVelocity: maxBatComponentVelocity, lightNodeFallOff: lightNodeFalloff, maximumBatsAllowedToSpawn: maximumEnemiesAllowed, minimumBatsKilledForLevelCompletion: minimumKillsForLevelCompletion)
        
        
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


