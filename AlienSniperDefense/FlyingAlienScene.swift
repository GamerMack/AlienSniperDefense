//
//  FlyingAlienScene.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/14/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

//
//  TestScene8.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class FlyingAlienScene: BaseScene{
    
    
    //Enemy Prototype
    lazy var enemy: FlyingAlien = {
        let randomScalingFactor = RandomFloatRange(min: 0.7, max: 1.4)
        let flyingAlien = FlyingAlien(alienColor: .blue)!
        flyingAlien.xScale *= randomScalingFactor
        flyingAlien.yScale *= randomScalingFactor
        
        let radius = flyingAlien.size.width/2
        flyingAlien.physicsBody = SKPhysicsBody(circleOfRadius: radius, center: self.position)
        flyingAlien.physicsBody?.allowsRotation = false
        flyingAlien.physicsBody?.affectedByGravity = false
        flyingAlien.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        flyingAlien.physicsBody?.collisionBitMask = PhysicsCategory.Ground
        flyingAlien.physicsBody?.contactTestBitMask = PhysicsCategory.Ground
        
        return flyingAlien
    }()
    
    
    //Timer Related Variables
    var fieldActionIntervalCounter: TimeInterval = 0.00
    var fieldActionInterval: TimeInterval = 8.00
    
    var velocityUpdateCounter: TimeInterval = 0.00
    var velocityUpdateInterval: TimeInterval = 5.00
    
    //Random Vector Configuration (for providing level-specific customization of velocity changes)
    var randomVectorConfiguration: RandomVectorConfiguration!
    //Random Point Generator
    
    var randomDistFromBackgroundObjectsArray: GKRandomDistribution {
        
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjects.count-1)
        }
    }
    
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, crosshairType: CrossHair.CrossHairType, backgroundMusic: String, fieldActionInterval: TimeInterval, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, enemiesSpawnedPerInterval: Int, initialNumberOfEnemiesSpawned: Int, maximumNumberOfEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration) {
        
        self.init(size: size)
        
        //Configure Opening/Intro Start Window
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = crosshairType
        self.backGroundMusic = backgroundMusic
        
        
        //Configure Game Rules and basic AI logic
        self.spawnInterval = spawnInterval
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.maximumNumberOFEnemies = maximumNumberOfEnemiesAllowed
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        //Configure background objects
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        
        //Configure unique aspects of scene
        self.fieldActionInterval = fieldActionInterval
        
        //Configure randomVectorConfiguration
        self.randomVectorConfiguration = randomVectorConfiguration
    
    
    }
    
    override func didMove(to view: SKView) {
        //Set current track
        currenTrack = .FlyingAlien
        
        //Register NSNotifications for Pause and Resume
        registerNotifications()
        
        //Basic scene configuration (calls base class's version of spawnBackgroundObjects)
        performBasicSceneConfiguration()
        
        //Call overridden version of spawnBackGroundObjects
        self.spawnBackgroundObjects(numberOfBackgroundObjects: self.numberOfBackgroundObjects)
        
        //Configure Background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.MissionPlausible, forParentNode: self)
        
        //Configure barrier node
        configureBarrierNode()
   
 
        //Spawn initial number of flying aliens
        spawnEnemyFromPrototype(numberOfEnemy: self.initialNumberOfEnemiesSpawned)
       
        
        
    }
    
    
    //MARK: ************* Configure barrier node for containing Flying Aliens
    
    private func configureBarrierNode(){
        let barrierNode = SKSpriteNode(texture: nil, color: .clear, size: self.size)
        barrierNode.zPosition = 2
        barrierNode.anchorPoint = CGPoint(x: 0, y: 0)
        barrierNode.position = CGPoint.zero
        
        let cgSize = CGSize(width: ScreenSizeFloatConstants.ScreenWidth, height: ScreenSizeFloatConstants.ScrrenHeight)
        let startingPoint = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth, y: -ScreenSizeFloatConstants.HalfScreenHeight)
        let cgRect = CGRect(origin: startingPoint, size: cgSize)
        barrierNode.physicsBody = SKPhysicsBody(edgeLoopFrom: cgRect)
        
        print(barrierNode.size)
        print(barrierNode.position)
        
        barrierNode.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        barrierNode.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
        barrierNode.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        
        self.addChild(barrierNode)
        
    }
   
    
    //MARK: *************** GAME LOOP FUNCTIONS
    
    override func didSimulatePhysics() {
        
        if(velocityUpdateCounter > velocityUpdateInterval){
            updatePhysicsForFlyingAliens()

            velocityUpdateCounter = 0
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        frameCount += currentTime - lastUpdateTime
        fieldActionIntervalCounter += currentTime - lastUpdateTime
        velocityUpdateCounter += currentTime - lastUpdateTime
        
        if(frameCount > spawnInterval){
            spawnEnemyFromPrototype(numberOfEnemy: self.enemiesSpawnedPerInterval)
            frameCount = 0.0
        }
        
        
        if(fieldActionIntervalCounter > fieldActionInterval){
            disableGravityFields()
            fieldActionIntervalCounter = 0
        }
        
        //Update flying aliens' flying mode
        updateFlyingModesForSpawnedAliens(currentTime: currentTime)
        
        lastUpdateTime = currentTime
    }
    
    
    private func updateFlyingModesForSpawnedAliens(currentTime: TimeInterval){
        for node in self.children{
            if let node = node as? FlyingAlien{
                node.updateFlyingMode(currentTime: currentTime)
            }
        }
    }
    
    
    
    //MARKL *************** SPAWNING FUNCTIONS
    override func spawnEnemyFromPrototype(numberOfEnemy: Int) {
        for _ in 0..<numberOfEnemy{
            let randomScaleFactor = RandomFloatRange(min: 0.4, max: 0.7)
            
            let enemyCopy = enemy.copy() as! FlyingAlien
            
            
            configurePhysicsForEnemyCopy(enemyCopy: enemyCopy)
            
            //Set initial health of flying alien to 2
            enemyCopy.userData = NSMutableDictionary()
            enemyCopy.userData?.setValue(2, forKey: "health")
            
            enemyCopy.xScale *= randomScaleFactor
            enemyCopy.yScale *= randomScaleFactor
            
            let randomSpawnPoint = randomPointGenerator.getRandomPointInRandomQuadrant()
            enemyCopy.position = randomSpawnPoint
            enemyCopy.name = "flyingAlien"
            
            currentNumberOfEnemies += 1
            enemyCopy.move(toParent: self)
            
        }
        
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
    }
  
    
    private func configurePhysicsForEnemyCopy(enemyCopy: FlyingAlien){
        let radius = enemy.size.width/2
        enemyCopy.physicsBody = SKPhysicsBody(circleOfRadius: radius, center: self.position)
        enemyCopy.physicsBody?.allowsRotation = false
        enemyCopy.physicsBody?.affectedByGravity = false
        enemyCopy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemyCopy.physicsBody?.collisionBitMask = PhysicsCategory.Ground
        enemyCopy.physicsBody?.contactTestBitMask = PhysicsCategory.Ground
    }
    
    //MARK: ******************* USER INPUT HANDLERS
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        super.touchesMoved(touches, with: event)
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        
    
        for node in nodes(at: touchLocation){
            
            let num = randomDistFromBackgroundObjectsArray.nextInt()
            
            if node.name == "backgroundObject\(num)"{
                for subNode in node.children{
                    if let subNode = subNode as? SKFieldNode{
                        subNode.isEnabled = true
                    }
                    
                    node.run(SKAction.repeatForever(SKAction.sequence([
                        SKAction.group([
                            SKAction.fadeAlpha(to: 0.4, duration: 1.0),
                            SKAction.scale(to: 0.4, duration: 1.0)
                            ]),
                        SKAction.group([
                            SKAction.fadeAlpha(to: 1.0, duration: 1.0),
                            SKAction.scale(to: 1.0, duration: 1.0)
                            ])
                        ])), withKey: "fieldAction")
                }
                
                
            }
            
            
            
            if player.contains(touchLocation){
                    player.run(shootingSound)

                    performResponseForSpawnedAliens(touchLocation: touchLocation)
                
            }
            
        }
        
    }
    
    //MARK: ************ Helper Functions for handling touch events

    private func performResponseForSpawnedAliens(touchLocation: CGPoint){
        for node in nodes(at: touchLocation){
            if let node = node as? FlyingAlien{
                let userDict = node.userData
                node.respondToHit(userDictionary: userDict)
            }
        }
    }
    
    
    
    //MARK: ************** Helper Function that uses user dictionary to update physics and handle touch input for individual alien node
    
    private func updatePhysicsForFlyingAliens(){
        
        for node in self.children{
            if let node = node as? FlyingAlien{
                
                let maxVectorX = self.randomVectorConfiguration.maxVectorX
                let minVectorX = self.randomVectorConfiguration.minVectorX
                
                let maxVectorY = self.randomVectorConfiguration.maxVectorY
                let minVectorY = self.randomVectorConfiguration.minVectorY
                
                let randomVector = RandomVector(yComponentMin: minVectorY, yComponentMax: maxVectorY, xComponentMin: minVectorX, xComponentMax: maxVectorX)
                
                node.updatePhysics(randomVector: randomVector)
                
            }
        }
        
        
    }
    
    
   
  
    private func getPositionOfRandomBackgroundObject() -> CGPoint{
        
        let randomDist = GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjectsPositions.count-1)
        
        let randomIndex = randomDist.nextInt()
        
        return backgroundObjectsPositions[randomIndex]
        
        
    }
    
    
    

    private func disableGravityFields(){
        for object in backgroundObjects{
            
            
            for node in object.children{
                if let node = node as? SKFieldNode{
                    if(node.isEnabled){
                        node.isEnabled = false
                        node.parent?.removeAction(forKey: "fieldAction")
                    }
                }
            }
        }
    }
    
    private func spawnBackgroundObjects(numberOfBackgroundObjects: Int){
        
        let numberOfObjects: Int = numberOfBackgroundObjects > (backgroundObjects.count-1) ? (backgroundObjects.count-1) : numberOfBackgroundObjects
        
        
        for index in 0..<numberOfObjects{
            
            let randomSpawnPoint = index % 2 == 0 ? randomPointGenerator.getUpperScreenPoint() : randomPointGenerator.getLowerScreenPoint()
            
            backgroundObjects[index].name = "backgroundObject\(index)"
            backgroundObjects[index].zPosition = -1
            backgroundObjects[index].position = randomSpawnPoint
            backgroundObjectsPositions.append(randomSpawnPoint)
            
            let gravityFieldNode = SKFieldNode.radialGravityField()
            gravityFieldNode.isEnabled = false
            gravityFieldNode.categoryBitMask = PhysicsCategory.Enemy
            gravityFieldNode.strength = 200.0
            gravityFieldNode.minimumRadius = 200.0
            backgroundObjects[index].addChild(gravityFieldNode)
            
            self.addChild(backgroundObjects[index])
        }
    }
   
    

    
    
}

extension FlyingAlienScene{
    override func loadNextLevel() {
        //TODO: Implement loadNextLevel function
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
       
        
        var nextLevelDifficulty: FlyingAlienLevelLoader.DifficultyLevel
        
        switch(currentGameSettings.getGameDifficulty()){
        case .valueHard:
            nextLevelDifficulty = .Hard
            break
        case .valueMedium:
            nextLevelDifficulty = .Medium
            break
        case .valueEasy:
            nextLevelDifficulty = .Easy
            break
        }
        
        var nextLevelScene: FlyingAlienScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: nextLevelDifficulty)
        
        
        
        switch(self.levelNumber){
        case 5:
            //Load player status summary scene
            let transition = SKTransition.crossFade(withDuration: 2.00)
            let summaryScene = SummaryScene(size: self.size, selectedTrackType: .FlyingAlien)
            self.view?.presentScene(summaryScene, transition: transition)
            
            break
        case 4:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel5(difficultyLevel: nextLevelDifficulty)
        case 3:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel4(difficultyLevel: nextLevelDifficulty)
        case 2:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel3(difficultyLevel: nextLevelDifficulty)
        case 1:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel2(difficultyLevel: nextLevelDifficulty)
        default:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: nextLevelDifficulty)
        }
        
        self.view?.presentScene(nextLevelScene, transition: mainTransition)
    }
        
    
    
    override func reloadCurrentLevel() {
        //TODO: Implement reload current level function
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
        
        var currentLevelDifficulty: FlyingAlienLevelLoader.DifficultyLevel
        
        switch(currentGameSettings.getGameDifficulty()){
        case .valueHard:
            currentLevelDifficulty = .Hard
            break
        case .valueMedium:
            currentLevelDifficulty = .Medium
            break
        case .valueEasy:
            currentLevelDifficulty = .Easy
            break
        }
        
        
        
        var currentLevelScene: FlyingAlienScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        
        switch(self.levelNumber){
        case 5:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel5(difficultyLevel: currentLevelDifficulty)
        case 4:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel4(difficultyLevel: currentLevelDifficulty)
        case 3:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel3(difficultyLevel: currentLevelDifficulty)
        case 2:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel2(difficultyLevel: currentLevelDifficulty)
        case 1:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        default:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        }
        
        self.view?.presentScene(currentLevelScene, transition: mainTransition)

    }
    
}


extension FlyingAlienScene{
    
    //MARK: ************** Override basic scene configuration so that base class version of spawnBackgroundObjects is not called
    
    override func performBasicSceneConfiguration(){
        //Set anchor point of current scene to center
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.black
        
        //Configure player
        player = CrossHair(crossHairType: self.playerType)
        self.addChild(player)
        
        //Configure explosion animation
        configureExplosionAnimation()
        
        //Configure particle emitter for background
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        
        //Configure SceneInterfaceManagerDelegate
        sceneInterfaceManagerDelegate = SceneInterfaceManager(newManagedScene: self)
        sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: "Level \(levelNumber)", levelDescription: self.levelDescription, enemyName: self.enemyName, spawningLimit: self.maximumNumberOFEnemies)
        
        
        //Configure initial HUD display
        currentNumberOfEnemies = 0
        numberOfEnemiesKilled = 0
        self.addChild(hud2)
        
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
        
    
    }
    
    
}


