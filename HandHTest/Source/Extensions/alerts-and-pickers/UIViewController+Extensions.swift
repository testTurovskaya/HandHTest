//
//  UIViewController+Extensions.swift
//  HandHTest
//
//  Created by Надежда Туровская on 25.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

//this extension is got from https://github.com/dillidon/alerts-and-pickers

import UIKit
extension UIViewController {
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
    
    //Personal extension
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
