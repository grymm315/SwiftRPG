//
//  FaceBuilder.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 9/1/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class Face:UIView {
    
    var EyeOffset:CGPoint = CGPoint(x: 45.0, y: -11.0)
    private var EyePositionLeft:CGPoint{ return CGPoint(x: bounds.midX - (EyeOffset.x * size / 100), y:bounds.midY + (EyeOffset.y * size / 100))}
    private var EyePositionRight:CGPoint{ return CGPoint(x: bounds.midX + (EyeOffset.x * size / 100), y:bounds.midY + (EyeOffset.y * size / 100))}
    var NosePosition:CGPoint { return CGPoint(x: bounds.midX - (size * 0.05), y:bounds.midY + (size * 0.2))}
    var MouthPosition:CGPoint { return CGPoint(x: bounds.midX, y:bounds.midY + (size * 0.2))}
    var FacePosition:CGPoint {return CGPoint(x: self.bounds.midX, y: self.bounds.midY)}
    
    @IBInspectable var right:CGFloat = 0.2
    @IBInspectable var left: CGFloat = 0.8
    lazy var size: CGFloat = bounds.width / 3.14
    
    
    
    var EyeShapeLeft:UIBezierPath = UIBezierPath()
    var EyeShapeRight:UIBezierPath = UIBezierPath()
    var NoseShape:UIBezierPath = UIBezierPath()
    var MouthShape:UIBezierPath = UIBezierPath()
    var FaceShape:UIBezierPath = UIBezierPath()
    var teeth: UIBezierPath = UIBezierPath()
    var ears: UIBezierPath = UIBezierPath()
    
    lazy var health = HealthBar()
    var testView : UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20)))
   
    
    override init(frame: CGRect) {
       super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        health.bounds = CGRect(x: 0, y: 0, width: self.bounds.width/2, height: 20)
        health.frame.origin.x = self.bounds.width / 4
        health.backgroundColor = UIColor.gray
     //   self.backgroundColor = UIColor.clear
        self.addSubview(health)
    }
    /* Returns a CGPoint that uses the center of the view as (0 ,0) which is helpful for using a trigonometric Unit circle*/
    func fromCenter(_ x:CGFloat, _ y:CGFloat)->CGPoint {
        let temp: CGPoint = CGPoint(x: self.bounds.midX + x, y: self.bounds.midY + y)
        return temp
    }
    
    override func draw(_ rect: CGRect) {

        ears.move(to: fromCenter(0, 0))
        ears.addLine(to: fromCenter(-1.1 * size, 0.1 * size))
        ears.addLine(to: fromCenter(-1.3 * size, -1 * size))
        ears.addLine(to: fromCenter(0, 0))
        ears.addLine(to: fromCenter(1.1 * size, 0.1 * size))
        ears.addLine(to: fromCenter(1.3 * size, -1 * size))
        ears.addLine(to: fromCenter(0, 0))
        UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0).setFill()
        ears.fill()
        
        ears.stroke()
        
        FaceShape.addArc(withCenter: FacePosition, radius: size, startAngle: 0.9 * CGFloat.pi, endAngle: 0.1 * CGFloat.pi, clockwise: true)
        FaceShape.addQuadCurve(to: fromCenter(cos(0.9 * CGFloat.pi) * size , sin(0.9 * CGFloat.pi) * size), controlPoint: fromCenter(size  * -0.1, size * 1.7))
        //UIColor.black.setStroke()
            UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0).setFill()
        
            //UIColor.green.setFill()
            FaceShape.lineWidth = 2
            FaceShape.stroke()
            FaceShape.fill()
        
        NoseShape.move(to: NosePosition)
        NoseShape.addLine(to: CGPoint(x: NoseShape.currentPoint.x - size * 0.3, y: NoseShape.currentPoint.y + size * 0.1))
        NoseShape.addLine(to: CGPoint(x: NosePosition.x, y: NosePosition.y - size * 0.2))
        NoseShape.lineWidth = 5
        UIColor(red: 0, green: 0.3, blue: 0, alpha: 1.0).setStroke()
        NoseShape.lineJoinStyle = .round
        NoseShape.lineCapStyle = .round
        UIColor.black.setFill()
        NoseShape.stroke()
       // NoseShape.fill()
        
        MouthShape.move(to: CGPoint(x: bounds.midX - size * 0.5, y: bounds.midY + size * 0.4))
        teeth.move(to: CGPoint(x: bounds.midX - size * 0.5, y: bounds.midY + size * 0.4))
        for _ in 0...7 {
        MouthShape.addLine(to: CGPoint(x: MouthShape.currentPoint.x + size * 0.05, y: MouthShape.currentPoint.y + size * 0.05))
            MouthShape.addLine(to: CGPoint(x: MouthShape.currentPoint.x + size * 0.05, y: MouthShape.currentPoint.y - size * 0.05))}
        
        teeth.addLine(to: MouthShape.cgPath.currentPoint)
        MouthShape.addLine(to: CGPoint(x: MouthShape.currentPoint.x - size * 0.1, y: MouthShape.currentPoint.y + size * 0.2))
        
        teeth.addLine(to: MouthShape.cgPath.currentPoint)
        teeth.addLine(to: CGPoint(x: MouthShape.currentPoint.x - size * 0.05, y: MouthShape.currentPoint.y + size * 0.05))
        for _ in 0...5 {
            MouthShape.addLine(to: CGPoint(x: MouthShape.currentPoint.x - size * 0.05, y: MouthShape.currentPoint.y + size * 0.05))
            MouthShape.addLine(to: CGPoint(x: MouthShape.currentPoint.x - size * 0.05, y: MouthShape.currentPoint.y - size * 0.05))}
        teeth.addLine(to: CGPoint(x: MouthShape.currentPoint.x + size * 0.05, y: MouthShape.currentPoint.y + size * 0.05))

        UIColor.black.setFill()
        //MouthShape.addClip()
        MouthShape.stroke()
        MouthShape.fill()
        teeth.stroke()
        
        EyeShapeRight.move(to: CGPoint(x: EyePositionRight.x - size * 0.3, y: EyePositionRight.y - size * 0.1))
        EyeShapeRight.addLine(to: CGPoint(x: EyePositionRight.x + 30, y: EyeShapeRight.currentPoint.y - size * 0.05))
        EyeShapeRight.addQuadCurve(to: CGPoint(x: EyePositionRight.x - size * 0.3, y: EyePositionRight.y - size * 0.1), controlPoint: CGPoint(x: EyePositionRight.x - size * 0.05, y: EyePositionRight.y + size * 0.15))
        EyeShapeRight.lineCapStyle = .round
        EyeShapeRight.lineWidth = 3
        UIColor.black.setStroke()
        UIColor.red.setFill()
        EyeShapeRight.stroke()
        EyeShapeRight.fill()
        
        EyeShapeLeft.move(to: CGPoint(x: EyePositionLeft.x + size * 0.3, y: EyePositionLeft.y - size * 0.1))
        EyeShapeLeft.addLine(to: CGPoint(x: EyePositionLeft.x - 30, y: EyeShapeLeft.currentPoint.y - size * 0.05))
        EyeShapeLeft.addQuadCurve(to: CGPoint(x: EyePositionLeft.x + size * 0.3, y: EyePositionLeft.y - size * 0.1), controlPoint: CGPoint(x: EyePositionLeft.x + size * 0.05, y: EyePositionLeft.y + size * 0.15))
        //EyeShapeLeft.addArc(withCenter: EyePositionLeft, radius: size * 0.1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        EyeShapeLeft.lineWidth = 3
        UIColor.black.setStroke()
        UIColor.red.setFill()
        EyeShapeLeft.lineCapStyle = .round
        EyeShapeLeft.stroke()
        EyeShapeLeft.fill()
        self.backgroundColor = UIColor.clear
        health.setNeedsDisplay()
        
    }
}
