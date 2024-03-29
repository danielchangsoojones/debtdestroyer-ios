//
//  AppleTesterView.swift
//  debtdestroyer
//
//  Created by DK on 4/18/23.
//

import UIKit
import TTTAttributedLabel

class AppleTesterView: UIView, TTTAttributedLabelDelegate {
    var descContainer = UIView()
    var startLbl = UILabel()
    var countDownTimerLbl = UILabel()
    var dayDateLbl = UILabel()
    var headingLbl = UILabel()
    var descriptionLbl = UILabel()
    var tiebreakerRuleLbl : TTTAttributedLabel!
    var prizeBtn = GradientBlueButton()
    var videoContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setContainerForVideo()
        setStartLabel()
        setCountDownTimerLabel()
        setDayDateLabel()
        setDescriptionContainer()
        
        setPrizeButton()
        setTiebreakerRuleLabel()
        setHeadingLabel()
        setDescriptionLabel()
        
    }
    
    private func addImgView() {
        //        let img = UIImage(named: "backgroundShadow")
        //        let imgView = UIImageView(image: img)
        //        imgView.contentMode = .scaleAspectFill
        //        self.addSubview(imgView)
        //        imgView.snp.makeConstraints { make in
        //            make.leading.trailing.bottomMargin.equalToSuperview()
        //            make.top.equalTo(650)
        //        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerForVideo() {
        addSubview(videoContainer)
        videoContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDescriptionContainer() {
        descContainer.backgroundColor = .clear
        descContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        descContainer.layer.cornerRadius = 15
        descContainer.clipsToBounds = true
        
        //        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        //        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //        blurEffectView.alpha = 0.5
        //        blurEffectView.frame = descContainer.bounds
        //        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        descContainer.addSubview(blurEffectView)
        
        addSubview(descContainer)
        descContainer.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setStartLabel() {
        startLbl.text = "NEXT GAME STARTING IN:"
        startLbl.numberOfLines = 0
        startLbl.textAlignment = .center
        startLbl.textColor = .white
        startLbl.font = UIFont.MontserratSemiBold(size: 25)
        videoContainer.addSubview(startLbl)
        startLbl.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    private func setCountDownTimerLabel() {
        countDownTimerLbl.text = "0"
        countDownTimerLbl.numberOfLines = 0
        countDownTimerLbl.textAlignment = .center
        countDownTimerLbl.textColor = .white
        countDownTimerLbl.font = UIFont.MontserratBold(size: 35)
        videoContainer.addSubview(countDownTimerLbl)
        countDownTimerLbl.snp.makeConstraints { make in
            make.top.equalTo(startLbl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func setDayDateLabel() {
        dayDateLbl.numberOfLines = 0
        dayDateLbl.textAlignment = .center
        dayDateLbl.textColor = .white
        dayDateLbl.font = UIFont.MontserratSemiBold(size: 16)
        videoContainer.addSubview(dayDateLbl)
        dayDateLbl.snp.makeConstraints { make in
            make.top.equalTo(countDownTimerLbl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    private func setHeadingLabel() {
        headingLbl.numberOfLines = 0
        headingLbl.text = "Compete in our live trivia."
        headingLbl.textAlignment = .left
        headingLbl.textColor = .white
        headingLbl.font = UIFont.MontserratSemiBold(size: 22)
        descContainer.addSubview(headingLbl)
        headingLbl.snp.makeConstraints { make in
            make.top.equalTo(prizeBtn.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLbl.text = "Answer all 15 of our questions to win!"
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .left
        descriptionLbl.textColor = .white
        descriptionLbl.font = UIFont.MontserratRegular(size: 18)
        descContainer.addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(headingLbl.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(tiebreakerRuleLbl.snp.top).offset(-15)
        }
    }
    
    private func setTiebreakerRuleLabel() {
        tiebreakerRuleLbl = TTTAttributedLabel.init(frame: .zero)
        tiebreakerRuleLbl.numberOfLines = 0
        tiebreakerRuleLbl.textAlignment = .left
        tiebreakerRuleLbl.isUserInteractionEnabled = true
        
        let text = "See tiebreaker rules."
        let str = NSString(string: text)
        let theRange = str.range(of: "tiebreaker rules")
        let attributedString = NSMutableAttributedString(string:text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.cgColor, NSAttributedString.Key.font:  UIFont.MontserratRegular(size: 18)])
        attributedString.addAttribute(.underlineStyle, value: 1, range: theRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: theRange)
        
        let url = URL(string: "https://www.debtdestroyer.app/tie-breaker-rules")!
        
        tiebreakerRuleLbl.addLink(to: url, with: theRange)
        tiebreakerRuleLbl.attributedText = attributedString
        tiebreakerRuleLbl.delegate = self
        descContainer.addSubview(tiebreakerRuleLbl)
        tiebreakerRuleLbl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "https://www.debtdestroyer.app/tie-breaker-rules" {
            UIApplication.shared.open(url)
        } else {
            print("Tapped none")
        }
    }
    
    private func setPrizeButton() {
        prizeBtn.layer.cornerRadius = 33
        prizeBtn.clipsToBounds = true
        prizeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        descContainer.addSubview(prizeBtn)
        prizeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(66)
            make.width.greaterThanOrEqualTo(66)
            make.top.equalToSuperview().offset(30)
        }
    }
    
}
