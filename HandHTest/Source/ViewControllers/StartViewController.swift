//
//  StartViewController.swift
//  HandHTest
//
//  Created by Надежда Туровская on 24.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var goToAuthButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToAuthButton.layer.cornerRadius = 22
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = .white
        navigationBar.setValue(true, forKey: "hidesShadow")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.setValue(true, forKey:  "hidesShadow")
    }
}
