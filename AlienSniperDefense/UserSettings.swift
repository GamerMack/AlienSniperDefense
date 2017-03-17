//
//  UserSettings.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


class UserSettings{
    
    static let ValidDifficultyLevels = [
        DifficultyLevel.Easy,
        DifficultyLevel.Medium,
        DifficultyLevel.Hard
    ]
    
    static let ValidGamePlayModes = [
        GamePlayMode.MinimumKills,
        GamePlayMode.TimeLimit
    ]
    
    class GamePlayMode{
        static let MinimumKills = "MinimumKills"
        static let TimeLimit = "TimeLimit"
    }
    
    class DifficultyLevel{
        static let Easy = "Easy"
        static let Medium = "Medium"
        static let Hard = "Hard"
    }
}
