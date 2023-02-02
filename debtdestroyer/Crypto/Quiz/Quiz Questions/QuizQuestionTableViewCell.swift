//
//  QuizQuestionTableViewCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 31/01/23.
//

import UIKit
import Reusable

class QuizQuestionTableViewCell: UITableViewCell, Reusable {
    
    let questionLabel = UILabel()
    let answersLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
  
        setQuestionLabel()
        setAnswersLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setQuestionLabel() {
        questionLabel.font = UIFont.MontserratMedium(size: 18)
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byCharWrapping
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setAnswersLabel() {
        answersLabel.font = UIFont.MontserratRegular(size: 15)
        answersLabel.textColor = .gray
        answersLabel.numberOfLines = 0
        addSubview(answersLabel)
        answersLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
  
}

