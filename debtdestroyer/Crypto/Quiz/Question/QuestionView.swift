//
//  QuestionNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit
import AVFoundation

class QuestionView: UIView {
    let answerStackView = UIStackView()
    let questionLabel = UILabel()
    let questionNoLabel = UILabel()
    let contentView = UIView()
    private let leadingOffset: CGFloat = 20
    var timerLabel = UILabel()
    let pointsLabel = UILabel()
    let playerLayer = AVPlayerLayer()
    let bottomView = UIView()
    let progressBarContainer = UIView()
    var timerBar = UIProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addVideoLayer()
        setPointsLabel()
        setQuestionNoLabel()
        setBottomView()
        setUpProgressBarContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVideoLayer() {
        contentView.backgroundColor = .clear
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(self)
            make.height.greaterThanOrEqualTo(800)
        }
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.bounds
        
        contentView.layer.addSublayer(playerLayer)
        contentView.backgroundColor = .clear.withAlphaComponent(0.5)
    }
    
    private func setTimerLabel() {
        timerLabel.numberOfLines = 0
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.font = UIFont.MontserratBold(size: 16)
        contentView.addSubview(timerLabel)
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
        contentView.addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.height.equalTo(dimenssion)
            make.width.equalTo(100)
            make.topMargin.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setQuestionNoLabel() {
        questionNoLabel.numberOfLines = 0
        questionNoLabel.isHidden = true
        questionNoLabel.font = UIFont.MontserratRegular(size: 15)
        questionNoLabel.textColor = .black
        contentView.addSubview(questionNoLabel)
        questionNoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.topMargin.equalToSuperview().offset(80)

        }
    }
    
    private func setBottomView() {
        bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
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
        contentView.addSubview(progressBarContainer)
        progressBarContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
            make.height.equalTo(50)
        }
        
        setUpTimerBar()
        setTimerLabel()

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
}
