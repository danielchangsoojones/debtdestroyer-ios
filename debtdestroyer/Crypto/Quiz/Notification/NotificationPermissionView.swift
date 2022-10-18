//
//  NotificationPermissionView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 07/10/22.
//

import UIKit

class NotificationPermissionView: UIView {
    let imgView = UIImageView()
    let descriptionLabel = UILabel()
    let titleLabel = UILabel()
    private let leadingOffset: CGFloat = 20
    let allowBtn = SpinningWithGradButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setImgView()
        setAllowNotificationButton()
        setTitleLabel()
        setDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImgView() {
        imgView.image = UIImage.init(named: "notification")
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 150 / 2
        imgView.backgroundColor = .systemGray6
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.height.width.equalTo(150)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Keep me posted"
        titleLabel.font = UIFont.MontserratBold(size: 20)
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(leadingOffset)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.text = "Get notified every day a new quiz comes out."
        descriptionLabel.font = UIFont.MontserratRegular(size: 14)
        descriptionLabel.textColor = .black
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(leadingOffset)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
    
    private func setAllowNotificationButton() {
        if #available(iOS 15.0, *) {
            if allowBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("I WANT TO BE NOTIFIED", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
                allowBtn.configuration = configuration
                
            } else {
                allowBtn.configuration?.attributedTitle = AttributedString("I WANT TO BE NOTIFIED", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 22),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            allowBtn.setTitleColor(.white, for: .normal)
            allowBtn.titleLabel?.font = UIFont.MontserratSemiBold(size: 22)
            allowBtn.setTitle("I WANT TO BE NOTIFIED", for: .normal)
        }
        
        allowBtn.backgroundColor = .clear
        let height: CGFloat = 55
        allowBtn.layer.cornerRadius = height / 2
        allowBtn.layer.masksToBounds = true
        addSubview(allowBtn)
        allowBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }
}
