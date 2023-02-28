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
                UserDefaults.standard.set(firstName, forKey: OnboardingOrder.firstName)
                UserDefaults.standard.set(lastName, forKey: OnboardingOrder.lastName)
                UserDefaults.standard.synchronize()
                
                OnboardingDataStore.segueToNextVC(onboardingOrders: onboardingOrders,
                                                  index: index,
                                                  currentVC: self,
                                                  dataStore: dataStore,
                                                  nextBtn: nextButton)
            } else {
                nextButton.stopSpinning()
                BannerAlert.show(title: "Enter a name",
                                 subtitle: "Please enter in your first and last name",
                                 type: .error)
                
            }
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
    
    private func nextVC() {
         let promoCodeAndInviteShow = UserDefaults.standard.bool(forKey: "promoCodeAndInviteShow")
        if promoCodeAndInviteShow {
            let promoVC = AddressViewController()
            self.navigationController?.pushViewController(promoVC, animated: true)
        } else {
            nextButton.startSpinning()
            let email = UserDefaults.standard.string(forKey: "email") ?? ""
            let password = UserDefaults.standard.string(forKey: "password") ?? ""
            let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
            let firstName = UserDefaults.standard.string(forKey: OnboardingKeys.firstName) ?? ""
            let lastName = UserDefaults.standard.string(forKey: OnboardingKeys.lastName) ?? ""
            dataStore.register(email: email, password: password) {
                self.dataStore.save(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName, promoCode: nil) {
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "password")
                    UserDefaults.standard.removeObject(forKey: "phoneNumber")
                    UserDefaults.standard.removeObject(forKey: OnboardingKeys.firstName)
                    UserDefaults.standard.removeObject(forKey: OnboardingKeys.lastName)
                    UserDefaults.standard.synchronize()
                }
                self.nextButton.stopSpinning()
                let vc = CryptoTabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
