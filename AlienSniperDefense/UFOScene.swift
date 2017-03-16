//
//  UFOScene.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
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
import AVFoundation

/** NOTE: Background music has to be configured manually for this scene. An unknown bug prevents the derived class from calling the base class function that adds and activates the AVAudioNode **/

class UFOScene: BaseScene{
    
  
    //MARK: UFO-related variables
    var ufoController: UFOController!
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, crossHairType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKillsForLevelCompletion: Int, maximumAllowableSpawnedUFO: Int) {
        
        self.init(size: size)
        
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        self.playerType = crossHairType
        self.backGroundMusic = backGroundMusic
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        self.spawnInterval = spawnInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval

        self.maximumNumberOFEnemies = maximumAllowableSpawnedUFO
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        
        //Configuration of UFO Controller
        self.ufoController = UFOController(ufoSpawningInterval: spawnInterval, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        
        //Basic configuration
        super.performBasicSceneConfiguration()

        //Configure Background music (this function does not get  the base class's
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: "Drumming Sticks.mp3", forParentNode: self)
        
        //Set zPosition of Player CrossHair
        player.zPosition = 15
        
        //Spawn initial number of UFOs
        ufoController.spawnUFOs(numberOfUFOs: self.initialNumberOfEnemiesSpawned)
        self.addChild(ufoController)
    }
    
    
    
    //MARK: *************** GAME LOOP FUNCTIONS
    
    override func didSimulatePhysics() {
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        frameCount += currentTime - lastUpdateTime
        
        if(currentNumberOfEnemies > maximumNumberOFEnemies){
            self.isPaused = true
            self.showRestartButtons()
            
        }
        
        if(numberOfEnemiesKilled > minimumKillsForLevelCompletion){
            //Load next scene
        }
        
        
        //Update player CrossHair
        player.update()
        checkPlayerPositionForReposition()
        
        
        //Update UFOs managed by the controller
        ufoController.update(currentTime: currentTime)
        
       
        lastUpdateTime = currentTime
    }
    
    
    //MARK: *************** Reset Player to onscreen position in case removed by gravity field
    private func checkPlayerPositionForReposition(){
        
        if(playerIsOffscreen()){
            let randomOnScreenPoint = randomPointGenerator.getRandomPointInRandomQuadrant()
            player.position = randomOnScreenPoint
        }
    }
    
    private func playerIsOffscreen() -> Bool{
        return (player.position.x < -ScreenSizeFloatConstants.HalfScreenWidth || player.position.x > ScreenSizeFloatConstants.HalfScreenWidth || player.position.y < -ScreenSizeFloatConstants.HalfScreenHeight || player.position.y > ScreenSizeFloatConstants.HalfScreenHeight)
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
            
        }
        
        
        if(menuButton.contains(touchLocation)){
        }
        
        
        
        for node in nodes(at: touchLocation){
            
            if node.name == NodeNames.StartButton{
                node.removeFromParent()
            }
            
            if player.contains(touchLocation){
               
                player.run(shootingSound)
                
                ufoController.respondToTouch(touchLocation: touchLocation)
                
                /**
                currentNumberOfEnemies -= 1
                numberOfEnemiesKilled += 1
                
                hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
                hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
                **/
            }
        }
        
    }
    
    
    
   
    
    
    
    
   

    
    
    
}

