//
//  MegaMillios.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/13/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation

class MegaMillions {
    var numbers:[Int] = []
    var powerball:[Int] = []
    var winningNumbers:String = ""
    
    func setup() {
        //We are placing 70 numbers to choose from the megamillions numbers
        for num in 1...70 {
            numbers.append(num)
        }
        //The powerball number is between 1 and 25
        for pnum in 1...25 {
            powerball.append(pnum)
        }
    }
    
    func refreshnumbers() {
        
        numbers.shuffle()
        numbers.shuffle()
        numbers.shuffle()
        powerball.shuffle()
        
        let winner:String = "\(numbers[1...5]) Mega: \(powerball.randomElement() ?? 13))"
        print(winner)
        winningNumbers = winner
        
    }
    
    
}
