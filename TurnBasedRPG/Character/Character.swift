//
//  Character.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

class Character {
    internal init(strength: UInt8, perception: UInt8, endurance: UInt8, charisma: UInt8, intelligence: UInt8, luck: UInt8, agility: UInt8) {
        self.strength = strength
        self.perception = perception
        self.endurance = endurance
        self.charisma = charisma
        self.intelligence = intelligence
        self.luck = luck
        self.agility = agility
        name = "Grymmenthald"
        
        equippedSlot = Weapon.init(name: "Bare-Hands", description: "Ordinary hands. 10 fingers and 2 thumbs on each hand.")
        chestEquipmentSlot = Armor.init(name: "Black T-Shirt", description: "100% Cotton. Machine wash cold.", type: .Chest)
        legsEquipmentSlot = Armor.init(name: "Jeans", description: "Blue denim. Formal wear of the Candian Empire", type: .Legs)
        
    }
    
    var maxHealth: Int {
        return Int(endurance * 10)
    }
    lazy var currentHealth: Int = Int(endurance * 10)
    
    // Is this too Fallout?
    var strength: UInt8
    var perception: UInt8
    var endurance: UInt8
    var charisma:UInt8
    var intelligence:UInt8
    var luck:UInt8
    var agility:UInt8
    
    var name: String
    var level = 1
    var experience = 0
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
    
    private func equipToHead(index:Int){
        removeHeadPiece()
        headEquipmentSlot = inventory.remove(at: index) as! Armor
    }
    
    private func equipPants(index:Int){
        removeLegPiece()
        legsEquipmentSlot = inventory.remove(at: index) as! Armor
    }
    
    private func equipShirt(index:Int){
        removeChestPiece()
        chestEquipmentSlot = inventory.remove(at: index) as! Armor
    }
    
    private func equipWeapon(index:Int){
        removeEquipedItem()
        equippedSlot = inventory.remove(at: index) as! Weapon
    }
    
    func equipItemFromRow(index: Int){
        let item = inventory[index]
        if item is Armor {
            if let thisArmor = item as? Armor{
                switch (thisArmor.type) {
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
            } else {
                print("Armor isn't Armor")
            }
        } else if item is Weapon {
            equipWeapon(index: index)
        } else {
            print("I don't know what the fuck you're trying to equip")
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
        let rewardPool:[Equipment] = [
            Armor(name: "Wool Hat", description: "Spun of yarn, this hat protects from cold", type: .Head),
            Armor(name: "Magic Sword", description: "This sword possess the magic of friendship", type: .Arm),
            Equipment(name: "A Gem", description: "A small blue gem. It might be a piece of glass")
        ]
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
        return 36 - getAllStats()
    }
    
    func getAllStats() -> Int {
        let total = stats.values.reduce(0, +)
        return Int(total)
    }
    
    // MARK: Random Data... remove this from the class
    enum raceTypes: String{
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
    
    enum sexType: Int {
        case male, female, nueter
    }
    
    let classDescription:[String] = [
        "mage", "cleric", "thief", "warrior", "vampire", "druid", "ranger",
        "augurer", "paladin", "nephandi", "savage", "phantomer", "archer", "demon",
        "assassin", "angel", "werewolf", "licanthrope", "lich", "monger", "pirate",
        "baker", "butcher", "blacksmith", "mayor", "king", "queen"
    ]
    
    enum classType:Int, CustomStringConvertible {
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
