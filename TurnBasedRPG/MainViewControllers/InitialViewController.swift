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
        startButton.fromBottom()
        creditButton.fromBottom()
        settingsButton.fromBottom()
        shareButton.fromBottom()
        startButton.fadeIn(1.0)
        creditButton.fadeIn(1.2)
        settingsButton.fadeIn(1.4)
        shareButton.fadeIn(1.6)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

