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
    
    private func setDescriptionView() {
        
        descriptionTextView.text = """

Everytime you make a payment towards one of your student loans, Debt Destroyed observes and awards you sweepstakes tickets. These sweepstake tickets are entered into our weekly raffle to win cash and prizes for your student loan.

You get tickets, just by paying your student loans like you normally do!

*Debt Destroyed never shares or sells your data. Connecting a student loan account merely allows Debt Destroyed to observe when you made a payment towards a student loan in order to award you tickets.

"""
        descriptionTextView.contentInsetAdjustmentBehavior = .automatic
        descriptionTextView.center = self.center
        descriptionTextView.textAlignment = NSTextAlignment.justified
        descriptionTextView.textColor = .black
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.font = UIFont.MontserratSemiBold(size: 16)
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
                configuration.attributedTitle = AttributedString("Connect Accounts ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
                connectAccBtn.configuration = configuration
                
            } else {
                connectAccBtn.configuration?.attributedTitle = AttributedString("Connect Accounts ➔", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.MontserratSemiBold(size: 18),NSAttributedString.Key.foregroundColor : UIColor.white]))
            }
            
        } else {
            connectAccBtn.setTitleColor(.white, for: .normal)
            connectAccBtn.setTitle("Connect Accounts ➔", for: .normal)
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
