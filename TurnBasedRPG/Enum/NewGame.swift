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
            let rayven = Command("Rayven- Priestess", completionHandler: {
                UIApplication.systemMessage("You begin your journey as Rayven- Voodoo Priestess")
                 let hero = Character(strength: 1, perception: 3, endurance: 2, charisma: 3, intelligence: 4, luck: 3, agility: 2)
                hero.name = "Rayven"
                hero.race = .human
                hero.profession = .cleric
                hero.image = "shadowqueen"
                hero.rewardItem(ItemRack.manaPotion.instance)
                hero.rewardItem(ItemRack.healthPotion.instance)
                hero.rewardItem(ArmorRack.shirt.instance)
                hero.rewardItem(ArmorRack.leatherPants.instance)
                hero.rewardItem(WeaponRack.club.instance)
                
                GameDatabase.shared.hero = hero
            })
            let colby = Command("Colby- Warrior", completionHandler: {
                UIApplication.systemMessage("You begin your journey as Colby- Road Warrior")
                let hero = Character(strength: 3, perception: 2, endurance: 3, charisma: 1, intelligence: 1, luck: 3, agility: 2)
               hero.name = "Colby"
               hero.race = .human
               hero.profession = .warrior
               hero.image = "merchant"
               hero.rewardItem(ItemRack.healthPotion.instance)
                hero.rewardItem(ArmorRack.chainChest.instance)
                hero.rewardItem(ArmorRack.jeans.instance)
                hero.rewardItem(WeaponRack.axe.instance)
               
               GameDatabase.shared.hero = hero
            })
            let wretch = Command("Durby- Wretch ", completionHandler: {
                UIApplication.systemMessage("For some reason you chose the wretch Durby.")
                let hero = Character(strength: 2, perception: 3, endurance: 2, charisma: 1, intelligence: 1, luck: 1, agility: 3)
               hero.name = "Durby"
               hero.race = .human
                hero.profession = .assassin
               hero.image = "thief"
               hero.rewardItem(ItemRack.healthPotion.instance)
               hero.rewardItem(ArmorRack.shirt.instance)
               hero.rewardItem(ArmorRack.leatherPants.instance)
               hero.rewardItem(WeaponRack.bareFist.instance)
               
               GameDatabase.shared.hero = hero
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
