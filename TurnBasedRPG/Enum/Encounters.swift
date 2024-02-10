//
//  Encounters.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 2/7/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

/** Use the Weapon Rack to hold an enum of all the potential weapons we might have for easy retrieval */
enum ForestEncounters {
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
                UIApplication.systemMessage("The goblin stares at you in confusion before running off.")
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
