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
    
    let startRoom:RoomNode = RoomNode(name: """
 The ship lay in darkness, devoid of any signs of life. The occasional creak echoed through the empty vessel as the wind shifted and caused parts of the ship to flex. Its age was apparent, with the sails in tatters from constant exposure to the elements, leaving only a few fragments hanging by a thread. Once more, the old ship groaned, having been undisturbed for what seemed like an eternity. The decks had not seen a human footstep in a long time.
        
        The ship hovered in the sky at the very edge of the world. One half of the vessel faced a stunning expanse of crystal blue waters stretching out to the horizon, adorned with a handful of picturesque islands. The other half of the ship was exposed to the void, an endless sea of black nothingness. Gazing out from the front or back of the ship revealed the stark contrast between the sea of water and the sea of nothing, where the two met in a visible divide.

        The water fell off the edge and turned to mist and clouds. But if you continued to look down into the black void of nothing, deep into the darkness, sometimes the darkness would stare back up at you. A sane person would not tempt the attention of the things down there, for they might crawl up the side of the world and deliver oblivion in their wake.
""")
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
