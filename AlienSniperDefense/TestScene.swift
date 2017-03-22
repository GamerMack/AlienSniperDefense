//
//  TestScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    
    override func didMove(to view: SKView) {
        //Set the anchor point of the scene
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //Set background color
        self.backgroundColor = SKColor.black
        
        //Setup emitter node
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
    }
}
