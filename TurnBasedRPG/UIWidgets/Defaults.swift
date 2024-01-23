//
//  DefaultSwitch.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/22/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import UIKit

class DefaultSwitch: UISwitch {
    
    @IBInspectable var keyValue: String = "defaultSwitch"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    func initialSetup(){
        let defaults = UserDefaults.standard
        let check = defaults.bool(forKey: keyValue)
        print("Switch: \(keyValue) is \(check)")
        setOn(check, animated: true)
        self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    func setPreference(_ isOn:Bool){
        let defaults = UserDefaults.standard
        defaults.set(isOn, forKey: keyValue)
    }
    @objc func valueChanged(){
        setPreference(self.isOn)
    }
}

class DefaultSlider: UISlider {
    
    @IBInspectable var keyValue: String = "defaultSlider"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    func initialSetup(){
        let defaults = UserDefaults.standard
        let float = defaults.float(forKey: keyValue)
        print("Slider: \(keyValue) is \(float)")
        setValue(float, animated: true)
        self.addTarget(self, action: #selector(slideEndedIn), for: .touchUpInside)
        self.addTarget(self, action: #selector(slideEndedOut), for: .touchUpOutside)
    }

    func setPreference(_ isOn:Bool){
        let defaults = UserDefaults.standard
        defaults.set(isOn, forKey: keyValue)
    }
    
    // I'm not using the valueChanged event because it triggers ALOT.
    // User Defaults is best used sparingly
    @objc func valueChanged(){
        UserDefaults.standard.setValue(value, forKey: keyValue)
    }
    
    @objc func slideEndedIn(){
        UserDefaults.standard.setValue(value, forKey: keyValue)
    }
    @objc func slideEndedOut(){
        UserDefaults.standard.setValue(value, forKey: keyValue)
    }
}

class DefaultTextfield: UITextField {
    
    @IBInspectable var keyValue: String = "defaultText"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    func initialSetup(){
        let defaults = UserDefaults.standard
        let string = defaults.string(forKey: keyValue)
        print("TextField: \(keyValue) is \(string!)")
        text = string
        self.addTarget(self, action: #selector(textEditingDidEnd), for: .editingDidEnd)
        self.addTarget(self, action: #selector(textEditingChanged), for: .editingChanged)
        
        //Without this selector Event the keyboard will not dismiss on return
        self.addTarget(self, action: #selector(textEditingDidEndOnExit), for: .editingDidEndOnExit)

    }

    func setPreference(_ isOn:Bool){
        let defaults = UserDefaults.standard
        defaults.set(isOn, forKey: keyValue)
    }
    
    @objc func textEditingChanged(){
        UserDefaults.standard.setValue(text, forKey: keyValue)
    }
    @objc func textEditingDidEndOnExit(){
        print("Editing didEnd onExit")
    }
    @objc func textEditingDidEnd(){
        print("Editing END")
        UserDefaults.standard.setValue(text, forKey: keyValue)
    }
}

