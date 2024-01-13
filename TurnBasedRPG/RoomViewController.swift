//
//  RoomViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit
import AVFoundation

//** This is the main view controller for navigating the map*/
class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("touching \(String(describing: touch.view))")
        if ((touch.view?.isKind(of: UIButton.self))!) {
                return false
            }
            return true
        }
    
    @IBOutlet var tappers: [UISwipeGestureRecognizer]!
    
    
    //o is for outlet
    @IBOutlet weak var oNorth: UIButtonGUI!
    @IBOutlet weak var oSouth: UIButtonGUI!
    @IBOutlet weak var oEast: UIButtonGUI!
    @IBOutlet weak var oWest: UIButtonGUI!
    
    @IBOutlet weak var roomimage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let soundController = SoundController()
    
    var currentRoom:RoomNode?
//    var roomView: RoomView?
    var map: AreaGenerator = AreaGenerator(name: "adrift")
    var originReturn:CGPoint? //* */
    
    var transitSpeed:Double = 0.3 //** How fast the screen transitions
    
//    @IBOutlet weak var mobStack: UIStackView!
    let Gary:Face = Face()
    //let GaryHP:HealthBar = HealthBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the Origin Return to happen after the view did load
        // this is important for screen animations while transiting
//        originReturn = self.view.bounds.origin
        
//        roomView = RoomView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 80))
        originReturn = CGRect(x: 0, y: 44, width: self.view.bounds.width, height: self.view.bounds.height - 44).origin
        
//        self.view.addSubview(roomView!)
        moveRoom(to: map.startRoom)
        
        //I forget why I put a random face here... maybe testing
        Gary.frame = CGRect(x: 200, y: 200, width: 75, height: 75)
        Gary.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1045858305)
        
        // for all the gesture recognizers
        for tip in tappers {
            tip.delegate = self
        }
        
//        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EnemyCell.self, forCellWithReuseIdentifier: "enemy")
        self.view.bringSubviewToFront(collectionView)
        
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
//        roomView?.changeView(to: currentRoom!)
        if let tImage =  UIImage.init(named: currentRoom?.title ?? ""){
            roomimage.image = tImage
        }

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
    
    func walkSound(){
        let tiptoe: SystemSoundID = 1055
        AudioServicesPlaySystemSound(tiptoe)
    }
    
    func noExitSound(){
        soundController.tock()
    }
    /// Swipe Actions
    @IBAction func moveNorth(_ sender: Any) {
        if (currentRoom?.north == nil){
            print("Can't go North!")
            soundController.tock()
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
        }, completion: {(finished:Bool) in
            self.soundController.whoosh()
            self.view.frame.origin.y =  -self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.north)!)
        })
    }
    
    @IBAction func moveWest(_ sender: Any) {
        if (currentRoom?.west == nil){
            print("Can't go West!")
            self.noExitSound()
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
        }, completion: {(finished:Bool) in
            self.soundController.whoosh()
            self.view.frame.origin.x =  -self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.west)!)
        })
    }
    
    @IBAction func moveSouth(_ sender: Any) {
        if (currentRoom?.south == nil){
            print("Can't go South!")
            self.noExitSound()
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.y =  -self.view.frame.height
        }, completion: {(finished:Bool) in
            self.soundController.whoosh()
            self.view.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.south)!)
        })
    }
    
    @IBAction func moveEast(_ sender: Any) {
        if (currentRoom?.east == nil){
            print("Can't go East!")
            self.noExitSound()
            return}
        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin.x = -UIScreen.main.bounds.width
        }, completion: {(finished:Bool) in
            self.soundController.whoosh()
            self.view.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.east)!)
        })
    }
    
    
    //Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3//currentRoom?.mob_list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "enemy", for: indexPath) as! EnemyCell
        cell.backgroundColor = .red
//        cell.backgroundView = Face(frame: cell.bounds)
        cell.isUserInteractionEnabled = true
        // cell.contentView.addSubview(Face(frame: cell.bounds))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("????")

        return true
    }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let bvc = BattleViewController()
        // self.present(bvc, animated: true, completion: nil)
        print("BATTLE TIME!!")
        let suspense: SystemSoundID = 1032
        AudioServicesPlaySystemSound(suspense)
        
        self.performSegue(withIdentifier: "BattleView", sender: collectionView.cellForItem(at: indexPath))
    }
    
    
}

class EnemyCell: UICollectionViewCell {
    
    @IBOutlet weak var pressedButton: UIButton!
    @IBAction func doPress(_ sender: Any) {
        print("at least something happened")
    }
}
