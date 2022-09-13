//
//  AnswerChoiceView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class AnswerChoiceView: UIView {
    //TODO: make this a checkbox view
    let checkBoxView = UIView()
    let answerLabel = UILabel()
    
    init(answer: String) {
        super.init(frame: .zero)
        setCheckbox()
        setAnswerLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        checkBoxView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(answerLabel.snp.centerY)
            make.height.width.equalTo(30)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setCheckbox() {
        addSubview(checkBoxView)
    }
    
    private func setAnswerLabel() {
        answerLabel.numberOfLines = 0
        answerLabel.font = .systemFont(ofSize: 14, weight: .light)
        let coinbaseGray = UIColor(red: 135 / 255.0, green: 135 / 255.0, blue: 139 / 255.0, alpha: 1)
        answerLabel.textColor = coinbaseGray
        addSubview(answerLabel)
    }
}
