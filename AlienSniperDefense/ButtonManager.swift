//
//  ButtonManager.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

/**
 This class is only for demonstrating and teaching purposes.  Avoid use in production.
 **/
import Foundation
import SpriteKit


class ButtonManager{
    
    enum TrackType{
        case Wingman
        case Bat
        case StealthShip
        case FlyingAlien
        case UFO
    }
    
    static let sharedInstance = ButtonManager()
    
    private var introMessageButton: SKSpriteNode?
    
    
    static func getClearPlayerDataButton(buttonPosition: CGPoint) -> SKSpriteNode{
        let clearButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_button04")
        let clearButtonSprite = SKSpriteNode(texture: clearButtonTexture)
        clearButtonSprite.name = NodeNames.ClearPlayerDataButton
        clearButtonSprite.position = buttonPosition
        clearButtonSprite.zPosition = 31
        
        let clearButtonLabel = SKLabelNode(fontNamed: FontTypes.MarkerFeltThin)
        clearButtonLabel.name = NodeNames.ClearPlayerDataButton
        clearButtonLabel.text = "Clear Player Data"
        clearButtonLabel.horizontalAlignmentMode = .center
        clearButtonLabel.verticalAlignmentMode = .center
        clearButtonLabel.zPosition = 32
        clearButtonLabel.position = CGPoint(x: 0, y: 0)
        
        clearButtonSprite.addChild(clearButtonLabel)
        return clearButtonSprite
        
    }
    
    static func getTrackButton(isCompleted: Bool, trackType: TrackType, size: CGSize, position: CGPoint) -> SKSpriteNode{
        
        //Configure Track Node properties
        let trackNode = SKSpriteNode()
        trackNode.size = size
        trackNode.position = position
        trackNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        //For incomplete level, the tickmark is shown
        let boxTickTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_boxTick")
        
        //For completed levels, a checkmark is shown
        let checkMarkTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_boxCheckmark")
        
        //Indicator node is initialized based on completion status of the track
        let indicatorNode = isCompleted ? SKSpriteNode(texture: checkMarkTexture) : SKSpriteNode(texture: boxTickTexture)
        
        
        
        var trackTexture: SKTexture?
        var labelText: String
        var scaleFactor: CGFloat = 1.00
        
        switch(trackType){
            case .Bat:
                trackTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Bats)?.textureNamed("bat")
                labelText = NSLocalizedString("Fluorescent Bats", comment: "")
                scaleFactor = 2
                break
            case .FlyingAlien:
                trackTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .FlyingAliens)?.textureNamed("shipBlue_manned")
                scaleFactor = 0.70
                labelText = NSLocalizedString("Hover Borgs", comment: "")
                break
            case .StealthShip:
                trackTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .SpaceShips)?.textureNamed("playerShip2_blue")
                labelText = NSLocalizedString("Stealth Ships", comment: "")
                break
            case .UFO:
                trackTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UFO)?.textureNamed("ufoGreen")
                labelText = NSLocalizedString("UFOreos", comment: "")
                break
            case .Wingman:
                trackTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Enemies)?.textureNamed("wingMan1")
                labelText = NSLocalizedString("Wingman", comment: "")
                scaleFactor = 0.70
                break
        }
        
        
        //Configure the icon for the track node
        let iconNode = SKSpriteNode(texture: trackTexture)
        iconNode.xScale *= scaleFactor
        iconNode.yScale *= scaleFactor
        let iconNodeYPos = trackNode.size.height*0.20
        iconNode.position = CGPoint(x: 0, y: iconNodeYPos)
        
        //Configure the label for the track node
        let labelNode = SKLabelNode(fontNamed: FontTypes.MarkerFeltThin)
        labelNode.text = labelText
        labelNode.fontSize = 18.0
        labelNode.verticalAlignmentMode = .center
        labelNode.horizontalAlignmentMode = .center
        labelNode.position = CGPoint.zero
        
        //Configure the indicator node
        let indicatorNodeYPos = -trackNode.size.height*0.20
        indicatorNode.position = CGPoint(x: 0, y: indicatorNodeYPos)
        indicatorNode.xScale *= 1.7
        indicatorNode.yScale *= 1.7
        
     
        
        //Add subnodes to the track node
        trackNode.addChild(indicatorNode)
        trackNode.addChild(iconNode)
        trackNode.addChild(labelNode)
        
        return trackNode
        
    }
    
    
    static func getPauseButton() -> SKSpriteNode?{
        
        let buttonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("yellow_button09")
        
        let pauseNode = SKSpriteNode(texture: buttonTexture)
        pauseNode.name = NodeNames.PauseButton
        pauseNode.userData = NSMutableDictionary()
        pauseNode.userData?.setValue(false, forKey: "isPaused")
        pauseNode.zPosition = 15
        
        let pauseLabel = SKLabelNode(fontNamed: FontTypes.FuturaMediumItalic)
        pauseLabel.text = NSLocalizedString("Pause", comment: "")
        pauseLabel.name = NodeNames.PauseButton
        pauseNode.addChild(pauseLabel)
        pauseLabel.horizontalAlignmentMode = .center
        pauseLabel.verticalAlignmentMode = .center
        pauseLabel.position = CGPoint(x: pauseNode.position.x, y: pauseNode.position.y)
        pauseLabel.zPosition = 16
        pauseLabel.fontSize = 15.0
        
        return pauseNode
    }
    
    
    func getIntroMessageButton(withLevelTitleOf levelTitle: String, levelDescriptionOf levelDescription: String, andWithTimeLimitOf timeLimit: TimeInterval, andWithTextureNamed textureName: String = "yellow_panel") -> SKSpriteNode?{
        
        guard let introMessageButton = introMessageButton else { return nil}
        
        let newMessageButton = introMessageButton.copy() as! SKSpriteNode
        
        newMessageButton.texture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed(textureName)
        
        for node in newMessageButton.children{
            if(node.name == "text1"){
                if let node = node as? SKLabelNode{
                    node.text = levelTitle
                    node.name = NodeNames.StartButton
                }
            }
            
            if(node.name == "text2"){
                if let node = node as? SKLabelNode{
                    node.text = levelDescription
                    node.name = NodeNames.StartButton
                }
            }
            
            if(node.name == "text3"){
                if let node = node as? SKLabelNode{
                    node.text = NSLocalizedString("Time Limit: \(timeLimit)", comment: "")
                    node.name = NodeNames.StartButton
                    
                }
            }
        }
        
        return newMessageButton
    }
    
    
    
    private init(){
        setup()
    }

    
    private func setup(){
        introMessageButton = GenerateIntroMessageBoxWith(levelTitle: "Level 1", levelDescription: "Shoot Enemies", levelTimeLimitWarning: "Time Limit: 30.00")
    }
    
    
    
    private func GenerateIntroMessageBoxWith(levelTitle: String, levelDescription: String, levelTimeLimitWarning: String, textureName: String = "yellow_panel") -> SKSpriteNode?{
        
        
        //The texture for IntroMessage Box must be loaded in order for the rest of the function bloc to be executed
        guard let introBoxTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed(textureName) else { return nil }
        
    
        
        //The IntroMessage Box dimensions for width and height are 40% of the width and 40% of the height of the UIScreen, respectively; zPosition is set at 10 so that the IntroMessage Box appears in front of all other game objets
        let introBox = SKSpriteNode(texture: introBoxTexture, color: .clear, size: CGSize(width: kViewWidth*0.4, height: kViewHeight*0.4))
        introBox.position = CGPoint.zero
        introBox.zPosition = 10
        
        //The node name for the IntroBox will be StartButton; when the user clicks, the game begins
        introBox.name = NodeNames.StartButton
        
        
        //The message text is position relative to the height of the message box
        let introxBoxHeight = kViewHeight*0.4
        
        //Configure the top text: Level Title
        let introText1 = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        introBox.addChild(introText1)
        introText1.position = CGPoint(x: 0, y: introxBoxHeight*0.2 )
        introText1.text = levelTitle
        introText1.fontSize = 30.0
        introText1.zPosition = 12
        introText1.name = "text1"
        
        //Configure the center text: Level Description
        let introText2 = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        introBox.addChild(introText2)
        introText2.position = CGPoint(x: 0, y: 0 )
        introText2.text = levelDescription
        introText2.fontSize = 25.0
        introText2.zPosition = 12
        introText2.name = "text2"
        
        //Configure the bottom text: Time Limit Reminder
        let introText3 = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        introBox.addChild(introText3)
        introText3.position = CGPoint(x: 0, y: -introxBoxHeight*0.2 )
        introText3.fontSize = 15.0
        introText3.text = levelTimeLimitWarning
        introText3.zPosition = 12
        introText3.name = "text3"
        
        //Configure a pulsing action for the display box
        let introTextPulseAction = SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.2),
            SKAction.fadeOut(withDuration: 0.2)
            ])
        
        let pulsingAction = SKAction.repeatForever(introTextPulseAction)
        
        introText1.run(pulsingAction)
        
        return introBox
        
    }
    
}
