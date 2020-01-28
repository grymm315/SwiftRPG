//
//  Character.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

class Character{
    internal init(strength: UInt8, perception: UInt8, endurance: UInt8, charisma: UInt8, intelligence: UInt8, luck: UInt8, agility: UInt8) {
        self.strength = strength
        self.perception = perception
        self.endurance = endurance
        self.charisma = charisma
        self.intelligence = intelligence
        self.luck = luck
        self.agility = agility
        name = "Gary"
    }
    
    var inventory: [Equipment] = []
    
    lazy var stats: [String : UInt8] = [
    "strength" : strength,
    "perception" : perception,
    "endurance" : endurance,
    "charisma" : charisma,
    "intelligence" : intelligence,
    "luck" : luck,
    "agility" : agility,
    ]
    
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
    
    func raiseStat(_ name: String){
        let initial = stats[name]
        stats[name] = initial! + 1
    }
    
    func lowerStat(_ stat: String){
          let initial = stats[name]
              stats[name] = initial! + 1
    }
    
    // MARK: Random Data
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
