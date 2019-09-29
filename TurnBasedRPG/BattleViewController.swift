//
//  BattleViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/29/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit
import AVFoundation

class BattleViewController: UIViewController, BattleMenuDelegate {
    var hero:Character = Character(strength: 9, perception: 9, endurance: 9, charisma: 9, intelligence: 9, luck: 9, agility: 3)
    var enemy:Character = Character(strength: 3, perception: 3, endurance: 3, charisma: 3, intelligence: 3, luck: 3, agility: 9 )
    let sound = SoundController()
    
    @IBOutlet weak var enemyView: UIView!
    @IBOutlet weak var heroView: UIView!
    
    let synth = AVSpeechSynthesizer()
    let insults = [
        "Ye! YA!",
        "You'll never leave here alive!",
        "Is this an enemy that approaches?",
        "Prepare to Die",
        "Coo sew",
        "Ah",
        
        ]
    
    let painString = [
    "Ga",
    "Aaaa",
    "sh",
    "Fuck"
    
    ]
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
        let h = UIScreen.main.bounds.width * (GR * GR * GR)
        let w = UIScreen.main.bounds.width * GR
        enemy.race = .goblin
        enemyHP._maxHealth = enemy.maxHealth
        enemyHP._currentHealth = enemy.currentHealth
        enemyName.text = enemy.race.rawValue
        enemyView.addSubview(Face(frame: enemyView.bounds))
        menu.startFrame = CGRect(x: 0, y: self.view.bounds.height, width: 20, height: 20)
        menu.delegate = self
        self.view.addSubview(menu.view)
        heroHP.frame.origin.x = 0
      //  heroHP.frame.origin.y = (UIScreen.main.bounds.height / 2)
        heroHP._maxHealth = hero.maxHealth
        heroHP._currentHealth = hero.currentHealth
        heroName.text = hero.race.rawValue
        sound.randomSong()
    }
    
    func popText(_ text:String){
        statusText.text = text
        statusText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        statusText.textAlignment = .center
        statusText.layer.backgroundColor = #colorLiteral(red: 0.1549019754, green: 0.1745098174, blue: 0.119607961, alpha: 1)
        statusText.layer.cornerRadius = 12
        statusText.layer.borderWidth = 2
        statusText.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        statusText.frame = CGRect(x: 15, y: 50, width: UIScreen.main.bounds.width - 30, height: 50)
        self.view.addSubview(statusText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
            self.statusText.removeFromSuperview()
            })
        
    }
//
//    func randomInsults(){
//        let utterance = AVSpeechUtterance(string: insults.randomElement() ?? "Oh Shit")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-IE")
//        utterance.rate = 0.55
//        utterance.pitchMultiplier = 0.6
//        print("Saying: \(utterance.speechString)")
//        synth.speak(utterance)
//        
//    }
//    
//    func painNoise(){
//        let utterance = AVSpeechUtterance(string: painString.randomElement() ?? "Oh Shit")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-IE")
//        utterance.rate = 0.77
//        utterance.pitchMultiplier = 0.5
//        print("Saying: \(utterance.speechString)")
//        synth.speak(utterance)
//        
//    }
//    
//    
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
        switch action {
        case "Attack":
            let hdmg = Int.random(in: 1...Int(hero.strength))
            enemyHP.takeDamage(hdmg)
            popText("You deal \(hdmg) dmg to \(enemy.race)")
            sound.randomInsults()
        case "Magic":
            heroHP.heal(15)
            sound.magic()
            popText("You heal for 15 points")
        case "Item":
            print("Yet")
        case "Escape":
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
