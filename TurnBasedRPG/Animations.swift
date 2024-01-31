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
    /** This will cause the view to shake left and right.*/
    func shake(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - intensity, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + intensity, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    /** This will move the view up or down. and then the view will return to position*/
    func nudgeHorizontal(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + intensity, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    /** This will move the view left or right. and then the view will return to position*/
    func nudgeVertical(_ intensity:Double = 10){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - intensity))
        self.layer.add(animation, forKey: "position")
    }
    
    /** This will cause the view to fade out over a duration*/
    func fadeOut(_ duration:Double = 2){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.autoreverses = true
        animation.fromValue = self.layer.opacity
        animation.toValue = 0
        self.layer.add(animation, forKey: "opacity")
    }
    /** This will cause the view to continiously rotate*/
    func rotate() {
        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.transform = self.transform.rotated(by: -20.0 * 3.14/180.0)
          })
//           let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//            print()
////        rotation.fromValue = rotation.val
//        rotation.toValue = CGFloat(.pi * -0.2)
//           rotation.duration = 1
//           rotation.isCumulative = true
//            rotation.isRemovedOnCompletion = false
//        rotation.isAdditive = false
//        rotation.fillMode = CAMediaTimingFillMode.forwards
////        rotation
////           rotation.repeatCount = Float.greatestFiniteMagnitude
//           self.layer.add(rotation, forKey: "rotationAnimation")
       }
    
    /** This will cause the view to fade in over a duration*/
    func fadeIn(_ duration:Double = 2){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        self.layer.add(animation, forKey: "opacity")
    }
    
    /** This will stretch the view */
    func stretchHorizontal(){
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fromValue = 1
        animation.toValue = 2
        self.layer.add(animation, forKey: "transform.scale.x")
    }
    
    /** This will stretch the view */
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
    
    // This is broken... may need to be applied directly to a UIBezierPath
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
