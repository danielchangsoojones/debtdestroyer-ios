//
//  QuestionNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 26/09/22.
//

import UIKit

class QuestionView: UIView {
    let answerStackView = UIStackView()
    let questionLabel = UILabel()
    let questionNoLabel = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let quesImgView = UIImageView()
    private let leadingOffset: CGFloat = 20
    var timerLabel = UILabel()
    var circularView = CircularProgressCountdownTimerView()
    var backBtn = UIButton()
    let pointsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setScrollView()
        setUpProgressView()
        setTimerLabel()
        setBackButtonView()
        setPointsLabel()
//        setQuestionImgView()
        setQuestionNoLabel()
        setQuestionLabel()
        setStackView()
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
        timerLabel.textColor = .black
        timerLabel.font = UIFont.MontserratBold(size: 16)
        contentView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.center.equalTo(circularView)
        }
    }
    
    private func setBackButtonView() {
        backBtn.setTitle("ⓧ", for: .normal)
        backBtn.isHidden = true
        backBtn.setTitleColor(.black, for: .normal)
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
    
    private func setPointsLabel() {
        pointsLabel.text = " 0 Points "
        pointsLabel.textColor = .black
        pointsLabel.font = UIFont.MontserratRegular(size: 15)
        pointsLabel.textAlignment = .center
        pointsLabel.layer.borderColor = UIColor.black.cgColor
        pointsLabel.layer.borderWidth = 1
        pointsLabel.layer.cornerRadius = 15
        let dimenssion = 30
        contentView.addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.height.equalTo(dimenssion)
            make.width.equalTo(100)
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
        questionNoLabel.font = UIFont.MontserratRegular(size: 15)
        questionNoLabel.textColor = .black
        contentView.addSubview(questionNoLabel)
        questionNoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
//            make.top.equalTo(quesImgView.snp.bottom).offset(30)
            make.top.equalTo(circularView.snp.bottom).offset(50)

        }
    }
    
    private func setQuestionLabel() {
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.MontserratSemiBold(size: 20)
        questionLabel.textColor = .black
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
}
