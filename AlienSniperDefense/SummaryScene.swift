//
//  PlayerStatsSummaryScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class SummaryScene: SKScene{
    
    let gameSettings = GameSettings.sharedInstance
    
    enum TrackType{
        case Wingman, FlyingAlien, UFO, Bat, StealthShip
    }
    
    var trackType: SummaryScene.TrackType = .FlyingAlien
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, selectedTrackType: SummaryScene.TrackType) {
        self.init(size: size)
        self.trackType = selectedTrackType
    }
    
    
    override func didMove(to view: SKView) {
        //Configure Background Musics
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.FarmFrolics, forParentNode: self)
        
        //Set anchor point to zero
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //Configure background
        backgroundColor = UIColor.black
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        //Player Stats Title
        let title = SKLabelNode(fontNamed: FontTypes.MarkerFeltThin)
        title.text = "Well Done! Track Completed!"
        title.verticalAlignmentMode = .center
        title.horizontalAlignmentMode = .center
        title.fontSize = 30.0
        title.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.ScrrenHeight*0.40)
        self.addChild(title)
        
        
        let titlePositionX = -ScreenSizeFloatConstants.HalfScreenWidth
        let labelPositionX = ScreenSizeFloatConstants.HalfScreenWidth*0.50
        let titleFont = FontTypes.MarkerFeltThin
        let labelFont = FontTypes.MarkerFeltThin
        let titleFontSize = 25.0
        let labelFontSize = 30.0
        
        //Configure display for Total Number of Kills
        let killCountHeight = ScreenSizeFloatConstants.ScrrenHeight*0.20
        let killCount = getTotalKills()
        
        configureStatLabels(titleXPos: titlePositionX, labelXPos: labelPositionX, commonYPos: killCountHeight, titleFontType: titleFont, labelFontType: labelFont, titleFontSize: CGFloat(titleFontSize), labelFontSize: CGFloat(labelFontSize), titleText: "Total Number of Kills: ", labelText: "\(killCount)")

        
        //Configure display for Total Number of Enemies Spawned
        let enemyCountHeight = ScreenSizeFloatConstants.ScrrenHeight*0.00
        let trackEnemyCount = getTotalEnemiesSpawned()
        configureStatLabels(titleXPos: titlePositionX, labelXPos: labelPositionX, commonYPos: enemyCountHeight, titleFontType: titleFont, labelFontType: labelFont, titleFontSize: CGFloat(titleFontSize), labelFontSize: CGFloat(labelFontSize), titleText: "Total Number of Enemies Spawned: ", labelText: "\(trackEnemyCount)")
        
        //Configure display for Total GameTime
        let gameTimeHeight = -ScreenSizeFloatConstants.ScrrenHeight*0.20
        let trackGameTime = getTotalGameTime()
        
        configureStatLabels(titleXPos: titlePositionX, labelXPos: labelPositionX, commonYPos: gameTimeHeight, titleFontType: titleFont, labelFontType: labelFont, titleFontSize: CGFloat(titleFontSize), labelFontSize: CGFloat(labelFontSize), titleText: "Total Number of Enemies Spawned: ", labelText: "\(trackGameTime)")
        
        
        
        //Configure display for Total Bullets Fired
        let bulletCountHeight = -ScreenSizeFloatConstants.ScrrenHeight*0.40
        let trackBulletCount = getTotalNumberOfBulletsFired()
        
        configureStatLabels(titleXPos: titlePositionX, labelXPos: labelPositionX, commonYPos: bulletCountHeight, titleFontType: titleFont, labelFontType: labelFont, titleFontSize: CGFloat(titleFontSize), labelFontSize: CGFloat(labelFontSize), titleText: "Total Number of Bullets Fired: ", labelText: "\(trackBulletCount)")
        
    }
    
    private func configureStatLabels(titleXPos: CGFloat, labelXPos: CGFloat, commonYPos: CGFloat, titleFontType: String, labelFontType: String, titleFontSize: CGFloat, labelFontSize: CGFloat, titleText: String, labelText: String){
    
        let killCountTitle = SKLabelNode(fontNamed: titleFontType)
        killCountTitle.fontSize = CGFloat(titleFontSize)
        killCountTitle.horizontalAlignmentMode = .right
        killCountTitle.verticalAlignmentMode = .center
        killCountTitle.position = CGPoint(x: titleXPos, y: commonYPos)
        killCountTitle.text = titleText
    
        let killCountLabel = SKLabelNode(fontNamed: labelFontType)
        killCountLabel.fontSize = CGFloat(labelFontSize)
        killCountLabel.verticalAlignmentMode = .center
        killCountLabel.horizontalAlignmentMode = .left
        killCountLabel.position = CGPoint(x: labelXPos, y: commonYPos)
        killCountLabel.text = labelText
        
        self.addChild(killCountTitle)
        self.addChild(killCountLabel)
    }
    
    private func getTotalKills() -> Int{
        switch(trackType){
        case .Bat:
            let level1Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Bat, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Bat, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Bat, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Bat, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Bat, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)

        case .FlyingAlien:
            let level1Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.FlyingAlien, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.FlyingAlien, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.FlyingAlien, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.FlyingAlien, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.FlyingAlien, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)

        case .StealthShip:
            let level1Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.StealthShips, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.StealthShips, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.StealthShips, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.StealthShips, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.StealthShips, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)

        case .UFO:
            let level1Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.UFO, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.UFO, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.UFO, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.UFO, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.UFO, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)

        case .Wingman:
            let level1Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Wingman, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Wingman, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Wingman, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Wingman, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfKills(levelTuple: (.Wingman, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)

        }

    }
    
    private func getTotalEnemiesSpawned() -> Int{
        switch(trackType){
        case .Bat:
            let level1Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Bat, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Bat, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Bat, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Bat, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Bat, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .FlyingAlien:
            let level1Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.FlyingAlien, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.FlyingAlien, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.FlyingAlien, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.FlyingAlien, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.FlyingAlien, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .StealthShip:
            let level1Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.StealthShips, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.StealthShips, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.StealthShips, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.StealthShips, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.StealthShips, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .UFO:
            let level1Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.UFO, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.UFO, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.UFO, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.UFO, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.UFO, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .Wingman:
            let level1Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Wingman, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Wingman, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Wingman, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Wingman, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfEnemiesSpawned(levelTuple: (.Wingman, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        }
        
    }
    
    private func getTotalGameTime() -> Double{
        switch(trackType){
        case .Bat:
            let level1Kills = gameSettings.getTotalRunningTime(levelTuple: (.Bat, .Level1))
            let level2Kills = gameSettings.getTotalRunningTime(levelTuple: (.Bat, .Level2))
            let level3Kills = gameSettings.getTotalRunningTime(levelTuple: (.Bat, .Level3))
            let level4Kills = gameSettings.getTotalRunningTime(levelTuple: (.Bat, .Level4))
            let level5Kills = gameSettings.getTotalRunningTime(levelTuple: (.Bat, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .FlyingAlien:
            let level1Kills = gameSettings.getTotalRunningTime(levelTuple: (.FlyingAlien, .Level1))
            let level2Kills = gameSettings.getTotalRunningTime(levelTuple: (.FlyingAlien, .Level2))
            let level3Kills = gameSettings.getTotalRunningTime(levelTuple: (.FlyingAlien, .Level3))
            let level4Kills = gameSettings.getTotalRunningTime(levelTuple: (.FlyingAlien, .Level4))
            let level5Kills = gameSettings.getTotalRunningTime(levelTuple: (.FlyingAlien, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .StealthShip:
            let level1Kills = gameSettings.getTotalRunningTime(levelTuple: (.StealthShips, .Level1))
            let level2Kills = gameSettings.getTotalRunningTime(levelTuple: (.StealthShips, .Level2))
            let level3Kills = gameSettings.getTotalRunningTime(levelTuple: (.StealthShips, .Level3))
            let level4Kills = gameSettings.getTotalRunningTime(levelTuple: (.StealthShips, .Level4))
            let level5Kills = gameSettings.getTotalRunningTime(levelTuple: (.StealthShips, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .UFO:
            let level1Kills = gameSettings.getTotalRunningTime(levelTuple: (.UFO, .Level1))
            let level2Kills = gameSettings.getTotalRunningTime(levelTuple: (.UFO, .Level2))
            let level3Kills = gameSettings.getTotalRunningTime(levelTuple: (.UFO, .Level3))
            let level4Kills = gameSettings.getTotalRunningTime(levelTuple: (.UFO, .Level4))
            let level5Kills = gameSettings.getTotalRunningTime(levelTuple: (.UFO, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .Wingman:
            let level1Kills = gameSettings.getTotalRunningTime(levelTuple: (.Wingman, .Level1))
            let level2Kills = gameSettings.getTotalRunningTime(levelTuple: (.Wingman, .Level2))
            let level3Kills = gameSettings.getTotalRunningTime(levelTuple: (.Wingman, .Level3))
            let level4Kills = gameSettings.getTotalRunningTime(levelTuple: (.Wingman, .Level4))
            let level5Kills = gameSettings.getTotalRunningTime(levelTuple: (.Wingman, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        }
        
    }
    
    private func getTotalNumberOfBulletsFired() ->Int{
        switch(trackType){
        case .Bat:
            let level1Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Bat, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Bat, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Bat, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Bat, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Bat, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .FlyingAlien:
            let level1Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.FlyingAlien, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.FlyingAlien, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.FlyingAlien, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.FlyingAlien, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.FlyingAlien, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .StealthShip:
            let level1Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.StealthShips, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.StealthShips, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.StealthShips, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.StealthShips, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.StealthShips, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .UFO:
            let level1Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.UFO, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.UFO, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.UFO, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.UFO, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.UFO, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        case .Wingman:
            let level1Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Wingman, .Level1))
            let level2Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Wingman, .Level2))
            let level3Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Wingman, .Level3))
            let level4Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Wingman, .Level4))
            let level5Kills = gameSettings.getTotalNumberOfBulletsFired(levelTuple: (.Wingman, .Level5))
            
            return (level1Kills + level2Kills + level3Kills + level4Kills + level5Kills)
            
        }

    }


    
}
