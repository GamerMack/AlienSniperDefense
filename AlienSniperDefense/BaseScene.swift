//
//  BaseScene.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

/**  The Base Scene represent the essential functionality for scenes in different Game Tracks, including the Wingman Track, Bat Track, UFO Track, Flying Aliens Track, and Stealth Ship Track; Derived classes that inherit from the Base Scene will have unique game logic related to the AI for specific enemy characters as well as their own custom, convenience initializers that can be called in their respective level loaders but which will call the convenience initializer defined here for initializing basic scene properties (maximumNumberOfEnemies, numberOfEnemiesKilled, etc.)
 
 **/

class BaseScene: SKScene{
    
    
    //MARK: **************** Reference to Game Settings Singleton
    let currentGameSettings = GameSettings.sharedInstance
    var currentGamePlayMode: GameSettings.GamePlayModeVALUES = .valueMinimumKills
    
  
    //MARK: *****************Number for the Current Level
    enum CurrentTrack{
        case Wingman, Bat, UFO, StealthShip, FlyingAlien, None
    }
    
    var currenTrack: CurrentTrack = .None
    var levelNumber: Int = 1
    
    
    
    //MARK: ******************** UI Buttons
    var pauseButton = SKSpriteNode()
    var menuButton = SKSpriteNode()
    var restartButton = SKSpriteNode()
    
    var restartFromPauseState: SKSpriteNode?
    var returnToMenuFromPauseState: SKSpriteNode?
    
    var timerLabel: SKLabelNode?
    
    let timerLabelNumberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        
        nf.maximumIntegerDigits = 2
        nf.minimumIntegerDigits = 2
        
        return nf
    }()
    
    var sceneInterfaceManagerDelegate: SceneInterfaceManagerDelegate!
    var gameHasStarted: Bool = false
    
    
    //MARK: ********************* Explosion Animation (cached in the scene file for efficiency)
    var explosionAnimation = SKAction()
    var explosionSound = SKAction.playSoundFileNamed(SoundEffects.Explosion1, waitForCompletion: false)
    
    
    //MARK: *******************  GameState
    enum GameState{
        case Paused, Running
    }
    
    var currentGameState: GameState = .Running
    
    //MARK: ************** Background Objects Array and other related variables
    lazy var backgroundObjects: [BackgroundObject] = [
        BackgroundObject(backgroundObjectType: .Sun),
        BackgroundObject(backgroundObjectType: .Cloud1),
        BackgroundObject(backgroundObjectType: .Cloud2),
        BackgroundObject(backgroundObjectType: .FullMoon),
        BackgroundObject(backgroundObjectType: .HalfMoon),
        BackgroundObject(backgroundObjectType: .Cloud3),
        BackgroundObject(backgroundObjectType: .Cloud5),
        BackgroundObject(backgroundObjectType: .Cloud7),
        BackgroundObject(backgroundObjectType: .Cloud4)
    
    ]
    
    var numberOfBackgroundObjects: Int = 3
    var backgroundObjectsPositions = [CGPoint]()
    
    
    //MARK: ************** Variables pertaining to Game Rules and Scene Configuration
    var currentNumberOfEnemies: Int = 0
    var maximumNumberOFEnemies: Int = 10
    var numberOfEnemiesKilled: Int = 0
    var minimumKillsForLevelCompletion: Int = 0
    var numberOfBulletsFired: Int = 0
    
    var initialNumberOfEnemiesSpawned: Int = 2
    var levelDescription = String()
    var enemyName = String()
    var backGroundMusic = String()

    //MARK: *********************  Timer Related Variables
    var frameCount: TimeInterval = 0.00
    var lastUpdateTime: TimeInterval = 0.00
    var spawnInterval: TimeInterval = 5.00
    var enemiesSpawnedPerInterval: Int = 2
    var totalGameTime: TimeInterval = 0.00
    var timeLimit: TimeInterval = 60.00 //Time Limit set for TimeLimit Mode only
    var gameTimer: TimeInterval = 0.00
    var modifiedCurrentTime: TimeInterval = 0.00
    
    //MARK: ******************** Random Point Generator
    let randomPointGenerator = RandomPoint(algorithmType: .Faster)
    
    //MARK: ******************* HUD display
    var hud2 = HUD2()
    
    //MARK: ***************** Player Variables
    var player: CrossHair!
    var playerType: CrossHair.CrossHairType!
    var shootingSound = SKAction.playSoundFileNamed(SoundEffects.Laser9, waitForCompletion: false)
    
    
    //MARK: ***************SCENE INITIALIZERS
    convenience init(size: CGSize, levelNumber: Int, levelDescription: String, enemyName: String, crossHairType: CrossHair.CrossHairType, backgroundMusic: String, numberOfBackgroundObjects: Int, spawnInterval: TimeInterval, initialNumberOfEnemiesSpawned: Int, enemiesSpawnedPerInterval: Int, maximumNumberOfEnemiesAllowed: Int, minimumKillsForLevelCompletion: Int, timeLimit: TimeInterval = 60.00) {
    
        self.init(size: size)
        
        //Configure Opening/Intro Start Window
        self.levelNumber = levelNumber
        self.levelDescription = levelDescription
        self.enemyName = enemyName
        
        //Configure Player Type and Background Music
        self.playerType = crossHairType
        self.backGroundMusic = backgroundMusic
        
        
        //Configure Time Limit
        self.timeLimit = timeLimit
            
        //Configure Game Rules and basic AI logic
        self.spawnInterval = spawnInterval
        self.enemiesSpawnedPerInterval = enemiesSpawnedPerInterval
        self.initialNumberOfEnemiesSpawned = initialNumberOfEnemiesSpawned
        self.maximumNumberOFEnemies = maximumNumberOfEnemiesAllowed
        self.minimumKillsForLevelCompletion = minimumKillsForLevelCompletion
        
        //Configure background objects
        self.numberOfBackgroundObjects = numberOfBackgroundObjects
        
       
    }
    
    override func didMove(to view: SKView) {
        //Add an observer for the PresentAuthenticationViewController notification
        /** FUTURE VERSIONS
         
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(GameViewController.showAuthenticationViewController), name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
    
        **/
        
        //Set gameHasStarted to false, set totalGameTime to zero
        gameHasStarted = false
        totalGameTime = 0.00
        
        //Register Pause and Resume notifications with NSNotification center
        registerNotifications()
        
        //Basic scene configuration
        performBasicSceneConfiguration()
        
        //Set current GamePlay mode
        setCurrentGamePlayMode()

    }
    
    //MARK: ***************** Registration for NSNotifications
    
    func registerNotifications(){
        
        //Register Pause and Resume notifications with NSNotification center
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(BaseScene.pauseGame), name: Notification.Name(rawValue: "Pause"), object: nil)
        
        nc.addObserver(self, selector: #selector(BaseScene.resumeGame), name: Notification.Name(rawValue: "Resume"), object: nil)
        
    }
    
    //MARK: ****************** Set Current GamePlay Mode
    func setCurrentGamePlayMode(){
        currentGamePlayMode = currentGameSettings.getGamePlayMode()
    }
    
    //MARK: ************** Basic Scene Configuration
    
    func performBasicSceneConfiguration(){
        //Set anchor point of current scene to center
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.black
        
        //Set initial game state to running
        self.currentGameState = .Running
        self.gameHasStarted = false
        
        //Configure player
        player = CrossHair(crossHairType: self.playerType)
        self.addChild(player)
        
        //Configure explosion animation
        configureExplosionAnimation()
        
        //Configure particle emitter for background
        let emitterPath = Bundle.main.path(forResource: "StarryNight", ofType: "sks")!
        let emitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as! SKEmitterNode
        emitterNode.targetNode = self
        emitterNode.move(toParent: self)
        
        
        //Configure SceneInterfaceManagerDelegate
        sceneInterfaceManagerDelegate = SceneInterfaceManager(newManagedScene: self)
        
        let tempTexta = NSLocalizedString("Level ", comment: "")
        
        var tempTextb: String
        
        if(tempTexta == "等级 "){
            switch(levelNumber){
            case 1:
                tempTextb = tempTexta.appending("-")
                break
            case 2:
                tempTextb = tempTexta.appending("二")
                break
            case 3:
                tempTextb = tempTexta.appending("三")
                break
            case 4:
                tempTextb = tempTexta.appending("四")
                break
            case 5:
                tempTextb = tempTexta.appending("五")
                break
            default:
                tempTextb = tempTexta.appending("零")
                break
            }
        } else {
            tempTextb = tempTexta.appending("\(levelNumber)")
            
        }
        
        
        
        if(currentGameSettings.getGamePlayMode() == .valueTimeLimit){
            
            sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: tempTextb, levelDescription: self.levelDescription, enemyName: self.enemyName, levelTimeLimit: self.timeLimit, minimumKillsForLevelCompletion: self.minimumKillsForLevelCompletion)
            
            configureTimerButton()
            
            
        }else{
            
           
            sceneInterfaceManagerDelegate.setupIntroMessageBox(levelTitle: tempTextb, levelDescription: self.levelDescription, enemyName: self.enemyName, spawningLimit: self.maximumNumberOFEnemies, minimumKillsForLevelCompletion: self.minimumKillsForLevelCompletion)
        }
        

        
        
        
        //Configure initial HUD display
        currentNumberOfEnemies = 0
        numberOfEnemiesKilled = 0
        self.addChild(hud2)
        
        hud2.setNumberOfEnemiesTo(numberOfEnemies: currentNumberOfEnemies)
        hud2.setNumberOfEnemiesKilledTo(numberKilled: numberOfEnemiesKilled)
        
        
        //Spawn Background Objects
        spawnBackgroundObjects(numberOfBackgroundObjects: self.numberOfBackgroundObjects, scaledByFactorOf: 0.40)
        
        
        //Add the Pause Button
        configurePauseButton()
        
        
        //Configure the Pause State Buttons
        setupPauseStateButtons()
    
        
    }
    
    //MARK: *********** Function for Configuring and Updating Timer Button
    
    final func configureTimerButton(){
        self.timerLabel = SKLabelNode(fontNamed: FontTypes.NoteWorthyLight)
        if let timerLabel = timerLabel {
            timerLabel.fontColor = SKColor.yellow
            timerLabel.verticalAlignmentMode = .center
            timerLabel.horizontalAlignmentMode = .right
            timerLabel.fontSize = 15.0
        
            let timerYPos = -ScreenSizeFloatConstants.HalfScreenHeight*0.85
            let timerXPos = ScreenSizeFloatConstants.HalfScreenWidth*0.90
            timerLabel.position = CGPoint(x: timerXPos, y: timerYPos)
        
           
            let timeRemaining = self.timeLimit - self.totalGameTime
            
            
            let timerNumber = NSNumber(value: timeRemaining)
            let numberString = timerLabelNumberFormatter.string(from: timerNumber)
            
            if(numberString != nil){
                let timerText = NSLocalizedString("Time Remaining: \(numberString!)", comment: "")
                timerLabel.text = timerText
            }
        
            self.addChild(timerLabel)
        }
    }
    
    final func updateTimerButton(){
        if let timerLabel = self.timerLabel{
           
            var timeRemaining = self.timeLimit - self.totalGameTime
            
            timeRemaining = timeRemaining < 0.00 ? 0.00 : timeRemaining

            let timerNumber = NSNumber(value: timeRemaining)
            let numberString = timerLabelNumberFormatter.string(from: timerNumber)
            
            if(numberString != nil){
                let tempTexta = NSLocalizedString("Time Remaining: ", comment: "")
                let tempTextb = tempTexta.appending("\(numberString!)")
                
                let timerText = NSLocalizedString(tempTextb, comment: "")
                timerLabel.text = timerText
            }
        }
    }
 
    
    //MARK: *************** GAME LOOP FUNCTIONS (these will be overriden and customized in subclasses)
    
    override func update(_ currentTime: TimeInterval) {
        //Keep track of total game time
        if(gameHasStarted){
            totalGameTime += currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        if(currentGameState == .Paused) { return }
        
        //Lose Condition in TimeLimit Mode: Total Game Time exceeds Maximum Time Limit
        if(currentGamePlayMode == .valueTimeLimit){
            
            updateTimerButton()

            
            if(totalGameTime > timeLimit){
                
                if(numberOfEnemiesKilled > minimumKillsForLevelCompletion){
                    /**If player exceeds minimum kill count at the expiration of the timer,
                        then advance to the next level **/

                        self.run(SKAction.sequence([
                            SKAction.run({
                                self.showLevelCompleteLabel()

                            }),
                            SKAction.wait(forDuration: 2.00),
                            SKAction.run({
                                self.loadNextLevel()
                            })]))

                    
                } else {
                    /**If player fails to meet the minimum kill count by the end of timer countdown, then show Menu and Restart Buttons
                        **/
                        showTimeUpLabel()
                        showLevelIncompleteLabel()
                        self.isPaused = true
                        self.showRestartButtons()
                }
                

            }
        }
        
        
        //Lose Condition in Minimum Kills Mode: Number of OnScreen Enemies exceeds Maximum Number of Enemies Allowed
        if(currentGamePlayMode == .valueMinimumKills){
            if(currentNumberOfEnemies > maximumNumberOFEnemies){
                
                //Configure label for "Too many enemies spawned" notice
                showTooManyEnemiesLabel()
                
                
                self.isPaused = true
                self.showRestartButtons()
                
            }
            
            
            if(numberOfEnemiesKilled > minimumKillsForLevelCompletion){
                savePlayerStatsForLevel()
                loadNextLevel()
            }
            
        }
        
        
        //player.update()

       

    }
    
  
    
    
    //MARK: ******************* USER INPUT HANDLERS (these will be overriden and customized in subclasses)
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(currentGameState == .Paused) { return }
        
        let node = touches.first! as UITouch
        let touchLocation = node.location(in: self)
        
        player.setTargetPosition(position: touchLocation)
        
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if player.contains(touchLocation){
            numberOfBulletsFired += 1
        }
        
        for node in nodes(at: touchLocation){
            
            if node.name == NodeNames.PauseButton, let node = node as? SKLabelNode{
                
                //Ensures that pause button is not activated if player is shooting enemies close by
                if player.contains(touchLocation){
                    return
                }
                
                //Reconfigure Pause Button to become a Resume button
                node.name = NodeNames.ResumeButton
                
                node.text = NSLocalizedString("Resume", comment: "")
                /**
                for subNode in node.children{
                    if let subNode = subNode as? SKLabelNode{
                        subNode.text = "Resume"
                        subNode.name = NodeNames.ResumeButton
                    }
                }
                 **/
                
                showPauseStateButtons()
                pauseGame()
                
                
                
            } else if node.name == NodeNames.ResumeButton, let node = node as? SKLabelNode{
                //Ensures that resume button is not activated if player is shooting enemies close by
                if player.contains(touchLocation){
                    return
                }
                
                //Reconfigure Pause Button to become a Resume button
                node.name = NodeNames.PauseButton
                node.text = NSLocalizedString("Pause", comment: "")
                
                /**
                for subNode in node.children{
                    if let subNode = subNode as? SKLabelNode{
                        subNode.text = "Pause"
                        subNode.name = NodeNames.PauseButton
                    }
                }
                **/
                
                removePauseStateButtons()
                resumeGame()

                
            }
            
        }
        
      
        if(restartButton.contains(touchLocation)){
            
            //Remove time up display when restarting
            for node in nodes(at: touchLocation){
                if node.name == NodeNames.TimeUpDisplay{
                    node.removeFromParent()
                }
            }
            
            reloadCurrentLevel()
        }
        
        if(menuButton.contains(touchLocation)){
           loadMenuScene()
        }
        
        
        for node in nodes(at: touchLocation){
            if node.name == NodeNames.ReturnToMenuButton{
                loadMenuScene()
            }
            
            if node.name == NodeNames.RestartGameButton{
                reloadCurrentLevel()
            }
        }
        
        if(currentGameState == .Paused) { return }
        

        for node in nodes(at: touchLocation){
            
            if node.name == NodeNames.StartButton{
                //Remove the start window to begin game
                gameHasStarted = true
                node.removeFromParent()
                currentGameState = .Running
            }
            
         
        }
        
    }
    
    
   
    
    func spawnEnemyFromPrototype(numberOfEnemy: Int){
        //This method is to be overrided in derived classes
        
    }
    
    func spawnBackgroundObjects(numberOfBackgroundObjects: Int, scaledByFactorOf scaleFactor: CGFloat){
        
        let numberOfObjects: Int = numberOfBackgroundObjects > (backgroundObjects.count-1) ? (backgroundObjects.count-1) : numberOfBackgroundObjects
        
        
        for index in 0..<numberOfObjects{
            
            let randomSpawnPoint = index % 2 == 0 ? randomPointGenerator.getUpperScreenPoint() : randomPointGenerator.getLowerScreenPoint()
            
            backgroundObjects[index].zPosition = -1
            backgroundObjects[index].position = randomSpawnPoint
            backgroundObjectsPositions.append(randomSpawnPoint)
            
            self.addChild(backgroundObjects[index])
        }
    }
    
    
    final func configurePauseButton(){
        if let newPauseButton = ButtonManager.getPauseButton(){
            pauseButton = newPauseButton
            pauseButton.name = NodeNames.PauseButton

            let xPos = -ScreenSizeFloatConstants.HalfScreenWidth*0.85
            let yPos = -ScreenSizeFloatConstants.HalfScreenHeight*0.90
            
            let buttonWidth =  ScreenSizeFloatConstants.HalfScreenWidth*0.20
            let buttonHeight = ScreenSizeFloatConstants.HalfScreenHeight*0.15
            
            let size = CGSize(width: buttonWidth, height: buttonHeight)
            pauseButton.position = CGPoint(x: xPos, y: yPos)
            pauseButton.size = size
            pauseButton.zPosition = 15
            self.addChild(pauseButton)
            
        }
        
    }


    final func configureExplosionAnimation(){
        if let textureAtlas = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .RegularExplosion){
            
            self.explosionAnimation = SKAction.animate(with: [
                textureAtlas.textureNamed("regularExplosion00"),
                textureAtlas.textureNamed("regularExplosion01"),
                textureAtlas.textureNamed("regularExplosion02"),
                textureAtlas.textureNamed("regularExplosion03"),
                textureAtlas.textureNamed("regularExplosion04"),
                textureAtlas.textureNamed("regularExplosion05"),
                textureAtlas.textureNamed("regularExplosion06"),
                textureAtlas.textureNamed("regularExplosion07"),
                textureAtlas.textureNamed("regularExplosion08")
                ], timePerFrame: 0.05)
            
        }
    }
    
    
    final func setGamePlayModeForScene(){
        
        currentGamePlayMode = currentGameSettings.getGamePlayMode()
        

    }
    
    //MARK: *************  Game State Functions (registered with NotificationCenter)
    func pauseGame(){
        currentGameState = .Paused
        self.isPaused = true
    }
    
    func resumeGame(){
        currentGameState = .Running
        self.isPaused = false
        
    
    }
    
    //MARK: *********** Remove observers for Pause and Resume Notifications, as well as for PresentAuthenticationViewController
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
}


//MARK: *****************************SCENE EXTENSION

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

extension BaseScene{
    
    typealias LevelTuple = (currentTrack: CurrentTrack, currentLevelNumber: Int)
    
    func savePlayerStatsForLevel(){
        
        let currentLevelTuple: LevelTuple = (currentTrack: self.currenTrack, currentLevelNumber: self.levelNumber)
        
        switch(currentLevelTuple){
        case (.Bat, 1):
                currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Bat, .Level1))
                currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Bat, .Level1))
                currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Bat, .Level1))
                currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Bat, .Level1))
                currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Bat, .Level1))
            break
        case (.Bat, 2):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Bat, .Level2))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Bat, .Level2))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Bat, .Level2))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Bat, .Level2))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Bat, .Level2))
            break
        case (.Bat, 3):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Bat, .Level3))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Bat, .Level3))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Bat, .Level3))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Bat, .Level3))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Bat, .Level3))
           
            break
        case (.Bat, 4):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Bat, .Level4))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Bat, .Level4))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Bat, .Level4))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Bat, .Level4))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Bat, .Level4))
            
            break
        case (.Bat, 5):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Bat, .Level5))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Bat, .Level5))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Bat, .Level5))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Bat, .Level5))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Bat, .Level5))
            break
            
        case (.FlyingAlien, 1):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.FlyingAlien, .Level1))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.FlyingAlien, .Level1))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.FlyingAlien, .Level1))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.FlyingAlien, .Level1))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.FlyingAlien, .Level1))
            break
        case (.FlyingAlien, 2):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.FlyingAlien, .Level2))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.FlyingAlien, .Level2))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.FlyingAlien, .Level2))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.FlyingAlien, .Level2))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.FlyingAlien, .Level2))
            break
        case (.FlyingAlien, 3):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.FlyingAlien, .Level3))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.FlyingAlien, .Level3))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.FlyingAlien, .Level3))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.FlyingAlien, .Level3))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.FlyingAlien, .Level3))
            break
        case (.FlyingAlien, 4):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.FlyingAlien, .Level4))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.FlyingAlien, .Level4))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.FlyingAlien, .Level4))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.FlyingAlien, .Level4))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.FlyingAlien, .Level4))
            break
        case (.FlyingAlien, 5):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.FlyingAlien, .Level5))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.FlyingAlien, .Level5))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.FlyingAlien, .Level5))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.FlyingAlien, .Level5))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.FlyingAlien, .Level5))
            break

        case (.StealthShip, 1):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.StealthShips, .Level1))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.StealthShips, .Level1))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.StealthShips, .Level1))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.StealthShips, .Level1))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.StealthShips, .Level1))
            break
        case (.StealthShip, 2):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.StealthShips, .Level2))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.StealthShips, .Level2))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.StealthShips, .Level2))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.StealthShips, .Level2))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.StealthShips, .Level2))
            break
        case (.StealthShip, 3):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.StealthShips, .Level3))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.StealthShips, .Level3))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.StealthShips, .Level3))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.StealthShips, .Level3))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.StealthShips, .Level3))
            break
        case (.StealthShip, 4):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.StealthShips, .Level4))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.StealthShips, .Level4))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.StealthShips, .Level4))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.StealthShips, .Level4))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.StealthShips, .Level4))
            break
        case (.StealthShip, 5):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.StealthShips, .Level5))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.StealthShips, .Level5))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.StealthShips, .Level5))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.StealthShips, .Level5))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.StealthShips, .Level5))
            break

        case (.UFO, 1):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.UFO, .Level1))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.UFO, .Level1))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.UFO, .Level1))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.UFO, .Level1))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.UFO, .Level1))
            break
        case (.UFO, 2):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.UFO, .Level2))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.UFO, .Level2))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.UFO, .Level2))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.UFO, .Level2))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.UFO, .Level2))
            break
        case (.UFO, 3):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.UFO, .Level3))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.UFO, .Level3))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.UFO, .Level3))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.UFO, .Level3))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.UFO, .Level3))
            break
        case (.UFO, 4):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.UFO, .Level4))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.UFO, .Level4))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.UFO, .Level4))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.UFO, .Level4))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.UFO, .Level4))
            break
        case (.UFO, 5):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.UFO, .Level5))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.UFO, .Level5))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.UFO, .Level5))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.UFO, .Level5))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.UFO, .Level5))
            break

        case (.Wingman, 1):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Wingman, .Level1))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Wingman, .Level1))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Wingman, .Level1))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Wingman, .Level1))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Wingman, .Level1))
            break
        case (.Wingman, 2):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Wingman, .Level2))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Wingman, .Level2))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Wingman, .Level2))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Wingman, .Level2))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Wingman, .Level2))
            break
        case (.Wingman, 3):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Wingman, .Level3))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Wingman, .Level3))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Wingman, .Level3))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Wingman, .Level3))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Wingman, .Level3))
            break
        case (.Wingman, 4):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Wingman, .Level4))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Wingman, .Level4))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Wingman, .Level4))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Wingman, .Level4))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Wingman, .Level4))
            break
        case (.Wingman, 5):
            currentGameSettings.saveLevelCompletionStatus(isCompleted: true, levelInfo: (.Wingman, .Level5))
            currentGameSettings.saveTotalNumberOfBulletsFired(totalBulletsFired: self.numberOfBulletsFired, levelInfo: (.Wingman, .Level5))
            currentGameSettings.saveTotalNumberOfKills(totalKills: self.numberOfEnemiesKilled, levelInfo: (.Wingman, .Level5))
            currentGameSettings.saveTotalNumberOfSpawnedEnemies(totalSpawnedEnemies: self.currentNumberOfEnemies, levelInfo: (.Wingman, .Level5))
            currentGameSettings.saveTotalRunningTime(totalRunningTime: self.totalGameTime, levelInfo: (.Wingman, .Level5))
            break

        default:
            break  //No stats saved
        }
    
    }
}

