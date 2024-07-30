//
//  Mobs.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 7/27/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

enum Monster {
    case Goblin, LoneWolf, ork, dog, rat, possum, troll, ghost, merchant, thief, townGuard
    var instance: Character {
        switch self {
        case .Goblin:
            let c = Character(strength: 1, perception: 1, endurance: 1, charisma: 0, intelligence: 1, luck: 1, agility: 1)
            c.name = "Goblin Forager"
            return c
        case .LoneWolf:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Lone Wolf"
            return c
        case .ork:
            let c = Character(strength: 3, perception: 1, endurance: 2, charisma: 1, intelligence: 1, luck: 1, agility: 1)
            c.name = "Ork"
            return c
        case .dog:
            let c = Character(strength: 1, perception: 3, endurance: 1, charisma: 1, intelligence: 1, luck: 4, agility: 2)
            c.name = "Stray Dog"
            return c
        case .rat:
            let c = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Rat"
            return c
        case .possum:
            let c = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1)
            c.name = "Possum"
            return c
        case .troll:
            let c = Character(strength: 7, perception: 1, endurance: 7, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Troll"
            return c
        case .ghost:
            let c = Character(strength: 0, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1)
            c.name = "Ghost"
            return c
        case .merchant:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Merchant"
            return c
        case .thief:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Thief"
            return c
        case .townGuard:
            let c = Character(strength: 2, perception: 2, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 2)
            c.name = "Town Guard"
            return c
        }
    }
}
