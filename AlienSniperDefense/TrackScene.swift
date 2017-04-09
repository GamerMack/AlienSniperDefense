//
//  TrackScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class TrackScene: SKScene{
    
    //MARK: ************ Cache for Button clicks
    let clickSound = SKAction.playSoundFileNamed(SoundEffects.Click1, waitForCompletion: false)
    
    //MARK: ********* Track Type Enum
    enum TrackType{
        case Wingman, Bat, FlyingAlien, StealthShip, UFO
    }
    
    let gameSettings = GameSettings.sharedInstance
    
    override func didMove(to view: SKView) {
        //Add observer for PresentAuthenticationViewController notification
        /** FUTURE VERSIONS
         
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(GameViewController.showAuthenticationViewController), name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
       **/
        
        //Configure Background Musics
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.FarmFrolics, forParentNode: self)
        
        //Configure background
        configureBackground()
        
        
     
        self.anchorPoint = CGPoint(x: 0, y: 0.4)
        
        let sceneTitle = SKLabelNode(fontNamed: FontTypes.MarkerFeltWie)
        sceneTitle.fontSize = 40.0
        sceneTitle.text = NSLocalizedString("Click on a level track below:", comment: "")
        let sceneTitleYPos = ScreenSizeFloatConstants.HalfScreenHeight*0.9
        let sceneTitleXPos = ScreenSizeFloatConstants.HalfScreenWidth
        sceneTitle.position = CGPoint(x: sceneTitleXPos, y: sceneTitleYPos)
        self.addChild(sceneTitle)
        
        
        let numberOfTracks = 5
        
        for index in 0..<numberOfTracks{
            
            let horizontalOffset = ScreenSizeFloatConstants.ScreenWidth*0.04
            let xStartPos = (self.size.width/CGFloat(numberOfTracks))/2 + horizontalOffset
            
            let trackWidth = (self.size.width/CGFloat(numberOfTracks))*0.90
            //let trackMargin = (self.size.width/CGFloat(numberOfTracks))*0.10
            
            let trackHeight = (self.size.height)*0.90
            let trackSize = CGSize(width: trackWidth, height: trackHeight)
            
            let trackButtonYPos: CGFloat = 20.00
            let trackButtonZPos: CGFloat = -10.00
            
            switch(index){
                case 0:
                    let completionStatus = getCompletionStatusFor(trackTypeOf: .Wingman)
                    let wingmanTrackButton = ButtonManager.getTrackButton(isCompleted: completionStatus, trackType: .Wingman, size: trackSize, position: CGPoint(x: xStartPos, y: trackButtonYPos))
                    wingmanTrackButton.zPosition = trackButtonZPos
                    wingmanTrackButton.name = NodeNames.WingmanTrackButton
                    self.addChild(wingmanTrackButton)
                    break
                case 1:
                    let completionStatus = getCompletionStatusFor(trackTypeOf: .Bat)
                    let batTrackButton = ButtonManager.getTrackButton(isCompleted: completionStatus, trackType: .Bat, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: trackButtonYPos))
                    batTrackButton.name = NodeNames.BatTrackButton
                    batTrackButton.zPosition = trackButtonZPos

                    self.addChild(batTrackButton)
                    break
                case 2:
                    let completionStatus = getCompletionStatusFor(trackTypeOf: .UFO)
                    let ufoTrackButton = ButtonManager.getTrackButton(isCompleted: completionStatus, trackType: .UFO, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: trackButtonYPos))
                    ufoTrackButton.name = NodeNames.UFOTrackButton
                    ufoTrackButton.zPosition = trackButtonZPos

                    self.addChild(ufoTrackButton)
                    break
                case 3:
                    let completionStatus = getCompletionStatusFor(trackTypeOf: .StealthShip)
                    let stealthTrackButton = ButtonManager.getTrackButton(isCompleted: completionStatus, trackType: .StealthShip, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: trackButtonYPos))
                    stealthTrackButton.name = NodeNames.StealthShipTrackButton
                    stealthTrackButton.zPosition = trackButtonZPos
                    self.addChild(stealthTrackButton)
                    break
                case 4:
                    let completionStatus = getCompletionStatusFor(trackTypeOf: .FlyingAlien)
                    let flyingAlienButton = ButtonManager.getTrackButton(isCompleted: completionStatus, trackType: .FlyingAlien, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: trackButtonYPos))
                    flyingAlienButton.name = NodeNames.FlyingAlienTrackButton
                    flyingAlienButton.zPosition = trackButtonZPos

                    self.addChild(flyingAlienButton)
                    break
                default:
                    break
            }
            
        }
        
        
      
        //Configure ReturnToMenu Button
        let mainMenuTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-menu")
        let menuSprite = SKSpriteNode(texture: mainMenuTexture)
        menuSprite.name = NodeNames.ReturnToMenuButton
        menuSprite.xScale *= 0.80
        menuSprite.yScale *= 0.80
        menuSprite.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.05, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.70)
        self.addChild(menuSprite)
        
        //TODO: Configure Achievements Button
        /**
        let achievementsButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_button02")
        let achievementSprite = SKSpriteNode(texture: achievementsButtonTexture)
        achievementSprite.name = NodeNames.AchievementsButton
        achievementSprite.position = CGPoint(x: ScreenSizeFloatConstants.ScreenWidth*0.90, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.70)
        let achievementsLabel = SKLabelNode(fontNamed: FontTypes.FuturaMedium)
        achievementsLabel.text = "See Achievements"
        achievementsLabel.name = NodeNames.AchievementsButton
        achievementsLabel.horizontalAlignmentMode = .center
        achievementsLabel.verticalAlignmentMode = .center
        achievementsLabel.position = CGPoint(x: achievementSprite.position.x, y: achievementSprite.position.y)
        achievementSprite.addChild(achievementsLabel)
        self.addChild(achievementSprite)
        **/
    }
    
    
    //MARK: Functions for handling User Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        let transition = SKTransition.crossFade(withDuration: 2.00)
        
        for node in nodes(at: touchLocation){
            
            let mainTransition = SKTransition.crossFade(withDuration: 2.00)
            
            
            for node in nodes(at: touchLocation){
                
                /**
                if node.name == NodeNames.AchievementsButton{
                    let nc = NotificationCenter.default
                    nc.post(name: Notification.Name(rawValue: GameKitHelper.ShowAchievements), object: nil)
                    
                } **/
                
                if node.name == NodeNames.ReturnToMenuButton{
                    let menuScene = MenuScene(size: self.size)
                    self.view?.presentScene(menuScene, transition: transition)
                }
            }
            
            if node.name == NodeNames.BatTrackButton{
                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .Bat)

                self.view?.presentScene(instructionScene, transition: mainTransition)
            }
            
            if node.name == NodeNames.StealthShipTrackButton{
                node.run(clickSound)
                
                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .StealthShip)

                self.view?.presentScene(instructionScene, transition: mainTransition)
            }
            
            
            if node.name == NodeNames.UFOTrackButton{
                node.run(clickSound)

                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .UFO)
                self.view?.presentScene(instructionScene, transition: transition)
            }
            
            
            if node.name == NodeNames.WingmanTrackButton{
                node.run(clickSound)

                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .Wingman)
                self.view?.presentScene(instructionScene, transition: transition)
            }
            
            if node.name == NodeNames.FlyingAlienTrackButton{
                node.run(clickSound)

                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .FlyingAlien)
                self.view?.presentScene(instructionScene, transition: mainTransition)
            }
            
           
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    private func configureBackground(){
        //Set background color
        self.backgroundColor = SKColor.black
        
        //Setup emitter node
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
    }
    
    private func getCompletionStatusFor(trackTypeOf trackType: TrackType) -> Bool{
        
        switch(trackType){
            case .Bat:
                let level1Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Bat, .Level1))
                let level2Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Bat, .Level2))
                let level3Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Bat, .Level3))
                let level4Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Bat, .Level4))
                let level5Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Bat, .Level5))
                return (level1Status && level2Status && level3Status && level4Status && level5Status)
            case .FlyingAlien:
                let level1Status = gameSettings.getLevelCompletionStatus(levelInfo: (.FlyingAlien, .Level1))
                let level2Status = gameSettings.getLevelCompletionStatus(levelInfo: (.FlyingAlien, .Level2))
                let level3Status = gameSettings.getLevelCompletionStatus(levelInfo: (.FlyingAlien, .Level3))
                let level4Status = gameSettings.getLevelCompletionStatus(levelInfo: (.FlyingAlien, .Level4))
                let level5Status = gameSettings.getLevelCompletionStatus(levelInfo: (.FlyingAlien, .Level5))
                return (level1Status && level2Status && level3Status && level4Status && level5Status)
            case .StealthShip:
                let level1Status = gameSettings.getLevelCompletionStatus(levelInfo: (.StealthShips, .Level1))
                let level2Status = gameSettings.getLevelCompletionStatus(levelInfo: (.StealthShips, .Level2))
                let level3Status = gameSettings.getLevelCompletionStatus(levelInfo: (.StealthShips, .Level3))
                let level4Status = gameSettings.getLevelCompletionStatus(levelInfo: (.StealthShips, .Level4))
                let level5Status = gameSettings.getLevelCompletionStatus(levelInfo: (.StealthShips, .Level5))
                return (level1Status && level2Status && level3Status && level4Status && level5Status)
            case .UFO:
                let level1Status = gameSettings.getLevelCompletionStatus(levelInfo: (.UFO, .Level1))
                let level2Status = gameSettings.getLevelCompletionStatus(levelInfo: (.UFO, .Level2))
                let level3Status = gameSettings.getLevelCompletionStatus(levelInfo: (.UFO, .Level3))
                let level4Status = gameSettings.getLevelCompletionStatus(levelInfo: (.UFO, .Level4))
                let level5Status = gameSettings.getLevelCompletionStatus(levelInfo: (.UFO, .Level5))
                return (level1Status && level2Status && level3Status && level4Status && level5Status)
            case .Wingman:
                let level1Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Wingman, .Level1))
                let level2Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Wingman, .Level2))
                let level3Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Wingman, .Level3))
                let level4Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Wingman, .Level4))
                let level5Status = gameSettings.getLevelCompletionStatus(levelInfo: (.Wingman, .Level5))
                return (level1Status && level2Status && level3Status && level4Status && level5Status)
            
        }
        
      
    }
    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
    
    
}
