//
//  GameSettings.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
//
//  GameSettings.swift
//  BatInvasion
//
//  Created by Aleksander Makedonski on 3/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit




class GameSettings{
    
    static let sharedInstance = GameSettings()
    
    //MARK: *************** APP-WIDE PLAYER STAT KEYS
    
    //MARK: Private Class Constants
    let defaults = UserDefaults.standard
    private let keyFirstRun = "FirstRun"
    private let keyTotalRunningTime = "TotalRunningTime"
    private let keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
    private let keyTotalNumberOfKills = "TotalNumberOfKills"
    private let keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
    
  
    
    
    //MARK: Init
    init(){
        if (defaults.object(forKey: keyFirstRun) != nil){
            firstLaunch()
        }
    }
    
    //MARK: Private helper methods
    private func firstLaunch(){
        //Initialize Game-Wide, Player-State KEYS
        defaults.set(0.00, forKey: keyTotalRunningTime)
        defaults.set(0, forKey: keyTotalNumberOfBulletsFired)
        defaults.set(0, forKey: keyTotalNumberOfKills)
        defaults.set(0, forKey: keyTotalNumberOfSpawnedEnemies)
        
        defaults.set(GameSettings.DifficultyVALUES.valueEasy.rawValue, forKey: GameSettings.UserSettingKEYS.keyDifficultyLevel.rawValue )
        defaults.set(GameSettings.GamePlayModeVALUES.valueMinimumKills.rawValue, forKey: GameSettings.UserSettingKEYS.keyGamePlayMode.rawValue)
        
        //Initialize keys for WingmanTrack
        defaults.set(0.00, forKey: WingmanTrack.Level1.keyTotalNumberOfBulletsFired.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level1.keyTotalNumberOfKills.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue)
        defaults.set(0.00, forKey: WingmanTrack.Level1.keyTotalRunningTime.rawValue)

        defaults.set(0.00, forKey: WingmanTrack.Level2.keyTotalNumberOfBulletsFired.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level2.keyTotalNumberOfKills.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue)
        defaults.set(0.00, forKey: WingmanTrack.Level2.keyTotalRunningTime.rawValue)
        
        defaults.set(0.00, forKey: WingmanTrack.Level3.keyTotalNumberOfBulletsFired.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level3.keyTotalNumberOfKills.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue)
        defaults.set(0.00, forKey: WingmanTrack.Level3.keyTotalRunningTime.rawValue)

        defaults.set(0.00, forKey: WingmanTrack.Level4.keyTotalNumberOfBulletsFired.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level4.keyTotalNumberOfKills.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue)
        defaults.set(0.00, forKey: WingmanTrack.Level4.keyTotalRunningTime.rawValue)

        defaults.set(0.00, forKey: WingmanTrack.Level5.keyTotalNumberOfBulletsFired.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level5.keyTotalNumberOfKills.rawValue)
        defaults.set(0, forKey: WingmanTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue)
        defaults.set(0.00, forKey: WingmanTrack.Level5.keyTotalRunningTime.rawValue)

        //TODO: Initialize keys for BAT TRACK
        
        //TODO: Initialize keys for STEALTH SHIP Track
        
        //TODO: Initialize keys for UFO Track
        
        //TODO: Initialize keys for FLYING ALIENS Track
        
        defaults.setValue(false, forKey: keyFirstRun)
        
        defaults.synchronize()
    }
    
    
    
    
    //MARK: Public Method for Game-Wide Settings
    
    func setGamePlayMode(gamePlayMode: GameSettings.GamePlayModeVALUES){
        switch(gamePlayMode){
        case .valueMinimumKills:
            defaults.set(GameSettings.GamePlayModeVALUES.valueMinimumKills.rawValue, forKey: GameSettings.UserSettingKEYS.keyGamePlayMode.rawValue)
            break
        case .valueTimeLimit:
            defaults.set(GameSettings.GamePlayModeVALUES.valueTimeLimit.rawValue, forKey: GameSettings.UserSettingKEYS.keyGamePlayMode.rawValue)
            break
        }
        
        defaults.synchronize()
    }
    
    func setGameDifficultyLevel(difficulty: GameSettings.DifficultyVALUES){
        switch(difficulty){
        case .valueHard:
            defaults.set(GameSettings.DifficultyVALUES.valueHard.rawValue, forKey: GameSettings.UserSettingKEYS.keyDifficultyLevel.rawValue)
            break
        case .valueMedium:
            defaults.set(GameSettings.DifficultyVALUES.valueMedium.rawValue, forKey: GameSettings.UserSettingKEYS.keyDifficultyLevel.rawValue)
            break
        case .valueEasy:
            defaults.set(GameSettings.DifficultyVALUES.valueEasy.rawValue, forKey: GameSettings.UserSettingKEYS.keyDifficultyLevel.rawValue)
            break
        }
        
        defaults.synchronize()
    }
    
    //MARK: Public Retrieval Methods for Game-Wide Settings
    func getGamePlayMode() -> GameSettings.GamePlayModeVALUES{
        
        let gamePlayMode = defaults.value(forKey: GameSettings.UserSettingKEYS.keyGamePlayMode.rawValue) as! String
        
        return GameSettings.GamePlayModeVALUES(rawValue: gamePlayMode)!
        
        
    }
    
    
    func getGameDifficulty() -> GameSettings.DifficultyVALUES{
        
        let difficulty = defaults.value(forKey: GameSettings.UserSettingKEYS.keyDifficultyLevel.rawValue) as! String
        
        return GameSettings.DifficultyVALUES(rawValue: difficulty)!
    }
    
    
   

}



extension GameSettings{
    
    
    //MARK:**************** APP-WIDE SETTING KEYS and VALUES
    
    //MARK: User-Setting KEYS
    enum UserSettingKEYS: String{
        case keyDifficultyLevel = "DifficultyLevel"
        case keyGamePlayMode = "GamePlayMode"
    }
    
    //MARK: User-Setting VALUES (Namespaced-GamePlay Mode Settings)
    enum GamePlayModeVALUES: String{
        case valueMinimumKills = "MinimumKills"
        case valueTimeLimit = "TimeLimit"
    }
    
    //MARK: User-Setting VALUES (Namespaced-Difficulty Settings)
    enum DifficultyVALUES: String{
        case valueHard = "Hard"
        case valueMedium = "Medium"
        case valueEasy = "Easy"
    }
    
    //MARK: TrackType
    enum TrackType{
        case Wingman, UFO, StealthShips, Bat, FlyingAlien
    }

    
    //MARK: Level Number
    enum Level{
        case Level1, Level2, Level3, Level4, Level5
    }
    
    //MARK:  Typealias for a tuple specifying track and level information
    typealias LevelTuple = (trackName: TrackType, levelNumber: Level)
    
    
    //MARK: Public retrieval methods for Full Game Stats
    func getTotalRunningTime(levelTuple: LevelTuple) -> Double{
        
        switch(levelTuple){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            return defaults.value(forKey: WingmanTrack.Level1.keyTotalRunningTime.rawValue) as! Double
        case (.Wingman, .Level2):
             return defaults.value(forKey: WingmanTrack.Level2.keyTotalRunningTime.rawValue) as! Double
        case (.Wingman, .Level3):
             return defaults.value(forKey: WingmanTrack.Level3.keyTotalRunningTime.rawValue) as! Double
        case (.Wingman, .Level4):
             return defaults.value(forKey: WingmanTrack.Level4.keyTotalRunningTime.rawValue) as! Double
        case (.Wingman, .Level5):
            return defaults.value(forKey: WingmanTrack.Level5.keyTotalRunningTime.rawValue) as! Double
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
             return defaults.value(forKey: BatTrack.Level1.keyTotalRunningTime.rawValue) as! Double
        case (.Bat, .Level2):
            return defaults.value(forKey: BatTrack.Level2.keyTotalRunningTime.rawValue) as! Double
        case (.Bat, .Level3):
            return defaults.value(forKey: BatTrack.Level3.keyTotalRunningTime.rawValue) as! Double
        case (.Bat, .Level4):
            return defaults.value(forKey: BatTrack.Level4.keyTotalRunningTime.rawValue) as! Double
        case (.Bat, .Level5):
            return defaults.value(forKey: BatTrack.Level5.keyTotalRunningTime.rawValue) as! Double
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            return defaults.value(forKey: UFOTrack.Level1.keyTotalRunningTime.rawValue) as! Double
        case (.UFO, .Level2):
            return defaults.value(forKey: UFOTrack.Level2.keyTotalRunningTime.rawValue) as! Double
        case (.UFO, .Level3):
            return defaults.value(forKey: UFOTrack.Level3.keyTotalRunningTime.rawValue) as! Double
        case (.UFO, .Level4):
            return defaults.value(forKey: UFOTrack.Level4.keyTotalRunningTime.rawValue) as! Double
        case (.UFO, .Level5):
            return defaults.value(forKey: UFOTrack.Level5.keyTotalRunningTime.rawValue) as! Double
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            return defaults.value(forKey: FlyingAlienTrack.Level1.keyTotalRunningTime.rawValue) as! Double
        case (.FlyingAlien, .Level2):
            return defaults.value(forKey: FlyingAlienTrack.Level2.keyTotalRunningTime.rawValue) as! Double
        case (.FlyingAlien, .Level3):
            return defaults.value(forKey: FlyingAlienTrack.Level3.keyTotalRunningTime.rawValue) as! Double
        case (.FlyingAlien, .Level4):
            return defaults.value(forKey: FlyingAlienTrack.Level4.keyTotalRunningTime.rawValue) as! Double
        case (.FlyingAlien, .Level5):
            return defaults.value(forKey: FlyingAlienTrack.Level5.keyTotalRunningTime.rawValue) as! Double
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            return defaults.value(forKey: StealthShipTrack.Level1.keyTotalRunningTime.rawValue) as! Double
            
        case (.StealthShips, .Level2):
            return defaults.value(forKey: StealthShipTrack.Level2.keyTotalRunningTime.rawValue) as! Double
            
        case (.StealthShips, .Level3):
            return defaults.value(forKey: StealthShipTrack.Level3.keyTotalRunningTime.rawValue) as! Double
            
        case (.StealthShips, .Level4):
            return defaults.value(forKey: StealthShipTrack.Level4.keyTotalRunningTime.rawValue) as! Double
            
        case (.StealthShips, .Level5):
            return defaults.value(forKey: StealthShipTrack.Level5.keyTotalRunningTime.rawValue) as! Double
            
        }

    }
    
    func getTotalNumberOfBulletsFired(levelTuple: LevelTuple) -> Int{
        
        switch(levelTuple){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            return defaults.value(forKey: WingmanTrack.Level1.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Wingman, .Level2):
            return defaults.value(forKey: WingmanTrack.Level2.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Wingman, .Level3):
            return defaults.value(forKey: WingmanTrack.Level3.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Wingman, .Level4):
            return defaults.value(forKey: WingmanTrack.Level4.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Wingman, .Level5):
            return defaults.value(forKey: WingmanTrack.Level5.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
            return defaults.value(forKey: BatTrack.Level1.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Bat, .Level2):
            return defaults.value(forKey: BatTrack.Level2.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Bat, .Level3):
            return defaults.value(forKey: BatTrack.Level3.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Bat, .Level4):
            return defaults.value(forKey: BatTrack.Level4.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.Bat, .Level5):
            return defaults.value(forKey: BatTrack.Level5.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            return defaults.value(forKey: UFOTrack.Level1.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.UFO, .Level2):
            return defaults.value(forKey: UFOTrack.Level2.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.UFO, .Level3):
            return defaults.value(forKey: UFOTrack.Level3.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.UFO, .Level4):
            return defaults.value(forKey: UFOTrack.Level4.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.UFO, .Level5):
            return defaults.value(forKey: UFOTrack.Level5.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            return defaults.value(forKey: FlyingAlienTrack.Level1.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.FlyingAlien, .Level2):
            return defaults.value(forKey: FlyingAlienTrack.Level2.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.FlyingAlien, .Level3):
            return defaults.value(forKey: FlyingAlienTrack.Level3.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.FlyingAlien, .Level4):
            return defaults.value(forKey: FlyingAlienTrack.Level4.keyTotalNumberOfBulletsFired.rawValue) as! Int
        case (.FlyingAlien, .Level5):
            return defaults.value(forKey: FlyingAlienTrack.Level5.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            return defaults.value(forKey: StealthShipTrack.Level1.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        case (.StealthShips, .Level2):
            return defaults.value(forKey: StealthShipTrack.Level2.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        case (.StealthShips, .Level3):
            return defaults.value(forKey: StealthShipTrack.Level3.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        case (.StealthShips, .Level4):
            return defaults.value(forKey: StealthShipTrack.Level4.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        case (.StealthShips, .Level5):
            return defaults.value(forKey: StealthShipTrack.Level5.keyTotalNumberOfBulletsFired.rawValue) as! Int
            
        }

    }
    
    func getTotalNumberOfKills(levelTuple: LevelTuple) -> Int{
        
        switch(levelTuple){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            return defaults.value(forKey: WingmanTrack.Level1.keyTotalNumberOfKills.rawValue) as! Int
        case (.Wingman, .Level2):
            return defaults.value(forKey: WingmanTrack.Level2.keyTotalNumberOfKills.rawValue) as! Int
        case (.Wingman, .Level3):
            return defaults.value(forKey: WingmanTrack.Level3.keyTotalNumberOfKills.rawValue) as! Int
        case (.Wingman, .Level4):
            return defaults.value(forKey: WingmanTrack.Level4.keyTotalNumberOfKills.rawValue) as! Int
        case (.Wingman, .Level5):
            return defaults.value(forKey: WingmanTrack.Level5.keyTotalNumberOfKills.rawValue) as! Int
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
            return defaults.value(forKey: BatTrack.Level1.keyTotalNumberOfKills.rawValue) as! Int
        case (.Bat, .Level2):
            return defaults.value(forKey: BatTrack.Level2.keyTotalNumberOfKills.rawValue) as! Int
        case (.Bat, .Level3):
            return defaults.value(forKey: BatTrack.Level3.keyTotalNumberOfKills.rawValue) as! Int
        case (.Bat, .Level4):
            return defaults.value(forKey: BatTrack.Level4.keyTotalNumberOfKills.rawValue) as! Int
        case (.Bat, .Level5):
            return defaults.value(forKey: BatTrack.Level5.keyTotalNumberOfKills.rawValue) as! Int
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            return defaults.value(forKey: UFOTrack.Level1.keyTotalNumberOfKills.rawValue) as! Int
        case (.UFO, .Level2):
            return defaults.value(forKey: UFOTrack.Level2.keyTotalNumberOfKills.rawValue) as! Int
        case (.UFO, .Level3):
            return defaults.value(forKey: UFOTrack.Level3.keyTotalNumberOfKills.rawValue) as! Int
        case (.UFO, .Level4):
            return defaults.value(forKey: UFOTrack.Level4.keyTotalNumberOfKills.rawValue) as! Int
        case (.UFO, .Level5):
            return defaults.value(forKey: UFOTrack.Level5.keyTotalNumberOfKills.rawValue) as! Int
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            return defaults.value(forKey: FlyingAlienTrack.Level1.keyTotalNumberOfKills.rawValue) as! Int
        case (.FlyingAlien, .Level2):
            return defaults.value(forKey: FlyingAlienTrack.Level2.keyTotalNumberOfKills.rawValue) as! Int
        case (.FlyingAlien, .Level3):
            return defaults.value(forKey: FlyingAlienTrack.Level3.keyTotalNumberOfKills.rawValue) as! Int
        case (.FlyingAlien, .Level4):
            return defaults.value(forKey: FlyingAlienTrack.Level4.keyTotalNumberOfKills.rawValue) as! Int
        case (.FlyingAlien, .Level5):
            return defaults.value(forKey: FlyingAlienTrack.Level5.keyTotalNumberOfKills.rawValue) as! Int
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            return defaults.value(forKey: StealthShipTrack.Level1.keyTotalNumberOfKills.rawValue) as! Int
            
        case (.StealthShips, .Level2):
            return defaults.value(forKey: StealthShipTrack.Level2.keyTotalNumberOfKills.rawValue) as! Int
            
        case (.StealthShips, .Level3):
            return defaults.value(forKey: StealthShipTrack.Level3.keyTotalNumberOfKills.rawValue) as! Int
            
        case (.StealthShips, .Level4):
            return defaults.value(forKey: StealthShipTrack.Level4.keyTotalNumberOfKills.rawValue) as! Int
            
        case (.StealthShips, .Level5):
            return defaults.value(forKey: StealthShipTrack.Level5.keyTotalNumberOfKills.rawValue) as! Int
            
        }

    }
    
    func getTotalNumberOfEnemiesSpawned(levelTuple: LevelTuple) -> Int{
        
        switch(levelTuple){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            return defaults.value(forKey: WingmanTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Wingman, .Level2):
            return defaults.value(forKey: WingmanTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Wingman, .Level3):
            return defaults.value(forKey: WingmanTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Wingman, .Level4):
            return defaults.value(forKey: WingmanTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Wingman, .Level5):
            return defaults.value(forKey: WingmanTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
            return defaults.value(forKey: BatTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Bat, .Level2):
            return defaults.value(forKey: BatTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Bat, .Level3):
            return defaults.value(forKey: BatTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Bat, .Level4):
            return defaults.value(forKey: BatTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.Bat, .Level5):
            return defaults.value(forKey: BatTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            return defaults.value(forKey: UFOTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.UFO, .Level2):
            return defaults.value(forKey: UFOTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.UFO, .Level3):
            return defaults.value(forKey: UFOTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.UFO, .Level4):
            return defaults.value(forKey: UFOTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.UFO, .Level5):
            return defaults.value(forKey: UFOTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            return defaults.value(forKey: FlyingAlienTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.FlyingAlien, .Level2):
            return defaults.value(forKey: FlyingAlienTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.FlyingAlien, .Level3):
            return defaults.value(forKey: FlyingAlienTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.FlyingAlien, .Level4):
            return defaults.value(forKey: FlyingAlienTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
        case (.FlyingAlien, .Level5):
            return defaults.value(forKey: FlyingAlienTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            return defaults.value(forKey: StealthShipTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        case (.StealthShips, .Level2):
            return defaults.value(forKey: StealthShipTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        case (.StealthShips, .Level3):
            return defaults.value(forKey: StealthShipTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        case (.StealthShips, .Level4):
            return defaults.value(forKey: StealthShipTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        case (.StealthShips, .Level5):
            return defaults.value(forKey: StealthShipTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue) as! Int
            
        }
        
    }
    
    
    //MARK: Public Saving Methods for Individual Levels
    func saveTotalRunningTime(totalRunningTime: Double, levelInfo: LevelTuple){
        
        switch(levelInfo){
            //Save running time for Wingman levels
            case (.Wingman, .Level1):
                defaults.set(totalRunningTime, forKey: WingmanTrack.Level1.keyTotalRunningTime.rawValue)
                break
            case (.Wingman, .Level2):
                defaults.set(totalRunningTime, forKey: WingmanTrack.Level2.keyTotalRunningTime.rawValue)
                break
            case (.Wingman, .Level3):
                defaults.set(totalRunningTime, forKey: WingmanTrack.Level3.keyTotalRunningTime.rawValue)
                break
            case (.Wingman, .Level4):
                defaults.set(totalRunningTime, forKey: WingmanTrack.Level4.keyTotalRunningTime.rawValue)
                break
            case (.Wingman, .Level5):
                defaults.set(totalRunningTime, forKey: WingmanTrack.Level5.keyTotalRunningTime.rawValue)
                break
            
            //Save running time for BatTrack Levels
            case (.Bat, .Level1):
                defaults.set(totalRunningTime, forKey: BatTrack.Level1.keyTotalRunningTime.rawValue)
                break
            case (.Bat, .Level2):
                defaults.set(totalRunningTime, forKey: BatTrack.Level2.keyTotalRunningTime.rawValue)
                break
            case (.Bat, .Level3):
                defaults.set(totalRunningTime, forKey: BatTrack.Level3.keyTotalRunningTime.rawValue)
                break
            case (.Bat, .Level4):
                defaults.set(totalRunningTime, forKey: BatTrack.Level4.keyTotalRunningTime.rawValue)
                break
            case (.Bat, .Level5):
                defaults.set(totalRunningTime, forKey: BatTrack.Level5.keyTotalRunningTime.rawValue)
                break
            
            //Save running time data for UFO Levels
            case (.UFO, .Level1):
                defaults.set(totalRunningTime, forKey: UFOTrack.Level1.keyTotalRunningTime.rawValue)
                break
            case (.UFO, .Level2):
                defaults.set(totalRunningTime, forKey: UFOTrack.Level2.keyTotalRunningTime.rawValue)
                break
            case (.UFO, .Level3):
                defaults.set(totalRunningTime, forKey: UFOTrack.Level3.keyTotalRunningTime.rawValue)
                break
            case (.UFO, .Level4):
                defaults.set(totalRunningTime, forKey: UFOTrack.Level4.keyTotalRunningTime.rawValue)
                break
            case (.UFO, .Level5):
                defaults.set(totalRunningTime, forKey: UFOTrack.Level5.keyTotalRunningTime.rawValue)
                break
            
            //Save running time data for FlyingAlien Levels
            case (.FlyingAlien, .Level1):
                defaults.set(totalRunningTime, forKey: FlyingAlienTrack.Level1.keyTotalRunningTime.rawValue)
                break
            case (.FlyingAlien, .Level2):
              defaults.set(totalRunningTime, forKey: FlyingAlienTrack.Level2.keyTotalRunningTime.rawValue)
                break
            case (.FlyingAlien, .Level3):
              defaults.set(totalRunningTime, forKey: FlyingAlienTrack.Level3.keyTotalRunningTime.rawValue)
                break
            case (.FlyingAlien, .Level4):
              defaults.set(totalRunningTime, forKey: FlyingAlienTrack.Level4.keyTotalRunningTime.rawValue)
                break
            case (.FlyingAlien, .Level5):
              defaults.set(totalRunningTime, forKey: FlyingAlienTrack.Level5.keyTotalRunningTime.rawValue)
                break
            
            
            //Save  running time data for StealthShip levels
            case (.StealthShips, .Level1):
                defaults.set(totalRunningTime, forKey: StealthShipTrack.Level1.keyTotalRunningTime.rawValue)
                break
            case (.StealthShips, .Level2):
                defaults.set(totalRunningTime, forKey: StealthShipTrack.Level2.keyTotalRunningTime.rawValue)
                break
            case (.StealthShips, .Level3):
                defaults.set(totalRunningTime, forKey: StealthShipTrack.Level3.keyTotalRunningTime.rawValue)
                break
            case (.StealthShips, .Level4):
                defaults.set(totalRunningTime, forKey: StealthShipTrack.Level4.keyTotalRunningTime.rawValue)
                break
            case (.StealthShips, .Level5):
                defaults.set(totalRunningTime, forKey: StealthShipTrack.Level5.keyTotalRunningTime.rawValue)
                break
        }
        
        defaults.synchronize()
    }
    
    func saveTotalNumberOfKills(totalKills: Int, levelInfo: LevelTuple){
        
        switch(levelInfo){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            defaults.set(totalKills, forKey: WingmanTrack.Level1.keyTotalNumberOfKills.rawValue)
            break
        case (.Wingman, .Level2):
            defaults.set(totalKills, forKey: WingmanTrack.Level2.keyTotalNumberOfKills.rawValue)
            break
        case (.Wingman, .Level3):
            defaults.set(totalKills, forKey: WingmanTrack.Level3.keyTotalNumberOfKills.rawValue)
            break
        case (.Wingman, .Level4):
            defaults.set(totalKills, forKey: WingmanTrack.Level4.keyTotalNumberOfKills.rawValue)
            break
        case (.Wingman, .Level5):
            defaults.set(totalKills, forKey: WingmanTrack.Level5.keyTotalNumberOfKills.rawValue)
            break
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
            defaults.set(totalKills, forKey: BatTrack.Level1.keyTotalNumberOfKills.rawValue)
            break
        case (.Bat, .Level2):
            defaults.set(totalKills, forKey: BatTrack.Level2.keyTotalNumberOfKills.rawValue)
            break
        case (.Bat, .Level3):
            defaults.set(totalKills, forKey: BatTrack.Level3.keyTotalNumberOfKills.rawValue)
            break
        case (.Bat, .Level4):
            defaults.set(totalKills, forKey: BatTrack.Level4.keyTotalNumberOfKills.rawValue)
            break
        case (.Bat, .Level5):
            defaults.set(totalKills, forKey: BatTrack.Level5.keyTotalNumberOfKills.rawValue)
            break
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            defaults.set(totalKills, forKey: UFOTrack.Level1.keyTotalNumberOfKills.rawValue)
            break
        case (.UFO, .Level2):
            defaults.set(totalKills, forKey: UFOTrack.Level2.keyTotalNumberOfKills.rawValue)
            break
        case (.UFO, .Level3):
            defaults.set(totalKills, forKey: UFOTrack.Level3.keyTotalNumberOfKills.rawValue)
            break
        case (.UFO, .Level4):
            defaults.set(totalKills, forKey: UFOTrack.Level4.keyTotalNumberOfKills.rawValue)
            break
        case (.UFO, .Level5):
            defaults.set(totalKills, forKey: UFOTrack.Level5.keyTotalNumberOfKills.rawValue)
            break
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            defaults.set(totalKills, forKey: FlyingAlienTrack.Level1.keyTotalNumberOfKills.rawValue)
            break
        case (.FlyingAlien, .Level2):
            defaults.set(totalKills, forKey: FlyingAlienTrack.Level2.keyTotalNumberOfKills.rawValue)
            break
        case (.FlyingAlien, .Level3):
            defaults.set(totalKills, forKey: FlyingAlienTrack.Level3.keyTotalNumberOfKills.rawValue)
            break
        case (.FlyingAlien, .Level4):
            defaults.set(totalKills, forKey: FlyingAlienTrack.Level4.keyTotalNumberOfKills.rawValue)
            break
        case (.FlyingAlien, .Level5):
            defaults.set(totalKills, forKey: FlyingAlienTrack.Level5.keyTotalNumberOfKills.rawValue)
            break
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            defaults.set(totalKills, forKey: StealthShipTrack.Level1.keyTotalNumberOfKills.rawValue)
            break
        case (.StealthShips, .Level2):
            defaults.set(totalKills, forKey: StealthShipTrack.Level2.keyTotalNumberOfKills.rawValue)
            break
        case (.StealthShips, .Level3):
            defaults.set(totalKills, forKey: StealthShipTrack.Level3.keyTotalNumberOfKills.rawValue)
            break
        case (.StealthShips, .Level4):
            defaults.set(totalKills, forKey: StealthShipTrack.Level4.keyTotalNumberOfKills.rawValue)
            break
        case (.StealthShips, .Level5):
            defaults.set(totalKills, forKey: StealthShipTrack.Level5.keyTotalNumberOfKills.rawValue)
            break
        }
        
        defaults.synchronize()
    }
    
    func saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: Int, levelInfo: LevelTuple){
        
        switch(levelInfo){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            defaults.set(totalSpawnedEnemies, forKey: WingmanTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Wingman, .Level2):
            defaults.set(totalSpawnedEnemies, forKey: WingmanTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Wingman, .Level3):
            defaults.set(totalSpawnedEnemies, forKey: WingmanTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Wingman, .Level4):
            defaults.set(totalSpawnedEnemies, forKey: WingmanTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Wingman, .Level5):
            defaults.set(totalSpawnedEnemies, forKey: WingmanTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
            defaults.set(totalSpawnedEnemies, forKey: BatTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Bat, .Level2):
            defaults.set(totalSpawnedEnemies, forKey: BatTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Bat, .Level3):
            defaults.set(totalSpawnedEnemies, forKey: BatTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Bat, .Level4):
            defaults.set(totalSpawnedEnemies, forKey: BatTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.Bat, .Level5):
            defaults.set(totalSpawnedEnemies, forKey: BatTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            defaults.set(totalSpawnedEnemies, forKey: UFOTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.UFO, .Level2):
            defaults.set(totalSpawnedEnemies, forKey: UFOTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.UFO, .Level3):
            defaults.set(totalSpawnedEnemies, forKey: UFOTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.UFO, .Level4):
            defaults.set(totalSpawnedEnemies, forKey: UFOTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.UFO, .Level5):
            defaults.set(totalSpawnedEnemies, forKey: UFOTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            defaults.set(totalSpawnedEnemies, forKey: FlyingAlienTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.FlyingAlien, .Level2):
            defaults.set(totalSpawnedEnemies, forKey: FlyingAlienTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.FlyingAlien, .Level3):
            defaults.set(totalSpawnedEnemies, forKey: FlyingAlienTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.FlyingAlien, .Level4):
            defaults.set(totalSpawnedEnemies, forKey: FlyingAlienTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.FlyingAlien, .Level5):
            defaults.set(totalSpawnedEnemies, forKey: FlyingAlienTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            defaults.set(totalSpawnedEnemies, forKey: StealthShipTrack.Level1.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.StealthShips, .Level2):
            defaults.set(totalSpawnedEnemies, forKey: StealthShipTrack.Level2.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.StealthShips, .Level3):
            defaults.set(totalSpawnedEnemies, forKey: StealthShipTrack.Level3.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.StealthShips, .Level4):
            defaults.set(totalSpawnedEnemies, forKey: StealthShipTrack.Level4.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        case (.StealthShips, .Level5):
            defaults.set(totalSpawnedEnemies, forKey: StealthShipTrack.Level5.keyTotalNumberOfSpawnedEnemies.rawValue)
            break
        }
        
        defaults.synchronize()
    }
    
    func saveTotalNumberOfBulletsFired(totalBulletsFired: Int, levelInfo: LevelTuple){
        
        switch(levelInfo){
        //Save running time for Wingman levels
        case (.Wingman, .Level1):
            defaults.set(totalBulletsFired, forKey: WingmanTrack.Level1.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Wingman, .Level2):
            defaults.set(totalBulletsFired, forKey: WingmanTrack.Level2.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Wingman, .Level3):
            defaults.set(totalBulletsFired, forKey: WingmanTrack.Level3.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Wingman, .Level4):
            defaults.set(totalBulletsFired, forKey: WingmanTrack.Level4.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Wingman, .Level5):
            defaults.set(totalBulletsFired, forKey: WingmanTrack.Level5.keyTotalNumberOfBulletsFired.rawValue)
            break
            
        //Save running time for BatTrack Levels
        case (.Bat, .Level1):
            defaults.set(totalBulletsFired, forKey: BatTrack.Level1.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Bat, .Level2):
            defaults.set(totalBulletsFired, forKey: BatTrack.Level2.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Bat, .Level3):
            defaults.set(totalBulletsFired, forKey: BatTrack.Level3.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Bat, .Level4):
            defaults.set(totalBulletsFired, forKey: BatTrack.Level4.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.Bat, .Level5):
            defaults.set(totalBulletsFired, forKey: BatTrack.Level5.keyTotalNumberOfBulletsFired.rawValue)
            break
            
        //Save running time data for UFO Levels
        case (.UFO, .Level1):
            defaults.set(totalBulletsFired, forKey: UFOTrack.Level1.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.UFO, .Level2):
            defaults.set(totalBulletsFired, forKey: UFOTrack.Level2.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.UFO, .Level3):
            defaults.set(totalBulletsFired, forKey: UFOTrack.Level3.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.UFO, .Level4):
            defaults.set(totalBulletsFired, forKey: UFOTrack.Level4.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.UFO, .Level5):
            defaults.set(totalBulletsFired, forKey: UFOTrack.Level5.keyTotalNumberOfBulletsFired.rawValue)
            break
            
        //Save running time data for FlyingAlien Levels
        case (.FlyingAlien, .Level1):
            defaults.set(totalBulletsFired, forKey: FlyingAlienTrack.Level1.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.FlyingAlien, .Level2):
            defaults.set(totalBulletsFired, forKey: FlyingAlienTrack.Level2.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.FlyingAlien, .Level3):
            defaults.set(totalBulletsFired, forKey: FlyingAlienTrack.Level3.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.FlyingAlien, .Level4):
            defaults.set(totalBulletsFired, forKey: FlyingAlienTrack.Level4.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.FlyingAlien, .Level5):
            defaults.set(totalBulletsFired, forKey: FlyingAlienTrack.Level5.keyTotalNumberOfBulletsFired.rawValue)
            break
            
            
        //Save  running time data for StealthShip levels
        case (.StealthShips, .Level1):
            defaults.set(totalBulletsFired, forKey: StealthShipTrack.Level1.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.StealthShips, .Level2):
            defaults.set(totalBulletsFired, forKey: StealthShipTrack.Level2.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.StealthShips, .Level3):
            defaults.set(totalBulletsFired, forKey: StealthShipTrack.Level3.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.StealthShips, .Level4):
            defaults.set(totalBulletsFired, forKey: StealthShipTrack.Level4.keyTotalNumberOfBulletsFired.rawValue)
            break
        case (.StealthShips, .Level5):
            defaults.set(totalBulletsFired, forKey: StealthShipTrack.Level5.keyTotalNumberOfBulletsFired.rawValue)
            break
        }
        
        defaults.synchronize()
    }


    
    //MARK: ************** TRACK-LEVEL, PLAYER STAT KEYS (Namespaced-Level Keys)
    enum WingmanTrack{
        
        enum Level1: String{
            case keyTotalRunningTime = "WingmanLevel1TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "WingmanLevel1TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "WingmanLevel1TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "WingmanLevel1TotalNumberOfSpawnedEnemies"
        }
        
        enum Level2: String{
            case keyTotalRunningTime = "WingmanLevel2TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "WingmanLevel2TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "WingmanLevel2TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "WingmanLevel2TotalNumberOfSpawnedEnemies"
        }
        
        enum Level3: String{
            case keyTotalRunningTime = "WingmanLevel3TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "WingmanLevel3TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "WingmanLevel3TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "WingmanLevel3TotalNumberOfSpawnedEnemies"
        }
        
        enum Level4: String{
            case keyTotalRunningTime = "WingmanLevel4TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "WingmanLevel4TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "WingmanLevel4TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "WingmanLevel4TotalNumberOfSpawnedEnemies"
        }
        
        enum Level5: String{
            case keyTotalRunningTime = "WingmanLevel5TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "WingmanLevel5TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "WingmanLevel5TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "WingmanLevel5TotalNumberOfSpawnedEnemies"
        }
    }
    
    enum UFOTrack{
        
        enum Level1: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level2: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level3: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level4: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level5: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
    }
    
    enum StealthShipTrack{
        
        enum Level1: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level2: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level3: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level4: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level5: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
    }
    
    enum BatTrack{
        
        enum Level1: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level2: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level3: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level4: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level5: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
    }
    
    enum FlyingAlienTrack{
        
        enum Level1: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level2: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level3: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level4: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
        
        enum Level5: String{
            case keyTotalRunningTime = "TotalRunningTime"
            case keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
            case keyTotalNumberOfKills = "TotalNumberOfKills"
            case keyTotalNumberOfSpawnedEnemies = "TotalNumberOfSpawnedEnemies"
        }
    }
    
}
