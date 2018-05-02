//
//  Connectivity.swift
//  HandHTest
//
//  Created by Надежда Туровская on 26.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
