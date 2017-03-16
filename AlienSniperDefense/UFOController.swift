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
    
    
    //MARK: ********** HUD: Controller stores a reference to the HUD that must be updated
    var hud2: HUD2!
    
    //MARK: ************ Variables related to UFO array
    private var ufoArray = [UFO]()
    private var ufoIndex: Int {
        get{
            return GKRandomDistribution(lowestValue: 0, highestValue: ufoArray.count-1).nextInt()
        }
    }
    
    
    //MARK: ************* TOTAL NUMBER OF UFO SPAWNED AND KILLED
    private var totalNumberOfUFOSpawned: Int = 0
    private var totalNumberOfUFOKilled: Int = 0
    

    
    //MARK: ************ INITIALIZERS
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        setup()
    }
    
    convenience init(hud2: HUD2, ufoSpawningInterval: TimeInterval = 10.00, minUFOSpawnedPerInterval: Int = 0,  maxUFOSpawnedPerInterval: Int = 1) {
        
        self.init()
        setup()
        
        //Initialize HUD2 passed in from scene
        self.hud2 = hud2
        
        //Initialize controller spawning parameters
        self.minimumUFOSpawnedPerInterval = minUFOSpawnedPerInterval
        self.maximumUFOSpawnedPerInterval = maxUFOSpawnedPerInterval
        self.ufoSpawningInterval = ufoSpawningInterval
        
        self.totalNumberOfUFOSpawned = 0
        self.totalNumberOfUFOKilled = 0
    }
    
    private func setup(){
        
        //Populate UFO array with UFOs of different speed and color
        if let ufo1 = UFO(ufoType: .Blue, pathAnimationConfiguration: PathAnimationConfiguration(d1: 10, d2: 10, d3: 10, d4: 10, d5: 10)),
            let ufo2 = UFO(ufoType: .Green, pathAnimationConfiguration: PathAnimationConfiguration(d1: 20, d2: 20, d3: 20, d4: 20, d5: 20)),
            let ufo3 = UFO(ufoType: .Red, pathAnimationConfiguration: PathAnimationConfiguration(d1: 5, d2: 10, d3: 15, d4: 20, d5: 25)),
            let ufo4 = UFO(ufoType: .Yellow, pathAnimationConfiguration: PathAnimationConfiguration(d1: 25, d2: 20, d3: 15, d4: 10, d5: 5)),
            let ufo5 = UFO(ufoType: .Blue, pathAnimationConfiguration: PathAnimationConfiguration(d1: 30, d2: 30, d3: 30, d4: 30, d5: 30)),
            let ufo6 = UFO(ufoType: .Red, pathAnimationConfiguration: PathAnimationConfiguration(d1: 9, d2: 8, d3: 7, d4: 6, d5: 5)),
            let ufo7 = UFO(ufoType: .Yellow, pathAnimationConfiguration: PathAnimationConfiguration(d1: 5, d2: 6, d3: 7, d4: 8, d5: 9)),
            let ufo8 = UFO(ufoType: .Green, pathAnimationConfiguration: PathAnimationConfiguration(d1: 15, d2: 15, d3: 15, d4: 15, d5: 15)){
            
            ufoArray = [
                ufo1,   //Blue UFO
                ufo2,   //Green UFO
                ufo3,   //Red UFO
                ufo4,   //Yellow UFO
                ufo5,   //Blue UFO
                ufo6,   //Red UFO
                ufo7,    //Yellow UFO
                ufo8    //Green UFO
                
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
            
           
            
            let randomDist = GKRandomDistribution(lowestValue: 100, highestValue: 150)
            
            let duration1 = Double(randomDist.nextUniform())
            let duration2 = Double(randomDist.nextUniform())
            let duration3 = Double(randomDist.nextUniform())
            let duration4 = Double(randomDist.nextUniform())
            let duration5 = Double(randomDist.nextUniform())
            
            ufoClone.performUFOConfiguration(duration1: duration1, duration2: duration2, duration3: duration3, duration4: duration4, duration5: duration5)
         
            self.addChild(ufoClone)
            
            totalNumberOfUFOSpawned += 1
            hud2.setNumberOfEnemiesTo(numberOfEnemies: totalNumberOfUFOSpawned)
        }
        
    }
    
    func spawnRandomNumberOfUFOsFrom(minimum: Int, toMaximum maximum: Int){
        let numberOfUFO = GKRandomDistribution(lowestValue: minimum, highestValue: maximum).nextInt()
        
        for _ in 0...numberOfUFO{
            
            let ufoClone = ufoArray[ufoIndex].copy() as! UFO
            
            let randomDist = GKRandomDistribution(lowestValue: 100, highestValue: 150)
            
            let duration1 = Double(randomDist.nextUniform())
            let duration2 = Double(randomDist.nextUniform())
            let duration3 = Double(randomDist.nextUniform())
            let duration4 = Double(randomDist.nextUniform())
            let duration5 = Double(randomDist.nextUniform())
            

            
            ufoClone.performUFOConfiguration(duration1: duration1, duration2: duration2, duration3: duration3, duration4: duration4, duration5: duration5)
            
            self.addChild(ufoClone)
            
            totalNumberOfUFOSpawned += 1
            hud2.setNumberOfEnemiesTo(numberOfEnemies: totalNumberOfUFOSpawned)
        }
        
    }
    
    
    //MARK: ********** Touch Response Functions
    
    func respondToTouch(touchLocation: CGPoint){
        
        for node in self.children{
            if let node = node as? UFO{
                if node.contains(touchLocation){
                    node.respondToTouch()
                    totalNumberOfUFOSpawned -= 1
                    totalNumberOfUFOKilled += 1
                    
                    //Update HUD
                    hud2.setNumberOfEnemiesTo(numberOfEnemies: totalNumberOfUFOSpawned)
                    hud2.setNumberOfEnemiesKilledTo(numberKilled: totalNumberOfUFOKilled)
                    
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
