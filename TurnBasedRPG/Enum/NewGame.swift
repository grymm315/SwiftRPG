//
//  NewGame.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 8/15/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

enum NewGame: CaseIterable {
    case Quickstart, Gender, Species, Occupation
    var instance: [Command] {
        switch self {
      
        case .Quickstart:
            let description = Command("Select a hero", completionHandler: {})
            description.isSelectable = false
            let rayven = Command("Little Red Riding Hood", completionHandler: {
                UIApplication.systemMessage("Once upon a time there was a young girl named Little Red Riding Hood.........")
                 let hero = Character(strength: 1, perception: 3, endurance: 2, charisma: 3, intelligence: 1, luck: 3, agility: 2)
                hero.name = "Red"
                hero.rewardXp(1000)
                hero.race = .human
                hero.profession = .cleric
                hero.image = "shadowqueen"
                hero.rewardItem(ItemRack.manaPotion.instance)
                hero.rewardItem(ItemRack.healthPotion.instance)
                hero.rewardItem(ArmorRack.shirt.instance)
                hero.rewardItem(ArmorRack.plateChest.instance)
                hero.rewardItem(ArmorRack.chainChest.instance)


//                hero.rewardItem(ArmorRack.leatherPants.instance)
                hero.rewardItem(WeaponRack.club.instance)
                
                GameDatabase.shared.hero = hero
                UIApplication.topViewController?.performSegue(withIdentifier: "enterGame", sender: nil)
            })
            let colby = Command("Little Boy Blue", completionHandler: {
                UIApplication.systemMessage("Once upon a time there was Little Boy Blue. A sleepy little boy without a clue..........")
                let hero = Character(strength: 3, perception: 2, endurance: 3, charisma: 1, intelligence: 1, luck: 3, agility: 2)
               hero.name = "Blue"
               hero.race = .human
                hero.rewardXp(1000)

               hero.profession = .warrior
               hero.image = "merchant"
               hero.rewardItem(ItemRack.healthPotion.instance)
//                hero.rewardItem(ArmorRack.chainChest.instance)
                hero.rewardItem(ArmorRack.jeans.instance)
                hero.rewardItem(WeaponRack.axe.instance)
               GameDatabase.shared.hero = hero
                UIApplication.topViewController?.performSegue(withIdentifier: "enterGame", sender: nil)
            })
            let wretch = Command("Hansel", completionHandler: {
                UIApplication.systemMessage("Once upon a time there  was a young man Hansel........")
                let hero = Character(strength: 2, perception: 3, endurance: 2, charisma: 1, intelligence: 1, luck: 1, agility: 3)
               hero.name = "Hansel"
               hero.race = .human
                hero.rewardXp(1000)

                hero.profession = .assassin
               hero.image = "thief"
               hero.rewardItem(ItemRack.healthPotion.instance)
               hero.rewardItem(ArmorRack.shirt.instance)
//               hero.rewardItem(ArmorRack.leatherPants.instance)
               hero.rewardItem(WeaponRack.bareFist.instance)
               
               GameDatabase.shared.hero = hero
                UIApplication.topViewController?.performSegue(withIdentifier: "enterGame", sender: nil)
            })
            let custom = Command("Custom", completionHandler: {

            })
            return [description, rayven, colby, wretch]
        case .Gender:
            let description = Command("Select Gender", completionHandler: {})
            description.isSelectable = false
            let boy = Command("Boy", completionHandler: {
               
            })
            let girl = Command("Girl", completionHandler: {

            })
            return [description, boy, girl]
        case .Species:
            let description = Command("Select Race", completionHandler: {})
            description.isSelectable = false
            let human = Command("Human", completionHandler: {
            })
            let goblin = Command("Goblin", completionHandler: {
            })
            return [description, human, goblin]
        case .Occupation:
            let description = Command("Select Job", completionHandler: {})
            description.isSelectable = false
            let cleric = Command("Clergy", completionHandler: {
            })
            let fighter = Command("Fighter", completionHandler: {
            })
            let mage = Command("Mage", completionHandler: {
            })
            
         
            return [description, cleric, fighter, mage]
        }
    }
}
