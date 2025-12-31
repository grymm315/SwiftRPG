//
//  Character.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

class Character: Codable  {
    
    enum characterKeys: String, CodingKey, CaseIterable {
            case name, strength, perception, endurance, charisma, intelligence, luck,
        agility, gold, level, experience, race, profession, sex, inventory, headEquipmentSlot, chestEquipmentSlot, legsEquipmentSlot, equippedSlot, hp, mana, energy, image
        }
    
    var maxHealth: Int {return Int((stats["endurance"] ?? 1) * 10)}
    lazy var currentHealth: Int = maxHealth
    
    var maxMana: Int {return Int((stats["intelligence"] ?? 1) * 10)}
    lazy var currentMana: Int = maxMana
    var maxEnergy: Int {return Int(80 + (stats["endurance"] ?? 1) * 10)}
    lazy var currentEnergy: Int = maxEnergy
    
    
    // Is this too Fallout?
    var strength: UInt8
    var perception: UInt8
    var endurance: UInt8
    var charisma:UInt8
    var intelligence:UInt8
    var luck:UInt8
    var agility:UInt8
    var gold: Int = 0
    
    //asleep
    //confused
    //enraged
    //
    
    var name: String
    var skills: [Skill] = [Run()]
    private var level = 0
    private var experience = 0
    var race:raceTypes = .human
    var profession:classType = .warrior
    var sex:sexType = .male
    var image:String?
    
    private var inventory: [Equipment] = []
    
    private var headEquipmentSlot: Armor?
    private var chestEquipmentSlot: Armor?
    private var legsEquipmentSlot: Armor?
    private var equippedSlot: Weapon?
    
    func getInventory() -> [Equipment] { return inventory}
    func getHead() -> Armor? { return headEquipmentSlot}
    func getChest() -> Armor? { return chestEquipmentSlot}
    func getLegs() -> Armor? { return legsEquipmentSlot}
    func getWeapon() -> Weapon? { return equippedSlot}
    
    lazy var stats: [String : UInt8] = [
        "strength" : strength,
        "perception" : perception,
        "endurance" : endurance,
        "charisma" : charisma,
        "intelligence" : intelligence,
        "luck" : luck,
        "agility" : agility,
    ]
    
    internal init(strength: UInt8, perception: UInt8, endurance: UInt8, charisma: UInt8, intelligence: UInt8, luck: UInt8, agility: UInt8) {
        self.strength = strength
        self.perception = perception
        self.endurance = endurance
        self.charisma = charisma
        self.intelligence = intelligence
        self.luck = luck
        self.agility = agility
        name = "Our Hero"
    }
    
    required init(from decoder: Decoder) throws {
        enum equipmentKeys: CodingKey {
            case type
        }
        
        enum equipmentTypes: String, CodingKey {
            case chest, legs, equiped, consumable, junk
        }
        let container = try decoder.container(keyedBy: characterKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.strength = try container.decode(UInt8.self, forKey: .strength)
        self.perception = try container.decode(UInt8.self, forKey: .perception)
        self.endurance = try container.decode(UInt8.self, forKey: .endurance)
        self.charisma = try container.decode(UInt8.self, forKey: .charisma)
        self.intelligence = try container.decode(UInt8.self, forKey: .intelligence)
        self.luck = try container.decode(UInt8.self, forKey: .luck)
        self.agility = try container.decode(UInt8.self, forKey: .agility)
        self.gold = try container.decode(Int.self, forKey: .gold)
        self.level = try container.decode(Int.self, forKey: .level)
        self.experience = try container.decode(Int.self, forKey: .experience)
        self.profession = try container.decode(classType.self, forKey: .profession)
        self.race = try container.decode(raceTypes.self, forKey: .race)
        self.sex = try container.decode(sexType.self, forKey: .sex)
        self.headEquipmentSlot = try container.decode(Armor?.self, forKey: .headEquipmentSlot)
        self.chestEquipmentSlot = try container.decode(Armor?.self, forKey: .chestEquipmentSlot)
        self.legsEquipmentSlot = try container.decode(Armor?.self, forKey: .legsEquipmentSlot)
        self.equippedSlot = try container.decode(Weapon?.self, forKey: .equippedSlot)
        self.currentHealth = try container.decode(Int.self, forKey: .hp)
        self.currentMana = try container.decode(Int.self, forKey: .mana)
        self.currentEnergy = try container.decode(Int.self, forKey: .energy)
        self.image = try container.decode(String.self, forKey: .image)
        var equipmentArrayForType = try container.nestedUnkeyedContainer(forKey: .inventory)
        var myInventory = [Equipment]()
        var equipArray = equipmentArrayForType

        while (!equipmentArrayForType.isAtEnd){
            let equipment = try equipmentArrayForType.nestedContainer(keyedBy: equipmentKeys.self)
            let type = try equipment.decode(Equipment.EquipmentTypes.self, forKey: equipmentKeys.type)
            print("Type: \(type)")
            switch type {
            case .Armor:
                myInventory.append(try equipArray.decode(Armor.self))
            case .Weapon:
                myInventory.append(try equipArray.decode(Weapon.self))
            case .Consumable:
                myInventory.append(try equipArray.decode(Consumable.self))
            case .Junk:
                myInventory.append(try equipArray.decode(Equipment.self))
            }
        }
        self.inventory = myInventory
    }
    
 
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: characterKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(stats["strength"], forKey: .strength)
        try container.encode(stats["perception"], forKey: .perception)
        try container.encode(stats["endurance"], forKey: .endurance)
        try container.encode(stats["charisma"], forKey: .charisma)
        try container.encode(stats["intelligence"], forKey: .intelligence)
        try container.encode(stats["luck"], forKey: .luck)
        try container.encode(stats["agility"], forKey: .agility)
        try container.encode(gold, forKey: .gold)
        try container.encode(level, forKey: .level)
        try container.encode(experience, forKey: .experience)
        try container.encode(profession, forKey: .profession)
        try container.encode(race, forKey: .race)
        try container.encode(sex, forKey: .sex)
        try container.encode(inventory, forKey: .inventory)
        try container.encode(currentHealth, forKey: .hp)
        try container.encode(currentMana, forKey: .mana)
        try container.encode(currentEnergy, forKey: .energy)
        try container.encode(headEquipmentSlot, forKey: .headEquipmentSlot)
        try container.encode(chestEquipmentSlot, forKey: .chestEquipmentSlot)
        try container.encode(legsEquipmentSlot, forKey: .legsEquipmentSlot)
        try container.encode(equippedSlot, forKey: .equippedSlot)
        }
    
    func getGold() -> Int {return gold}
    func getStatusEffects() -> String {return "None"}
    func getLevel() -> Int {return level}
    func getExperience() -> Int {return experience}
    func rewardXp(_ xp: Int) {
        experience += xp
        lvlUp()
        UIApplication.xpMessage("You have gained \(xp)xp.")
    }
    
    func getXpToLvl() -> Int {
        var xp = 100
        if (level == 1){
            xp = 1000
        } else if (level == 2){
            xp = 1250
        } else if (level == 3){
            xp = 1550
        } else if (level == 4){
            xp = 1750
        } else if (level == 5){
            xp = 2250
        } else if (level == 6){
            xp = 3250
        } else if (level == 7){
            xp = 4250
        } else if (level == 8){
            xp = 5250
        } else if (level == 9){
            xp = 6250
        } else if (level == 10){
            xp = 7250
        } else if (level > 10) {
            xp = 10000
        }
            return xp
    }
    
    func takeDamage(_ dmg: Int) {
            currentHealth -= dmg
    }
    
    func attack(enemy: Character) -> Int{
        let injury = (getWeapon()?.damage?.physical ?? 1) * Int8(stats["strength"] ?? 1) - enemy.getDefense()
        print("\(self.race) has done \(injury) dmg to \(enemy.race)")

        if (injury <= 0){
            return 0
        }
        enemy.currentHealth -= Int(injury)
        return Int(injury)
    }
    
    func lvlUp() {
        if (experience < getXpToLvl()) { return }
        let diff = experience - getXpToLvl()
        level += 1
        UIApplication.xpMessage("LEVEL UP!!! Welcome to level \(level).")
        experience = diff
        lvlUp() // Recursive check for multiple levelups
        
    }
    
    func heal(_ amt: Int){
    currentHealth += amt
        if currentHealth > maxHealth {
            currentHealth = maxHealth
        }
    }
    
    func adjustMana(_ amt: Int){
        currentMana += amt
        if (currentMana < 0){
            currentMana = 0
        }
        if (currentMana > maxMana){
            currentMana = maxMana
        }
    }
    
    func adjustEnergyLevel(_ amt: Int) {
        currentEnergy += amt
        if (currentEnergy < 0){
            currentEnergy = 0
        }
        if (currentEnergy > maxEnergy) {
            currentEnergy = maxEnergy
        }
    }
    
    func raiseStat(_ name: String){
        let initial = stats[name]
        if (getLevelUpsAvailable() > 0){
        stats[name] = initial! + 1
        }
    }
    
    func lowerStat(_ name: String){
        let initial = stats[name]
        if (initial! > 1){
        stats[name] = initial! - 1
        }
    }
    
    func getLevelUpsAvailable() -> Int {
        return 17 + level - getAllStats()
    }
    
    func getAllStats() -> Int {
        let total = stats.values.reduce(0, +)
        return Int(total)
    }
    
    func xpToNextLevel(){
        
    }
    func getItemFromRow(_ index:IndexPath) -> Equipment {
        return inventory[index.row]
    }
    func rewardItem(_ item: Equipment){
        inventory.append(item)
    }
    func dropItemFromRow(_ index:Int){
        inventory.remove(at: index)
    }
    
    func getAttack() -> Int {
        let attk = 1 + Int8(strength) + (getWeapon()?.damage?.physical ?? 0)
        return Int(attk)
    }
    
    func getDefense() -> Int8 {
        let def = (getChest()?.damageResist?.physical ?? 0) + (getLegs()?.damageResist?.physical ?? 0)
        return def
    }
    private func equipToHead(index:Int){
        removeHeadPiece()
        headEquipmentSlot = (inventory.remove(at: index) as! Armor)
    }
    
    private func equipPants(index:Int){
        removeLegPiece()
        legsEquipmentSlot = (inventory.remove(at: index) as! Armor)
    }
    
    private func equipShirt(index:Int){
        removeChestPiece()
        chestEquipmentSlot = (inventory.remove(at: index) as! Armor)
    }
    
    private func equipWeapon(index:Int){
        removeEquipedItem()
        equippedSlot = (inventory.remove(at: index) as! Weapon)
    }
    
    private func useItem(index:Int){
        let item = inventory.remove(at: index) as! Consumable
        item.effect?.action()
    }
    
    func equipItem(named: String){
       
        let count = inventory.firstIndex(where: {$0.name.contains(named)})
        if (count != nil){
            if (count! >= 0 && count! <= inventory.count){
                print("Item \(named) found at index \(count ?? -1)")
                equipItemFromRow(index: count!)
            }
        }
    }
    
    func equipItemFromRow(index: Int){
        let item = inventory[index]
        if item is Armor {
            if let thisArmor = item as? Armor{
                switch (thisArmor.equippedLocation) {
                case .Arm:
                    equipToHead(index: index)
                case .Head:
                    equipToHead(index: index)
                case .Chest:
                    equipShirt(index: index)
                case .Legs:
                    equipPants(index: index)
                case .Shoes:
                    equipToHead(index: index)
                }
                UIApplication.systemMessage("You equip \(item.name)")

            } else {
                UIApplication.systemMessage("\(item.name) isn't armor you can equip")

            }
        } else if item is Weapon {
            UIApplication.systemMessage("You equip \(item.name)")
            equipWeapon(index: index)
        } else if item is Consumable {
            UIApplication.systemMessage("You use \(item.name)")
            useItem(index: index)
        } else {
            UIApplication.systemMessage("Don't know how to use \(item.name)")
        }
        
        
    }
    
    func removeHeadPiece(){
        if (headEquipmentSlot != nil){
            inventory.append(headEquipmentSlot!)
            headEquipmentSlot = nil
        }
    }
    
    func removeChestPiece(){
        if (chestEquipmentSlot != nil){
            inventory.append(chestEquipmentSlot!)
            chestEquipmentSlot = nil
        }
    }
    
    func removeLegPiece(){
        if (legsEquipmentSlot != nil){
            inventory.append(legsEquipmentSlot!)
            legsEquipmentSlot = nil
        }
    }
    
    func removeEquipedItem(){
        if (equippedSlot != nil){
            inventory.append(equippedSlot!)
            equippedSlot = nil
        }
    }
    
    func reward () {
      
    }
    
    func receives() {
        
    }
    
    
    
}
