//
//  BattleViewController.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/29/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    lazy var hero:Character = Character()
    lazy var enemy:Character = Character()
    
    
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var enemyName: UILabel!
    @IBOutlet weak var enemyHP: HealthBar!
    @IBOutlet weak var heroHP: HealthBar!
    
    
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
        
        
        
    }
    
    //hero attacks enemy
    @IBAction func attack(_ sender: Any) {
        enemyHP._currentHealth -= 5
        enemyHP.setNeedsDisplay()
        
    }
    
    func check () {
        if (enemyHP._currentHealth < 0) {
            print ("You won")
        }
        
        if (heroHP._currentHealth < 0) {
            print("You perished in combat")
        }
    }
    
}
