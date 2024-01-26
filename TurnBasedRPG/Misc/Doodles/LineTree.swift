//
//  LineTree.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 4/10/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import UIKit
@IBDesignable
class LineTree: UIView {

    var trunk = CAShapeLayer()
    var leaves = CAShapeLayer()
    var windX: CGFloat = 0
    var windY: CGFloat = 0
    
    
     override func didMoveToSuperview() {
            super.didMoveToSuperview()
            
            backgroundColor = UIColor.clear
            
            // initial shape of the view
    //        rectanglePath = UIBezierPath(rect: bounds)
            
           
    //        eyePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width * 0.8, height: bounds.height * 0.5))
            
            trunk.path = getTrunkPath()//eye2()//eyeShape(width: 0.8, height: 0.5)
            trunk.lineWidth = 5
            trunk.strokeColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            trunk.fillColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            layer.addSublayer(trunk)
        
        leaves.path = getLeaves()
        leaves.lineWidth = 6
        leaves.strokeColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        leaves.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        layer.addSublayer(leaves)
        
    
        }
    
    func getTrunkPath() -> CGPath {
        let trunkPath = UIBezierPath()
        trunkPath.move(to: CGPoint(x: bounds.width / 2 * 0.49 , y: bounds.height))
        trunkPath.addLine(to: CGPoint(x: (bounds.width / 2) + windX , y: 20 + windY))
        
        trunkPath.addLine(to: CGPoint(x: bounds.width / 2 , y: bounds.height))
        
              return trunkPath.cgPath
    }
    
    func getLeaves() -> CGPath {
        let bunch = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width * 0.89, height: bounds.height * 0.49))// UIBezierPath()
        return bunch.cgPath
    }
    
//    func getLeavesPath() -> {
//
//    }
//
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
