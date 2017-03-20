//
//  MedalScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/20/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class MedalScene: SKScene{
    
    //MARK: ********* Enum for Medal Types
    enum MedalType{
        case Gold, Silver, Bronze
    }
    
    var medalType: MedalType = .Bronze
    
    //MARK: ********* SCENE INITIALIZERS
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, medalType: MedalType) {
        self.init(size: size)
        
        self.medalType = medalType
    }
    
    
    override func didMove(to view: SKView) {
        
        //Configure scene
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //Configure background
        backgroundColor = UIColor.black
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        //Configure Background Musics
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.GameOver, forParentNode: self)
        
        
        
        var medalTexture: SKTexture?
        
        switch(self.medalType){
        case .Gold:
            medalTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Medals)?.textureNamed("flat_medal1")
            break
        case .Silver:
             medalTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Medals)?.textureNamed("flat_medal3")
            break
        case .Bronze:
             medalTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Medals)?.textureNamed("flat_medal2")
            break
        }
        
        let medalSprite = SKSpriteNode(texture: medalTexture)
        medalSprite.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.50, y: 0)
        self.addChild(medalSprite)
        
        medalSprite.xScale *= 1.5
        medalSprite.yScale *= 1.5
        
        var medalText: String?
        
        switch(self.medalType){
            case .Gold:
                medalText = "Gold Medal Sniper"
                break
            case .Silver:
                medalText = "Silver Medal Sniper"
                break
            case .Bronze:
                medalText = "Bronze Medal Sniper"
                break
        }
        
        let label1 = SKLabelNode(fontNamed: FontTypes.FuturaCondensedMedium)
        label1.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.30)
        label1.verticalAlignmentMode = .center
        label1.horizontalAlignmentMode = .center
        label1.text = "Congratulations! You won the"
        
        let label2 = SKLabelNode(fontNamed: FontTypes.FuturaCondensedMedium)
        label2.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.20)
        label2.verticalAlignmentMode = .center
        label2.horizontalAlignmentMode = .center
        label2.fontSize = 40.0
        label2.text = medalText
        label2.fontColor = SKColor.yellow
        
        self.addChild(label1)
        self.addChild(label2)
        
        //Configure ReturnToMenu Button
        let mainMenuTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-menu")
        let menuSprite = SKSpriteNode(texture: mainMenuTexture)
        menuSprite.name = NodeNames.ReturnToMenuButton
        menuSprite.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.90, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.90)
        self.addChild(menuSprite)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        for node in nodes(at: touchLocation){
            if node.name == NodeNames.ReturnToMenuButton{
                let transition = SKTransition.crossFade(withDuration: 2.00)
                let trackScene = TrackScene(size: self.size)
                self.view?.presentScene(trackScene, transition: transition)
            }
        }
    }
    
    
}
