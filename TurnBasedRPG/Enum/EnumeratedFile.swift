//
//  EnumeratedFile.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/15/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

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
    case male, female, nueter, f2m, m2f
}

enum classType:Int, CustomStringConvertible, Codable {
    case mage, cleric, thief, warrior, vampire, druid, ranger,
    augurer, paladin, savage, demon, assassin,  pirate,
    baker, butcher, blacksmith, mayor, king, queen, innKeeper
    
    var description: String {
        switch self {
        case .mage:
            return "mage"
        case .assassin:
            return "Assassin"
        case .cleric:
            return "cleric"
        case .thief:
            return "thief"
        case .warrior:
            return "warrior"
        case .vampire:
            return "vampire"
        case .druid:
            return "druid"
        case .ranger:
            return "ranger"
        case .augurer:
            return "augurer"
        case .paladin:
            return "paladin"
        case .savage:
            return "savage"
        case .demon:
            return "demon"
        case .pirate:
            return "pirate"
        case .baker:
            return "baker"
        case .butcher:
            return "butcher"
        case .blacksmith:
            return "blacksmith"
        case .mayor:
            return "mayor"
        case .king:
            return "king"
        case .queen:
            return "queen"
        case .innKeeper:
            return "innKeeper"
        }
    }
}
