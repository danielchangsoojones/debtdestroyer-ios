//
//  ReminderTextNotificationView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/02/23.
//

import UIKit
import TTTAttributedLabel

class ReminderTextNotificationView: UIView, TTTAttributedLabelDelegate  {
    let scrollView = UIScrollView()
    let contentView = UIView()
    var noThanksButton: UIButton!
    var enableButton: GradientBtn!
    var startLbl = UILabel()
    let imgView = UIImageView()
    var descriptionLbl : TTTAttributedLabel!

    
    var viewContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setViewContainer()
        setNoThanksBtn()
        setEnableReminderTextBtn()
        setScrollView()

        setStartLabel()
        setImgView()
        setDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewContainer() {
        viewContainer.backgroundColor = .white
        viewContainer.layer.cornerRadius = 20
        addSubview(viewContainer)
        viewContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(180)
            make.bottom.equalToSuperview().inset(100)
        }
    }

    
    private func setScrollView() {
        scrollView.backgroundColor = .white
        viewContainer.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview()
            make.bottom.equalTo(enableButton.snp.top).offset(-20)
        }
        
        contentView.backgroundColor = .clear
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self).inset(15)
        }
    }
    
    private func setStartLabel() {
        startLbl.text = "Reminder Texts Before Every Game"
        startLbl.numberOfLines = 0
        startLbl.textAlignment = .left
        startLbl.textColor = .black
        startLbl.font = UIFont.MontserratSemiBold(size: 30)
        contentView.addSubview(startLbl)
        startLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setImgView() {
        imgView.image = UIImage.init(named: "textNoti")
        imgView.contentMode = .scaleAspectFill
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.equalTo(startLbl.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(322)
            make.height.equalTo(275)

        }
    }
        
    private func setDescriptionLabel() {
        
        
        descriptionLbl = TTTAttributedLabel.init(frame: .zero)
        descriptionLbl.textColor = .black
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .left
        descriptionLbl.font = UIFont.MontserratRegular(size: 18)
        descriptionLbl.isUserInteractionEnabled = true
        
        
        
        
        
        let text = "By enabling, you authorize Debt Destroyer to send recurring automated reminder messages at the mobile number used to sign up. Consent is not a condition of any purchase. Reply HELP for help and STOP to cancel. Msg frequency varies. Msg and data rates may apply. Privacy Policy Terms of Use Questions: danieljones@nomadmoments.com"
        let str = NSString(string: text)
        let theRangeTerm = str.range(of: "Terms of Use")
        let theRangePolicy = str.range(of: "Privacy Policy")
        
        let attributedString = NSMutableAttributedString(string:text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor, NSAttributedString.Key.font:  UIFont.MontserratRegular(size: 18)])
        attributedString.addAttribute(.underlineStyle, value: 1, range: theRangeTerm)
        attributedString.addAttribute(.underlineStyle, value: 1, range: theRangePolicy)
        
        let urlTerm = URL(string: "https://www.debtdestroyer.app/terms-and-services")!

        descriptionLbl.addLink(to: urlTerm, with: theRangePolicy)
        descriptionLbl.addLink(to: urlTerm, with: theRangeTerm)

        descriptionLbl.attributedText = attributedString
        descriptionLbl.delegate = self
        
        contentView.addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(imgView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "https://www.debtdestroyer.app/terms-and-services" {
            UIApplication.shared.open(url)
        } else {
            print("Tapped none")
        }
    }
    
    
    func setEnableReminderTextBtn() {
        enableButton = GradientBtn()
        if #available(iOS 15.0, *) {
            if enableButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Enable Reminder Texts", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
                enableButton.configuration = configuration
                
            } else {
                enableButton.configuration?.attributedTitle = AttributedString("Enable Reminder Texts", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            enableButton.setTitleColor(.white, for: .normal)
            enableButton.setTitle("Enable Reminder Texts", for: .normal)
        }
        enableButton.layer.cornerRadius =  25
        enableButton.clipsToBounds = true
     
        
        viewContainer.addSubview(enableButton)
        enableButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(noThanksButton.snp.top).offset(-15)
        }
    }
    
    func setNoThanksBtn(){
        noThanksButton = UIButton()
        if #available(iOS 15.0, *) {
            if noThanksButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("No Thanks", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "EC595C")]))
                noThanksButton.configuration = configuration
                
            } else {
                noThanksButton.configuration?.attributedTitle = AttributedString("No Thanks", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "EC595C")]))
            }
            
        } else {
            noThanksButton.setTitle("No Thanks", for: .normal)
        }
        noThanksButton.layer.cornerRadius =  8
        noThanksButton.backgroundColor = .clear
        noThanksButton.clipsToBounds = true
        let horizontalInset: CGFloat = 20
        let verticalInset: CGFloat = 20
        noThanksButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        viewContainer.addSubview(noThanksButton)
        noThanksButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(10)
        }
     
    }

    
    
}
