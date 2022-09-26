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
    var backImgView = UIImageView()
    let favLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        setScrollView()
        setUpProgressView()
        setBackImageView()
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
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
            make.height.greaterThanOrEqualTo(1500)
        }
    }
    
    private func setUpProgressView() {
        contentView.addSubview(circularView)
        circularView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    func setBackImageView() {
        backImgView.image = UIImage.init(named: "cancel")// Close icon with white tint download
        backImgView.backgroundColor = .white
        let dimenssion = 35
        contentView.addSubview(backImgView)
        backImgView.snp.makeConstraints { make in
            make.height.width.equalTo(dimenssion)
            make.centerY.equalTo(circularView)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    func setFavLabel() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "cancel")// Heart icon download
        let attachmentString = NSAttributedString(attachment: attachment)
        let lblString = NSMutableAttributedString(string: "")
        lblString.append(attachmentString)
        let count = NSMutableAttributedString(string: " 3")
        lblString.append(count)
        favLabel.attributedText = lblString
        favLabel.textColor = .black
        favLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        favLabel.textAlignment = .right
        let dimenssion = 35
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
        questionNoLabel.text = "question 5 of 10"
        questionNoLabel.numberOfLines = 0
        questionNoLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        questionNoLabel.textColor = .white
        contentView.addSubview(questionNoLabel)
        questionNoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(quesImgView.snp.bottom).offset(20)
        }
    }
    
    private func setQuestionLabel() {
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        questionLabel.textColor = .white
        contentView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(questionNoLabel.snp.bottom).offset(20)
        }
    }
    
    private func setStackView() {
        answerStackView.axis = .vertical
        answerStackView.alignment = .leading
        answerStackView.distribution = .fillProportionally
        answerStackView.spacing = 5
        contentView.addSubview(answerStackView)
        answerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(questionLabel)
            make.top.equalTo(questionLabel.snp.bottom).offset(50)
            make.height.equalTo(300)
        }
    }
    
    func setTimerLabel() {
        timerLabel.text = "10"
        timerLabel.numberOfLines = 0
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.center).offset(100)
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