//
//  EnemyTracker.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class EnemyTracker: SKNode, EnemyTrackerDelegate{
    
    weak var managedScene: WingmanScene? {
        
        get{
            return self.parent as! WingmanScene?
        }
        
        set(newManagedScene){
            if let newManagedScene = newManagedScene{
                self.move(toParent: newManagedScene)
            }
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(newManagedScene: WingmanScene) {
        self.init()
        managedScene = newManagedScene
        
       

    }
    
    
    func didBeginGame(){
        if let managedScene = managedScene{
            managedScene.currentNumberOfEnemies = 0
            managedScene.numberOfEnemiesKilled = 0
            
            managedScene.hud2.setNumberOfEnemiesTo(numberOfEnemies: managedScene.currentNumberOfEnemies)
            managedScene.hud2.setNumberOfEnemiesKilledTo(numberKilled: managedScene.numberOfEnemiesKilled)
        }
    }
    
    func didSpawnEnemy(numberOfEnemiesSpawned: Int){
        if let managedScene = managedScene{
            managedScene.currentNumberOfEnemies += numberOfEnemiesSpawned
            managedScene.hud2.setNumberOfEnemiesTo(numberOfEnemies: managedScene.currentNumberOfEnemies)
        }
    }
    
    func didKillEnemy(numberOfEnemiesKilled: Int){
        if let managedScene = managedScene{
            managedScene.numberOfEnemiesKilled += 1
            managedScene.currentNumberOfEnemies -= 1
        
            
            managedScene.hud2.setNumberOfEnemiesTo(numberOfEnemies: managedScene.currentNumberOfEnemies)
            managedScene.hud2.setNumberOfEnemiesKilledTo(numberKilled: managedScene.numberOfEnemiesKilled)
        }
    }
}
