//
//  ViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var logInButton = UIButton()
    private var registerButton = UIButton()
    var termsAndPolicyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        let welcomeView = WelcomeView(frame: self.view.bounds)
        self.view = welcomeView
        logInButton = welcomeView.logInButton
        registerButton = welcomeView.registerButton
        termsAndPolicyLabel = welcomeView.termsAndPolicyLabel
        welcomeView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        welcomeView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        setNavBarBtns()
        
    }
    
    private func setNavBarBtns() {
        var helpImg = UIImage.init(named: "Help")
        helpImg = helpImg?.withRenderingMode(.alwaysOriginal)
        let help = UIBarButtonItem(image: helpImg , style: .plain, target: self, action: #selector(helpPressed))
        navigationItem.rightBarButtonItem = help
        
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    @objc private func helpPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    
    @objc private func logInPressed() {
        let logInVC = LogInViewController()
        navigationController?.pushViewController(logInVC, animated: true)
    }
    
    @objc private func registerPressed() {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

