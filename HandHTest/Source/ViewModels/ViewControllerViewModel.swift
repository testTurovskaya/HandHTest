//
//  ViewControllerViewModel.swift
//  HandHTest
//
//  Created by Надежда Туровская on 02.05.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


struct ViewControllerViewModel {
    
    // MARK: - Public Properties
    
    let loginStatus = authManager.status.asDriver().asDriver(onErrorJustReturn: .none)
}
