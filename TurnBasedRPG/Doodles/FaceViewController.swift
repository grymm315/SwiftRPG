//
//  FaceViewController.swift
//  TurnBasedRPG
//
//  Created by TACTILIS on 8/22/19.
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Button1(_ sender: Any) {
        eyeObject.takeValue(CGFloat(slide1.value))
        eyeObject.blink()
        rightEyeObject.blink()
        print(slide1)
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
