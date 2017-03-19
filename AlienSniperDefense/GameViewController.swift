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
        
        let ufoScene = UFOLevelLoader.getLevel1(difficultyLevel: .Easy)
        
        let batScene = BatScene(size: self.view.bounds.size, levelNumber: 1, levelDescription: "Kill the bats", enemyName: "Bat", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 3, spawnInterval: 10.0, initialNumberOfEnemiesSpawned: 0, minBatsSpawned: 0, maxBatsSpawned: 5, minBatComponentVelocity: 60.00, maxBatComponentVelocity: 80.00, lightNodeFallOff: 2.00, maximumBatsAllowedToSpawn: 40, minimumBatsKilledForLevelCompletion: 5)
        
        let randomVectorConfiguration = RandomVectorConfiguration(minimumVectorYComponent: 20.0, maximumVectorYComponent: 40.0, minimumVectorXComponent: 10.0, maximumVectorXComponent: 20.0)
        
        let wingmanScene = WingmanScene(size: self.view.bounds.size, levelNumber: 1, levelDescription: "Kill all the wingman", enemyName: "Wingman", playerType: .BlueLarge, backgroundMusic: BackgroundMusic.CheerfulAnnoyance, numberOfBackgroundObjects: 3, hideInterval: 5.00, spawnInterval: 10.00, initialNumberOfEnemiesSpawned: 5, enemiesSpawnedPerInterval: 5, randomVectorConfigurationForUpdate: randomVectorConfiguration, maximumEnemiesAllowed: 30, minimumKillsForLevelCompletion: 5)
        
        let stealthShipScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: .Easy)
        let flyingAlienScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: .Easy)
        
        let menuScene = MenuScene(size: self.view.bounds.size)
        let trackScene = TrackScene(size: self.view.bounds.size)
        let instructionScene = InstructionScene(size: self.view.bounds.size, selectedTrackType: .Wingman)
        
            // Set the scale mode to scale to fit the window
            ufoScene.scaleMode = .aspectFill
            batScene.scaleMode = .aspectFill
            wingmanScene.scaleMode = .aspectFill
            stealthShipScene.scaleMode = .aspectFill
            flyingAlienScene.scaleMode = .aspectFill
            trackScene.scaleMode = .aspectFill
            menuScene.scaleMode = .aspectFill
            instructionScene.scaleMode = .aspectFill
        
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(batScene)
                    
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
