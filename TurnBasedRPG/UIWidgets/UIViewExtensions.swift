//
//  UIViewExtensions.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/20/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shakeHorizontal(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - intensity, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + intensity, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func shakeVertical(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - intensity))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y + intensity))
        self.layer.add(animation, forKey: "position")
    }
}
