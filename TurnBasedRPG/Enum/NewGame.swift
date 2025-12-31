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
            let description = Command("\n[Dungeon Initiated] \n\nDarkness swallows everything, then torches flare to life, casting jagged shadows across stone walls slick with age. The air is damp, metallic—like blood that’s been waiting centuries. No way out but forward.\n\n[Choose your Hero]\n\n", completionHandler: {})
            description.isSelectable = false
            let rayven = Command("Rayven", completionHandler: {
                UIApplication.systemMessage("The dungeon isn’t a prison—it’s a crucible. Every novice must walk its halls, not to escape, but to prove they deserve to rise higher. The elders call it a trial by fire: survive the traps, outwit the monsters, and claim the core’s blessing… or fall, and let the dungeon claim you as fuel. Your name is already etched into the roster. There’s no turning back—the gates grind open, and the darkness waits.")
                 let hero = Character(strength: 1, perception: 2, endurance: 2, charisma: 3, intelligence: 3, luck: 3, agility: 2)
                hero.name = "Rayven"
                hero.rewardXp(1000)
                hero.race = .human
                hero.profession = .cleric
                hero.skills.append(Punch())
                hero.skills.append(FirstAid())
                hero.skills.append(Fireball())
                hero.image = "shadowqueen"
                hero.rewardItem(ItemRack.manaPotion.instance)
                hero.rewardItem(ItemRack.healthPotion.instance)
                hero.rewardItem(ArmorRack.shirt.instance)
                hero.rewardItem(ArmorRack.jeans.instance)
                hero.equipItem(named: ArmorRack.jeans.instance.name)
                hero.equipItem(named: ArmorRack.shirt.instance.name)



//                hero.rewardItem(ArmorRack.leatherPants.instance)
                hero.rewardItem(WeaponRack.club.instance)
                
                UIApplication.systemMessage("Swipe in any direction to shift rooms—left, right, up, or down")
                GameDatabase.shared.hero = hero
                UIApplication.topViewController?.performSegue(withIdentifier: "enterGame", sender: nil)
            })
            let colby = Command("Colby", completionHandler: {
                UIApplication.systemMessage("The dungeon isn’t a prison—it’s a crucible. Every novice must walk its halls, not to escape, but to prove they deserve to rise higher. The elders call it a trial by fire: survive the traps, outwit the monsters, and claim the core’s blessing… or fall, and let the dungeon claim you as fuel. Your name is already etched into the roster. There’s no turning back—the gates grind open, and the darkness waits.")
                let hero = Character(strength: 3, perception: 2, endurance: 3, charisma: 1, intelligence: 1, luck: 3, agility: 3)
               hero.name = "Colby"
               hero.race = .human
                hero.rewardXp(1000)
                hero.skills.append(Punch())
                hero.skills.append(Kick())
               hero.profession = .warrior
               hero.image = "merchant"
               hero.rewardItem(ItemRack.healthPotion.instance)
//                hero.rewardItem(ArmorRack.chainChest.instance)
                hero.rewardItem(ArmorRack.jeans.instance)
                hero.rewardItem(WeaponRack.axe.instance)
                
                hero.equipItem(named: WeaponRack.axe.instance.name)
                hero.equipItem(named: ArmorRack.jeans.instance.name)


               GameDatabase.shared.hero = hero
                UIApplication.systemMessage("Swipe in any direction to shift rooms—left, right, up, or down")
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
            return [description, rayven, colby]
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
