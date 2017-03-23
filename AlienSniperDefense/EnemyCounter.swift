//
//  EnemyCounter.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class EnemyCounter: SKNode, EnemyCounterDelegate{
    
    
    weak var baseScene: BaseScene? {
        set(newBaseScene){
            if(newBaseScene != nil){
                self.move(toParent: newBaseScene!)
            }
        }
        
        get{
            return self.parent! as? BaseScene
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(baseScene: BaseScene) {
        self.init()
        
        self.baseScene = baseScene
    }
    
    

    func didIncreaseOnScreenEnemyCountBy(amountOfIncrease: Int){
        if let baseScene = baseScene{
            baseScene.currentNumberOfEnemies += amountOfIncrease
            let newNumberOfEnemies = baseScene.currentNumberOfEnemies
            baseScene.hud2.setNumberOfEnemiesTo(numberOfEnemies: newNumberOfEnemies)
        }
        
    }
    
    func didKillOnScreenEnemies(numberOfEnemiesKilled: Int){
        if let baseScene = baseScene{
            baseScene.numberOfEnemiesKilled += 1
            baseScene.currentNumberOfEnemies -= 1
            
            if(baseScene.currentNumberOfEnemies < 0){
                baseScene.currentNumberOfEnemies = 0
            }
            
            let newNumberOfEnemies = baseScene.currentNumberOfEnemies
            let newNumberOfKills = baseScene.numberOfEnemiesKilled
            
            baseScene.hud2.setNumberOfEnemiesTo(numberOfEnemies: newNumberOfEnemies)
            baseScene.hud2.setNumberOfEnemiesKilledTo(numberKilled: newNumberOfKills)
        }
    }
    
}
