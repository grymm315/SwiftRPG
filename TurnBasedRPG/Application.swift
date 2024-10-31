//
//  UIApplicationExtension.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/24/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import UIKit

let goldenRatio:CGFloat = 0.6180340

extension UIApplication {
    class var topViewController: UIViewController? { return getTopViewController() }
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController { return getTopViewController(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController { return getTopViewController(base: selected) }
        }
        if let presented = base?.presentedViewController { return getTopViewController(base: presented) }
        return base
    }
    
    class func systemMessage(_ text:String){
        print("MESSAGE: \(text)")
        lazy var statusText: InfoBox = InfoBox()
        statusText.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.82, height: 100)
        statusText.center.x = (UIApplication.topViewController?.view.center.x)!
        statusText.center.y = 200
        statusText.text = text
//        statusText.sizeToFit()
        UIApplication.topViewController?.view.addSubview(statusText)
        statusText.fromTop(0.1)
        displayLog(text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.50, execute: {
            statusText.fadeOut(0.5)
//            self.statusText.removeFromSuperview()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            statusText.removeFromSuperview()
            
        })
    }
    
    class func xpMessage(_ text: String){
        displayLog(text, color: UIColor.yellow)
    }
    
    class func itemMessage(_ text: String){
        displayLog(text, color: UIColor.green)
    }
    
    class func displayLog(_ text: String, color: UIColor = UIColor.cyan){
        let attributedString = NSMutableAttributedString(string: text + "\n", attributes: [.foregroundColor: color])
        GameDatabase.shared.logFile.append(attributedString)
        GameDatabase.shared.logDelegate?.text(text, color: UIColor.red)
    }
    
    class func battleNotification(_ text:String){
        lazy var statusText: UILabel = UILabel()

        statusText.text = text
        statusText.layer.opacity = 1.0
        statusText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        statusText.textAlignment = .center
        statusText.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        statusText.layer.cornerRadius = 12
        statusText.layer.borderWidth = 2
        statusText.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        statusText.frame = CGRect(x: 15, y: 120, width: UIScreen.main.bounds.width - 30, height: 50)
        UIApplication.topViewController?.view.addSubview(statusText)
        statusText.fromTop(0.1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50, execute: {
            statusText.fadeOut(0.5)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            statusText.removeFromSuperview()
        })
    }

    private class func _share(_ data: [Any],
                              applicationActivities: [UIActivity]?,
                              setupViewControllerCompletion: ((UIActivityViewController) -> Void)?) {
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
        setupViewControllerCompletion?(activityViewController)
        UIApplication.topViewController?.present(activityViewController, animated: true, completion: nil)
    }

    /** This will pop the iOS standard share screen*/
    class func share(_ data: Any...,
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
    /** This will pop the iOS standard share screen*/
    class func share(_ data: [Any],
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
}

extension UIScreen {
    
    func isPortrait() -> Bool{
        return UIScreen.main.bounds.width < UIScreen.main.bounds.height
    }
    
    func goldenPopupFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height *  goldenRatio), size: CGSize(width: (UIScreen.main.bounds.width * (1 - goldenRatio)), height: (UIScreen.main.bounds.height * (1.0 - goldenRatio))))
    }
    
    func getRatio() -> CGFloat {
        var ratio = (1 - 0.6180340)
        
        //Portrait mode
        if (isPortrait()){
//            ratio = UIScreen.main.bounds.width / (UIScreen.main.bounds.height - 44)
        } else {
            //LandscapeMode
            ratio = (UIScreen.main.bounds.height - 32) / UIScreen.main.bounds.width
        }
        return ratio
    }
    
    // When constraints ain't cutting it we will forcefully set frames
    func goldenSmallTopFrame() -> CGRect{
        
        var rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 44) * getRatio())
        
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * getRatio(), height: (UIScreen.main.bounds.height - 32))
        }
        return rect
    }
    func goldenLargeLowerFrame() -> CGRect{
       
        //Portrait
        var rect = CGRect(x: 0, y: (UIScreen.main.bounds.height - 44) * getRatio(), width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - ((UIScreen.main.bounds.height - 44) * getRatio())))
        //Landscape
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: UIScreen.main.bounds.width * getRatio(), y: 0, width: UIScreen.main.bounds.width * (1 - getRatio()), height: UIScreen.main.bounds.height - 32)
        }
        return rect
    }
    
    // When constraints ain't cutting it we will forcefully set frames
    func goldenSmallBottomFrame() -> CGRect{
        
        var rect = CGRect(x: 0, y: (UIScreen.main.bounds.height - ((UIScreen.main.bounds.height - 44) * (1 - getRatio()))), width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 44) * (1 - getRatio()))
        
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * getRatio(), height: (UIScreen.main.bounds.height - 32))
        }
        return rect
    }
    func goldenLargeTopFrame() -> CGRect{
       
        //Portrait
        var rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - ((UIScreen.main.bounds.height - 44) * (1 - getRatio()))))
        //Landscape
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: UIScreen.main.bounds.width * getRatio(), y: 0, width: UIScreen.main.bounds.width * (1 - getRatio()), height: UIScreen.main.bounds.height - 32)
        }
        return rect
    }
}

extension CGRect {
    func prettyPrint() -> String{
        return "Origin: \(self.origin) Height: \(self.height), Width: \(self.width)"
    }
}
