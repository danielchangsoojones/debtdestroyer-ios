//
//  StartQuizView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 14/09/22.
//

import UIKit

class StartQuizView: UIView {
    let backgroudImgView = UIImageView()
    let descriptionLabel = UILabel()
    let nameLabel = UILabel()
    private let leadingOffset: CGFloat = 20
    let nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setbackgroudImgView()
        setNextButton()
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
    
    private func setDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        descriptionLabel.textColor = .white
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
            make.leading.equalToSuperview().inset(leadingOffset)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
    
    private func setNextButton() {
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        nextButton.setTitle("Start Quiz", for: .normal)
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
