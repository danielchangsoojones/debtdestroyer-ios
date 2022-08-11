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
        .font: UIFont.systemFont(ofSize: 18, weight: .thin),
        .foregroundColor: UIColor.black,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    override func viewDidLoad() {
        messageHelper = MessageHelper(currentVC: self, delegate: nil)
        super.viewDidLoad()
        updateLabels()
        setUpforgotPasswordBtn()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func runServerAuthentication() {
    dataStore.logIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
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
        
        self.view.addSubview(forgotPasswordBtn)
        forgotPasswordBtn.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            
        }
    }
    
    @objc private func forgetBtnPressed() {
        let msg = "please help me reset my password for debtdestroyer"
        messageHelper?.text("3176905323", body: msg)
    }
    
    override func segueIntoApp() {
        let vc = HomeTabBarViewController()
       // let navController = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
