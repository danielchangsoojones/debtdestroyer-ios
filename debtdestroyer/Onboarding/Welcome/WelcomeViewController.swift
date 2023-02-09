//
//  ViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit
import Frigade

class WelcomeViewController: FrigadePage {
    private var messageHelper: MessageHelper?
    private var logInButton = UIButton()
    private var signUpButton = UIButton()
    var termsAndPolicyLabel = UILabel()
    var color1 = UIColor()
    var color2 = UIColor()
    var welcomeView = WelcomeView()
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        welcomeView = WelcomeView(frame: self.view.bounds)
        self.view = welcomeView
        logInButton = welcomeView.logInButton
        signUpButton = welcomeView.signUpButton
        color1 = welcomeView.hexStringToUIColor(hex: "FF2474")
        color2 = welcomeView.hexStringToUIColor(hex: "FF7910")
        titleLabel = welcomeView.titleLabel
        termsAndPolicyLabel = welcomeView.termsAndPolicyLabel
        subtitleLabel = welcomeView.subtitleLabel
        welcomeView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        welcomeView.signUpButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        setNavBarBtns()
        if let flow = FrigadeHelper.shared.welcomePage {
            let flowData = flow.getData()
            if !flowData.isEmpty {
                let data = flowData[0]
                if data.title != nil {
                    titleLabel.text = data.title
                }
                if data.subtitle != nil {
                    subtitleLabel.text = data.subtitle
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //  Rashmi -> for applying gradientColor ot create image, method needs logInButton frame.bound so calling / applying grad border and text code in viewDidAppear. Even tried to call it in viewdidLayoutSubviews but didnt work.
        logInButton.layer.cornerRadius = globalCornerRadius
        logInButton.clipsToBounds = true
        let gradientForText = welcomeView.getGradientLayer(bounds: logInButton.bounds)
        logInButton.setTitleColor(welcomeView.gradientColor(bounds: logInButton.bounds, gradientLayer: gradientForText), for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: logInButton.frame.size)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = globalCornerRadius

        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:logInButton.bounds, cornerRadius:globalCornerRadius).cgPath
        border.frame = logInButton.bounds
        border.fillColor = nil
        border.strokeColor = UIColor.purple.cgColor
        border.lineWidth = 4
        gradient.mask = border

        logInButton.layer.addSublayer(gradient)
        
        let gradientLabel = welcomeView.getGradientLayer(bounds: titleLabel.bounds)
        titleLabel.textColor = welcomeView.gradientColor(bounds: titleLabel.bounds, gradientLayer: gradientLabel)
        
        
        
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
        SignUpCoordinator.shared.reset()
        SignUpCoordinator.shared.next(self)
    }
}
