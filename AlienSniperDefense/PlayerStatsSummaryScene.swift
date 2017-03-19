//
//  PlayerStatsSummaryScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class PlayerStatsSummaryScene: SKScene{
    
    enum TrackType{
        case Wingman, FlyingAlien, UFO, Bat, StealthShip
    }
    
    var trackType: PlayerStatsSummaryScene.TrackType = .FlyingAlien
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, selectedTrackType: PlayerStatsSummaryScene.TrackType) {
        self.init(size: size)
        self.trackType = selectedTrackType
    }
    
    
    override func didMove(to view: SKView) {
        //Configure Background Musics
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.FarmFrolics, forParentNode: self)
        
        //Set anchor point to zero
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //Configure background
        backgroundColor = UIColor.black
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        //Player Stats Title
        let title = SKLabelNode(fontNamed: FontTypes.MarkerFeltThin)
        title.text = "Well Done! Track Completed!"
        title.verticalAlignmentMode = .center
        title.horizontalAlignmentMode = .center
        title.fontSize = 30.0
        title.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.ScrrenHeight*0.40)
        self.addChild(title)
        
    }
    
}
