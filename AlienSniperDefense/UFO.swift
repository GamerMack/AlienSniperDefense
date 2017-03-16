//
//  UFO.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class UFO: SKSpriteNode{
    
    enum UFOType{
        case Red
        case Blue
        case Green
        case Yellow
    }
    
    
    var inFieldEmittingMode: Bool = false {
        didSet{
            
            if(inFieldEmittingMode){
                self.run(emittingAnimation, withKey: "emittingAnimation")
            }else{
                self.removeAction(forKey: "emittingAnimation")
            }
            
            
        }
    }
    
 
    
   
    //MARK: Actions
    var emittingAnimation = SKAction()
    var pathAction = SKAction()
    var damageAction = SKAction()
    var shapeOverlay = SKShapeNode()
    
    //MARK: RandomPoint Generator
    let randomPointGenerator = RandomPoint(algorithmType: .Faster)
    
    //MARK: Timing-Related Variables
    var frameCount: TimeInterval = 0.00
    var emittingInterval: TimeInterval = 5.00
    var lastUpdateTime: TimeInterval = 0.00
    
    //MARK: Variables related to health
    var health: Int = 1
    var pathAnimationDuration: Double = 5.00
    var isDead: Bool = false
    
    //MARK: *********** INITIALIZERS
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init?(ufoType: UFOType, pathAnimationDuration: Double) {
        
        guard let textureAtlas = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UFO) else { return nil }
        
        var texture: SKTexture
        
        switch(ufoType){
        case .Red:
            texture = textureAtlas.textureNamed("ufoRed")
            break
        case .Green:
            texture = textureAtlas.textureNamed("ufoGreen")
            break
        case .Yellow:
            texture = textureAtlas.textureNamed("ufoYellow")
            break
        case .Blue:
            texture = textureAtlas.textureNamed("ufoBlue")
            break
        
        }
        
        let ufoSize = texture.size()
        
        self.init(texture: texture, color: .clear, size: ufoSize)
        
        
        //Configure shape overlay, which appear in die animation
        shapeOverlay = SKShapeNode(circleOfRadius: ufoSize.width/2)
        shapeOverlay.fillColor = SKColor.red
        shapeOverlay.strokeColor = SKColor.clear
        shapeOverlay.zPosition = -15
        shapeOverlay.alpha = 0
        self.addChild(shapeOverlay)
        
        //Set duration of path animation: longer means slower UFO spped, short means faster speed
        self.pathAnimationDuration = pathAnimationDuration

     
        configurePosition()
        configurePhysics(physicsBodyRadius: ufoSize.width/2)
        configureAnimations()
        configureInitialHealth(initialHealth: 1)
    }
    
    
    //MARK: ************* Public configuration method used for UFO copies, since the copy() function called by the controller does not pefrom a deep copy
    
    func performUFOConfiguration(withPathAnimationDurationOf duration: Double){
        //Configure shape overlay, which appear in die animation
        
        let ufoSize = self.size
        
        let shapeOverlay = SKShapeNode(circleOfRadius: ufoSize.width/2)
        shapeOverlay.fillColor = SKColor.red
        shapeOverlay.strokeColor = SKColor.clear
        shapeOverlay.zPosition = -15
        shapeOverlay.alpha = 0
        self.addChild(shapeOverlay)
        
        //Set duration of path animation: longer means slower UFO spped, short means faster speed
        self.pathAnimationDuration = duration
        
        
        configurePosition()
        configurePhysics(physicsBodyRadius: ufoSize.width/2)
        configureAnimations()
        configureInitialHealth(initialHealth: 1)
        
    }
    
    
    //MARK: ************* Configuration for position
    private func configurePosition(){
        let randomPoint = randomPointGenerator.getRandomPointInRandomQuadrant()
        self.position = randomPoint
    }
    
    //MARK: ************ Configuration for intiial health
    private func configureInitialHealth(initialHealth: Int){
        self.health = initialHealth
    }
    
    //MARK: *********** Configuration for physics body
    private func configurePhysics(physicsBodyRadius: CGFloat){
        self.physicsBody = SKPhysicsBody(circleOfRadius: physicsBodyRadius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        self.physicsBody?.fieldBitMask = ~PhysicsCategory.Player
        
        self.physicsBody?.contactTestBitMask = ~PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.Player
    
    }
    
    
    //MARK: ********* Configuration for animations
    
    private func configureAnimations(){
        configurePathAction()
        configureDamageAction()
        configureEmittingAction()
    
    }
    
    private func configureEmittingAction(){
        let colorizeAction = SKAction.colorize(with: UIColor.init(colorLiteralRed: 0.40, green: 0.80, blue: 0.80, alpha: 0.40), colorBlendFactor: 2.00, duration: 0.50)
        let reverseColorizeAction = SKAction.reversed(colorizeAction)()
        
        emittingAnimation = SKAction.repeatForever(SKAction.sequence([
            SKAction.group([
                colorizeAction,
                SKAction.scale(to: 1.20, duration: 0.30)
                ]),
            SKAction.group([
                reverseColorizeAction,
                SKAction.scale(to: 0.80, duration: 0.30)
                ])
            ]))
    }
    
    
    private func configureDamageAction(){
        let action = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.4, duration: 1.0),
            SKAction.fadeAlpha(to: 0.8, duration: 1.0)
            ])
        
        damageAction = SKAction.repeatForever(action)
    }
    
    private func configurePathAction(){
        
     
        
        let cgRect = CGRect(x: self.position.x, y: self.position.y, width: 100, height: 100)
        let path = CGPath(ellipseIn: cgRect, transform: nil)
        let pathAnimation = SKAction.follow(path, duration: self.pathAnimationDuration)
        let reversePathAnimation = SKAction.reversed(pathAnimation)()
        
        let pathActionSequence = SKAction.sequence([
            pathAnimation,
            reversePathAnimation
            ])
        
        pathAction = SKAction.repeatForever(pathActionSequence)
        self.run(pathAction, withKey: "pathAction")
    }
    
    
    //MARK: *********** Game-Loop Related Functions
    func update(currentTime: TimeInterval){
        frameCount += currentTime - lastUpdateTime
        
        if(frameCount > emittingInterval){
            
            inFieldEmittingMode = !inFieldEmittingMode
            
            frameCount = 0
        }
        
        if(isOffScreen()){
            configurePosition()
        }
        
        lastUpdateTime = currentTime
    }
    
    
    private func isOffScreen() -> Bool{
        if(isDead) { return false }
        
        return (self.position.x < -ScreenSizeFloatConstants.HalfScreenWidth || self.position.x > ScreenSizeFloatConstants.HalfScreenWidth || self.position.y < -ScreenSizeFloatConstants.HalfScreenHeight || self.position.y > ScreenSizeFloatConstants.HalfScreenHeight)
    }
    
    
    //MARK: ************** User touch/hit handlers
    
    func respondToTouch(){
        
        if(inFieldEmittingMode) { return }
        
        switch(self.getHealth()){
      
        case 1:
            takeDamage()
            decreaseHealthBy(healthUnits: 1)
            break
        case 0:
            die()
            break
        default:
            takeDamage()
        }
        
    }
    
    
    func takeDamage(){
        
        self.run(damageAction, withKey: "damageAction")
    }
    
  
    
    func die(){
        
        self.removeAllActions()
        
        for node in self.children{
            if let node = node as? SKShapeNode{
                node.zPosition = 15
                node.alpha = 0.50
            }
        }
        
        self.physicsBody?.affectedByGravity = true
        self.isDead = true
        
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.00),
            SKAction.removeFromParent()
            ]))
        
        
    }
    
    func setHealthTo(healthValue: Int){
        self.health = healthValue
    }
    
    func getHealth() -> Int{
        return self.health
    }
    
    func decreaseHealthBy(healthUnits: Int){
        self.health -= healthUnits
    }
        
        
}

    
