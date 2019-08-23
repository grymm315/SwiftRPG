//
//  BattleViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/29/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    var hero:Character = Character()
    var enemy:Character = Character()
    
    
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var enemyName: UILabel!
    @IBOutlet weak var enemyHP: HealthBar!
    @IBOutlet weak var heroHP: HealthBar!
    
    @IBOutlet weak var attkButton: UIButtonGUI!
    var heroPOS = 0
    var enemyPOS = 0
    
    
    let counter = 0
    
    
    
    override func viewDidLoad() {
        enemy.race = .goblin
        enemyHP._maxHealth = enemy.maxHealth
        enemyHP._currentHealth = enemy.currentHealth
        enemyName.text = enemy.race.rawValue
        
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
            attkButton.isHidden = false
        }
    }
    
    func AIMove(){
        heroHP._currentHealth -= Int.random(in: 1...10)
        heroHP.setNeedsDisplay()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
            self.tick()
        })
    }
    
    //hero attacks enemy
    @IBAction func attack(_ sender: Any) {
        attkButton.isHidden = true
        
        
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
