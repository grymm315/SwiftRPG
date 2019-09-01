//
//  BattleViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/29/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, BattleMenuDelegate {
    func chose(action: String) {
        print("Chose: \(action)")
        switch action {
        case "Attack":
        enemyHP.takeDamage(Int.random(in: 1...10))
        //attack(action)
        case "Magic":
            heroHP.heal(10)
//            menu.menuItems = ["Fire Bolt", "Flash", "Herpes"]
//            menu.reloadInputViews()
//            self.view.addSubview(menu.view)
        case "Item":
            print("Yet")
        default:
            print("Default")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            self.tick()
        })
    }
    
    
    var hero:Character = Character()
    var enemy:Character = Character()
    
    let GR:CGFloat = 0.6180340

    let menu:BattleMenu = BattleMenu()
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var enemyName: UILabel!
    @IBOutlet weak var enemyHP: HealthBar!
    @IBOutlet weak var heroHP: HealthBar!
    
    @IBOutlet weak var attkButton: UIButtonGUI!
    var heroPOS = 0
    var enemyPOS = 0
    
    
    let counter = 0
    
    
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height *  GR), size: CGSize(width: (UIScreen.main.bounds.width * (1 - GR)), height: (UIScreen.main.bounds.height * (1.0 - GR))))
        }
    }
    
    override func viewDidLoad() {
        let h = UIScreen.main.bounds.width * (GR * GR * GR)
        let w = UIScreen.main.bounds.width * GR
        enemy.race = .goblin
        enemyHP._maxHealth = enemy.maxHealth
        enemyHP._currentHealth = enemy.currentHealth
        enemyName.text = enemy.race.rawValue
        menu.startFrame = CGRect(x: 0, y: self.view.bounds.height, width: 20, height: 20)
        menu.delegate = self
        self.view.addSubview(menu.view)
//        self.present(menu, animated: true, completion: nil)
        heroHP.frame.origin.x = 0
        heroHP.frame.origin.y = (UIScreen.main.bounds.height * (1 - GR))
//        heroHP.frame = CGRect(x: 0, y: h + (UIScreen.main.bounds.height * (1 - GR)), width: w, height: h)
        heroHP._maxHealth = hero.maxHealth
        heroHP._currentHealth = hero.currentHealth
        heroName.text = hero.race.rawValue

    }
    
    func tick() {
        
        //lose condition
        if (heroHP._currentHealth < 0) {
            print("You perished in combat")
        }
        //win condition
        if (enemyHP._currentHealth < 0) {
            print ("You won")
            self.dismiss(animated: true, completion: nil)
        }
        
        
        if (heroPOS < enemyPOS) {
            heroPOS += hero.agility
            AIMove()
        } else {
            enemyPOS += enemy.agility
//            attkButton.isHidden = false
            menu.menuItems = ["Attack", "Magic", "Item", "Escape"]
            self.view.addSubview(menu.view)
        }
    }
    
    func attacks(_ who:Character, attacks victim:Character){
       // who.
    }
    
    func AIMove(){
//        heroHP._currentHealth -= Int.random(in: 1...10)
        heroHP.takeDamage(Int.random(in: 1...10))
//        heroHP.setNeedsDisplay()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            self.tick()
        })
    }
    
    //hero attacks enemy
    @IBAction func attack(_ sender: Any) {
   //     attkButton.isHidden = true
        
        
        enemyHP._currentHealth -= Int.random(in: 1...10)
        enemyHP.setNeedsDisplay()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
            self.tick()
        })
    }
    
    func punches(){
        
    }
    
    func stab(){
        
    }
    
    func fireball(){
        
    }
    
    func roll(){
        
    }
    
    func rocketpunch(){
        
    }
    
    func kick(){
        
    }
    
    func slow(){
        
    }
    
   
    
}
