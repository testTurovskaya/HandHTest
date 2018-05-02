//
//  UIApplication+Extensions.swift
//  HandHTest
//
//  Created by Надежда Туровская on 25.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//
//this extension is got from https://github.com/dillidon/alerts-and-pickers

import UIKit

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}
