//
//  NameViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/09/22.
//

import UIKit
import SnapKit

class NameViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var quizTopicDatas: QuizTopicParse?
    var crypto_address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.hideKeyboardWhenTappedAround()
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
//            dataStore.save(phoneNumber: String(phoneNumber), crypto_address: crypto_address ?? "")
            
            if let quizTopicDatas = quizTopicDatas {
                let feedbackVC = ProvideFeedbackViewController(quizTopicDatas: quizTopicDatas)
                self.navigationController?.pushViewController(feedbackVC, animated: true)
            } else {
                BannerAlert.show(title: "Error", subtitle: "couldn't find the quizTopic", type: .error)
            }
            
            nextButton.stopSpinning()
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
}
