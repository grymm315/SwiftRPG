//
//  BattleController.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 2/25/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

class BattleController {
    static var shared = BattleController()
    
    var hero:Character?
    var enemy:Character?
    var gameOver:Bool = false
    
    var battleDelegate: BattleViewActions?
    
    private var timeDelay = 0.5
    var heroInitiative = 0
    var enemyInitiative = 1
    
    let counter = 0
    
    func start(_ hero: Character, _ enemy: Character ){
        gameOver = false
        self.hero = hero
        self.enemy = enemy
        determineNextMove()
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
        
        if (hero?.currentHealth ?? 0 <= 0) {
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
    
    func statusReport() {
        print("\(hero?.name): \(heroInitiative) vs \(enemy?.race): \(enemyInitiative)")
    }
    
    func AIMove() {
        let dmg = enemy?.attack(enemy: hero!)
        battleDelegate?.battleAction(action: .mobAttacksHero, value: dmg ?? 0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeDelay, execute: {
            self.determineNextMove()
        })
        enemyInitiative += 1
    }
    
    func playerMove() {
        let dmg = hero?.attack(enemy: enemy!)
        battleDelegate?.battleAction(action: .heroAttacksMob, value: dmg ?? 0)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeDelay, execute: {
            self.determineNextMove()
        })
        heroInitiative += 1
    }
}
