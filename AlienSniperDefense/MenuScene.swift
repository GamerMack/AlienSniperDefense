//
//  MenuScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//




import Foundation
import SpriteKit
import AVFoundation

/**
 TODO: Easy,medium, and hard buttons should be added to a container node whose zPosition can be set behind the main screen after a selection is made
 TODO: Likewise, GamePlayMode buttons should be added to a container node whose zPosition can be set behidn the screen upon selection
 
 TODO: A small arrow menu should allow user to navigate between different option screens (i.e. Difficulty Selection and GamePlayMode) as well as to QUIT the game
 
 **/



class MenuScene: SKScene{
 
    
    //Cache for Click Sounds played when pressing UI buttons
    let clickSound1 = SKAction.playSoundFileNamed(SoundEffects.Click1, waitForCompletion: false)
    let clickSound3 = SKAction.playSoundFileNamed(SoundEffects.Click3, waitForCompletion: false)
    let clickSound4 = SKAction.playSoundFileNamed(SoundEffects.Click4, waitForCompletion: false)

    
    //Texture Atlas for MenuScene
    let textureAtlas: SKTextureAtlas? = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)
    
    //Menu Button
    let startButton: SKSpriteNode = SKSpriteNode()
    
    //Difficulty Configuration Buttons
    var hardButton = SKSpriteNode()
    var mediumButton = SKSpriteNode()
    var easyButton = SKSpriteNode()
    
    //GamePlayMode Configuration Buttons
    var noTimeLimitModeButton = SKSpriteNode()
    var minimumKillsModeButton = SKSpriteNode()
    var multiplayerModeButton = SKSpriteNode()
    
    //User Options Manager
    let gameSettingsManager = GameSettings.sharedInstance
    
    //Random Point Generator (for generating randomized background decorations)
    let randomPointGenerator = RandomPoint(algorithmType: .Faster)
    
    override func didMove(to view: SKView) {
        //Add observer for PresentAuthenticationViewController notification
        /** Future Versions
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(GameViewController.showAuthenticationViewController), name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
        **/
        
        //Configure Anchor Point
        self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        
        //Setup background music
        BackgroundMusic.configureBackgroundMusicFrom(fileNamed: BackgroundMusic.GermanVirtue, forParentNode: self)
        
        //Set up particle emitter node in background
        configureBackground()
        
        //Setup game title
        setupGameTitle()
        
        //Setup start button
        setupStartButton()
        
        //Add characters for background decoration
        setupBackgroundDecoration()
     
    }
    
    private func configureBackground(){
        //Set background color
        self.backgroundColor = SKColor.black
        
        //Setup emitter node
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches{
            let touchLocation = t.location(in: self)
            let nodeTouched = nodes(at: touchLocation)[0]
            
            
            //User hits start button
            if nodeTouched.name == NodeNames.StartButton{
                startButton.removeAllActions()
                startButton.run(SKAction.sequence([
                    clickSound1,
                    SKAction.removeFromParent()
                    ]))
        
                setupDifficultyOptionsButtons()
             
            }
            
            
            //User selects difficulty options
            if nodeTouched.name == "Hard"{
                gameSettingsManager.setGameDifficultyLevel(difficulty: .valueHard)
                
                
                hardButton.run(SKAction.sequence([
                    clickSound4,
                    SKAction.wait(forDuration: 1.0)
                    ]))
                
                removeDifficultyOptionsButtons()
                setupGamePlayModeButtons()
        
            }
            

            if nodeTouched.name == "Medium"{
                gameSettingsManager.setGameDifficultyLevel(difficulty: .valueMedium)
                
                mediumButton.run(SKAction.sequence([
                    clickSound4,
                    SKAction.wait(forDuration: 1.0)
                    ]))
                
                removeDifficultyOptionsButtons()
                setupGamePlayModeButtons()
             
            }
            
            if nodeTouched.name == "Easy"{
                gameSettingsManager.setGameDifficultyLevel(difficulty: .valueEasy)
            
                easyButton.run(SKAction.sequence([
                    clickSound4,
                    SKAction.wait(forDuration: 1.0)
                    ]))
                removeDifficultyOptionsButtons()
                setupGamePlayModeButtons()
    
                
            }
            
            
            //User selects GamePlayMode
            if nodeTouched.name == NodeNames.TimeLimitModeButton{
                gameSettingsManager.setGamePlayMode(gamePlayMode: .valueTimeLimit)
                nodeTouched.run(clickSound3)
                
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 2.00)
                removeGamePlayModeButtons()
                let trackScene = TrackScene(size: self.size)
                self.view?.presentScene(trackScene, transition: transition)

            }
            
            if nodeTouched.name == NodeNames.MinimumKillsModeButton{
                gameSettingsManager.setGamePlayMode(gamePlayMode: .valueMinimumKills)
                nodeTouched.run(clickSound3)

                removeGamePlayModeButtons()
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 2.00)
                let trackScene = TrackScene(size: self.size)
                self.view?.presentScene(trackScene, transition: transition)


            }
            
            if nodeTouched.name == NodeNames.StartMultiplayerButton{
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue: GameKitHelper.StartMultiplayerGame), object: nil)
            }
            
        }
        
    }
    

    
    private func setupGameTitle(){
        //Build the label for the GameTitle
        let topTitleNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        topTitleNode.fontColor = SKColor.yellow
        topTitleNode.text = NSLocalizedString("Alien", comment: "")
        topTitleNode.zPosition = 2
        topTitleNode.position = CGPoint(x: 0.0, y: 100)
        topTitleNode.fontSize = 50
        self.addChild(topTitleNode)
        
        let bottomTitleNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        bottomTitleNode.fontColor = SKColor.yellow
        bottomTitleNode.text = NSLocalizedString("Sniper Defense", comment: "")
        bottomTitleNode.position = CGPoint(x: 0.0, y: 40)
        bottomTitleNode.zPosition = 2
        bottomTitleNode.fontSize = 50
        self.addChild(bottomTitleNode)
        
        let authorNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        authorNode.fontColor = SKColor.yellow
        authorNode.text = NSLocalizedString("Game Developer: Alex Makedonski", comment: "")
        authorNode.position = CGPoint(x: 0.0, y: 20)
        authorNode.zPosition = 2
        authorNode.fontSize = 10
        self.addChild(authorNode)
        
        let designerNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        designerNode.fontColor = SKColor.yellow
        designerNode.text = NSLocalizedString("Graphics By: Kenney", comment: "")
        designerNode.position = CGPoint(x: 0.0, y: 0)
        designerNode.zPosition = 2
        designerNode.fontSize = 10
        self.addChild(designerNode)
        
    }
    
    private func setupStartButton(){
        //Build the start node
        
        guard let textureAtlas = textureAtlas else { return }
        
        startButton.texture = textureAtlas.textureNamed("yellow_button09")
        startButton.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        startButton.size = CGSize(width: 295, height: 76)
        startButton.name = NodeNames.StartButton
        startButton.position = CGPoint(x: 0, y: -80)
        startButton.zPosition = 2
        self.addChild(startButton)
        
        
        
        
        //Build label text for Start Button
        let startButtonText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        startButtonText.text = NSLocalizedString("Start Game", comment: "")
        startButtonText.verticalAlignmentMode = .center
        startButtonText.position = CGPoint(x: 0, y: 2)
        startButtonText.fontSize = 40
        startButtonText.name = NodeNames.StartButton
        startButtonText.zPosition = 3
        startButton.addChild(startButtonText)
        
        let pulseAnimation = SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 0.25),
            SKAction.fadeAlpha(to: 0.8, duration: 0.25)
            ]))
        
        startButton.run(pulseAnimation, withKey: "startPulseAnimation")
    }
    
    
    //MARK: ********** Helper function for setting up randomized background decoration
    
    private func setupBackgroundDecoration(){
        
        let randomPoint1 = randomPointGenerator.getLowerLeftQuadrantPoint()
        let randomPoint2 = randomPointGenerator.getLowerRightQuadrantPoint()
        let randomPoint3 = randomPointGenerator.getUpperLeftQuadrantPoint()
        let randomPoint4 = randomPointGenerator.getUpperRightQuadrantPoint()
        
        //Add some alien enemies
        guard let wingmanTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Enemies)?.textureNamed("wingMan1") else { return }
        
        let wingmanNode = SKSpriteNode(texture: wingmanTexture)
        wingmanNode.xScale *= 1.2
        wingmanNode.yScale *= 1.2
        wingmanNode.position = randomPoint1
        wingmanNode.zPosition = 1
        wingmanNode.zRotation = -10
        self.addChild(wingmanNode)
        
        
        guard let ufoTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UFO)?.textureNamed("ufoRed") else {return}
        
        let ufoNode = SKSpriteNode(texture: ufoTexture)
        ufoNode.xScale *= 1.2
        ufoNode.yScale *= 1.2
        ufoNode.position = randomPoint2
        ufoNode.zPosition = 1
        ufoNode.zRotation = 10
        self.addChild(ufoNode)
        
        
        guard let flyingAliensTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .FlyingAliens)?.textureNamed("shipBlue_manned") else {return}
        
        let flyingAlienNode = SKSpriteNode(texture: flyingAliensTexture)
        flyingAlienNode.xScale *= 1.2
        flyingAlienNode.yScale *= 1.2
        flyingAlienNode.position = randomPoint3
        flyingAlienNode.zPosition = 1
        flyingAlienNode.zRotation = 100
        self.addChild(flyingAlienNode)
        
        guard let stealthShipTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .SpaceShips)?.textureNamed("playerShip1_red") else {return}
        
        let stealthShipNode = SKSpriteNode(texture: stealthShipTexture)
        stealthShipNode.xScale *= 1.2
        stealthShipNode.yScale *= 1.2
        stealthShipNode.position = randomPoint4
        stealthShipNode.zPosition = 1
        stealthShipNode.zRotation = 10
        self.addChild(stealthShipNode)
        
        
    }
    
    
    //MARK: *********** Helper Functions for setting up menu buttons
    
    private func setupDifficultyOptionsButtons(){
        
        let hardButtonYPos = ScreenSizeFloatConstants.HalfScreenHeight*0.30
        let mediumButtonYPos = -ScreenSizeFloatConstants.HalfScreenHeight*0.20
        let easyButtonYPos = -ScreenSizeFloatConstants.HalfScreenHeight*0.70
            
        hardButton = getButtonWith(textureNamed: "yellow_button06", andWithTextOf: NSLocalizedString("Hard", comment: ""), atPosition: CGPoint(x: 0, y: hardButtonYPos))
        hardButton.name = "Hard"
        setNameOfChildLabelTo(nodeName: "Hard", forNode: hardButton)
        
        mediumButton = getButtonWith(textureNamed: "yellow_button06", andWithTextOf: NSLocalizedString("Medium", comment: ""), atPosition: CGPoint(x: 0, y: mediumButtonYPos))
        mediumButton.name = "Medium"
        setNameOfChildLabelTo(nodeName: "Medium", forNode: mediumButton)
        
        easyButton = getButtonWith(textureNamed: "yellow_button06", andWithTextOf: NSLocalizedString("Easy", comment: ""), atPosition: CGPoint(x: 0, y: easyButtonYPos))
        easyButton.name = "Easy"
        setNameOfChildLabelTo(nodeName: "Easy", forNode: easyButton)
        
        self.addChild(hardButton)
        self.addChild(mediumButton)
        self.addChild(easyButton)
    }
    
    private func setNameOfChildLabelTo(nodeName: String, forNode node: SKNode){
        for node in node.children{
            if let node = node as? SKLabelNode{
                node.name = nodeName
            }
        }
    }
    
    private func setupGamePlayModeButtons(){
        
        let buttonWidth = ScreenSizeFloatConstants.HalfScreenWidth*0.90
        let buttonHeight = ScreenSizeFloatConstants.HalfScreenHeight*0.50
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        
        noTimeLimitModeButton = getButtonWith(textureNamed: "yellow_button02", andWithTextOf: NSLocalizedString("Time Limit Mode", comment: ""), atPosition: CGPoint(x: 0, y: ScreenSizeFloatConstants.HalfScreenHeight*0.25), andWithSizeOf: buttonSize)
        
        noTimeLimitModeButton.name = NodeNames.TimeLimitModeButton
        setNameOfChildLabelTo(nodeName: NodeNames.TimeLimitModeButton, forNode: noTimeLimitModeButton)
        
        minimumKillsModeButton = getButtonWith(textureNamed: "yellow_button02", andWithTextOf: NSLocalizedString("Minimum Kills Mode", comment: ""), atPosition: CGPoint(x: 0, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.30), andWithSizeOf: buttonSize)
        
        minimumKillsModeButton.name = NodeNames.MinimumKillsModeButton
        setNameOfChildLabelTo(nodeName: NodeNames.MinimumKillsModeButton, forNode: minimumKillsModeButton)
        
        multiplayerModeButton = getButtonWith(textureNamed: "yellow_button02", andWithTextOf: NodeNames.StartMultiplayerButton, atPosition: CGPoint(x: 0, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.85), andWithSizeOf: buttonSize)
        
        self.addChild(noTimeLimitModeButton)
        self.addChild(minimumKillsModeButton)
        //self.addChild(multiplayerModeButton)
        
    }
    
    
    
    
    //MARK: ************ Helper Function for setting up Difficulty/GamePlayMode buttons
    private func getButtonWith(textureNamed textureName: String, andWithTextOf buttonText: String, atPosition position: CGPoint, andWithSizeOf size: CGSize = CGSize(width: 295, height: 75)) ->SKSpriteNode {
        
        guard let textureAtlas = self.textureAtlas else { return SKSpriteNode() }
        
        var button = SKSpriteNode()
        
        let buttonTexture = textureAtlas.textureNamed(textureName)
        button = SKSpriteNode(texture: buttonTexture)
        button.anchorPoint = CGPoint.zero
        button.size = size
        button.name = buttonText
        button.position = position
        button.zPosition = 15
        
        let buttonTextLabel = SKLabelNode(fontNamed: kFuturaCondensedMedium)
        buttonTextLabel.text = buttonText
        buttonTextLabel.verticalAlignmentMode = .center
        buttonTextLabel.position = CGPoint(x: button.size.width*0.50, y: button.size.height*0.50)
        buttonTextLabel.fontSize = 35
        buttonTextLabel.fontColor = SKColor.blue
        buttonTextLabel.name = buttonText
        buttonTextLabel.zPosition = 20
        
        button.addChild(buttonTextLabel)
        
        return button
        
    }
    
    //MARK: ********** Helper Function for removing user options buttons
    private func removeDifficultyOptionsButtons(){
        hardButton.removeFromParent()
        mediumButton.removeFromParent()
        easyButton.removeFromParent()
    }
    
    private func removeGamePlayModeButtons(){
        minimumKillsModeButton.removeFromParent()
        noTimeLimitModeButton.removeFromParent()
        multiplayerModeButton.removeFromParent()
    }
    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
    
}

