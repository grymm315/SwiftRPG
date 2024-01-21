//
//  CommandMenu.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/20/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import UIKit

class CommandMenu: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class CommandCell: UICollectionViewCell {

    @IBOutlet weak var cLabel: UILabel!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 8
        self.layer.borderColor = UIColor.white.cgColor
        self.isUserInteractionEnabled = true
        
        cLabel = UILabel(frame: self.bounds)
       }
    
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           self.backgroundColor = .blue
           self.layer.cornerRadius = 20.0
           self.layer.borderWidth = 8
           self.layer.borderColor = UIColor.white.cgColor
           self.isUserInteractionEnabled = true
       }
    func visualize(_ text:String) {
        self.cLabel.textColor = UIColor.white
        self.cLabel.textAlignment = .center
        self.cLabel.text = text
        self.cLabel.numberOfLines = 2
        
    }
}
