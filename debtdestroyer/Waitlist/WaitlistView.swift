//
//  WaitlistView.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 1/13/23.
//

import Foundation
import UIKit

class WaitlistView: UIView {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    private let clockImageView = UIImageView()
    let contactUsBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitle()
        setSubtitle()
        setClockImageView()
        setContactUsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.MontserratBold(size: 20)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(-40)
        }
    }
    
    private func setSubtitle() {
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.MontserratRegular(size: 18)
        subtitleLabel.textAlignment = .center
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
    
    private func setClockImageView() {
        clockImageView.image = UIImage.init(named: "Clock")
        clockImageView.contentMode = .scaleAspectFill
        addSubview(clockImageView)
        clockImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200).priority(.high)
            make.bottom.equalTo(titleLabel.snp.bottom).offset(-50)
        }
    }
    
    private func setContactUsButton() {
        let titletxt = "Contact Us"
        if titletxt != contactUsBtn.titleLabel?.text {
            if #available(iOS 15.0, *) {
                if self.contactUsBtn.configuration == nil {
                    var configuration = UIButton.Configuration.plain()
                    configuration.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                    self.contactUsBtn.configuration = configuration
                    
                } else {
                    self.contactUsBtn.configuration?.attributedTitle = AttributedString(titletxt, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                }
                
            } else {
                self.contactUsBtn.setTitleColor(.black, for: .normal)
                self.contactUsBtn.setTitle(titletxt, for: .normal)
            }
        }
        contactUsBtn.contentVerticalAlignment = .center
        contactUsBtn.titleLabel?.lineBreakMode = .byWordWrapping
        contactUsBtn.titleLabel?.textAlignment = .center
        contactUsBtn.layer.cornerRadius = CGFloat(60)
        contactUsBtn.clipsToBounds = true
        contactUsBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        contactUsBtn.backgroundColor = .black
        
        addSubview(contactUsBtn)
        contactUsBtn.snp.makeConstraints { make in
            make.height.width.equalTo(120).priority(.high)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(35)
        }
    }

}
