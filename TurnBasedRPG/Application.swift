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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.50, execute: {
            statusText.fadeOut(0.5)
//            self.statusText.removeFromSuperview()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
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
}

extension CGRect {
    func prettyPrint() -> String{
        return "Origin: \(self.origin) Height: \(self.height), Width: \(self.width)"
    }
}
