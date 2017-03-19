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
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            
        case .Medium:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: mediumConfig)
            
        case .Easy:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: easyConfig)
            
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
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: hardConfig)
            
        case .Medium:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: mediumConfig)
            
        case .Easy:
            return makeLevel2Scene(spawnInterval: 10.0, initialNumberOfUFOSpawned: 1, minUFOSpawnedPerInterval: 1, maxUFOSpawnedPerInterval: 3, minimumKilledForLevelCompletion: 10, maximumAllowableUFOonScreen: 20, pathAnimationConfiguration: easyConfig)
            
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
        
        let randomDistHard = GKRandomDistribution(lowestValue: 1, highestValue: 5)
        let randomDistMedium = GKRandomDistribution(lowestValue: 1, highestValue: 5)
        let randomDistEasy = GKRandomDistribution(lowestValue: 1, highestValue: 5)

        
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
    
    
    static private func makeLevel3Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 3, levelDescription: "The UFOs are spawning faster!!", enemyName: "UFO", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
    
    
    static private func makeLevel2Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 2, levelDescription: "The UFOs just got faster!!", enemyName: "UFO", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
    
    static private func makeLevel1Scene(spawnInterval: TimeInterval, initialNumberOfUFOSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKilledForLevelCompletion: Int, maximumAllowableUFOonScreen: Int, pathAnimationConfiguration: PathAnimationConfiguration) -> UFOScene{
        
        return UFOScene(size: ScreenSizeFloatConstants.ScreenSize.size, levelNumber: 1, levelDescription: "Shoot all the UFOs!", enemyName: "UFO", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 5, spawnInterval: spawnInterval, initialNumberOfEnemiesSpawned: initialNumberOfUFOSpawned, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, minimumKillsForLevelCompletion: minimumKilledForLevelCompletion, maximumAllowableSpawnedUFO: maximumAllowableUFOonScreen, pathAnimationConfiguration: pathAnimationConfiguration)
        
    }
    
}
