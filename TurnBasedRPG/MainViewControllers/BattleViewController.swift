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
    case heroAttacksMob,  heroHealsMob, heroAttacksHero, heroHealsHero, mobAttacksHero, mobHealsHero,  mobHealMob, youDied, youWin, flee
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
    
    var isPaused:Bool = false
    var gameOver:Bool = false
        
    let menu:BattleMenu = BattleMenu()
    var heroPOS = 0
    var enemyPOS = 0
    
    let counter = 0
    
    var hero:Character = GameDatabase.shared.hero
    var enemy:Character = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1 )
    let sound = SoundController()
    
    
    override func viewDidLoad() {
        enemy.race = .goblin
        enemyHP.alignHpTo(enemy)

        menu.delegate = self
//        self.view.addSubview(menu.view)
        heroView.addSubview(FaceView(frame: heroView.bounds))
        
        heroHP.alignHpTo(hero)
        heroName.text = hero.name
        SoundController.shared.speak("You are attacked by a ferocious \(enemy.race.rawValue).")
        BattleController.shared.battleDelegate = self
        BattleController.shared.start(hero, enemy)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enemyImage.image = UIImage(named: enemy.image ?? "Willy")
        
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
    func chose(action: String) {
            //print("Chose: \(action)")
        SoundController.shared.tapSound()
        switch action {
        case "Attack":
            let hdmg = Int.random(in: 1...Int(hero.strength))
            enemyHP.takeDamage(hdmg)
            enemyImage.shake()
            UIApplication.battleNotification("You deal \(hdmg) dmg to \(enemy.race)")
            sound.painNoise()
        case "Heal":
            heroHP.heal(15)
            GameDatabase.shared.hero.currentHealth -= 15
            sound.magic()
            UIApplication.battleNotification("You heal for 15 points")
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
            UIApplication.battleNotification("You deal \(value) dmg to \(enemy.race)")
            sound.painNoise()
            
        case .heroAttacksHero:
            UIApplication.battleNotification("Stop hitting yourself for \(value) dmg")

        case .mobAttacksHero:
            enemyImage.nudgeVertical(-70)
            heroHP.alignHpTo(hero)
            GameDatabase.shared.hero.currentHealth -= value
            UIApplication.battleNotification("\(enemy.race) attacks you for \(value) points")
            sound.painNoise()

        case .heroHealsMob:
            UIApplication.battleNotification("Why are you healing the enemy for \(value) dmg")
            enemyHP.alignHpTo(enemy)


        case .mobHealsHero:
            heroHP.heal(value)
            GameDatabase.shared.hero.currentHealth -= value
            sound.magic()
            UIApplication.battleNotification("\(enemy.race) heals you for 15 points")
            heroHP.alignHpTo(hero)


        case .heroHealsHero:
            heroHP.heal(value)
            GameDatabase.shared.hero.currentHealth -= value
            sound.magic()
            heroHP.alignHpTo(hero)
            UIApplication.battleNotification("You heal for \(value) points")
        case .mobHealMob:
            enemyHP.alignHpTo(enemy)

        case .youDied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                UIApplication.battleNotification("You have died!!")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.dismiss(animated: true, completion: nil)
            })
        case .youWin:
            print ("You won")
            let fanfare: SystemSoundID = 1025
            AudioServicesPlaySystemSound(fanfare)
            gameOver = true
            isPaused = true
            UIApplication.battleNotification("You have defeated \(enemy.name)!!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                UIApplication.battleNotification("You have gained \(value) XP!!")
                GameDatabase.shared.hero.rewardXp(value)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.dismiss(animated: true, completion: nil)
            })
        case .flee:
            SoundController.shared.speak("You ran away like a cow-word!")
            self.dismiss(animated: true, completion: nil)
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


