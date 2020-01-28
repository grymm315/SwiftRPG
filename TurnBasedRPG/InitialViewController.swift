//
//  ViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    var numbers:[Int] = []
    var power:[Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for num in 1...70 {
            numbers.append(num)
        }
        for pnum in 1...25 {
            power.append(pnum)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshnumbers(_ sender: Any) {
        
        numbers.shuffle()
        numbers.shuffle()
        numbers.shuffle()
        power.shuffle()
        
        let winner:String = "\(numbers[1...5]) Mega: \(power.randomElement() ?? 13))"
        print(winner)
        status.text = winner
        
    }
    
}

