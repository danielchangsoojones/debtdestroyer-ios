//
//  NameViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/09/22.
//

import UIKit
import SnapKit

class NameViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.hideKeyboardWhenTappedAround()
        passwordTextField.isSecureTextEntry = false
    }
    
    private func updateLabels() {
        emailLabel.text = "First Name"
        emailTextField.placeholder = "First Name"
        passwordLabel.text = "Last Name"
        passwordTextField.placeholder = "Last Name"
    }
    
    override func nextBtnPressed() {
        nextButton.startSpinning()
        if isComplete {
            if let firstName = emailTextField.text, let lastName = passwordTextField.text {
                
                let email = UserDefaults.standard.string(forKey: "email") ?? ""
                let password = UserDefaults.standard.string(forKey: "password") ?? ""
                let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
                dataStore.register(email: email, password: password) {
                    self.dataStore.save(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName){
                        UserDefaults.standard.removeObject(forKey: "email")
                        UserDefaults.standard.removeObject(forKey: "password")
                        UserDefaults.standard.removeObject(forKey: "phoneNumber")
                        UserDefaults.standard.synchronize()
                    }
                }
              
            }
            nextButton.stopSpinning()
            segueIntoApp()
        } else {
            nextButton.stopSpinning()
        }
    }
    
    var isComplete: Bool {
        guard let fNameStr = emailTextField?.text else {
            return false
        }
            
        if fNameStr.removeWhitespaces().isEmpty {
            BannerAlert.show(title: "First Name Needed", subtitle: "Please input your first name", type: .error)
            return false
        }
        guard let lNameStr = passwordTextField?.text else {
            return false
        }
        
        if lNameStr.removeWhitespaces().isEmpty {
            BannerAlert.show(title: "Last Name Needed", subtitle: "Please input your last name", type: .error)
            return false
        }
        
        return true
    }
    
    override func segueIntoApp() {
        let vc = CryptoTabBarViewController()//HomeTabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
