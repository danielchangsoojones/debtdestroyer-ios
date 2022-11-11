//
//  ConnectDisclosureView.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 08/11/22.
//

import UIKit

class ConnectDisclosureView: UIView {
    let titleLbl = UILabel()
    let descriptionTextView = UITextView()
    let connectAccBtn = SpinningWithGradButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleLabel()
        setDescriptionView()
        setConnectAccBtn()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLbl.text = "Verify your student loan accounts to start earning tickets!"
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
    
    private func setDescriptionView() {
        descriptionTextView.text = "Confirm your identity by answering some security questions. Once your identity is verified, your student loan accounts will start earning you tickets into our sweepstakes!\n\n*Debt Destroyed never shares or sells your data."
        descriptionTextView.contentInsetAdjustmentBehavior = .automatic
        descriptionTextView.center = self.center
        descriptionTextView.textAlignment = NSTextAlignment.center
        descriptionTextView.textColor = .black
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.font = UIFont.MontserratRegular(size: 14)
        descriptionTextView.isSelectable = false
        descriptionTextView.isEditable = false
        addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func setConnectAccBtn() {
        connectAccBtn.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            if connectAccBtn.configuration == nil {
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString("Verify Student Loans ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                connectAccBtn.configuration = configuration
                
            } else {
                connectAccBtn.configuration?.attributedTitle = AttributedString("Verify Student Loans ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            connectAccBtn.setTitleColor(.white, for: .normal)
            connectAccBtn.setTitle("Verify Student Loans ➔", for: .normal)
        }
        let height: CGFloat = 55
        connectAccBtn.layer.cornerRadius = height/2
        connectAccBtn.layer.masksToBounds = true
        addSubview(connectAccBtn)
        connectAccBtn.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(20)
            make.height.equalTo(height)
        }
    }

    
}
