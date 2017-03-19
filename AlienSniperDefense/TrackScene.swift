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
    
    
    override func didMove(to view: SKView) {
        //Configure Background Musics
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.FarmFrolics, forParentNode: self)
        
        //Configure background
        configureBackground()
        
        self.anchorPoint = CGPoint(x: 0, y: 0.4)
        
        let sceneTitle = SKLabelNode(fontNamed: FontTypes.MarkerFeltWie)
        sceneTitle.fontSize = 40.0
        sceneTitle.text = "Click on a level track below:"
        let sceneTitleYPos = ScreenSizeFloatConstants.HalfScreenHeight*0.8
        let sceneTitleXPos = ScreenSizeFloatConstants.HalfScreenWidth
        sceneTitle.position = CGPoint(x: sceneTitleXPos, y: sceneTitleYPos)
        self.addChild(sceneTitle)
        
        
        let numberOfTracks = 5
        
        for index in 0..<numberOfTracks{
            
            let horizontalOffset = ScreenSizeFloatConstants.ScreenWidth*0.04
            let xStartPos = (self.size.width/CGFloat(numberOfTracks))/2 + horizontalOffset
            
            let trackWidth = (self.size.width/CGFloat(numberOfTracks))*0.90
            let trackMargin = (self.size.width/CGFloat(numberOfTracks))*0.10
            
            let trackHeight = (self.size.height)*0.90
            let trackSize = CGSize(width: trackWidth, height: trackHeight)
            
            switch(index){
                case 0:
                    let wingmanTrackButton = ButtonManager.getTrackButton(isCompleted: false, trackType: .Wingman, size: trackSize, position: CGPoint(x: xStartPos, y: 0))
                    wingmanTrackButton.name = NodeNames.WingmanTrackButton
                    self.addChild(wingmanTrackButton)
                    break
                case 1:
                    let batTrackButton = ButtonManager.getTrackButton(isCompleted: false, trackType: .Bat, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: 0))
                    batTrackButton.name = NodeNames.BatTrackButton
                    self.addChild(batTrackButton)
                    break
                case 2:
                    let ufoTrackButton = ButtonManager.getTrackButton(isCompleted: false, trackType: .UFO, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: 0))
                    ufoTrackButton.name = NodeNames.UFOTrackButton
                    self.addChild(ufoTrackButton)
                    break
                case 3:
                    let stealthTrackButton = ButtonManager.getTrackButton(isCompleted: false, trackType: .StealthShip, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: 0))
                    stealthTrackButton.name = NodeNames.StealthShipTrackButton
                    self.addChild(stealthTrackButton)
                    break
                case 4:
                    let flyingAlienButton = ButtonManager.getTrackButton(isCompleted: false, trackType: .FlyingAlien, size: trackSize, position: CGPoint(x: xStartPos + (trackWidth)*CGFloat(index), y: 0))
                    flyingAlienButton.name = NodeNames.FlyingAlienTrackButton
                    self.addChild(flyingAlienButton)
                    break
                default:
                    break
            }
            
        }
    }
    
    
    //MARK: Functions for handling User Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        let transition = SKTransition.crossFade(withDuration: 2.00)
        
        for node in nodes(at: touchLocation){
            
            let mainTransition = SKTransition.crossFade(withDuration: 2.00)
            
            if node.name == NodeNames.BatTrackButton{
                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .Bat)

                self.view?.presentScene(instructionScene, transition: mainTransition)
            }
            
            if node.name == NodeNames.StealthShipTrackButton{
                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .StealthShip)

                self.view?.presentScene(instructionScene, transition: mainTransition)
            }
            
            
            if node.name == NodeNames.UFOTrackButton{
                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .UFO)
                self.view?.presentScene(instructionScene, transition: transition)
            }
            
            
            if node.name == NodeNames.WingmanTrackButton{
                let instructionScene = InstructionScene(size: self.size, selectedTrackType: .Wingman)
                self.view?.presentScene(instructionScene, transition: transition)
            }
            
            if node.name == NodeNames.FlyingAlienTrackButton{
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
    
    
    
    
}
