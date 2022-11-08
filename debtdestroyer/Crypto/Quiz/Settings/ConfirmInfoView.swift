//
//  ConfirmInfoView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 08/11/22.
//

import UIKit

class ConfirmInfoView: UIView {

    let titleLbl = UILabel()
    let nextBtn = SpinningWithGradButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleLabel()
        setNextBtn()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLbl.text = "Connect your student loan accounts to start earning tickets!"
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        titleLbl.textColor = .black
        titleLbl.font = UIFont.MontserratBold(size: 26)
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
        
    private func setNextBtn() {
        nextBtn.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            if nextBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Next ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                nextBtn.configuration = configuration
                
            } else {
                nextBtn.configuration?.attributedTitle = AttributedString("Next ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            nextBtn.setTitleColor(.white, for: .normal)
            nextBtn.setTitle("Next ➔", for: .normal)
        }
        let height: CGFloat = 55
        nextBtn.layer.cornerRadius = height/2
        nextBtn.layer.masksToBounds = true
        addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }
    
    
}
