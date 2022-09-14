//
//  AnswerChoiceView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit
import BEMCheckBox

class AnswerChoiceView: UIView {
    //TODO: make this a checkbox view
    let checkBoxView = BEMCheckBox()
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
        checkBoxView.boxType = .circle
        checkBoxView.tintColor = .white.withAlphaComponent(0.7)
        let coinbaseBlue = UIColor(red: 64 / 255.0, green: 124 / 255.0, blue: 232 / 255.0, alpha: 1)
        checkBoxView.onFillColor = coinbaseBlue
        checkBoxView.onCheckColor = .white
        addSubview(checkBoxView)
    }
    
    private func setAnswerLabel() {
        answerLabel.numberOfLines = 0
        answerLabel.font = .systemFont(ofSize: 16)
        deselect()
        addSubview(answerLabel)
    }
    
    func deselect() {
        answerLabel.textColor = .white.withAlphaComponent(0.6)
    }
    
    func select() {
        answerLabel.textColor = .white
    }
}
