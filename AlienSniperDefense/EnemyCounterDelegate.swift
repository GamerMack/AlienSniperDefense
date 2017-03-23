//
//  EnemyCounterDelegate.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


protocol EnemyCounterDelegate{
    
    weak var baseScene: BaseScene? { get set }
    
    func didIncreaseOnScreenEnemyCountBy(amountOfIncrease: Int)

    func didKillOnScreenEnemies(numberOfEnemiesKilled: Int)

}
