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
    
    var authenticationViewController: UIViewController?
    var enableGameCenter: Bool = false
    var lastError: Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundLoader.preloadSounds()
        
        //Add to Notification Center an observer for the PresentAuthenticationNotification
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(GameViewController.showAuthenticationViewController), name: Notification.Name(rawValue: GameKitHelper.PresentAuthenticationViewController), object: nil)
        
        
        //Authenticate the local player to access GameCenter services
        let localPlayer = GKLocalPlayer.localPlayer()
      
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
        
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
           let menuScene = MenuScene(size: self.view.bounds.size)
            menuScene.scaleMode = .aspectFill
        
        let testScene = TestScene(size: self.view.bounds.size)
        testScene.scaleMode = .aspectFit
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
        //TODO: Need to access the authentication view controller from GameCenter
       // present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true, completion: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
