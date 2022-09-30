//
//  CreateProfileViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import UIKit
import SnapKit

class CreateProfileViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var quizTopicDatas: QuizTopicParse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.hideKeyboardWhenTappedAround()
        addOptionalLabel()
    }
    
    private func updateLabels() {
        emailLabel.text = "Phone Number"
        emailTextField.placeholder = "(123)-456-7890"
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        emailTextField.keyboardType = .phonePad
        emailTextField.delegate = self
        
    }
    
    private func addOptionalLabel() {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.text = "(Optional): providing your phone number is optional. We will alert you when new crypto quizzes come out and you can collect coins. Also, we will ask you for feedback on the app!"
        label.numberOfLines = 0
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.top.equalTo(stackView.snp.bottom).offset(5)
        }
    }
    
    override func nextBtnPressed() {
        nextButton.startSpinning()
        if isComplete {
            let bottomText = emailTextField?.text ?? "1111111111"
            let phoneNumber = NumberFormatter().number(from: bottomText.numbersOnly)?.doubleValue ?? 1111111111
            dataStore.save(phoneNumber: String(phoneNumber))
            let nameVC = NameViewController()
            self.navigationController?.pushViewController(nameVC, animated: true)
            
            nextButton.stopSpinning()
        } else {
            nextButton.stopSpinning()
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
            BannerAlert.show(title: "Invalid Phone Number", subtitle: "A proper phone number has only 10 digits", type: .error)
            return false
        }
        
        return true
    }
}

extension CreateProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = self.emailTextField.text else { return true }

        emailTextField.text = text.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
        let d = emailTextField.text?.numbersOnly
        let count = d!.count + string.count - range.length
        print(count <= 11)

        return count <= 11
    }
}
