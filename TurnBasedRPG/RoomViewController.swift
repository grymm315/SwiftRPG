//
//  RoomViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    @IBOutlet weak var oNorth: UIButtonGUI!
    @IBOutlet weak var oSouth: UIButtonGUI!
    @IBOutlet weak var oEast: UIButtonGUI!
    @IBOutlet weak var oWest: UIButtonGUI!
    
    @IBOutlet weak var roomName: UILabel!
    
    var currentRoom:RoomNode?
    var dood: FirstArea = FirstArea()
    var originReturn:CGPoint?
    var transitSpeed:Double = 0.3
    
    @IBOutlet weak var mobStack: UIStackView!
    let Gary:Face = Face()
    //let GaryHP:HealthBar = HealthBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originReturn = self.view.frame.origin
        moveRoom(to: dood.startRoom)
        print("From: \(self.view.frame.origin)")
        Gary.bounds = mobStack.frame
        self.view.addSubview(Gary)
       // mobStack.addSubview(Gary)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveRoom(to: RoomNode){
        currentRoom = to
        if ((currentRoom?.north) != nil){ oNorth.isHidden = false} else {oNorth.isHidden = true}
        if ((currentRoom?.east) != nil){ oEast.isHidden = false} else {oEast.isHidden = true}
        if ((currentRoom?.south) != nil){ oSouth.isHidden = false} else {oSouth.isHidden = true}
        if ((currentRoom?.west) != nil){ oWest.isHidden = false} else {oWest.isHidden = true}
        roomName.text = currentRoom?.title
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin = self.originReturn!
            })
    }
    
    @IBAction func moveNorth(_ sender: Any) {
        
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
        }, completion: {(finished:Bool) in
            print("From: \(self.view.frame.origin)")

            self.view.frame.origin.y =  -self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.north)!)
        })
    }
    
    @IBAction func moveWest(_ sender: Any) {
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
        }, completion: {(finished:Bool) in
            print("From: \(self.view.frame.origin)")

            self.view.frame.origin.x =  -self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.west)!)
        })
    }
    
    @IBAction func moveSouth(_ sender: Any) {
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.y =  -self.view.frame.height
        }, completion: {(finished:Bool) in
            print("From: \(self.view.frame.origin)")

            self.view.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.south)!)
        })
    }
    
    @IBAction func moveEast(_ sender: Any) {
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.x = -UIScreen.main.bounds.width
        }, completion: {(finished:Bool) in
            print("From: \(self.view.frame.origin)")
            self.view.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.east)!)
        })
    }
    
    
}
