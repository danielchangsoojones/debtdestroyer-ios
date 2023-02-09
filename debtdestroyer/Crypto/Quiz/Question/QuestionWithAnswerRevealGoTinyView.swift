//
//  QuestionWithAnswerRevealGoTinyView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 25/01/23.
//

import UIKit
import AVFoundation

class QuestionWithAnswerRevealGoTinyView: UIView {
    let answerStackView = UIStackView()
    let questionLabel = UILabel()
    let questionNoLabel = UILabel()
    let questionContentView = UIView()
    private let leadingOffset: CGFloat = 20
    var timerLabel = UILabel()
    let pointsLabel = UILabel()
    let playerLayer = AVPlayerLayer()
    let bottomView = UIView()
    let progressBarContainer = UIView()
    let revealAnswerContainer = UIView()
    let correctAnswerView = UIView()
    let yourAnswerView = UIView()
    let yourAnswerLabel = UILabel()
    let correctAnswerLabel = UILabel()
    let yourAnswerHeading = UILabel()
    let correctAnswerHeading = UILabel()
    var timerBar = UIProgressView()
    let intervieweeImageView = UIImageView()
    let soundOffContainer = UIView()
    let noSoundImageView = UIImageView()
    var soundOffTextLabel = UILabel()
    let closePopupButton = UIButton()
    let gifImgViewCheckMark = UIImageView()
    let gifImgViewXmark = UIImageView()
    let helpButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addVideoLayer()
        setPointsLabel()
        setUpSoundOffContainer()
        setHelpButton()
        setQuestionNoLabel()
        addIntervieweeImageView()
        setBottomView()
        setUpProgressBarContainer()
        setUpRevealAnswerContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVideoLayer() {
        questionContentView.backgroundColor = .clear
        addSubview(questionContentView)
        questionContentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(self)
            make.height.greaterThanOrEqualTo(800)
        }
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.bounds
        
        self.layer.insertSublayer(playerLayer, at: 0)
        self.backgroundColor = .clear.withAlphaComponent(0.5)
    }
    
    private func setTimerLabel() {
        timerLabel.numberOfLines = 0
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.font = UIFont.MontserratBold(size: 16)
        questionContentView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.center.equalTo(timerBar)
        }
    }
    
    private func setPointsLabel() {
        pointsLabel.text = " 0 Points "
        pointsLabel.textColor = .white
        pointsLabel.font = UIFont.MontserratRegular(size: 15)
        pointsLabel.textAlignment = .center
        pointsLabel.layer.borderColor = UIColor.white.cgColor
        pointsLabel.layer.borderWidth = 1
        pointsLabel.layer.cornerRadius = 15
        let dimenssion = 30
        addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.height.equalTo(dimenssion)
            make.width.equalTo(100)
            make.topMargin.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setHelpButton() {
        helpButton.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            if helpButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("help?", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratRegular(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                helpButton.configuration = configuration
                
            } else {
                helpButton.configuration?.attributedTitle = AttributedString("help?", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratRegular(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            helpButton.setTitleColor(.white, for: .normal)
            helpButton.setTitle("help?", for: .normal)
        }
        addSubview(helpButton)
        helpButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.topMargin.equalToSuperview().offset(30)
            make.leading.equalToSuperview().inset(15)
        }
    }
    
    
    private func setQuestionNoLabel() {
        questionNoLabel.numberOfLines = 0
        questionNoLabel.isHidden = true
        questionNoLabel.font = UIFont.MontserratRegular(size: 15)
        questionNoLabel.textColor = .black
        questionContentView.addSubview(questionNoLabel)
        questionNoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.topMargin.equalToSuperview().offset(80)
            
        }
    }
    
    private func setBottomView() {
        bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        questionContentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomView.alpha = 0.0
        setQuestionLabel()
        setStackView()
    }
    
    private func setQuestionLabel() {
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.MontserratSemiBold(size: 25)
        questionLabel.textColor = .white
        bottomView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setUpProgressBarContainer() {
        progressBarContainer.backgroundColor = .clear
        questionContentView.addSubview(progressBarContainer)
        progressBarContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
            make.height.equalTo(35)
        }
        
        setUpTimerBar()
        setTimerLabel()
        
    }
    
    private func setUpSoundOffContainer() {
        soundOffContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        soundOffContainer.isHidden = true
        soundOffContainer.layer.cornerRadius = 20
        questionContentView.addSubview(soundOffContainer)
        soundOffContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.topMargin.equalToSuperview().inset(35)
            make.height.equalTo(60)
            make.width.equalTo(240)
        }
        
        setSoundOffImage()
        setButtonToClosePopup()
        setSoundOffTextLabel()
        
    }
    
    private func setSoundOffImage() {
        noSoundImageView.image = UIImage(named: "no-sound")
        noSoundImageView.contentMode = .scaleAspectFill
        noSoundImageView.backgroundColor = .clear
        soundOffContainer.addSubview(noSoundImageView)
        noSoundImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setButtonToClosePopup() {
        closePopupButton.setTitle("X", for: .normal)
        closePopupButton.setTitleColor(.white, for: .normal)
        soundOffContainer.addSubview(closePopupButton)
        closePopupButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setSoundOffTextLabel() {
        soundOffTextLabel.text = "Sound is off. Turn up your volume to hear."
        soundOffTextLabel.numberOfLines = 0
        soundOffTextLabel.textAlignment = .left
        soundOffTextLabel.textColor = .white
        soundOffTextLabel.font = UIFont.MontserratRegular(size: 14)
        soundOffTextLabel.adjustsFontSizeToFitWidth = true
        soundOffContainer.addSubview(soundOffTextLabel)
        soundOffTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(noSoundImageView.snp.trailing).offset(10)
            make.trailing.equalTo(closePopupButton.snp.leading).offset(-10)
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func setUpTimerBar() {
        timerBar.trackTintColor = .clear
        timerBar.progressTintColor = .purple
        timerBar.progress = 0.0
        progressBarContainer.addSubview(timerBar)
        
        timerBar.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setStackView() {
        answerStackView.axis = .vertical
        answerStackView.alignment = .center
        answerStackView.distribution = .fillEqually
        answerStackView.spacing = 15
        bottomView.addSubview(answerStackView)
        answerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(questionLabel)
            make.top.equalTo(questionLabel.snp.bottom).offset(15)
            make.height.equalTo(250)
            make.bottomMargin.equalToSuperview()
        }
    }
    
    private func addIntervieweeImageView() {
        intervieweeImageView.contentMode = .scaleAspectFit
        intervieweeImageView.alpha  = 0.0
        questionContentView.addSubview(intervieweeImageView)
        intervieweeImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func setUpRevealAnswerContainer() {
        revealAnswerContainer.alpha = 0.0
        revealAnswerContainer.backgroundColor = .clear
        questionContentView.addSubview(revealAnswerContainer)
        revealAnswerContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(200)
        }
      
        setCorrectAnswerHeadingLabel()
        setYourAnswerHeadingLabel()
        setUpCorrectAnswerView()
        setUpYourAnswerView()
        setCorrectAnswerLabel()
        setGifImage(gifImgView: gifImgViewCheckMark, subviewTo: correctAnswerView, bottomTo: correctAnswerLabel, imageName: "checkmark")
        setYourAnswerLabel()
        setGifImage(gifImgView: gifImgViewXmark, subviewTo: yourAnswerView, bottomTo: yourAnswerLabel, imageName: "xmark")
    }
    
    private func setCorrectAnswerHeadingLabel() {
        correctAnswerHeading.text = "Correct Answer:"
        correctAnswerHeading.textAlignment = .center
        correctAnswerHeading.numberOfLines = 1
        correctAnswerHeading.font = UIFont.MontserratSemiBold(size: 21)
        correctAnswerHeading.textColor = .white
        revealAnswerContainer.addSubview(correctAnswerHeading)
        correctAnswerHeading.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(10)
            make.width.equalTo(self.frame.size.width / 2)
        }
    }
    
    private func setYourAnswerHeadingLabel() {
        yourAnswerHeading.text = "Your Answer:"
        yourAnswerHeading.textAlignment = .center
        yourAnswerHeading.numberOfLines = 1
        yourAnswerHeading.font = UIFont.MontserratSemiBold(size: 21)
        yourAnswerHeading.textColor = .white
        revealAnswerContainer.addSubview(yourAnswerHeading)
        yourAnswerHeading.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(correctAnswerHeading.snp.top)
            make.width.equalTo(self.frame.size.width / 2)
        }
    }
    
    private func setUpCorrectAnswerView() {
        correctAnswerView.backgroundColor = .clear
        revealAnswerContainer.addSubview(correctAnswerView)
        correctAnswerView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(correctAnswerHeading.snp.bottom).offset(15)
            make.width.equalTo((self.frame.size.width / 2 ) - 40)
        }
    }
    
    private func setUpYourAnswerView() {
        yourAnswerView.alpha = 0.0
        yourAnswerView.backgroundColor = .clear
        revealAnswerContainer.addSubview(yourAnswerView)
        yourAnswerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo((self.frame.size.width / 2 ) - 40)
        }
    }
    
    private func setCorrectAnswerLabel() {
        correctAnswerLabel.numberOfLines = 2
        correctAnswerLabel.textAlignment = .center
        correctAnswerLabel.font = UIFont.MontserratSemiBold(size: 21)
        correctAnswerLabel.textColor = .black
        correctAnswerView.addSubview(correctAnswerLabel)
        correctAnswerLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(90)
        }
    }
    
    private func setYourAnswerLabel() {
        yourAnswerLabel.numberOfLines = 2
        yourAnswerLabel.textAlignment = .center
        yourAnswerLabel.font = UIFont.MontserratSemiBold(size: 21)
        yourAnswerLabel.textColor = .black
        yourAnswerView.addSubview(yourAnswerLabel)
        yourAnswerLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(90)
        }
    }
    
    func setGifImage(gifImgView: UIImageView, subviewTo: UIView, bottomTo: UILabel, imageName: String) {
        gifImgView.image = UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        gifImgView.tintColor = .black
        gifImgView.alpha = 0.2
        UIImageView.animate(withDuration: 1, animations: {
            gifImgView.alpha = 1
        })
        gifImgView.backgroundColor = .clear
        subviewTo.addSubview(gifImgView)
        gifImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalTo(bottomTo.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
    }
    
}
