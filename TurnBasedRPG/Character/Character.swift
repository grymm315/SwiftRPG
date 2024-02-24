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
    
    internal init(strength: UInt8, perception: UInt8, endurance: UInt8, charisma: UInt8, intelligence: UInt8, luck: UInt8, agility: UInt8) {
        self.strength = strength
        self.perception = perception
        self.endurance = endurance
        self.charisma = charisma
        self.intelligence = intelligence
        self.luck = luck
        self.agility = agility
        name = "Grymmenthald"
        
        equippedSlot = WeaponRack.bareFist.instance
        chestEquipmentSlot = ArmorRack.shirt.instance
        legsEquipmentSlot = ArmorRack.leatherPants.instance
        
    }
    

    
    var maxHealth: Int {return Int((stats["endurance"] ?? 1) * 10)}
    lazy var currentHealth: Int = maxHealth
    
    var maxMana: Int {return Int((stats["intelligence"] ?? 1) * 10)}
    lazy var currentMana: Int = maxMana
    var maxEnergy: Int {return Int((stats["endurance"] ?? 1) * 10)}
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
    
    var name: String
    private var level = 1
    private var experience = 0
    var race:raceTypes = .human
    var profession:classType = .warrior
    var sex:sexType = .male
    
    private var inventory: [Equipment] = []
    
    private var headEquipmentSlot: Armor?
    private var chestEquipmentSlot: Armor?
    private var legsEquipmentSlot: Armor?
    private var equippedSlot: Weapon?
    
    func getInventory() -> [Equipment] { return inventory}
    func getHead() -> Armor? { return headEquipmentSlot}
    func getChest() -> Armor? { return chestEquipmentSlot}
    func getLegs() -> Armor? { return legsEquipmentSlot}
    func getWeapo() -> Weapon? { return equippedSlot}
    
    
    
   
    func takeDamage(_ dmg: Int) {
        let t = dmg - getDefense()
        if t >= 0 {
            currentHealth -= dmg
        }
    }
    
    enum characterKeys: String, CodingKey, CaseIterable {
            case name, strength, perception, endurance, charisma, intelligence, luck,
        agility, gold, level, experience, race, profession, sex, inventory, headEquipmentSlot, chestEquipmentSlot, legsEquipmentSlot, equippedSlot
        }
    enum equipmentKeys: CodingKey {
        case type
    }
    
    enum equipmentTypes: String, CodingKey {
        case chest, legs, equiped, consumable, junk
    }
    
    required init(from decoder: Decoder) throws {
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
        self.race = try container.decode(raceTypes.self, forKey: .race)
        self.sex = try container.decode(sexType.self, forKey: .sex)
        self.headEquipmentSlot = try container.decode(Armor?.self, forKey: .headEquipmentSlot)
        self.chestEquipmentSlot = try container.decode(Armor?.self, forKey: .chestEquipmentSlot)
        self.legsEquipmentSlot = try container.decode(Armor?.self, forKey: .legsEquipmentSlot)
        self.equippedSlot = try container.decode(Weapon?.self, forKey: .equippedSlot)
        
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
        
        print("Container: \(try container.decode([Equipment].self, forKey: .inventory))")
        
     

    }
    
 
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: characterKeys.self)
        try container.encode(name, forKey: .name)
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
        try container.encode(race, forKey: .race)
        try container.encode(sex, forKey: .sex)
        try container.encode(inventory, forKey: .inventory)
        
        try container.encode(headEquipmentSlot, forKey: .headEquipmentSlot)
        try container.encode(chestEquipmentSlot, forKey: .chestEquipmentSlot)
        try container.encode(legsEquipmentSlot, forKey: .legsEquipmentSlot)
        try container.encode(equippedSlot, forKey: .equippedSlot)
        }
    
    func getGold() -> Int {
        return gold
    }
    
    func getStatusEffects() -> String {
        return "None"
    }
    
    func getLevel() -> Int {
        return level
    }
    
    func getExperience() -> Int {
        return experience
    }
    
    func rewardXp(_ xp: Int) {
        experience += xp
        lvlUp()
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
    
    func lvlUp() {
        if (experience < getXpToLvl()) { return }
        let diff = experience - getXpToLvl()
        level += 1
        experience = diff
        lvlUp() // Recursive check for multiple levelups
        
    }
    
    func heal(_ amt: Int){
    currentHealth += amt
        if currentHealth > maxHealth {
            currentHealth = maxHealth
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
//    func getItem(_ item: Equipment){
//        if let index = inventory.firstIndex(where: {$0.name == item.name}) {
//           //found item
//        } else {
//            //did not find item
//        }
//    }
    
    func getAttack() -> Int {
        let attk = 1 + Int8(strength) + (getWeapo()?.damage?.damageResist ?? 0)
        return Int(attk)
    }
    
    func getDefense() -> Int {
        let def = (getChest()?.damageResist?.damageResist ?? 0) + (getLegs()?.damageResist?.damageResist ?? 0)
        return Int(def)
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
    
//    func equip(_ item: Equipment){
//        let swapping = item
//
//        if let index = inventory.firstIndex(where: {$0.name == item.name}) {
//
//        } else {
//    print("Did not find item")
//        }
//    }
    
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

    
    lazy var stats: [String : UInt8] = [
        "strength" : strength,
        "perception" : perception,
        "endurance" : endurance,
        "charisma" : charisma,
        "intelligence" : intelligence,
        "luck" : luck,
        "agility" : agility,
    ]
    
    func reward () {
      
    }
    
    func receives() {
        
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
        return 7 + level - getAllStats()
    }
    
    func getAllStats() -> Int {
        let total = stats.values.reduce(0, +)
        return Int(total)
    }
    
    // MARK: Random Data... remove this from the class
    enum raceTypes: String, Codable{
        case human, elf, dwarf, halfling, pixie, halfogre, halforc,
        halftroll, halfelf, gith, drow, seaelf, vampire, demon,
        lizman, nome, angel,
        troll, ant, ape, baboon, bat, bear, bee,
        beetle, boar, bugbear, cat, dog, dragon, ferret, fly,
        gargoyle, gelatin, ghoul, gnoll, gnome, goblin, golem,
        gorgon, harpy, hobgoblin, kobold, lizardman, locust,
        lycanthrope, minotaur, mold, mule, neanderthal, ooze, orc,
        rat, rustmonster, shadow, shapeshifter, shrew, shrieker,
        skeleton, slime, snake, spider, stirge, thoul, troglodyte,
        undead, wight, wolf, worm, zombie, bovine, canine, feline,
        porcine, mammal, rodent, avis, reptile, amphibian, fish,
        crustacean, insect, spirit, magical, horse, animal, humanoid,
        monster, god, shrub, tree, flower, grass, fungus, weed,
        Aarakocra, Aasimon, Angel, Antelope, Azer, Basilisk, Beholder,
        Bird, Brownie, Camel, Celestial, Centaur, Chitine, Couatl,
        Creeper, Dao, Deer, Demon, Deva, Devil, Dinosaur, Djinni,
        Dolphin, Drake, Dryad, Duergar, Eel, Efreeti, Elemental,
        Elephant, Ethereal, Ettin, Fairy, Firbolg, Genasi, Giant,
        Goat, Gremlin, Griffon, Hydra, Illithid, Imp, Incarnate,
        Janni, Kraken, Kuatoa, Lagomorph, Leech, Leprechaun, Lich,
        Liquid, Magman, Manticore, Marid, Marsupial, Mephit, Mercane,
        Mist, Mollusc, Mongrel, Myconoid, Nereid, Nymph, Octopus,
        Ogre, Pech, Phantom, Primate, Rabbit, Rakshasa, Rock,
        Sahaugin, Satyr, Selkie, Shark, Sirine, Slaad, Sprite,
        Squid, Squirrel, Stone, Sylph, Tanarri, Thrikreen, Tiefling,
        Titan, Toad, Unicorn, Urchin, Vapor, Wemic, Whale, Xorn
    }
    
    enum sexType: Int, Codable {
        case male, female, nueter
    }
    
//    let classDescription:[String] = [
//        "mage", "cleric", "thief", "warrior", "vampire", "druid", "ranger",
//        "augurer", "paladin", "nephandi", "savage", "phantomer", "archer", "demon",
//        "assassin", "angel", "werewolf", "licanthrope", "lich", "monger", "pirate",
//        "baker", "butcher", "blacksmith", "mayor", "king", "queen"
//    ]
    
    enum classType:Int, CustomStringConvertible, Codable {
        case mage, cleric, thief, warrior, vampire, druid, ranger,
        augurer, paladin, nephandi, savage, phantomer, archer, demon,
        assassin, angel, werewolf, licanthrope, lich, monger, pirate,
        baker, butcher, blacksmith, mayor, king, queen
        
        var description: String {
            switch self {
            case .mage:
                return "mage"
            case .angel:
                return "Angel"
            case .archer:
                return "Archer"
            case .assassin:
                return "Assassin"
            default:
                return "Dude"
            }
        }
    }
    
    
}
