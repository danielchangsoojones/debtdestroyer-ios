//
//  StartQuizNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 29/09/22.
//

import UIKit

class StartQuizView: UIView {
    let backgroudImgView = UIImageView()
    let logoImgView = UIImageView()
    let descriptionLabel = UILabel()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    private let leadingOffset: CGFloat = 20
    let nextButton = SpinningWithGradButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setbackgroudImgView()
        setLogoImgView()
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
            make.leading.trailing.equalToSuperview()
            make.bottomMargin.equalToSuperview()
            make.topMargin.equalToSuperview()
        }
    }
    
    private func setLogoImgView() {
        logoImgView.image = UIImage.init(named: "drop")
        logoImgView.contentMode = .scaleAspectFill
        addSubview(logoImgView)
        logoImgView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(10)
            make.height.width.equalTo(18)
            
        }
    }
 
    private func setNameLabel() {
        nameLabel.text = Helpers.getAppDisplayNameStr()
        nameLabel.font = UIFont.MontserratRegular(size: 14)
        nameLabel.textColor = .black
        nameLabel.backgroundColor = .clear
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImgView)
            make.leading.equalTo(logoImgView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setTitleLabel() {
        titleLabel.font = UIFont.MontserratBold(size: 20)
        titleLabel.textColor = .black
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
        descriptionLabel.font = UIFont.MontserratRegular(size: 14)
        descriptionLabel.textColor = .black
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
        nextButton.backgroundColor = .clear
        let height: CGFloat = 55
        nextButton.layer.cornerRadius = height / 2
        nextButton.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            if nextButton.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Start Trivia", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
                nextButton.configuration = configuration
                
            } else {
                nextButton.configuration?.attributedTitle = AttributedString("Start Trivia", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
         
        } else {
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.setTitle("Start Trivia", for: .normal)
        }
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }
}
