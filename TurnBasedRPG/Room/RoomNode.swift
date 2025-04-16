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
    var environment: RoomEnvironment = .field
    
    var mob_list:[Monster] = []
    
    init(name:String, environment: RoomEnvironment = .field, treasure: Int = 0, danger: Int = 0) {
        title = name
        self.environment = environment
        self.dangerRating = danger
        self.lootRating = treasure
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
    
    func oneWayRoom(_ loc: direction, room: RoomNode, wrongRoom: RoomNode){
        self.east = wrongRoom
        self.west = wrongRoom
        self.north = wrongRoom
        self.south = wrongRoom
        
        linkRoom(loc, room: room)
        
    }
}

enum RoomEnvironment {
    case indoors, city, field, forest, highway, industrial
}
