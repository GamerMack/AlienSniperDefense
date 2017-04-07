//
//  StealthShipScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class StealthShipScene: BaseScene{
    

    /**SpaceShip types
    Red Color: Red1,Red2,Red3
    Blue Color: Blue1,Blue2,Blue3
    Green Color: Green1,Green2,Green3
    Orange Color: Orange1,Orange2,Orange3
     **/
    
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
            hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        }
    }
    
    //SpaceShip Prototype
    var spaceShips: [SpaceShip] = [
        SpaceShip(spaceShipTypeOf: .Red1, travelSpeedOf: 5.0, scalingFactor: 0.8)!,
        SpaceShip(spaceShipTypeOf: .Red2, travelSpeedOf: 5.0, scalingFactor: 0.8)!,
        SpaceShip(spaceShipTypeOf: .Red3, travelSpeedOf: 5.0, scalingFactor: 0.8)!,
        SpaceShip(spaceShipTypeOf: .Blue1, travelSpeedOf: 5.0, scalingFactor: 0.8)!,
        SpaceShip(spaceShipTypeOf: .Blue2, travelSpeedOf: 5.0, scalingFactor: 0.8)!,
        SpaceShip(spaceShipTypeOf: .Blue3, travelSpeedOf: 5.0, scalingFactor: 0.8)!,
    
    ]
    
    var spaceShipTransitionInterval: TimeInterval = 3.00
    var spaceShipFlySpeed: TimeInterval = 5.00
    var adjustedCurrentTime: TimeInterval = 0.00
    var adjustedLastUpdateTime: TimeInterval = 0.00
    
    var currentSpaceShipIndex: Int = 0
    
    var randomSpaceShipIndex: Int {
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: backgroundObjectsPositions.count-1).nextInt()
        }
    }
    
    
    

    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, playerType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, spaceShipTravelSpeed: TimeInterval, spaceShipTransitionInterval: TimeInterval, maximumNumberOfEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, timeLimit: TimeInterval = 60.00) {
        
        self.init(size: size)
        
        //Configure spaceship parameters
        self.spaceShipTransitionInterval = spaceShipTransitionInterval
        self.spaceShipFlySpeed = spaceShipTravelSpeed
        
        //Configure Time Limit for Time Limit Mode
        self.timeLimit = timeLimit
        
        
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
        self.maximumNumberOFEnemies = maximumNumberOfEnemiesAllowed
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        //Configure background objects
        self.numberOfBackgroundObjects = numberOfBackgroundObjects

        
    }
    
    
    private func configureStealthModeIntervalTimes(stealthInterval: TimeInterval){
        for ship in spaceShips{
            ship.resetFlyModeTransitionInterval(toFlyModeTransitionInterval: stealthInterval)
        }
    }
    
    
    private func configureSpaceShipTravelSpeeds(spaceShipTravelSpeed: TimeInterval){

        for ship in spaceShips{
            ship.resetFlySpeed(toFlyingSpeedOf: spaceShipTravelSpeed)
        }
    }
    
    override func didMove(to view: SKView) {
        //Set current track
        currenTrack = .StealthShip
        
        
        //Perform basic scene configuration and register NSNotifications for pause and resume
        super.didMove(to: view)
        
        //Configure Background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.MissionPlausible, forParentNode: self)
        
        //Spawn first spaceship
        spawnSpaceShipFromArray()

    }
    
    
    
    //MARK: *************** GAME LOOP FUNCTIONS
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if(!gameHasStarted){
            frameCount = 0
            adjustedCurrentTime = 0
        } else {
            adjustedCurrentTime = currentTime
        }
        
        frameCount += adjustedCurrentTime - adjustedLastUpdateTime
        
        
        if(frameCount > spawnInterval){
            //spawn the spaceships from an array
            spawnSpaceShipFromArray()
            frameCount = 0
        }
        
        
        updateAllSpaceShips(currentTime: adjustedCurrentTime)
        
        
        //Update the player's position
        player.update()
        
        adjustedLastUpdateTime = adjustedCurrentTime
        lastUpdateTime = currentTime
    }
    
    
    //Helper function for update method
    private func updateAllSpaceShips(currentTime: TimeInterval){
        for node in self.children{
            if let node = node as? SpaceShip{
                node.update(currentTime: currentTime)
            }
        }
    }
    
    
    
    //MARK: ******************* USER INPUT HANDLERS
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let node = touches.first! as UITouch
        let touchLocation = node.location(in: self)
        
        player.setTargetPosition(position: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        
        if player.contains(touchLocation){
            player.run(shootingSound)

            for node in nodes(at: touchLocation){
                
                if node.name == "SpaceShip"{
                    
                    guard let node = node as? SpaceShip else { return }
                    
                    if(kDebug){
                        print("The space ship's health is \(node.getHealth())")
                    }
                    
                    switch(node.getHealth()){
                    case 2:
                        if(kDebug){
                            print("The space ship took damage")
                        }
                        node.takeDamage1()

                        break
                    case 1:
                        if(kDebug){
                            print("The space ship took damage")
                        }
                        node.takeDamage2()
        
                        break
                    case 0:
                        if(kDebug){
                            print("The space ship died")
                        }
                        
                        let isBeingRemovedStatus = node.userData?.value(forKey: "isBeingRemovedStatus")
                        
                        if(isBeingRemovedStatus != nil), let isBeingRemovedStatus = isBeingRemovedStatus as? Bool, isBeingRemovedStatus == true{
                            return
                        } else {
                            node.userData = NSMutableDictionary()
                            node.userData?.setValue(true, forKey: "isBeingRemovedStatus")
                            
                            node.run(SKAction.group([
                                explosionSound,
                                explosionAnimation
                                ]))
                            node.run(SKAction.sequence([
                                SKAction.wait(forDuration: 2.0),
                                SKAction.removeFromParent()
                                ]))
                            numberOfEnemiesKilled += 1
                        }
                        break
                    default:
                        print("The space ship died")
                    
                        node.run(SKAction.group([
                            explosionSound,
                            explosionAnimation
                            ]))
                        node.run(SKAction.sequence([
                            SKAction.wait(forDuration: 2.0),
                            SKAction.removeFromParent()
                            ]))
            
                        numberOfEnemiesKilled += 1
                        break
                    
                }
                    
                    
            }
        }
        
            
        }
        
    }
    
    override func spawnEnemyFromPrototype(numberOfEnemy: Int) {
        for _ in 0..<numberOfEnemy{
            
            spawnSpaceShipFromArray()
            
        }
    }
    
    private func spawnSpaceShipFromArray(){
        
        if(currentSpaceShipIndex > spaceShips.count-1){
            currentSpaceShipIndex = 0
        }
        
        let spaceShip = spaceShips[currentSpaceShipIndex].copy() as! SpaceShip
        
        spaceShip.zPosition = player.zPosition-1
        spaceShip.name = "SpaceShip"
        spaceShip.userData?.setValue(2, forKey: "health")
        
        spaceShip.move(toParent: self)
        currentSpaceShipIndex += 1
        currentNumberOfEnemies += 1
        

        
    }

    
    private func spawnEnemyFromRandomArrayIndex(){
        
        let spaceShip = spaceShips[randomSpaceShipIndex]
        
        spaceShip.name = "SpaceShip"
        
        spaceShip.userData?.setValue(2, forKey: "health")
        currentNumberOfEnemies += 1
        spaceShip.move(toParent: self)
        
        
    }
    

  
    
    
    
}


extension StealthShipScene{
    
    override func reloadCurrentLevel() {
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
        var currentLevelDifficulty: StealthShipSceneLevelLoader.DifficultyLevel
        
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
        
        
        var currentLevelScene: StealthShipScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
        
        switch(self.levelNumber){
        case 5:
            currentLevelScene = StealthShipSceneLevelLoader.loadLevel5(difficultyLevel: currentLevelDifficulty)
            break
        case 4:
            currentLevelScene = StealthShipSceneLevelLoader.loadLevel4(difficultyLevel: currentLevelDifficulty)
            break
        case 3:
            currentLevelScene = StealthShipSceneLevelLoader.loadLevel3(difficultyLevel: currentLevelDifficulty)
            break
        case 2:
            currentLevelScene = StealthShipSceneLevelLoader.loadLevel2(difficultyLevel: currentLevelDifficulty)
            break
        case 1:
            currentLevelScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
            break
        default:
            currentLevelScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: currentLevelDifficulty)
            break
        }
        
        self.view?.presentScene(currentLevelScene, transition: mainTransition)
        
        
    }
    
    override func loadNextLevel() {
        let mainTransition = SKTransition.crossFade(withDuration: 2.00)
        
        var nextLevelScene: StealthShipScene?
        
        var nextLevelDifficulty: StealthShipSceneLevelLoader.DifficultyLevel
        
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
        
        switch(self.levelNumber){
       
            case 1:
                nextLevelScene = StealthShipSceneLevelLoader.loadLevel2(difficultyLevel: nextLevelDifficulty)
                break
            case 2:
                nextLevelScene = StealthShipSceneLevelLoader.loadLevel3(difficultyLevel: nextLevelDifficulty)
                break
            case 3:
                nextLevelScene = StealthShipSceneLevelLoader.loadLevel4(difficultyLevel: nextLevelDifficulty)
                break
            case 4:
                nextLevelScene = StealthShipSceneLevelLoader.loadLevel5(difficultyLevel: nextLevelDifficulty)
                break
            case 5:
                let transition = SKTransition.crossFade(withDuration: 2.00)
                let summaryScene = SummaryScene(size: self.size, selectedTrackType: .StealthShip)
                self.view?.presentScene(summaryScene, transition: transition)
                break
        default:
            nextLevelScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: nextLevelDifficulty)
        }
        
        if(nextLevelScene == nil){
            let transition = SKTransition.crossFade(withDuration: 2.00)
            let summaryScene = SummaryScene(size: self.size, selectedTrackType: .StealthShip)
            self.view?.presentScene(summaryScene, transition: transition)
        } else {
            self.view?.presentScene(nextLevelScene!, transition: mainTransition)
        }
        
    }
    
}


