//
//  UFO.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


struct PathAnimationConfiguration{
    var duration1: Double = 10.00
    var duration2: Double = 10.00
    var duration3: Double = 10.00
    var duration4: Double = 10.00
    var duration5: Double = 10.00
    
    init(d1: Double, d2: Double, d3: Double, d4: Double, d5: Double){
        duration1 = d1
        duration2 = d2
        duration3 = d3
        duration4 = d4
        duration5 = d5
    }
}

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
    var shapeOverlay = SKShapeNode()
    
    var moveDuration1: Double = 15.00
    var moveDuration2: Double = 15.00
    var moveDuration3: Double = 15.00
    var moveDuration4: Double = 15.00
    var moveDuration5: Double = 15.00

    
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
    
    convenience init?(ufoType: UFOType, pathAnimationConfiguration: PathAnimationConfiguration) {
        
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
        

     
        configurePosition()
        configurePhysics(physicsBodyRadius: ufoSize.width/2)
        
        let duration1 = pathAnimationConfiguration.duration1
        let duration2 = pathAnimationConfiguration.duration2
        let duration3 = pathAnimationConfiguration.duration3
        let duration4 = pathAnimationConfiguration.duration4
        let duration5 = pathAnimationConfiguration.duration5
        
        configurePathAction(duration1: duration1, duration2: duration2, duration3: duration3, duration4: duration4, duration5: duration5)
        configureEmittingAction()
        configureInitialHealth(initialHealth: 1)
    }
    
    
    //MARK: ************* Public configuration method used for UFO copies, since the copy() function called by the controller does not pefrom a deep copy
    
    func performUFOConfiguration(duration1: Double, duration2: Double, duration3: Double, duration4: Double, duration5: Double){
        //Configure shape overlay, which appear in die animation
        
        let ufoSize = self.size
        
        let shapeOverlay = SKShapeNode(circleOfRadius: ufoSize.width/2)
        shapeOverlay.fillColor = SKColor.red
        shapeOverlay.strokeColor = SKColor.clear
        shapeOverlay.zPosition = -15
        shapeOverlay.alpha = 0
        self.addChild(shapeOverlay)
        
        //Set duration of path animation: longer means slower UFO spped, short means faster speed
        
        configurePosition()
        configurePhysics(physicsBodyRadius: ufoSize.width/2)

        
        configurePathAction(duration1: duration1, duration2: duration2, duration3: duration3, duration4: duration4, duration5: duration5)
        configureEmittingAction()
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
    
    
   
    
    private func configurePathAction(duration1: Double, duration2: Double, duration3: Double, duration4: Double, duration5: Double){
        
     
        //Get random points in 4 Screen quadrants
        let point1 = randomPointGenerator.getRandomPointInRandomQuadrant()
        let point2 = randomPointGenerator.getRandomPointInRandomQuadrant()
        let point3 = randomPointGenerator.getRandomPointInRandomQuadrant()
        let point4 = randomPointGenerator.getRandomPointInRandomQuadrant()
        
        
        
        let moveToStartPoint = SKAction.move(to: point1, duration: duration1)
        self.run(moveToStartPoint)
        
        let moveToPoint2 = SKAction.move(to: point2, duration: duration2)
        let moveToPoint3 = SKAction.move(to: point3, duration: duration3)
        let moveToPoint4 = SKAction.move(to: point4, duration: duration4)
        let returnToPoint1 = SKAction.move(to: point1, duration: duration5)
        
        let pathActionSequence = SKAction.sequence([
            moveToPoint2,
            moveToPoint3,
            moveToPoint4,
            returnToPoint1
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
        
        
        lastUpdateTime = currentTime
    }
    
    
    
    
    //MARK: ************** User touch/hit handlers
    
    func respondToTouch() -> Bool{
        
        if(inFieldEmittingMode) { return false }
        
        die()
        
        return true
        
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

    
