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
    
    let startRoom:RoomNode = RoomNode(name: "s2", environment: .industrial, treasure: 7, danger: 7)
    let reactorRoom:RoomNode = RoomNode(name: "s3", environment: .industrial, treasure: 7, danger: 7)
    let diningRoom:RoomNode = RoomNode(name: "ew4", environment: .indoors, treasure: 4, danger: 1)
    let flightdeck:RoomNode = RoomNode(name: "nwe2", environment: .indoors, treasure: 3, danger: 2)
    let furnaceInside:RoomNode = RoomNode(name: "FurnaceInside", environment: .industrial, treasure: 6, danger: 5)
    let furnaceOutside:RoomNode = RoomNode(name: "ew6", environment: .industrial, treasure: 6, danger: 3)
    
    let gateOpening:RoomNode = RoomNode(name: "GateOpening", environment: .highway, treasure: 3, danger: 2)
    
    let cityRoad1:RoomNode = RoomNode(name: "CityRoad1", environment: .highway, treasure: 3, danger: 2)
    let downtown4:RoomNode = RoomNode(name: "nw", environment: .city, treasure: 6, danger: 2)
    let downtown5:RoomNode = RoomNode(name: "ns5", environment: .city, treasure: 3, danger: 2)
    let downtownSheriff:RoomNode = RoomNode(name: "ns", environment: .city, treasure: 3, danger: 0)
    
    let street1:RoomNode = RoomNode(name: "ns", environment: .highway, treasure: 3, danger: 2)
    let street2:RoomNode = RoomNode(name: "se2", environment: .highway, treasure: 3, danger: 2)
    let street3:RoomNode = RoomNode(name: "nsw", environment: .highway, treasure: 3, danger: 2)
    let toriiGate2:RoomNode = RoomNode(name: "ToriiGate2", environment: .highway, treasure: 8, danger: 2)
    let toriiGate1:RoomNode = RoomNode(name: "ne1", environment: .highway, treasure: 8, danger: 2)
    let roadToTower:RoomNode = RoomNode(name: "nse", environment: .highway, treasure: 3, danger: 4)
    
    let town:RoomNode = RoomNode(name: "ns3", environment: .city, treasure: 3, danger: 3)
    
    let woods:RoomNode = RoomNode(name: "nse1", environment: .forest, treasure: 3, danger: 3)
    let woods2:RoomNode = RoomNode(name: "se1", environment: .forest, treasure: 3, danger: 3)
    let woods3:RoomNode = RoomNode(name: "nw", environment: .forest, treasure: 3, danger: 3)
    let woods4:RoomNode = RoomNode(name: "sw2", environment: .forest, treasure: 3, danger: 3)
    let woods5:RoomNode = RoomNode(name: "ne1", environment: .forest, treasure: 3, danger: 3)
    let darkwoods:RoomNode = RoomNode(name: "ds", environment: .forest, treasure: 3, danger: 10)
    let lightwoods:RoomNode = RoomNode(name: "lightwoods", environment: .forest, treasure: 3, danger: 10)
    
    let cabin1:RoomNode = RoomNode(name: "w1", environment: .forest, treasure: 3, danger: 3)
    let cabin2:RoomNode = RoomNode(name: "e4", environment: .forest, treasure: 3, danger: 3)

    let cabindoor:RoomNode = RoomNode(name: "cabindoor", environment: .forest, treasure: 3, danger: 3)

    let cabinWoods:RoomNode = RoomNode(name: "nsew", environment: .forest, treasure: 3, danger: 3)

    //new
    let forest1:RoomNode = RoomNode(name: "ns2", environment: .forest, treasure: 3, danger: 3)
    let forest2:RoomNode = RoomNode(name: "w2", environment: .forest, treasure: 3, danger: 3)
    let forest3:RoomNode = RoomNode(name: "w3", environment: .forest, treasure: 3, danger: 3)
    let forest4:RoomNode = RoomNode(name: "n", environment: .forest, treasure: 3, danger: 3)
    let forest5:RoomNode = RoomNode(name: "nsew3", environment: .forest, treasure: 3, danger: 3)
    let forest6:RoomNode = RoomNode(name: "nsew", environment: .forest, treasure: 3, danger: 3)
    let forest7:RoomNode = RoomNode(name: "nsew2", environment: .forest, treasure: 3, danger: 3)
    let forest8:RoomNode = RoomNode(name: "e3", environment: .forest, treasure: 3, danger: 3)
    
    let bedroom1:RoomNode = RoomNode(name: "e", environment: .city, treasure: 6, danger: 2)
    let bedroom2:RoomNode = RoomNode(name: "w1", environment: .city, treasure: 3, danger: 2)
    let bedroom3:RoomNode = RoomNode(name: "e1", environment: .city, treasure: 3, danger: 2)
    let house1:RoomNode = RoomNode(name: "nsew5", environment: .city, treasure: 6, danger: 2)
    let house2:RoomNode = RoomNode(name: "ew2", environment: .city, treasure: 3, danger: 2)
    let house3:RoomNode = RoomNode(name: "ew", environment: .city, treasure: 3, danger: 2)
    
    let street3way:RoomNode = RoomNode(name: "swe1", environment: .city, treasure: 6, danger: 2)
    let narrowstreet:RoomNode = RoomNode(name: "ew2", environment: .city, treasure: 3, danger: 2)
    let minimart:RoomNode = RoomNode(name: "w1", environment: .city, treasure: 3, danger: 2)
    
    
    let PossibleExits = [ "n", "s", "e", "w", "ns", "ne", "nw", "nse", "nsw", "new", "sew", "ew"] //12d
    var map: [[RoomNode]] = []
    var zone :[RoomNode] = []
    
    // For something not random
    init(name: String){
        
        bedroom3.linkRoom(.east, room: house3)
        bedroom3.mob_list.append(Monster.merchant)
        house3.linkRoom(.east, room: street3way)
        street3way.linkRoom(.east, room: narrowstreet)
        narrowstreet.linkRoom(.east, room: minimart)
        street3way.linkRoom(.south, room: house1)
        street3way.event_list = SearchEncounters.barrel.instance
        house1.linkRoom(.east, room: house2)
        house2.linkRoom(.east, room: bedroom2)
        house1.linkRoom(.west, room: bedroom1)
        house1.linkRoom(.south, room: forest5)
        house1.event_list = SearchEncounters.alcove2.instance
        
        forest5.linkRoom(.east, room: forest5)
        forest5.linkRoom(.south, room: forest7)
        forest7.linkRoom(.south, room: forest1)
        forest7.linkRoom(.west, room: woods)
        woods.event_list = SearchEncounters.alcove2.instance
        forest7.linkRoom(.east, room: forest2)
        
        forest1.linkRoom(.south, room: forest6)
        forest6.linkRoom(.south, room: forest4)
        forest6.linkRoom(.east, room: forest3)
        forest6.linkRoom(.west, room: forest8)

        
        flightdeck.linkRoom(.east, room: diningRoom)
        flightdeck.linkRoom(.west, room: furnaceOutside)
        flightdeck.linkRoom(.north, room: startRoom)
        
        diningRoom.linkRoom(.east, room: street3)
        street3.event_list = SearchEncounters.barrel.instance
        street3.linkRoom(.north, room: downtown5)
        downtown5.linkRoom(.north, room: town)
        town.linkRoom(.north, room: woods)
        woods.linkRoom(.north, room: woods2)
        woods2.linkRoom(.east, room: woods3)
        
        woods3.linkRoom(.north, room: woods4)
        woods4.linkRoom(.west, room: woods5)
        woods5.linkRoom(.north, room: cabinWoods)
        cabinWoods.linkRoom(.east, room: cabin1)
        cabin1.event_list = SearchEncounters.alcove2.instance
        bedroom2.event_list = SearchEncounters.alcove2.instance
        minimart.event_list = SearchEncounters.alcove2.instance


        cabinWoods.linkRoom(.west, room: cabin2)
        cabinWoods.linkRoom(.north, room: darkwoods)
        darkwoods.event_list = SearchEncounters.door.instance
        
        street3.linkRoom(.south, room: toriiGate2)
        //The new images are not rendering when linked together
        //However going through one of the older images will always
        //reset the view correctly
        street2.linkRoom(.east, room: furnaceOutside)
        street1.linkRoom(.north, room: street2)
        street1.linkRoom(.south, room: roadToTower)
        roadToTower.linkRoom(.south, room: toriiGate1)
        roadToTower.linkRoom(.east, room: toriiGate2)
        roadToTower.event_list = SearchEncounters.barrel.instance
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
                newRoom.mob_list.append(Monster.Goblin)
            case 1:
                newRoom.mob_list.append(Monster.LoneWolf)
            case 5:
                newRoom.mob_list.append(Monster.dog)
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
                newRoom.mob_list.append(Monster.ghost)
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
