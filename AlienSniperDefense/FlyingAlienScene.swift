//
//  FlyingAlienScene.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/14/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

//
//  FlyingAlienScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


/** 
 
 Previous version did not call the base class's didMove(to view:) function but instead individually called the overridden functions that were executed when calling the base class's method
 //Set current GamePlayMode
 setCurrentGamePlayMode()
 
 //Register NSNotifications for Pause and Resume
 registerNotifications()
 
 
 //Basic scene configuration (calls base class's version of spawnBackgroundObjects)
 performBasicSceneConfiguration()
 
 
 //Call overridden version of spawnBackGroundObjects
 self.spawnBackgroundObjects(numberOfBackgroundObjects: self.numberOfBackgroundObjects)
 **/
 


import Foundation
import SpriteKit
import GameplayKit

class FlyingAlienScene: BaseScene{
    
    
    override var currentNumberOfEnemies: Int{
        didSet{
            if(currentNumberOfEnemies < 0){
                currentNumberOfEnemies = 0
            }
            
            hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        }
    }
    
    override var numberOfEnemiesKilled: Int{
        didSet{
            currentNumberOfEnemies -= (numberOfEnemiesKilled - oldValue)
            
            hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
        }
    }
    
    //MARK: Adjusted Current Velocity
    var adjustedCurrentTime: TimeInterval = 0.00
    var adjustedLastUpdateTime: TimeInterval = 0.00
    
    
    //Enemy Prototype
    lazy var enemy: FlyingAlien? = {
        let randomScalingFactor = RandomFloatRange(min: 0.7, max: 1.4)
        
        guard let flyingAlien = FlyingAlien(alienColor: .blue) else { return nil }
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
    var velocityUpdateInterval: TimeInterval = 2.00
    
    //Random Vector Configuration (for providing level-specific customization of velocity changes)
    var randomVectorConfiguration: RandomVectorConfiguration!
    //Random Point Generator
    
    var randomDistFromBackgroundObjectsArray: GKRandomDistribution {
        
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjects.count-1)
        }
    }
    
    //Customized laser sound that can be used instead of the base scene's laser sound
    let laserSound: SKAction = SKAction.playSoundFileNamed(SoundEffects.Laser9, waitForCompletion: false)
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, crosshairType: CrossHair.CrossHairType, backgroundMusic: String, fieldActionInterval: TimeInterval, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, enemiesSpawnedPerInterval: Int, initialNumberOfEnemiesSpawned: Int, maximumNumberOfEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, randomVectorConfiguration: RandomVectorConfiguration, timeLimit: TimeInterval = 60.00) {
        
        self.init(size: size)
        
        //Configure Opening/Intro Start Window
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = crosshairType
        self.backGroundMusic = backgroundMusic
        
        //Configure Time Limit for Time Limit Mode
        self.timeLimit = timeLimit
        
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
        
        super.didMove(to: view)
    
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
        
        
        barrierNode.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        barrierNode.physicsBody?.collisionBitMask = PhysicsCategory.Enemy | ~PhysicsCategory.Player
        barrierNode.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy | ~PhysicsCategory.Player
        player.physicsBody?.collisionBitMask = 0
        
        self.addChild(barrierNode)
        
    }
   
    
    //MARK: *************** GAME LOOP FUNCTIONS
    
    override func didSimulatePhysics() {
        
        if(velocityUpdateCounter > velocityUpdateInterval){
            updatePhysicsForFlyingAliens(randomVectorConfiguration: self.randomVectorConfiguration)

            velocityUpdateCounter = 0
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if(!gameHasStarted){
            adjustedCurrentTime = 0
            frameCount = 0
        } else {
            adjustedCurrentTime = currentTime
        
        }
        
        
        frameCount += adjustedCurrentTime - adjustedLastUpdateTime
        fieldActionIntervalCounter += adjustedCurrentTime - adjustedLastUpdateTime
        velocityUpdateCounter += adjustedCurrentTime - adjustedLastUpdateTime
        
        
        
        if(frameCount > spawnInterval){
            spawnEnemyFromPrototype(numberOfEnemy: self.enemiesSpawnedPerInterval)
            frameCount = 0.0
        }
        
    
        if(fieldActionIntervalCounter > fieldActionInterval){
            disableGravityFields()
            fieldActionIntervalCounter = 0
        }
        
        //Update flying aliens' flying mode
        updateFlyingModesForSpawnedAliens(currentTime: adjustedCurrentTime)
        
        //Update the player's position
        player.update()
        
        adjustedLastUpdateTime = adjustedCurrentTime
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
            
            guard let enemy = enemy else { return }
            
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
        
    }
  
    
    private func configurePhysicsForEnemyCopy(enemyCopy: FlyingAlien){
        
        guard let enemy = enemy else { return }
        
        let radius = enemy.size.width/2
        enemyCopy.physicsBody = SKPhysicsBody(circleOfRadius: radius, center: self.position)
        enemyCopy.physicsBody?.allowsRotation = false
        enemyCopy.physicsBody?.affectedByGravity = false
        enemyCopy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemyCopy.physicsBody?.collisionBitMask = PhysicsCategory.Ground
        enemyCopy.physicsBody?.contactTestBitMask = PhysicsCategory.Ground
        
        let randomVector = RandomVector(randomVectorConfiguration: self.randomVectorConfiguration)
        enemyCopy.physicsBody?.velocity = randomVector.getVector()
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
                    if let node = node as? FlyingAlien{
                        let userDict = node.userData
                        
                        let isBeingRemovedStatus = userDict?.value(forKey: "isBeingRemoved") as? Bool
                        
                        if(isBeingRemovedStatus != nil), isBeingRemovedStatus == true{
                            return
                        } else {
                            node.respondToHit(userDictionary: userDict, parentScene: self)
                        }
                    }
                
            }
            
        }
        
    }
    
   
    
    //MARK: ************** Helper Function that uses user dictionary to update physics and handle touch input for individual alien node
    
    private func updatePhysicsForFlyingAliens(randomVectorConfiguration: RandomVectorConfiguration){
        
        for node in self.children{
            if let node = node as? FlyingAlien{
                
        
                let maxVectorX = randomVectorConfiguration.maxVectorX
                let minVectorX = randomVectorConfiguration.minVectorX
                
                let maxVectorY = randomVectorConfiguration.maxVectorY
                let minVectorY = randomVectorConfiguration.minVectorY
                
                var randomVector = RandomVector(yComponentMin: minVectorY, yComponentMax: maxVectorY, xComponentMin: minVectorX, xComponentMax: maxVectorX)
                
                randomVector.randomizeXComponentSign()
                randomVector.randomizeYComponentSign()
                
                node.updatePhysics(randomVector: randomVector)
                
            }
        }
        
        
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
        
        var nextLevelScene: FlyingAlienScene?
        
        
        switch(self.levelNumber){
       
        case 1:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel2(difficultyLevel: nextLevelDifficulty)
            break
        case 2:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel3(difficultyLevel: nextLevelDifficulty)
            break
        case 3:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel4(difficultyLevel: nextLevelDifficulty)
            break
        case 4:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel5(difficultyLevel: nextLevelDifficulty)
            break
        case 5:
            //Load player status summary scene
            let transition = SKTransition.crossFade(withDuration: 2.00)
            let summaryScene = SummaryScene(size: self.size, selectedTrackType: .FlyingAlien)
            self.view?.presentScene(summaryScene, transition: transition)
            break
            
        default:
            nextLevelScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: nextLevelDifficulty)
        }
        
        if(nextLevelScene == nil){
            //Load player status summary scene
            let transition = SKTransition.crossFade(withDuration: 2.00)
            let summaryScene = SummaryScene(size: self.size, selectedTrackType: .FlyingAlien)
            self.view?.presentScene(summaryScene, transition: transition)
        } else {
            self.view?.presentScene(nextLevelScene!, transition: mainTransition)

        }
        
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
            break
        case 4:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel4(difficultyLevel: currentLevelDifficulty)
            break
        case 3:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel3(difficultyLevel: currentLevelDifficulty)
            break
        case 2:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel2(difficultyLevel: currentLevelDifficulty)
            break
        case 1:
            currentLevelScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
            break
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
        player.physicsBody?.collisionBitMask = PhysicsCategory.NoCategory
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
        
        let tempTexta = NSLocalizedString("Level ", comment: "")
        
        var tempTextb: String
        
        if(tempTexta == "等级 "){
            switch(levelNumber){
            case 1:
                tempTextb = tempTexta.appending("-")
                break
            case 2:
                tempTextb = tempTexta.appending("二")
                break
            case 3:
                tempTextb = tempTexta.appending("三")
                break
            case 4:
                tempTextb = tempTexta.appending("四")
                break
            case 5:
                tempTextb = tempTexta.appending("五")
                break
            default:
                tempTextb = tempTexta.appending("零")
                break
            }
        } else {
            tempTextb = tempTexta.appending("\(levelNumber)")
            
        }
        
        
        if(currentGameSettings.getGamePlayMode() == .valueTimeLimit){
            sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: tempTextb, levelDescription: self.levelDescription, enemyName: "Hover Borg", levelTimeLimit: self.timeLimit, minimumKillsForLevelCompletion: self.minimumKillsForLevelCompletion)
        }else{
            sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: tempTextb, levelDescription: self.levelDescription, enemyName: "Hover Borg", spawningLimit: self.maximumNumberOFEnemies, minimumKillsForLevelCompletion: self.minimumKillsForLevelCompletion)
        }
        

        
        
        //Configure initial HUD display
        currentNumberOfEnemies = 0
        numberOfEnemiesKilled = 0
        self.addChild(hud2)
        
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
        
        //Configure the Pause State Buttons
        setupPauseStateButtons()
        
        //Configure the Pause Buttons
        configurePauseButton()
    }
    
    
}


