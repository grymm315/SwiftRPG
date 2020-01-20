//
//  GameDatabase.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/19/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import Foundation

class GameDatabase {
    
    static let shared: GameDatabase = GameDatabase()
    
    var hero:Character = Character(strength: 9, perception: 9, endurance: 9, charisma: 9, intelligence: 9, luck: 9, agility: 3)
    
}
