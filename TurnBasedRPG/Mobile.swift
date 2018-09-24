//
//  Mobile.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation

class Mobile {
    
    var name:String = "Generic"
    var description:String = "Description"
    
    
    func move(from: RoomNode, to: RoomNode){
        if let removing = from.mob_list.index(where: {$0 === self}){
            from.mob_list.remove(at: removing)
            to.mob_list.append(self)
        }
        
        
        
    }
    
    
}
