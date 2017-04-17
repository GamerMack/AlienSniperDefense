//
//  InstructionScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

class InstructionScene: SKScene{
    
    //MARK: ************* Current Game Settings singleton
    let gameSettings = GameSettings.sharedInstance
    
    enum TrackType{
        case Wingman, FlyingAlien, UFO, Bat, StealthShip
    }
    
    var trackType: InstructionScene.TrackType = .FlyingAlien
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, selectedTrackType: InstructionScene.TrackType) {
        self.init(size: size)
        trackType = selectedTrackType
    }
    
    
    override func didMove(to view: SKView) {
        //Add observer for PresentAuthenticationViewController notification
        /**
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(GameViewController.showAuthenticationViewController), name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
        **/
        
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
        
        
        let mainNode = SKNode()
        mainNode.position = CGPoint.zero
        self.addChild(mainNode)
        
        switch(trackType){
            case .Wingman:
                configureNodeForWingmanTrack(mainNode: mainNode)
                    break
            case .FlyingAlien:
                configureNodeForFlyingAlienTrack(mainNode: mainNode)
                    break
            case .StealthShip:
                configureNodeForStealthShipTrack(mainNode: mainNode)
                    break
            case .UFO:
                configureNodeForUFOTrack(mainNode: mainNode)
                    break
            case .Bat:
                configureNodeForBatTrack(mainNode: mainNode)
                    break
            }
    }
    
    
    
    
    //MARK:  Main Node Configuration Functions
    private func configureNodeForWingmanTrack(mainNode: SKNode){
        mainNode.name = NodeNames.WingmanTrackButton
        
        //Configure arrow texture
        let arrowTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_sliderRight")
        let arrowSprite = SKSpriteNode(texture: arrowTexture)
        arrowSprite.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        //Configure hidden and unhiddenWingman
        let unhiddenWingman = Wingman(scalingFactor: 0.6)
        
        let cloud = BackgroundObject(backgroundObjectType: .FullMoon)
        let hiddenWingman = Wingman(scalingFactor: 0.6)
        
        if let hiddenWingman = hiddenWingman, let unhiddenWingman = unhiddenWingman{
            hiddenWingman.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.30)
            cloud.position = CGPoint(x: hiddenWingman.position.x + 20, y: hiddenWingman.position.y - 20)
            cloud.zPosition = 30
            unhiddenWingman.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.30)
            
            mainNode.addChild(unhiddenWingman)
            mainNode.addChild(hiddenWingman)
            mainNode.addChild(cloud)
            mainNode.addChild(arrowSprite)
        }
        
        
      
        makeLabelForNode(node: mainNode,
                         withTextOf: NSLocalizedString("Wingman can hide behind sky objects.", comment: ""),
                         text2: NSLocalizedString("When hiding, they cannot be hit", comment: ""),
                         text3: nil)
    }
    
    private func configureNodeForFlyingAlienTrack(mainNode: SKNode){
        mainNode.name = NodeNames.FlyingAlienTrackButton
        
        
        //Configure manned ship
       let unmannedTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .FlyingAliens)?.textureNamed("shipBlue")
        let unmannedShip = SKSpriteNode(texture: unmannedTexture)
        unmannedShip.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.30)
        
        //Configure unmanned ship
        let mannedTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .FlyingAliens)?.textureNamed("shipBlue_manned")
        let mannedShip = SKSpriteNode(texture: mannedTexture)
        mannedShip.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        //Configure arrow texture
        let arrowTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_sliderRight")
        let arrowSprite = SKSpriteNode(texture: arrowTexture)
        arrowSprite.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        
        
        mainNode.addChild(arrowSprite)
        mainNode.addChild(mannedShip)
        mainNode.addChild(unmannedShip)
        
        makeLabelForNode(node: mainNode,
                         withTextOf: NSLocalizedString("Hover Borg can be manned or unmanned.", comment: ""),
                         text2: NSLocalizedString("When unmanned, they cannot be hit.", comment: ""),
                         text3: NSLocalizedString("Shoot background objects to generate blackholes that capture Hover Borgs.", comment: ""))
    }
    
    private func configureNodeForStealthShipTrack(mainNode: SKNode){
        mainNode.name = NodeNames.StealthShipTrackButton
        
        
        //Configure manned ship
        let shipTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .SpaceShips)?.textureNamed("playerShip1_red")
        let fadingShip = SKSpriteNode(texture: shipTexture)
        fadingShip.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        fadingShip.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeOut(withDuration: 2.00),
            SKAction.fadeIn(withDuration: 2.00)
            ])))
        
        //Configure unmanned ship
        let nonFadingShip = SKSpriteNode(texture: shipTexture)
        nonFadingShip.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        //Configure arrow texture
        let arrowTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_sliderRight")
        let arrowSprite = SKSpriteNode(texture: arrowTexture)
        arrowSprite.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        
        mainNode.addChild(nonFadingShip)
        mainNode.addChild(fadingShip)
        mainNode.addChild(arrowSprite)
        
        
        makeLabelForNode(node: mainNode,
                         withTextOf: NSLocalizedString("Stealth mode is indicated by fading action.", comment: ""),
                         text2: NSLocalizedString("When in stealth mode, stealth ships cannot take damage.", comment: ""),
                         text3: NSLocalizedString("Stealth ships require multiple hits to be destroyed", comment: ""))
    }
    
    private func configureNodeForUFOTrack(mainNode: SKNode){
        mainNode.name = NodeNames.UFOTrackButton
        
        
        //Configure manned ship
        let ufoTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UFO)?.textureNamed("ufoRed")
        let animatedUFO = SKSpriteNode(texture: ufoTexture)
        animatedUFO.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        animatedUFO.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.group([
                SKAction.fadeOut(withDuration: 2.00),
                SKAction.scale(to: 0.4, duration: 2.00)
                ]),
            SKAction.group([
                SKAction.fadeIn(withDuration: 2.00),
                SKAction.scale(to: 1.00, duration: 2.00)
                ])
            ])))
        
        //Configure unmanned ship
        let nonAnimatedUFO = SKSpriteNode(texture: ufoTexture)
        nonAnimatedUFO.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        //Configure arrow texture
        let arrowTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_sliderRight")
        let arrowSprite = SKSpriteNode(texture: arrowTexture)
        arrowSprite.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        
        mainNode.addChild(animatedUFO)
        mainNode.addChild(nonAnimatedUFO)
        mainNode.addChild(arrowSprite)
        
        makeLabelForNode(node: mainNode,
                         withTextOf: NSLocalizedString("When in emitting mode, UFOreos expand and contract.", comment: ""),
                         text2: NSLocalizedString("In emitting mode, UFOreos cannot take damage, and", comment: ""),
                         text3: NSLocalizedString( "may emit gravity fields that disrupt player movement", comment: ""))
    }
    
    private func configureNodeForBatTrack(mainNode: SKNode){
        mainNode.name = NodeNames.BatTrackButton
        
        //Reconfigure background color
        backgroundColor = UIColor(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
        //Configure non-illuminated bat
        let batSprite = Bat(scalingFactor: 3.0, startingHealth: 3, xVelocity: 0.00, yVelocity: 0.00, applyImpulseInterval: 0.00)
        batSprite?.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)

        //Configure arrow texture
        let arrowTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_sliderRight")
        let arrowSprite = SKSpriteNode(texture: arrowTexture)
        arrowSprite.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        //Configure illuminated bat
        let illuminatedBat = Bat(scalingFactor: 3.0, startingHealth: 3, minXVelocity: 0.00, maxXVelocity: 0.00, minYVelocity: 0.00, maxYVelocity: 0.00)
        illuminatedBat?.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.40, y: ScreenSizeFloatConstants.HalfScreenHeight*0.40)
        
        if let player = CrossHair(crossHairType: .OutlineLarge), let batSprite = batSprite, let illuminatedBat = illuminatedBat{
            player.position = illuminatedBat.position
            mainNode.addChild(player)
            mainNode.addChild(batSprite)
            mainNode.addChild(illuminatedBat)
            mainNode.addChild(arrowSprite)


        }
        
      
    
        
        makeLabelForNode(node: mainNode,
                         withTextOf: NSLocalizedString("Bats can be hard to see in the dark.", comment: ""),
                         text2: NSLocalizedString("When targeted with the cross hair, they can be illuminated", comment: ""),
                         text3: nil)
    }
    
    
    private func getLabelNode(withTextOf labelText: String) -> SKLabelNode{
        
        let labelNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        labelNode.text = labelText
        labelNode.verticalAlignmentMode = .center
        labelNode.horizontalAlignmentMode = .center
        labelNode.fontSize = 25.0
        labelNode.fontColor = SKColor.yellow
        
        return labelNode
    }
    
    
    private func makeLabelForNode(node: SKNode, withTextOf text1: String, text2: String?, text3: String?){
        
        let labelNode1 = getLabelNode(withTextOf: text1)
        let yPosLabelNode1 = ScreenSizeFloatConstants.HalfScreenHeight*0.20
        labelNode1.fontSize = 25.0
        labelNode1.position = CGPoint(x: 0, y: -yPosLabelNode1)
        
        node.addChild(labelNode1)
        
        if let text2 = text2{
            let labelNode2 = getLabelNode(withTextOf: text2)
            let yPosLabelNode = ScreenSizeFloatConstants.HalfScreenHeight*0.40
            labelNode2.position = CGPoint(x: 0, y: -yPosLabelNode)
            labelNode2.fontSize = 25.0
            
            node.addChild(labelNode2)

        }
        
        if let text3 = text3{
            let labelNode3 = getLabelNode(withTextOf: text3)
            let yPosLabelNode = ScreenSizeFloatConstants.HalfScreenHeight*0.60
            labelNode3.position = CGPoint(x: 0, y: -yPosLabelNode)
            labelNode3.fontSize = 20.0
            
            node.addChild(labelNode3)
        }
        
    }
    
    
    //MARK: User Touch Handlers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        for node in nodes(at: touchLocation){
            
            let mainTransition = SKTransition.crossFade(withDuration: 2.00)
            var nextScene: SKScene?
            
            if node.name == NodeNames.WingmanTrackButton{
                switch(gameSettings.getGameDifficulty()){
                    case .valueHard:
                        nextScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: .Hard)
                        break
                    case .valueMedium:
                        nextScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: .Medium)
                        break
                    case .valueEasy:
                        nextScene = WingmanSceneLevelLoader.loadLevel1(difficultyLevel: .Easy)
                        break
                    }
                
                if let nextScene = nextScene{
                    self.view?.presentScene(nextScene, transition: mainTransition)
                }

            }
            
            if node.name == NodeNames.UFOTrackButton{
                switch(gameSettings.getGameDifficulty()){
                    case .valueHard:
                        nextScene = UFOLevelLoader.getLevel1(difficultyLevel: .Hard)
                        break
                    case .valueMedium:
                        nextScene = UFOLevelLoader.getLevel1(difficultyLevel: .Medium)
                        break
                    case .valueEasy:
                        nextScene = UFOLevelLoader.getLevel1(difficultyLevel: .Easy)
                        break
                }
                
                if let nextScene = nextScene{
                    self.view?.presentScene(nextScene, transition: mainTransition)
                }
            }
            
            if node.name == NodeNames.StealthShipTrackButton{
                switch(gameSettings.getGameDifficulty()){
                case .valueHard:
                    nextScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: .Hard)
                    break
                case .valueMedium:
                    nextScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: .Medium)
                    break
                case .valueEasy:
                    nextScene = StealthShipSceneLevelLoader.loadLevel1(difficultyLevel: .Easy)
                    break
                }
                
                if let nextScene = nextScene{
                    self.view?.presentScene(nextScene, transition: mainTransition)
                }
                
                
            }
            
            if node.name == NodeNames.BatTrackButton{
                switch(gameSettings.getGameDifficulty()){
                    case .valueHard:
                        nextScene = BatSceneLevelLoader.getLevel1Scene(size: self.size, difficultyLevel: .Hard)
                        break
                    case .valueMedium:
                        nextScene = BatSceneLevelLoader.getLevel1Scene(size: self.size, difficultyLevel: .Medium)
                        break
                    case .valueEasy:
                        nextScene = BatSceneLevelLoader.getLevel1Scene(size: self.size, difficultyLevel: .Easy)
                        break
                }
                
                if let nextScene = nextScene{
                    self.view?.presentScene(nextScene, transition: mainTransition)
                }
                
            }
            
            if node.name == NodeNames.FlyingAlienTrackButton{
                
                switch(gameSettings.getGameDifficulty()){
                case .valueHard:
                    nextScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: .Hard)
                    break
                case .valueMedium:
                    nextScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: .Medium)
                    break
                case .valueEasy:
                    nextScene = FlyingAlienLevelLoader.loadLevel1(difficultyLevel: .Easy)
                    break
                }
                
                if let nextScene = nextScene{
                    self.view?.presentScene(nextScene, transition: mainTransition)
                }
                
                
            }
            
        }
    }
    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
    
    
}
