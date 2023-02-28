//
//  ViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit

enum OnboardingOrder: String {
    case emailpassword = "emailpassword"
    case name = "name"
    case phone = "phone"
    case promo = "promo"
    case contactInvite = "contactInvite"
    
    var vcType: UIViewController.Type {
        switch self {
        case .emailpassword:
            return RegisterViewController.self
        case .name:
            return NameViewController.self
        case .phone:
            return PhoneViewController.self
        case .promo:
            return PromoViewController.self
        case .contactInvite:
            return ContactViewController.self
        }
    }
    
    static let promoCode = "promoCode"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let email = "email"
    static let password = "password"
    static let phoneNumber = "phoneNumber"
    
    static func getCurrentVC(onboardingOrders: [OnboardingOrder], index: Int) -> UIViewController? {
        if !onboardingOrders.indices.contains(index) {
            return nil
        } else {
            let currentOrder = onboardingOrders[index]
            switch currentOrder {
            case .emailpassword, .name, .phone:
                if let vcType = currentOrder.vcType as? RegisterViewController.Type {
                    let vc = vcType.init(onboardingOrders: onboardingOrders,
                                         index: index)
                    return vc
                }
            case .promo:
                if let vcType = currentOrder.vcType as? PromoViewController.Type {
                    let vc = vcType.init(onboardingOrders: onboardingOrders,
                                         index: index)
                    return vc
                }
            case .contactInvite:
                if let vcType = currentOrder.vcType as? ContactViewController.Type {
                    let vc = vcType.init(onboardingOrders: onboardingOrders,
                                         index: index)
                    return vc
                }
            }
            
            return nil
        }
    }
}

class WelcomeViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var logInButton = UIButton()
    private var signUpButton = UIButton()
    var termsAndPolicyLabel = UILabel()
    var color1 = UIColor()
    var color2 = UIColor()
    var welcomeView = WelcomeView()
    var titleLabel = UILabel()
    private var promoCodeAndInviteShow : Bool = true
    private var dataStore: OnboardingDataStore?
    private var config: ConfigurationParse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataStore = OnboardingDataStore(delegate: self)
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        welcomeView = WelcomeView(frame: self.view.bounds)
        self.view = welcomeView
        logInButton = welcomeView.logInButton
        signUpButton = welcomeView.signUpButton
        color1 = welcomeView.hexStringToUIColor(hex: "FF2474")
        color2 = welcomeView.hexStringToUIColor(hex: "FF7910")
        titleLabel = welcomeView.titleLabel
        termsAndPolicyLabel = welcomeView.termsAndPolicyLabel
        welcomeView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        welcomeView.signUpButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        setNavBarBtns()
        // after API call get ready to intehrate, call it here and save the value to User defalts as User object is not yet created/ avilable.
        UserDefaults.standard.set(true, forKey: "promoCodeAndInviteShow")
        UserDefaults.standard.synchronize()
        getConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //  Rashmi -> for applying gradientColor ot create image, method needs logInButton frame.bound so calling / applying grad border and text code in viewDidAppear. Even tried to call it in viewdidLayoutSubviews but didnt work.
        logInButton.layer.cornerRadius =  8
        logInButton.clipsToBounds = true
        let gradientForText = welcomeView.getGradientLayer(bounds: logInButton.bounds)
        logInButton.setTitleColor(welcomeView.gradientColor(bounds: logInButton.bounds, gradientLayer: gradientForText), for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: logInButton.frame.size)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = 8

        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:logInButton.bounds, cornerRadius:8).cgPath
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
        let logInVC = LogInViewController(onboardingOrders: [.emailpassword], index: 0)
        navigationController?.pushViewController(logInVC, animated: true)
    }
    
    @objc private func registerPressed() {
        let onboardingOrders = getOnboardingOrder()
        if let nextVC = OnboardingOrder.getCurrentVC(onboardingOrders: onboardingOrders, index: 0) {
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            BannerAlert.show(title: "Error",
                             subtitle: "Could not find matching onboarding view controllers",
                             type: .error)
        }
    }
    
    private func getConfig() {
        dataStore?.getConfig(completion: { config in
            self.config = config
        })
    }
    
    private func getOnboardingOrder() -> [OnboardingOrder] {
        //if no internet, default to this
        let defaultOrder: [String] = [OnboardingOrder.emailpassword.rawValue, OnboardingOrder.name.rawValue, OnboardingOrder.phone.rawValue, OnboardingOrder.promo.rawValue]
        let onboardingOrderStrs = config?.onboardingOrder ?? defaultOrder
        let onboardingOrders = onboardingOrderStrs.map { str in
            return OnboardingOrder(rawValue: str) ?? .emailpassword
        }
        return onboardingOrders
    }
}

extension WelcomeViewController: OnboardingDataStoreDelegate {
    func segueIntoApp() {}
    
    func showError(title: String, subtitle: String) {}
}

