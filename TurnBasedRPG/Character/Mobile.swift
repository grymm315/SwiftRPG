//
//  Mobile.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

///Fundamental Mobility, a hero, a monster, a npc all have basic mobilities, which are defined in this protocol
protocol Mobile {
    
    /// The name of the creature
    var name                : String { get set }  // This should be under a different protocol for thing that have names
    var mobilityDescription : String { get set }
    
    /** This allows the unit to move from room to room*/
    func move(from: RoomNode, to: RoomNode)
}

extension Mobile {
    
}


class Creature {
    
    var name : String = "Nameless thing"
    var mobilityDescription: String = "Twist and turns worse than a snake"
    
    init() {}
    init(name :String) {
        self.name = name
    }
    init(name: String, mobilityDescription: String) {
        self.name = name
        self.mobilityDescription = mobilityDescription
    }
    
    func move(from: RoomNode, to: RoomNode) {
//        if let removing = from.mob_list.firstIndex(where: {$0 === Creature.self}){
//            from.mob_list.remove(at: removing)
//            to.mob_list.append(self)
//        }
    }
}

extension Creature: Mobile {
    
}
