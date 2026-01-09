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
    case FireBall, LightningBolt, firstaid, punch, kick, grapple, run, bite, venom, tailswipe, flee
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
        case .bite:
            return Bite()
        case .venom:
            return Venom()
        case .tailswipe:
            return TailSwipe()
        case .flee:
            return MonsterRun()
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
        
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 10)
        } else {
            return (BattleActions.mobAttacksHero, 10)
        }
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
        
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 10)
        } else {
            return (BattleActions.mobAttacksHero, 10)
        }
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
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 3)
        } else {
            return (BattleActions.mobAttacksHero, 3)
        }
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
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 4)
        } else {
            return (BattleActions.mobAttacksHero, 4)
        }
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
        let manaCost = energyCost
        
        if owner.currentMana < manaCost {
            print("Not enough mana!")
            return (BattleActions.playerInput, 0)
        }
        attacker.currentMana -= energyCost
        defender.takeDamage(energyCost)
        
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, energyCost)
        } else {
            return (BattleActions.mobAttacksHero, energyCost)
        }
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
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroHealsHero, 10)
        } else {
            return (BattleActions.mobHealMob, 10)
        }
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
            if (Bool.random()){
                return (BattleActions.flee, 2)
            } else {
                return (BattleActions.flee, 0)
            }
        }
    }
}

final class MonsterRun: ActiveSkill {
    var name: String = "MonsterRun"
    var description: String = "The monster runs away!!"
    var isPassive: Bool = false
    var energyCost: Int = 5
    var manaCost: Int = 0
    
    func handle(event: CombatEvent, owner: Character) -> (action: BattleActions, value: Int) {
        guard case .attack(_, let defender) = event else { return (BattleActions.playerInput, 0) }
        _ = 5
        
        if owner.agility > defender.agility {
            print("The monster gets away!!")
            return (BattleActions.flee, 3)
        } else {
            print("The monster did not get away...")
            return (BattleActions.flee, 4)
           
        }
    }
}

final class Bite: ActiveSkill {
    var energyCost: Int = 3
    var manaCost: Int = 0
    var name: String = "Bite"
    var description: String = "A mouth full of teeth meet a mouthful of flesh!"
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
        
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 3)
        } else {
            return (BattleActions.mobAttacksHero, 3)
        }
    }
}

final class TailSwipe: ActiveSkill {
    var energyCost: Int = 3
    var manaCost: Int = 0
    var name: String = "TailSwipe"
    var description: String = "A mouth full of teeth meet a mouthful of flesh!"
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
        
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 3)
        } else {
            return (BattleActions.mobAttacksHero, 3)
        }
    }
}

final class Venom: ActiveSkill {
    var energyCost: Int = 3
    var manaCost: Int = 0
    var name: String = "Venom"
    var description: String = "Venom is when it bites you, poison is when you bite it"
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
        
        if attacker.name == GameDatabase.shared.hero.name {
            return (BattleActions.heroAttacksMob, 3)
        } else {
            return (BattleActions.mobAttacksHero, 3)
        }
    }
}
