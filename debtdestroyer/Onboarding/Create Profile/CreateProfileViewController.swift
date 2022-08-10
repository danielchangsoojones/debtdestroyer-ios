//
//  CreateProfileViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import UIKit

class CreateProfileViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    private func updateLabels() {
        emailLabel.text = "Phone Number"
        emailTextField.placeholder = "(123)-456-7890"
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        
    }
    
    override func nextBtnPressed() {
//        nextButton.startSpinning()
        if isComplete {
            let bottomText = emailTextField?.text ?? "1111111111"
            let phoneNumber = NumberFormatter().number(from: bottomText.numbersOnly)?.doubleValue ?? 1111111111
            //dataStore.save( phoneNumber: String(phoneNumber))
            
            let vc = HomeTabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
//            nextButton.stopSpinning()
        }
    }
    
    var isComplete: Bool {
        guard let phoneStr = emailTextField?.text else {
            return false
        }
       
        if phoneStr.isEmpty {
            BannerAlert.show(title: "Phone Number Needed", subtitle: "Please input your phone number", type: .error)
            return false
        }
        
        if !phoneStr.isPhoneNumber {
            BannerAlert.show(title: "Invalid Phone Number", subtitle: "A proper phone number has only 9 digits", type: .error)
            return false
        }
        
        return true
    }
}
