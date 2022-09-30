//
//  QuestionNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit

class QuestionNewUIView: UIView {
    let answerStackView = UIStackView()
    let questionLabel = UILabel()
    let questionNoLabel = UILabel()
    let submitBtn = UIButton()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let quesImgView = UIImageView()
    private let leadingOffset: CGFloat = 20
    var timerLabel = UILabel()
    var circularView = CircularProgressCountdownTimerView()
    var backBtn = UIButton()
    let favLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .blue
        setScrollView()
        setUpProgressView()
        setTimerLabel()
        setBackButtonView()
        setFavLabel()
        setQuestionImgView()
        setQuestionNoLabel()
        setQuestionLabel()
        setStackView()
//        setSubmitBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScrollView() {
        scrollView.backgroundColor = .clear
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
    
    private func setUpProgressView() {
        contentView.addSubview(circularView)
        circularView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setTimerLabel() {
        timerLabel.text = "15"
        timerLabel.numberOfLines = 0
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.center.equalTo(circularView)
        }
    }
    
    private func setBackButtonView() {
        backBtn.setTitle("ⓧ", for: .normal)
        backBtn.isHidden = true
        backBtn.setTitleColor(.white, for: .normal)
        backBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        backBtn.backgroundColor = .clear
        let dimenssion = 30
        contentView.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.height.width.equalTo(dimenssion)
            make.centerY.equalTo(circularView)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setFavLabel() {
        favLabel.text = " ♥ 3 "
        favLabel.textColor = .white
        favLabel.isHidden = true
        favLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        favLabel.textAlignment = .center
        favLabel.layer.borderColor = UIColor.white.cgColor
        favLabel.layer.borderWidth = 1
        favLabel.layer.cornerRadius = 15
        let dimenssion = 30
        contentView.addSubview(favLabel)
        favLabel.snp.makeConstraints { make in
            make.height.equalTo(dimenssion)
            make.width.equalTo(50)
            make.centerY.equalTo(circularView)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func setQuestionImgView() {
        quesImgView.image = UIImage.init(named: "coffee")
        quesImgView.contentMode = .scaleAspectFit
        contentView.addSubview(quesImgView)
        quesImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
            make.top.equalTo(circularView.snp.bottom).offset(50)
        }
    }
    
    private func setQuestionNoLabel() {
        questionNoLabel.numberOfLines = 0
        questionNoLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        questionNoLabel.textColor = .white
        contentView.addSubview(questionNoLabel)
        questionNoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(quesImgView.snp.bottom).offset(30)
        }
    }
    
    private func setQuestionLabel() {
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        questionLabel.textColor = .white
        contentView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(questionNoLabel.snp.bottom).offset(10)
        }
    }
    
    private func setStackView() {
        answerStackView.axis = .vertical
        answerStackView.alignment = .center
        answerStackView.distribution = .fillEqually
        answerStackView.spacing = 15
        contentView.addSubview(answerStackView)
        answerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(questionLabel)
            make.top.equalTo(questionLabel.snp.bottom).offset(30)
            make.height.equalTo(250)
        }
    }
    
    
//    private func setSubmitBtn() {
//        let coinbaseBlue = UIColor(red: 64 / 255.0, green: 124 / 255.0, blue: 232 / 255.0, alpha: 1)
//        submitBtn.backgroundColor = coinbaseBlue
//        let height: CGFloat = 50
//        submitBtn.layer.cornerRadius = height / 2
//        submitBtn.setTitle("Submit", for: .normal)
//        submitBtn.setTitleColor(.white, for: .normal)
//        contentView.addSubview(submitBtn)
//        submitBtn.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview().offset(-10)
//            make.height.equalTo(50)
//        }
//    }
}
