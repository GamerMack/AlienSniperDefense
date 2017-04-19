//
//  BaseScene+Buttons.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 4/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit



extension BaseScene{
    
    func showTooManyEnemiesLabel(){
        
        let labelNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        labelNode.fontColor = SKColor.yellow
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontSize = 45.0
        labelNode.text = NSLocalizedString("Too many enemies on screen!", comment: "")
        labelNode.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.ScrrenHeight*0.30)
        let scalingAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.scale(to: 1.5, duration: 2.0),
            SKAction.scale(to: 0.7, duration: 2.0)
            ]))
        labelNode.run(scalingAction)
        labelNode.zPosition = 30
        labelNode.name = NodeNames.TooManyEnemiesNotice
        
        
        let shapeNode = SKShapeNode(rectOf: CGSize(width: ScreenSizeFloatConstants.ScreenWidth*0.90, height: ScreenSizeFloatConstants.HalfScreenHeight*0.35))
        shapeNode.strokeColor = SKColor.black
        shapeNode.fillColor = SKColor(colorLiteralRed: 0.20, green: 0.20, blue: 0.60, alpha: 1.0)
        shapeNode.position = CGPoint(x: labelNode.position.x, y: labelNode.position.y)
        shapeNode.zPosition = 29
        self.addChild(shapeNode)
        self.addChild(labelNode)
        
    }
    
    
    final func setupPauseStateButtons(){
        guard let menuButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-menu") else { return }
        
        guard let restartButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-restart") else { return }
        
        self.returnToMenuFromPauseState = SKSpriteNode(texture: menuButtonTexture)
        self.restartFromPauseState = SKSpriteNode(texture: restartButtonTexture)
        
        
        guard let returnToMenuFromPauseState = self.returnToMenuFromPauseState, let restartFromPauseState = self.restartFromPauseState else { return }
        
        
        returnToMenuFromPauseState.name = NodeNames.ReturnToMenuButton
        restartFromPauseState.name = NodeNames.RestartGameButton
        
        let returnToMenuText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        returnToMenuText.text = NSLocalizedString("Main Menu", comment: "")
        returnToMenuText.fontSize = 20.0
        returnToMenuText.fontColor = SKColor.white
        returnToMenuText.verticalAlignmentMode = .bottom
        returnToMenuText.position = CGPoint(x: returnToMenuFromPauseState.position.x, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.4)
        returnToMenuText.name = NodeNames.ReturnToMenuButton
        returnToMenuText.move(toParent: returnToMenuFromPauseState)
        
        let restartGameText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        restartGameText.text = NSLocalizedString("Restart Level", comment: "")
        restartGameText.fontSize = 20.0
        restartGameText.fontColor = SKColor.white
        restartGameText.verticalAlignmentMode = .bottom
        restartGameText.position = CGPoint(x: restartFromPauseState.position.x, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.4)
        restartGameText.name = NodeNames.RestartGameButton
        restartGameText.move(toParent: restartFromPauseState)
        
        returnToMenuFromPauseState.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        restartFromPauseState.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        returnToMenuFromPauseState.size = CGSize(width: kViewWidth*0.2, height: kViewHeight*0.3)
        restartFromPauseState.size = CGSize(width: kViewWidth*0.2, height: kViewHeight*0.3)
        
        returnToMenuFromPauseState.position = CGPoint(x: -ScreenSizeFloatConstants.HalfScreenWidth*0.25, y: 20)
        restartFromPauseState.position = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.25, y: 20)
        
        
    }
    
    final func showPauseStateButtons(){
        
        guard let returnToMenuFromPauseState = self.returnToMenuFromPauseState else { return }
        
        guard let restartFromPauseState = self.restartFromPauseState else { return }
        
        
        
        restartFromPauseState.zPosition = 15
        returnToMenuFromPauseState.zPosition = 15
        
        
        returnToMenuFromPauseState.alpha = 1
        restartFromPauseState.alpha = 1
        
        restartFromPauseState.move(toParent: self)
        returnToMenuFromPauseState.move(toParent: self)
        
    }
    
    
    final func removePauseStateButtons(){
        
        guard let returnToMenuFromPauseState = self.returnToMenuFromPauseState else { return }
        guard let restartFromPauseState = self.restartFromPauseState else { return }
        
        returnToMenuFromPauseState.zPosition = -15
        restartFromPauseState.zPosition = -15
        
        returnToMenuFromPauseState.alpha = 0
        restartFromPauseState.alpha = 0
        
        returnToMenuFromPauseState.move(toParent: pauseButton)
        restartFromPauseState.move(toParent: pauseButton)
        
    }
    
    func setupRecordButtons(){
        
        
        guard let startRecordButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("recordButton"), let stopRecordButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("stopButton"), let previewButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .UI)?.textureNamed("replayButton") else {
            print("Error: The requested UI texture could not be found or loaded")
            return
        }
      
      
        startRecordButton = SKSpriteNode(texture: startRecordButtonTexture)
        stopRecordButton = SKSpriteNode(texture: stopRecordButtonTexture)
        previewButton = SKSpriteNode(texture: previewButtonTexture)
        
        let scaledSize = CGSize(width: 40, height: 40)
        
        startRecordButton.scale(to: scaledSize)
        stopRecordButton.scale(to: scaledSize)
        previewButton.scale(to: scaledSize)
        
        startRecordButton.name = NodeNames.StartRecordButton
        stopRecordButton.name = NodeNames.StopRecordButton
        previewButton.name = NodeNames.PreviewRecordingButton
        
        startRecordButton.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        stopRecordButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        previewButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        let buttonGroupStartLocation = CGPoint(x: ScreenSizeFloatConstants.HalfScreenWidth*0.70, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.90)
        
        startRecordButton.position = CGPoint(x: buttonGroupStartLocation.x, y: buttonGroupStartLocation.y)
        
        stopRecordButton.position = CGPoint(x: startRecordButton.position.x + 10, y: startRecordButton.position.y)
        
        let stopRecordButtonWidth = startRecordButton.size.width
        
        previewButton.position = CGPoint(x: stopRecordButton.position.x + stopRecordButtonWidth + 10, y: stopRecordButton.position.y)
        
        addChild(startRecordButton)
        addChild(stopRecordButton)
        addChild(previewButton)
    }
    
    final func setupMenuAndRestartButtons(){
        
        guard let menuButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-menu") else { return }
        
        guard let restartButtonTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("button-restart") else { return }
        
        menuButton = SKSpriteNode(texture: menuButtonTexture)
        restartButton = SKSpriteNode(texture: restartButtonTexture)
        
        menuButton.name = NodeNames.ReturnToMenuButton
        restartButton.name = NodeNames.RestartGameButton
        
        menuButton.size = CGSize(width: kViewWidth*0.2, height: kViewHeight*0.3)
        restartButton.size = CGSize(width: kViewWidth*0.2, height: kViewHeight*0.3)
        
        menuButton.position = CGPoint(x: kViewWidth*0.5*0.2, y: 0)
        restartButton.position = CGPoint(x: menuButton.position.x - menuButton.size.width - 30, y: menuButton.position.y)
        
        let returnToMenuText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        returnToMenuText.text = NSLocalizedString("Main Menu", comment: "")
        returnToMenuText.fontSize = 20.0
        returnToMenuText.fontColor = SKColor.white
        returnToMenuText.verticalAlignmentMode = .bottom
        returnToMenuText.position = CGPoint(x: menuButton.position.x, y: -menuButton.size.height)
        returnToMenuText.name = NodeNames.ReturnToMenuButton
        returnToMenuText.move(toParent: menuButton)
        
        let restartGameText = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        restartGameText.text = NSLocalizedString("Restart Level", comment: "")
        restartGameText.fontSize = 20.0
        restartGameText.fontColor = SKColor.white
        restartGameText.verticalAlignmentMode = .bottom
        restartGameText.position = CGPoint(x: restartButton.position.x, y: -restartButton.size.height)
        restartGameText.name = NodeNames.RestartGameButton
        restartGameText.move(toParent: restartButton)
        
        restartButton.zPosition = -15
        menuButton.zPosition = -15
        
        restartButton.alpha = 0
        menuButton.alpha = 0
        
        
        
        
        
    }
    
    final func showRestartButtons(){
        //Set the button alpha to zero
        
        setupMenuAndRestartButtons()
        
        restartButton.alpha = 1
        menuButton.alpha = 1
        
        menuButton.move(toParent: self)
        restartButton.move(toParent: self)
        
        menuButton.zPosition = 15
        restartButton.zPosition = 15
        
        
        let fadeAnimation = SKAction.fadeAlpha(to: 1.0, duration: 1.0)
        
        restartButton.run(fadeAnimation)
        menuButton.run(fadeAnimation)
    }
    
    
    final func loadMenuScene(){
        let transition = SKTransition.crossFade(withDuration: 2.00)
        let trackScene = TrackScene(size: self.size)
        self.view?.presentScene(trackScene, transition: transition)
    }
    
    final func showLevelCompleteLabel(){
        let labelNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        labelNode.fontColor = SKColor.yellow
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontSize = 45.0
        labelNode.text = NSLocalizedString("Level Complete! Well Done!", comment: "")
        labelNode.position = CGPoint(x: 0, y: ScreenSizeFloatConstants.ScrrenHeight*0.10)
        let scalingAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeAlpha(to: 0.7, duration: 0.5),
            SKAction.fadeAlpha(to: 1.0, duration: 0.5)
            ]))
        labelNode.run(scalingAction)
        labelNode.zPosition = 30
        
        
        let shapeNode = SKShapeNode(rectOf: CGSize(width: ScreenSizeFloatConstants.ScreenWidth*0.90, height: ScreenSizeFloatConstants.HalfScreenHeight*0.35))
        shapeNode.strokeColor = SKColor.black
        shapeNode.fillColor = SKColor(colorLiteralRed: 0.20, green: 0.20, blue: 0.60, alpha: 1.0)
        shapeNode.position = CGPoint(x: labelNode.position.x, y: labelNode.position.y)
        shapeNode.zPosition = 29
        self.addChild(shapeNode)
        self.addChild(labelNode)
        
    }
    
    final func showLevelIncompleteLabel(){
        let labelNode = SKLabelNode(fontNamed: FontTypes.NoteWorthyBold)
        labelNode.fontColor = SKColor.yellow
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontSize = 20.0
        labelNode.text = NSLocalizedString("Not Enough Enemies Killed! Better luck next time!", comment: "")
        labelNode.position = CGPoint(x: 30, y: -ScreenSizeFloatConstants.HalfScreenHeight*0.90)
        let scalingAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeAlpha(to: 0.7, duration: 0.5),
            SKAction.fadeAlpha(to: 1.0, duration: 0.5)
            ]))
        labelNode.run(scalingAction)
        labelNode.zPosition = 30
        
        
        let shapeNode = SKShapeNode(rectOf: CGSize(width: ScreenSizeFloatConstants.ScreenWidth*0.85, height: ScreenSizeFloatConstants.HalfScreenHeight*0.35))
        shapeNode.strokeColor = SKColor.black
        shapeNode.fillColor = SKColor(colorLiteralRed: 0.20, green: 0.20, blue: 0.60, alpha: 1.0)
        shapeNode.position = CGPoint(x: labelNode.position.x, y: labelNode.position.y)
        shapeNode.zPosition = 29
        self.addChild(shapeNode)
        self.addChild(labelNode)
        
        
    }
    
    final func showTimeUpLabel(){
        
        let timeUpTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .HUD)?.textureNamed("text_timeup")
        var timeUpSprite = SKNode()
        
        let chineseFlagText = NSLocalizedString("If", comment: "")
        
        if(chineseFlagText == "如果"){
            timeUpSprite = SKLabelNode(text: "时间到了!")
            let timeUpLabel = timeUpSprite as! SKLabelNode
            timeUpLabel.fontSize = 40.0
            timeUpLabel.horizontalAlignmentMode = .center
            timeUpLabel.verticalAlignmentMode = .center
            timeUpLabel.fontColor = SKColor.yellow
            
            
        } else {
            
            timeUpSprite = SKSpriteNode(texture: timeUpTexture)
            
        }
        
        
        timeUpSprite.position = CGPoint(x: 0.00, y: ScreenSizeFloatConstants.HalfScreenHeight*0.8)
        
        let originalZRotation = timeUpSprite.zRotation
        
        let scalingSequence = SKAction.sequence([
            SKAction.group([
                SKAction.scale(to: 1.30, duration: 1.0),
                SKAction.rotate(toAngle: 20, duration: 1.0)
                ]),
            SKAction.group([
                SKAction.scale(to: 0.70, duration: 1.0),
                SKAction.rotate(toAngle: originalZRotation, duration: 1.0)
                ])
            ])
        let scalingAction = SKAction.repeatForever(scalingSequence)
        
        timeUpSprite.run(scalingAction)
        timeUpSprite.name = NodeNames.TimeUpDisplay
        
        self.addChild(timeUpSprite)
        
    }
    
    
    func reloadCurrentLevel(){
        //To be overridden in derived classes
    }
    
    func loadNextLevel(){
        //To be overridden in derived classes
    }
    
    
}
