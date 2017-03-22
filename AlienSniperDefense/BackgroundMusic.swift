//
//  BackgroundMusic.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/13/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

//Background Audio Track Titles
let kGermanVirtue = "German Virtue.mp3"
let kInfiniteDescent = "Infinite Descent.mp3"
let kItalianMom = "Italian Mom.mp3"
let kMishiefStroll = "Mishief Stroll.mp3"
let kMissionPlausible = "Mission Plausible.mp3"
let kCheerfulAnnoyance = "Cheerful Annoyance.mp3"
let kDrummingSticks = "Drumming Sticks.mp3"
let kFarmFrolics = "Farm Frolics.mp3"
let kFlowingRocks = "Flowing Rocks.mp3"
let kAlphaDance = "Alpha Dance.mp3"
let kNightAtTheBeach = "Night at the Beach.mp3"
let kGameOver = "Game Over.mp3"
let kPolkaTrain = "Polka Train.mp3"

class BackgroundMusic{
    static let PolkaTrain = kPolkaTrain
    static let NightAtTheBeach = kNightAtTheBeach
    static let AlphaDance = kAlphaDance
    static let GermanVirtue = kGermanVirtue
    static let InfiniteDescent = kInfiniteDescent
    static let ItalianMom = kItalianMom
    static let MishiefStroll = kMishiefStroll
    static let MissionPlausible = kMissionPlausible
    static let CheerfulAnnoyance = kCheerfulAnnoyance
    static let DrummingSticks = kDrummingSticks
    static let FarmFrolics = kFarmFrolics
    static let FlowingRocks = kFlowingRocks
    static let GameOver = kGameOver
    
    
    //Configure background music
    static func configureBackgroundMusicFrom(fileNamed fileName: String, forParentNode parentNode: SKNode){
        
        let bg = SKAudioNode(fileNamed: fileName)
        bg.autoplayLooped = true
        parentNode.addChild(bg)
        
    }
    
}
