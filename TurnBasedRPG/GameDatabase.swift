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
    
    lazy var quests: [String : String] = [
        "New Beginings" : "Welcome to the world of Grymm. You have awakened in a town, try to get to the next one.",
        "New Dawn" : "It is the middle of night, can you last until day?",
    ]
    
    
    var map: AreaGenerator = AreaGenerator.init(name: "Adrift")
    lazy var currentRoom:RoomNode = map.downtown5
    
    var canEditStats:Bool = true
    
    var musicOn = true
    var soundOn = true
    
    var musicVolume = 1.0
    var soundVolume = 1.0
    
    var gameSpped = 1.0
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Save1")
    
    func saveGame() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let savedData =  try encoder.encode(GameDatabase.shared.hero)
            print("Saved Data: \(String(data: savedData, encoding: .utf8) ?? "XXX")")
            try savedData.write(to: documentsURL)

        } catch {
            print("Save Game Error: \(error)")
        }
    }
    
    func loadGame() {
        
            let decoder = JSONDecoder()
        do {
            let loadedData = try Data(contentsOf: documentsURL)
            print("Loaded Data: \(String(data: loadedData, encoding: .utf8) ?? "XXX")")

            let readingData = try decoder.decode(Character.self, from: loadedData)
            GameDatabase.shared.hero = readingData
        } catch {
            print("Load Error: \(error)")
        }
    }
}
