//
//  Doodle.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/3/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class Burst: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var middle = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    @IBInspectable var size:CGFloat = 30.0
    
    func center(_ x:CGFloat, _ y:CGFloat)->CGPoint {
        let temp: CGPoint = CGPoint(x: self.bounds.midX + x, y: self.bounds.midY + y)
        return temp
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
      //stride(from: 0, to: 10, by: 2).forEach()
        let concentricCircles = UIBezierPath()
      //  FaceShape.addArc(withCenter: middle, radius: 100, startAngle: 0, endAngle: 0.5 * CGFloat.pi, clockwise: true)
        for i in 1...5 {
            concentricCircles.move(to: center(CGFloat(30 * i), 0.0))
            concentricCircles.addArc(withCenter: middle, radius: CGFloat(30 * i), startAngle: 0 * CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        }
        concentricCircles.lineCapStyle = .round
        concentricCircles.lineJoinStyle = .round
        UIColor.blue.setStroke()
        UIColor.yellow.setFill()
        concentricCircles.lineWidth = 15
        concentricCircles.fill()
        concentricCircles.stroke()
    }

}
