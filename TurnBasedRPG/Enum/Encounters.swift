//
//  Encounters.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 2/7/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

enum ForestEncounters: CaseIterable {
    case Goblin, Mushrooms, RestfulSpring, LoneWolf
    var instance: [Command] {
        switch self {
      
        case .Goblin:
            let description = Command("All of a sudden you spot a goblin in the distance. What do you do?", completionHandler: {})
            description.isSelectable = false
            let attkGoblin = Command("Attack Goblin", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: self)
            })
            let waveGoblin = Command("Wave at Goblin", completionHandler: {
                UIApplication.systemMessage("The goblin stares at you in confusion before running off. +40XP")
                GameDatabase.shared.hero.rewardXp(40)
            })
            let fleeGoblin = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You manage to escape before the gobline sees you..")
            })
            return [description, attkGoblin, waveGoblin, fleeGoblin]
        case .Mushrooms:
            let description = Command("You stumble across a circle of mushrooms. What do you do?", completionHandler: {})
            description.isSelectable = false
            let mushrooms = Command("Collect Mushrooms", completionHandler: {
                UIApplication.systemMessage("You collect the mushroom and put it in your bag.")
                GameDatabase.shared.hero.rewardItem(ItemRack.mushroom.instance)
            })
            let leave = Command("Leave", completionHandler: {
                UIApplication.systemMessage("No poisonous mushrooms for you.")

            })
            return [description, mushrooms, leave]
        case .RestfulSpring:
            let description = Command("A Spring bubbles up from the ground. What do you do?", completionHandler: {})
            description.isSelectable = false
            let drink = Command("Drink from Spring", completionHandler: {
                UIApplication.systemMessage("You guzzle the sweet water. Water is so good. ")
            })
            let bath = Command("Bathe in Spring", completionHandler: {
                UIApplication.systemMessage("You get naked when a Goblin attacks! ")
            })
            return [description, drink, bath]
        case .LoneWolf:
            let attkWolf = Command("Attack Wolf", completionHandler: {
                
            })
            return [attkWolf]
        }
    }
}

enum CityEncounters: CaseIterable {
    case Merchant, Thief, CityGuard, Rat, Dog
    var instance: [Command] {
        switch self {
        case .Rat:
            let description = Command("A fearless Rat approaches. What do you do?", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Rat", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: self)
            })
            let shoo = Command("Shoo Rat", completionHandler: {
                UIApplication.systemMessage("The rat scurries off. +2XP")
                GameDatabase.shared.hero.rewardXp(2)
            })
            let flee = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You bravely run away")
            })
            return [description, attk, shoo, flee]
        case .Merchant:
            let description = Command("You see a merchant peddling his wares", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Rob Merchant", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: self)
            })
            let buy = Command("Shop", completionHandler: {
                UIApplication.systemMessage("Not implemented")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, flee]
        case .Thief:
            let description = Command("You are confronted with a thief", completionHandler: {})
            description.isSelectable = false
            let flee = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You bravely run away")
            })
            return [description, flee]
        case .CityGuard:
            let description = Command("You encounter a guardsman on patrol", completionHandler: {})
            description.isSelectable = false
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, flee]
        case .Dog:
            let description = Command("You see a merchant peddling his wares", completionHandler: {})
            description.isSelectable = false
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, flee]
        }
    }
}

enum HighwayEncounters: CaseIterable {
    case Merchant, Thief, CityGuard, Rat, Dog
    var instance: [Command] {
        switch self {
        case .Rat:
            let description = Command("A fearless Deer approaches. What do you do?", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Rat", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: self)
            })
            let shoo = Command("Shoo Rat", completionHandler: {
                UIApplication.systemMessage("The rat scurries off. +2XP")
                GameDatabase.shared.hero.rewardXp(2)
            })
            let flee = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You bravely run away")
            })
            return [description, attk, shoo, flee]
        case .Merchant:
            let description = Command("You see a travelling merchant", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Rob Merchant", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: self)
            })
            let buy = Command("Shop", completionHandler: {
                UIApplication.systemMessage("Not implemented")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, flee]
        case .Thief:
            let description = Command("A man approaches demanding your money or your life", completionHandler: {})
            description.isSelectable = false
            let flee = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You bravely run away")
            })
            return [description, flee]
        case .CityGuard:
            let description = Command("You encounter a weary ranger.", completionHandler: {})
            description.isSelectable = false
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, flee]
        case .Dog:
            let description = Command("A friendly dog approaches", completionHandler: {})
            description.isSelectable = false
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, flee]
        }
    }
}
