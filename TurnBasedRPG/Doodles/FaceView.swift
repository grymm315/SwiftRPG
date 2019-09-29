//
//  FaceView.swift
//  TurnBasedRPG
//
//  Created by TACTILIS on 9/2/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
 var FaceShape:UIBezierPath = UIBezierPath()
    var reflectLine: UIBezierPath = UIBezierPath()
    var line1: UIBezierPath = UIBezierPath()
    var midline: UIBezierPath = UIBezierPath()
    var line3: UIBezierPath = UIBezierPath()
    
    var circle: UIBezierPath = UIBezierPath()

    let GR:CGFloat = 0.6180340
    
    
    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
 reflectLine.move(to: CGPoint(x: self.bounds.width / 2, y: 0))
        reflectLine.addLine(to: CGPoint(x: self.bounds.width / 2, y: self.bounds.height))
        reflectLine.stroke()
        
        let ratio:CGFloat = 1 - GR
        line1.move(to: CGPoint(x: 0, y: self.bounds.height * ratio))
        line1.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height * ratio))
        line1.stroke()
        
        let ratio2:CGFloat = GR
        midline.move(to: CGPoint(x: 0, y: self.bounds.height * ratio2))
        midline.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height * ratio2))
        midline.stroke()
        
        let ratio3:CGFloat = (self.bounds.height + (self.bounds.height * ratio2)) / 2
        
        line3.move(to: CGPoint(x: 0, y: ratio3))
        line3.addLine(to: CGPoint(x: self.bounds.width, y: ratio3))
        line3.stroke()
        
        let middle = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        circle.addArc(withCenter: middle, radius: self.bounds.width / 2 , startAngle: 0 * CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        circle.stroke()
        
        
        
    }
 

}
