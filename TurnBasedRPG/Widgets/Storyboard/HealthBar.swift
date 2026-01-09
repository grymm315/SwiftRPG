//
//  HealthBar.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/1/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class HealthBar: UIView {
    
    let barFrame = CAShapeLayer()
    let barCurrent = CAShapeLayer()
    let backBar = CAShapeLayer()
    
    // Like how full is the health bar 50%?
    private var healthBarRatio:CGFloat {
        get {
            return CGFloat(_currentHealth) / CGFloat(_maxHealth)
        }
    }
    var _maxHealth: Int = 100
    var _currentHealth: Int = 100
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        barFrame.path = UIBezierPath(rect: self.bounds).cgPath
        barFrame.fillColor = self.backgroundColor?.cgColor
        barFrame.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4018122874)
        barFrame.lineWidth = 1.2
        barFrame.fillRule = .nonZero
        barFrame.cornerRadius = 20
        
        //        barFrame.superlayer?.cornerRadius = 60
        //   barCurrent.masksToBounds = true
        layer.addSublayer(barFrame)
        
        backBar.path = barFrame.path
        //        backBar.fillColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        layer.addSublayer(backBar)
        barCurrent.cornerRadius = 20
        barCurrent.path = currentPath().cgPath
        barCurrent.fillColor = self.tintColor.cgColor
        
        backBar.cornerRadius = 20
        //        barCurrent.superlayer?.cornerRadius = 120
        //barCurrent.masksToBounds = true
        layer.addSublayer(barCurrent)
        //layer.cornerRadius = 12
    }
    
    func alignHpTo(_ mob: Character) {
        _maxHealth = mob.maxHealth
        
        if (mob.currentHealth <= _currentHealth  ) {
            backBar.fillColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        } else {
            backBar.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        if (mob.currentHealth < 0){
            _currentHealth = 0
        } else {
            _currentHealth = mob.currentHealth
        }
        scale(path: barCurrent, duration: 0.2)
        scale(path: backBar, duration: 0.9)
    }
    
    func takeDamage(_ dmg: Int){
        backBar.fillColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        if (dmg < _currentHealth) {
            _currentHealth = _currentHealth - dmg }
        else {
            _currentHealth = 0
        }
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
        animation.toValue = healthBarRatio
        animation.duration = CFTimeInterval(duration)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        path.add(animation, forKey: nil)
    }
    
    func reAlign(path: CAShapeLayer){
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2
        animation.toValue = currentPath()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        path.add(animation, forKey: nil)
    }
    
    func currentPath() -> UIBezierPath{
        return UIBezierPath(rect: CGRect(origin: barFrame.bounds.origin, size: CGSize(width: self.bounds.width * healthBarRatio, height: self.bounds.height)))
    }
    
    
}
