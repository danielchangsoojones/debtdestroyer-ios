//
//  StartQuizNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class StartQuizNewUIView: UIView {
    let backgroudImgView = UIImageView()
    let descriptionLabel = UILabel()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    private let leadingOffset: CGFloat = 20
    let nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setbackgroudImgView()
        setNextButton()
        setNameLabel()
        setTitleLabel()
        setDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setbackgroudImgView() {
        backgroudImgView.contentMode = .scaleAspectFill
        addSubview(backgroudImgView)
        backgroudImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
 
    private func setNameLabel() {
        nameLabel.text = "LavaDrop"
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.textColor = .white
        nameLabel.backgroundColor = .clear
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(leadingOffset)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Ready to get more from your money?"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(leadingOffset)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.text = "Welcome to LavaDrop. One app to manage all things money. Join a global community of 10 millions who spend, save, invest through us."
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(leadingOffset)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
    
    private func setNextButton() {
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        nextButton.setTitle("Start Trivia", for: .normal)
        let height: CGFloat = 55
        nextButton.layer.cornerRadius = height / 2
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }
}
