//
//  LoginViewModel.swift
//  HandHTest
//
//  Created by Надежда Туровская on 02.05.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct LoginViewModel {
    
    // MARK: - Public Properties
   
    let emailTextColor: Driver<UIColor>
    let passwordTextColor: Driver<UIColor>
    let credentialsValid: Driver<Bool>
    
    // MARK: - Initializers
    
    init(emailText: Driver<String>, passwordText: Driver<String>) {
        
        let emailValid = emailText
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.isValidEmail() }
        
        let passwordValid = passwordText
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.isValidPassword()}
        
        let validTextColor: UIColor = .textBlack
        let invalidTextColor: UIColor = .tangerine
        emailTextColor = emailValid
            .map { $0 ? validTextColor : invalidTextColor }
        
        passwordTextColor = passwordValid
            .map { $0 ? validTextColor : invalidTextColor }
        
        credentialsValid = Driver.combineLatest(emailValid, passwordValid) { $0 && $1 }
        
    }
    
    // MARK: - Public methods
    
    func login(_ email: String, password: String) -> Observable<AutenticationStatus>{
        return authManager.login(email, password: password)
    }
}
