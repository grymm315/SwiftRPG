//
//  FaceViewController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 8/22/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var slide1: UISlider!
    @IBOutlet weak var slide2: UISlider!
    @IBOutlet weak var slide3: UISlider!
    @IBOutlet weak var rightEyeObject: Eye!
    @IBOutlet weak var eyeObject: Eye!
    @IBOutlet weak var FaceButton1: UIButton!
    @IBOutlet weak var slide4: UISlider!
    @IBOutlet weak var slide5: UISlider!
    
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Button1(_ sender: Any) {
        eyeObject.takeValue(CGFloat(slide1.value), CGFloat(slide2.value), CGFloat(slide3.value), CGFloat(slide4.value),CGFloat(slide5.value))
        rightEyeObject.takeValue(CGFloat(slide1.value), CGFloat(slide3.value), CGFloat(slide2.value), CGFloat(slide4.value),CGFloat(slide5.value))
        eyeObject.blink()
       self.view.sendSubviewToBack(FaceButton1)
        rightEyeObject.blink()
        
        if let slide1 = slide1 {
            print(slide1)
        }
        
        l1.text = "Arc::\(slide1.value)"
        l2.text = "Outter:\(slide2.value)"
        l3.text = "Inner:\(slide3.value)"
        l4.text = "Position:\(slide4.value)"
        l5.text = "Size:\(slide5.value)"
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
