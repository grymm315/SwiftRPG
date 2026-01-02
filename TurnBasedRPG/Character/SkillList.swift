//
//  ItemList.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 9/2/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

protocol ActiveSkill{
    var name: String { get }
    var energyCost: Int { get }
    var manaCost: Int { get }
    var description: String { get }
    var isPassive: Bool { get }
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int)
 
}

enum Skill: Codable{
    case FireBall, LightningBolt, firstaid, punch, kick, grapple, run
    var cast: ActiveSkill {
        switch self {
        case .FireBall:
            return Fireball()
        case .LightningBolt:
            return LightingBolt()
        case .firstaid:
            return FirstAid()
        case .punch:
            return Punch()
        case .kick:
            return Kick()
        case .grapple:
            return Grapple()
        case .run:
            return Run()
        }
    }
}

final class Fireball: ActiveSkill {
    var name: String = "Fireball"
    var description: String = "A fiery orb that explodes in damage"
    var isPassive: Bool = false
    var energyCost: Int = 0
    var manaCost: Int = 3
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(let attacker, let defender) = event else { return (BattleActions.playerInput, 0) }
    
        if (owner.currentMana < manaCost || owner.currentEnergy < energyCost) {
            print("Not enough mana/energy to cast this!")
            return (BattleActions.playerInput, 0)
        }
        attacker.currentMana -= manaCost
        defender.currentHealth -= 10
        return (BattleActions.heroAttacksMob, 10)
    }
}

final class LightingBolt: ActiveSkill {
    var energyCost: Int = 5
    
    var manaCost: Int = 7
    
    var name: String = "Bolt"
    var description: String = "A lightning bolt that strikes the enemy"
    var isPassive: Bool = false
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(let attacker, let defender) = event else { return (BattleActions.playerInput, 0) }
    
        
        if (owner.currentMana < manaCost || owner.currentEnergy < energyCost) {
            print("Not enough mana/energy to cast this!")
            return (BattleActions.playerInput, 0)
        }
        attacker.currentMana -= manaCost
        defender.currentHealth -= 10
        return (BattleActions.heroAttacksMob, 10)
    }
}

final class Punch: ActiveSkill {
    var energyCost: Int = 3
    var manaCost: Int = 0
    var name: String = "Punch"
    var description: String = "Ball your hand into a fist and deliver a punch"
    var isPassive: Bool = false
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(let attacker, let defender) = event else { return (BattleActions.playerInput, 0) }
        let manaCost = 0
        
        if (owner.currentMana < manaCost || owner.currentEnergy < energyCost) {
            print("Not enough mana/energy to cast this!")
            return (BattleActions.playerInput, 0)
        }
        attacker.currentEnergy -= manaCost
        defender.currentHealth -= 3
        return (BattleActions.heroAttacksMob, 3)
    }
    
    func use(owner: Character, victim: Character) {
        
    }
}

final class Kick: ActiveSkill {
    
    var name: String = "Kick"
    var description: String = "Introduce your foot to the enemy"
    var isPassive: Bool = false
    var energyCost: Int = 4
    var manaCost: Int = 0

    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(let attacker, let defender) = event else { return (BattleActions.playerInput, 0) }
                
        if owner.currentMana < energyCost {
            print("Not enough mana!")
            return (BattleActions.playerInput, 0)
        }
        attacker.currentEnergy -= energyCost
        defender.currentHealth -= 4
        return (BattleActions.heroAttacksMob, 4)
    }
}

final class Grapple: ActiveSkill {
        
    var name: String = "Grapple"
    var description: String = "Attempt to grab the enemy"
    var isPassive: Bool = false
    var energyCost: Int = 5
    var manaCost: Int = 0

    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(let attacker, let defender) = event else { return (BattleActions.playerInput, 0) }
        let manaCost = 10
        
        if owner.currentMana < manaCost {
            print("Not enough mana!")
            return (BattleActions.playerInput, 0)
        }
        attacker.currentMana -= manaCost
        defender.currentHealth -= 10
        return (BattleActions.heroAttacksMob, 10)
    }
}

final class FirstAid: ActiveSkill {
    var name: String = "First Aid"
    var description: String = "Heal yourself for a small ammount"
    var isPassive: Bool = false
    var energyCost: Int = 5
    var manaCost: Int = 0
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(let attacker, _) = event else { return (BattleActions.playerInput, 0) }
        let manaCost = 5
        
        if owner.currentMana < manaCost {
            print("Not enough mana!")
            return (BattleActions.playerInput, 0)
        }
        // The attacker is the caster in need of healing
        attacker.currentMana -= manaCost
        attacker.heal(10)
        return (BattleActions.heroHealsHero, 10)
    }
    
}

final class Run: ActiveSkill {
    var name: String = "Run"
    var description: String = "Move your feet swiftly away from the enemy"
    var isPassive: Bool = false
    var energyCost: Int = 5
    var manaCost: Int = 0
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(_, let defender) = event else { return (BattleActions.playerInput, 0) }
        _ = 5
        
        if owner.agility > defender.agility {
            print("You get away!!")
            return (BattleActions.flee, 0)
        } else {
            print("You did not get away...")
            return (BattleActions.flee, 2)
           
        }
    }
}


