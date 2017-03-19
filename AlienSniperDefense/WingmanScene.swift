//
//  BaseScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class WingmanScene: BaseScene{
    
    //Enemy Prototype
    lazy var enemy: Enemy = {
        let randomScalingFactor = RandomFloatRange(min: 0.7, max: 1.4)
        let wingman = Wingman(scalingFactor: randomScalingFactor)!
        return wingman
        
    }()
    
    
    //MARK: ********* Variables-Related to Wingman Configuration
    var randomVectorConfigurationForUpdate: RandomVectorConfiguration = RandomVectorConfiguration(minimumVectorYComponent: -50.00, maximumVectorYComponent: 50.00, minimumVectorXComponent: -50.00, maximumVectorXComponent: 50.00)
    
    var hideIntervalFrameCount: TimeInterval = 0.00
    var hideInterval: TimeInterval = 8.00
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, playerType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, hideInterval: TimeInterval, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, randomVectorConfigurationForUpdate: RandomVectorConfiguration, maximumEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int) {
        
        
        //Delegate to designated initializer
        self.init(size: size)

        //Configure Opening/Intro Start Window
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = playerType
        self.backGroundMusic = backgroundMusic
        
        
        //Configure Game Rules and basic AI logic
        self.spawnInterval = spawnInterval
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.maximumNumberOFEnemies = maximumEnemiesAllowed
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        //Configure background objects
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        
        //Configure Wingman-related properties
        self.hideInterval = hideInterval
        self.randomVectorConfigurationForUpdate = randomVectorConfigurationForUpdate
    }
    
    
    //MARK: **************** Functions for handling user input
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)

        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
    
        for node in nodes(at: touchLocation){
            if let node = node as? Wingman, player.contains(touchLocation){
                node.run(SKAction.sequence([
                    explosionSound,
                    explosionAnimation
                    ]))
                
                currentNumberOfEnemies -= 1
                numberOfEnemiesKilled += 1
                
                hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
                hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
                
            } else {
                player.run(shootingSound)
            }
        }
    }




    override func didMove(to view: SKView) {
        //Basic Scene Configuration, Register NSNotifications for Pause and Resume
        super.didMove(to: view)
        
        //Configure Background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.MissionPlausible, forParentNode: self)
        
        //Populate WingmanArray
        spawnEnemyFromPrototype(numberOfEnemy: self.initialNumberOfEnemiesSpawned)
        
    }
    
    //MARK: ************ Game Loop Functions
    
    override func didSimulatePhysics() {
        updateAllWingmanPhysics()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        super.update(currentTime)
        
    
        frameCount += currentTime - lastUpdateTime
        hideIntervalFrameCount += currentTime - lastUpdateTime
    
        player.update()
    
        if(frameCount > spawnInterval){
                spawnEnemyFromPrototype(numberOfEnemy: enemiesSpawnedPerInterval)
                frameCount = 0
        }
    
    
        if(hideIntervalFrameCount > hideInterval){
                hideAllWingman()
                hideIntervalFrameCount = 0
        }
    
        lastUpdateTime = currentTime
    }
    
    //MARK: Enemy Spawning Functions
    override func spawnEnemyFromPrototype(numberOfEnemy: Int){
        
        for _ in 0..<numberOfEnemy{
            let randomScaleFactor = RandomFloatRange(min: 0.4, max: 0.7)
            
            let enemy = self.enemy as! Wingman
            let enemyCopy = enemy.copy() as! Wingman
            
            configurePhysicsForEnemyCopy(enemyCopy: enemyCopy)
            
            enemyCopy.xScale *= randomScaleFactor
            enemyCopy.yScale *= randomScaleFactor
            
            let randomSpawnPoint = randomPointGenerator.getRandomPointInRandomQuadrant()
            enemyCopy.position = randomSpawnPoint
            enemyCopy.name = "wingman"
            
            currentNumberOfEnemies += 1
            enemyCopy.move(toParent: self)
            
        }
        
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        
    }
    
    
    private func configurePhysicsForEnemyCopy(enemyCopy: Wingman){
        
        let enemySize = enemyCopy.size.width/2
        enemyCopy.physicsBody = SKPhysicsBody(circleOfRadius: enemySize)
        enemyCopy.physicsBody?.affectedByGravity = false
        enemyCopy.physicsBody?.allowsRotation = false
        enemyCopy.physicsBody?.linearDamping = 0.0
        enemyCopy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemyCopy.physicsBody?.collisionBitMask = ~PhysicsCategory.Player
        
    }

    
    //MARK: *************** Private helper functions related to Wingman animation and AI
    
    //Helper function for update method
    private func updateAllWingmanPhysics(){
        
        
        for node in self.children{
            if let node = node as? Wingman{
                node.updatePhysicsWith(randomVectorConfiguration: self.randomVectorConfigurationForUpdate)
            }
        }
    }
    
    
    private func hideAllWingman(){
        for node in self.children{
            if let node = node as? Wingman{
                node.run(SKAction.move(to: getPositionOfRandomBackgroundObject(), duration: 0.50))
                node.zPosition = -2
            }
        }
    }
    
    private func getPositionOfRandomBackgroundObject() -> CGPoint{
        
        let randomDist = GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjectsPositions.count-1)
        
        let randomIndex = randomDist.nextInt()
        
        return backgroundObjectsPositions[randomIndex]
        
        
    }
   
}


extension WingmanScene{
    
    override func reloadCurrentLevel() {
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
      
        
        var currentLevelDifficulty: WingmanSceneLevelLoader.DifficultyLevel
        
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
        
        var currentLevelScene: WingmanScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        
        
        switch(self.levelNumber){
        case 5:
            currentLevelScene = WingmanSceneLevelLoader.loadLevel5(difficultyLevel: currentLevelDifficulty)
        case 4:
            currentLevelScene = WingmanSceneLevelLoader.loadLevel4(difficultyLevel: currentLevelDifficulty)
        case 3:
            currentLevelScene = WingmanSceneLevelLoader.loadLevel3(difficultyLevel: currentLevelDifficulty)
        case 2:
            currentLevelScene = WingmanSceneLevelLoader.loadLevel2(difficultyLevel: currentLevelDifficulty)
        case 1:
            currentLevelScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        default:
            currentLevelScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        }
        
        self.view?.presentScene(currentLevelScene, transition: mainTransition)
        
        
    }
    
    
    override func loadNextLevel() {
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
        var nextLevelDifficulty: WingmanSceneLevelLoader.DifficultyLevel
        
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
        
        var nextLevelScene: WingmanScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: nextLevelDifficulty)
        
        
        
        switch(self.levelNumber){
        case 5:
                //Load player status summary scene
                let transition = SKTransition.crossFade(withDuration: 2.00)
                let summaryScene = PlayerStatsSummaryScene(size: self.size, selectedTrackType: .Wingman)
                self.view?.presentScene(summaryScene, transition: transition)
            break
        case 4:
            nextLevelScene = WingmanSceneLevelLoader.loadLevel5(difficultyLevel: nextLevelDifficulty)
        case 3:
            nextLevelScene = WingmanSceneLevelLoader.loadLevel4(difficultyLevel: nextLevelDifficulty)
        case 2:
            nextLevelScene = WingmanSceneLevelLoader.loadLevel3(difficultyLevel: nextLevelDifficulty)
        case 1:
            nextLevelScene = WingmanSceneLevelLoader.loadLevel2(difficultyLevel: nextLevelDifficulty)
        default:
            nextLevelScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: nextLevelDifficulty)
        }
        
        self.view?.presentScene(nextLevelScene, transition: mainTransition)
        
    }
    
}
