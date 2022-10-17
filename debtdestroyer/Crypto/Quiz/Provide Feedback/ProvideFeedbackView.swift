//
//  ProvideFeedbackView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit

class ProvideFeedbackView: UIView {
    private var stackView: UIStackView!
    var addTextField: UITextField!
    var descriptionLabel1: UILabel!
    var descriptionLabel2: UILabel!
    var nextQuizButton: UIButton!
    var feedbackButton: GradientBtn!
    private var stackViewForBtn: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        setUpStackView()
        setUpStackViewContent()
        addButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        stackView = UIStackView()
        stackView.spacing = 35
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.topMargin.equalToSuperview().offset(20)
        }
    }
    
    private func setUpStackViewContent() {
        if User.shouldShowEarnings {
            descriptionLabel1 = createLabel(title: "Your Nano will be sent within 24 hours. It takes us up to 24 hours since we have to manually send out the rewards currently.")
            descriptionLabel2 = createLabel(title: "Thanks for learning about Nano! Please come back tommorow for our next coin quiz about a new coin where you’ll earn airdrops for that coin!")
        }
    }
    
    private func addButtons() {
        
        stackViewForBtn = UIStackView()
        stackViewForBtn.spacing = 9
        stackViewForBtn.axis = .horizontal
        stackViewForBtn.distribution = .fillEqually
        stackViewForBtn.alignment = .center
        stackView.addArrangedSubview(stackViewForBtn)
        stackViewForBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        setNextQuizButton()
        setFeedbackButton()
    }
    
    func setFeedbackButton() {
        feedbackButton = GradientBtn()
        feedbackButton.setTitle("Provide Feedback", for: .normal)
        
        feedbackButton.layer.cornerRadius =  8
        feedbackButton.clipsToBounds = true
        feedbackButton.titleLabel?.adjustsFontSizeToFitWidth = true
        let horizontalInset: CGFloat = 5
        let verticalInset: CGFloat = 20
        feedbackButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        stackViewForBtn.addArrangedSubview(feedbackButton)
        feedbackButton.snp.makeConstraints{ make in
            make.height.equalTo(feedbackButton.snp.width).multipliedBy(0.34)
        }
    }
    
    func setNextQuizButton(){
        nextQuizButton = UIButton()
        nextQuizButton.titleLabel?.textColor = .fuchsiaPink
        nextQuizButton.setTitle("Start Next Quiz", for: .normal)
        nextQuizButton.layer.cornerRadius =  8
        nextQuizButton.backgroundColor = .clear
        nextQuizButton.clipsToBounds = true
        nextQuizButton.titleLabel?.adjustsFontSizeToFitWidth = true
        let horizontalInset: CGFloat = 5
        let verticalInset: CGFloat = 20
        nextQuizButton.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        stackViewForBtn.addArrangedSubview(nextQuizButton)
        nextQuizButton.snp.makeConstraints{ make in
            make.height.equalTo(nextQuizButton.snp.width).multipliedBy(0.34)
        }
    }
    
    private func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .jaguarBlack
        label.font = UIFont.MontserratMedium(size: 14)
        stackView.addArrangedSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
        }
        
        return label
    }
}
