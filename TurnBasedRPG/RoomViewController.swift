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
    
    @IBOutlet weak var roomView: UIImageView!
    @IBOutlet weak var commandMenu: UICollectionView!
        
    @IBOutlet var tappers: [UISwipeGestureRecognizer]!
    // This moves lines up Command + ALT + [
    // This moves lines down Command + ALT + ]
    
    // This is where our map starts during animation
    var originReturn:CGPoint? //* */
    var transitSpeed:Double = 0.16 //** How fast the screen transitions
    
    //The map hold all our RoomNodes
    var map: AreaGenerator = AreaGenerator(name: "adrift")
    //Where we currently are
    var currentRoom:RoomNode?
    
    let exploreEventMenu:PopUp = PopUp()
    let patrolEventMenu:PopUp = PopUp()
    let sneakEventMenu:PopUp = PopUp()
    
    var forceActionMenu:[Command] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCommandMenu()
        // These commands should be in a separate file
        // Hardcoding this for quick ideation
        let gremlin:Command = Command("Encounter Gremlin", completionHandler: {
            print("Encountered gremlin")
            self.performSegue(withIdentifier: "BattleView", sender: self)
        })
        let mushroom:Command = Command("Find Mushrooms", completionHandler: {
            print("Find Mushrooms")
            GameDatabase.shared.hero.rewardItem(Equipment(name: "Mushroom", description: "A mouldy a mushroom"))
        })
        let nothing:Command = Command("Nothing happens", completionHandler: {
            SoundController.shared.speak("You spend some time exploring but you find nothing")
        })
        let rock:Command = Command("Find Rock", completionHandler: {
            print("Find Rock")
            GameDatabase.shared.hero.rewardItem(Equipment(name: "Rock", description: "In an intelligence contest, this thing would have you beat"))
        })
        
        patrolEventMenu.options.append(gremlin)
        exploreEventMenu.options.append(mushroom)
        sneakEventMenu.options.append(nothing)
        exploreEventMenu.options.append(rock)

        exploreEventMenu.startFrame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height, width: 20, height: 20)

        // Setting the Origin Return to happen after the view did load
        // this is important for screen animations while transiting

        originReturn = CGRect(x: 0, y: 44, width: self.view.bounds.width, height: self.view.bounds.height - 44).origin
        
        moveRoom(to: map.startRoom)
                
        // for all the gesture recognizers
        for tip in tappers {
            tip.delegate = self
        }
        
        SoundController.shared.speak("Swipe to move.")

        commandMenu.delegate = self
        commandMenu.dataSource = self
        //For some reason this is causing the Cell not to register
//        commandMenu.register(CommandCell.self, forCellWithReuseIdentifier: "collectionCommand")
        self.view.bringSubviewToFront(commandMenu)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let clicked = sender as? UICollectionViewCell {
            if let next = segue.destination as? BattleViewController {
                next.enemyView = clicked.contentView
            }
        }
    }
    
    //This Adds commands to the menu
    func setCommandMenu() {
        forceActionMenu.append(contentsOf: [
            Command("Explore", completionHandler: {self.popMenu()}),
            Command("Patrol", completionHandler: {self.showPatrolMenu()}),
            Command("Sneak", completionHandler: {self.popMenu()}),
                                           ])
    }
    //This displays the command popup
    func popMenu() {
        SoundController.shared.menuOpen()
            view.addSubview(exploreEventMenu.view)
    }
    
    func showPatrolMenu() {
        SoundController.shared.menuOpen()
            view.addSubview(patrolEventMenu.view)
    }
    
    func showSneakMenu() {
        SoundController.shared.menuOpen()
            view.addSubview(sneakEventMenu.view)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if ((touch.view?.isKind(of: UIButton.self))!) {
                return false
            }
            return true
        }
    
    /** This method allows the user to manually traverse the room Map Node Tree */
    func moveRoom(to: RoomNode){
        currentRoom = to // Moving our current room to the next room
        if let tImage =  UIImage.init(named: currentRoom?.title ?? ""){
            roomView.image = tImage
        }

        UIView.animate(withDuration: transitSpeed, animations: {
            self.view.frame.origin = self.originReturn!
        })
    }
    
    func hideCommandMenu() {
        UIView.animate(withDuration: transitSpeed, animations: {
            self.commandMenu.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
        }, completion: {(finished:Bool) in
            self.commandMenu.frame.origin.y =  -self.view.frame.height
        })
    }
    
    func showCommandMenu() {
        
    }
    
    func dockMenuBottom() {
        
    }
    
    /// Swipe Actions
    @IBAction func moveNorth(_ sender: Any) {
        if (currentRoom?.north == nil){
            print("Can't go North!")
            SoundController.shared.noPassage()
            self.view.shakeVertical(-10)
            return
        }
        SoundController.shared.roomChangeSound()
        UIView.animate(withDuration: transitSpeed, animations: {
            self.roomView.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
        }, completion: {(finished:Bool) in
            self.roomView.frame.origin.y =  -self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.north)!)
        })
    }
    
    @IBAction func moveWest(_ sender: Any) {
        if (currentRoom?.west == nil){
            print("Can't go West!")
            self.view.shakeHorizontal()
            SoundController.shared.noPassage()
            return
        }
        SoundController.shared.roomChangeSound()
        UIView.animate(withDuration: transitSpeed, animations: {
            self.roomView.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
        }, completion: {(finished:Bool) in
            SoundController.shared.roomChangeSound()
            self.roomView.frame.origin.x =  -self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.west)!)
        })
    }
    
    @IBAction func moveSouth(_ sender: Any) {
        if (currentRoom?.south == nil){
            print("Can't go South!")
            self.view.shakeVertical()
            SoundController.shared.noPassage()
            return}
        SoundController.shared.roomChangeSound()

        UIView.animate(withDuration: transitSpeed, animations: {
            self.roomView.frame.origin.y =  -self.view.frame.height
        }, completion: {(finished:Bool) in
            self.roomView.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
            self.moveRoom(to: (self.currentRoom?.south)!)
        })
    }
    
    @IBAction func moveEast(_ sender: Any) {
        if (currentRoom?.east == nil){
            print("Can't go East!")
            SoundController.shared.noPassage()
            self.view.shakeHorizontal(-10)
            return}
        SoundController.shared.roomChangeSound()

        UIView.animate(withDuration: transitSpeed, animations: {
            self.roomView.frame.origin.x = -UIScreen.main.bounds.width
        }, completion: {(finished:Bool) in
            SoundController.shared.roomChangeSound()
            self.roomView.frame.origin.x = UIScreen.main.bounds.width + self.view.frame.width
            self.moveRoom(to: (self.currentRoom?.east)!)
        })
    }
    
    
    //Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forceActionMenu.count//currentRoom?.mob_list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //This button used to have just enemies. It now pops a quick menu
        let cell: CommandCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCommand", for: indexPath) as! CommandCell
       
        cell.visualize(forceActionMenu[indexPath.row].name)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let bvc = BattleViewController()
        // self.present(bvc, animated: true, completion: nil)
        forceActionMenu[indexPath.row].action()
    }
}


