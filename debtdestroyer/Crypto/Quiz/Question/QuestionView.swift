//
//  QuestionView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class QuestionView: UIView {
    let answerStackView = UIStackView()
    let questionLabel = UILabel()
    let submitBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setQuestionLabel()
        setStackView()
        setSubmitBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setQuestionLabel() {
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        questionLabel.textColor = .white
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.topMargin.equalToSuperview().offset(20)
        }
    }
    
    private func setStackView() {
        answerStackView.axis = .vertical
        answerStackView.alignment = .leading
        answerStackView.distribution = .fillProportionally
        answerStackView.spacing = 5
        addSubview(answerStackView)
        answerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(questionLabel)
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.height.equalTo(300)
        }
    }
    
    private func setSubmitBtn() {
        let coinbaseBlue = UIColor(red: 64 / 255.0, green: 124 / 255.0, blue: 232 / 255.0, alpha: 1)
        submitBtn.backgroundColor = coinbaseBlue
        let height: CGFloat = 50
        submitBtn.layer.cornerRadius = height / 2
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
    }
}
