//
//  UIButtonGUI.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonGUI:UIButton{
    
    @IBInspectable public var cornerRadius: CGFloat = 2.0 {didSet {
        self.layer.cornerRadius = self.cornerRadius}}
    
    @IBInspectable public var masksToBounds: Bool = false {didSet {self.layer.masksToBounds = self.masksToBounds}}
    @IBInspectable public var borderWidth: CGFloat = 2.0 {didSet {self.layer.borderWidth = self.borderWidth}}
    @IBInspectable public var borderColor: UIColor = UIColor.black {didSet {self.layer.borderColor = (self.borderColor.cgColor )}}
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 10, height: 10) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 2.0 {didSet {
        self.layer.shadowRadius = self.shadowRadius
        if (shadowRadius > 0){self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath}
        }}
    @IBInspectable public var shadowOpacity: Float = 100 {didSet {
        self.layer.shadowOpacity = self.shadowOpacity / 100
        }}
    @IBInspectable public var shadowColor: UIColor = UIColor.black {didSet {self.layer.shadowColor = (self.shadowColor.cgColor )}}
    @IBInspectable public var shouldRasterize: Bool = true {didSet {self.layer.shouldRasterize = (self.shouldRasterize )}}
    
    @IBInspectable public var swoop:Int = 0

    func fromLeft(){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: -self.frame.origin.x, y: self.frame.origin.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin = returnHere
        })
    }
    
    func fromRight(){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x + UIScreen.main.bounds.width, y: self.frame.origin.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin = returnHere
        })
    }
    func fromTop(){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: -self.frame.origin.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin = returnHere
        })
    }
    func fromBottom(){
        let returnHere = self.frame.origin
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + UIScreen.main.bounds.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin = returnHere
        })
    }
    
    func nothing(){
    }
    

    
    
}
