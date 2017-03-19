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

    lazy var prototypeBat = Bat(scalingFactor: 0.80, startingHealth: 1, minXVelocity: 0, maxXVelocity: 10, minYVelocity: 0, maxYVelocity: 10)!
        
    
    var minBatsSpawned: Int = 0
    var maxBatsSpawned: Int = 0
    var minBatComponentVelocity: Double = 0
    var maxBatComponentVelocity: Double = 0
    
    //MARK: ****************** CrossHair LightNode Configuration
    var lightNodeFallOff: CGFloat = 2.0
    
   
    
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, playerType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, minBatsSpawned: Int, maxBatsSpawned: Int, minBatComponentVelocity: Double, maxBatComponentVelocity: Double,lightNodeFallOff: CGFloat, maximumBatsAllowedToSpawn: Int, minimumBatsKilledForLevelCompletion: Int) {
        
        //Delegate to designated initializer
        self.init(size: size)
        
        //Configure Opening/Intro Start Window
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = playerType
        self.backGroundMusic = backgroundMusic
        
        
        //Configure basic AI logic
        self.spawnInterval = spawnInterval
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.currentNumberOfEnemies = initialNumberOfEnemiesSpawned
        self.minBatsSpawned = minBatsSpawned
        self.maxBatsSpawned = maxBatsSpawned
        self.maxBatComponentVelocity = maxBatComponentVelocity
        self.minBatComponentVelocity = minBatComponentVelocity
        self.lightNodeFallOff = lightNodeFallOff
        
        
        //Configure Game Rules
        self.maximumNumberOFEnemies = maximumBatsAllowedToSpawn
        self.minimumKillsForLevelCompletion = minimumBatsKilledForLevelCompletion
        
        //Configure background objects
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        
        
        

    }
    


    
    override func didMove(to view: SKView) {
        //Set current track
        currenTrack = .Bat
        
        //Set framecount to zero
        frameCount = 0.00
        
        //Perform basic scene configuration
        performBasicSceneConfiguration()
        
        
        //TODO: ********** Remove after debugging completed
        self.backgroundColor = SKColor.gray
        
                
        //Configure initial HUD display
        currentNumberOfEnemies = 0
        numberOfEnemiesKilled = 0
        hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        self.addChild(hud2)

        
        //Spawn initial number of bats
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        
    }
    
    
    //MARK: ************** Override performBasicConfiguration() helper method
    
    override func performBasicSceneConfiguration() {
        //Register NSNotifications for Pause and Resume Method
        registerNotifications()
        
        //Set anchor point of current scene to center
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.black
        self.frameCount = 0.00
        
        //Configure SceneInterfaceManagerDelegate
        sceneInterfaceManagerDelegate = SceneInterfaceManager(newManagedScene: self)
        sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: "Level \(levelNumber)", levelDescription: self.levelDescription, enemyName: "Bat", spawningLimit: self.maximumNumberOFEnemies)
        
        
        //Configure particle emitter for background
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.particleColor = SKColor.orange
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        
        //Configure player
        player = CrossHair(crossHairType: .BlueLarge)
        player.zPosition = 15
        let lightNode = player.childNode(withName: NodeNames.CrossHairLight) as! SKLightNode
        lightNode.falloff = self.lightNodeFallOff
        self.addChild(player)

        //Configure explosion animation
        configureExplosionAnimation()
        
        //Configure Background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.MissionPlausible, forParentNode: self)
        
        
        //Spawn Background Objects
        spawnBackgroundObjects(numberOfBackgroundObjects: self.numberOfBackgroundObjects, scaledByFactorOf: 0.40)
        
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
    
    override func didEvaluateActions() {
        if(frameCount > spawnInterval){
            //Update the Bat Controller
            spawnRandomNumberOfBatsFrom(minimum: self.minBatsSpawned, toMaximum: self.maxBatsSpawned)
            frameCount = 0.00
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if(!gameHasStarted) { frameCount = 0 }
        
        frameCount += currentTime - lastUpdateTime
    
        
      
        lastUpdateTime = currentTime

        
    }
    
    

    
    
    //MARK: ******************* USER INPUT HANDLERS
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let node = touches.first! as UITouch
        let touchLocation = node.location(in: self)
        
        player.updateTargetPosition(position: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        
        
        for node in nodes(at: touchLocation){
            
            if player.contains(touchLocation){
                
                player.run(shootingSound)
                
                if let node = node as? Bat{
                    
                    node.respondToHit()
                    self.numberOfEnemiesKilled += 1
                    self.currentNumberOfEnemies -= 1
                    
                    self.hud2.setNumberOfEnemiesKilledTo(numberKilled: self.numberOfEnemiesKilled)
                    self.hud2.setNumberOfEnemiesTo(numberOfEnemies: self.currentNumberOfEnemies)
                    
            
                }
            }
            
            
          
        }
        
    }
    
    

    private func getPositionOfRandomBackgroundObject() -> CGPoint{
        
        let randomDist = GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjectsPositions.count-1)
        
        let randomIndex = randomDist.nextInt()
        
        return backgroundObjectsPositions[randomIndex]
        
        
    }
    
    
  
}


extension BatScene{
    //MARK: **************** Bat Spawning Functions
    
    func spawnBats(numberOfBats: Int?){
        
        let numberOfBatsToSpawn = numberOfBats ?? initialNumberOfEnemiesSpawned
        
        for _ in 0...numberOfBatsToSpawn{
            
            let batClone = prototypeBat.copy() as! Bat
            batClone.name = "bat"
            configurePhysicsForClone(batClone: batClone)
            batClone.move(toParent: self)
            self.currentNumberOfEnemies += 1
            hud2.setNumberOfEnemiesTo(numberOfEnemies: self.currentNumberOfEnemies)

        }
        
    }
    
    func spawnRandomNumberOfBatsFrom(minimum: Int, toMaximum maximum: Int){
        let numberOfBats = GKRandomDistribution(lowestValue: minimum, highestValue: maximum).nextInt()
        
        if(frameCount < spawnInterval) { return }

        
        for _ in 0...numberOfBats{
            
            let batClone = prototypeBat.copy() as! Bat
            batClone.name = "bat"
            configurePhysicsForClone(batClone: batClone)
            batClone.move(toParent: self)
            self.currentNumberOfEnemies += 1
            hud2.setNumberOfEnemiesTo(numberOfEnemies: self.currentNumberOfEnemies)
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

extension BatScene{
    
    override func loadNextLevel() {
        
        var nextLevelDifficulty: BatSceneLevelLoader.DifficultyLevel
        
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
        
        switch(levelNumber){
            case 1:
                BatSceneLevelLoader.loadLevel2From(currentScene: self, difficultyLevel: nextLevelDifficulty)
            break
        case 2:
            BatSceneLevelLoader.loadLevel3From(currentScene: self, difficultyLevel: nextLevelDifficulty)
            break
        case 3:
            BatSceneLevelLoader.loadLevel3From(currentScene: self, difficultyLevel: nextLevelDifficulty)
            break
        case 4:
            BatSceneLevelLoader.loadLevel4From(currentScene: self, difficultyLevel: nextLevelDifficulty)
            break
        case 5:
            //Load player stats summary scene
            let transition = SKTransition.crossFade(withDuration: 2.00)
            let summaryScene = SummaryScene(size: self.size, selectedTrackType: SummaryScene.TrackType.Bat)
            self.view?.presentScene(summaryScene, transition: transition)
            break
        default:
            break
        }
    }
    
    override func reloadCurrentLevel() {
        
        var currentLevelDifficulty: BatSceneLevelLoader.DifficultyLevel
        
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
        
        
        switch(levelNumber){
        case 1:
            BatSceneLevelLoader.loadLevel1From(currentScene: self, difficultyLevel: currentLevelDifficulty)
            break
        case 2:
            BatSceneLevelLoader.loadLevel2From(currentScene: self, difficultyLevel: currentLevelDifficulty)
            break
        case 3:
            BatSceneLevelLoader.loadLevel3From(currentScene: self, difficultyLevel: currentLevelDifficulty)
            break
        case 4:
            BatSceneLevelLoader.loadLevel4From(currentScene: self, difficultyLevel: currentLevelDifficulty)
            break
        case 5:
            BatSceneLevelLoader.loadLevel5From(currentScene: self, difficultyLevel: currentLevelDifficulty)
            break
        default:
            //TODO: Not yet implemented
            break
        }
    }
    
}
