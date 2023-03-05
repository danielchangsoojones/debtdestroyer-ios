//
//  WelcomeView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import SnapKit

class WelcomeView: UIView {
    private var stackView: UIStackView!
    private var logInView: UIView!
    var logInButton: UIButton!
    var signUpButton: GradientBtn!
    var termsAndPolicyLabel = UILabel()
    var loginBtn = UIButton()
    var titleLabel = UILabel()

    var color1 = UIColor()
    var color2 = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
       
        addLogInView()
        addButtons()
        setLabelForTermsPolicy()
        addLogo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLogInView() {
        logInView = UIView()
        logInView.backgroundColor = .white
        addSubview(logInView)
        logInView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView = UIStackView()
        stackView.spacing = 9
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        logInView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(40)
            make.top.equalTo(logInView.snp.top).inset(20)
        }
    }
    
    func setSignupBtn() {
        signUpButton = GradientBtn()
        if #available(iOS 15.0, *) {
            if signUpButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Sign Up", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.white]))
                signUpButton.configuration = configuration
                
            } else {
                signUpButton.configuration?.attributedTitle = AttributedString("Sign Up", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.setTitle("Sign Up", for: .normal)
        }
        signUpButton.layer.cornerRadius =  8
        signUpButton.clipsToBounds = true
        let horizontalInset: CGFloat = 20
        let verticalInset: CGFloat = 20
        signUpButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        stackView.addArrangedSubview(signUpButton)
        signUpButton.snp.makeConstraints{ make in
            make.height.equalTo(signUpButton.snp.width).multipliedBy(0.34)
        }
    }
    
    func setLoginBtn(){
        logInButton = UIButton()
        if #available(iOS 15.0, *) {
            if logInButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Log In", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "FF2474")]))
                logInButton.configuration = configuration
                
            } else {
                logInButton.configuration?.attributedTitle = AttributedString("Log In", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "FF2474")]))
            }
            
        } else {
            logInButton.setTitle("Log In", for: .normal)
        }
        logInButton.layer.cornerRadius =  8
        logInButton.backgroundColor = .clear
        logInButton.clipsToBounds = true
        let horizontalInset: CGFloat = 20
        let verticalInset: CGFloat = 20
        logInButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        stackView.addArrangedSubview(logInButton)
        logInButton.snp.makeConstraints{ make in
            make.height.equalTo(logInButton.snp.width).multipliedBy(0.34)
        }
        
      
       
    }
 
    private func setLabelForTermsPolicy() {
        termsAndPolicyLabel.textColor = .black
        termsAndPolicyLabel.numberOfLines = 1
        termsAndPolicyLabel.textAlignment = .center
        termsAndPolicyLabel.font = UIFont.MontserratRegular(size: 10)
        termsAndPolicyLabel.adjustsFontSizeToFitWidth = true
        termsAndPolicyLabel.minimumScaleFactor = 0.5
        termsAndPolicyLabel.isUserInteractionEnabled = true
        
        let attributedString = NSMutableAttributedString(string: "By signing up, you agree to our Terms of Service and Privacy Policy")
        let text = "By signing up, you agree to our Terms of Service and Privacy Policy"
        let str = NSString(string: text)
        let theRangeTerm = str.range(of: "Terms of Service")
        let theRangePolicy = str.range(of: "Privacy Policy")
        
        attributedString.addAttribute(.underlineStyle, value: 1, range: theRangeTerm)
        attributedString.addAttribute(.underlineStyle, value: 1, range: theRangePolicy)
        
        termsAndPolicyLabel.attributedText = attributedString
        termsAndPolicyLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        logInView.addSubview(termsAndPolicyLabel)
        termsAndPolicyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(stackView.snp.top).offset(-10)
        }
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let text = "By signing up, you agree to our Terms of Service and Privacy Policy"
        let str = NSString(string: text)
        let theRangeTerm = str.range(of: "Terms of Service")
        let theRangePolicy = str.range(of: "Privacy Policy")
        let url = URL(string: "https://www.debtdestroyer.app/privacy-policy")!
        let urlTerm = URL(string: "https://www.debtdestroyer.app/terms-and-services")!
        if gesture.didTapAttributedTextInLabel(label: termsAndPolicyLabel, inRange: theRangeTerm) {
            UIApplication.shared.open(urlTerm)
        } else if gesture.didTapAttributedTextInLabel(label: termsAndPolicyLabel, inRange: theRangePolicy) {
            UIApplication.shared.open(url)
        } else {
            print("Tapped none")
        }
    }
    
    private func addButtons() {
        setLoginBtn()
        setSignupBtn()
    }

    private func addLogo() {
        let logoImageView = UIImageView()
        if let logoImage = UIImage(named: "logo") {
            logoImageView.image = logoImage
            logoImageView.contentMode = .scaleAspectFit
            addSubview(logoImageView)
            logoImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview().inset(150)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(self.frame.width * 0.5)
            }
        }
        
        titleLabel.text = Helpers.getAppDisplayNameStr()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.MontserratBold(size: 30)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
        }
    }
}
