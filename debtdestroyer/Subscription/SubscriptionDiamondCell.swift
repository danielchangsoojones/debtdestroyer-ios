//
//  SubscriptionDiamondCell.swift
//  debtdestroyer
//
//  Created by Rashmi Aher on 02/09/22.
//

import UIKit
import Reusable

class SubscriptionDiamondCell: UICollectionViewCell, Reusable{
    let background = UIView()
    let topBtn = GradientBtn()
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
        background.backgroundColor = .systemGray5
        background.layer.cornerRadius = 8
        
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
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
        priceLbl.text = "$5.99/month"
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
        loanConnectionsLbl.text = "unlimited"
        loanConnectionsLbl.adjustsFontSizeToFitWidth = true
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
        topBtn.setTitle("Diamond", for: .normal)
        topBtn.layer.cornerRadius =  8
        topBtn.clipsToBounds = true
        topBtn.backgroundColor = .clear
        topBtn.isUserInteractionEnabled = false
        background.addSubview(topBtn)
        topBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(50)
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
    }

    
    func setTicketsLbl() {
        ticketsLbl.text = "10x"
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
        line.backgroundColor = hexStringToUIColor(hex: "FF7021")
        background.addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(ticketsLbl.snp.bottom).offset(2)
        }
    }
    
    func setLine1() {
        line1.backgroundColor = hexStringToUIColor(hex: "FF7021")
        background.addSubview(line1)
        line1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(emailNewsLetterLbl.snp.bottom).offset(2)
        }
    }
    
    func setLine2() {
        line2.backgroundColor = hexStringToUIColor(hex: "FF7021")
        background.addSubview(line2)
        line2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(loanConnectionsLbl.snp.bottom).offset(2)
        }
    }
    
    func setLine3() {
        line3.backgroundColor = hexStringToUIColor(hex: "FF7021")
        background.addSubview(line3)
        line3.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(priceLbl.snp.bottom).inset(2)
        }
    }

    
}
