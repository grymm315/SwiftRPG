//
//  Mobile.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

/** Fundamental Mobile Unit, this could be a hero, monster, npc*/
class Mobile {
    
    var name:String = "Generic"/**< The name of the creature */
    var description:String = "Description" /**< The Description of the creature */
    
    /** This allows the unit to move from room to room*/
    func move(from: RoomNode, to: RoomNode){
        if let removing = from.mob_list.index(where: {$0 === self}){
            from.mob_list.remove(at: removing)
            to.mob_list.append(self)
        }
    }
}
