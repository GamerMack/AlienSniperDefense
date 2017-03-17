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
    private let defaults = UserDefaults.standard
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
    
    
    //MARK: Public retrieval methods for Full Game Stats
    func getTotalRunningTime() -> Double{
        return defaults.value(forKey: keyTotalRunningTime)! as! Double
    }
    
    func getTotalNumberOfBulletsFired() -> Int{
        return defaults.value(forKey: keyTotalNumberOfBulletsFired)! as! Int
    }
    
    func getTotalNumberOfKills() -> Int{
        return defaults.value(forKey: keyTotalNumberOfKills)! as! Int
    }
    
    //TODO: Also include Total Enemies Spawned
    
    //MARK: Public Saving Methods for Full Game Stats
    func saveTotalRunningTime(totalRunningTime: Double){
        defaults.set(totalRunningTime, forKey: keyTotalRunningTime)
        defaults.synchronize()
    }
    
    func saveTotalNumberOfBulletsFired(totalBulletsFired: Int){
        defaults.set(totalBulletsFired, forKey: keyTotalNumberOfBulletsFired)
        defaults.synchronize()
    }
    
    func saveTotalNumberOfKills(totalNumberOfKills: Int){
        defaults.set(totalNumberOfKills, forKey: keyTotalNumberOfKills)
        defaults.synchronize()
    }
    
    //TODO: Also include Total Enemies Spawned


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
    
    
    //MARK: ************** TRACK-LEVEL, PLAYER STAT KEYS (Namespaced-Level Keys)
    enum WingmanTrack{
        
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
