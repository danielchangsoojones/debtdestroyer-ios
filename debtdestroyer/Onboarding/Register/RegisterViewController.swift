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
    var nextButton: UIButton!
    var dataStore: OnboardingDataStore!
    var stackView: UIStackView!
    var emailLabel: UILabel!
    var passwordLabel: UILabel!
    private var messageHelper: MessageHelper?

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
//        nextButton.startSpinning()
        if validateEmail() && validatePassword() {
            segueIntoApp()
            runServerAuthentication()
        } else {
//            nextButton.stopSpinning()
        }
    }
    
    func runServerAuthentication() {
        dataStore.register(email: emailTextField.text ?? "",
                           password: passwordTextField.text ?? "")
    }
    
    func segueIntoApp() {
        let profileVC = CreateProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
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
//        nextButton.stopSpinning()
        BannerAlert.show(title: title, subtitle: subtitle, type: .error)
    }
}
