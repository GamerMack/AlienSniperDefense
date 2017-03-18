//
//  InstructionScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

class InstructionScene: SKScene{
    
  
    enum TrackType{
        case Wingman, FlyingAlien, UFO, Bat, StealthShip
    }
    
    var trackType: InstructionScene.TrackType = .FlyingAlien
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, selectedTrackType: InstructionScene.TrackType) {
        self.init(size: size)
        trackType = selectedTrackType
    }
    
    override func didMove(to view: SKView) {
        //Configure Background Musics
        //BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.FarmFrolics, forParentNode: self)
        
        //Configure background
        //configureBackground()
        
        //Configure anchor point for scene
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        let mainNode = SKNode()
//        mainNode.position = CGPoint.zero
//        self.addChild(mainNode)

        
//        switch(trackType){
//        case .Wingman:
//            configureNodeForWingmanTrack(mainNode: mainNode)
//            break
//        case .FlyingAlien:
//            configureNodeForFlyingAlienTrack(mainNode: mainNode)
//            break
//        case .StealthShip:
//            configureNodeForStealthShipTrack(mainNode: mainNode)
//            break
//        case .UFO:
//            configureNodeForUFOTrack(mainNode: mainNode)
//            break
//        case .Bat:
//            configureNodeForBatTrack(mainNode: mainNode)
//            break
//            
//        }
        
        
    }
    
    
    //MARK: Scene Configuration Functions
    
    private func configureBackground(){
        //Set background color
        self.backgroundColor = SKColor.black
        
        //Setup emitter node
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
    }
    
    //MARK:  Main Node Configuration Functions
    private func configureNodeForWingmanTrack(mainNode: SKNode){
        mainNode.name = NodeNames.WingmanTrackButton
        
      
//        
//        makeLabelForNode(node: mainNode,
//                         withTextOf: "Wingman can hide behind sky objects.",
//                         text2: "When hiding, they cannot be hit",
//                         text3: nil)
    }
    
    private func configureNodeForFlyingAlienTrack(mainNode: SKNode){
        mainNode.name = NodeNames.FlyingAlienTrackButton
        
       
//        
//        makeLabelForNode(node: mainNode,
//                         withTextOf: "Hover Borg can be manned or unmanned.",
//                         text2: "When unmanned, they cannot be hit.",
//                         text3: "Shoot background objects to generate blackholes that capture Hover Borgs.")
    }
    
    private func configureNodeForStealthShipTrack(mainNode: SKNode){
        mainNode.name = NodeNames.StealthShipTrackButton
        
        
//        makeLabelForNode(node: mainNode,
//                         withTextOf: "When int stealth mode, stealth ships fade out.",
//                         text2: "When in stealth mode, they cannot take damage.",
//                         text3: "Stealth mode require multiple hits to be destroyed")
    }
    
    private func configureNodeForUFOTrack(mainNode: SKNode){
        mainNode.name = NodeNames.UFOTrackButton
        
        
//        makeLabelForNode(node: mainNode,
//                         withTextOf: "When in stealth mode, stealth ships fade out.",
//                         text2: "When in stealth mode, they cannot take damage.",
//                         text3: "Stealth mode require multiple hits to be destroyed")
    }
    
    private func configureNodeForBatTrack(mainNode: SKNode){
        mainNode.name = NodeNames.BatTrackButton
        
//        makeLabelForNode(node: mainNode,
//                         withTextOf: "Bats can be hard to see in the dark.",
//                         text2: "When targeted with the cross hair, they can be illuminated",
//                         text3: nil)
    }
    
    
    private func getLabelNode(withTextOf labelText: String) -> SKLabelNode{
        
        let labelNode = SKLabelNode(fontNamed: FontTypes.FuturaCondensedMedium)
        labelNode.text = labelText
        labelNode.verticalAlignmentMode = .center
        labelNode.horizontalAlignmentMode = .center
        labelNode.fontSize = 50.0
        labelNode.fontColor = SKColor.blue
        
        return labelNode
    }
    
    
    private func makeLabelForNode(node: SKNode, withTextOf text1: String, text2: String?, text3: String?){
        
        let labelNode1 = getLabelNode(withTextOf: text1)
        let yPosLabelNode1 = ScreenSizeFloatConstants.HalfScreenHeight*0.20
        labelNode1.position = CGPoint(x: 0, y: yPosLabelNode1)
        
        node.addChild(labelNode1)
        
        if let text2 = text2{
            let labelNode2 = getLabelNode(withTextOf: text2)
            let yPosLabelNode = ScreenSizeFloatConstants.HalfScreenHeight*0.30
            labelNode2.position = CGPoint(x: 0, y: yPosLabelNode)
            
            
            node.addChild(labelNode2)

        }
        
        if let text3 = text3{
            let labelNode3 = getLabelNode(withTextOf: text3)
            let yPosLabelNode = ScreenSizeFloatConstants.HalfScreenHeight*0.40
            labelNode3.position = CGPoint(x: 0, y: yPosLabelNode)
            
            node.addChild(labelNode3)
        }
        
    }
    
    
    //MARK: User Touch Handlers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        for node in nodes(at: touchLocation){
            
            
            if node.name == NodeNames.WingmanTrackButton{
                //TODO: load WingmanTrack Level 1
            }
            
            if node.name == NodeNames.UFOTrackButton{
                //TODO: load UFO Track Level 1
            }
            
            if node.name == NodeNames.StealthShipTrackButton{
                //TODO: load StealthShipTrack Level 1
                
            }
            
            if node.name == NodeNames.BatTrackButton{
                //TODO: load BatTrack Level 1
                
            }
            
            if node.name == NodeNames.FlyingAlienTrackButton{
                //TODO: load FlyingAlienTrack Level1
                
            }
            
        }
    }
    
    
}
