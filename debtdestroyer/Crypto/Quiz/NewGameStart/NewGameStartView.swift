//
//  NewGameStartView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/11/22.
//

import UIKit

class NewGameStartView: UIView {
    var rippleContainer = UIView()
    var descContainer = UIView()
    var startLbl = UILabel()
    var countDownTimerLbl = UILabel()
    var dayDateLbl = UILabel()
    var headingLbl = UILabel()
    var descriptionLbl = UILabel()
    var prizeBtn = GradientBtn()
    var videoContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(videoContainer)
        setContainerForRipple()
        setCountDownTimerLabel()
        setStartLabel()
        setDayDateLabel()
        addImgView()
        setDescriptionContainer()
      
        setPrizeButton()
        setHeadingLabel()
        setDescriptionLabel()
        
        videoContainer.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(prizeBtn)
        }
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
    
    private func setContainerForRipple() {
        rippleContainer.backgroundColor = .clear
        let w = self.frame.width
        addSubview(rippleContainer)
        rippleContainer.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.width.height.equalTo(w)
            make.centerX.equalToSuperview()
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
        headingLbl.numberOfLines = 0
        headingLbl.text = "Compete in our live trivia."
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
        descriptionLbl.text = "Answer all 15 of our questions to win!"
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
