//
//  GameDatabase.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/19/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit
protocol LogDelegate{
    func text(_ text: String, color: UIColor)
}
class GameDatabase {
    
    // Singleton example:
    // Access a singleton anywhere from the project with GameDatabase.shared.hero ect..
    static let shared: GameDatabase = GameDatabase()
    
    var hero:Character = Character(strength: 1, perception: 1, endurance: 1, charisma: 1, intelligence: 1, luck: 1, agility: 1)
    
    lazy var quests: [String : String] = [
        "Free Roam" : "Explore Grymm World. Find meaning in your wanderings.",
    ]
    
    
    var map: AreaGenerator = AreaGenerator.init(name: "Adrift")
    lazy var currentRoom:RoomNode = map.bedroom3
    
    var canEditStats:Bool = true
    
    var musicOn = true
    var soundOn = true
    
    var musicVolume = 1.0
    var soundVolume = 1.0
    
    var gameSpped = 1.0
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Save1")
    
    var logFile: NSMutableAttributedString = NSMutableAttributedString(string: "\n\n\n\n\n\n\n\n\n\n\n\nHello GrymmWorld\n", attributes: [.foregroundColor: UIColor.white]
    
    )
    var logDelegate: LogDelegate?
    func saveGame() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        UserDefaults.standard.setValue(currentRoom.title, forKey: "currentRoomImg")
        print("CP saving room \(currentRoom.title) \(currentRoom)")
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
            let room = UserDefaults.standard.string(forKey: "currentRoomImg")
            print("CP finding room \(room ?? "raw")")
            currentRoom = map.bedroom3.find{ $0.title == room } ?? map.bedroom3
            print("Loaded Data: \(String(data: loadedData, encoding: .utf8) ?? "XXX")")

            let readingData = try decoder.decode(Character.self, from: loadedData)
            GameDatabase.shared.hero = readingData
        } catch {
            print("Load Error: \(error)")
        }
    }
}
