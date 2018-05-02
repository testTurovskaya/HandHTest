//
//  TestData.swift
//  HandHTest
//
//  Created by Надежда Туровская on 02.05.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

let testData = TestData.shared
struct TestData {
    
    // MARK: - Public Properties
    
    static let shared = TestData()
    let validDict = ["hello@handh.ru": "Qwerty123",
                     "hr@handh.ru" : "Qwerty123",
                     "123@hand.ru" : "Qwerty123",
                     "qwerty@gmail.com": "123Qwerty",
                     "admin@admin.ru" : "Admin1"]
}
