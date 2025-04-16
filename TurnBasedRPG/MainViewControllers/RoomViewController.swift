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

class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, LogDelegate {
  
    
    @IBOutlet weak var consoleView: UIView!
    @IBOutlet weak var roomView: UIView!
    
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var commandMenu: UICollectionView!
        
    @IBOutlet weak var dayNight: UIImageView!
    @IBOutlet var gestures: [UISwipeGestureRecognizer]!

    @IBOutlet weak var hpBar: HealthBar!
    @IBOutlet weak var mpBar: HealthBar!
    @IBOutlet weak var energyBar: HealthBar! //granola = delicious
    
    @IBOutlet weak var logView: UITextView!
    @IBOutlet weak var exitParticles: ParticleView!
    // This is where our map starts during animation
    var originReturn:CGPoint? //* */
    var transitSpeed:Double = 0.16 //** How fast the screen transitions
    
    //The map hold all our RoomNodes
//    var map: AreaGenerator = AreaGenerator(name: "adrift")
    //Where we currently are
    var currentRoom:RoomNode?
    
    let exploreEventMenu:PopUp = PopUp()
    let patrolEventMenu:PopUp = PopUp()
    let sneakEventMenu:PopUp = PopUp()
    
    var forceActionMenu:[Command] = []
    
    fileprivate func setHealthBars() {
        hpBar._maxHealth = GameDatabase.shared.hero.maxHealth
        hpBar._currentHealth = GameDatabase.shared.hero.currentHealth
        hpBar.takeDamage(0)
        
        mpBar._maxHealth = GameDatabase.shared.hero.maxMana
        mpBar._currentHealth = GameDatabase.shared.hero.currentMana
        mpBar.takeDamage(0)
        
        energyBar._maxHealth = GameDatabase.shared.hero.maxEnergy
        energyBar._currentHealth = GameDatabase.shared.hero.currentEnergy
        energyBar.takeDamage(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCommandMenu()
        
        setHealthBars()
        
        // Setting the Origin Return to happen after the view did load
        // this is important for screen animations while transiting
//        roomImage.frame = roomView.frame
        originReturn = UIScreen.main.goldenLargeLowerFrame().origin//self.view.frame.origin
        roomImage.contentMode = .scaleAspectFill
        logView.attributedText = GameDatabase.shared.logFile
        GameDatabase.shared.logDelegate = self
                
        currentRoom = GameDatabase.shared.currentRoom // Moving our current room to the next room
        if let tImage =  UIImage.init(named: currentRoom?.title ?? ""){
            print("Entered room \(currentRoom?.title ?? "!ERROR!")")
            roomImage.image = tImage
            exitParticles.indicateSwipe(forRoom: currentRoom!)
        }

                
        // for all the gesture recognizers
        for swipe in gestures {
            swipe.delegate = self
        }
        
        SoundController.shared.speak("Swipe to move.")

        commandMenu.delegate = self
        commandMenu.dataSource = self
        //For some reason this is causing the Cell not to register
//        commandMenu.register(CommandCell.self, forCellWithReuseIdentifier: "collectionCommand")
        self.view.bringSubviewToFront(commandMenu)
    }
    
    override func viewDidLayoutSubviews() {
        consoleView.frame = UIScreen.main.getUpperFrame(ratio: 0.30)
        consoleView.layer.masksToBounds = true
        roomView.frame = UIScreen.main.getLowerFrame(ratio: 0.30)
        originReturn = UIScreen.main.getLowerFrame(ratio: 0.30).origin
        text("", color: UIColor.white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setHealthBars()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(".... FOR BATTLE!!")

            print("clicked")
            if let battleView = segue.destination as? BattleViewController {
                print("PREPARE FOR BATTLE!!")
                if let monster = sender as? Monster{
                    battleView.enemy = monster.instance
                }
            } else {
                print("... what is \(segue.destination.debugDescription)")
            }
        
    }
    
    func text(_ text: String, color: UIColor) {
        logView.attributedText = GameDatabase.shared.logFile
        let bottom = self.logView.contentSize.height - self.logView.bounds.size.height
        self.logView.setContentOffset(CGPoint(x: 0, y: bottom), animated: true)
    }
    
    //This Adds commands to the menu
    func setCommandMenu() {
        // These commands should be in a separate file
        // Hardcoding this for quick ideation
        
        forceActionMenu.append(contentsOf: [
            Command("Find", completionHandler: {self.popMenu()}),
            Command("Fight", completionHandler: {self.showPatrolMenu()}),
            Command("Speak", completionHandler: {self.showSneakMenu()}),
        ])
        
        let gremlin:Command = Command("Encounter Goblin", completionHandler: {
            self.performSegue(withIdentifier: "BattleView", sender: self)
        })
        let bobaGirl:Command = Command("Talk to Boba Girl", completionHandler: {
            self.performSegue(withIdentifier: "NpcDialog", sender: self)
        })
        let mushroom:Command = Command("Find BuzzPop", completionHandler: {
            GameDatabase.shared.hero.rewardItem(ItemRack.buzzPop.instance)
        })
        let nothing:Command = Command("Nothing happens", completionHandler: {
            SoundController.shared.speak("You spend some time exploring but you find nothing")
        })
        let rock:Command = Command("Find armor", completionHandler: {
            GameDatabase.shared.hero.rewardItem(ArmorRack.chainChest.instance)
        })
        let crown:Command = Command("Steal Crown", completionHandler: {
            GameDatabase.shared.hero.rewardItem(ArmorRack.crown.instance)
        })
        let xpPot:Command =  Command("Find XP Potion", completionHandler: {
            GameDatabase.shared.hero.rewardItem(ItemRack.xpPotion.instance)
        })
        
        let healthPot:Command =  Command("Find Health Potion", completionHandler: {
            GameDatabase.shared.hero.rewardItem(ItemRack.healthPotion.instance)
        })
        
        let saveGame:Command =  Command("Save Game", completionHandler: {
                GameDatabase.shared.saveGame()
        })
        
        let loadGame:Command =  Command("Load Game", completionHandler: {
                GameDatabase.shared.loadGame()
        })
        
        
        patrolEventMenu.options.append(gremlin)
        sneakEventMenu.options.append(bobaGirl)

        exploreEventMenu.options.append(crown)
        exploreEventMenu.options.append(rock)
        exploreEventMenu.options.append(mushroom)
        exploreEventMenu.options.append(xpPot)
        exploreEventMenu.options.append(healthPot)
        exploreEventMenu.options.append(saveGame)
        exploreEventMenu.options.append(loadGame)


        
        exploreEventMenu.prompt = "Find a thing"


        exploreEventMenu.startFrame = commandMenu.frame
        sneakEventMenu.startFrame = commandMenu.frame
        patrolEventMenu.startFrame = commandMenu.frame
        
        commandMenu.backgroundColor = UIColor.blue
        commandMenu.layer.borderColor = UIColor.white.cgColor
        commandMenu.layer.borderWidth = 4.0
        commandMenu.layer.cornerRadius = 20
        let showDevConsole = !UserDefaults.standard.bool(forKey: "DevConsole")
        commandMenu.isHidden = showDevConsole

        
    }
    //This displays the command popup
    func popMenu() {
        SoundController.shared.menuOpen()
            view.addSubview(exploreEventMenu.view)
    }
    
    func showPatrolMenu() {
        SoundController.shared.menuOpen()
        patrolEventMenu.updateViews()
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
        GameDatabase.shared.currentRoom = to
        if let tImage =  UIImage.init(named: currentRoom?.title ?? ""){
            print("Entered room \(currentRoom?.title ?? "!ERROR!")")
            roomImage.image = tImage
        }
        exitParticles.indicateSwipe(forRoom: to)
        
        waitDayNight(self)
        GameDatabase.shared.hero.rewardXp(1)
        GameDatabase.shared.hero.adjustEnergyLevel(-2)
        energyBar.takeDamage(2)
        UIView.animate(withDuration: transitSpeed, animations: {
//            self.view.frame.origin = self.originReturn!
            self.roomView.frame.origin = self.originReturn!
            
        })
    }
    
    func randomChance(){
        if (Bool.random()){
            //randomly we ain't doin shit- exit logic
            return
        }
        switch self.currentRoom?.environment {
        case .forest:
            print("forest")
            patrolEventMenu.options = ForestEncounters.allCases.randomElement()!.instance
            self.showPatrolMenu()
            return
        case .city:
            print("City")
            patrolEventMenu.options = CityEncounters.allCases.randomElement()!.instance
            self.showPatrolMenu()
            return
        case .highway:
            print("Highway")
            patrolEventMenu.options = HighwayEncounters.allCases.randomElement()!.instance
            self.showPatrolMenu()
            return
            
        default:
            print("This environment has no encounters")
        }
    }
    
    @IBAction func waitDayNight(_ sender: Any) {
        print("Waiting")
        dayNight.rotate()
        GameDatabase.shared.hero.adjustEnergyLevel(1)
        energyBar._currentHealth = GameDatabase.shared.hero.currentEnergy
        energyBar.heal(0)
        randomChance()
    }
    
    func hideCommandMenu() {
        UIView.animate(withDuration: transitSpeed, animations: {
            self.commandMenu.frame.origin.y = UIScreen.main.bounds.height + self.view.frame.height
        }, completion: {(finished:Bool) in
            self.commandMenu.frame.origin.y =  -self.view.frame.height
        })
    }
    
    func exhausted() -> Bool {
        if (GameDatabase.shared.hero.currentEnergy <= 0){
            self.view.shake()
            UIApplication.systemMessage("You are too tired.")
            waitDayNight(self)
            return true
        } else {
            return false
        }
    }
    

    /// Swipe Actions
    @IBAction func moveNorth(_ sender: Any) {
        if (currentRoom?.north == nil){
            SoundController.shared.noPassage()
            self.view.nudgeVertical(-10)
            return
        }
        
        if (exhausted()){return}
        
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
            self.view.nudgeHorizontal()
            SoundController.shared.noPassage()
            return
        }
        if (exhausted()){return}
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
            self.view.nudgeVertical()
            SoundController.shared.noPassage()
            return}
        if (exhausted()){return}
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
            SoundController.shared.noPassage()
            self.view.nudgeHorizontal(-10)
            return}
        if (exhausted()){return}
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
        collectionView.cellForItem(at: indexPath)?.shrink()
        SoundController.shared.tapSound()
        forceActionMenu[indexPath.row].action()
    }
}


