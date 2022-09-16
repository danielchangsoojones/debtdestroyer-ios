//
//  SubscriptionCurrentCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 02/09/22.
//

import UIKit

class SubscriptionCurrentView: UIView {
    let background = UIView()
    let topBtn = UIButton()
    let ticketsLbl = UILabel()
    let emailNewsLetterLbl = UILabel()
    let loanConnectionsLbl = UILabel()
    let priceLbl = UILabel()
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
        background.layer.cornerRadius = 8
        background.layer.borderWidth = 0.5
        background.layer.borderColor = hexStringToUIColor(hex: "8A8A8A").cgColor
        addSubview(background)
        background.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        setTopBtn()
        setTicketsLbl()
        setLine()
        setEmailNewsLetterLbl()
        setLine1()
        setLoanConnectionsLbl()
        setLine2()
        setPriceLbl()
        setLine3()
    }

    func setPriceLbl() {
        priceLbl.text = "Free"
        priceLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        priceLbl.textColor = hexStringToUIColor(hex: "8A8A8A")
        priceLbl.textAlignment = .center
        priceLbl.backgroundColor = .clear
        background.addSubview(priceLbl)
        priceLbl.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(loanConnectionsLbl.snp.bottom).offset(30)
        }
    }
        
    func setLoanConnectionsLbl() {
        loanConnectionsLbl.text = "1"
        loanConnectionsLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loanConnectionsLbl.textColor = hexStringToUIColor(hex: "8A8A8A")
        loanConnectionsLbl.textAlignment = .center
        loanConnectionsLbl.backgroundColor = .clear
        background.addSubview(loanConnectionsLbl)
        loanConnectionsLbl.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(emailNewsLetterLbl.snp.bottom).offset(30)
        }
    }
    
    func setEmailNewsLetterLbl() {
        emailNewsLetterLbl.text = ""
        emailNewsLetterLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        emailNewsLetterLbl.textColor = hexStringToUIColor(hex: "8A8A8A")
        emailNewsLetterLbl.textAlignment = .center
        emailNewsLetterLbl.backgroundColor = .clear
        background.addSubview(emailNewsLetterLbl)
        emailNewsLetterLbl.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(ticketsLbl.snp.bottom).offset(30)
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
            make.top.equalToSuperview().inset(15)
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
    }
    
    func setTicketsLbl() {
        ticketsLbl.text = "1x"
        ticketsLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        ticketsLbl.textColor = hexStringToUIColor(hex: "8A8A8A")
        ticketsLbl.textAlignment = .center
        ticketsLbl.backgroundColor = .clear
        background.addSubview(ticketsLbl)
        ticketsLbl.snp.makeConstraints { make in
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
            make.top.equalTo(ticketsLbl.snp.bottom).offset(2)
        }
    }

    func setLine1() {
        line1.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line1)
        line1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(emailNewsLetterLbl.snp.bottom).offset(2)
        }
    }
    
    func setLine2() {
        line2.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line2)
        line2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(loanConnectionsLbl.snp.bottom).offset(2)
        }
    }
    
    func setLine3() {
        line3.backgroundColor = hexStringToUIColor(hex: "8A8A8A")
        background.addSubview(line3)
        line3.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(priceLbl.snp.bottom).inset(2)
        }
    }

}