//
//  RoomViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit
//** This is the main view controller for navigating the map*/
class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var oNorth: UIButtonGUI!
    @IBOutlet weak var oSouth: UIButtonGUI!
    @IBOutlet weak var oEast: UIButtonGUI!
    @IBOutlet weak var oWest: UIButtonGUI!
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentRoom:RoomNode?
    var roomView: RoomView?
    var map: AreaGenerator = AreaGenerator(size: 20)
    var originReturn:CGPoint? //* */
    
    var transitSpeed:Double = 0.3 //** How fast the screen transitions
    
    @IBOutlet weak var mobStack: UIStackView!
    let Gary:Face = Face()
    //let GaryHP:HealthBar = HealthBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the Origin Return to happen after the view did load
        // this is important for screen animations while transiting
        originReturn = self.view.frame.origin
        
        roomView = RoomView(frame: CGRect(x: 0, y: 34, width: self.view.bounds.width, height: self.view.bounds.height - 80))
        self.view.addSubview(roomView!)
        moveRoom(to: map.startRoom)
        
        //I forget why I put a random face here... maybe testing
        Gary.frame = CGRect(x: 200, y: 200, width: 75, height: 75)
        Gary.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1045858305)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let clicked = sender as? UICollectionViewCell {
            if let next = segue.destination as? BattleViewController {
                next.enemyView = clicked.contentView
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** This method allows the user to manually traverse the room Map Node Tree */
    func moveRoom(to: RoomNode){
        currentRoom = to // Moving our current room to the next room
        roomView?.changeView(to: currentRoom!)
        roomName.text = currentRoom?.title
        
        //Moves the view back into view
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin = self.originReturn!
        })
        collectionView.reloadData()
    }
    
    //** @Deprecated No longer use this*/
    func setWallView(_ exist: Bool, wall: UIButtonGUI){
        if (exist){
            wall.alpha = 0.1
            wall.isEnabled = true
        } else {
            wall.alpha = 1
            wall.isEnabled = false
        }
    }
    
    /// Swipe Actions
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
    
    
    //Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentRoom?.mob_list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "enemy", for: indexPath)
        cell.backgroundColor = .red
        cell.backgroundView = Face(frame: cell.bounds)
        // cell.contentView.addSubview(Face(frame: cell.bounds))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let bvc = BattleViewController()
        // self.present(bvc, animated: true, completion: nil)
        self.performSegue(withIdentifier: "BattleView", sender: collectionView.cellForItem(at: indexPath))
    }
    
    
}
