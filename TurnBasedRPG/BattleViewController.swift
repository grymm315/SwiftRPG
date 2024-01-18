//
//  BattleViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/29/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit
import AVFoundation

// TODO: This needs refactored
class BattleViewController: UIViewController, BattleMenuDelegate {
    var hero:Character = GameDatabase.shared.hero
    var enemy:Character = Character(strength: 3, perception: 3, endurance: 3, charisma: 3, intelligence: 3, luck: 3, agility: 9 )
    let sound = SoundController()
    
    @IBOutlet weak var enemyView: UIView!
    @IBOutlet weak var heroView: UIView!
    
    var isPaused:Bool = false
    var gameOver:Bool = false
    
    let GR:CGFloat = 0.6180340
    
    let menu:BattleMenu = BattleMenu()
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var enemyName: UILabel!
    @IBOutlet weak var enemyHP: HealthBar!
    @IBOutlet weak var heroHP: HealthBar!
    
    @IBOutlet weak var attkButton: UIButtonGUI!
    var heroPOS = 0
    var enemyPOS = 0
    
    lazy var statusText: UILabel = UILabel()
    let counter = 0
    
    
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height *  GR), size: CGSize(width: (UIScreen.main.bounds.width * (1 - GR)), height: (UIScreen.main.bounds.height * (1.0 - GR))))
        }
    }
    
    override func viewDidLoad() {
        enemy.race = .goblin
        enemyHP._maxHealth = enemy.maxHealth
        enemyHP._currentHealth = enemy.currentHealth
        enemyName.text = enemy.race.rawValue
        enemyView.addSubview(Face(frame: enemyView.bounds))

        menu.delegate = self
        self.view.addSubview(menu.view)
//        heroHP.frame.origin.x = 0
        heroView.addSubview(FaceView(frame: heroView.bounds))
        //  heroHP.frame.origin.y = (UIScreen.main.bounds.height / 2)
        heroHP._maxHealth = hero.maxHealth
        heroHP._currentHealth = hero.currentHealth
        heroName.text = hero.race.rawValue
        SoundController.shared.speak("You are attacked by a ferocious goblin.")
    }
    
    func popText(_ text:String){
        statusText.text = text
        statusText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        statusText.textAlignment = .center
        statusText.layer.backgroundColor = #colorLiteral(red: 0.1549019754, green: 0.1745098174, blue: 0.119607961, alpha: 1)
        statusText.layer.cornerRadius = 12
        statusText.layer.borderWidth = 2
        statusText.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        statusText.frame = CGRect(x: 15, y: 80, width: UIScreen.main.bounds.width - 30, height: 50)
        self.view.addSubview(statusText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
            self.statusText.removeFromSuperview()
        })
        
    }
    
    
    func tick() {
        //lose condition
        if (gameOver) {
            print("You perished in combat")
            return
        }
        //win condition
        if (enemyHP._currentHealth < 0) {
            print ("You won")
            isPaused = true
            let fanfare: SystemSoundID = 1025
            AudioServicesPlaySystemSound(fanfare)
            gameOver = true
            self.dismiss(animated: true, completion: nil)
        }
        
        
        if (heroPOS < enemyPOS) {
            heroPOS += Int(hero.agility)
            // sound.randomInsults()
            AIMove()
        } else {
            enemyPOS += Int(enemy.agility)
            menu.menuItems = ["Attack", "Magic", "Item", "Escape"]
            self.view.addSubview(menu.view)
        }
    }
    
    func chose(action: String) {
        print("Chose: \(action)")
        SoundController.shared.tapSound()
        switch action {
        case "Attack":
            let hdmg = Int.random(in: 1...Int(hero.strength))
            enemyHP.takeDamage(hdmg)
            popText("You deal \(hdmg) dmg to \(enemy.race)")
            sound.painNoise()
        case "Magic":
            heroHP.heal(15)
            sound.magic()
            popText("You heal for 15 points")
        case "Item":
            print("Yet")
        case "Escape":
            SoundController.shared.speak("You ran away like a cow-word!")
            self.dismiss(animated: true, completion: nil)
        default:
            print("Default")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            self.tick()
        })
    }
    
    func attacks(_ who:Character, attacks victim:Character){
    }
    
    func AIMove(){
        let edmg = Int.random(in: 1...Int(enemy.strength))
        heroHP.takeDamage(edmg)
        popText("\(enemy.race) attacks you for \(edmg) points")
        sound.painNoise()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            self.tick()
        })
    }
    
    //hero attacks enemy
    @IBAction func attack(_ sender: Any) {
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
