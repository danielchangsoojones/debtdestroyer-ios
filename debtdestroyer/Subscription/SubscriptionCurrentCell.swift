//
//  SubscriptionCurrentCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 02/09/22.
//

import UIKit
import Reusable

class SubscriptionCurrentCell: UICollectionViewCell, Reusable{
    let background = UIView()
    let topBtn = UIButton()
    let ticketsTxt = UITextField()
    let emailNewsLetterTxt = UITextField()
    let loanConnectionsTxt = UITextField()
    let priceTxt = UITextField()
    private let line = UIView()
    private let line1 = UIView()
    private let line2 = UIView()
    private let line3 = UIView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackground() {
        background.backgroundColor = .systemGray5
        background.layer.cornerRadius = 8
        
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
        setTopBtn()
        setTicketsTxt()
        setLine()
        setEmailNewsLetterTxt()
        setLine1()
        setLoanConnectionsTxt()
        setLine2()
        setPriceTxt()
        setLine3()
    }

    func setPriceTxt() {
        priceTxt.text = "Free"
        priceTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        priceTxt.textColor = hexStringToUIColor(hex: "8A8A8A")
        priceTxt.textAlignment = .justified
        priceTxt.backgroundColor = .clear
        background.addSubview(priceTxt)
        priceTxt.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.equalToSuperview().inset(5)
            make.top.equalTo(loanConnectionsTxt.snp.bottom).offset(30)
        }
    }
        
    func setLoanConnectionsTxt() {
        loanConnectionsTxt.text = "1"
        loanConnectionsTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loanConnectionsTxt.textColor = hexStringToUIColor(hex: "8A8A8A")
        loanConnectionsTxt.textAlignment = .center
        loanConnectionsTxt.backgroundColor = .clear
        background.addSubview(loanConnectionsTxt)
        loanConnectionsTxt.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(emailNewsLetterTxt.snp.bottom).offset(30)
        }
    }
    
    func setEmailNewsLetterTxt() {
        emailNewsLetterTxt.text = ""
        emailNewsLetterTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        emailNewsLetterTxt.textColor = hexStringToUIColor(hex: "8A8A8A")
        emailNewsLetterTxt.textAlignment = .center
        emailNewsLetterTxt.backgroundColor = .clear
        background.addSubview(emailNewsLetterTxt)
        emailNewsLetterTxt.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(ticketsTxt.snp.bottom).offset(30)
        }
        
    }
    
    func setTopBtn() {
        topBtn.setTitle("Current", for: .normal)
        topBtn.layer.cornerRadius =  8
        topBtn.clipsToBounds = true
        topBtn.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        topBtn.isUserInteractionEnabled = false
        background.addSubview(topBtn)
        topBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(50)
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
    }
    
    func setTicketsTxt() {
        ticketsTxt.text = "1x"
        ticketsTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        ticketsTxt.textColor = hexStringToUIColor(hex: "8A8A8A")
        ticketsTxt.textAlignment = .center
        ticketsTxt.backgroundColor = .clear
        background.addSubview(ticketsTxt)
        ticketsTxt.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(topBtn.snp.bottom).offset(15)
        }
    }
    
    func setLine() {
        line.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(ticketsTxt.snp.bottom).offset(2)
        }
    }

    func setLine1() {
        line1.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line1)
        line1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(emailNewsLetterTxt.snp.bottom).offset(2)
        }
    }
    
    func setLine2() {
        line2.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line2)
        line2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(loanConnectionsTxt.snp.bottom).offset(2)
        }
    }
    
    func setLine3() {
        line3.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line3)
        line3.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(priceTxt.snp.bottom).inset(2)
        }
    }

}
