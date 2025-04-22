//
//  BattleViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/29/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit
import AVFoundation


enum BattleActions {
    case heroAttacksMob,  heroHealsMob, heroAttacksHero, heroHealsHero, mobAttacksHero, mobHealsHero,  mobHealMob, youDied, youWin, flee, playerInput
}

protocol BattleViewActions {
    func battleAction(action: BattleActions, value: Int)
}
// TODO: This needs refactored
class BattleViewController: UIViewController, BattleMenuDelegate, BattleViewActions {
    
    
    
    @IBOutlet weak var enemyView: UIView!
    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var enemyImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var enemyName: UILabel!
    @IBOutlet weak var enemyHP: HealthBar!
    @IBOutlet weak var heroHP: HealthBar!
    
    @IBOutlet weak var attkButton: UIButtonGUI!
    
    @IBOutlet weak var lowerConsoleView: UIView!
    @IBOutlet weak var topEnemyView: UIView!
    var consoleText: NSMutableAttributedString =  NSMutableAttributedString(string: "", attributes: [.foregroundColor: UIColor.white])
    var isPaused:Bool = false
    var gameOver:Bool = false
        
    let menu:BattleMenu = BattleMenu()
    var heroPOS = 0
    var enemyPOS = 0
    
    let counter = 0
    @IBOutlet weak var consoleLog: UITextView!
    
    var hero:Character = GameDatabase.shared.hero
    var enemy:Character = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1 )
    let sound = SoundController()
    
    
    override func viewDidLoad() {
        enemyHP.alignHpTo(enemy)

        menu.delegate = self
//        self.view.addSubview(menu.view)
        let heroImage = UIImageView(frame: heroView.bounds)
        heroImage.image = UIImage(named: GameDatabase.shared.hero.image ?? "goblin")
        heroImage.contentMode = .scaleToFill
        
        heroView.addSubview(heroImage)
        
        
        heroHP.alignHpTo(hero)
        heroName.text = hero.name
        SoundController.shared.speak("You are attacked by a ferocious \(enemy.name).")
        BattleController.shared.battleDelegate = self
        BattleController.shared.start(hero, enemy)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enemyImage.image = UIImage(named: enemy.image ?? "goblin")
        enemyName.text = "\(enemy.name)"
    }
    
    func setBackgroundImage(){
        
    }
        
//    func tick() {
//        //lose condition
//        if (gameOver) {
//            print("The Battle is over")
//            return
//        }
//        //win condition
//        if (enemyHP._currentHealth <= 0) {
//            print ("You won")
//            let fanfare: SystemSoundID = 1025
//            AudioServicesPlaySystemSound(fanfare)
//            gameOver = true
//            isPaused = true
//            UIApplication.battleNotification("You have defeated \(enemy.name)!!")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//                UIApplication.battleNotification("You have gained 100 XP!!")
//                GameDatabase.shared.hero.rewardXp(100)
//            })
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
//                self.dismiss(animated: true, completion: nil)
//            })
//        }
//
//        if (heroPOS < enemyPOS) {
//            heroPOS += Int(hero.agility)
//            // sound.randomInsults()
//            AIMove()
//        } else {
//            enemyPOS += Int(enemy.agility)
//            menu.menuItems = ["Attack", "Heal", "Item", "Escape"]
//            self.view.addSubview(menu.view)
//        }
//    }
//
//
    func getBattleChoices() -> [String] {
        return ["Attack", "Heal", "Item", "Escape"]
    }
    func showBattleMenu() {
        menu.menuItems = getBattleChoices()
        self.view.addSubview(menu.view)
    }
    func chose(action: String) {
            //print("Chose: \(action)")
        SoundController.shared.tapSound()
        switch action {
        case "Attack":
            let hdmg = Int.random(in: 1...Int(hero.strength))
            enemyHP.takeDamage(hdmg)
            enemyImage.shake()
            displayLog("You deal \(hdmg) dmg to \(enemy.name)", color: UIColor.white)
            sound.painNoise()
        case "Heal":
            heroHP.heal(15)
            GameDatabase.shared.hero.currentHealth -= 15
            sound.magic()
            displayLog("You heal for 15 points", color: UIColor.green)
        case "Item":
            print("Yet")
        case "Escape":
            SoundController.shared.speak("You ran away like a cow-word!")
            self.dismiss(animated: true, completion: nil)
        default:
            print("Default")
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
//            self.tick()
        })
    }
    
    func battleAction(action: BattleActions, value: Int) {
        switch action {
        case .heroAttacksMob:
            enemyHP.alignHpTo(enemy)
            enemyImage.shake()
            displayLog("You deal \(value) damage to \(enemy.name)", color: UIColor.white)
            sound.painNoise()
            
        case .heroAttacksHero:
            displayLog("Stop hitting yourself for \(value) dmg", color: UIColor.red)
        case .mobAttacksHero:
            enemyImage.nudgeVertical(-70)
            GameDatabase.shared.hero.currentHealth -= value
            heroHP.alignHpTo(GameDatabase.shared.hero)
            displayLog("\(enemy.name) attacks you for \(value) points", color: UIColor.red)
            sound.painNoise()
            
        case .heroHealsMob:
            displayLog("Why are you healing the enemy for \(value) dmg", color: UIColor.green)
            enemyHP.alignHpTo(enemy)
            
        case .mobHealsHero:
            heroHP.heal(value)
            GameDatabase.shared.hero.currentHealth -= value
            sound.magic()
            displayLog("\(enemy.name) heals you for 15 points", color: UIColor.green)
            heroHP.alignHpTo(hero)

        case .heroHealsHero:
            heroHP.heal(value)
            GameDatabase.shared.hero.currentHealth -= value
            sound.magic()
            heroHP.alignHpTo(hero)
            displayLog("You heal for \(value) points", color: UIColor.green)

        case .mobHealMob:
            enemyHP.alignHpTo(enemy)

        case .youDied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.displayLog("You have died!!", color: UIColor.red)

                UIApplication.battleNotification("You have died!!")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                GameDatabase.shared.hero.heal(100)
                self.dismiss(animated: true, completion: nil)
            })
        case .youWin:
            print ("You won")
            let fanfare: SystemSoundID = 1025
            AudioServicesPlaySystemSound(fanfare)
            gameOver = true
            isPaused = true
            displayLog("You have defeated \(enemy.name)!!", color: UIColor.yellow)

            UIApplication.battleNotification("You have defeated \(enemy.name)!!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                GameDatabase.shared.hero.rewardXp(value)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.dismiss(animated: true, completion: nil)
            })
        case .flee:
            displayLog("They who flee and run away live to fight another day", color: UIColor.red)
            UIApplication.displayLog("They who flee and run away live to fight another day")
            SoundController.shared.speak("They who flee and run away live to fight another day")
            self.dismiss(animated: true, completion: nil)
        case .playerInput:
            displayLog("*", color: UIColor.yellow)
            showBattleMenu()
        }
    }
    
    override func viewDidLayoutSubviews() {
        topEnemyView.frame = UIScreen.main.getUpperFrame(ratio: 0.5)
        lowerConsoleView.frame = UIScreen.main.getLowerFrame(ratio: 0.5)
    }
    
    func displayLog(_ text: String, color: UIColor = UIColor.cyan){
        let attributedString = NSMutableAttributedString(string: text + "\n", attributes: [.foregroundColor: color])
        consoleText.append(attributedString)
        consoleLog.attributedText = consoleText
        if (self.consoleLog.contentSize.height > self.consoleLog.bounds.size.height){
            let bottom = self.consoleLog.contentSize.height - self.consoleLog.bounds.size.height
            self.consoleLog.setContentOffset(CGPoint(x: 0, y: bottom), animated: true)
        }
    }
    
//    func attacks(_ who:Character, attacks victim:Character){
//    }
//
//    func AIMove(){
//        let edmg = Int.random(in: 1...Int(enemy.strength))
//        enemyImage.nudgeVertical(-70)
//        heroHP.takeDamage(edmg)
//        GameDatabase.shared.hero.currentHealth -= edmg
//
//        UIApplication.battleNotification("\(enemy.race) attacks you for \(edmg) points")
//        sound.painNoise()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
//            self.tick()
//        })
//    }
//
//    //hero attacks enemy
//    @IBAction func attack(_ sender: Any) {
//        enemyHP._currentHealth -= Int.random(in: 1...10)
//        enemyHP.setNeedsDisplay()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
//            self.tick()
//        })
//    }
}


