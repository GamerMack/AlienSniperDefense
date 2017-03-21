//
//  EnemyTrackerDelegate.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


protocol  EnemyTrackerDelegate: class {
    
    
    weak var managedScene: WingmanScene? { get set }
    
  
    func didBeginGame()

    func didSpawnEnemy(numberOfEnemiesSpawned: Int)
  
    func didKillEnemy(numberOfEnemiesKilled: Int)
}
