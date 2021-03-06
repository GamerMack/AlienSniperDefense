//
//  UFOScene.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

//
//  UFOScene.swift
//  AlienSniperDefense
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
    
    var adjustedCurrentTime: TimeInterval = 0.00
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, crossHairType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, minUFOSpawnedPerInterval: Int, maxUFOSpawnedPerInterval: Int, minimumKillsForLevelCompletion: Int, maximumAllowableSpawnedUFO: Int, pathAnimationConfiguration: PathAnimationConfiguration, timeLimit: TimeInterval = 60.00) {
        
        self.init(size: size)
        
        //Configure Time Limit for Time Limit Mode
        self.timeLimit = timeLimit
        
        //Configure Scene Information
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Scene Elements
        self.playerType = crossHairType
        self.backGroundMusic = backGroundMusic
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        
        //Configure Spawning Settings
        self.spawnInterval = spawnInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval

        self.maximumNumberOFEnemies = maximumAllowableSpawnedUFO
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        
        //Configuration of UFO Controller

        self.ufoController = UFOController(hud2: self.hud2, ufoSpawningInterval: spawnInterval, minUFOSpawnedPerInterval: minUFOSpawnedPerInterval, maxUFOSpawnedPerInterval: maxUFOSpawnedPerInterval, pathAnimationConfiguration: pathAnimationConfiguration)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        //Set current track
        currenTrack = .UFO
        
        
        //Perform basic configuration and register Notifications for Pause and Resume
        super.didMove(to: view)

        //Configure Background music (this function does not get  the base class's
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: "Drumming Sticks.mp3", forParentNode: self)
        
        //Set zPosition of Player CrossHair
        player.zPosition = 15
        
        //Spawn initial number of UFOs
        ufoController.spawnUFOs(forParentNode: self, numberOfUFOs: self.initialNumberOfEnemiesSpawned)
        
        self.addChild(ufoController)
    }
    
    
    
    //MARK: *************** GAME LOOP FUNCTIONS
    
    override func didSimulatePhysics() {
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        frameCount += currentTime - lastUpdateTime
        
        
        if(!gameHasStarted){
            adjustedCurrentTime = 0
        } else {
            adjustedCurrentTime = currentTime
        }
        
        //Update player CrossHair
        checkPlayerPositionForReposition()
        
        
        //Update controller to spawn UFOs at regular intervals
        ufoController.update(withParentNode: self, currentTime: adjustedCurrentTime)
        
        //Update all of the UFO nodes spawned up to this point
        for node in self.children{
            if let node = node as? UFO{
                node.update(currentTime: currentTime)
            }
        }
       
        //Update the player's position
        player.update()
        
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
        
        super.touchesMoved(touches, with: event)
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        
        
            
            if player.contains(touchLocation){
               
                player.run(shootingSound)
                
                for node in nodes(at: touchLocation){
                    if let node = node as? UFO{
                        if(node.respondToTouch()){
                            currentNumberOfEnemies -= 1
                            numberOfEnemiesKilled += 1
                        
                            hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
                            hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
                        
                        
                        }
                    }
                }
                
                
        }
        
        
        
    }
    
}
    
    
    
   
    
    
    
    
   

    
    
    




extension UFOScene{
    
    override func loadNextLevel(){
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
        
        var nextLevelDifficulty: UFOLevelLoader.DifficultyLevel
        
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
        
        
        var nextLevelScene: UFOScene?
        
        switch(self.levelNumber){

            case 1:
                nextLevelScene = UFOLevelLoader.getLevel2(difficultyLevel: nextLevelDifficulty)
                break
            case 2:
                nextLevelScene = UFOLevelLoader.getLevel3(difficultyLevel: nextLevelDifficulty)
                break
            case 3:
                nextLevelScene = UFOLevelLoader.getLevel4(difficultyLevel: nextLevelDifficulty)
                break
            case 4:
                nextLevelScene = UFOLevelLoader.getLevel5(difficultyLevel: nextLevelDifficulty)
                break
            case 5:
                let transition = SKTransition.crossFade(withDuration: 2.00)
                let summaryScene = SummaryScene(size: self.size, selectedTrackType: .UFO)
                self.view?.presentScene(summaryScene, transition: transition)
                break
            default:
                nextLevelScene = UFOLevelLoader.getLevel1(difficultyLevel: nextLevelDifficulty)
        }
        
        if(nextLevelScene == nil){
            let transition = SKTransition.crossFade(withDuration: 2.00)
            let summaryScene = SummaryScene(size: self.size, selectedTrackType: .UFO)
            self.view?.presentScene(summaryScene, transition: transition)
        } else {
            self.view?.presentScene(nextLevelScene!, transition: mainTransition)

        }
        
        
        
    }
    
    override func reloadCurrentLevel(){
        
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
        
        var currentLevelDifficulty: UFOLevelLoader.DifficultyLevel
        
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
        
        
        var currentLevelScene: UFOScene = UFOLevelLoader.getLevel1(difficultyLevel: currentLevelDifficulty)
        
        switch(self.levelNumber){
            case 5:
                currentLevelScene = UFOLevelLoader.getLevel5(difficultyLevel: currentLevelDifficulty)
            case 4:
                currentLevelScene = UFOLevelLoader.getLevel4(difficultyLevel: currentLevelDifficulty)
            case 3:
                currentLevelScene = UFOLevelLoader.getLevel3(difficultyLevel: currentLevelDifficulty)
            case 2:
                currentLevelScene = UFOLevelLoader.getLevel2(difficultyLevel: currentLevelDifficulty)
            case 1:
                currentLevelScene = UFOLevelLoader.getLevel1(difficultyLevel: currentLevelDifficulty)
            default:
                currentLevelScene = UFOLevelLoader.getLevel1(difficultyLevel: currentLevelDifficulty)
        }
        
        self.view?.presentScene(currentLevelScene, transition: mainTransition)

        
    }
}

