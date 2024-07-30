//
//  Equipment.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/14/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import Foundation


class Equipment: Codable {
    enum codingKey: CodingKey {
        case name, description, level, weight, bulk, value, type, imageNamed
    }
 
    enum EquipmentTypes: String, Decodable {
        case Armor, Weapon, Consumable, Junk
    }
    var level: UInt8?
    var weight: UInt8?
    var bulk: UInt8?
    var value: Int?
    var imageNamed: String?
    
    var name: String = ""
    var type: EquipmentTypes = .Junk
    var description: String?
    
    init(name: String, description:String) {
        self.name = name
        self.description = description
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKey.self)
        try container.encode(level, forKey: .level)
        try container.encode(weight, forKey: .weight)
        try container.encode(bulk, forKey: .bulk)
        try container.encode(value, forKey: .value)
        try container.encode(imageNamed, forKey: .imageNamed)
        try container.encode(name, forKey: .name)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(description, forKey: .description)
    }
    
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: codingKey.self)
            
            self.level = try container.decode(UInt8?.self, forKey: .level)
            self.weight = try container.decode(UInt8?.self, forKey: .weight)
            self.bulk = try container.decode(UInt8?.self, forKey: .bulk)
            self.value = try container.decode(Int?.self, forKey: .value)
            self.type = try container.decode(EquipmentTypes.self, forKey: .type)
            self.name = try container.decode(String.self, forKey: .name)
            self.imageNamed = try container.decode(String?.self, forKey: .imageNamed)
            self.description = try container.decode(String?.self, forKey: .description)
//            var equipmentArrayForType = try container.nestedUnkeyedContainer(forKey: EquipmentKey.equipments)
//            var equipments = [Equipment]()
//
//            var equipmentArray = equipmentArrayForType
//            while(!equipmentArrayForType.isAtEnd){
//
//            }
        }
}

//class Equipment: BasicEquipment{
//    override init(name: String, description:String) {
//        super.init(name: name, description: description)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.s
//        try super.init(from: decoder)
//    }
//}


class Weapon: Equipment {
    
    enum WeaponType: Codable {
        case Sword, Club, Claw, Unarmed, Gun, FireWand, IceWand, GreenWand
    }
    
    enum codingKeys: CodingKey {
        case weaponType, damage, speed
    }
    var weaponType: WeaponType?
    var damage: Damage?
    var speed: UInt8?
    
    init(name: String, description:String, weaponType: WeaponType, dmg:UInt8, speed: UInt8, imageNamed:String = "fist") {
        super.init(name: name, description: description)
        self.weaponType = weaponType
        self.imageNamed = imageNamed
        let damage = Damage()
        damage.physical = Int8(dmg)
        self.damage = damage
        self.speed = speed
        self.type = .Weapon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.weaponType = try container.decode(WeaponType.self, forKey: .weaponType)
        self.damage = try container.decode(Damage.self, forKey: .damage)
        self.speed = try container.decode(UInt8.self, forKey: .speed)

        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        try container.encode(damage, forKey: .damage)
        try container.encode(speed, forKey: .speed)
        try container.encode(weaponType, forKey: .weaponType)

        try super.encode(to: encoder)
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
            return Armor(name: "Shirt", description: "Just a normal shirt that doesn't provide much protection", type: .Chest, image: "chest", defense: 1)
        case .crown:
            return Armor(name: "Saphire Crown", description: "A jeweled saphire crown that seems to glow", type: .Head, image: "Jeans", defense: 1)
        case .chainChest:
            return Armor(name: "Chainmail", description: "Lots of tiny metal rings woven together to forma  shirt", type: .Chest, image: "chainChest", defense: 2)
        case .plateChest:
            return Armor(name: "Platemail", description: "A turtle would be jealous", type: .Chest, image: "PlateChest", defense: 3)
        case .leatherPants:
            return Armor(name: "Leather Pants", description: "For when you start dipping your toes into BDSM", type: .Legs, image: "LeatherPants", defense: 2)
        }
    }
}

class Damage: Codable {
    var physical: Int8 = 0
    var magic: Int8 = 0
    var shock: Int8 = 0
    var frost: Int8 = 0
    var fire: Int8 = 0
    var chemical: Int8 = 0
}

enum ArmorType: Codable  {case Arm, Head, Chest, Legs, Shoes}

class Armor:Equipment {
    enum ArmorCodingKeys: String, CodingKey, CaseIterable {
            case damage
            case location
        }
    
    var equippedLocation: ArmorType
    var damageResist: Damage?
   
    init(name: String, description:String, type:ArmorType, image:String = "", defense:Int8) {
        self.equippedLocation = type
        let resist = Damage()
        resist.physical = defense
        self.damageResist = resist
        super.init(name: name, description: description)
        self.imageNamed = image
        self.type = .Armor

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArmorCodingKeys.self)
        self.equippedLocation = try container.decode(ArmorType.self, forKey: .location)
        self.damageResist = try container.decode(Damage.self, forKey: .damage)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ArmorCodingKeys.self)
        try container.encode(damageResist, forKey: .damage)
        try container.encode(equippedLocation, forKey: .location)
        try super.encode(to: encoder)
        }
    
}

class Consumable:Equipment {
    enum CodingKeys: String, CodingKey, CaseIterable {
            case stacksBy, effect
        }
    var stack: Int = 10
    var effect: Effect?
    
    init(_ text:String, description: String, effect: Effect?){
        self.effect = effect
        super.init(name: text, description: description)
        self.type = .Consumable

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stack = try container.decode(Int.self, forKey: .stacksBy)
        self.effect = try container.decode(Effect?.self, forKey: .effect)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stack, forKey: .stacksBy)
        try container.encode(effect, forKey: .effect)
        try super.encode(to: encoder)
        }
    
}

enum EffectType: Codable {
    case heal, damage, gainMana, loseMana, gainExperience, poison, zombie, death, illuminate, gainEnergy, loseEnergy
}

class Effect: Codable {
    var effectType: EffectType
    var value: Int?
    var turns: Int?
    var target: Character?
    
    init (_ effect: EffectType, by value: Int? = 0, for turns: Int? = 0) {
        effectType = effect
        self.value = value
        self.turns = turns
    }
    
    func action() {
        switch effectType {
        case .heal:
            print("Heal")
            GameDatabase.shared.hero.heal(value ?? 0)
        case .damage:
            print("damage")
            GameDatabase.shared.hero.takeDamage(value ?? 0)
        case .gainMana:
            print("gainMana")
            GameDatabase.shared.hero.currentMana += value ?? 0
        case .loseMana:
            print("loseMana")
            GameDatabase.shared.hero.currentMana -= value  ?? 0
        case .gainExperience:
            print("gainExperience")
            GameDatabase.shared.hero.rewardXp(value ?? 0)
        case .poison:
            print("poison")
        case .zombie:
            print("zombie")
        case .death:
            print("death")
        case .illuminate:
            print("illuminate")
        case .gainEnergy:
            GameDatabase.shared.hero.adjustEnergyLevel(value ?? 0)
        case .loseEnergy:
            GameDatabase.shared.hero.adjustEnergyLevel(-(value ?? 0))
        }
    }
}

enum ItemRack {
    case healthPotion, manaPotion, mushroom, bisquit, soup, buzzPop, xpPotion
    var instance: Consumable {
        switch self {
        case .healthPotion:
            return Consumable("Health Potion", description: "This will restore 20HP", effect: Effect(.heal, by: 20))
        case .manaPotion:
            return Consumable("Mana Potion", description: "This will restore 20HP", effect: Effect(.gainMana, by: 20))
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
