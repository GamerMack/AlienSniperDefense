//
//  Constants.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

//Debug Mode Flag
let kDebug = true


//UserOptions and Configuration Constants

/* NON-NAMESPACED GLOBAL CONSTANTS
 
    let kEasy = "Easy"
    let kMedium = "Medium"
    let kHard = "Hard"
 */




//Player Stats

/** GLOBAL CONSTANTS MAY BE USED INSTEAD OF STATIC CONSTANTS ON PLAYER STATS CLASS
    let kTotalKillCount = "TotalKillCount"
    let kTotalBulletsFired = "TotalBulletsFired"
    let kTotalTimeElapsed = "TotalTimeElapsed"
    let kTotalLevelsCompleted = "TotalLevelsCompleted"

    let kAverageLevelCompletionTime = "AverageLevelCompletionTime"
    let kShootingAccuracy = "ShootingAccuracy"
**/




//Node Names

class NodeNames{
    static let StartButton = "StartButton"
    static let PauseButton = "PauseButton"
    static let ResumeButton = "ResumeButton"
    static let RestartGameButton = "RestartGame"
    static let ReturnToMenuButton = "ReturnToMenu"
    static let GameOverButton = "GameOver"
    static let CrossHairLight = "CrossHairLight"
    static let UFOFieldNode = "UFOFieldNode"
    
    static let WingmanTrackButton = "WingmanTrack"
    static let BatTrackButton = "BatTrack"
    static let StealthShipTrackButton = "StealthShipTrack"
    static let FlyingAlienTrackButton = "FlyingAlienTrack"
    static let UFOTrackButton = "UFOTrack"

    
}

//ZPosition Constants

class ZPositionOrder{
    static let background = CGFloat(-12.0)
    static let hud = CGFloat(10.0)
}
