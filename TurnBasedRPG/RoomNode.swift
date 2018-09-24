//
//  RoomNode.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

class RoomNode{
    
    enum direction {
        case north, south, east, west
    }
    
    var title:String = "A Room"
    var Description:String = "A Generic Room"
    
    var north:RoomNode?
    var south:RoomNode?
    var east:RoomNode?
    var west:RoomNode?
    
    var mob_list:[Mobile] = []
    
    init(name:String) {
        title = name
    }
    
    /*Creates a 2 way link between rooms*/
    func linkRoom(_ loc: direction, room: RoomNode){
        switch loc {
        case .north:
            self.north = room
            room.south = self
        case .south:
            self.south = room
            room.north = self
        case .east:
            self.east = room
            room.west = self
        case .west:
            self.west = room
            room.east = self
        default:
            print("make more directions")
        }
        
        
        
    }
    
}
