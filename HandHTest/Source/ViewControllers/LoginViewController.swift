//
//  LoginViewController.swift
//  HandHTest
//
//  Created by Надежда Туровская on 24.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswowordButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var buttonsStack: UIStackView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        passwordField.textContentType = UITextContentType("")
        
        loginButton.layer.cornerRadius = 22
        forgotPasswowordButton.layer.borderWidth = 0.4
        let borderColor: UIColor = .whiteFour
        forgotPasswowordButton.layer.borderColor = borderColor.cgColor
        forgotPasswowordButton.layer.cornerRadius = 4
        
        navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
        let title =  NSLocalizedString("authorization", comment: "")
        navigationItem.title = title
        
        let viewModel = LoginViewModel(emailText: emailField.rx.text.orEmpty.asDriver(),
                                       passwordText: passwordField.rx.text.orEmpty.asDriver())
        viewModel.credentialsValid
            .drive(onNext: { [unowned self] valid in
                self.loginButton.isEnabled = valid
            })
            .disposed(by: disposeBag)
        
        viewModel.emailTextColor
            .drive(onNext: { [unowned self] color in
                UIView.animate(withDuration: 0.2) {
                    self.emailField.textColor = color
                }
            })
            .disposed(by: disposeBag)
        
        
        viewModel.passwordTextColor
            .drive(onNext: { [unowned self] color in
                UIView.animate(withDuration: 0.2) {
                    self.passwordField.textColor = color
                }
            })
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .withLatestFrom(viewModel.credentialsValid)
            .filter { $0 }
            .flatMapLatest { [unowned self] valid -> Observable<AutenticationStatus> in
                viewModel.login(self.emailField.text!, password: self.passwordField.text!)
                    .observeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] autenticationStatus in
                switch autenticationStatus {
                case .none:
                    break
                case .success:
                    self.showForecast()
                case .error(let error):
                    self.showError(error)
                }
                authManager.status.value = autenticationStatus
            })
            .disposed(by: disposeBag)
        

    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setValue(true, forKey:  "hidesShadow")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
   
    
    // MARK: - IBActions
    
    @IBAction func createAccount(_ sender: UIButton) {
        let tittle =  NSLocalizedString("registration", comment: "")
        showAlertWith(title: tittle)
    }
    @IBAction func remindPassword(_ sender: UIButton) {
        let tittle =  NSLocalizedString("we sent you a link to reset your password", comment: "")
        showAlertWith(title: tittle)
    }
    
    // MARK: - Private Methods

    fileprivate func showAlertWith(title: String){
        let alert = UIAlertController(style: .alert, title: title)
        alert.addAction(title: "OK")
        alert.view.tintColor = .tangerine
        alert.show()
    }
    
    fileprivate func showError(_ error: AutenticationError) {
        var title = ""
        switch error{
        case .noInternet:
            title = NSLocalizedString("no internet connection", comment: "")
        case .wrongData:
            title = NSLocalizedString("wrong email/password", comment: "")
        default:
            break
        }
        showAlertWith(title: title)
    }
    fileprivate func showAlertWith(_ forecasts: [Forecast]){
        let alert = UIAlertController(style: .actionSheet)
        let title = NSLocalizedString("login", comment: "")
        alert.title = title
        alert.setTitle(font: .boldSystemFont(ofSize: 16), color: .black)
        let weaters = forecasts.map{Weather.init(by: $0)}
        for weater in weaters {
            let city = NSLocalizedString(weater.city, comment: "")
            let btnTitle = city + " " + weater.temperature
            alert.addAction(image: weater.icon, title: btnTitle, color: .black, style: .default, isEnabled: false, handler: nil)
        }
        alert.addAction(image: nil, title: "ОК", color: .tangerine, style: .default, isEnabled: true, handler: nil)
        alert.show()
        
    }
    fileprivate func showForecast(){
        forecastService.getWeaterFor(cities: [.cupertino, .moskow, .petersburg, .saransk, .kaliningrad]){response in
            do {
                guard  let data = response.data else {return}
                let response = try JSONDecoder().decode(OWMResponse.self, from: data)
                let forecasts = response.list
                self.showAlertWith(forecasts)
            }
            catch {
                print("JSon processing Failed")
            }
        }
    }
    
    // MARK: - Keyboard's Methods
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        scrollView.isScrollEnabled = true
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        print(contentInset.top)
        contentInset.top =  -(buttonsStack.frame.height / 1.8)
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.isScrollEnabled = false
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return false
    }
}
