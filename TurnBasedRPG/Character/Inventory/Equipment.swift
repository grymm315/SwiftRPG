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
