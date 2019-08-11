//
//  RoomView.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 7/20/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class RoomView: UIView {
    var wallHeight:CGFloat = 50
    let north:NorthWall
    let east:EastWall
    let south:SouthWall
    let west:WestWall
    
    weak var room:RoomNode?
    override init(frame: CGRect) {
        north = NorthWall(frame: frame)
        east = EastWall(frame: frame)
        west = WestWall(frame: frame)
        south = SouthWall(frame: frame)
        super.init(frame: frame)
        self.addSubview(north)
        self.addSubview(south)
        self.addSubview(east)
        self.addSubview(west)
        //      self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        north = NorthWall(coder: aDecoder)!
        east = EastWall(coder: aDecoder)!
        west = WestWall(coder: aDecoder)!
        south = SouthWall(coder: aDecoder)!
        super.init(coder: aDecoder)
        self.addSubview(north)
        self.addSubview(south)
        self.addSubview(east)
        self.addSubview(west)
       
    }
    override func draw(_ rect: CGRect) {
        
////        let line = UIBezierPath()
//        UIColor.green.setStroke()
//        UIColor.blue.setFill()
//        //left wall
////        if(room?.west == nil){
//
//        //bottom wall
////        if(room?.south == nil){
//        south.move(to: CGPoint(x: 0, y: self.bounds.height))
//         south.addLine(to: CGPoint(x:wallHeight, y: self.bounds.height - wallHeight))
//         south.addLine(to: CGPoint(x:self.bounds.width - wallHeight, y: self.bounds.height - wallHeight))
//            south.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
//        //right wall
////            if(room?.east == nil){
//        east.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
//        east.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: self.bounds.height - wallHeight))
//        east.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: wallHeight))
//            east.addLine(to: CGPoint(x: self.bounds.width, y: 0))
//        //top wall
////        if(room?.north == nil){
//        north.move(to: CGPoint(x: self.bounds.width, y: 0))
//        north.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: wallHeight))
//        north.addLine(to: CGPoint(x: wallHeight, y: wallHeight))
//        north.addLine(to: CGPoint(x: 0, y: 0))
//
//        //north.lineWidth = 3
//
//        if (room != nil){
//            if (room?.north == nil){
//                north.fill()
//                north.stroke()} else {
//                north.removeAllPoints()}
//
//            if (room?.east == nil){
////                east.fill()
////                east.stroke()}
//                east.removeAllPoints()}
//
//            if (room?.west == nil){
////                west.fill()
////                west.stroke()}
//                west.removeAllPoints()}
//
//
//            if (room?.south == nil){
////                south.fill()
////                south.stroke()}
//                south.removeAllPoints()}

//        }
    }
    
    func reset()
    {
        north.frame = self.frame
        south.frame = self.frame
        east.frame = self.frame
        west.frame = self.frame
        
    }
    
    func changeView(to: RoomNode){
//        north.isHidden = to.north != nil
//        south.isHidden = to.south != nil
//        east.isHidden = to.east != nil
//        west.isHidden = to.west != nil
    }
}

class Wall:UIView {
    var wallColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    var wallLine = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    var wallHeight:CGFloat = 50.0
    let path:UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect) {super .init(frame: frame)}
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}
}

class NorthWall:Wall{
    
    override func draw(_ rect: CGRect) {
        wallLine.setStroke()
        wallColor.setFill()
        path.move(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: wallHeight))
        path.addLine(to: CGPoint(x: wallHeight, y: wallHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.fill()
        path.stroke()
}
    
    
}

class SouthWall:Wall{
    
    override func draw(_ rect: CGRect) {
        wallLine.setStroke()
        wallColor.setFill()
        path.move(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x:wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x:self.bounds.width - wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.fill()
        path.stroke()
}
}

class EastWall: Wall {
    
    override func draw(_ rect: CGRect) {
        wallLine.setStroke()
        wallColor.setFill()
        path.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: wallHeight))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.fill()
        path.stroke()
}
}

class WestWall: Wall{
    
     override func draw(_ rect: CGRect) {
        wallLine.setStroke()
        wallColor.setFill()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x:wallHeight, y:wallHeight))
    path.addLine(to: CGPoint(x:wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.fill()
        path.stroke()
    }
    }
