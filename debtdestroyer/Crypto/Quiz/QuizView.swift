//
//  QuizView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class QuizView: UIView {
    let containerView = UIView()
    let iconImgView = UIImageView()
    let descriptionLabel = UILabel()
    private let leadingOffset: CGFloat = 10
    let tickerLabel = UILabel()
    let explainerImgView = UIImageView()
    let nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNextButton()
        setContentContainer()
        setIconImgView()
        setTickerSymbol()
        setDescriptionLabel()
        setExplainerImgView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentContainer() {
        containerView.backgroundColor = .white
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(3)
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
    }
    
    private func setIconImgView() {
        iconImgView.contentMode = .scaleAspectFit
        containerView.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leadingOffset)
            make.height.width.equalTo(50)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    private func setTickerSymbol() {
        let coinbaseGray = UIColor(red: 240 / 255.0, green: 242 / 255.0, blue: 247 / 255.0, alpha: 1)
        tickerLabel.backgroundColor = coinbaseGray
        let height: CGFloat = 50
        tickerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        tickerLabel.layer.cornerRadius = height / 2
        containerView.addSubview(tickerLabel)
        tickerLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImgView.snp.trailing).offset(5)
            make.centerY.equalTo(iconImgView)
            make.width.equalTo(70)
            make.height.equalTo(height)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionLabel.numberOfLines = 0
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImgView)
            make.trailing.equalTo(leadingOffset)
        }
    }
    
    private func setExplainerImgView() {
        explainerImgView.contentMode = .scaleAspectFit
        containerView.addSubview(explainerImgView)
        explainerImgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
        }
    }
    
    private func setNextButton() {
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(35)
        }
    }
}
