//
//  GameDatabase.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/19/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import Foundation

class GameDatabase {
    
    // Singleton example:
    // Access a singleton anywhere from the project with GameDatabase.shared.hero ect..
    static let shared: GameDatabase = GameDatabase()
    
    var hero:Character = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1)
    
    var canEditStats:Bool = true
    
    var musicOn = true
    var soundOn = true
    
    var musicVolume = 1.0
    var soundVolume = 1.0
    
    var gameSpped = 1.0
    
}
