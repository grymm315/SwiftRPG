//
//  BattleController.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 2/25/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

enum CombatEvent {
    case battleStarted
    case turnStart(unit: Character)
    case turnEnd(unit: Character)
    case attack(attacker: Character, defender: Character)
    case damageDealt(attacker: Character, defender: Character, damage: Int)
    case damageTaken(victim: Character, damage: Int)
    case unitDead(unit: Character)
    
}

class BattleController {
    static var shared = BattleController()
    
    var hero:Character?
    var enemy:Character?
    var gameOver:Bool = false
    
    var battleDelegate: BattleViewActions?
    
    private var timeDelay = 2.5
    var heroInitiative = 0
    var enemyInitiative = 1
    
    let counter = 0
    
    func start(_ hero: Character, _ enemy: Character ){
        gameOver = false
        self.hero = hero
        self.enemy = enemy
        determineNextMove()
    }
    
    func stop(){
        gameOver = true
        
    }
    
    func getOptions(){
        let weapon = hero?.getWeapon()
        var options : [String] = []
        switch weapon?.weaponType {
        case .Sword:
            options.append("Stab")
            options.append("Swing")
            options.append("Thrust")
        case .Club:
            options.append("Swing")

        case .Claw:
            options.append("Swipe")

        case .Unarmed:
            options.append("Punch")
            options.append("Kick")

        case .Gun:
            options.append("Shoot")

        case .FireWand:
            options.append("Fireball")
            options.append("Swing")
            options.append("Thrust")

        case .IceWand:
            options.append("Stab")
            options.append("Swing")
            options.append("Thrust")

        case .GreenWand:
            options.append("Stab")
            options.append("Swing")
            options.append("Thrust")

        case nil:
            options.append("Run")
            options.append("Dodge")
            options.append("Roll")

        }
    }
    
    
    func statusReport() {
        print("\(hero?.name ?? "Name not found"): \(heroInitiative) vs \(enemy?.race ?? raceTypes.Demon): \(enemyInitiative)")
    }
    
    func AIMove() {
        if (gameOver){return}
        let dmg = enemy?.attack(enemy: GameDatabase.shared.hero)
        battleDelegate?.battleAction(action: .mobAttacksHero, value: dmg ?? 0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeDelay, execute: {
            self.determineNextMove()
        })
        enemyInitiative += 1
    }
    
    func playerMove() {
        if (gameOver){return}
        let dmg = hero?.attack(enemy: enemy!)
        //battleDelegate?.battleAction(action: .heroAttacksMob, value: dmg ?? 0)
        battleDelegate?.battleAction(action: .playerInput, value: 0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeDelay, execute: {
            self.determineNextMove()
        })
        heroInitiative += 1
    }
    
    func determineEvade() -> Bool {
        
        let chance = Int.random(in: 0..<100)
        return chance <= 50
    }
    
    func determineParry() -> Bool {
        // Does character have something to parry with
        // Successful parry allows a repost
        let chance = Int.random(in: 0..<100)
        return chance <= 50
    }
    
    func determineBlock() -> Bool {
        // does character have something to block with
        let chance = Int.random(in: 0..<100)
        return chance <= 50
    }
    
    func determineDodge() -> Bool {
        // if the character is faster than the enemy dodge chance is increased
        // dodge consumes more stam than evade
        let chance = Int.random(in: 0..<100)
        return chance <= 50
    }
    
    
    
    func determineNextMove() {
        //lose condition
        if (gameOver) {
            print("The Battle is over")
            return
        }
        //win condition
        if (enemy?.currentHealth ?? 0 <= 0) {
            print ("You have defeated \(enemy?.name ?? "enemy")!!")
            gameOver = true
            GameDatabase.shared.hero.rewardXp(100)
            battleDelegate?.battleAction(action: .youWin, value: 100)
            return
        }
        
        if (GameDatabase.shared.hero.currentHealth ?? 0 <= 0) {
            print ("You have died!!")
            gameOver = true
            battleDelegate?.battleAction(action: .youDied, value: 0)
            return
        }
        statusReport()
        if (heroInitiative >= enemyInitiative) {
            AIMove()
        } else {
            playerMove()
        }
    }
    
   
    
}
