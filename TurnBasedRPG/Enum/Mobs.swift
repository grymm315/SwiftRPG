//
//  Mobs.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 7/27/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

enum Monster {
    case Goblin, LoneWolf, ork, dog, rat, possum, troll, ghost, merchant, thief, townGuard, beetle, spider, slime
    var instance: Character {
        switch self {
        case .Goblin:
            let c = Character(strength: 1, perception: 1, endurance: 1, charisma: 0, intelligence: 1, luck: 1, agility: 1)
            c.name = "Goblin Forager"
            c.image = "Goblin"
            return c
        case .LoneWolf:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Lone Wolf"
            c.image = "wolf"
            return c
        case .ork:
            let c = Character(strength: 3, perception: 1, endurance: 2, charisma: 1, intelligence: 1, luck: 1, agility: 1)
            c.name = "Ork"
            c.image = "Gremlin"
            return c
        case .dog:
            let c = Character(strength: 1, perception: 3, endurance: 1, charisma: 1, intelligence: 1, luck: 4, agility: 2)
            c.name = "Stray Dog"
            c.image = "wolf"
            return c
        case .possum:
            let c = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1)
            c.name = "Possum"
            c.image = "possum"
            return c
        case .troll:
            let c = Character(strength: 7, perception: 1, endurance: 7, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Troll"
            c.image = "troll"
            return c
        case .ghost:
            let c = Character(strength: 0, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1)
            c.name = "Ghost"
            c.image = "undead"
            return c
        case .merchant:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Merchant"
            c.image = "Willy"
            return c
        case .thief:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Thief"
            c.image = "thief"
            return c
        case .townGuard:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Town Guard"
            c.image = "merchant"
            return c
            
            //v 1.2.1 Mobs
        case .beetle:
            let c = Character(strength: 3, perception: 1, endurance: 3, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Giant Dungeon Beetle"
            c.image = "beetle"
            c.skills = [Skill.punch, Skill.grapple]
            return c
        case .spider:
            let c = Character(strength: 4, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Venomous Spider"
            c.image = "spider"
            c.skills = [Skill.punch, Skill.grapple]
            return c
        case .slime:
            let c = Character(strength: 3, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Green Slime"
            c.image = "blob"
            c.skills = [Skill.punch, Skill.firstaid]
            return c
        case .rat:
            let c = Character(strength: 2, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Rat"
            c.image = "rat"
            c.skills = [Skill.punch, Skill.run]
            return c
        }
    }
}
