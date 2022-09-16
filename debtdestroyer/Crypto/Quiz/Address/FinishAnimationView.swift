//
//  FinishAnimationView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 15/09/22.
//

import UIKit

class FinishAnimationView: UIView {
    var imgView = UIImageView()
    var circularView = CircularProgressView()
    var earnedLabel = UILabel()
    var nextButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setUpProgressView()
        setUpImageView()
        setEarnedLabel()
        setNextButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpProgressView() {
        addSubview(circularView)
        circularView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setUpImageView() {
        imgView.image = UIImage.init(named: "checkmark")
        imgView.backgroundColor = .white
        let dimenssion = 35
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(dimenssion)
            make.centerY.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setEarnedLabel() {
        earnedLabel.text = "You just earned 2 Nano!"
        earnedLabel.numberOfLines = 0
        earnedLabel.textAlignment = .center
        earnedLabel.textColor = .white
        earnedLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addSubview(earnedLabel)
        // lable constraints not getting set proprerly. Pending
        earnedLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.center).offset(100)
        }
    }

    private func setNextButton() {
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        nextButton.setTitle("Next Quiz", for: .normal)
        let height: CGFloat = 55
        nextButton.layer.cornerRadius = height / 2
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(height)
        }
    }
}
