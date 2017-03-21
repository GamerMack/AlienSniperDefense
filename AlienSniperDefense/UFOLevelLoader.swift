//
//  UFOLevelLoader.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class UFOLevelLoader{
    
    
    enum DifficultyLevel{
        case Hard
        case Medium
        case Easy
    }
    
    static func getLevel5(difficultyLevel: DifficultyLevel) -> UFOScene{
        
        var scene: UFOScene
        
        let randomDistHard = GKRandomDistribution(lowestValue: 25, highestValue: 35)
        let randomDistMedium = GKRandomDistribution(lowestValue: 15, highestValue: 25)
        let randomDistEasy = GKRandomDistribution(lowestValue: 10, highestValue: 15)
        
        
        let hardConfig = PathAnimationConfiguration(d1: Double(randomDistHard.nextUniform()), d2: Double(randomDistHard.nextUniform()), d3: Double(randomDistHard.nextUniform()), d4: Double(randomDistHard.nextUniform()), d5: Double(randomDistHard.nextUniform()))
        
        let mediumConfig = PathAnimationConfiguration(d1: Double(randomDistMedium.nextUniform()), d2: Double(randomDistMedium.nextUniform()), d3: Double(randomDistMedium.nextUniform()), d4: Double(randomDistMedium.nextUniform()), d5: Double(randomDistMedium.nextUniform()))
        
        let easyConfig = PathAnimationConfiguration(d1: Double(randomDistEasy.nextUniform()), d2: Double(randomDistEasy.nextUniform()), d3: Double(randomDistEasy.nextUniform()), d4: Double(randomDistEasy.nextUniform()), d5: Double(randomDistEasy.nextUniform()))
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel5Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 4, minUFOSpawnedPerInterval: 6, maxUFOSpawnedPerInterval: 10, minimumKilledForLevelCompletion: 20, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            
        case .Medium:
            return makeLevel5Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 5, maxUFOSpawnedPerInterval: 8, minimumKilledForLevelCompletion: 15, maximumAllowableUFOonScreen: 30, pathAnimationConfiguration: mediumConfig)
            
        case .Easy:
            return makeLevel5Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 5, maxUFOSpawnedPerInterval: 8, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 40, pathAnimationConfiguration: easyConfig)
            
        }
        
    }
    
    static func getLevel4(difficultyLevel: DifficultyLevel) -> UFOScene{
        
        var scene: UFOScene
        
        let randomDistHard = GKRandomDistribution(lowestValue: 15, highestValue: 25)
        let randomDistMedium = GKRandomDistribution(lowestValue: 10, highestValue: 15)
        let randomDistEasy = GKRandomDistribution(lowestValue: 5, highestValue: 10)
        
        
        let hardConfig = PathAnimationConfiguration(d1: Double(randomDistHard.nextUniform()), d2: Double(randomDistHard.nextUniform()), d3: Double(randomDistHard.nextUniform()), d4: Double(randomDistHard.nextUniform()), d5: Double(randomDistHard.nextUniform()))
        
        let mediumConfig = PathAnimationConfiguration(d1: Double(randomDistMedium.nextUniform()), d2: Double(randomDistMedium.nextUniform()), d3: Double(randomDistMedium.nextUniform()), d4: Double(randomDistMedium.nextUniform()), d5: Double(randomDistMedium.nextUniform()))
        
        let easyConfig = PathAnimationConfiguration(d1: Double(randomDistEasy.nextUniform()), d2: Double(randomDistEasy.nextUniform()), d3: Double(randomDistEasy.nextUniform()), d4: Double(randomDistEasy.nextUniform()), d5: Double(randomDistEasy.nextUniform()))
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel4Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 3, minUFOSpawnedPerInterval: 5, maxUFOSpawnedPerInterval: 8, minimumKilledForLevelCompletion: 20, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            
        case .Medium:
            return makeLevel4Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 5, maxUFOSpawnedPerInterval: 8, minimumKilledForLevelCompletion: 15, maximumAllowableUFOonScreen: 30, pathAnimationConfiguration: mediumConfig)
            
        case .Easy:
            return makeLevel4Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 5, maxUFOSpawnedPerInterval: 8, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 40, pathAnimationConfiguration: easyConfig)
            
        }
        
    }
    
    static func getLevel3(difficultyLevel: DifficultyLevel) -> UFOScene{
        
        var scene: UFOScene
        
        let randomDistHard = GKRandomDistribution(lowestValue: 15, highestValue: 25)
        let randomDistMedium = GKRandomDistribution(lowestValue: 10, highestValue: 15)
        let randomDistEasy = GKRandomDistribution(lowestValue: 5, highestValue: 10)
        
        
        let hardConfig = PathAnimationConfiguration(d1: Double(randomDistHard.nextUniform()), d2: Double(randomDistHard.nextUniform()), d3: Double(randomDistHard.nextUniform()), d4: Double(randomDistHard.nextUniform()), d5: Double(randomDistHard.nextUniform()))
        
        let mediumConfig = PathAnimationConfiguration(d1: Double(randomDistMedium.nextUniform()), d2: Double(randomDistMedium.nextUniform()), d3: Double(randomDistMedium.nextUniform()), d4: Double(randomDistMedium.nextUniform()), d5: Double(randomDistMedium.nextUniform()))
        
        let easyConfig = PathAnimationConfiguration(d1: Double(randomDistEasy.nextUniform()), d2: Double(randomDistEasy.nextUniform()), d3: Double(randomDistEasy.nextUniform()), d4: Double(randomDistEasy.nextUniform()), d5: Double(randomDistEasy.nextUniform()))
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel3Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 5, minimumKilledForLevelCompletion: 20, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            
        case .Medium:
            return makeLevel3Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 3, maxUFOSpawnedPerInterval: 5, minimumKilledForLevelCompletion: 15, maximumAllowableUFOonScreen: 30, pathAnimationConfiguration: mediumConfig)
            
        case .Easy:
            return makeLevel3Scene(spawnInterval: 5.0, initialNumberOfUFOSpawned: 2, minUFOSpawnedPerInterval: 3, maxUFOSpawnedPerInterval: 5, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 40, pathAnimationConfiguration: easyConfig)
            
        }
        
    }
    
    static func getLevel2(difficultyLevel: DifficultyLevel) -> UFOScene{
        
        var scene: UFOScene
        
        let randomDistHard = GKRandomDistribution(lowestValue: 15, highestValue: 25)
        let randomDistMedium = GKRandomDistribution(lowestValue: 10, highestValue: 15)
        let randomDistEasy = GKRandomDistribution(lowestValue: 5, highestValue: 10)
        
        
        let hardConfig = PathAnimationConfiguration(d1: Double(randomDistHard.nextUniform()), d2: Double(randomDistHard.nextUniform()), d3: Double(randomDistHard.nextUniform()), d4: Double(randomDistHard.nextUniform()), d5: Double(randomDistHard.nextUniform()))
        
        let mediumConfig = PathAnimationConfiguration(d1: Double(randomDistMedium.nextUniform()), d2: Double(randomDistMedium.nextUniform()), d3: Double(randomDistMedium.nextUniform()), d4: Double(randomDistMedium.nextUniform()), d5: Double(randomDistMedium.nextUniform()))
        
        let easyConfig = PathAnimationConfiguration(d1: Double(randomDistEasy.nextUniform()), d2: Double(randomDistEasy.nextUniform()), d3: Double(randomDistEasy.nextUniform()), d4: Double(randomDistEasy.nextUniform()), d5: Double(randomDistEasy.nextUniform()))
        
        
        switch(difficultyLevel){
        case .Hard:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            
        case .Medium:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: mediumConfig)
            
        case .Easy:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: easyConfig)
            
        }
        
    }
    
    
    static func getLevel1(difficultyLevel: DifficultyLevel) -> UFOScene{
        
        var scene: UFOScene
        
        let randomDistHard = GKRandomDistribution(lowestValue: 0, highestValue: 3)
        let randomDistMedium = GKRandomDistribution(lowestValue: 0, highestValue: 3)
        let randomDistEasy = GKRandomDistribution(lowestValue: 0, highestValue: 3)

        
        let hardConfig = PathAnimationConfiguration(d1: Double(randomDistHard.nextUniform()), d2: Double(randomDistHard.nextUniform()), d3: Double(randomDistHard.nextUniform()), d4: Double(randomDistHard.nextUniform()), d5: Double(randomDistHard.nextUniform()))
        
        let mediumConfig = PathAnimationConfiguration(d1: Double(randomDistMedium.nextUniform()), d2: Double(randomDistMedium.nextUniform()), d3: Double(randomDistMedium.nextUniform()), d4: Double(randomDistMedium.nextUniform()), d5: Double(randomDistMedium.nextUniform()))
        
        let easyConfig = PathAnimationConfiguration(d1: Double(randomDistEasy.nextUniform()), d2: Double(randomDistEasy.nextUniform()), d3: Double(randomDistEasy.nextUniform()), d4: Double(randomDistEasy.nextUniform()), d5: Double(randomDistEasy.nextUniform()))
        
        switch(difficultyLevel){
            case .Hard:
                return makeLevel1Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            case .Medium:
                return makeLevel1Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: mediumConfig)
            case .Easy:
                return makeLevel1Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: easyConfig)
        }
        
    }
    
    
    
    static private func makeLevel5Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 5, levelDescription: "UFOreos make their last stand!!", enemyName: "UFOreo", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
    
    static private func makeLevel4Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 4, levelDescription: "UFOreos are spawning like crazy!!", enemyName: "UFOreo", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
    
    static private func makeLevel3Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 3, levelDescription: "UFOreos are spawning faster!!", enemyName: "UFOreo", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
    static private func makeLevel2Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 2, levelDescription: "UFOreo just got faster!!", enemyName: "UFOreo", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
    static private func makeLevel1Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the UFOreos!", enemyName: "UFOreo", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
}
