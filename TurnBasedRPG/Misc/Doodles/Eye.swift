//
//  Eye.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 8/22/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit
@IBDesignable
class Eye: UIView {

    let shapeLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    let borderLayer = CAShapeLayer()
    var eyePath = UIBezierPath()
    let pupil = CAShapeLayer()
    
    let GR:CGFloat = 0.6180340
    var height:CGFloat {return self.bounds.height}
    var width:CGFloat {return self.bounds.width}
    lazy var middle = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    var midY: CGFloat { return self.bounds.midY}
    
    var modLu = CGPoint(x: 0.5, y: 0.5)
    
    var upperLeft: CGPoint {return CGPoint(x: 0, y: midY - (modLu.y * height))}
    var upperRight: CGPoint {return CGPoint(x: width, y: 0)}
    var upperArc: CGPoint {return CGPoint(x: width / 2, y: -10) }
    
    var lowerLeft: CGPoint {return CGPoint(x: 0, y: height) }
    var lowerRight: CGPoint {return CGPoint(x: width, y: height)}
    var lowerArc: CGPoint {return CGPoint(x: width / 2, y: height + 10)}
    
    var isRight: Bool = false
    
    var top: CGFloat = 23.0

    @IBInspectable var size:CGFloat = 100
    
    func center(_ x:CGFloat, _ y:CGFloat)->CGPoint {
        let temp: CGPoint = CGPoint(x: self.bounds.midX + x, y: self.bounds.midY + y)
        return temp
    }
    
    func flerp(_ x:CGFloat, _ y:CGFloat)->CGPoint {
        let temp: CGPoint = CGPoint(x: self.bounds.origin.x + x, y: self.bounds.origin.y + (self.bounds.height / 2 ))
        return temp
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = UIColor.gray
        
        // initial shape of the view
//        rectanglePath = UIBezierPath(rect: bounds)
        
       
//        eyePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width * 0.8, height: bounds.height * 0.5))
        // Create initial shape of the view
        shapeLayer.path = customEye()//eye2()//eyeShape(width: 0.8, height: 0.5)
        shapeLayer.lineWidth = 20
        shapeLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3)
        shapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(shapeLayer)
        pupil.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: bounds.width * 0.08, y: 0), size: CGSize(width: bounds.width * 0.3, height: bounds.width * 0.3 ))).cgPath
        pupil.lineWidth = 10
        pupil.strokeColor = UIColor.blue.cgColor
        pupil.fillColor = UIColor.black.cgColor
        layer.addSublayer(pupil)
        borderLayer.path = shapeLayer.path
        borderLayer.lineWidth = 4
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(borderLayer)
        
       
        //mask layer
        maskLayer.path = shapeLayer.path
        maskLayer.position =  shapeLayer.position
        maskLayer.strokeColor = UIColor.purple.cgColor
        maskLayer.lineWidth = 4
        layer.mask = maskLayer
        
        
        
    }
    
    var EyeOffset:CGPoint = CGPoint(x: 45.0, y: -11.0)
    private var EyePositionLeft:CGPoint{ return CGPoint(x: bounds.midX - (EyeOffset.x * size / 100), y:bounds.midY + (EyeOffset.y * size / 100))}
    private var EyePositionRight:CGPoint{ return CGPoint(x: bounds.midX + (EyeOffset.x * size / 100), y:bounds.midY + (EyeOffset.y * size / 100))}
    
    func eye2() -> CGPath{
        let EyeShapeRight = UIBezierPath()
        EyeShapeRight.move(to: CGPoint(x: EyePositionRight.x - size * 0.3, y: EyePositionRight.y - size * 0.1))
        EyeShapeRight.addLine(to: CGPoint(x: EyePositionRight.x + size * 0.1, y: EyeShapeRight.currentPoint.y - size * 0.05))
        EyeShapeRight.addQuadCurve(to: CGPoint(x: EyePositionRight.x - size * 0.3, y: EyePositionRight.y - size * 0.1), controlPoint: CGPoint(x: EyePositionRight.x - size * 0.05, y: EyePositionRight.y + size * 0.15))
        return EyeShapeRight.cgPath
    }
    
    func customEye() -> CGPath {
        let eyePath = UIBezierPath()
        eyePath.move(to: upperLeft)
        eyePath.addQuadCurve(to: upperRight, controlPoint: upperArc)
        eyePath.addLine(to: lowerRight)
        eyePath.addQuadCurve(to: lowerLeft, controlPoint: lowerArc)
        eyePath.addLine(to: upperLeft)
        return eyePath.cgPath
        
    }
    
    func fdfs() -> CGPath {
        let eyePath = UIBezierPath()
        eyePath.move(to: upperLeft)
        eyePath.addQuadCurve(to: upperRight, controlPoint: upperArc)
        eyePath.addLine(to: lowerRight)
        eyePath.addQuadCurve(to: lowerLeft, controlPoint: lowerArc)
        eyePath.addLine(to: upperLeft)
        return eyePath.cgPath
        
    }
    
    func eyeShape(width: CGFloat, height: CGFloat) -> CGPath {
      //  let thing = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width * width, height: bounds.height * height))
        let thing = UIBezierPath(rect: CGRect(origin: bounds.origin, size: CGSize(width: bounds.width * width, height: bounds.height * height)))

        return thing.cgPath
    }
    
    func prepareForEditing(editing:Bool){
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2
        
        // Your new shape here
        animation.toValue = UIBezierPath(ovalIn: bounds).cgPath
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: nil)
        maskLayer.add(animation, forKey: nil)
    }
    
    func blink(){
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.toValue = 0.1
        animation.duration = 0.2
        animation.autoreverses = true
        shapeLayer.add(animation, forKey: nil)
        maskLayer.add(animation, forKey: nil)
    }
    func eyeShift(){
        
        let animation = CABasicAnimation(keyPath: "position")
       // animation.fromValue = [0, 0]
        animation.toValue = [-10, 0]
        animation.duration = 1.0
        animation.autoreverses = true
        // Your new shape here
      //  animation.toValue = eyeShape(width: 0.8, height: 0.05)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        pupil.add(animation, forKey: nil)
//maskLayer.add(animation, forKey: nil)
        
    }
    
    func takeValue(_ value1: CGFloat, _ value2: CGFloat, _ value3: CGFloat, _ value4: CGFloat, _ value5: CGFloat){
//        lowerArc = CGPoint(x: 40, y: value1)
//        lowerLeft = CGPoint(x: 0, y: value2)
//        lowerRight = CGPoint(x: 80, y: value3)
        pupil.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: value4, y: 0), size: CGSize(width: value5, height: value5))).cgPath
        shapeLayer.path = customEye()
        eyeShift()
        borderLayer.path = shapeLayer.path
        maskLayer.path = shapeLayer.path
        
    }
    func oldblink(){
        eyeShift()
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1.0
        
        // Your new shape here
        animation.toValue = eyeShape(width: 0.8, height: 0.05)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
//                animation.fillMode = CAMediaTimingFillMode.forwards
//                animation.isRemovedOnCompletion = false

        
        shapeLayer.add(animation, forKey: nil)
        maskLayer.add(animation, forKey: nil)
    }

    
    func animatePathChange(for layer: CAShapeLayer, toPath: CGPath) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1.0
        animation.fromValue = layer.path
        animation.toValue = toPath
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(animation, forKey: "path")
    }
    
    
}
