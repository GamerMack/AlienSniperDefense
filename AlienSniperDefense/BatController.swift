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
    private var minimumBatsSpawnedPerInterval: Int = 0
    private var maximumBatsSpawnedPerInterval: Int = 1
    
    //MARK: ************ Variables related to bats array
    private var batsArray = [Bat]()
    private var batIndex: Int {
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: batsArray.count-1).nextInt()
        }
    }
    
    
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
    
    
    convenience init(minBatsSpawned: Int = 0,  maxBatsSpawned: Int = 1) {
        
        self.init()
        setup()
        self.minimumBatsSpawnedPerInterval = minBatsSpawned
        self.maximumBatsSpawnedPerInterval = maxBatsSpawned
    }

    private func setup(){
        
        if let bat1 = Bat(scalingFactor: 0.3), let bat2 = Bat(scalingFactor: 0.6), let bat3 = Bat(scalingFactor: 1.0), let bat4 = Bat(scalingFactor: 2.0), let bat5 = Bat(scalingFactor: 4.0){
                batsArray = [ bat1, bat2, bat3, bat4, bat5 ]
            
        }
        
      
    }
    
    func setInitialNumberOfBatsSpawnedTo(numberOfBatsSpawned: Int){
        self.initialNumberOfBatsSpawned = numberOfBatsSpawned
    }
    
    //MARK: ******* GAME LOOP FUNCTIONS
    
    
    //********* update(minaBatsSpawnedPerInterval:maxBatsSpawnedPerInterval:) will spawn bats at random intervals (called in game scene's update function)
    func update(forParentNode parentNode: BatScene, minBatsSpawnedPerInterval: Int, maxBatsSpawnedPerInterval: Int){
        
        spawnRandomNumberOfBatsFrom(forParentNode: parentNode, minimum: minBatsSpawnedPerInterval, toMaximum: maxBatsSpawnedPerInterval)
        
    }
    
    
    //MARK: ************* Bat spawning functions
    
    func spawnBats(forParentNode parentNode: BatScene, numberOfBats: Int?){
        
        let numberOfBatsToSpawn = numberOfBats ?? initialNumberOfBatsSpawned
        
        for _ in 0...numberOfBatsToSpawn{
            
            let batClone = batsArray[batIndex].copy() as! Bat
            configurePhysicsForClone(batClone: batClone)
            parentNode.addChild(batClone)
            parentNode.currentNumberOfEnemies += 1
        }
        
    }
    
    func spawnRandomNumberOfBatsFrom(forParentNode parentNode: BatScene, minimum: Int, toMaximum maximum: Int){
        let numberOfBats = GKRandomDistribution(lowestValue: minimum, highestValue: maximum).nextInt()
        
        for _ in 0...numberOfBats{
            
            let batClone = batsArray[batIndex].copy() as! Bat
            configurePhysicsForClone(batClone: batClone)
            parentNode.addChild(batClone)
            parentNode.currentNumberOfEnemies += 1
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
