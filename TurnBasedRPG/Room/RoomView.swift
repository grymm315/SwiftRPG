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
    //* */
    override init(frame: CGRect) {
        print("Init Frame: \(frame)")
        north = NorthWall(frame: frame)
        east = EastWall(frame: frame)
        west = WestWall(frame: frame)
        south = SouthWall(frame: frame)
        
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        addWall(south)
        addWall(east)
        addWall(west)
        addWall(north)
        //      self.backgroundColor = UIColor.black
    }
    
    func addWall(_ wall: UIView){
        wall.isUserInteractionEnabled = false
        self.addSubview(wall)
    }
    
    //* */
    
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
    
    func reset()
    {
        north.frame = self.frame
        south.frame = self.frame
        east.frame = self.frame
        west.frame = self.frame
        
    }
    
    //* */
    func changeView(to: RoomNode){
        print("Change view \(to)")
        north.isHidden = to.north != nil
        south.isHidden = to.south != nil
        east.isHidden = to.east != nil
        west.isHidden = to.west != nil
    }
}
//* */
class Wall:UIView {
    var wallColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    var wallLine = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    var wallHeight:CGFloat = 50.0
    var wallShape:CAShapeLayer = CAShapeLayer()
    //let path:UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect) {super .init(frame: frame)}
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        wallShape.path = getPath()
        wallShape.lineWidth = 5
        wallShape.strokeColor = wallLine.cgColor
        wallShape.fillColor = wallColor.cgColor
        layer.addSublayer(wallShape)
    }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}
    
    func getPath() -> CGPath{
        let path = UIBezierPath()
        return path.cgPath
    }
}
//* */
class NorthWall:Wall{
    override func getPath() -> CGPath {
        print("Path for north")
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: wallHeight))
        path.addLine(to: CGPoint(x: wallHeight, y: wallHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path.cgPath
    }
}

//* */
class SouthWall:Wall{
    override func getPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x:wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x:self.bounds.width - wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        return path.cgPath
    }
}
//* */
class EastWall: Wall {
    
    override func getPath() -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x: self.bounds.width - wallHeight, y: wallHeight))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        return path.cgPath
        
    }
}
//* */
class WestWall: Wall{
    
    
    //override func draw(_ rect: CGRect) {
    override func getPath() -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:wallHeight, y:wallHeight))
        path.addLine(to: CGPoint(x:wallHeight, y: self.bounds.height - wallHeight))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        return path.cgPath
        
    }
}
