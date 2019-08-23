//
//  Magic.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/1/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

class Magic {
    
    func castDirectDamage(caster:Character, target:Character, dmg:Int){
        target.currentHealth -= (dmg)
    }
    
    func castFireDamage(caster:Character, target:Character, dmg:Int){
        target.currentHealth -= (dmg)
    }
    
    func castIceDamage(caster:Character, target:Character, dmg:Int){
        target.currentHealth -= (dmg)
    }
    
    func castThunderDamage(caster:Character, target:Character, dmg:Int){
        target.currentHealth -= (dmg)
    }
    
    func castPierceDamage(caster:Character, target:Character, dmg:Int){
        target.currentHealth -= (dmg)
    }

    
    
    
    
    
}
