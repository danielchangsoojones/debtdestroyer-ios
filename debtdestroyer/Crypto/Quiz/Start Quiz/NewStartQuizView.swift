//
//  NewStartQuizView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 21/11/22.
//

import UIKit

class NewStartQuizView: UIView {
    let topStackView = UIStackView()
    var inviteButton = UIButton()
    var continueButton = UIButton()
    var earnedAmountLbl = UILabel()
    var middleLbl = UILabel()
    let dailyChallengeLbl = UILabel()
    let dailyChallengeContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setContainerForDailyChallenge()
        setTopStackView()
        setEarnedAmounteLabel()
        setMiddleLabel()
        setInviteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTopStackView() {
        
        topStackView.axis = .horizontal
        topStackView.distribution = .fill
        topStackView.alignment = .leading
        topStackView.spacing = 5
        topStackView.backgroundColor = .systemGray6
        topStackView.layer.borderColor = UIColor.darkGray.cgColor
        topStackView.layer.borderWidth = 1
        topStackView.layer.cornerRadius = 30
        addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(60)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
        
    
        
    }
    
    private func setEarnedAmounteLabel() {
        earnedAmountLbl.text = "$0"
        earnedAmountLbl.numberOfLines = 0
        earnedAmountLbl.textAlignment = .center
        earnedAmountLbl.textColor = .black
        earnedAmountLbl.font = UIFont.MontserratSemiBold(size: 16)
        topStackView.addArrangedSubview(earnedAmountLbl)
        earnedAmountLbl.snp.makeConstraints { make in
            make.centerY.equalTo(topStackView)
        }
    }
    
    func setMiddleLabel() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "Tickets")
        let attachmentString = NSAttributedString(attachment: attachment)
        let lblString = NSMutableAttributedString(string: "")
        lblString.append(attachmentString)
        let space = NSMutableAttributedString(string: " 4")
        lblString.append(space)
        middleLbl.attributedText = lblString
        middleLbl.textColor = .black
        middleLbl.font = UIFont.MontserratRegular(size: 10)
        middleLbl.textAlignment = .right
        topStackView.addArrangedSubview(middleLbl)
        middleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(topStackView)
//            make.width.equalTo(50)
        }
    }
    
    func setInviteButton(){
        inviteButton = UIButton()
        if #available(iOS 15.0, *) {
            if inviteButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Invite", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
                inviteButton.configuration = configuration
                
            } else {
                inviteButton.configuration?.attributedTitle = AttributedString("Invite", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
            }
            
        } else {
            inviteButton.setTitle("Invite", for: .normal)
        }
        inviteButton.layer.cornerRadius =  20
        inviteButton.backgroundColor = .clear
        inviteButton.clipsToBounds = true
        
        topStackView.addArrangedSubview(inviteButton)
        inviteButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.centerY.equalTo(topStackView)
//            make.width.equalTo(90)
        }
    }
    
    private func setContainerForDailyChallenge() {
        dailyChallengeContainer.backgroundColor = .yellow
        addSubview(dailyChallengeContainer)
        dailyChallengeContainer.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(90)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(350)
        }
//        playVideo(from: "PexelsVideos.mp4", playerLayerOn: dailyChallengeContainer)
        setChallengeLbl()
        setContinueButton()
        
    }
    
    private func setChallengeLbl(){
        dailyChallengeLbl.text = "Daily Challenge"
        dailyChallengeLbl.numberOfLines = 0
        dailyChallengeLbl.textAlignment = .center
        dailyChallengeLbl.textColor = .black
        dailyChallengeLbl.font = UIFont.MontserratBold(size: 32)
        dailyChallengeContainer.addSubview(dailyChallengeLbl)
        dailyChallengeLbl.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setContinueButton(){
        if #available(iOS 15.0, *) {
            if continueButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Continue", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
                continueButton.configuration = configuration
                
            } else {
                continueButton.configuration?.attributedTitle = AttributedString("Continue", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
            }
            
        } else {
            continueButton.setTitle("Continue", for: .normal)
        }
        continueButton.layer.cornerRadius =  20
        continueButton.backgroundColor = .topBlue
        continueButton.clipsToBounds = true
        
        dailyChallengeContainer.addSubview(continueButton)
        continueButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.top.equalTo(dailyChallengeLbl.snp.bottom).offset(30)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
    }
    
}
