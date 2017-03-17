//
//  BatLevel.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//



import Foundation
import SpriteKit
import GameplayKit

class BatScene: BaseScene
{
    
    //MARK: ******************** BAT CONFIGURATION PARAMTERS

    lazy var prototypeBatArray: [Bat] = {
        
        var batsArray = [Bat]()
        
        if let bat1 = Bat(scalingFactor: 0.3), let bat2 = Bat(scalingFactor: 0.6), let bat3 = Bat(scalingFactor: 1.0), let bat4 = Bat(scalingFactor: 2.0), let bat5 = Bat(scalingFactor: 4.0){
            
            batsArray.append(bat1)
            batsArray.append(bat2)
            batsArray.append(bat3)
            batsArray.append(bat4)
            batsArray.append(bat5)
            
        }
        
        return batsArray
    
    }()
    
    var batIndex: Int {
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: prototypeBatArray.count-1).nextInt()
        }
    }
    
    var minBatsSpawned: Int = 0
    var maxBatsSpawned: Int = 0
    var minBatComponentVelocity: Double = 0
    var maxBatComponentVelocity: Double = 0
    var maximumBatsAllowedToSpawn: Int = 0
    var minimumBatsKilledForLevelCompletion: Int = 0
    
    //MARK: ****************** CrossHair LightNode Configuration
    var lightNodeFallOff: CGFloat = 2.0
    
   
    
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, playerType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double,lightNodeFallOff: CGFloat, maximumBatsAllowedToSpawn: Int, minimumBatsKilledForLevelCompletion: Int) {
        
        //Configure Opening/Intro Start Window
        self.init(size: size)
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = playerType
        self.backGroundMusic = backgroundMusic
        
        //Configure background
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        
        //Configure bat spawning parameters
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.currentNumberOfEnemies = initialNumberOfEnemiesSpawned
        self.spawnInterval = spawnInterval
        self.minBatsSpawned = minBatsSpawned
        self.maxBatsSpawned = maxBatsSpawned
       
        self.maxBatComponentVelocity = maxBatComponentVelocity
        self.minBatComponentVelocity = minBatComponentVelocity
        self.lightNodeFallOff = lightNodeFallOff
        
        //Configure game rules
        self.maximumBatsAllowedToSpawn = maximumBatsAllowedToSpawn
        self.minimumBatsKilledForLevelCompletion = minimumBatsKilledForLevelCompletion
        
      

    }
    


    
    override func didMove(to view: SKView) {
        
        
        //Set anchor point of current scene to center
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.black
        self.frameCount = 0.00
        
        //Configure SceneInterfaceManagerDelegate
        sceneInterfaceManagerDelegate = SceneInterfaceManager(newManagedScene: self)
        sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: "Level \(levelNumber)", levelDescription: self.levelDescription, enemyName: "Bat", spawningLimit: self.maximumBatsAllowedToSpawn)
        
        
        //Configure particle emitter for background
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.particleColor = SKColor.orange
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        
        //Configure explosion animation
        configureExplosionAnimation()
        
        //Configure initial HUD display
        currentNumberOfEnemies = 0
        numberOfEnemiesKilled = 0
        hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        self.addChild(hud2)

        //Configure player
        player = CrossHair(crossHairType: .BlueLarge)
        player.zPosition = 15
        let lightNode = player.childNode(withName: NodeNames.CrossHairLight) as! SKLightNode
        lightNode.falloff = self.lightNodeFallOff
    
        self.addChild(player)
        
        //Configure Background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.MissionPlausible, forParentNode: self)
        

        //Spawn Background Objectsr
        spawnBackgroundObjects(numberOfBackgroundObjects: self.numberOfBackgroundObjects, scaledByFactorOf: 0.40)
        
        
        //Spawn initial number of bats
        spawnBats(numberOfBats: nil)
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)

        
        
    }

    
    
    //MARK: *************** GAME LOOP FUNCTIONS
    
    override func didSimulatePhysics() {
        
        var randomVector = RandomVector(yComponentMin: self.minBatComponentVelocity, yComponentMax: self.maxBatComponentVelocity, xComponentMin: self.minBatComponentVelocity, xComponentMax: self.maxBatComponentVelocity)
        
        randomVector.randomizeXComponentSign()
        randomVector.randomizeYComponentSign()
        
        
        for node in self.children{
            if let bat = node as? Bat{
                checkForRepositioning()
                bat.physicsBody?.velocity = randomVector.getVector()
            }
        }
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        frameCount += currentTime - lastUpdateTime
        
        if(numberOfEnemiesKilled > minimumBatsKilledForLevelCompletion){
            loadNextScene(difficultyLevel: .Easy)
        }
        
        if(self.currentNumberOfEnemies > maximumNumberOFEnemies){
          //  self.isPaused = true
           // self.showRestartButtons()
            
        }
        
    
        player.update()
        
        if(frameCount > spawnInterval){
            //Update the Bat Controller
            
           spawnRandomNumberOfBatsFrom(minimum: self.minBatsSpawned, toMaximum: self.maxBatsSpawned)
            frameCount = 0.00
        }
        
        
        lastUpdateTime = currentTime

        
    }
    
    

    
    
    //MARK: ******************* USER INPUT HANDLERS
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let node = touches.first! as UITouch
        let touchLocation = node.location(in: self)
        
        player.updateTargetPosition(position: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        
        
        
        if(restartButton.contains(touchLocation)){
            
            reloadCurrentScene(difficultyLevel: .Easy)
        }
        
        
        if(menuButton.contains(touchLocation)){
            let transition = SKTransition.crossFade(withDuration: 2.0)
            self.view?.presentScene(MenuScene(size: self.size), transition: transition)
        }
        
        
        
        for node in nodes(at: touchLocation){
            
            if node.name == NodeNames.StartButton{
                node.removeFromParent()
            }
            
            if let node = node as? Bat, player.contains(touchLocation){
                node.run(SKAction.sequence([
                    explosionSound,
                    explosionAnimation
                    ]))
                
                numberOfEnemiesKilled += 1
                currentNumberOfEnemies -= 1
                
                hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
                hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
                
            } else {
                player.run(shootingSound)
            }
        }
        
    }
    
    

    private func getPositionOfRandomBackgroundObject() -> CGPoint{
        
        let randomDist = GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjectsPositions.count-1)
        
        let randomIndex = randomDist.nextInt()
        
        return backgroundObjectsPositions[randomIndex]
        
        
    }
    
    
    
    private func reloadCurrentScene(difficultyLevel: BatSceneLevelLoader.DifficultyLevel){
        switch(levelNumber){
        case 1:
            BatSceneLevelLoader.loadLevel1From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 2:
            BatSceneLevelLoader.loadLevel2From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 3:
            BatSceneLevelLoader.loadLevel3From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 4:
            BatSceneLevelLoader.loadLevel4From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 5:
            BatSceneLevelLoader.loadLevel5From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        default:
            //TODO: Not yet implemented
            break
        }
    }
    
    private func loadNextScene(difficultyLevel: BatSceneLevelLoader.DifficultyLevel){
        
        switch(levelNumber){
        case 1:
            BatSceneLevelLoader.loadLevel2From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 2:
            BatSceneLevelLoader.loadLevel3From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 3:
            BatSceneLevelLoader.loadLevel3From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 4:
            BatSceneLevelLoader.loadLevel4From(currentScene: self, difficultyLevel: difficultyLevel)
            break
        case 5:
            //TODO: Not yet implemented; load transitional scene or scene for next track
            break
        default:
            break
        }
    }
    
    
    private func removeExcessNodes(numberToRemove: Int){
        var counter = 0
        
        for node in self.children{
            if let node = node as? Bat, counter < numberToRemove{
                node.removeFromParent()
                currentNumberOfEnemies -= 1
                hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
                counter += 1
            }
        }
    }
}


extension BatScene{
    //MARK: **************** Bat Spawning Functions
    
    func spawnBats(numberOfBats: Int?){
        
        let numberOfBatsToSpawn = numberOfBats ?? initialNumberOfEnemiesSpawned
        
        for _ in 0...numberOfBatsToSpawn{
            
            let batClone = prototypeBatArray[batIndex].copy() as! Bat
            configurePhysicsForClone(batClone: batClone)
            self.addChild(batClone)
            self.currentNumberOfEnemies += 1
        }
        
    }
    
    func spawnRandomNumberOfBatsFrom(minimum: Int, toMaximum maximum: Int){
        let numberOfBats = GKRandomDistribution(lowestValue: minimum, highestValue: maximum).nextInt()
        
        for _ in 0...numberOfBats{
            
            let batClone = prototypeBatArray[batIndex].copy() as! Bat
            configurePhysicsForClone(batClone: batClone)
            self.addChild(batClone)
            self.currentNumberOfEnemies += 1
        }
        
    }
    
    //MARK: ************* Configure properites on bat clone
    private func configurePhysicsForClone(batClone: Bat){
        let radius = batClone.size.width/2.0
        batClone.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        batClone.physicsBody?.affectedByGravity = false
        batClone.physicsBody?.allowsRotation = false
        batClone.physicsBody?.linearDamping = 0.0
        batClone.physicsBody?.collisionBitMask = ~PhysicsCategory.Player
        batClone.physicsBody?.contactTestBitMask = ~PhysicsCategory.Player
        batClone.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
    }
    
    
    func checkForRepositioning(){
        for node in self.children{
            if let bat = node as? Bat{
                if(bat.position.x < -ScreenSizeFloatConstants.HalfScreenWidth*0.8 || bat.position.x > ScreenSizeFloatConstants.HalfScreenHeight*0.8){
                    bat.setPosition()
                }
                
                if(bat.position.y < -ScreenSizeFloatConstants.HalfScreenHeight*0.8 || bat.position.y > ScreenSizeFloatConstants.HalfScreenHeight*0.8){
                    bat.setPosition()
                }
            }
        }
    }
    

    
    
}

