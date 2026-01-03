//
//  Encounters.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 2/7/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

enum DungeonEncounters: CaseIterable {
    case slime, beetle, rat, spider
    
    var instance: [Command]{
        switch self {
            
        case .slime:
            let description = Command("You see a pool of slime oozing from the ground.", completionHandler: {})
            description.isSelectable = false
            let attkGoblin = Command("Stomp slime puddle", completionHandler: {
                
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.slime)
            })
            
            let fleeGoblin = Command("Avoid slime puddle", completionHandler: {
                UIApplication.systemMessage("You walk around the slime puddle." )
            })
            return [description, attkGoblin, fleeGoblin]
            
        case .beetle:
            let description = Command("An angry beetle crawls out from under a rock.", completionHandler: {})
            description.isSelectable = false
            let attkGoblin = Command("Attack beetle", completionHandler: {
                
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.beetle)
            })
            let waveGoblin = Command("Shoo beetle", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.beetle)
            })
            let fleeGoblin = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You manage to escape before the beetle sees you..")
            })
            return [description, attkGoblin, waveGoblin, fleeGoblin]
        case .rat:
            let description = Command("A hungry rat scampers out from under a rock.", completionHandler: {})
            description.isSelectable = false
            let attkGoblin = Command("Attack Rat", completionHandler: {
                
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.rat)
            })
            let waveGoblin = Command("Shoo rat", completionHandler: {
                UIApplication.systemMessage("The rat stares at you in confusion before running off. +40XP")
                GameDatabase.shared.hero.rewardXp(40)
            })
            let fleeGoblin = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You manage to escape before the goblin sees you..")
            })
            return [description, attkGoblin, waveGoblin, fleeGoblin]
        case .spider:
            let description = Command("You see a spider hanging from a web", completionHandler: {})
            description.isSelectable = false
            let attkGoblin = Command("Attack Spider", completionHandler: {
                
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.spider)
            })
            let waveGoblin = Command("Shoo spider", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.spider)
            })
            let fleeGoblin = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You manage to escape before the spider sees you..")
            })
            return [description, attkGoblin, waveGoblin, fleeGoblin]
        }
    }
}
enum SearchEncounters: CaseIterable {
    case barrel, door, alcove2, treasure
    var instance: [Command] {
        switch self {
            case .barrel:
            let description = Command("This room contains various barrels.", completionHandler: {})
            description.isSelectable = false
            let search = Command("Search barrel", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
           
            let ignore = Command("Ignore", completionHandler: {
                UIApplication.systemMessage("")
            })
            return [description, search, ignore]
        case .door:
            let description = Command("This the final door of the dungeon.", completionHandler: {})
            description.isSelectable = false
            let openDoor = Command("Open door", completionHandler: {
                UIApplication.systemMessage("This door is locked. You need a key to open it.")

            })
           
            let ignore = Command("Ignore", completionHandler: {
                
            })
            return [description, openDoor, ignore]
        case .alcove2:
            let description = Command("This room contains two different alcoves", completionHandler: {})
            description.isSelectable = false
            let search = Command("Search left alcove", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
            let search2 = Command("Search right alcove", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
           
            let ignore = Command("Ignore", completionHandler: {
                UIApplication.systemMessage("")
            })
            return [description, search, search2, ignore]
        case .treasure:
            let description = Command("This seems to be a storage room of some kind", completionHandler: {})
            description.isSelectable = false
            let search = Command("Search left alcove", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
            let search2 = Command("Search right alcove", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
            let search3 = Command("Search right box", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
            let search4 = Command("Search left box", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
            let search5 = Command("Search barrel", completionHandler: {
                UIApplication.systemMessage("After searching the barrel you find nothing of interest.")

            })
           
            let ignore = Command("Ignore", completionHandler: {
                UIApplication.systemMessage("")
            })
            return [description, search, search2, search3, search4, search5, ignore]
        }
    }
}


enum ForestEncounters: CaseIterable {
    case Goblin, Mushrooms, RestfulSpring, LoneWolf
    var instance: [Command] {
        switch self {
      
        case .Goblin:
            let description = Command("All of a sudden you spot a goblin in the distance. What do you do?", completionHandler: {})
            description.isSelectable = false
            let attkGoblin = Command("Attack Goblin", completionHandler: {
                
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.Goblin)
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
            let description = Command("You see a stray dog begging for scraps", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Wolf", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.LoneWolf)
            })
            let bribe = Command("Give food", completionHandler: {
                UIApplication.systemMessage("You give the dog some of your food.")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, bribe, flee]
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
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.rat)
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
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.merchant)
            })
            let buy = Command("Shop", completionHandler: {
                UIApplication.systemMessage("Not implemented")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, buy, flee]
        case .Thief:
            let description = Command("You are confronted with a thief", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Thief", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.thief)
            })
            let bribe = Command("Give money", completionHandler: {
                UIApplication.systemMessage("You give the thief $20 and he lets you go on the way")
            })
            let flee = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You bravely run away")
            })
            return [description, attk, bribe, flee]
        case .CityGuard:
            let description = Command("You encounter a guardsman on patrol", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Guard", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.townGuard)
            })
            let bribe = Command("Bribe Guard", completionHandler: {
                UIApplication.systemMessage("You give the guard $20")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, bribe, flee]
        case .Dog:
            let description = Command("You see a stray dog begging for scraps", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Dog", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.dog)
            })
            let bribe = Command("Give food", completionHandler: {
                UIApplication.systemMessage("You give the dog some of your food.")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, bribe, flee]
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
            let attk = Command("Attack Deer", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.dog)
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
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.merchant)
            })
            let buy = Command("Shop", completionHandler: {
                UIApplication.systemMessage("Not implemented")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, buy, flee]
        case .Thief:
            let description = Command("You are confronted with a thief", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Thief", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.thief)
            })
            let bribe = Command("Give money", completionHandler: {
                UIApplication.systemMessage("You give the thief $20 and he lets you go on the way")
            })
            let flee = Command("Flee", completionHandler: {
                UIApplication.systemMessage("You bravely run away")
            })
            return [description, attk, bribe, flee]
        case .CityGuard:
            let description = Command("You encounter a weary ranger.", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Ranger", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.townGuard)
            })
            let bribe = Command("Give money", completionHandler: {
                UIApplication.systemMessage("You give the guard $20 and he lets you go on the way")
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, bribe, flee]

        case .Dog:
            let description = Command("A friendly dog approaches", completionHandler: {})
            description.isSelectable = false
            let attk = Command("Attack Dog", completionHandler: {
                UIApplication.topViewController?.performSegue(withIdentifier: "BattleView", sender: Monster.dog)
            })
            let flee = Command("Leave", completionHandler: {
                UIApplication.systemMessage("Not seeing anything of interest you walk away.")
            })
            return [description, attk, flee]
        }
    }
}
