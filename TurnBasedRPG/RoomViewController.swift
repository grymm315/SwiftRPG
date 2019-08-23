//
//  RoomViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var oNorth: UIButtonGUI!
    @IBOutlet weak var oSouth: UIButtonGUI!
    @IBOutlet weak var oEast: UIButtonGUI!
    @IBOutlet weak var oWest: UIButtonGUI!
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentRoom:RoomNode?
   // let bg:RoomView = RoomView()
    var dood: AreaGenerator = AreaGenerator(x: 5, y: 5)
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
        Gary.frame = CGRect(x: 200, y: 200, width: 75, height: 75)
        collectionView.delegate = self
        collectionView.dataSource = self
        Gary.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1045858305)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** This method allows the user to manually traverse the room Map Node Tree */
    func moveRoom(to: RoomNode){
        currentRoom = to

        if ((currentRoom?.north) == nil){ oNorth.isHidden = false} else {oNorth.isHidden = true}
        if ((currentRoom?.east) == nil){ oEast.isHidden = false} else {oEast.isHidden = true}
        if ((currentRoom?.south) == nil){ oSouth.isHidden = false} else {oSouth.isHidden = true}
        if ((currentRoom?.west) == nil){ oWest.isHidden = false} else {oWest.isHidden = true;}
        

        roomName.text = currentRoom?.title
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin = self.originReturn!
            })
        collectionView.reloadData()
    }
    
    func setWallView(_ exist: Bool, wall: UIButtonGUI){
        if (exist){
            wall.alpha = 0.1
            wall.isEnabled = true
        } else {
            wall.alpha = 1
            wall.isEnabled = false
        }
        
    }
    
    @IBAction func moveNorth(_ sender: Any) {
        if (currentRoom?.north == nil){
            print("Can't go North!")
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
        }, completion: {(finished:Bool) in
            self.view.frame.origin.y =  -self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.north)!)
        })
    }
    
    @IBAction func moveWest(_ sender: Any) {
        if (currentRoom?.west == nil){
             print("Can't go West!")
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
        }, completion: {(finished:Bool) in
            self.view.frame.origin.x =  -self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.west)!)
        })
    }
    
    @IBAction func moveSouth(_ sender: Any) {
        if (currentRoom?.south == nil){
             print("Can't go South!")
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.y =  -self.view.frame.height
        }, completion: {(finished:Bool) in
            self.view.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.south)!)
        })
    }
    
    @IBAction func moveEast(_ sender: Any) {
        if (currentRoom?.east == nil){
             print("Can't go East!")
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.x = -UIScreen.main.bounds.width
        }, completion: {(finished:Bool) in
            self.view.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.east)!)
        })
    }
    ///// Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentRoom?.mob_list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "enemy", for: indexPath)
        cell.backgroundColor = .red
        cell.contentView.addSubview(Face(frame: cell.bounds))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let bvc = BattleViewController()
       // self.present(bvc, animated: true, completion: nil)
        self.performSegue(withIdentifier: "BattleView", sender: self)
    }
    
    
}
