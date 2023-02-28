//
//  CreateProfileViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import UIKit
import SnapKit

class PhoneViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func updateLabels() {
        emailLabel.text = "Phone Number"
        emailTextField.placeholder = "(123)-456-7890"
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        emailTextField.keyboardType = .phonePad
        emailTextField.delegate = self
    }
    
    override func nextBtnPressed() {
        nextButton.startSpinning()
        if isComplete {
            let bottomText = emailTextField?.text ?? "1111111111"
            let phoneNumber = NumberFormatter().number(from: bottomText.numbersOnly) ?? 1111111111
            
            UserDefaults.standard.set(phoneNumber, forKey: OnboardingOrder.phoneNumber)
            UserDefaults.standard.synchronize()
            nextVC()
        } else {
            nextButton.stopSpinning()
        }
    }
    
    private func nextVC() {
        nextButton.stopSpinning()
        OnboardingDataStore.segueToNextVC(onboardingOrders: onboardingOrders,
                                          index: index,
                                          currentVC: self,
                                          dataStore: dataStore,
                                          nextBtn: nextButton)
    }
    
    var isComplete: Bool {
        guard let phoneStr = emailTextField?.text else {
            return false
        }
        
        if phoneStr.isEmpty {
            BannerAlert.show(title: "Phone Number Needed", subtitle: "Please input your phone number", type: .error)
            return false
        }
        
//        if !phoneStr.isPhoneNumber {
//            BannerAlert.show(title: "Invalid Phone Number", subtitle: "A proper phone number has only 10 digits", type: .error)
//            return false
//        }
        
        return true
    }
}

extension PhoneViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        guard let text = self.emailTextField.text else { return true }
//
//        emailTextField.text = text.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
//        let d = emailTextField.text?.numbersOnly
//        let count = d!.count + string.count - range.length
//        print(count <= 11)
//
//        return count <= 11
//    }
}
