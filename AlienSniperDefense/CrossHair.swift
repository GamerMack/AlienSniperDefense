//
//  CrossHair.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

class CrossHair: SKSpriteNode{
    
    //MARK: Private class constants
    private let textureAtlas = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)
    
    private var touchOffset = 0
    private let moveFilter = 0.80
    
    //MARK: Private class variables
    private var newPosition = CGPoint()
    
    
    enum CrossHairType{
        case RedSmall
        case RedLarge
        case BlueSmall
        case BlueLarge
        case WhiteSmall
        case WhiteLarge
        case OutlineSmall
        case OutlineLarge
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    
    convenience init?(crossHairType: CrossHairType) {
        
        var texture: SKTexture?
        
        switch(crossHairType){
        case .BlueLarge:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_blue_large")
            break
        case .BlueSmall:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_blue_small")
            break
        case .RedLarge:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_red_large")
            break
        case .RedSmall:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_red_small")
            break
        case .OutlineLarge:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_outline_large")
            break
        case .OutlineSmall:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_outline_small")
            break
        default:
            texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .CrossHair)?.textureNamed("crosshair_blue_small")
        }
        
        
        guard let crosshairTexture = texture else { return nil}
        
        self.init(texture: crosshairTexture, color: .clear, size: crosshairTexture.size())
        configureLighting()
        configurePhysics()
        setup()
        
    }
    
    private func setup(){
        self.position = CGPoint(x: 0, y: 0)
        newPosition = CGPoint(x: 0, y: 0)
    }
    
    private func configureLighting(){
        let crosshairLight = SKLightNode()
        crosshairLight.name = NodeNames.CrossHairLight
        crosshairLight.categoryBitMask = PhysicsCategory.Player
        crosshairLight.lightColor = SKColor.yellow
        crosshairLight.shadowColor = SKColor.gray
        crosshairLight.ambientColor = SKColor.clear
        self.addChild(crosshairLight)
    }
    
    private func configurePhysics(){
        
        var radius = self.size.width
        
        
        //Crosshair radius is larger for easier difficulty mode
        let gameDifficulty = GameSettings.sharedInstance.getGameDifficulty()
        
        switch(gameDifficulty){
            case .valueHard:
                radius /= 1.5
            case .valueMedium:
                radius /= 1.0
            case .valueEasy:
                radius /= 0.5
        }
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        self.physicsBody?.fieldBitMask = PhysicsCategory.Player
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.Enemy
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
    
    }
    
    //MARK: - Update
    func update(){
        move()
    }
    
    //MARK: - Movement
    /**
    func updateTargetPosition(position: CGPoint){
        newPosition = position
 
    }
    **/
    
    
    func setTargetPosition(position: CGPoint){
        newPosition = position
    }
    
    private func move(){
        
        
        
        let newX = Smooth(startPoint: self.position.x, endPoint: newPosition.x, percentToMove: NumberUnit(moveFilter))
        let newY = Smooth(startPoint: self.position.y, endPoint: newPosition.y, percentToMove: NumberUnit(moveFilter))
    
        
        /** CONSIDER IMPLEMENTING BASED ON USER FEEDBACK FROM BETA TESTING
        let offsetCondition1 = self.position.x < ScreenSizeFloatConstants.HalfScreenWidth*0.80
        let offsetCondition2 = self.position.x > -ScreenSizeFloatConstants.HalfScreenWidth*0.80
        let offsetCondition3 = self.position.y > -ScreenSizeFloatConstants.HalfScreenHeight*0.80
        let offsetCondition4 = self.position.y < ScreenSizeFloatConstants.HalfScreenHeight*0.80
        **/
        
        
        self.position = CGPoint(x: newX, y: newY)
        
    }
    
}
