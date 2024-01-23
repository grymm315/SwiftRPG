//
//  ViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButtonGUI!
    @IBOutlet weak var creditButton: UIButtonGUI!
    @IBOutlet weak var settingsButton: UIButtonGUI!
    @IBOutlet weak var shareButton: UIButtonGUI!
    
    @IBAction func creditAction(_ sender: Any) {
        print("Roll the credits")
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startButton.fromBottom(startButton.animationSpeed)
        settingsButton.fromBottom(settingsButton.animationSpeed)
        creditButton.fromBottom(creditButton.animationSpeed)
        shareButton.fromBottom(shareButton.animationSpeed)
        
        startButton.fadeIn(startButton.animationSpeed)
        settingsButton.fadeIn(settingsButton.animationSpeed)
        creditButton.fadeIn(creditButton.animationSpeed)
        shareButton.fadeIn(shareButton.animationSpeed)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

