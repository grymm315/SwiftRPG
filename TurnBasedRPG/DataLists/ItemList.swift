//
//  ItemList.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 9/2/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

enum ItemRack {
    case healthPotion, manaPotion, mushroom, bisquit, soup, buzzPop, xpPotion
    var instance: Consumable {
        switch self {
        case .healthPotion:
            return Consumable("Health Potion", description: "This will restore 20HP", effect: Effect(.heal, by: 20))
        case .manaPotion:
            return Consumable("Mana Potion", description: "This will restore 20MP", effect: Effect(.gainMana, by: 20))
        case .mushroom:
            return Consumable("Mushroom", description: "A moldy mushroom. You eat this for energy", effect: Effect(.gainEnergy, by: 20))
        case .bisquit:
            return Consumable("Bisquit", description: "This is bread. You eat it.", effect: Effect(.heal, by: 20))
        case .soup:
            return Consumable("Bone Soup", description: "What a satisfying flavor", effect: Effect(.heal, by: 20))
        case .buzzPop:
            return Consumable("Buzz Pop", description: "This will get you full of energy", effect: Effect(.gainEnergy, by: 100))
        case .xpPotion:
            return Consumable("XP Potion", description: "Holy Shit! This is a cheat item", effect: Effect(.gainExperience, by: 750))
        }
    }
}

/** Use the Weapon Rack to hold an enum of all the potential weapons we might have for easy retrieval */
enum WeaponRack {
    case bareFist, club, brokenBottle, axe
    var instance: Weapon {
        switch self {
        case .bareFist:
            return Weapon(name: "Bare Fist", description: "Hands that slap you", weaponType: .Unarmed, dmg: 1, speed: 1, imageNamed: "fist")
        case .club:
            return Weapon(name: "Club", description: "Solid wood. Hard. Veiny?", weaponType: .Club, dmg: 2, speed: 1,imageNamed: "club")
        case .brokenBottle:
            return Weapon(name: "Broken Bottle", description: "RPG Classic weapon of choice", weaponType: .Sword, dmg: 2, speed: 1, imageNamed: "brokenbottle")
        case .axe:
            return Weapon(name: "Axe", description: "For chopping down trees or people", weaponType: .Sword, dmg: 2, speed: 1, imageNamed: "axe1")
        }
    }
}

enum ArmorRack {
    case jeans, shirt, crown, chainChest, plateChest, leatherPants
    
    var instance:Armor {
        switch self {
        case .jeans:
            return Armor(name: "Jeans", description: "Denim Jeans", type: .Legs, image: "Jeans", defense: 1)
        case .shirt:
            return Armor(name: "Shirt", description: "Just a normal shirt that doesn't provide much protection", type: .Chest, image: "Shirt", defense: 1)
        case .crown:
            return Armor(name: "Saphire Crown", description: "A jeweled saphire crown that seems to glow", type: .Head, image: "Jeans", defense: 1)
        case .chainChest:
            return Armor(name: "Chain Mail", description: "Lots of tiny metal rings woven together to forma  shirt", type: .Chest, image: "chainChest", defense: 2)
        case .plateChest:
            return Armor(name: "Platemail", description: "A turtle would be jealous", type: .Chest, image: "PlateChest", defense: 3)
        case .leatherPants:
            return Armor(name: "Leather Pants", description: "For when you start dipping your toes into BDSM", type: .Legs, image: "LeatherPants", defense: 2)
        }
    }
}
