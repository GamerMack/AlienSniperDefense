//
//  BatController.swift
//  AlienBusters
//
//  Created by Aleksander Makedonski on 3/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class BatController: SKNode{
    
    //MARK: ************  Timer-related variables
    private var frameCount = 0.0
    private var lastUpdateTime = 0.0
    private var batSpawningInterval = 10.0
    private var minimumBatsSpawnedPerInterval: Int = 0
    private var maximumBatsSpawnedPerInterval: Int = 1
    
    //MARK: ********** HUD: Controller stores a reference to the HUD that must be updated
    var hud2: HUD2!
    
    //MARK: ************ Variables related to bats array
    private var batsArray = [Bat]()
    private var batIndex: Int {
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: batsArray.count-1).nextInt()
        }
    }
    
    //MARK: ************* TOTAL NUMBER OF UFO SPAWNED AND KILLED
    private var totalNumberOfBatsSpawned: Int = 0
    private var totalNumberOfBatsKilled: Int = 0
    
    
    
    //MARK: ************* TOTAL NUMBER OF BATS SPAWNED
    private var initialNumberOfBatsSpawned: Int = 0
    

    
    //MARK: ************ INITIALIZERS
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        setup()
    }
    
    
    convenience init(hud2: HUD2, batSpawningInterval: TimeInterval, minBatsSpawned: Int = 0,  maxBatsSpawned: Int = 1) {
        
        self.init()
        setup()     //Call setup to populate the array with a variety of Bats
        
        //Initialize hud2 passed in from scene
        self.hud2 = hud2
        
        
        //Initialize timing-related variables
        self.minimumBatsSpawnedPerInterval = minBatsSpawned
        self.maximumBatsSpawnedPerInterval = maxBatsSpawned
        self.batSpawningInterval = batSpawningInterval
        
        //Initialize spawn count and kill count to zero
        self.totalNumberOfBatsSpawned = 0
        self.totalNumberOfBatsKilled = 0
    }

    private func setup(){
   
        if let bat1 =  Bat(scalingFactor: 0.7, startingHealth: 2, minXVelocity: 0, maxXVelocity: 10, minYVelocity: 0, maxYVelocity: 10),
            let bat2 =  Bat(scalingFactor: 1.5, startingHealth: 2, minXVelocity: 0, maxXVelocity: 10, minYVelocity: 0, maxYVelocity: 10),
            let bat3 =  Bat(scalingFactor: 0.5, startingHealth: 2, minXVelocity: 0, maxXVelocity: 10, minYVelocity: 0, maxYVelocity: 10),
            let bat4 =  Bat(scalingFactor: 1.8, startingHealth: 2, minXVelocity: 0, maxXVelocity: 10, minYVelocity: 0, maxYVelocity: 10),
            let bat5 =  Bat(scalingFactor: 0.9, startingHealth: 2, minXVelocity: 0, maxXVelocity: 10, minYVelocity: 0, maxYVelocity: 10){
                batsArray = [ bat1, bat2, bat3, bat4, bat5 ]
            
        }
        
      
    }
    
    func setInitialNumberOfBatsSpawnedTo(numberOfBatsSpawned: Int){
        self.initialNumberOfBatsSpawned = numberOfBatsSpawned
    }
    
    //MARK: ******* GAME LOOP FUNCTIONS
    
    
    //********* update(minaBatsSpawnedPerInterval:maxBatsSpawnedPerInterval:) will spawn bats at random intervals (called in game scene's update function)
    func update(forParentNode parentNode: BatScene, currentTime: TimeInterval){
        
        frameCount += currentTime - lastUpdateTime
        
        if(frameCount > batSpawningInterval){
            
            spawnRandomNumberOfBatsFrom(forParentNode: parentNode, minimum: self.minimumBatsSpawnedPerInterval, toMaximum: self.maximumBatsSpawnedPerInterval)
            
            frameCount = 0.0
        }
       
        
        lastUpdateTime = currentTime
    }
    
    
    //MARK: ************* Bat spawning functions
    
    func spawnBats(forParentNode parentNode: BatScene, numberOfBats: Int?){
        
        let numberOfBatsToSpawn = numberOfBats ?? initialNumberOfBatsSpawned
        
        for _ in 0...numberOfBatsToSpawn{
            
            let batClone = batsArray[batIndex].copy() as! Bat
            configurePhysicsForClone(batClone: batClone)
            parentNode.addChild(batClone)
            
            //Update the current spawn count for the BatScene
            parentNode.currentNumberOfEnemies += 1
            hud2.setNumberOfEnemiesTo(numberOfEnemies: parentNode.currentNumberOfEnemies)
        }
        
    }
    
    func spawnRandomNumberOfBatsFrom(forParentNode parentNode: BatScene, minimum: Int, toMaximum maximum: Int){
        let numberOfBats = GKRandomDistribution(lowestValue: minimum, highestValue: maximum).nextInt()
        
        for _ in 0...numberOfBats{
            
            let batClone = batsArray[batIndex].copy() as! Bat
            configurePhysicsForClone(batClone: batClone)
            parentNode.addChild(batClone)
            
            //Update the current spawn count for the BatScene
            parentNode.currentNumberOfEnemies += 1
            hud2.setNumberOfEnemiesTo(numberOfEnemies: parentNode.currentNumberOfEnemies)


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
    
    
    func getTotalNumberOfBatSpawned() -> Int{
        return totalNumberOfBatsSpawned
    }
    
  
   
    


    
}
