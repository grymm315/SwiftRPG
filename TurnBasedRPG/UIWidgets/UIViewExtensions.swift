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
    func shake(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - intensity, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + intensity, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func nudgeHorizontal(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + intensity, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func nudgeVertical(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - intensity))
        self.layer.add(animation, forKey: "position")
    }
    func fadeOut(_ duration:Double = 2){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.autoreverses = true
        animation.fromValue = self.layer.opacity
        animation.toValue = 0
        self.layer.add(animation, forKey: "opacity")
    }
    
    func fadeIn(_ duration:Double = 2){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        self.layer.add(animation, forKey: "opacity")
    }
    
    func stretchHorizontal(){
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fromValue = 1
        animation.toValue = 2
        self.layer.add(animation, forKey: "transform.scale.x")
    }
    
    func stretchVertical(){
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.fromValue = 1
        animation.toValue = 2
        self.layer.add(animation, forKey: "transform.scale.y")
    }
    
    func scale(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 2
        self.layer.add(animation, forKey: "transform.scale")
    }
    
    func shrink(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.75
        animation.autoreverses = true
        animation.duration = 0.1
        self.layer.add(animation, forKey: "transform.scale")
    }
    
    func animateBorderWidth(toValue: CGFloat, duration: Double = 0.3) {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
      }
    
    func animateStrokeEnd(_ duration:CGFloat = 4.0){
        let anim1 = CABasicAnimation(keyPath: "strokeEnd")
        anim1.fromValue         = 0.0
        anim1.toValue           = 1.0
        anim1.duration          = duration
        anim1.repeatCount       = 1
        anim1.autoreverses      = true
        anim1.isRemovedOnCompletion = false
        anim1.isAdditive = true
        anim1.fillMode = CAMediaTimingFillMode.forwards
    
        self.layer.add(anim1, forKey: "line")
    }
    
    func fromBottom(_ animationSpeed: CGFloat){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + UIScreen.main.bounds.height)
        UIView.animate(withDuration: animationSpeed, animations: {
            self.frame.origin = returnHere
        })
    }
    
    
    func fromLeft(_ animationSpeed: CGFloat){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: -self.frame.origin.x, y: self.frame.origin.y)
        UIView.animate(withDuration: animationSpeed, animations: {
            self.frame.origin = returnHere
        })
    }
    
    func fromRight(_ animationSpeed: CGFloat){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x + UIScreen.main.bounds.width, y: self.frame.origin.y)
        UIView.animate(withDuration: animationSpeed, animations: {
            self.frame.origin = returnHere
        })
    }
    func fromTop(_ animationSpeed: CGFloat){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: -self.frame.origin.y)
        UIView.animate(withDuration: animationSpeed, animations: {
            self.frame.origin = returnHere
        })
    }
}
