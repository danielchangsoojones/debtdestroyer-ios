//
//  DOBViewController.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 09/12/22.
//

import UIKit

class DOBViewController: RegisterViewController, UINavigationControllerDelegate {
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func updateLabels() {
        emailLabel.text = "Date of birth"
        emailTextField.placeholder = "DD/MM/YYYY"
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        emailTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.doneClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        emailTextField.inputAccessoryView = toolBar

    }
    
    @objc func doneClick() {
        // print(checkForTxtFld)
        self.view.endEditing(true)
        
            emailTextField.resignFirstResponder()
          
    }

    
    @objc func datePickerValueChanged() {
        
        let dateFormatter         = DateFormatter()
        dateFormatter.dateStyle   = DateFormatter.Style.short
        dateFormatter.dateFormat  = "dd-MM-yyyy"
        let formattedDate: String = dateFormatter.string(from: datePicker.date)
        emailTextField.text = formattedDate
        
    }

    override func nextBtnPressed() {
        nextButton.startSpinning()
        if isComplete {
            let dateFormatter         = DateFormatter()
            dateFormatter.dateStyle   = DateFormatter.Style.short
            dateFormatter.dateFormat  = "dd-MM-yyyy"
            let formattedDate: String = dateFormatter.string(from: Date())
            let bottomText = emailTextField?.text ?? formattedDate
            
            UserDefaults.standard.set(bottomText, forKey: "DOB")
            UserDefaults.standard.synchronize()
            nextVC()
            nextButton.stopSpinning()
        } else {
            nextButton.stopSpinning()
        }
    }
    
    private func nextVC() {
        let nameVC = NameViewController()
        self.navigationController?.pushViewController(nameVC, animated: true)
    }
    
    var isComplete: Bool {
        guard let dobStr = emailTextField?.text else {
            return false
        }
        
        if dobStr.isEmpty {
            BannerAlert.show(title: "DOB Needed", subtitle: "Please enter your date of birth", type: .error)
            return false
        }
        
        return true
    }
}
