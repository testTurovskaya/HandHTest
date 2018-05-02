//
//  AuthManager.swift
//  HandHTest
//
//  Created by Надежда Туровская on 02.05.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

enum AutenticationError: Error {
    case noInternet
    case server
    case wrongData
}

enum AutenticationStatus {
    case none
    case error(AutenticationError)
    case success
}

var authManager = AuthManager.shared

class AuthManager {
    
    // MARK: - Public Properties
    
    let status = Variable(AutenticationStatus.none)
    static var shared = AuthManager()
    
    // MARK: - Initializers
    
    fileprivate init() {}
    
    // MARK: - Public methods
    
    func login(_ email: String, password: String) -> Observable<AutenticationStatus>{
        return Observable<AutenticationStatus>.create{
            observer in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()){
                guard Connectivity.isConnectedToInternet() else {
                    observer.onNext(.error(.noInternet))
                    observer.onCompleted()
                    return
                }
                let isCorrectPassword = testData.validDict[email] == password
                if isCorrectPassword{
                    observer.onNext(.success)
                    observer.onCompleted()
                } else {
                    observer.onNext(.error(.wrongData))
                    observer.onCompleted()
                }
                
            }
            return Disposables.create()
        }
    }
    
    
}
