//
//  RoomNode.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

protocol updateProtocol {
    func updateLabel(name:String)
    func updateTime(seconds:Int)
}

class RoomNode {
    
    enum direction {
        case north, south, east, west
    }
    
    var title:String = "A Room"
    var Description:String = "A Generic Room"
    var imgName:String?
    
    var north:RoomNode?
    var south:RoomNode?
    var east:RoomNode?
    var west:RoomNode?
    
    var dangerRating: Int = 0
    var lootRating: Int = 0
    var environment: String = ""
    
    var mob_list:[Creature] = []
    
    init(name:String) {
        title = name
    }
    
    /** Creates a 2 way link between rooms */
    func linkRoom(_ loc: direction, room: RoomNode){
        
        switch loc {
        case .north:
            self.north = room
            room.south = self
            print("Created newRoom to the North")
        case .south:
            self.south = room
            room.north = self
            print("Created newRoom to the South")
        case .east:
            self.east = room
            room.west = self
            print("Created newRoom to the East")
        case .west:
            self.west = room
            room.east = self
            print("Created newRoom to the West")
            
        }
    }
    
}
