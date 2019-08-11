//
//  ScanLine.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 2/21/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class ScanLine: UIView {

    override init(frame: CGRect) {
        super .init(frame: frame)
  //      self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     //   self.backgroundColor = UIColor.black
        //fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        
        let line = UIBezierPath()
        UIColor.green.setStroke()
        line.move(to: CGPoint(x: 0, y: 0))
        line.lineWidth = 30
        
        line.addLine(to: CGPoint(x: 0, y: self.bounds.height))
      //  line.move(to: CGPoint(x: self.bounds.width, y: 0))
        line.stroke()
    }
    
}
