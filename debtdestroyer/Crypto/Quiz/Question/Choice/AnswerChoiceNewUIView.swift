//
//  AnswerChoiceNewUIView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 28/09/22.
//

import UIKit

class AnswerChoiceNewUIView: UIView {
    let gifImgView = UIImageView()
    let answerLabel = UILabel()
    var isChosen = false

    init(answer: String) {
        super.init(frame: .zero)
        setAnswerLabel()
        setGifImage()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        gifImgView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setGifImage() {
        gifImgView.backgroundColor = .clear
        addSubview(gifImgView)
    }
    
    private func setAnswerLabel() {
        answerLabel.numberOfLines = 0
        answerLabel.font = .MontserratBold(size: 18)
        answerLabel.textAlignment = .center
        deselect()
        addSubview(answerLabel)
    }
    
    func deselect() {
        isChosen = false
        answerLabel.textColor = .black
        self.backgroundColor = .systemGray6
    }
    
    func select() {
        isChosen = true
        answerLabel.textColor = .black
        setGradientBackground(color1: hexStringToUIColor(hex: "BE62F6"), color2: hexStringToUIColor(hex: "A324EA"),radi: 25)
    }
}
