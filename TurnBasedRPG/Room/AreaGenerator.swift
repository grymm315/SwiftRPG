//
//  AreaGenerator.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/30/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

//Playing with some ways to randomly generate a map
class AreaGenerator{
    
    let startRoom:RoomNode = RoomNode(name: "Begin")
    let endRoom:RoomNode = RoomNode(name: "Finish")
    let room3:RoomNode = RoomNode(name: "Walk before run")
    
    
    
    let PossibleExits = [ "n", "s", "e", "w", "ns", "ne", "nw", "nse", "nsw", "new", "sew", "ew"] //12d
    var map: [[RoomNode]] = []
    var zone :[RoomNode] = []
    
    init(size: Int){
        let currentRoom: RoomNode = startRoom
        let second: RoomNode = RoomNode(name: "A portal")
        currentRoom.linkRoom(.north, room: second)
        for rrr in 0...size {
            let newRoom = RoomNode(name: "Room# \(rrr)")
            let ra = Int.random(in: 0...10)
            switch (ra){
            case 3:
                newRoom.mob_list.append(Creature())
            case 1:
                newRoom.mob_list.append(Creature())
            case 5:
                newRoom.mob_list.append(Creature())
            default:
                break
            }
            
            
            
            findRandomEmptyNode(currentRoom, newRoom)
        }
        
    }
    
    func findRandomEmptyNode(_ current: RoomNode, _ newRoom: RoomNode){
        let selectedExit = Int.random(in: 1..<5)
        switch selectedExit {
        case 1:
            if current.north == nil{
                current.linkRoom(.north, room: newRoom)} else {
                findRandomEmptyNode(current.north!, newRoom)
            }
        case 2:
            if current.east == nil{
                current.linkRoom(.east, room: newRoom)} else {
                findRandomEmptyNode(current.east!, newRoom)
            }
        case 3:
            if current.south == nil{
                current.linkRoom(.south, room: newRoom)} else {
                findRandomEmptyNode(current.south!, newRoom)
            }
        case 4:
            if current.west == nil{
                current.linkRoom(.west, room: newRoom)} else {
                findRandomEmptyNode(current.west!, newRoom)
            }
        default:
            print("No Selections")
        }
        
    }
    init(x:Int, y:Int) {
        
        var currentRoom: RoomNode = startRoom
        //var exits: [String] = []
        
        for rrr in 0...50 {
            let newRoom = RoomNode(name: "Room# \(rrr)")
            let ra = Int.random(in: 0...2)
            for _ in 0...ra {
                newRoom.mob_list.append(Creature())
            }
            
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
