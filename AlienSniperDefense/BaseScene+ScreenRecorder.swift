//
//  BaseScene+ScreenRecorder.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 4/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import ReplayKit

extension BaseScene: RPScreenRecorderDelegate, RPPreviewViewControllerDelegate{
    
    var screenRecordingToggleEnabled: Bool{
        return UserDefaults.standard.bool(forKey: "screenRecordingEnabled")
    }
    func startScreenRecording(){
        
        guard screenRecordingToggleEnabled else { return }
        
        let sharedRecorder = RPScreenRecorder.shared()
        
        sharedRecorder.delegate = self
        
        //Start the recorder; if an error occurs, then an AlertViewController is shown; the handler for errors that occur in starting the recording is asynchronous but the AlertController will be shown on the Main Queue
        
        sharedRecorder.startRecording(handler: {
            
            error in
            
            if let error = error{
                self.showScreenRecordingAlert(message: error.localizedDescription)
            }
        
        })
    }
    
    func stopScreenRecording(withHandler handler: @escaping (() -> Void)){
        
        let sharedRecorder = RPScreenRecorder.shared()
        
        sharedRecorder.stopRecording(handler: {
        previewViewController, error in
            
            if let error = error{
                self.showScreenRecordingAlert(message: error.localizedDescription)
                return
            }
        
            if let previewViewController = previewViewController{
                previewViewController.previewControllerDelegate = self
                
                self.previewViewController = previewViewController
            }
            
            handler()
            
        })
    }
    
    func showScreenRecordingAlert(message: String){
        
        //Pause the scene and un-pause after the alert returns 
        currentGameState = .Paused
        
        //Shows the user that there was an error with starting or stopping the controller 
        
        let alertController = UIAlertController(title: "ReplayKit Error", message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.currentGameState = .Running
        })
        
        /** Ensure that the this event handler occurs on the main queue instead of a background queue
         
         **/
        DispatchQueue.main.async {
            self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    //RPScreenRecorderDelegate
    
    func screenRecorder(_ screenRecorder: RPScreenRecorder, didStopRecordingWithError error: Error, previewViewController: RPPreviewViewController?) {
        
        //If any error occurs while recording the GamePlay, display the alert message to the user
        showScreenRecordingAlert(message: error.localizedDescription)
        
        //Store a reference to the previewViewController that can be displayed when the user presses the preview button
        if previewViewController != nil{
            self.previewViewController = previewViewController
        }
    }
    
    //RPPreviewViewControllerDelegate
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        previewViewController?.dismiss(animated: true, completion: nil)
    }
    
}
