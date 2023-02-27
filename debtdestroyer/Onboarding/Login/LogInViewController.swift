//
//  LogInViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class LogInViewController: RegisterViewController {
    private var messageHelper: MessageHelper?
    let forgotPasswordBtn  = UIButton()
    let buttonAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.MontserratThin(size: 18),
        .foregroundColor: UIColor.black,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        setUpforgotPasswordBtn()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func updateLabels() {
        let logo = UIImage(named: "Login-1")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    private func setUpforgotPasswordBtn() {
        let attributeString = NSMutableAttributedString(
            string: "Forgot Password?",
            attributes: buttonAttributes
        )
        forgotPasswordBtn.setAttributedTitle(attributeString, for: .normal)
        forgotPasswordBtn.addTarget(self, action: #selector(forgetBtnPressed), for: .touchUpInside)
        self.view.addSubview(forgotPasswordBtn)
        forgotPasswordBtn.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            
        }
    }
    
    @objc private func forgetBtnPressed() {
        let vc = ResetPasswordViewController(onboardingOrders: [], index: 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func nextBtnPressed() {
        nextButton.startSpinning()
        dataStore.logIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {
            self.nextButton?.stopSpinning()
            let vc = CryptoTabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
