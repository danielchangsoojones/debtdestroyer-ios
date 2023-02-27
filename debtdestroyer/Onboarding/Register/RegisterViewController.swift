//
//  RegisterViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController, OnboardingDataStoreDelegate {
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nextButton: SpinningWithGradButton!
    var dataStore: OnboardingDataStore!
    var stackView: UIStackView!
    var emailLabel: UILabel!
    var passwordLabel: UILabel!
    private var messageHelper: MessageHelper?
    let onboardingOrders: [OnboardingOrder]
    let index: Int
    
    required init(onboardingOrders: [OnboardingOrder], index: Int) {
        self.onboardingOrders = onboardingOrders
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let registerView = RegisterView(frame: self.view.bounds)
        self.view = registerView
        emailTextField = registerView.emailTextField
        passwordTextField = registerView.passwordTextField
        passwordTextField.isSecureTextEntry = true
        nextButton = registerView.nextButton
        stackView = registerView.stackView
        emailLabel = registerView.emailLabel
        passwordLabel = registerView.passwordLabel
        registerView.nextButton.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
      
        dataStore = OnboardingDataStore(delegate: self)
        self.hideKeyboardWhenTappedAround()
        let logo = UIImage(named: "Sign-Up")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.backButtonTitle = ""

        setNavBarBtns()
    }
    
    private func setNavBarBtns() {
        var helpImg = UIImage.init(named: "Help")
        helpImg = helpImg?.withRenderingMode(.alwaysOriginal)
        let help = UIBarButtonItem(image: helpImg , style: .plain, target: self, action: #selector(helpPressed))
        navigationItem.rightBarButtonItem = help
     
        navigationItem.hidesBackButton = true
        var backImg = UIImage.init(named: "arrow-left-alt")
        backImg = backImg?.withRenderingMode(.alwaysOriginal)
        let back = UIBarButtonItem(image: backImg , style: .plain, target: self, action: #selector(backPressed))
        navigationItem.leftBarButtonItem = back

        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc func nextBtnPressed() {
        nextButton.startSpinning()
        if validateEmail() && validatePassword() {
            UserDefaults.standard.set(emailTextField.text, forKey: OnboardingOrder.email)
            UserDefaults.standard.set(passwordTextField.text, forKey: OnboardingOrder.password)
            UserDefaults.standard.synchronize()
            
            OnboardingDataStore.segueToNextVC(onboardingOrders: onboardingOrders,
                                              index: index,
                                              currentVC: self,
                                              dataStore: dataStore,
                                              nextBtn: nextButton)
        } else {
            nextButton.stopSpinning()
        }
    }
    
    func segueIntoApp() {
        nextButton.stopSpinning()
        Helpers.enterApplication(from: self)
    }
}

extension RegisterViewController {
    func validateEmail() -> Bool {
        if let email = emailTextField?.text, !email.isEmail {
            BannerAlert.show(title: "Invalid Email",
                             subtitle: "You must input a proper email",
                             type: .error)
            return false
        }
        
        return true
    }
    
    func validatePassword() -> Bool {
        if let password = passwordTextField?.text {
            if password.isBlank {
                BannerAlert.show(title: "Invalid Password", subtitle: "You must input a password", type: .error)
                return false
            }
        }
        return true
    }
    
    func showError(title: String, subtitle: String) {
        nextButton.stopSpinning()
        BannerAlert.show(title: title, subtitle: subtitle, type: .error)
    }
}
