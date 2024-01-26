//
//  Doodle.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/3/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class Doodle: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var middle = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    
    
    func center(_ x:CGFloat, _ y:CGFloat)->CGPoint {
        let temp: CGPoint = CGPoint(x: self.bounds.midX + x, y: self.bounds.midY + y)
        return temp
    }
    
    override func draw(_ rect: CGRect) {
        
        let FaceShape = UIBezierPath()
        FaceShape.addArc(withCenter: middle, radius: 100, startAngle: 0, endAngle: 0.5 * CGFloat.pi, clockwise: true)
      //  FaceShape.addLine(to: CGPoint(x: middle.x, y: middle.y + 90))
        //FaceShape.addQuadCurve(to: CGPoint(x: middle.x + 90, y: middle.y), controlPoint: CGPoint(x: 50, y: 50))
       // FaceShape.move(to: middle)
        FaceShape.addArc(withCenter: middle, radius: 70, startAngle: 0.5 * CGFloat.pi, endAngle: 0, clockwise: false)
        FaceShape.move(to: middle)
        FaceShape.addArc(withCenter: middle, radius: 20, startAngle: 0, endAngle: 1, clockwise: true)
        FaceShape.lineCapStyle = .round
        FaceShape.lineJoinStyle = .round
        FaceShape.addQuadCurve(to: center(-10, -20), controlPoint: center(-40, 0))

        //FaceShape.addQuadCurve(to: middle, controlPoint: FaceShape.currentPoint)
        // UIColor.green.setStroke()
        UIColor.gray.setFill()
        FaceShape.lineWidth = 10
        FaceShape.stroke()
        FaceShape.move(to: center(-10, -10))
        //FaceShape.fill()
    }

}
