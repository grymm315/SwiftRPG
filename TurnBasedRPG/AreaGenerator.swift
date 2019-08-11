//
//  AreaGenerator.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/30/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

class AreaGenerator{
    
    let startRoom:RoomNode = RoomNode(name: "Begin")
    let endRoom:RoomNode = RoomNode(name: "Finish")
    let room3:RoomNode = RoomNode(name: "Walk before run")
    
   
    
    let PossibleExits = [ "n", "s", "e", "w", "ns", "ne", "nw", "nse", "nsw", "new", "sew", "ew"] //12d
    var map: [[RoomNode]] = []
    var zone :[RoomNode] = []
    
    init(x:Int, y:Int) {
        
        
        
        var currentRoom: RoomNode = startRoom
        var exits: [String] = []
        
        for rrr in 0...50 {
            let newRoom = RoomNode(name: "Room# \(rrr)")
            
            
            let selectedExit = Int.random(in: 1..<5)
            switch selectedExit {
            case 1:
                currentRoom.linkRoom(.north, room: newRoom)
            case 2:
                currentRoom.linkRoom(.east, room: newRoom)
            case 3:
                currentRoom.linkRoom(.south, room: newRoom)
            case 4:
                currentRoom.linkRoom(.west, room: newRoom)
            default:
                print("No Selections")
            }
            currentRoom = newRoom
        }

    }
    
    func method1(){
        
        
    }
    
    
}
