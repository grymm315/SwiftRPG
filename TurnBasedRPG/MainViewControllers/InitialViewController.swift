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
        creditButton.fadeIn(1.0)
        startButton.fadeIn(1.0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

