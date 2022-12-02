//
//  QuizManagerView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 30/11/22.
//

import UIKit

class QuizManagerView: UIView {
    struct Constants {
        static let radiusForBtn = 100
    }
    private var stackView: UIStackView!
    let questionLabel = UILabel()
    let questionPromptBtn = UIButton()
    let revealAnswerBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpStackView()
        setquestionLabel()
        setQuestionPromptButton()
        setRevealAnsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        stackView = UIStackView()
        stackView.spacing = 35
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)

        }
    }

    private func setquestionLabel() {
        questionLabel.text = "Who was the biggest butt in hollywood?"
        questionLabel.font = UIFont.MontserratSemiBold(size: 20)
        questionLabel.numberOfLines = 0
        questionLabel.textColor = .black
        questionLabel.textAlignment = .center
        stackView.addArrangedSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func setRevealAnsButton() {
        let titletxt = "Reveal Answer"
        if titletxt != revealAnswerBtn.titleLabel?.text {
            if #available(iOS 15.0, *) {
                if self.revealAnswerBtn.configuration == nil {
                    var configuration = UIButton.Configuration.plain()
                    configuration.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.black]))
                    self.revealAnswerBtn.configuration = configuration
                    
                } else {
                    self.revealAnswerBtn.configuration?.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.black]))
                }
                
            } else {
                self.revealAnswerBtn.setTitleColor(.black, for: .normal)
                self.revealAnswerBtn.setTitle(titletxt, for: .normal)
            }
        }
        revealAnswerBtn.contentVerticalAlignment = .center
        revealAnswerBtn.layer.cornerRadius = CGFloat(Constants.radiusForBtn)
        revealAnswerBtn.clipsToBounds = true
        revealAnswerBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        revealAnswerBtn.backgroundColor = .red

        stackView.addArrangedSubview(revealAnswerBtn)
        revealAnswerBtn.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.radiusForBtn * 2).priority(.high)
            make.centerX.equalToSuperview()
        }
    }

    private func setQuestionPromptButton() {
        let titletxt = "Show Question Prompt"
        if titletxt != questionPromptBtn.titleLabel?.text {
            if #available(iOS 15.0, *) {
                if self.questionPromptBtn.configuration == nil {
                    var configuration = UIButton.Configuration.plain()
                    configuration.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.black]))
                    self.questionPromptBtn.configuration = configuration
                    
                } else {
                    self.questionPromptBtn.configuration?.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.black]))
                }
                
            } else {
                self.questionPromptBtn.setTitleColor(.black, for: .normal)
                self.questionPromptBtn.setTitle(titletxt, for: .normal)
            }
        }
        questionPromptBtn.contentVerticalAlignment = .center
        questionPromptBtn.layer.cornerRadius = CGFloat(Constants.radiusForBtn)
        questionPromptBtn.clipsToBounds = true
        questionPromptBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        questionPromptBtn.backgroundColor = .purple

        stackView.addArrangedSubview(questionPromptBtn)
        questionPromptBtn.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.radiusForBtn * 2)
            make.centerX.equalToSuperview()
        }
    }

    

}
