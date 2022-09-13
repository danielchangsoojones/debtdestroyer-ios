//
//  QuizView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/13/22.
//

import UIKit

class QuizView: UIView {
    let iconImgView = UIImageView()
    let descriptionLabel = UILabel()
    private let leadingOffset: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setIconImgView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setIconImgView() {
        addSubview(iconImgView)
        iconImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leadingOffset)
            make.height.width.equalTo(50)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImgView)
            make.trailing.equalTo(leadingOffset)
        }
    }
}
