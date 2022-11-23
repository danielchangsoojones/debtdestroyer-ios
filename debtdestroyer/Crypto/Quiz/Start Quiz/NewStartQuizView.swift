//
//  NewStartQuizView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 21/11/22.
//

import UIKit
import SwiftConfettiView

class NewStartQuizView: UIView {
    let topStackView = UIStackView()
    var inviteButton = UIButton()
    var continueButton = UIButton()
    var earnedAmountLbl = UILabel()
    var middleLbl = UILabel()
    let dailyChallengeLbl = UILabel()
    let dailyChallengeContainer = UIView()
    var triviaContainer = UIView()
    var triviaLbl = UILabel()
    let prizeLbl = UILabel()
    let triviaBottomStackView = UIStackView()
    var dayTimeLbl = UILabel()
    let prizeAmountLbl = UILabel()
    var shareButton = UIButton()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setScrollView()
        setContainerForDailyChallenge()
        setTopStackView()
        setEarnedAmounteLabel()
        setMiddleLabel()
        setInviteButton()
        setContainerForTrivia()
        setTriviaLbl()
        setPrizeAmountLbl()
        setTriviaBottomStackView()
        setShareButton()
        setDayTimeLabel()
        setPrizeAmountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        contentView.backgroundColor = .clear
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
            make.height.greaterThanOrEqualTo(800)
        }
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
        contentView.addSubview(topStackView)
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
        
//        let con = SwiftConfettiView(frame: self.bounds)
//        
//        con.backgroundColor = .blue
//        con.type = .triangle
//        con.intensity = 0.85
//        con.clipsToBounds = true
//        contentView.addSubview(con)
//        con.startConfetti()
        
        dailyChallengeContainer.backgroundColor = .yellow
        contentView.addSubview(dailyChallengeContainer)
        dailyChallengeContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.left.right.equalToSuperview().inset(10)
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
            make.width.equalTo(180)
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
    
    private func setContainerForTrivia() {
        triviaContainer.backgroundColor = .pestalGreen
        triviaContainer.layer.cornerRadius = 15
        contentView.addSubview(triviaContainer)
        triviaContainer.snp.makeConstraints { make in
            make.top.equalTo(dailyChallengeContainer.snp.bottom).offset(-30)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(350)
        }
        
        

    }
    
    private func setTriviaLbl(){
        triviaLbl.text = "HQ Trivia"
        triviaLbl.numberOfLines = 0
        triviaLbl.textAlignment = .center
        triviaLbl.textColor = .white
        triviaLbl.font = UIFont.MontserratBold(size: 32)
        triviaContainer.addSubview(triviaLbl)
        triviaLbl.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setPrizeAmountLbl(){
        prizeLbl.text = "$1,500 Prize!"
        prizeLbl.numberOfLines = 0
        prizeLbl.textAlignment = .center
        prizeLbl.textColor = .white
        prizeLbl.font = UIFont.MontserratSemiBold(size: 18)
        triviaContainer.addSubview(prizeLbl)
        prizeLbl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(triviaLbl.snp.bottom).offset(15)
        }
    }
    
    private func setTriviaBottomStackView() {
        triviaBottomStackView.axis = .horizontal
        triviaBottomStackView.distribution = .fill
        triviaBottomStackView.alignment = .leading
        triviaBottomStackView.spacing = 5
        triviaBottomStackView.backgroundColor = .red
        triviaContainer.addSubview(triviaBottomStackView)
        triviaBottomStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
       
    }
    
    func setShareButton(){
        if #available(iOS 15.0, *) {
            if shareButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Share", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
                shareButton.configuration = configuration
                
            } else {
                shareButton.configuration?.attributedTitle = AttributedString("Share", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 15),NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
            }
            
        } else {
            shareButton.setTitle("Share", for: .normal)
        }
//        shareButton.layer.cornerRadius =  20
//        shareButton.layer.borderColor = UIColor.gray.cgColor
//        shareButton.layer.borderWidth = 1
        shareButton.backgroundColor = .clear
        shareButton.clipsToBounds = true
        
        triviaBottomStackView.addArrangedSubview(shareButton)
        shareButton.snp.makeConstraints{ make in
            make.height.equalTo(40).priority(.high)
            make.centerY.equalTo(triviaBottomStackView)
//                        make.width.equalTo(90)
        }
    }
    
    private func setDayTimeLabel() {
        dayTimeLbl.text = "Thursday 4 pm".capitalized
        dayTimeLbl.numberOfLines = 0
        dayTimeLbl.textColor = .black
        dayTimeLbl.font = UIFont.MontserratSemiBold(size: 12)
        triviaBottomStackView.addArrangedSubview(dayTimeLbl)
        dayTimeLbl.snp.makeConstraints { make in
            make.centerY.equalTo(triviaBottomStackView)
//            make.width.equalTo(90)

        }
    }
    
    private func setPrizeAmountLabel() {
        prizeAmountLbl.text = "$1.5K"
        prizeAmountLbl.numberOfLines = 0
        prizeAmountLbl.textAlignment = .center
        prizeAmountLbl.textColor = .black
        prizeAmountLbl.font = UIFont.MontserratSemiBold(size: 16)
        triviaBottomStackView.addArrangedSubview(prizeAmountLbl)
        prizeAmountLbl.snp.makeConstraints { make in
            make.centerY.equalTo(triviaBottomStackView)
        }
    }
    
}
