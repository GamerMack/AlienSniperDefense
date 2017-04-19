//
//  ScreenRecorderOptionsVC.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 4/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

class ScreenRecorderOptionsVC: UIViewController, UINavigationControllerDelegate{
    
   
    let enableRecordButton = UIButton(type: UIButtonType.roundedRect)
    let disableRecordButton = UIButton(type: UIButtonType.roundedRect)
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
      
   
        
        enableRecordButton.translatesAutoresizingMaskIntoConstraints = false
        disableRecordButton.translatesAutoresizingMaskIntoConstraints = false
        

        view.addSubview(enableRecordButton)
        view.addSubview(disableRecordButton)
        
        
        
        NSLayoutConstraint.activate([
            enableRecordButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20.00),
            enableRecordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enableRecordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            enableRecordButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
            disableRecordButton.topAnchor.constraint(equalTo: enableRecordButton.bottomAnchor, constant: 20.00),
            disableRecordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            disableRecordButton.widthAnchor.constraint(equalTo: enableRecordButton.widthAnchor),
            disableRecordButton.heightAnchor.constraint(equalTo: enableRecordButton.heightAnchor)
            
            ])
        
        
        
        let enableRecordLabel = UILabel()
        enableRecordLabel.text = "Enable Screen Recording"
        enableRecordLabel.textAlignment = .center
        enableRecordButton.addSubview(enableRecordLabel)
        
        enableRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            enableRecordLabel.centerXAnchor.constraint(equalTo: enableRecordButton.centerXAnchor),
            enableRecordLabel.centerYAnchor.constraint(equalTo: enableRecordButton.centerYAnchor),
            enableRecordLabel.widthAnchor.constraint(equalTo: enableRecordButton.widthAnchor, multiplier: 0.90),
            enableRecordLabel.heightAnchor.constraint(equalTo: enableRecordButton.heightAnchor, multiplier: 0.90)
            ])
        
        let disableRecordLabel = UILabel()
        disableRecordLabel.text = "Enable Screen Recording"
        disableRecordLabel.textAlignment = .center
        disableRecordButton.addSubview(disableRecordLabel)
        
        disableRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            disableRecordLabel.centerXAnchor.constraint(equalTo: disableRecordButton.centerXAnchor),
            disableRecordLabel.centerYAnchor.constraint(equalTo: disableRecordButton.centerYAnchor),
            disableRecordLabel.widthAnchor.constraint(equalTo: disableRecordButton.widthAnchor, multiplier: 0.90),
            disableRecordLabel.heightAnchor.constraint(equalTo: disableRecordButton.heightAnchor, multiplier: 0.90)
            ])
    
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
    
        enableRecordButton.addTarget(self, action: #selector(ScreenRecorderOptionsVC.enableScreenRecording), for: UIControlEvents.touchDown)
        
        disableRecordButton.addTarget(self, action: #selector(ScreenRecorderOptionsVC.disableScreenRecording), for: UIControlEvents.touchDown)
    }
    
    
    func enableScreenRecording(){
        UserDefaults.standard.set(true, forKey: "screenRecordingEnabled")
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func disableScreenRecording(){
        UserDefaults.standard.set(false, forKey: "screenRecordingEnabled")
        navigationController?.popToRootViewController(animated: true)
    }
    
}
