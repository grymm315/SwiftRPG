//
//  Equipment.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/14/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import Foundation


class Equipment {
    var count: Int = 0
    var level: UInt8?
    var weight: UInt8?
    var bulk: UInt8?
    var value: Int?
    
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
}

class Armor:Equipment {
    
    enum ArmorType {
    case Arm, Head, Chest, Legs, Shoes
    }
    var type: ArmorType?
    var damageResist: Int8?
    var magicResist: Int8?
    var shockResist: Int8?
    var frostResist: Int8?
    var fireResist: Int8?
    var chemicalResist: Int8?

}

class Usable:Equipment {
    
}
