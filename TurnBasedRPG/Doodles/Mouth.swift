//
//  Mouth.swift
//  TurnBasedRPG
//
//  Created by TACTILIS on 9/29/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

class Mouth: UIView {

    let mShape = CAShapeLayer()
    var height:CGFloat {return self.bounds.height}
    var width:CGFloat {return self.bounds.width}
    
    var upperArc: CGPoint {return CGPoint(x: width / 2, y: (height / 2) - 10) }
    var lowerArc: CGPoint {return CGPoint(x: width / 2, y: (height / 2) + 10)}
    var right: CGPoint {return CGPoint(x: width, y: height / 2)}
    var left: CGPoint {return CGPoint(x: 0, y: height / 2)}

    
    let GR:CGFloat = 0.6180340
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        
        
    }
    
    func getPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: left)
        path.addQuadCurve(to: right, controlPoint: upperArc)
        path.addQuadCurve(to: left, controlPoint: lowerArc)
        
        
        return path.cgPath
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
