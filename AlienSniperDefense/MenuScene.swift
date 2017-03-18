//
//  MenuScene.swift
//  AlienBusters
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
    
    //User Options Manager
    let gameSettingsManager = GameSettings.sharedInstance
    
    //Random Point Generator (for generating randomized background decorations)
    let randomPointGenerator = RandomPoint(algorithmType: .Faster)
    
    override func didMove(to view: SKView) {
        
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
                startButton.run(SKAction.removeFromParent())
        
                setupDifficultyOptionsButtons()
             
            }
            
            
            //User selects difficulty options
            if nodeTouched.name == "Hard"{
                gameSettingsManager.setGameDifficultyLevel(difficulty: .valueHard)
                
                hardButton.run(SKAction.wait(forDuration: 1.0))
                removeDifficultyOptionsButtons()
                
                setupGamePlayModeButtons()
        
            }
            

            if nodeTouched.name == "Medium"{
                gameSettingsManager.setGameDifficultyLevel(difficulty: .valueMedium)
                
                mediumButton.run(SKAction.wait(forDuration: 1.0))
                removeDifficultyOptionsButtons()
                setupGamePlayModeButtons()
             
            }
            
            if nodeTouched.name == "Easy"{
                gameSettingsManager.setGameDifficultyLevel(difficulty: .valueEasy)
            
                easyButton.run(SKAction.wait(forDuration: 5.0))
                removeDifficultyOptionsButtons()
                setupGamePlayModeButtons()
    
                
            }
            
            
            //User selects GamePlayMode
            if nodeTouched.name == "Time Limit"{
                gameSettingsManager.setGamePlayMode(gamePlayMode: .valueTimeLimit)
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 2.00)
                removeGamePlayModeButtons()
                let trackScene = TrackScene(size: self.size)
                self.view?.presentScene(trackScene, transition: transition)

            }
            
            if nodeTouched.name == "Minimum Kills"{
                gameSettingsManager.setGamePlayMode(gamePlayMode: .valueMinimumKills)
                removeGamePlayModeButtons()
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 2.00)
                let trackScene = TrackScene(size: self.size)
                self.view?.presentScene(trackScene, transition: transition)


            }
            
        }
        
    }
    

    
    private func setupGameTitle(){
        //Build the label for the GameTitle
        let topTitleNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        topTitleNode.fontColor = SKColor.blue
        topTitleNode.text = "Sneaky Alien"
        topTitleNode.zPosition = 2
        topTitleNode.position = CGPoint(x: 0.0, y: 100)
        topTitleNode.fontSize = 60
        self.addChild(topTitleNode)
        
        let bottomTitleNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        bottomTitleNode.fontColor = SKColor.blue
        bottomTitleNode.text = "Sniper Defense"
        bottomTitleNode.position = CGPoint(x: 0.0, y: 40)
        bottomTitleNode.zPosition = 2
        bottomTitleNode.fontSize = 60
        self.addChild(bottomTitleNode)
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
        startButtonText.text = "Start Game"
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
        wingmanNode.zRotation = -30
        self.addChild(wingmanNode)
        
        
        guard let ufoTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UFO)?.textureNamed("ufoRed") else {return}
        
        let ufoNode = SKSpriteNode(texture: ufoTexture)
        ufoNode.xScale *= 1.2
        ufoNode.yScale *= 1.2
        ufoNode.position = randomPoint2
        ufoNode.zPosition = 1
        ufoNode.zRotation = 120
        self.addChild(ufoNode)
        
        
        guard let flyingAliensTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .FlyingAliens)?.textureNamed("shipBlue_manned") else {return}
        
        let flyingAlienNode = SKSpriteNode(texture: flyingAliensTexture)
        flyingAlienNode.xScale *= 1.2
        flyingAlienNode.yScale *= 1.2
        flyingAlienNode.position = randomPoint3
        flyingAlienNode.zPosition = 1
        flyingAlienNode.zRotation = 120
        self.addChild(flyingAlienNode)
        
        guard let stealthShipTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .SpaceShips)?.textureNamed("playerShip1_red") else {return}
        
        let stealthShipNode = SKSpriteNode(texture: stealthShipTexture)
        stealthShipNode.xScale *= 1.2
        stealthShipNode.yScale *= 1.2
        stealthShipNode.position = randomPoint4
        stealthShipNode.zPosition = 1
        stealthShipNode.zRotation = 120
        self.addChild(stealthShipNode)
        
        
    }
    
    
    //MARK: *********** Helper Functions for setting up menu buttons
    
    private func setupDifficultyOptionsButtons(){
        hardButton = getButtonWith(textureNamed: "yellow_button06", andWithTextOf: "Hard", atPosition: CGPoint(x: 0, y: 100))
        mediumButton = getButtonWith(textureNamed: "yellow_button06", andWithTextOf: "Medium", atPosition: CGPoint(x: 0, y: 10))
        easyButton = getButtonWith(textureNamed: "yellow_button06", andWithTextOf: "Easy", atPosition: CGPoint(x: 0, y: -75))
        
        self.addChild(hardButton)
        self.addChild(mediumButton)
        self.addChild(easyButton)
    }
    
    private func setupGamePlayModeButtons(){
        noTimeLimitModeButton = getButtonWith(textureNamed: "yellow_button02", andWithTextOf: "Time Limit", atPosition: CGPoint(x: 0, y: 100))
        
        minimumKillsModeButton = getButtonWith(textureNamed: "yellow_button02", andWithTextOf: "Minimum Kills", atPosition: CGPoint(x: 0, y: 10))
        
        self.addChild(noTimeLimitModeButton)
        self.addChild(minimumKillsModeButton)
        
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
        buttonTextLabel.position = CGPoint(x: 100, y: 40)
        buttonTextLabel.fontSize = 40
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
    }
    
}

