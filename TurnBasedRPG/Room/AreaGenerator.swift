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
    
    let startRoom:RoomNode = RoomNode(name: "ReactorRoom", environment: .industrial, treasure: 7, danger: 7)
    let reactorRoom:RoomNode = RoomNode(name: "ReactorRoom", environment: .industrial, treasure: 7, danger: 7)
    let diningRoom:RoomNode = RoomNode(name: "DiningRoom", environment: .insideBuilding, treasure: 4, danger: 1)
    let flightdeck:RoomNode = RoomNode(name: "Flightdeck", environment: .insideBuilding, treasure: 3, danger: 2)
    let furnaceInside:RoomNode = RoomNode(name: "FurnaceInside", environment: .industrial, treasure: 6, danger: 5)
    let furnaceOutside:RoomNode = RoomNode(name: "FurnaceOutside", environment: .industrial, treasure: 6, danger: 3)
    
    let gateOpening:RoomNode = RoomNode(name: "GateOpening", environment: .highway, treasure: 3, danger: 2)
    
    let cityRoad1:RoomNode = RoomNode(name: "CityRoad1", environment: .highway, treasure: 3, danger: 2)
    let downtown4:RoomNode = RoomNode(name: "Downtown4", environment: .city, treasure: 6, danger: 2)
    let downtown5:RoomNode = RoomNode(name: "Downtown5", environment: .city, treasure: 3, danger: 2)
    let downtownSheriff:RoomNode = RoomNode(name: "DowntownSheriff", environment: .city, treasure: 3, danger: 0)
    
    let street1:RoomNode = RoomNode(name: "Street1", environment: .highway, treasure: 3, danger: 2)
    let street2:RoomNode = RoomNode(name: "Street2", environment: .highway, treasure: 3, danger: 2)
    let street3:RoomNode = RoomNode(name: "Street3", environment: .highway, treasure: 3, danger: 2)
    let toriiGate2:RoomNode = RoomNode(name: "ToriiGate2", environment: .highway, treasure: 8, danger: 2)
    let toriiGate1:RoomNode = RoomNode(name: "TorriGate1", environment: .highway, treasure: 8, danger: 2)
    let roadToTower:RoomNode = RoomNode(name: "RoadToTower", environment: .highway, treasure: 3, danger: 4)
    
    let town:RoomNode = RoomNode(name: "Town", environment: .forest, treasure: 3, danger: 3)
    
    let woods:RoomNode = RoomNode(name: "woods", environment: .forest, treasure: 3, danger: 3)
    let woods2:RoomNode = RoomNode(name: "woods2", environment: .forest, treasure: 3, danger: 3)
    let woods3:RoomNode = RoomNode(name: "woods3", environment: .forest, treasure: 3, danger: 3)
    let woods4:RoomNode = RoomNode(name: "woods4", environment: .forest, treasure: 3, danger: 3)
    let woods5:RoomNode = RoomNode(name: "woods5", environment: .forest, treasure: 3, danger: 3)
    let darkwoods:RoomNode = RoomNode(name: "darkwoods", environment: .forest, treasure: 3, danger: 10)
    let lightwoods:RoomNode = RoomNode(name: "lightwoods", environment: .forest, treasure: 3, danger: 10)
    
    let cabin1:RoomNode = RoomNode(name: "cabin1", environment: .forest, treasure: 3, danger: 3)
    let cabin2:RoomNode = RoomNode(name: "cabin2", environment: .forest, treasure: 3, danger: 3)

    let cabindoor:RoomNode = RoomNode(name: "cabindoor", environment: .forest, treasure: 3, danger: 3)

    let cabinWoods:RoomNode = RoomNode(name: "woodscabin", environment: .forest, treasure: 3, danger: 3)

    
    
    
    let PossibleExits = [ "n", "s", "e", "w", "ns", "ne", "nw", "nse", "nsw", "new", "sew", "ew"] //12d
    var map: [[RoomNode]] = []
    var zone :[RoomNode] = []
    
    // For something not random
    init(name: String){
        flightdeck.linkRoom(.east, room: diningRoom)
        flightdeck.linkRoom(.west, room: furnaceOutside)
        flightdeck.linkRoom(.north, room: startRoom)
        
        diningRoom.linkRoom(.east, room: street3)
        street3.linkRoom(.north, room: downtown5)
        downtown5.linkRoom(.north, room: town)
        town.linkRoom(.north, room: woods)
        woods.linkRoom(.north, room: woods2)
        woods2.oneWayRoom(.east, room: woods3, wrongRoom: woods)
        woods3.oneWayRoom(.north, room: woods4, wrongRoom: woods)
        woods4.oneWayRoom(.west, room: woods5, wrongRoom: woods)
        woods5.oneWayRoom(.north, room: cabinWoods, wrongRoom: woods)
        cabinWoods.linkRoom(.east, room: cabin1)
        cabinWoods.linkRoom(.west, room: cabin2)


        
        
        street3.linkRoom(.south, room: toriiGate2)
        //The new images are not rendering when linked together
        //However going through one of the older images will always
        //reset the view correctly
        street2.linkRoom(.east, room: furnaceOutside)
        street1.linkRoom(.north, room: street2)
        street1.linkRoom(.south, room: roadToTower)
        roadToTower.linkRoom(.south, room: toriiGate1)
        roadToTower.linkRoom(.east, room: toriiGate2)
        toriiGate1.linkRoom(.east, room: downtown4)
        downtown4.linkRoom(.north, room: downtownSheriff)
        toriiGate2.linkRoom(.south, room: downtownSheriff)
    }
    
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
