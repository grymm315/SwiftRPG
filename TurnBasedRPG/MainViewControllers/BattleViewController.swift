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
    func displayLog(_ text: String, color: UIColor)
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
    @IBOutlet weak var energyBar: HealthBar!
    @IBOutlet weak var manaBar: HealthBar!
    
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
        energyBar.alignHpTo(enemy)
        manaBar.alignHpTo(enemy)

        menu.delegate = self
//        self.view.addSubview(menu.view)
        let heroImage = UIImageView(frame: heroView.bounds)
        heroImage.image = UIImage(named: GameDatabase.shared.hero.image ?? "goblin")
        heroImage.contentMode = .scaleToFill
        
        heroView.addSubview(heroImage)
        
        if let tImage =  UIImage.init(named: GameDatabase.shared.currentRoom.title){
            topEnemyView.setBackgroundImage(tImage)
//            roomImage.image = tImage
        }
        
        heroHP.alignHpTo(hero)
        heroName.text = hero.name
        let attkMsg = "You are attacked by a \(enemy.name)."
        SoundController.shared.speak(attkMsg)
        displayLog(attkMsg, color: UIColor.white)
        BattleController.shared.battleDelegate = self
        BattleController.shared.start(hero, enemy)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enemyImage.image = UIImage(named: enemy.image ?? "goblin")
        enemyName.text = "\(enemy.name)"
    }
    
    func setBackgroundImage(){
        
    }
       
    func alignHealthBars(){
       
        heroHP._maxHealth = GameDatabase.shared.hero.maxHealth
        heroHP._currentHealth = GameDatabase.shared.hero.currentHealth
        heroHP.takeDamage(0)
            
        manaBar._maxHealth = GameDatabase.shared.hero.maxMana
        manaBar._currentHealth = GameDatabase.shared.hero.currentMana
        manaBar.takeDamage(0)
            
        energyBar._maxHealth = GameDatabase.shared.hero.maxEnergy
        energyBar._currentHealth = GameDatabase.shared.hero.currentEnergy
        energyBar.takeDamage(0)
        
    }

    func getBattleOptions() -> [ActiveSkill] {
        //Lets make a function to do this logic in the character- pull direct from character class
        var skills: [ActiveSkill] = []
        
        for each in GameDatabase.shared.hero.skills {
            skills.append(each.cast)
        }
        
        return skills
    }
    
    func chose(action: any ActiveSkill) {
        let viewActions = action.handle(event: .attack(attacker: hero, defender: enemy), owner: hero)
        battleAction(action: viewActions.action, value: viewActions.value)
    }
    
    func monsterMoves(action: any ActiveSkill) {
        let viewActions = action.handle(event: .attack(attacker: enemy, defender: hero), owner: hero)
        battleAction(action: viewActions.action, value: viewActions.value)
    }
    
    func getBattleChoices() -> [String] {
        return ["Attack", "Heal", "Item", "Escape"]
    }
    func showBattleMenu() {
        menu.menuItems = getBattleOptions()
        self.view.addSubview(menu.view)
    }
    
    func battleAction(action: BattleActions, value: Int) {
        switch action {
        case .heroAttacksMob:
            enemyHP.alignHpTo(enemy)
            alignHealthBars()
            enemyImage.shake()
            displayLog("You deal \(value) damage to \(enemy.name)", color: UIColor.white)
            sound.painNoise()
            
        case .heroAttacksHero:
            displayLog("Stop hitting yourself for \(value) dmg", color: UIColor.red)
            
        case .mobAttacksHero:
            enemyImage.nudgeVertical(-70)
            GameDatabase.shared.hero.currentHealth -= value
            heroHP.alignHpTo(GameDatabase.shared.hero)
            alignHealthBars()
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
            alignHealthBars()

        case .heroHealsHero:
            heroHP.heal(value)
            sound.magic()
            heroHP.alignHpTo(hero)
            displayLog("You heal for \(value) points", color: UIColor.green)
            alignHealthBars()

        case .mobHealMob:
            enemyHP.alignHpTo(enemy)

        case .youDied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.displayLog("You have died!!", color: UIColor.red)

                UIApplication.battleNotification("You have died!!")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
//                GameDatabase.shared.hero.heal(100)
                GameDatabase.shared.hero.image = "undead"
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
            if (value == 0){
                displayLog("They who flee and run away live to fight another day", color: UIColor.red)
                UIApplication.displayLog("They who flee and run away live to fight another day")
                SoundController.shared.speak("They who flee and run away live to fight another day")
                self.dismiss(animated: true, completion: nil)
            } else {
                displayLog("You try to flee but the \(enemy.name) won't let you")
            }
        case .playerInput:
            displayLog("*", color: UIColor.yellow)
            showBattleMenu()
        }
    }
    
    override func viewDidLayoutSubviews() {
        topEnemyView.frame = UIScreen.main.getUpperFrame(ratio: 0.5)
        lowerConsoleView.frame = UIScreen.main.getLowerFrame(ratio: 0.5)
        
        lowerConsoleView.layer.masksToBounds = false
        lowerConsoleView.layer.shadowOffset = CGSize(width: -2, height: -8)
        lowerConsoleView.layer.shadowRadius = 5
        lowerConsoleView.layer.shadowColor = UIColor.black.cgColor
        lowerConsoleView.layer.shadowOpacity = 1
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
}


