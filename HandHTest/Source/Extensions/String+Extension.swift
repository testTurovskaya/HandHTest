//
//  String+extension.swift
//  HandHTest
//
//  Created by Надежда Туровская on 26.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

extension String {
    
    var degree:String {
        return self + "℃"
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let emailWithoutSpace =  self.trimmingCharacters(in: .whitespacesAndNewlines)
        return emailTest.evaluate(with: emailWithoutSpace)
    }
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,64}$"
        let passwordlTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordlTest.evaluate(with: self)
    }
}
