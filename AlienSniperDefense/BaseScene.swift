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
import AVFoundation

/**  The Base Scene represent the essential functionality for scenes in different Game Tracks, including the Wingman Track, Bat Track, UFO Track, Flying Aliens Track, and Stealth Ship Track; Derived classes that inherit from the Base Scene will have unique game logic related to the AI for specific enemy characters as well as their own custom, convenience initializers that can be called in their respective level loaders but which will call the convenience initializer defined here for initializing basic scene properties (maximumNumberOfEnemies, numberOfEnemiesKilled, etc.)
 
 **/

class BaseScene: SKScene{
    
    
    //MARK: *****************Number for the Current Level
    var levelNumber: Int = 1
    
    //MARK: ******************** UI Buttons
    var menuButton = SKSpriteNode()
    var restartButton = SKSpriteNode()
    var sceneInterfaceManagerDelegate: SceneInterfaceManagerDelegate!
    
    
    //MARK: ********************* Explosion Animation (cached in the scene file for efficiency)
    var explosionAnimation = SKAction()
    var explosionSound = SKAction.playSoundFileNamed(SoundEffects.Explosion1, waitForCompletion: false)
    
    //MARK: ************** Background Objects Array and other related variables
    lazy var backgroundObjects: [BackgroundObject] = [
        BackgroundObject(backgroundObjectType: .Sun),
        BackgroundObject(backgroundObjectType: .Cloud1),
        BackgroundObject(backgroundObjectType: .Cloud2),
        BackgroundObject(backgroundObjectType: .FullMoon),
        BackgroundObject(backgroundObjectType: .HalfMoon),
        BackgroundObject(backgroundObjectType: .Cloud3),
        BackgroundObject(backgroundObjectType: .Cloud5),
        BackgroundObject(backgroundObjectType: .Cloud6),
        BackgroundObject(backgroundObjectType: .Cloud4)
    
    ]
    
    var numberOfBackgroundObjects: Int = 3
    var backgroundObjectsPositions = [CGPoint]()
    
    
    //MARK: ************** Variables pertaining to Game Rules and Scene Configuration
    var currentNumberOfEnemies: Int = 0
    var maximumNumberOFEnemies: Int = 10
    var numberOfEnemiesKilled: Int = 0
    var minimumKillsForLevelCompletion: Int = 0
    
    var initialNumberOfEnemiesSpawned: Int = 2
    var levelDescription = String()
    var enemyName = String()
    var backGroundMusic = String()

    //MARK: *********************  Timer Related Variables
    var frameCount: TimeInterval = 0.00
    var lastUpdateTime: TimeInterval = 0.00
    var spawnInterval: TimeInterval = 5.00
    var enemiesSpawnedPerInterval: Int = 2
    

    //MARK: ******************** Random Point Generator
    let randomPointGenerator = RandomPoint(algorithmType: .Faster)
    
    //MARK: ******************* HUD display
    var hud2 = HUD2()
    
    //MARK: ***************** Player Variables
    var player: CrossHair!
    var playerType: CrossHair.CrossHairType!
    var shootingSound = SKAction.playSoundFileNamed(SoundEffects.Laser9, waitForCompletion: false)
    
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, crossHairType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumNumberOfEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int) {
    
        self.init(size: size)
        
        //Configure Opening/Intro Start Window
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = crossHairType
        self.backGroundMusic = backgroundMusic
        
        
        //Configure Game Rules and basic AI logic
        self.spawnInterval = spawnInterval
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.maximumNumberOFEnemies = maximumNumberOfEnemiesAllowed
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        //Configure background objects
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
    }
    
    override func didMove(to view: SKView) {
        
        //Basic scene configuration
        performBasicSceneConfiguration()
        
        //Configure Background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: self.backGroundMusic, forParentNode: self)
        

    }
    
    
    //MARK: ************** Basic Scene Configuration
    
    func performBasicSceneConfiguration(){
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
        
        
        //Spawn Background Objects
        spawnBackgroundObjects(numberOfBackgroundObjects: self.numberOfBackgroundObjects, scaledByFactorOf: 0.40)
    }
    
 
    
    //MARK: *************** GAME LOOP FUNCTIONS (these will be overriden and customized in subclasses)
    
    override func update(_ currentTime: TimeInterval) {
        if(numberOfEnemiesKilled > minimumKillsForLevelCompletion){
            loadNextLevel()
        }
        
        if(currentNumberOfEnemies > maximumNumberOFEnemies){
            self.isPaused = true
            self.showRestartButtons()
    
        }
        
        player.update()
       
        
    }
    
  
    
    
    
    //MARK: ******************* USER INPUT HANDLERS (these will be overriden and customized in subclasses)
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let node = touches.first! as UITouch
        let touchLocation = node.location(in: self)
        
        player.updateTargetPosition(position: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if(restartButton.contains(touchLocation)){
            reloadCurrentLevel()
        }
        
        if(menuButton.contains(touchLocation)){
           loadMenuScene()
        }
        
    
    
        for node in nodes(at: touchLocation){
            
            if node.name == NodeNames.StartButton{
                //Remove the start window to begin game
                node.removeFromParent()
            }
         
        }
        
    }
    
    func spawnEnemyFromPrototype(numberOfEnemy: Int){
        //This method is to be overrided in derived classes
        
    }
    
    func spawnBackgroundObjects(numberOfBackgroundObjects: Int, scaledByFactorOf scaleFactor: CGFloat){
        
        let numberOfObjects: Int = numberOfBackgroundObjects > (backgroundObjects.count-1) ? (backgroundObjects.count-1) : numberOfBackgroundObjects
        
        
        for index in 0..<numberOfObjects{
            
            let randomSpawnPoint = index % 2 == 0 ? randomPointGenerator.getUpperScreenPoint() : randomPointGenerator.getLowerScreenPoint()
            
            backgroundObjects[index].zPosition = -1
            backgroundObjects[index].position = randomSpawnPoint
            backgroundObjectsPositions.append(randomSpawnPoint)
            
            self.addChild(backgroundObjects[index])
        }
    }
    



    final func configureExplosionAnimation(){
        if let textureAtlas = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .RegularExplosion){
            
            self.explosionAnimation = SKAction.animate(with: [
                textureAtlas.textureNamed("regularExplosion00"),
                textureAtlas.textureNamed("regularExplosion01"),
                textureAtlas.textureNamed("regularExplosion02"),
                textureAtlas.textureNamed("regularExplosion03"),
                textureAtlas.textureNamed("regularExplosion04"),
                textureAtlas.textureNamed("regularExplosion05"),
                textureAtlas.textureNamed("regularExplosion06"),
                textureAtlas.textureNamed("regularExplosion07"),
                textureAtlas.textureNamed("regularExplosion08")
                ], timePerFrame: 0.25)
            
        }
    }
    

    
}


//MARK: *****************************SCENE EXTENSION

extension BaseScene{
    
    final func setupMenuAndRestartButtons(){
        
        guard let menuButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-menu") else { return }
        
        guard let restartButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-restart") else { return }
        
            menuButton = SKSpriteNode(texture: menuButtonTexture)
            restartButton = SKSpriteNode(texture: restartButtonTexture)
        
            menuButton.name = NodeNames.ReturnToMenuButton
            restartButton.name = NodeNames.RestartGameButton
            
            menuButton.size = CGSize(width: kViewWidth*0.2, height: kViewHeight*0.3)
            restartButton.size = CGSize(width: kViewWidth*0.2, height: kViewHeight*0.3)
            
            menuButton.position = CGPoint(x: kViewWidth*0.5*0.2, y: 0)
            restartButton.position = CGPoint(x: menuButton.position.x - menuButton.size.width - 30, y: menuButton.position.y)
            
            let returnToMenuText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
            returnToMenuText.text = "Main Menu"
            returnToMenuText.fontSize = 20.0
            returnToMenuText.fontColor = SKColor.white
            returnToMenuText.verticalAlignmentMode = .bottom
            returnToMenuText.position = CGPoint(x: 0, y: -menuButton.size.height)
            returnToMenuText.name = NodeNames.ReturnToMenuButton
            returnToMenuText.move(toParent: menuButton)
            
            let restartGameText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
            restartGameText.text = "Restart Level"
            restartGameText.fontSize = 20.0
            restartGameText.fontColor = SKColor.white
            restartGameText.verticalAlignmentMode = .bottom
            restartGameText.position = CGPoint(x: 0, y: -restartButton.size.height)
            restartGameText.name = NodeNames.RestartGameButton
            restartGameText.move(toParent: restartButton)
            
            restartButton.zPosition = -15
            menuButton.zPosition = -15
            
            restartButton.alpha = 0
            menuButton.alpha = 0
            
        
            
        
        
    }
    
    final func showRestartButtons(){
        //Set the button alpha to zero
        
            setupMenuAndRestartButtons()
            
            restartButton.alpha = 1
            menuButton.alpha = 1
        
            menuButton.move(toParent: self)
            restartButton.move(toParent: self)
            
            menuButton.zPosition = 15
            restartButton.zPosition = 15
            
            
            let fadeAnimation = SKAction.fadeAlpha(to: 1.0, duration: 1.0)
            
            restartButton.run(fadeAnimation)
            menuButton.run(fadeAnimation)
    }
    
    
    final func loadMenuScene(){
        let transition = SKTransition.crossFade(withDuration: 2.00)
        self.view?.presentScene(MenuScene(size: self.size), transition: transition)
    }
    
    func reloadCurrentLevel(){
        //To be overridden in derived classes
    }
    
    func loadNextLevel(){
        //To be overridden in derived classes
    }

    
}

