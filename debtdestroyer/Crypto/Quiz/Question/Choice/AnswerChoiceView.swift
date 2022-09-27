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
        setAnswerLabel()
        setCheckbox()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        checkBoxView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(50)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setCheckbox() {
        checkBoxView.boxType = .square
        checkBoxView.tintColor = .white
        checkBoxView.lineWidth = 4
        checkBoxView.onTintColor = .clear
        checkBoxView.onCheckColor = .white
        addSubview(checkBoxView)
    }
    
    private func setAnswerLabel() {
        answerLabel.numberOfLines = 0
        answerLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        answerLabel.textAlignment = .center
        deselect()
        addSubview(answerLabel)
    }
    
    func deselect() {
        answerLabel.textColor = .coinbaseBlue
        self.backgroundColor = .white
        checkBoxView.tintColor = .white
        checkBoxView.on = false
    }
    
    func select() {
        answerLabel.textColor = .white
        self.backgroundColor = .green
        checkBoxView.tintColor = .green
    }
}
