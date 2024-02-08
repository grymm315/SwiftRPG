//
//  Equipment.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/14/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import Foundation


class Equipment {
    var count: Int = 1
    var level: UInt8?
    var weight: UInt8?
    var bulk: UInt8?
    var value: Int?
    var imageNamed: String?
    
    var name: String = ""
    var description: String?
    
    init(name: String, description:String) {
        self.name = name
        self.description = description
    }
}

class Weapon: Equipment {
    enum WeaponType {
        case Sword, Club, Claw, Unarmed, Gun, FireWand, IceWand, GreenWand
    }
    
    var type: WeaponType?
    var damage: UInt8?
    var speed: UInt8?
    
    init(name: String, description:String, weaponType: WeaponType, dmg:UInt8, speed: UInt8) {
        super.init(name: name, description: description)
        
    }
    
}

/** Use the Weapon Rack to hold an enum of all the potential weapons we might have for easy retrieval */
enum WeaponRack {
    case bareFist, dagger, sword, axe
    var instance: Weapon {
        switch self {
        case .bareFist:
            return Weapon(name: "Bare Fist", description: "Hands that slap you", weaponType: .Unarmed, dmg: 1, speed: 1)
        case .dagger:
            return Weapon(name: "Dagger", description: "This could also be a letter opener", weaponType: .Sword, dmg: 1, speed: 1)
        case .sword:
            return Weapon(name: "Sword", description: "RPG Classic weapon of choice", weaponType: .Sword, dmg: 2, speed: 1)
        case .axe:
            return Weapon(name: "Axe", description: "For chopping down trees or people", weaponType: .Sword, dmg: 2, speed: 1)
        }
    }
}

enum ArmorRack {
    case jeans, shirt, crown, chainChest, plateChest, leatherPants
    
    var instance:Armor {
        switch self {
        case .jeans:
            return Armor(name: "Jeans", description: "Denim Jeans", type: .Legs)
        case .shirt:
            return Armor(name: "Shirt", description: "Just a normal shirt that doesn't provide much protection", type: .Chest)
        case .crown:
            return Armor(name: "Saphire Crown", description: "A jeweled saphire crown that seems to glow", type: .Head)
        case .chainChest:
            return Armor(name: "Chainmail", description: "Lots of tiny metal rings woven together to forma  shirt", type: .Chest)
        case .plateChest:
            return Armor(name: "Platemail", description: "A turtle would be jealous", type: .Chest)
        case .leatherPants:
            return Armor(name: "Leather Pants", description: "For when you start dipping your toes into BDSM", type: .Legs)
        }
    }
}
class Armor:Equipment {
    
    enum ArmorType {
    case Arm, Head, Chest, Legs, Shoes
    }
    var type: ArmorType
    var damageResist: Int8 = 0
    var magicResist: Int8 = 0
    var shockResist: Int8 = 0
    var frostResist: Int8 = 0
    var fireResist: Int8 = 0
    var chemicalResist: Int8 = 0
    
    init(name: String, description:String, type:ArmorType) {
        self.type = type
        super.init(name: name, description: description)
    }

}

class Consumable:Equipment {
    var stack: Int = 10

    public var action:() -> Void
    
    init(_ text:String, description: String, completionHandler:@escaping () -> Void){
        action = completionHandler
        super.init(name: text, description: description)
    }
    
}

enum ItemRack {
    case healthPotion, manaPotion, mushroom, bisquit, soup, buzzPop, xpPotion
    
    
    var instance: Consumable {
        switch self {
        case .healthPotion:
            return Consumable("Health Potion", description: "This will restore 20HP", completionHandler: {
                GameDatabase.shared.hero.currentHealth += 20
            })
        case .manaPotion:
            return Consumable("Mana Potion", description: "This will restore 20HP", completionHandler: {
                GameDatabase.shared.hero.currentMana += 20
            })
        case .mushroom:
            return Consumable("Mushroom", description: "A moldy mushroom. You eat this for energy", completionHandler: {
                GameDatabase.shared.hero.currentEnergy += 5
            })
        case .bisquit:
            return Consumable("Bisquit", description: "This is bread. You eat it.", completionHandler: {
                GameDatabase.shared.hero.currentHealth += 10
            })
        case .soup:
            return Consumable("Bone Soup", description: "What a satisfying flavor", completionHandler: {
                GameDatabase.shared.hero.currentHealth += 20
            })
        case .buzzPop:
            return Consumable("Buzz Pop", description: "This will get you full of energy", completionHandler: {
                GameDatabase.shared.hero.currentEnergy += 100
            })
        case .xpPotion:
            return Consumable("XP Potion", description: "Holy Shit! This is a cheat item", completionHandler: {
                GameDatabase.shared.hero.rewardXp(1000)
            })
        }
    }
    
}
