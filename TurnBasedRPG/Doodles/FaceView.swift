//
//  FaceView.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 9/2/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        faceShape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        faceShape.fillColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        leftEye = Eye(frame: CGRect(x: self.bounds.width * 0.04 , y: self.bounds.height * 0.383, width: self.bounds.width * 0.416, height: self.bounds.height * 0.216))
        rightEye = Eye(frame: CGRect(x: self.bounds.width * 0.54 , y: self.bounds.height * 0.383, width: self.bounds.width * 0.416, height: self.bounds.height * 0.216))
        //addSubview(faceShape)
        layer.addSublayer(faceShape)
        addSubview(leftEye)
        addSubview(rightEye)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        leftEye = Eye(frame: CGRect(x: self.bounds.width * 0.04 , y: self.bounds.height * 0.383, width: self.bounds.width * 0.416, height: self.bounds.height * 0.216))
        rightEye = Eye(frame: CGRect(x: self.bounds.width * 0.54 , y: self.bounds.height * 0.383, width: self.bounds.width * 0.416, height: self.bounds.height * 0.216))
        addSubview(leftEye)
        addSubview(rightEye)
        //fatalError("init(coder:) has not been implemented")
    }
    
// var FaceShape:UIBezierPath = UIBezierPath()
//    var reflectLine: UIBezierPath = UIBezierPath()
//    var line1: UIBezierPath = UIBezierPath()
//    var midline: UIBezierPath = UIBezierPath()
//    var line3: UIBezierPath = UIBezierPath()
    var leftEye: Eye!// = Eye(frame: CGRect(x: 12.0 , y: 115, width: 125, height: 65))
    var rightEye: Eye!// = Eye(frame: CGRect(x: 12.0, y: 115, width: 125, height: 65))
    var faceShape: CAShapeLayer = CAShapeLayer()
    var circle: UIBezierPath = UIBezierPath()

    let GR:CGFloat = 0.6180340
    
    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//
// reflectLine.move(to: CGPoint(x: self.bounds.width / 2, y: 0))
//        reflectLine.addLine(to: CGPoint(x: self.bounds.width / 2, y: self.bounds.height))
//        reflectLine.stroke()
//
//        let ratio:CGFloat = 1 - GR
//        line1.move(to: CGPoint(x: 0, y: self.bounds.height * ratio))
//        line1.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height * ratio))
//        line1.stroke()
//
//        let ratio2:CGFloat = GR
//        midline.move(to: CGPoint(x: 0, y: self.bounds.height * ratio2))
//        midline.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height * ratio2))
//        midline.stroke()
//
//        let ratio3:CGFloat = (self.bounds.height + (self.bounds.height * ratio2)) / 2
//
//        line3.move(to: CGPoint(x: 0, y: ratio3))
//        line3.addLine(to: CGPoint(x: self.bounds.width, y: ratio3))
//        line3.stroke()
//
//        let middle = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//
//        circle.addArc(withCenter: middle, radius: self.bounds.width / 2 , startAngle: 0 * CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
//
//        circle.stroke()
//    }
 

}
