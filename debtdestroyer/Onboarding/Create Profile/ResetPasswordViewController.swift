//
//  ResetPasswordViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/11/22.
//

import UIKit
import SnapKit

class ResetPasswordViewController: RegisterViewController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func updateLabels() {
        emailLabel.text = "Enter your email and we'll send you instructions on how to reset your password."
        emailTextField.placeholder = "Email"
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        emailTextField.keyboardType = .emailAddress
        
        let logo = UIImage(named: "Login-1")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
   
    override func nextBtnPressed() {
        nextButton.startSpinning()
        if validateEmail() {
            
            User.requestPasswordResetForEmail(inBackground:emailTextField.text!)
            nextButton.stopSpinning()
            
            self.segueIntoApp()
        } else {
            nextButton.stopSpinning()
        }
    }
        
    override func segueIntoApp() {
        self.navigationController?.popViewController(animated: true)
    }
}
