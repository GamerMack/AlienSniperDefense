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
import GameKit

class GameViewController: UIViewController {
    
    //TODO: Add observers for Notification(that is, PresentAuthenticationViewController) to the base scene as well as the TitleScene, TrackScene, and other transitional scenes, since the authentication handler is executed asynchronously and may complete after TitleScene/TrackScene/BaseScene is loaded
    
    let localPlayer = GKLocalPlayer.localPlayer()
    var authenticationViewController: UIViewController?
    var enableGameCenter: Bool = false
    var lastError: Error?
    var match: GKMatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundLoader.preloadSounds()
        
        //Add to Notification Center an observer for the PresentAuthenticationNotification
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(GameViewController.showAuthenticationViewController), name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
        
        nc.addObserver(self, selector: #selector(GameViewController.startMultiplayerGamePlay), name: Notification.Name(rawValue: GameKitHelper.StartMultiplayerGame), object: nil)
        

        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
           let menuScene = MenuScene(size: self.view.bounds.size)
            menuScene.scaleMode = .aspectFill
        
        let testScene = TestScene(size: self.view.bounds.size)
        testScene.scaleMode = .aspectFit
        
        let batScene4 = BatSceneLevelLoader.getLevel4Scene(size: self.view.bounds.size, difficultyLevel: .Easy)
        let batScene5 = BatSceneLevelLoader.getLevel5Scene(size: self.view.bounds.size, difficultyLevel: .Easy)
        
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(menuScene)
                    
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
    
    func authenticateLocalPlayer(){
        let localPlayer = self.localPlayer
        
        localPlayer.authenticateHandler = {
            (viewController: UIViewController?, error: Error?) -> Void in
            
            self.setLastError(lastError: error)
            
            if(viewController != nil){
                
                self.setAuthenticationViewController(authenticationViewController: viewController)
                
            } else if(localPlayer.isAuthenticated){
                
                self.enableGameCenter = true
                
            } else {
                
                
                self.enableGameCenter = false
                
            }
            
            
            
        }
    }
    
    private func setAuthenticationViewController(authenticationViewController: UIViewController?){
        if(authenticationViewController != nil){
            self.authenticationViewController = authenticationViewController
            
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
        }
    }
    
    private func setLastError(lastError: Error?){
        if let lastError = lastError{
            self.lastError = lastError
            logLastError()
        }
        
    }
    
    private func logLastError(){
        if let lastError = self.lastError{
            print("The last error to occur was: \(lastError.localizedDescription)")
        }
    }
    
    func showAuthenticationViewController(){
        //Authentication view controller is passed in as an argument to the callback function that is set for the event handler;
        if let authenticationViewController = self.authenticationViewController{
            present(authenticationViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: Call this method to present the GKGameCenterViewController that allows users to view current achievements; the game should pause before using this interface
    func viewCurrentAchievements(){
        
        if(!enableGameCenter) { return }
        
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        
        gameCenterViewController.viewState = .achievements
    
        present(gameCenterViewController, animated: false, completion: nil)
        
    }
    
    //MARK: *********** Call this method to update progress on achievements that are not hidden to the player (e.g. progress towards completion of certain tracks
    func reportProgressTowardsAnAchievement(){
        if(!enableGameCenter) { return }
        
        let newAchievement = GKAchievement()
        var achievements = [GKAchievement]()
        achievements.append(newAchievement)
        
        GKAchievement.report(achievements, withCompletionHandler: { (error: Error?) -> Void in
            
            if(error != nil){
                //TODO: handle error in reporting achievement
            }
        
        })
    }
    
    
    //MARK: *********** Load the player's achievements up-to-date
    func loadAchievementsForCurrentPlayer(){
        
        if(!enableGameCenter) { return }
        
        GKAchievement.loadAchievements(completionHandler:{ (achievements: [GKAchievement]?, error: Error?) -> Void in
            
            if(error != nil){
                //TODO: handle the error
            } else if let achievements = achievements {
                
                for achievement in achievements{
                    //achievement.identifier
                    //achievement.percentComplete
                    //achievement.isCompleted
                    
                }
            }
        })
    }
    
    
    //MARK: ********* When the player selects the multiplayer option in the MenuScene,a notification is posted, whose observer is implemented in the GameViewController class and which calls the startMultiplayerGamePlay method
    //TODO: ********* Register/post notifications for the StartMultiplayerGameplay Option
    func startMultiplayerGamePlay(){
        
        if(!enableGameCenter) {
            //If GameCenter is not enabled, make sure the player is logged in
            authenticateLocalPlayer()
        }
        
        
        let matchRequest = GKMatchRequest()
        matchRequest.maxPlayers = 2
        matchRequest.minPlayers = 2
        
        let matchMakerController = GKMatchmakerViewController(matchRequest: matchRequest)
        
        if let mmvc = matchMakerController{
            mmvc.delegate = self
            present(mmvc, animated: false, completion: nil)
        }
    }
    

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: ************ Conformance to GKMatchmakerViewControllerDelegate methods
extension GameViewController: GKMatchmakerViewControllerDelegate{
    
    //MARK: ********* The user has cancelled matchmaking
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ********* Matchmaking failed with an error
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
        print("Error finding match: \(error.localizedDescription)")
        
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true, completion: nil)
        
        self.match = match
        match.delegate = self
        
        if(match.expectedPlayerCount == 0){
            print("Ready to start match")
        }
        
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, hostedPlayerDidAccept player: GKPlayer) {
        //TODO: Not yet implemented
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFindHostedPlayers players: [GKPlayer]) {
        //TODO: Not yet implemented
    }
    
}



//MARK: ************ Conformance to GKGameCenterControllerDelegate
extension GameViewController: GKGameCenterControllerDelegate{
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        
    
        
    }
}

//MARK: ************ Conformance to GKMatchDelegate Methods
extension GameViewController: GKMatchDelegate{
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
    }
    
    //MARK: ********* For 1v1 games, will attempt to reconnect to the player if connection was interrupted
    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return true
    }
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        
    }
    
    func match(_ match: GKMatch, didReceive data: Data, forRecipient recipient: GKPlayer, fromRemotePlayer player: GKPlayer) {
        
    }
    
}

//MARK: ********** Conformance to UINavigationControllerDelegate methods
extension GameViewController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    //TODO: ****** Refactor to use UITraitEnvironment and UITraitCollection APIs
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.landscape
    }
    
    /**
    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
    
    }
     **/
    
    /**
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
    }
     **/
    
    /**
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
    }
     **/
}


