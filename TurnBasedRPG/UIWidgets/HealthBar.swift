//
//  HealthBar.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/1/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class HealthBar: UIView{
    
    let barFrame = CAShapeLayer()
    let barCurrent = CAShapeLayer()
    let backBar = CAShapeLayer()
    private var currentHealth:CGFloat {
        get {
            return CGFloat(_currentHealth) / CGFloat(_maxHealth)
        }
    }
    var _maxHealth: Int = 100
    var _currentHealth: Int = 100
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        barFrame.path = UIBezierPath(rect: self.bounds).cgPath
        barFrame.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        barFrame.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        barFrame.lineWidth = 2
        layer.addSublayer(barFrame)
        
        backBar.path = barFrame.path
//        backBar.fillColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        layer.addSublayer(backBar)
        barCurrent.path = currentPath().cgPath
        barCurrent.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.addSublayer(barCurrent)
    }
    
    func takeDamage(_ dmg: Int){
        backBar.fillColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        _currentHealth = _currentHealth - dmg
        scale(path: barCurrent, duration: 0.2)
        scale(path: backBar, duration: 0.9)
        
    }
    
    func heal(_ amt: Int){
        backBar.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        _currentHealth = _currentHealth + amt
        if (_currentHealth > _maxHealth){
            _currentHealth = _maxHealth
        }
        scale(path: backBar, duration: 0.2)
        scale(path: barCurrent, duration: 0.9)
    }
    
    func scale(path: CAShapeLayer, duration: CGFloat){
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.toValue = currentHealth
        animation.duration = CFTimeInterval(duration)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        path.add(animation, forKey: nil)
        
      //  animation.autoreverses = true
//        shapeLayer.add(animation, forKey: nil)
//        maskLayer.add(animation, forKey: nil)
    }
    
    func reAlign(path: CAShapeLayer){
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2
        
        // Your new shape here
        animation.toValue = currentPath()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
       // animation.
        
        path.add(animation, forKey: nil)
        
    }
    
    func currentPath() -> UIBezierPath{
       return UIBezierPath(rect: CGRect(origin: barFrame.bounds.origin, size: CGSize(width: self.bounds.width * currentHealth, height: self.bounds.height)))
    }
    
//    override func draw(_ rect: CGRect) {
//
//        let maxHealth: UIBezierPath = UIBezierPath(rect: self.bounds)
//        UIColor.black.setFill()
//        UIColor.white.setStroke()
//        maxHealth.lineWidth = 2
//        maxHealth.fill()
//        maxHealth.stroke()
//
//        let hp:UIBezierPath = UIBezierPath(rect: CGRect(origin: maxHealth.bounds.origin, size: CGSize(width: self.bounds.width * currentHealth, height: self.bounds.height)))
//
//        UIColor.white.setFill()
//        hp.fill()
//    }
    
    
}
