//
//  NewGameStartView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/11/22.
//

import UIKit
import Ripple

class NewGameStartView: UIView {
    var rippleContainer = UIView()
    var descContainer = UIView()
    var startLbl = UILabel()
    var countDownTimerLbl = UILabel()
    var dayDateLbl = UILabel()
    var headingLbl = UILabel()
    var descriptionLbl = UILabel()
    var prizeBtn = GradientBtn()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.setGradientBackground()
        setContainerForRipple()
        setCountDownTimerLabel()
        setStartLabel()
        setDayDateLabel()
        setDescriptionContainer()
      
        setPrizeButton()
        setHeadingLabel()
        setDescriptionLabel()

    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerForRipple() {
        rippleContainer.backgroundColor = .clear
        let w = self.frame.width
        addSubview(rippleContainer)
        rippleContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.width.height.equalTo(w)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setDescriptionContainer() {
        descContainer.backgroundColor = .white
        descContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        descContainer.layer.cornerRadius = 15
        descContainer.clipsToBounds = true
        addSubview(descContainer)
        descContainer.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setStartLabel() {
        startLbl.text = "NEXT GAME STARTING iN:"
        startLbl.numberOfLines = 0
        startLbl.textAlignment = .center
        startLbl.textColor = .white
        startLbl.font = UIFont.MontserratSemiBold(size: 25)
        rippleContainer.addSubview(startLbl)
        startLbl.snp.makeConstraints { make in
            make.bottom.equalTo(countDownTimerLbl.snp.top).offset(-20)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    private func setCountDownTimerLabel() {
        countDownTimerLbl.text = "0"
        countDownTimerLbl.numberOfLines = 0
        countDownTimerLbl.textAlignment = .center
        countDownTimerLbl.textColor = .white
        countDownTimerLbl.font = UIFont.MontserratBold(size: 35)
        rippleContainer.addSubview(countDownTimerLbl)
        countDownTimerLbl.snp.makeConstraints { make in
//            make.top.equalTo(startLbl.snp.bottom).offset(20)
//            make.left.right.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
    }
    
    private func setDayDateLabel() {
        dayDateLbl.text = "Tuesday Dec. 5th @ 6pm PDT"
        dayDateLbl.numberOfLines = 0
        dayDateLbl.textAlignment = .center
        dayDateLbl.textColor = .white
        dayDateLbl.font = UIFont.MontserratSemiBold(size: 16)
        rippleContainer.addSubview(dayDateLbl)
        dayDateLbl.snp.makeConstraints { make in
            make.top.equalTo(countDownTimerLbl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
        }
    }

    private func setHeadingLabel() {
        headingLbl.text = "Compete in our live trivia."
        headingLbl.numberOfLines = 0
        headingLbl.textAlignment = .left
        headingLbl.textColor = .black
        headingLbl.font = UIFont.MontserratSemiBold(size: 22)
        descContainer.addSubview(headingLbl)
        headingLbl.snp.makeConstraints { make in
            make.top.equalTo(prizeBtn.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLbl.text = "Answer all 12 questions correctly to win $1,000 towards your loans! If no one wins, the money rolls over to next week!"
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .left
        descriptionLbl.textColor = .black
        descriptionLbl.font = UIFont.MontserratRegular(size: 18)
        descContainer.addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(headingLbl.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func setPrizeButton() {
        let titletxt = " $1,000 Prize "
        if #available(iOS 15.0, *) {
            if prizeBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
                prizeBtn.configuration = configuration
                
            } else {
                prizeBtn.configuration?.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            prizeBtn.setTitleColor(.white, for: .normal)
            prizeBtn.setTitle(titletxt, for: .normal)
        }
        prizeBtn.layer.cornerRadius = 25
        prizeBtn.clipsToBounds = true
        prizeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
       
        descContainer.addSubview(prizeBtn)
        prizeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(30)
        }
    }

    
//    override func layoutSublayers(of layer: CALayer) {
//        super.layoutSublayers(of: self.layer)
//        let location = CGPoint.init(x: rippleContainer.frame.width/2, y: rippleContainer.frame.height/2)
//        //        ripple(location, view: rippleContainer, times: 5)
//        ripple(location, view: rippleContainer, times: 4, duration: 2, size: 100, multiplier: 4, divider: 3, color: .white, border: 2)
//    }
}
