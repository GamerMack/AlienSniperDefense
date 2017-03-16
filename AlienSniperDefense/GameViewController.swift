//
//  GameViewController.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SoundLoader.preloadSounds()

        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        
            let pathAnimationConfiguration = PathAnimationConfiguration(d1: 50, d2: 50, d3: 50, d4: 50, d5: 50)
        
        let ufoScene = UFOScene(size: self.view.bounds.size, levelNumber: 5, levelDescription: "Kill em!", enemyName: "ETs", crossHairType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 4, spawnInterval: 3.0, initialNumberOfEnemiesSpawned: 1, minUFOSpawnedPerInterval: 0, maxUFOSpawnedPerInterval: 1, minimumKillsForLevelCompletion: 2, maximumAllowableSpawnedUFO: 10, pathAnimationConfiguration: pathAnimationConfiguration)
        
            // Set the scale mode to scale to fit the window
            ufoScene.scaleMode = .aspectFill
                
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(ufoScene)
                    
                view.ignoresSiblingOrder = true
                    
                view.showsFPS = true
                view.showsNodeCount = true
                }
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
