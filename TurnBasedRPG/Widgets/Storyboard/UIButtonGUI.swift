//
//  UIButtonGUI.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import UIKit

//@IBDesignable
///This class just exposes certain variables on the storyboard widget
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
    
    @IBInspectable public var animationSpeed: CGFloat = 1.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        SoundController.shared.tapSound()
        self.shrink()
    }
    
    
    
    
}
