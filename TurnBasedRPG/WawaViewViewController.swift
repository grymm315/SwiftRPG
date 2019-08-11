//
//  WawaViewViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 2/21/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit
import AVFoundation

class WawaViewViewController: UIViewController {

    @IBOutlet weak var scanLine: ScanLine!
    var bombSoundEffect: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let path = Bundle.main.path(forResource: "wawa.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.numberOfLoops = -1
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
 
            UIView.animate(withDuration: 0.6, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.scanLine.frame.origin = CGPoint(x: self.view.frame.width, y: self.scanLine.frame.origin.y)
        }, completion: {(finished:Bool) in
             self.scanLine.frame.origin = CGPoint(x: 0, y: self.scanLine.frame.origin.y)
        })
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
