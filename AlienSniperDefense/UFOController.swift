//
//  UFOController.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class UFOController: SKNode{
    
    //MARK: ************  Timer-related variables
    private var frameCount = 0.0
    private var lastUpdateTime = 0.0
    private var ufoSpawningInterval = 10.0
    private var minimumUFOSpawnedPerInterval: Int = 0
    private var maximumUFOSpawnedPerInterval: Int = 1
    
    
    //MARK: ************ Variables related to UFO array
    private var ufoArray = [UFO]()
    private var ufoIndex: Int {
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: ufoArray.count-1).nextInt()
        }
    }
    
    
    //MARK: ************* TOTAL NUMBER OF BATS SPAWNED
    private var totalNumberOfUFOSpawned: Int = 0
    
    

    
    //MARK: ************ INITIALIZERS
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        setup()
    }
    
    convenience init(ufoSpawningInterval: TimeInterval = 10.00, minUFOSpawnedPerInterval: Int = 0,  maxUFOSpawnedPerInterval: Int = 1) {
        
        self.init()
        setup()
        
        self.minimumUFOSpawnedPerInterval = minUFOSpawnedPerInterval
        self.maximumUFOSpawnedPerInterval = maxUFOSpawnedPerInterval
        self.ufoSpawningInterval = ufoSpawningInterval
        
        self.totalNumberOfUFOSpawned = 0
    }
    
    private func setup(){
        
        //Populate UFO array with UFOs of different speed and color
        if let ufo1 = UFO(ufoType: .Blue, pathAnimationDuration: 3.00),
            let ufo2 = UFO(ufoType: .Green, pathAnimationDuration: 6.00),
            let ufo3 = UFO(ufoType: .Red, pathAnimationDuration: 10.00),
            let ufo4 = UFO(ufoType: .Yellow, pathAnimationDuration: 15.0),
            let ufo5 = UFO(ufoType: .Blue, pathAnimationDuration: 10.00),
            let ufo6 = UFO(ufoType: .Red, pathAnimationDuration: 6.00),
            let ufo7 = UFO(ufoType: .Yellow, pathAnimationDuration: 4.00),
            let ufo8 = UFO(ufoType: .Green, pathAnimationDuration: 4.00){
            
            ufoArray = [
                ufo1,   //Fast Blue UFO
                ufo2,   //Average Green UFO
                ufo3,   //Slow Red UFO
                ufo4,   //Slow Yellow UFO
                ufo5,   //Slow Blue UFO
                ufo6,   //Average Red UFO
                ufo7,    //Fast Yellow UFO
                ufo8    //Fast Green UFO
                
                ]
        }

        
    }
    
    func update(currentTime: TimeInterval){
        
        frameCount += currentTime - lastUpdateTime
        
        if(frameCount > ufoSpawningInterval){
            spawnRandomNumberOfUFOsFrom(minimum: self.minimumUFOSpawnedPerInterval, toMaximum: self.maximumUFOSpawnedPerInterval)
            
            
            //Update all UFOs in the node
            for node in self.children{
                if let node = node as? UFO{
                    node.update(currentTime: currentTime)
                }
            }
            
            frameCount = 0
        }
        
        lastUpdateTime = currentTime
        
    }
    
    
    
    //MARK: ********** Spawning Functions
   
    
    func spawnUFOs(numberOfUFOs: Int){
        
        for _ in 0...numberOfUFOs{
            
            let ufoClone = ufoArray[ufoIndex].copy() as! UFO
            
            let randomPathDuration = Double(GKRandomDistribution(lowestValue: 10, highestValue: 15).nextUniform())
            
            ufoClone.performUFOConfiguration(withPathAnimationDurationOf: randomPathDuration)
            /**
            ufoClone.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            ufoClone.physicsBody?.affectedByGravity = false
            ufoClone.physicsBody?.allowsRotation = false
            ufoClone.physicsBody?.linearDamping = 0.0
             **/
            self.addChild(ufoClone)
            totalNumberOfUFOSpawned += 1
        }
        
    }
    
    func spawnRandomNumberOfUFOsFrom(minimum: Int, toMaximum maximum: Int){
        let numberOfUFO = GKRandomDistribution(lowestValue: minimum, highestValue: maximum).nextInt()
        
        for _ in 0...numberOfUFO{
            
            let ufoClone = ufoArray[ufoIndex].copy() as! UFO
            
            let randomPathDuration = Double(GKRandomDistribution(lowestValue: 10, highestValue: 15).nextUniform())
            
            ufoClone.performUFOConfiguration(withPathAnimationDurationOf: randomPathDuration)
            
            /**
            let radius = ufoClone.size.width/2.0
            ufoClone.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            ufoClone.physicsBody?.affectedByGravity = false
            ufoClone.physicsBody?.allowsRotation = false
            ufoClone.physicsBody?.linearDamping = 0.0
             **/
            self.addChild(ufoClone)
            
            totalNumberOfUFOSpawned += 1
        }
        
    }
    
    
    //MARK: ********** Touch Response Functions
    
    func respondToTouch(touchLocation: CGPoint){
        
        for node in self.children{
            if let node = node as? UFO{
                if node.contains(touchLocation){
                    node.respondToTouch()
                }
            }
        }
        
    }
    
    func getTotalNumberOfUFOSpawned() -> Int{
        return totalNumberOfUFOSpawned
    }
    
    func reduceTotalNumberOfUFOSpawnedBy(numberEliminated: Int){
        totalNumberOfUFOSpawned -= numberEliminated
    }
    
    func getTotalUFOCount() -> Int{
        
        var numberOfUFO = 0
        
        for node in self.children{
            if node is UFO{
                numberOfUFO += 1
            }
        }
        
        return numberOfUFO
    }

    
    
}
